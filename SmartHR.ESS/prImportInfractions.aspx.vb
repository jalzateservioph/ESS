Imports System.IO
Imports PromotionModule
Imports System.Data.OleDb

Public Class prImportInfractions
    Inherits System.Web.UI.Page
    Public servertemp As String = Environment.GetFolderPath(Environment.SpecialFolder.CommonDocuments)
    Public pathfile As String
    Public constring As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
#Region "design Purposes Only"
    Protected Sub tabMenu_ActiveTabChanged(source As Object, e As DevExpress.Web.ASPxTabControl.TabControlEventArgs) Handles tabMenu.ActiveTabChanged
        If (tabMenu.ActiveTabIndex = 1) Then
            Server.Transfer("prImportPromotionHistory.aspx", True)
        ElseIf tabMenu.ActiveTabIndex = 0 Then
            Server.Transfer("prFileImporter.aspx", True)
        ElseIf tabMenu.ActiveTabIndex = 3 Then
            Server.Transfer("prReports.aspx", True)
        End If
    End Sub
    Sub scenario1()
        Layer1.Visible = True
        layer2.Visible = False
        layer3.Visible = False
        basePanel.HeaderText = "Select Excel files to be uploaded."
    End Sub
    Sub scenario2()
        Layer1.Visible = False
        layer2.Visible = True
        layer3.Visible = False
        basePanel.HeaderText = "Select Sheet to view contents."
    End Sub
    Sub scenario3()

        Layer1.Visible = False
        layer2.Visible = True
        layer3.Visible = True
    End Sub
    Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        scenario1()
    End Sub
    Sub displayMessage(ByVal text As String)
        popuplabel.Text = Text
        popup.EnableAnimation = True
        popup.CloseAction = DevExpress.Web.ASPxClasses.CloseAction.CloseButton
        popup.PopupHorizontalAlign = DevExpress.Web.ASPxClasses.PopupHorizontalAlign.WindowCenter
        popup.PopupVerticalAlign = DevExpress.Web.ASPxClasses.PopupVerticalAlign.WindowCenter
        popup.ShowOnPageLoad = True
    End Sub
#End Region
#Region "shared functions"
    Sub getSheet(ByVal pathfile As String, ByRef ddl As DevExpress.Web.ASPxEditors.ASPxComboBox, ByVal ColumnFinder As String)
        'this will get the sheets' name from excel file
        Dim im As New excelImporter
        Try
            constring = "provider=Microsoft.Ace.OLEDB.12.0;Data Source=" + pathfile + ";Extended Properties = Excel 12.0;"
            Session("ExcelConnection") = constring

            Dim connExcel As New OleDbConnection(constring)
            Using connExcel
                connExcel.Open()
                Dim dtSheets As DataTable = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
                ddl.Items.Clear()
                Dim listSheet As New List(Of String)
                Dim drSheet As DataRow
                For Each drSheet In dtSheets.Rows
                    listSheet.Add(drSheet("TABLE_NAME").ToString())
                Next
                For Each sheet As String In listSheet
                    If (im.isValidSheet(constring, sheet, ColumnFinder) = True) Then
                        ddl.Items.Add(sheet)
                    End If
                Next
                connExcel.Close()
            End Using
        Catch ex As Exception
            ddl.Items.Clear()
            displayMessage(ex.Message)
        End Try
    End Sub
#End Region

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        If uc.UploadedFiles(0).ContentLength And _
            (uc.UploadedFiles(0).FileName.EndsWith(".xlsx") Or uc.UploadedFiles(0).FileName.EndsWith(".xls")) Then
            lblFileNamePA.Text = "File Uploaded: " + uc.UploadedFiles(0).FileName
            Dim ifExist As Boolean = Directory.Exists(servertemp + "\TMP_TEMPREPOSITORY")
            If (ifExist = False) Then
                Directory.CreateDirectory(servertemp + "\TMP_TEMPREPOSITORY")
            End If
            pathfile = String.Concat(servertemp + "\TMP_TEMPREPOSITORY\" + uc.UploadedFiles(0).FileName)
            Session("excelPathFile") = pathfile
            Try

                If File.Exists(pathfile) Then
                    File.Delete(pathfile)
                End If
                uc.UploadedFiles(0).SaveAs(pathfile)
                getSheet(pathfile, cbSheet, "MANNO")
                If (cbSheet.Items.Count > 0) Then
                    scenario2()
                    cbSheet.SelectedIndex = 0
                    displayMessage(uc.UploadedFiles(0).FileName.ToString() + " Uploaded.")
                    cbSheet.SelectedIndex = -1
                Else
                    displayMessage("No Valid Sheets For Ability or Attendance")
                    scenario1()
                End If
            Catch ex As Exception

            End Try
        Else
            displayMessage("Invalid File or No File Selected. Choose a valid file.")
            scenario1()
        End If
    End Sub

    Protected Sub cbSheet_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbSheet.SelectedIndexChanged
        Dim pm As New excelImporter
        lblMessage.Text = pm.toTemporaryTablePA(SQLString(), Session("excelPathFile"), Session("ExcelConnection"), cbSheet.SelectedItem.ToString())
        Session("dataPA") = GetSQLDT("select * from prViewNewData")
        Dim dt As DataTable = Session("dataPA")
        grid.DataSource = Session("dataPA")
        grid.DataBind()
        If dt.Rows.Count = 0 And lblMessage.Text.ToLower = "true" Then
            displayMessage("Sheet already updated.")
            scenario2()
        ElseIf dt.Rows.Count = 0 And lblMessage.Text.ToLower = "false" Then
            displayMessage("Sheet contains invalid data.")
            scenario2()
        Else
            scenario3()
        End If
    End Sub

    Protected Sub grid_BeforeGetCallbackResult(sender As Object, e As EventArgs) Handles grid.BeforeGetCallbackResult
        grid.DataSource = Session("dataPA")
        grid.DataBind()
    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        popup.ShowOnPageLoad = False
    End Sub
End Class