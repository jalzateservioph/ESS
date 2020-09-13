Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class assets
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing
    Private URL As String = String.Empty

    Private ShowColumns() As Boolean = {False, False}
    Private ValidatedText As String
    Private ValidatedCancel As Boolean
    Private ValidatedCancelText As String

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("Remarks") = GetExpControl(sender, "Remarks", "Text")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        With UDetails

            Select Case tabAssets.ActiveTabIndex

                Case 0
                    If (ClearCache) Then ClearFromCache("Data.Assets.Register." & Session.SessionID)

                    LoadExpGrid(Session, dgView_001, "Stores/Loans Tab", "<Tablename=StoreIssued><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ItemCode] + ' ' + convert(nvarchar(19), [IssueDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[ItemCode], [IssueDate], [Quantity], [ReturnDate], [Reference], [Remarks]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StoreStatus] = 'Not Submitted')>", "Data.Assets.Register." & Session.SessionID)

                Case 1
                    If (ClearCache) Then ClearFromCache("Data.Assets.Status." & Session.SessionID)

                    ValidatedCancel = IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Stores", "Cancel", ValidatedCancelText)

                    LoadExpGrid(Session, dgView_002, "Stores/Loans Tab", "<Tablename=StoreIssued><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ItemCode] + ' ' + convert(nvarchar(19), [IssueDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[ItemCode], [IssueDate], [Quantity], [ReturnDate], [Reference], [StoreStatus], [Remarks]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and (not [StoreStatus] = 'Not Submitted' or [StoreStatus] is null))>", "Data.Assets.Status." & Session.SessionID)

                    If (Not ShowColumns(0)) Then

                        dgView_002.Columns("edit").Visible = False

                        dgView_002.Columns("delete").Visible = False

                    End If

                    If (Not ShowColumns(1)) Then dgView_002.Columns("cancel").Visible = False

                    If (ShowColumns(1) AndAlso Not ValidatedCancel) Then dgView_002.Columns("cancel").Visible = False

            End Select

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

        UDetails = GetUserDetails(Session, "Stores/Loans Tab")

        LoadExpDS(dsItemCode, "select distinct [ItemCode], [ItemDescription] from [StoresItems] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [ItemDescription]")

        LoadData()

        With UDetails

            If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Stores", "Stores", ValidatedText) AndAlso Not IsPostBack) Then

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.ShowPopup('" & ReplaceJavaText(ValidatedText) & "'); }"

            Else

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }"

            End If

        End With

    End Sub

    'TODO: v6.0.74 ENSURE THAT WE COMBINE ITEMS TO SUBMIT ALL ITEMS AS ONE WORKFLOW APPOVAL
    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim bSaved As Boolean

            With UDetails

                For iLoop As Integer = 0 To (dgView_001.VisibleRowCount - 1)

                    bSaved = ExecSQL("update [StoreIssued] set [StatusID] = -1, [StoreStatus] = 'New' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ItemCode] + ' ' + convert(nvarchar(19), [IssueDate], 120) = '" & dgView_001.GetRowValues(iLoop, "CompositeKey") & "')")

                    If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Stores', 'Stores', 'Start', 'Start', '" & Convert.ToDateTime(dgView_001.GetRowValues(iLoop, "IssueDate")).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                    If (Not bSaved) Then Exit For

                Next

            End With

            If (bSaved) Then

                ClearFromCache("Data.Assets.Register." & Session.SessionID)

                ClearFromCache("Data.Assets.Status." & Session.SessionID)

                e.Result = "tasks.aspx tools/index.aspx"

            End If

        End If

    End Sub

    Private Sub dgView_002_CommandButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCommandButtonEventArgs) Handles dgView_002.CommandButtonInitialize

        If (e.ButtonType = DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Edit) Or (e.ButtonType = DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Delete) Then

            Dim Status As String = sender.GetRowValues(e.VisibleIndex, "StoreStatus").ToString()

            If (Status = "HOD Declined" OrElse Status = "HR Declined") Then

                If (Not ShowColumns(0)) Then ShowColumns(0) = True

                e.Visible = True

            Else

                e.Visible = False

            End If

        End If

    End Sub

    Private Sub dgView_002_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_002.CustomButtonCallback

        If (e.ButtonID = "Cancel") Then

            With UDetails

                Dim SQL As String = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Stores', 'Cancel', 'Start', 'Start', '" & Convert.ToDateTime(dgView_002.GetRowValues(e.VisibleIndex, "IssueDate")).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                If (ExecSQL(SQL)) Then URL = "tasks.aspx tools/index.aspx"

            End With

        End If

    End Sub

    Private Sub dgView_002_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView_002.CustomButtonInitialize

        If (e.Column.Name = "cancel") Then

            e.Visible = DevExpress.Utils.DefaultBoolean.False

            If (ValidatedCancel) Then

                Dim Status As String = sender.GetRowValues(e.VisibleIndex, "StoreStatus").ToString()

                If (Not Status = "Cancelled" AndAlso Status.Length > 0) Then

                    e.Visible = DevExpress.Utils.DefaultBoolean.True

                    If (Not ShowColumns(1)) Then ShowColumns(1) = True

                End If

            End If

        End If

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        If (sender.Equals(dgView_002)) Then e.Properties("cpURL") = URL

    End Sub

    Private Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting

        Dim SQLAudit As String = "<Tablename=StoreIssued><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><ItemCode=" & e.Values("ItemCode").ToString() & "><IssueDate=" & Convert.ToDateTime(e.Values("IssueDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting

        Dim SQLAudit As String = "<Tablename=StoreIssued><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating

        Dim SQLAudit As String = "<Tablename=StoreIssued><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><ItemCode;2=" & e.OldValues("ItemCode").ToString() & "><IssueDate;3=" & Convert.ToDateTime(e.OldValues("IssueDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabAssets.TabPages(tabAssets.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabAssets.TabPages(tabAssets.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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