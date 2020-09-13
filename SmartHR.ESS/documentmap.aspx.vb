Imports DevExpress.Web.ASPxGridView.Export
Imports System.IO

Partial Public Class documentmap
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub LoadData()

        Dim UserGroup As String = String.Empty

        If (Not IsPostBack) Then

            tabDocumentMap.TabPages(1).Visible = Convert.ToBoolean((Session("Managed").CompanyNum = Session("LoggedOn").CompanyNum) AndAlso (Session("Managed").EmployeeNum = Session("LoggedOn").EmployeeNum))

            tabDocumentMap.TabPages(2).Visible = tabDocumentMap.TabPages(1).Visible

        End If

        If (Not IsNull(Session("LoggedOn"))) Then

            UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

            If (Not IsNull(UserGroup)) Then

                With UDetails

                    Select Case tabDocumentMap.ActiveTabIndex

                        Case 0
                            LoadExpGrid(Session, dgView_001, "Document Mapping", "<Tablename=ess.Documents><PrimaryKey=[ID]><Columns=[DateLinked], [Category], [Description], [Accepted], [DateRead], [VirtualPath]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Documents." & Session.SessionID)

                        Case 1
                            dgView_002.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                            dgView_002.DataBind()

                    End Select

                    If (cmbEmployee.Items.Count = 0) Then

                        cmbEmployee.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                        cmbEmployee.DataBind()

                    End If

                End With

            End If

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        LoadExpDS(dsCategory, "select [Description] from [ess.ModuleLU] order by [Description]")

        UDetails = GetUserDetails(Session, "Document Mapping")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim sender As Object = Nothing

        Dim DocPath As String = String.Empty

        Dim bClearFromCache As Boolean

        Dim bSaved As Boolean

        Dim SQL As String = String.Empty

        Try

            sender = Session("UploadedFile")

            If (Not IsNull(sender)) Then

                DocPath = GetFileData(Me, sender.UploadedFiles(0), "documents/mapped")

                If (DocPath.Length > 0) Then sender.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                If (sender.ID.ToString().Contains("_002")) Then

                    For Each objKey As Object In dgView_002.GetSelectedFieldValues("Value")

                        If (objKey = Session("Managed").CompanyNum & " " & Session("Managed").EmployeeNum) Then bClearFromCache = True

                        SQL = "insert into [ess.Documents]([CompanyNum], [EmployeeNum], [Category], [Path], [VirtualPath], [Description], [UserLinked], [DateLinked], [Acknowledged]) values('" & objKey.Split(" ")(0) & "', '" & objKey.Split(" ")(1) & "', '" & GetDataText(cmbCategory_002.Value) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "', '" & GetDataText(txtDescription_002.Text) & "', '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', 0)"

                        bSaved = ExecSQL(SQL)

                        If (Not bSaved) Then Exit For

                    Next

                Else

                    If (cmbEmployee.Value = Session("Managed").CompanyNum & " " & Session("Managed").EmployeeNum) Then bClearFromCache = True

                    SQL = "insert into [ess.Documents]([CompanyNum], [EmployeeNum], [Category], [Path], [VirtualPath], [Description], [UserLinked], [DateLinked], [Acknowledged]) values('" & cmbEmployee.Value.Split(" ")(0) & "', '" & cmbEmployee.Value.Split(" ")(1) & "', '" & GetDataText(cmbCategory_003.Value) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "', '" & GetDataText(txtDescription_003.Text) & "', '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', 0)"

                    bSaved = ExecSQL(SQL)

                End If

                Session.Remove("UploadedFile")

            End If

        Catch ex As Exception

        Finally

            If (bSaved) Then

                If (bClearFromCache) Then ClearFromCache("Data.Documents." & Session.SessionID)

                dgView_002.Selection.UnselectAll()

                e.Result = SUCCESS & " Successfully saved the information"

            Else

                e.Result = DBERROR & SQL

                If (File.Exists(GetXML(DocPath, KeyName:="FilePath"))) Then File.Delete(GetXML(DocPath, KeyName:="FilePath"))

            End If

            If (Not IsNull(sender)) Then sender = Nothing

        End Try

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            If (Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Length > 0) Then

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

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabDocumentMap.TabPages(tabDocumentMap.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabDocumentMap.TabPages(tabDocumentMap.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

#End Region

End Class