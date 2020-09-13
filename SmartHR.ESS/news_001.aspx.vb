Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class news_001
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object, Optional ByVal ClearSession As Boolean = True)

        e.NewValues("Date") = GetExpControl(sender, "Date", "Date")

        e.NewValues("Title") = GetExpControl(sender, "Title", "Text")

        e.NewValues("Summary") = GetExpControl(sender, "Summary", "Text")

        e.NewValues("ImageUrl") = Session("ImageUrl")

        e.NewValues("CapturedBy") = Session("LoggedOn").UserID

        e.NewValues("CapturedDate") = Now

        e.NewValues("Article") = GetExpControl(sender, "Article", "Html")

        If (ClearSession) Then Session.Remove("ImageUrl")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache) Then ClearFromCache("Data.NewsLU")

        With UDetails

            LoadExpGrid(Session, dgView, "Notify Admin", "<Tablename=ess.News><PrimaryKey=[ID]><Columns=[Title], [Summary], [Date], [ImageUrl], [Article], [CapturedBy], [CapturedDate]><ColumnOrder=Date><OrderType=desc>", "Data.NewsLU")

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

        UDetails = GetUserDetails(Session, "Notify Admin")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Back") Then e.Result = "homepage.aspx tools/index.aspx"

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView.CustomColumnDisplayText

        If (e.Column.FieldName = "Summary") Then

            e.DisplayText = SplitText(sender.GetRowValues(e.VisibleRowIndex, "Summary"), 45) & "..."

        ElseIf (e.Column.FieldName = "Article") Then

            e.DisplayText = SplitText(sender.GetRowValues(e.VisibleRowIndex, "Article"), 75) & "..."

        End If

    End Sub

    Private Sub dgView_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            FilePath = ServerPath & e.Values("ImageUrl").ToString().Replace("~/", "\").Replace("/", "\")

            If (File.Exists(FilePath)) Then File.Delete(FilePath)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView.RowInserting

        Dim SQLAudit As String = String.Empty

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

        Dim SQLAudit As String = String.Empty

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

            If (IsNull(e.OldValues("ImageUrl"))) Then e.OldValues("ImageUrl") = sender.GetRowValues(iRowIndex, "ImageUrl")

        End If

        Dim upDocument As ASPxUploadControl = Session("UploadedFile")

        If (IsNull(upDocument)) Then

            If (sender.IsNewRowEditing) Then

                e.RowError = "Information incomplete, no file attached."

            Else

                If (IsNull(e.NewValues("ImageUrl"))) Then e.NewValues("ImageUrl") = e.OldValues("ImageUrl")

                Session("ImageUrl") = GetDataText(e.NewValues("ImageUrl").ToString())

                GetExpValues(sender, e, False)

                e.RowError = ValidateExpGrid(sender, e)

            End If

        Else

            If (upDocument.UploadedFiles(0).IsValid) Then

                Dim sDocPath As String = GetFileData(Me, upDocument.UploadedFiles(0), "documents/news")

                Session("ImageUrl") = GetDataText(GetXML(sDocPath, KeyName:="VirtualPath"))

                e.NewValues("ImageUrl") = Session("ImageUrl")

                GetExpValues(sender, e, False)

                e.RowError = ValidateExpGrid(sender, e)

                If (e.RowError.Length = 0) Then

                    If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

                        Dim FilePath As String = ServerPath & e.OldValues("ImageUrl").ToString().Replace("~/", "\").Replace("/", "\")

                        If (File.Exists(FilePath)) Then File.Delete(FilePath)

                    End If

                    If (sDocPath.Length > 0) Then

                        'upDocument.UploadedFiles(0).SaveAs(GetXML(sDocPath, KeyName:="FilePath"))

                        Dim thumbBytes() As Byte = GetThumbnail(upDocument.UploadedFiles(0).FileBytes, 48, 48)

                        Dim ioThumbnail As New FileStream(GetXML(sDocPath, KeyName:="FilePath"), FileMode.Create)

                        ioThumbnail.Seek(0, SeekOrigin.Begin)

                        ioThumbnail.Write(thumbBytes, 0, thumbBytes.Length)

                        ioThumbnail.Close()

                        ioThumbnail.Dispose()

                        ioThumbnail = Nothing

                    End If

                Else

                    Session.Remove("ImageUrl")

                End If

            Else

                e.RowError = "Information incomplete, file attached not valid."

            End If

        End If

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "ImageUrl").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ImageUrl").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ImageUrl").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open Image"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ImageUrl").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            If (Container.Grid.GetRowValues(Container.VisibleIndex, "ImageUrl").ToString().Length > 0) Then

                ReturnText = "the image could not be located"

            Else

                ReturnText = "no image attached"

            End If

        End If

        Return ReturnText

    End Function

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile") = sender

    End Sub

#End Region

End Class