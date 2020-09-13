Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports System.Web.HttpUtility

Partial Public Class reports
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("ReportUri") = Session("ReportUri")

        e.NewValues("SQL") = GetExpControl(sender, "SQL", "Text")

        e.NewValues("CreatedBy") = Session("LoggedOn").UserID

        e.NewValues("CreatedOn") = Now

        Session.Remove("ReportUri")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache) Then ClearFromCache("Data.Users.Reports." & Session.SessionID)

        With UDetails

            LoadExpGrid(Session, dgView, "ESS Reports", "<Tablename=ess.Users.ReportsLU><PrimaryKey=[ID]><Columns=[ModuleID], [Template], [Name], [ReportUri], [SQL], [CreatedBy], [CreatedOn]><Where=([Template] is null or [Template] = '" & .Template & "')>", "Data.Users.Reports." & Session.SessionID)

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        LoadExpDS(dsModuleLU, "select [ID], [Description] from [ess.ModuleLU] order by [Description]")

        LoadExpDS(dsTemplateLU, "select [Code], [Name] from [UserGroupTemplates] order by [Name]")

        UDetails = GetUserDetails(Session, "ESS Reports")

        LoadData(Not IsPostBack)

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView.RowDeleting

        Dim SQLAudit As String = "<Tablename=ess.Users.ReportsLU><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><ID=" & e.Values("CompositeKey").ToString() & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            FilePath = ServerPath & e.Values("ReportUri").ToString().Replace("~/", "\").Replace("/", "\")

            If (File.Exists(FilePath)) Then File.Delete(FilePath)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView.RowInserting

        Dim SQLAudit As String = "<Tablename=ess.Users.ReportsLU><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

        End If

    End Sub

    Private Sub dgView_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView.RowUpdating

        Dim SQLAudit As String = "<Tablename=ess.Users.ReportsLU><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><ID;2=" & e.Keys("CompositeKey").ToString() & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

        End If

    End Sub

    Private Sub dgView_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView.RowValidating

        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            If (IsNull(e.OldValues("ReportUri"))) Then e.OldValues("ReportUri") = sender.GetRowValues(iRowIndex, "ReportUri")

        End If

        e.NewValues("CreatedBy") = Session("LoggedOn").UserID

        e.NewValues("CreatedOn") = Now

        Dim upDocument As ASPxUploadControl = Session("UploadedFile")

        If (IsNull(upDocument)) Then

            If (sender.IsNewRowEditing) Then

                e.RowError = "Information incomplete, no file attached."

            Else

                If (IsNull(e.NewValues("ReportUri"))) Then e.NewValues("ReportUri") = e.OldValues("ReportUri")

                Session("ReportUri") = GetDataText(e.NewValues("ReportUri").ToString())

                e.RowError = ValidateExpGrid(sender, e)

            End If

        Else

            If (upDocument.UploadedFiles(0).IsValid) Then

                Dim DocPath As String = GetFileData(Me, upDocument.UploadedFiles(0), "reports")

                Session("ReportUri") = GetDataText(GetXML(DocPath, KeyName:="VirtualPath"))

                e.NewValues("ReportUri") = Session("ReportUri")

                e.RowError = ValidateExpGrid(sender, e)

                If (e.RowError.Length = 0) Then

                    If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

                        Dim FilePath As String = ServerPath & e.OldValues("ReportUri").ToString().Replace("~/", "\").Replace("/", "\")

                        If (File.Exists(FilePath)) Then File.Delete(FilePath)

                    End If

                    If (DocPath.Length > 0) Then upDocument.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                Else

                    Session.Remove("ReportUri")

                End If

            Else

                e.RowError = "Information incomplete, file attached not valid."

            End If

        End If

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim EncryptedURL As String = UrlEncode(CryptoEncrypt("<type=load><id=" & Container.Grid.GetRowValues(Container.VisibleIndex, "CompositeKey") & "><SessionID=" & Session.SessionID & "><Group=" & GetUserGroup(UDetails.UserID, Session.SessionID) & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile") = sender

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Try

            Dim xFilePath As String = "Users Reports [" & Date.Today.ToString("yyyy-MM-dd") & "]"

            Select Case e.Item.Name

                Case "mnuExp_CSV"
                    dgExports.WriteCsvToResponse(xFilePath)

                Case "mnuExp_XLS"
                    dgExports.WriteXlsToResponse(xFilePath)

                Case "mnuExp_XLSX"
                    dgExports.WriteXlsxToResponse(xFilePath)

                Case "mnuExp_RTF"
                    dgExports.WriteRtfToResponse(xFilePath)

                Case "mnuExp_PDF"
                    dgExports.WritePdfToResponse(xFilePath)

            End Select

        Catch ex As Exception

        Finally

        End Try

    End Sub

#End Region

End Class