Imports DevExpress.Web.ASPxGridView.Export
Imports DevExpress.Web.ASPxHtmlEditor
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class workflow
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            e.NewValues("Type") = GetExpControl(sender, "Type", "Text")

            e.NewValues("Name") = GetExpControl(sender, "fromname", "Text")

            e.NewValues("Address") = GetExpControl(sender, "fromaddress", "Text")

            e.NewValues("Server") = GetExpControl(sender, "Server", "Text")

            e.NewValues("Port") = Convert.ToInt16(GetExpControl(sender, "Port", "Text"))

            e.NewValues("Username") = GetExpControl(sender, "Username", "Text")

            Dim Password As String = Session("Password")

            If (Not IsNull(Password)) Then

                If (Password.Length > 0) Then Password = CryptoEncrypt(Password, EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                e.NewValues("Password") = Password

            End If

            e.NewValues("Subject") = GetExpControl(sender, "Subject", "Text")

            e.NewValues("Body") = Regex.Replace(Regex.Replace(Regex.Replace(GetExpControl(sender, "Body", "Html").ToString(), "PARAM\[", "<%PARAM[", RegexOptions.IgnoreCase), "\]", "]%>", RegexOptions.IgnoreCase), "{PathID}", "<%PathID%>", RegexOptions.IgnoreCase)

        ElseIf (sender.Equals(dgView_002)) Then

            e.NewValues("Type") = GetExpControl(sender, "Type", "Text")

            e.NewValues("Body") = Regex.Replace(Regex.Replace(Regex.Replace(GetExpControl(sender, "Body", "Text").ToString(), "PARAM\[", "<%PARAM[", RegexOptions.IgnoreCase), "\]", "]%>", RegexOptions.IgnoreCase), "{PathID}", "<%PathID%>", RegexOptions.IgnoreCase)

        ElseIf (sender.ID.ToString().Contains("_004")) Then

            e.NewValues("WFType") = dgView_003.GetRowValues(Convert.ToInt32(Session("Workflow.LoadSub")), "WFType")

            e.NewValues("WFName") = dgView_003.GetRowValues(Convert.ToInt32(Session("Workflow.LoadSub")), "WFName")

        ElseIf (sender.ID.ToString().Contains("_005")) Then

            e.NewValues("WFLUID") = dgView_003.GetRowValues(Convert.ToInt32(Session("Workflow.LoadSub")), "CompositeKey")

        End If

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002)) Then

            If (e.NewValues("Body").ToString().Contains("{TABLE:")) Then

                Dim tblBody() As String = {GetXML(e.NewValues("Body").ToString(), "{", "TABLE", ":", "}"), String.Empty}

                If (tblBody(0).Length > 0) Then

                    tblBody(1) = tblBody(0)

                    tblBody(0) = tblBody(0).Replace("]%>", "]")

                    e.NewValues("Body") = e.NewValues("Body").ToString().Replace(tblBody(1), tblBody(0))

                End If

            End If

        End If

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (Not IsPostBack) Then Session("Workflow.LoadSub") = Nothing

        Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabWorkflow.ActiveTabIndex

                Case 0
                    If (ClearCache) Then ClearFromCache("Data.Workflow.EmailLU.Setup")

                    LoadExpGrid(Session, dgView_001, "Workflow Manager", "<Tablename=EmailLU><PrimaryKey=[id]><Columns=[Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], replace(replace(replace(cast([Body] as varchar(8000)), char(60) + char(37) + 'PathID' + char(37) + char(62), '{PathID}'), char(60) + char(37), ''), char(37) + char(62), '') as [Body]>", "Data.Workflow.EmailLU.Setup")

                Case 1
                    If (ClearCache) Then ClearFromCache("Data.Workflow.SMSLU.Setup")

                    LoadExpGrid(Session, dgView_002, "Workflow Manager", "<Tablename=MessagingLU><PrimaryKey=[id]><Columns=[Type], replace(replace(replace(cast([Body] as varchar(8000)), char(60) + char(37) + 'PathID' + char(37) + char(62), '{PathID}'), char(60) + char(37), ''), char(37) + char(62), '') as [Body]>", "Data.Workflow.SMSLU.Setup")

                Case 2
                    If (ClearCache) Then

                        ClearFromCache("Data.Workflow.Setup")

                        ClearFromCache("Data.Workflow.Types.Setup")

                        ClearFromCache("Data.Workflow.Departments.Setup")

                    End If

                    LoadExpDS(dsWFType, "select [WFType] from [ess.WFTypeLU] order by [WFType]")

                    LoadExpDS(dsWFDepartment, "select distinct [DeptName] from [Department] order by [DeptName]")

                    If (IsNumeric(Session("Workflow.LoadSub"))) Then IsRowExpanded = dgView_003.IsRowExpanded(Session("Workflow.LoadSub"))

                    LoadExpGrid(Session, dgView_003, "Workflow Manager", "<Tablename=ess.WFLU><PrimaryKey=[ID]><Columns=(select top 1 [LockedBy] from [ess.WF] where ([WFLUID] = [ess.WFLU].[ID]) order by [LockedBy] desc) as [LockedBy], [WFType], [WFName]>", "Data.Workflow.Setup")

                    If (IsNumeric(Session("Workflow.LoadSub"))) Then

                        iRowIndex = Session("Workflow.LoadSub")

                        If (IsRowExpanded) Then

                            Dim wfType As String = dgView_003.GetRowValues(iRowIndex, "WFType").ToString()
                            Dim wfName As String = dgView_003.GetRowValues(iRowIndex, "WFName").ToString()

                            If (wfType.ToLower() = "leave") Then

                                LoadExpDS(dsWFAppType, "select 'Cancel' as [AppType] union select [LeaveType] from [LeaveLU] order by [AppType]")

                            Else

                                LoadExpDS(dsWFAppType, "select [AppType] from [ess.WFAppTypeLU] order by [AppType]")

                            End If

                            dgView = TryCast(TryCast(dgView_003.FindDetailRowTemplateControl(iRowIndex, "pageControl_003"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Tablename=ess.WFAppType><PrimaryKey=[ID]><Columns=[AppType], [StopBalExc], [MaxNegative], [WFType], [WFName]><Where=([WFType] = '" & wfType & "' and [WFName] = '" & wfName & "')>", "Data.Workflow.Types.Setup")

                            dgView = TryCast(TryCast(dgView_003.FindDetailRowTemplateControl(iRowIndex, "pageControl_003"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_005"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Tablename=ess.WFLinkedDepts><PrimaryKey=[ID]><Columns=[DeptName], [WFLUID]><Where=([WFLUID] = " & dgView_003.GetRowValues(iRowIndex, "CompositeKey") & ")>", "Data.Workflow.Departments.Setup")

                        End If

                    End If

            End Select

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (Not IsNull(Request.QueryString("TabID"))) Then

                If (IsNumeric(Request.QueryString("TabID"))) Then tabWorkflow.ActiveTabIndex = Convert.ToInt32(Request.QueryString("TabID"))

            End If

        End If

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then

            SetEmployeeData(Session, Session("Selected.Value"))

            Dim FilePath As String = String.Format("{0}\images\emails.jpg", ServerPath)

            If (Not File.Exists(FilePath)) Then Return

            Dim objImage As Object = File.ReadAllBytes(FilePath)

            If (Not IsNull(objImage)) Then

                imgPicture.ContentBytes = GetThumbnail(objImage, 120, 160)

            End If

        ElseIf (Not IsNull(Session("UploadedFile"))) Then

            Dim FilePath As String = String.Format("{0}\images\emails.jpg", ServerPath)

            Dim objImage As Object = Session("UploadedFile").UploadedFiles(0).FileBytes

            Session.Remove("UploadedFile")

            File.WriteAllBytes(FilePath, objImage)

            If (Not IsNull(objImage)) Then

                imgPicture.ContentBytes = GetThumbnail(objImage, 120, 160)

                'Else

                '    imgPicture.ContentBytes = Nothing

            End If

            'ElseIf (tabWorkflow.ActiveTabIndex = 3) Then

            '    Dim FilePath As String = String.Format("{0}\emails.htm", ServerPath)

            '    If (Not File.Exists(FilePath)) Then Return

            '    If (emailEditor_001.Html = Nothing Or emailEditor_001.Html = "") Then

            '        emailEditor_001.Html = File.ReadAllText(FilePath)

            '    End If

        End If

        UDetails = GetUserDetails(Session, "Workflow Manager")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Dim SQL As String = String.Empty

        Select Case Values(0)

            Case "Cascade"
                Dim Name As String = Values(1)
                Dim Address As String = Values(2)
                Dim Server As String = Values(3)
                Dim Port As String = Values(4)
                Dim Username As String = GetNullText(Values(5))
                Dim Password As String = GetNullText(GetDataText(CryptoEncrypt(Values(6), EncPwd, SaltPwd, 5, EncVectorPwd, 256)))

                SQL = "update [EmailLU] set [Name] = '" & Name & "', [Address] = '" & Address & "', [Server] = '" & Server & "', [Port] = " & Port & ", [Username] = " & Username & ", [Password] = " & Password

            Case "Password"
                Session("Password") = Values(1)

                ErrorText = SUCCESS

            Case "Unlock"
                SQL = "update [ess.WF] set [LockedBy] = null where ([WFLUID] = " & dgView_003.GetRowValues(Convert.ToInt32(Values(1)), "CompositeKey").ToString() & ")"

            Case "Workflow"
                If (Values(1) = "Processes") Then

                    Session("WFLUID") = dgView_003.GetRowValues(Convert.ToInt32(Values(2)), "CompositeKey")
                    Session("WFType") = dgView_003.GetRowValues(Convert.ToInt32(Values(2)), "WFType")
                    Session("WFName") = dgView_003.GetRowValues(Convert.ToInt32(Values(2)), "WFName")

                    ErrorText = "workflowman_001.aspx tools/index.aspx"

                End If

        End Select

        If (SQL.Length > 0) Then

            If (ExecSQL(SQL)) Then

                LoadData(True)

                ErrorText = SUCCESS & " Successfully saved the information"

            Else

                ErrorText = DBERROR & SQL

            End If

        End If

        e.Result = Values(0) & " " & ErrorText

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Private Sub dgView_003_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView_003.CustomButtonInitialize

        If (e.Column.Name = "unlock") Then

            If (sender.GetRowValues(e.VisibleIndex, "LockedBy").ToString().Length = 0) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        End If

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

    End Sub

    Private Sub dgView_003_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_003.DataBound

        Dim bVisible As Boolean

        For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

            If (sender.GetRowValues(iLoop, "LockedBy").ToString().Length > 0) Then

                bVisible = True

                Exit For

            End If

        Next

        sender.Columns("unlock").Visible = bVisible

    End Sub

    Private Sub dgView_003_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowEventArgs) Handles dgView_003.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = Nothing

            With UDetails

                If (sender.Equals(dgView_003)) Then

                    ClearFromCache("Data.Workflow.Setup")

                    ClearFromCache("Data.Workflow.Types.Setup")

                    ClearFromCache("Data.Workflow.Departments.Setup")

                    Dim wfType As String = dgView_003.GetRowValues(e.VisibleIndex, "WFType").ToString()
                    Dim wfName As String = dgView_003.GetRowValues(e.VisibleIndex, "WFName").ToString()

                    If (wfType.ToLower() = "leave") Then

                        LoadExpDS(dsWFAppType, "select 'Cancel' as [AppType] union select [LeaveType] from [LeaveLU] order by [AppType]")

                    Else

                        LoadExpDS(dsWFAppType, "select [AppType] from [ess.WFAppTypeLU] order by [AppType]")

                    End If

                    dgView = TryCast(TryCast(dgView_003.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl_003"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Tablename=ess.WFAppType><PrimaryKey=[ID]><Columns=[AppType], [StopBalExc], [MaxNegative], [WFType], [WFName]><Where=([WFType] = '" & wfType & "' and [WFName] = '" & wfName & "')>", "Data.Workflow.Types.Setup")

                    dgView = TryCast(TryCast(dgView_003.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl_003"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_005"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Tablename=ess.WFLinkedDepts><PrimaryKey=[ID]><Columns=[DeptName], [WFLUID]><Where=([WFLUID] = " & dgView_003.GetRowValues(e.VisibleIndex, "CompositeKey") & ")>", "Data.Workflow.Departments.Setup")

                    Session("Workflow.LoadSub") = e.VisibleIndex

                End If

            End With

        ElseIf (sender.Equals(dgView_003) AndAlso IsNumeric(Session("Workflow.LoadSub"))) Then

            Session.Remove("Workflow.LoadSub")

        End If

    End Sub

    Private Sub dgView_001_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles dgView_001.HtmlRowCreated, dgView_002.HtmlRowCreated

        If (e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.Data AndAlso sender.Equals(dgView_002)) Then

            Dim lblText As DevExpress.Web.ASPxEditors.ASPxLabel = TryCast(TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, TryCast(sender.Columns("Body"), DevExpress.Web.ASPxGridView.GridViewDataColumn), "lblBody" & sender.ID.Replace("dgView", String.Empty)), DevExpress.Web.ASPxEditors.ASPxLabel), DevExpress.Web.ASPxEditors.ASPxLabel)

            If (Not IsNull(lblText)) Then lblText.Text = SplitText(sender.GetRowValues(e.VisibleIndex, "Body").ToString().Replace(Chr(9), String.Empty), 75) & "... "

        ElseIf (e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.EditForm AndAlso (Not sender.IsNewRowEditing) AndAlso sender.Equals(dgView_001)) Then

            Dim Password As String = e.GetValue("Password").ToString()

            If (Password.Length > 0) Then Password = CryptoDecrypt(Password, EncPwd, SaltPwd, 5, EncVectorPwd, 256)

            SetExpControl(sender, "password", "Text", Password)

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting
        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_004" OrElse sender.ID = "dgView_005") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting

        Dim SQLAudit As String = String.Empty

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004" OrElse sender.ID.ToString() = "dgView_005")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating

        Dim SQLAudit As String = String.Empty

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating

        GetExpValues(sender, e)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabWorkflow.TabPages(tabWorkflow.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabWorkflow.TabPages(tabWorkflow.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dgExports)) Then

                dgExports.Dispose()

                dgExports = Nothing

            End If

        End Try

    End Sub

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session.Remove("UploadedFile")

        If (sender.UploadedFiles.Length > 0) Then Session("UploadedFile") = sender

    End Sub

    Protected Sub cmdUpdate_Click(sender As Object, e As EventArgs)

        Using strWriter As New System.IO.StreamWriter(String.Format("{0}\emails.htm", ServerPath))
            strWriter.Write(CreateFullHtmlString())
        End Using

    End Sub

    Protected Sub emailEditor_001_Load(sender As Object, e As EventArgs)

        Dim FilePath As String = String.Format("{0}\emails.htm", ServerPath)

        If (Not File.Exists(FilePath)) Then Return

        If (emailEditor_001.Html = Nothing Or emailEditor_001.Html = "") Then

            emailEditor_001.Html = File.ReadAllText(FilePath).Replace("<%Body%>", "&lt;%Body%&gt;").Replace("<a href=""<%WebServer%>""><%WebServer%></a>", "<%WebServer%>").Replace("<%WebServer%>", "&lt;%WebServer%&gt;")

        End If

    End Sub

    Private Function CreateFullHtmlString() As String

        Dim htmlText As String = "" & Environment.NewLine &
        "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">" & Environment.NewLine &
        "<html xmlns=""http://www.w3.org/1999/xhtml"" >" & Environment.NewLine &
        "	<head>" & Environment.NewLine &
        "		<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />" & Environment.NewLine &
        "		<meta name=""Generator"" content=""Microsoft Word 11 (filtered medium)"" />" & Environment.NewLine &
        "		<style type=""text/css"">" & Environment.NewLine &
        "            html, body" & Environment.NewLine &
        "            {" & Environment.NewLine &
        "                background: #ffffff;" & Environment.NewLine &
        "                color: #000000;" & Environment.NewLine &
        "                font: 10pt Tahoma;" & Environment.NewLine &
        "                margin: 0px;" & Environment.NewLine &
        "                padding: 0px;" & Environment.NewLine &
        "                text-align: left;" & Environment.NewLine &
        "            }" & Environment.NewLine &
        "		</style>" & Environment.NewLine &
        "       <title>Absalom Systems Pty Ltd: SmartHR - It's about people</title>" & Environment.NewLine &
        "	</head>" & Environment.NewLine &
        "	<body>" & Environment.NewLine &
        "       " &
        HttpUtility.HtmlDecode(emailEditor_001.Html).Replace("%3C%WebServer%%3E", "<%WebServer%>").Replace("&lt;%WebServer%&gt;", "<%WebServer%>").Replace("%3C%Body%%3E", "<%Body%>").Replace("&lt;%Body%&gt;", "<%Body%>").Replace("<%WebServer%>", "<a href=""<%WebServer%>""><%WebServer%></a>") & Environment.NewLine &
        "	</body>" & Environment.NewLine &
        "</html>"

        CreateFullHtmlString = htmlText

    End Function

#End Region

End Class
