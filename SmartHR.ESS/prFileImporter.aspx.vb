Imports System.IO
Imports System.Data.OleDb
Imports PromotionModule
Imports DevExpress.XtraEditors.Controls
Imports DevExpress.Web.ASPxGridView
Imports Microsoft.Reporting.WebForms
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraEditors
Imports DevExpress.XtraReports.UI
Imports DevExpress.XtraReports.Web

Public Class prFileImporter
    Inherits System.Web.UI.Page
    Public servertemp As String = Environment.GetFolderPath(Environment.SpecialFolder.CommonDocuments)
    Public pathfile As String
    Public constring As String
    Public InvalidRows As Integer
    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadData()
    End Sub
#Region "design Purposes Only"
    
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

                    Dim xCommand As OleDbCommand = connExcel.CreateCommand
                    Dim xReader As OleDbDataReader
                    xCommand.CommandText = "SELECT * FROM [" + drSheet("TABLE_NAME").ToString() + "] WHERE [MANNO] = '' OR [MANNO] IS NULL"
                    xReader = xCommand.ExecuteReader

                    While xReader.Read()
                        InvalidRows = InvalidRows + 1
                    End While
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
            WriteEventLog(ex.ToString())
            displayMessage(ex.Message)
        End Try
    End Sub
#End Region
#Region "PROMOTIONS AND ABILITY"
    'upload
    Protected Sub btnUploadPA_Click(sender As Object, e As EventArgs) Handles btnUploadPA.Click
        If ucPerformanceAbility.HasFile Then
            lblFileNamePA.Text = "File Uploaded: " + ucPerformanceAbility.PostedFile.FileName
            Dim ifExist As Boolean = Directory.Exists(servertemp + "\TMP_TEMPREPOSITORY")
            If (ifExist = False) Then
                Directory.CreateDirectory(servertemp + "\TMP_TEMPREPOSITORY")
            End If
            pathfile = String.Concat(servertemp + "\TMP_TEMPREPOSITORY\" + ucPerformanceAbility.FileName)

            Session("excelPathFile") = pathfile
            Try

                If File.Exists(pathfile) Then
                    File.Delete(pathfile)
                End If
                ucPerformanceAbility.SaveAs(pathfile)
                getSheet(pathfile, cbSheetPA, "MANNO")
                If (cbSheetPA.Items.Count > 0) Then
                    If InvalidRows > 0 Then
                        displayMessage("File included blank employee codes. Process terminated.")
                        scenario1()
                    Else
                        scenario2()
                        cbSheetPA.SelectedIndex = 0
                        displayMessage(ucPerformanceAbility.FileName.ToString() + " Uploaded.")
                        cbSheetPA.SelectedIndex = -1
                    End If
                ElseIf ucPerformanceAbility.FileName.EndsWith(".xlsx") Or ucPerformanceAbility.FileName.EndsWith(".xls") Then
                    displayMessage("No Valid Sheets For Ability or Attendance")
                    scenario1()
                Else
                    displayMessage("Invalid File. Choose a valid file.")
                    scenario1()
                End If
            Catch ex As Exception
                WriteEventLog(ex.Message)
                Console.WriteLine(ex.Message)
            End Try
        Else
            displayMessage("No file selected")
            scenario1()
        End If
    End Sub
    'back
    Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        scenario1()
    End Sub

    Sub displayMessage(ByVal text As String)

        popuplabel.Text = text
        popup.EnableAnimation = True
        popup.CloseAction = DevExpress.Web.ASPxClasses.CloseAction.CloseButton
        popup.PopupHorizontalAlign = DevExpress.Web.ASPxClasses.PopupHorizontalAlign.WindowCenter
        popup.PopupVerticalAlign = DevExpress.Web.ASPxClasses.PopupVerticalAlign.WindowCenter
        popup.ShowOnPageLoad = True
    End Sub
    'when view is clicked
    'save
    Protected Sub btnSavePA_Click(sender As Object, e As EventArgs) Handles btnSavePA.Click
        Dim pm As New excelImporter
        If (pm.insert_to(Session("dataPA"), SQLString(), "prInsertToPerformance") = True) Then
            displayMessage("Successfully updated. Please choose another sheet that you want to update. If you're already done, click back.")
            scenario2()
        Else
            displayMessage("Procedure Not Found. Please Update Database First.")
        End If
        'insert to master table
    End Sub
#End Region
#Region "events"
    'para nde lang mawala ung value ng viniview na data
    Protected Sub gridPA_BeforeGetCallbackResult(sender As Object, e As EventArgs) Handles gridPA.BeforeGetCallbackResult
        gridPA.DataSource = Session("dataPA")
        gridPA.DataBind()
    End Sub
#End Region

#Region "Essay Responses"
    Public Sub LoadData()
        Dim dgView As ASPxGridView = Nothing
        'Dim Sql_Ability As String = "SELECT [ID], CONVERT(DATE, [Period_From]) AS [Period_From], CONVERT(DATE, [Period_To]) AS [Period_To], [Man_No], [Rate_Code], UPPER([Rate_Type]) AS [Rate_Type] FROM prPerformance"
        'LoadExpDS(ds_Ability, Sql_Ability)
        'dgView_Ability.DataSource = ds_Ability
        'dgView_Ability.KeyFieldName = "ID"
        'dgView_Ability.DataBind()
        LoadExpGrid(Session, dgView_Ability, "AbilityRating", "<Tablename=prPerformance><PrimaryKey=[ID]><Columns=[ID], CONVERT(DATE, [Period_From]) AS [Period_From], CONVERT(DATE, [Period_To]) AS [Period_To], [Man_No], [Rate_Code], UPPER([Rate_Type]) AS [Rate_Type]><Where=([Rate_Type] != 'ATTENDANCE')>", "Data.View.Ability." & Session.SessionID)
    End Sub
    'Protected Sub dgView_EssRes_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_Ability.CustomJSProperties
    '    e.Properties("cpCancelEdit") = True
    '    e.Properties("cpRefreshDelete") = True
    'End Sub
    Protected Sub dgView_EssRes_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_Ability.RowInserting
        Dim SQLAudit As String = String.Empty
        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_Ability")) Then
            e.Cancel = True
            Exit Sub
        End If
        GetExpValues1(sender, e)
        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_EssRes_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_Ability.RowUpdating
        Dim SQLAudit As String = String.Empty
        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (sender.ID = "dgView_Ability") Then ExecSQL(String.Format("UPDATE [ESS.TWSEssayItems] SET KPACode = '{0}', Keyword = '{2}', CapturedBy = '{3}', CapturedOn = '{4}' WHERE Keyword = '{2}'", e.NewValues("KPACode"), e.NewValues("Keyword"), e.OldValues("Keyword"), Session("LoggedOn").UserID, DateTime.Now.ToString()))
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_EssRes_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_Ability.RowDeleting
        Dim SQLAudit As String = String.Empty
        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            If (sender.ID = "dgView_Ability") Then ExecSQL(String.Format("DELETE FROM [ESS.TWSEssayItems] WHERE KPACode = '{0}'", e.Keys("CompositeKey").ToString()))
        End If
        'LoadData()
    End Sub
    Protected Sub dgView_EssRes_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_Ability.RowValidating
        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex
        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then
            If (sender.Equals(dgView_Ability)) Then
                If (IsNull(e.OldValues("CapturedBy"))) Then e.OldValues("CapturedBy") = sender.GetRowValues(iRowIndex, "CapturedBy")
            End If
        ElseIf (sender.Equals(dgView_Ability)) Then
            e.NewValues("CapturedBy") = Session("LoggedOn").UserID
        End If
        ValidateExpValues1(sender, e)
    End Sub
    Private Sub GetExpValues1(ByVal sender As Object, ByVal e As Object)
        If (sender.Equals(dgView_Ability)) Then
            If (sender.IsEditing Or sender.IsNewRowEditing) AndAlso (sender.Equals(dgView_Ability)) Then
                e.NewValues("CapturedBy") = Session("LoggedOn").UserID
                e.NewValues("CapturedOn") = Date.Now
            End If
        End If
    End Sub
    Private Sub ValidateExpValues1(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        If (sender.Equals(dgView_Ability)) Then
            If (IsNull(e.NewValues("CapturedBy"))) Then e.NewValues("CapturedBy") = e.OldValues("CapturedBy")
        End If
        e.RowError = ValidateExpGrid(sender, e)
    End Sub
#End Region

    Protected Sub tabMenu_ActiveTabChanged(source As Object, e As DevExpress.Web.ASPxTabControl.TabControlEventArgs) Handles tabMenu.ActiveTabChanged
        If (tabMenu.ActiveTabIndex = 1) Then
            Server.Transfer("prImportPromotionHistory.aspx", True)
        ElseIf tabMenu.ActiveTabIndex = 2 Then
            Server.Transfer("prImportInfractions.aspx", True)
        ElseIf tabMenu.ActiveTabIndex = 3 Then
            Server.Transfer("prReports.aspx", True)
        End If
    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        popup.ShowOnPageLoad = False
    End Sub

    Protected Sub cbSheetPA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbSheetPA.SelectedIndexChanged
        Dim pm As New excelImporter
        lblMessage.Text = pm.toTemporaryTablePA(SQLString(), Session("excelPathFile"), Session("ExcelConnection"), cbSheetPA.SelectedItem.ToString())
        Dim xTable As DataTable = GetSQLDT("SELECT [EMPLOYEE NUMBER] AS [EmployeeCode] FROM [prViewNewData] WHERE [EMPLOYEE NUMBER] NOT IN (SELECT EmployeeNum FROM Personnel)")
        If xTable.Rows.Count = 0 Then
            Session("dataPA") = GetSQLDT("select * from prViewNewData")
            Dim dt As DataTable = Session("dataPA")
            gridPA.DataSource = Session("dataPA")
            gridPA.DataBind()
            If dt.Rows.Count = 0 And lblMessage.Text.ToLower = "true" Then
                displayMessage("Sheet already updated.")
                scenario2()
            ElseIf dt.Rows.Count = 0 And lblMessage.Text.ToLower = "false" Then
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
                           "attachment; filename=Attendance and Performance Template.xlsx;")
        Response.TransmitFile(Server.MapPath("downloads\Attendance and Performance Template.xlsx"))
        Response.Flush()
        Response.End()
    End Sub
End Class