Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class linkdocs
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function LinkDocsGetFileData(ByRef pg As Page, ByRef docUpload As Object, Optional ByVal CheckDuplicate As Boolean = True) As String

        Dim ReturnText As String = String.Empty

        Try
            Dim drivePath As String = System.Configuration.ConfigurationManager.AppSettings.Get("SavePathDrive")
            Dim folderPath As String = System.Configuration.ConfigurationManager.AppSettings.Get("SavePathFolder")
            If (Not Directory.Exists(String.Format("{0}/{1}", Server.MapPath("~"), folderPath))) Then 'added directory creation 
                Directory.CreateDirectory(String.Format("{0}/{1}", Server.MapPath("~"), folderPath))
            End If
            Dim empNum As String = UDetails.EmployeeNum.ToString().Trim()
            'Dim empNum As String = Session("LoggedOn").EmployeeNum.ToString.Trim()

            Dim UploadPath As String = String.Format("{0}\{1}\{2}",
                                                     Server.MapPath("~"),
                                                     folderPath,
                                                     empNum)

            Dim FileStripped As String = String.Empty
            Dim FilePath As String = String.Empty
            Dim UNCPath As String = String.Empty

            With docUpload

                If (Not IsNull(.PostedFile)) Then

                    If ((.PostedFile.FileName.Length > 0) And (.PostedFile.ContentLength > 0)) Then

                        FileStripped = Path.GetFileName(.PostedFile.FileName).Replace("'", String.Empty)

                        Dim bFound As Boolean
                        Dim iIndex As Integer
                        Dim Filename(1) As String

                        Filename(0) = " - Copy"
                        Filename(1) = " - Copy (%iIndex%)"

                        FilePath = Path.Combine(UploadPath, FileStripped)

                        If (CheckDuplicate) Then

                            Dim tmpFilename As String

                            iIndex = 0

                            bFound = File.Exists(FilePath)

                            While (bFound)

                                tmpFilename = Path.GetDirectoryName(FilePath) & "\" & Path.GetFileNameWithoutExtension(FilePath) & Filename(IIf(iIndex > 1, 1, iIndex)).Replace("%iIndex%", iIndex.ToString()) & Path.GetExtension(FilePath).ToLower()

                                iIndex += 1

                                bFound = File.Exists(tmpFilename)

                                If (Not bFound) Then FilePath = tmpFilename

                            End While

                        End If

                        If (Not Directory.Exists(UploadPath)) Then Directory.CreateDirectory(UploadPath)

                        ReturnText = String.Format("<MapPath={0}>",
                                                   UploadPath)

                        ReturnText &= String.Format("<FilePath={0}>",
                                                    FilePath)

                        ReturnText &= String.Format("<VirtualPath=~/{0}/{1}/{2}>",
                                                    folderPath,
                                                    empNum,
                                                    FileStripped)

                        ReturnText &= String.Format("<ServerPath={0}/{1}/{2}/{3}>",
                                                    System.Configuration.ConfigurationManager.AppSettings.Get("SaveWebsite"),
                                                    folderPath,
                                                    empNum,
                                                    FileStripped)

                        ReturnText &= String.Format("<UNCPath=\\{0}\{1}\{2}\{3}>",
                                                    pg.Server.MachineName,
                                                    folderPath.Replace("/", "\"),
                                                    empNum,
                                                    FileStripped)

                    End If

                End If

            End With

        Catch ex As Exception

        Finally

        End Try

        Return ReturnText

    End Function

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("DocPath") = Session("DocPath")

        e.NewValues("ESSLinked") = True

        e.NewValues("ESSPath") = Session("ESSPath")

        'e.NewValues("UserLinked") = Session("LoggedOn").UserID

        e.NewValues("UserLinked") = Session("Managed").UserID

        e.NewValues("DateLinked") = Now

        Session.Remove("DocPath")

        Session.Remove("ESSPath")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache) Then ClearFromCache("Data.LinkedDocs." & Session.SessionID)

        With UDetails

            LoadExpGrid(Session, dgView, "Linked Documents", "<Tablename=PersonnelDocLink><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [DocPath] + ' ' + [Category]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Category], [DocDescription], [DocPath], [ESSLinked], [ESSPath], [UserLinked], [DateLinked]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.LinkedDocs." & Session.SessionID)

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

        LoadExpDS(dsCategory, "select [Value], [Text] from [DocLinkCategoryLU] order by [Text]")

        UDetails = GetUserDetails(Session, "Linked Documents")

        'With UDetails

        '    Dim xEmployee As String = .EmployeeNum

        'End With

        LoadData(True)

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView.RowDeleting

        Dim SQLAudit As String = "<Tablename=PersonnelDocLink><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><DocPath=" & e.Values("DocPath").ToString() & "><Category=" & e.Values("Category").ToString() & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            'If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("Managed").UserID, SQLAudit)

            FilePath = String.Format("{0}:{1}", System.Configuration.ConfigurationManager.AppSettings.Get("SavePathDrive"), e.Values("ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))

            Dim FileStripped As String = Path.GetFileName(FilePath)

            Dim UploadPath As String = FilePath.Replace(FileStripped, "Deleted")

            Dim DeletedFilePath As String = String.Format("{0}\{1}", UploadPath, FileStripped)

            If (File.Exists(FilePath)) Then

                If (Not Directory.Exists(UploadPath)) Then Directory.CreateDirectory(UploadPath)

                If (File.Exists(DeletedFilePath)) Then

                    'File.Move(FilePath, FilePath)
                    'File.Delete(FilePath)

                    File.Delete(DeletedFilePath)

                End If

                File.Move(FilePath, DeletedFilePath)

            End If

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView.RowInserting

        Dim SQLAudit As String = "<Tablename=PersonnelDocLink><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            'If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("Managed").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

        End If

    End Sub

    Private Sub dgView_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView.RowUpdating

        Dim SQLAudit As String = "<Tablename=PersonnelDocLink><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><DocPath;2=" & Session("DocPath").ToString() & "><Category;3=" & e.OldValues("Category").ToString() & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            'If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("Managed").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

        End If

    End Sub

    Private Sub dgView_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView.RowValidating

        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            If (IsNull(e.OldValues("DocPath"))) Then e.OldValues("DocPath") = sender.GetRowValues(iRowIndex, "DocPath")

            If (IsNull(e.OldValues("ESSPath"))) Then e.OldValues("ESSPath") = sender.GetRowValues(iRowIndex, "ESSPath")

        End If

        e.NewValues("ESSLinked") = True

        Dim upDocument As ASPxUploadControl = Session("UploadedFile")

        If (IsNull(upDocument)) Then

            If (sender.IsNewRowEditing) Then

                e.RowError = "Information incomplete, no file attached."

            Else

                If (IsNull(e.NewValues("DocPath"))) Then e.NewValues("DocPath") = e.OldValues("DocPath")

                If (IsNull(e.NewValues("ESSPath"))) Then e.NewValues("ESSPath") = e.OldValues("ESSPath")

                Session("DocPath") = GetDataText(e.NewValues("DocPath").ToString())

                Session("ESSPath") = GetDataText(e.NewValues("ESSPath").ToString())

                e.RowError = ValidateExpGrid(sender, e)

            End If

        Else

            If (upDocument.UploadedFiles(0).IsValid) Then

                Dim DocPath As String = LinkDocsGetFileData(Me, upDocument.UploadedFiles(0))

                Session("DocPath") = GetDataText(GetXML(DocPath, KeyName:="ServerPath"))

                e.NewValues("DocPath") = Session("DocPath")

                Session("ESSPath") = GetDataText(GetXML(DocPath, KeyName:="VirtualPath"))

                e.NewValues("ESSPath") = Session("ESSPath")

                e.RowError = ValidateExpGrid(sender, e)

                If (e.RowError.Length = 0) Then

                    If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

                        Dim FilePath As String = ServerPath & e.OldValues("ESSPath").ToString().Replace("~/", "\").Replace("/", "\")

                        If (File.Exists(FilePath)) Then File.Delete(FilePath)

                    End If

                    If (DocPath.Length > 0) Then upDocument.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                Else

                    Session.Remove("DocPath")
                    Session.Remove("ESSPath")

                End If

            Else

                e.RowError = "Information incomplete, file attached not valid."

            End If

        End If

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "DocPath").ToString().Replace("~/", "/") & "', 'download'); }"

        If (Not File.Exists(Server.MapPath(Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath")))) Then
            ReturnText = String.Empty
        End If

        'Dim ReturnText As String = "function(s, e) { window.open('" & System.Configuration.ConfigurationManager.AppSettings.Get("SaveWebsite") & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "/") & "', 'download'); }"
        'If (Not File.Exists(System.Configuration.ConfigurationManager.AppSettings.Get("SavePathDrive") & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", ":\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(Server.MapPath(Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath")))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (Not File.Exists(Server.MapPath(Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath")))) Then

            If (Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Length > 0) Then

                ReturnText = "the file could not be located"

            Else

                ReturnText = "no file attached"

            End If

        End If

        Return ReturnText

    End Function

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile") = sender

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Try

            Dim xFilePath As String = "Linked Documents [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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