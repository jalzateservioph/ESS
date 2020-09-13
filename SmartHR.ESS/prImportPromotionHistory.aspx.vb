Imports System.IO
Imports System.Data.OleDb
Imports PromotionModule
Public Class prPromotionHistoryMigrator
    Inherits System.Web.UI.Page
    Public servertemp As String = Environment.GetFolderPath(Environment.SpecialFolder.CommonDocuments)
    Public pathfile As String
    Public constring As String
    Public InvalidRows As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


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
    Protected Sub tabpage_ActiveTabChanged(source As Object, e As DevExpress.Web.ASPxTabControl.TabControlEventArgs) Handles tabpage.ActiveTabChanged
        If (tabpage.ActiveTabIndex = 0) Then
            Server.Transfer("prFileImporter.aspx", True)
        ElseIf tabpage.ActiveTabIndex = 2 Then
            Server.Transfer("prImportInfractions.aspx", True)
        ElseIf tabpage.ActiveTabIndex = 3 Then
            Server.Transfer("prReports.aspx", True)
        End If
    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        If uc.HasFile Then
            lblFileNamePA.Text = "File Uploaded: " + uc.FileName
            Dim ifExist As Boolean = Directory.Exists(servertemp + "\TMP_TEMPREPOSITORY")
            If (ifExist = False) Then
                Directory.CreateDirectory(servertemp + "\TMP_TEMPREPOSITORY")
            End If
            pathfile = String.Concat(servertemp + "\TMP_TEMPREPOSITORY\" + uc.FileName)

            Session("excelPathFile") = pathfile
            Try
                If File.Exists(pathfile) Then
                    File.Delete(pathfile)
                End If
                uc.SaveAs(pathfile)
                getSheet(pathfile, cbSheet)
                If (cbSheet.Items.Count > 0) Then
                    If InvalidRows > 0 Then
                        displayMessage("File included blank employee codes. Process terminated.")
                        scenario1()
                    Else
                        scenario2()
                        cbSheet.SelectedIndex = 0
                        displayMessage(uc.FileName.ToString() + " Uploaded.")
                        cbSheet.SelectedIndex = -1
                    End If
                ElseIf uc.FileName.EndsWith(".xlsx") Or uc.FileName.EndsWith(".xls") Then
                    displayMessage("No valid Sheets for Promotion History")
                    scenario1()
                Else
                    displayMessage("Invalid File. Choose a valid file.")
                    scenario1()
                End If
            Catch exception As Exception
            End Try
        Else
            displayMessage("No selected File")

        End If
    End Sub
    Sub getSheet(ByVal pathfile As String, ByRef ddl As DevExpress.Web.ASPxEditors.ASPxComboBox)
        'this will get the sheets' name from excel file
        Dim im As New excelImporter
        Try
            InvalidRows = 0
            constring = "provider=Microsoft.Ace.OLEDB.12.0;Data Source=" + pathfile + ";Extended Properties=""Excel 12.0;IMEX=1;"""
            
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

                    Dim xCommand As OleDbCommand = connExcel.CreateCommand
                    Dim xReader As OleDbDataReader
                    xCommand.CommandText = "SELECT * FROM [" + drSheet("TABLE_NAME").ToString() + "] WHERE [Employee Number] = '' OR [Employee Number] IS NULL"
                    xReader = xCommand.ExecuteReader

                    While xReader.Read()
                        InvalidRows = InvalidRows + 1
                    End While
                Next
                For Each sheet As String In listSheet
                    If (im.isValidSheetForPH(constring, sheet) = True) Then
                        ddl.Items.Add(sheet)
                    End If
                Next
                connExcel.Close()
            End Using
        Catch ex As Exception
            ddl.Items.Clear()
        End Try
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        scenario1()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim ei As New excelImporter()
        Dim dt As DataTable = Session("dataPA")
        If ((ei.prInsertPromotionHistory(Session("dataPA"), SQLString())) = 0) Then
            ' txtMessage.Value += "Successfully Updated"
            displayMessage("Successfully updated. Please choose another sheet that you want to update. If you're already done, click back.")
        Else
            'txtMessage.Value += "Procedure Not Found. Please Update Database First
            displayMessage("Procedure Not Found. Please Update Database First")
        End If
    End Sub

    Protected Sub grid_BeforeGetCallbackResult(sender As Object, e As EventArgs) Handles grid.BeforeGetCallbackResult
        grid.DataSource = Session("dataPA")
        grid.DataBind()
    End Sub
    Sub displayMessage(ByVal text As String)
        popuplabel.Text = text
        popup.EnableAnimation = True
        popup.CloseAction = DevExpress.Web.ASPxClasses.CloseAction.CloseButton
        popup.PopupHorizontalAlign = DevExpress.Web.ASPxClasses.PopupHorizontalAlign.WindowCenter
        popup.PopupVerticalAlign = DevExpress.Web.ASPxClasses.PopupVerticalAlign.WindowCenter
        popup.ShowOnPageLoad = True
    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        popup.ShowOnPageLoad = False
    End Sub

    Protected Sub cbSheet_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbSheet.SelectedIndexChanged
        Dim pm As New excelImporter
        Dim str As String = pm.toTemporaryTablePH(SQLString(), Session("excelPathFile"), Session("ExcelConnection"), cbSheet.SelectedItem.ToString())
        Dim xTable As DataTable = GetSQLDT("SELECT [EMPLOYEE NUMBER] AS [EmployeeCode] FROM [prViewNewDataPH] WHERE [EMPLOYEE NUMBER] NOT IN (SELECT EmployeeNum FROM Personnel)")
        If xTable.Rows.Count = 0 Then
            Session("dataPA") = GetSQLDT("select * from [prViewNewDataPH]")
            Dim dt As DataTable = Session("dataPA")
            grid.DataSource = Session("dataPA")
            grid.DataBind()
            If dt.Rows.Count = 0 And str.ToLower = "true" Then
                displayMessage("Sheet already updated.")
                scenario2()
            ElseIf dt.Rows.Count = 0 And str.ToLower = "false" Then
                displayMessage("Sheet contains invalid data.")
                scenario2()
            Else
                scenario3()
            End If
        Else
            Dim InvalidRecords As String = ""

            For Each xRow As DataRow In xTable.Rows
                InvalidRecords += xRow("EmployeeCode") + " "
            Next xRow

            displayMessage("Invalid Employee Codes : " + InvalidRecords)
        End If
    End Sub

    Protected Sub btnDownloadTemplate_Click(sender As Object, e As EventArgs) Handles btnDownloadTemplate.Click
        Response.ClearContent()
        Response.Clear()
        Response.ContentType = "text/plain"
        Response.AddHeader("Content-Disposition",
                           "attachment; filename=Promotion History Template.xlsx;")
        Response.TransmitFile(Server.MapPath("downloads\Promotion History Template.xlsx"))
        Response.Flush()
        Response.End()
    End Sub


End Class