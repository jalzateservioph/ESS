Public Partial Class routing
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub FillComboBox(ByVal cmb As DevExpress.Web.ASPxEditors.ASPxComboBox, ByVal RouteToCompNum As String)

        If (String.IsNullOrEmpty(RouteToCompNum)) Then Return

        LoadExpDS(dsRouteToEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & GetDataText(RouteToCompNum) & "') order by [Name]")

        cmb.DataBind()

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache) Then ClearFromCache("Data.Routing." & Session.SessionID)

        LoadExpDS(dsRouteToCompNum, "select [CompanyName] + ' [' + [CompanyNum] + ']' as [CompanyName], [CompanyNum] from [Company] order by [CompanyName]")

        With UDetails

            LoadExpGrid(Session, dgView, "Tasks", "<Tablename=ess.RoutingRules><PrimaryKey=[ID]><Columns=[CompanyNum], [EmployeeNum], [WFLUID], [RouteToCompNum], [RouteToEmpNum], [From], [Until], [OnceOff], [Description], [CapturedBy], [CapturedOn]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Routing." & Session.SessionID)

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

        LoadExpDS(dsWFLU, "select [WFType] + ': ' + [WFName] as [Text], [ID] from [ess.WFLU] where (not [WFType] in('Performance', 'Registration')) order by [WFType] + ': ' + [WFName]")

        UDetails = GetUserDetails(Session, "Tasks")

        LoadData()

    End Sub

    Protected Sub cmbEmployee_OnCallback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)

        FillComboBox(TryCast(source, DevExpress.Web.ASPxEditors.ASPxComboBox), e.Parameter)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim ReturnText As String = String.Empty

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Select Case Values(0)

            Case "Submit"
                If (Values(1) = "submit") Then

                    ReturnText = "tasks.aspx tools/index.aspx"

                    Dim WFLUID As Integer = 0

                    Dim dteStart As Date = Nothing

                    Dim dteUntil As Date = Nothing

                    Dim RouteID As Integer = 0

                    Dim objData() As Object = dgView.GetRowValues(Convert.ToInt32(Values(2)), "CompositeKey", "CompanyNum", "EmployeeNum", "WFLUID", "RouteToCompNum", "RouteToEmpNum", "From", "Until")

                    If (Not IsNull(objData)) Then

                        RouteID = objData(0)

                        If (IsNumeric(objData(3))) Then WFLUID = Convert.ToInt32(objData(3))

                        If (IsDate(objData(6))) Then dteStart = objData(6)

                        If (IsDate(objData(7))) Then dteUntil = objData(7)

                        Dim dtRows As DataTable = Nothing

                        Try

                            Dim SQL As String = "select top 1 [u].[CompanyNum], [u].[EmployeeNum], [Username], [p].[EMailAddress], [p].[PreferredName], [p].[FirstName], [p].[Surname] from [Users] as [u] left outer join [Personnel] as [p] on [u].[CompanyNum] = [p].[CompanyNum] and [u].[EmployeeNum] = [p].[EmployeeNum] where ([u].[CompanyNum] = '" & objData(4).ToString() & "' and [u].[EmployeeNum] = '" & objData(5).ToString() & "') order by [DefaultUser] desc"

                            objData = Nothing

                            objData = GetSQLFields(SQL)

                            If (Not IsNull(objData)) Then

                                SQL = "select [ID], [XMLTag] from [ess.Path] where (not [WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] in('Performance', 'Registration'))) and [WFLUID] > 0"

                                If (WFLUID > 0) Then SQL &= " and [WFLUID] = " & WFLUID.ToString()

                                If (IsDate(dteStart) AndAlso IsDate(dteUntil)) Then SQL &= " and [ActionDate] >= '" & dteStart.ToString("yyyy-MM-dd") & " 00:00:00' and [ActionDate] <= '" & dteUntil.ToString("yyyy-MM-dd") & " 23:59:59'"

                                SQL &= " and (not (select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start') and [ActionerUsername] = '" & UDetails.UserID & "' and ([Frozen] is null or [Frozen] = 0)))"

                                dtRows = GetSQLDT(SQL)

                                If (IsData(dtRows)) Then

                                    Dim bSaved As Boolean

                                    Dim PathID As Integer = 0

                                    Dim XMLData As String = String.Empty

                                    Dim FullName As String = String.Empty

                                    FullName = objData(6)

                                    If (Not String.IsNullOrEmpty(FullName)) Then

                                        If (String.IsNullOrEmpty(objData(4)) AndAlso Not String.IsNullOrEmpty(objData(5))) Then

                                            FullName = objData(5) & " " & objData(6)

                                        ElseIf (Not String.IsNullOrEmpty(objData(4))) Then

                                            FullName = objData(4) & " " & objData(6)

                                        End If

                                    Else

                                        FullName = String.Empty

                                    End If

                                    For i As Integer = 0 To (dtRows.Rows.Count - 1)

                                        With dtRows.Rows(i)

                                            PathID = .Item("ID")

                                            XMLData = .Item("XMLTag").ToString()

                                        End With

                                        SetXML(XMLData, "Routed", "True")

                                        SetXML(XMLData, "RouteID", RouteID)

                                        bSaved = ExecSQL("insert into [ess.WFAudit]([PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], [UserEmail], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [EmailOrigCC], [EmailOrigBCC], [EmailActCC], [EmailActBCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername], [UserCell], [OriginatorCell], [SMSCC], [SMSOrigCC], [SMSActCC]) select top 1 [PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], '" & objData(3).ToString() & "', [WFID], '" & GetDataText(FullName.ToString()) & "', '" & objData(0) & "', '" & objData(1) & "', '" & GetDataText(objData(2)) & "', [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [EmailOrigCC], [EmailOrigBCC], [EmailActCC], [EmailActBCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername], [UserCell], [OriginatorCell], [SMSCC], [SMSOrigCC], [SMSActCC] from [ess.WFAudit] where ([PathID] = " & PathID.ToString() & ") order by [ID] desc")

                                        If (bSaved) Then bSaved = ExecSQL("update [ess.Path] set [UserEmail] = '" & objData(3).ToString() & "', [Actioner] = '" & GetDataText(FullName.ToString()) & "', [ActionerCompanyNum] = '" & objData(0) & "', [ActionerEmployeeNum] = '" & objData(1) & "', [ActionerUsername] = '" & GetDataText(objData(2)) & "', [XMLTag] = '" & XMLData & "' where ([ID] = " & PathID.ToString() & ")")

                                        If (bSaved) Then

                                            ExecNotify(PathID.ToString())

                                        Else

                                            Exit For

                                        End If

                                    Next

                                    If (bSaved) Then bSaved = ExecSQL("delete from [ess.RoutingRules] where ([ID] = " & RouteID.ToString() & ")")

                                End If

                            End If

                        Catch ex As Exception

                        Finally

                            If (Not IsNull(dtRows)) Then

                                dtRows.Dispose()

                                dtRows = Nothing

                            End If

                        End Try

                        objData = Nothing

                    End If

                End If

        End Select

        e.Result = ReturnText

    End Sub

    Private Sub dgView_CellEditorInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs) Handles dgView.CellEditorInitialize

        If (Not sender.IsEditing OrElse Not e.Column.FieldName = "RouteToEmpNum") Then Return

        Dim combo As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (sender.IsEditing AndAlso Not sender.IsNewRowEditing) Then

            If (IsNull(e.KeyValue)) Then Return

            Dim val As String = sender.GetRowValuesByKeyValue(e.KeyValue, "RouteToCompNum")

            If (val Is DBNull.Value) Then Return

            FillComboBox(combo, val)

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

            If (IsNumeric(combo.Value)) Then Session("routeEmployeeNum") = combo.Value

        ElseIf (sender.IsEditing AndAlso sender.IsNewRowEditing) Then

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        End If

    End Sub

    Private Sub dgView_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView.CustomButtonInitialize

        If (e.Column.Name = "submit") Then

            If (sender.GetRowValues(e.VisibleIndex, "OnceOff")) Then

                e.Visible = DevExpress.Utils.DefaultBoolean.True

            Else

                e.Visible = DevExpress.Utils.DefaultBoolean.False

            End If

        End If

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView.RowInserting

        Dim SQLAudit As String = String.Empty

        e.NewValues("CompanyNum") = Session("Managed").CompanyNum

        e.NewValues("EmployeeNum") = Session("Managed").EmployeeNum

        e.NewValues("CapturedBy") = UDetails.UserID

        e.NewValues("CapturedOn") = Now

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (IsNull(e.OldValues("CompanyNum"))) Then e.NewValues("CompanyNum") = Session("Managed").CompanyNum

        If (IsNull(e.OldValues("EmployeeNum"))) Then e.NewValues("EmployeeNum") = Session("Managed").EmployeeNum

        If (IsNull(e.OldValues("CapturedBy"))) Then e.NewValues("CapturedBy") = UDetails.UserID

        If (IsNull(e.OldValues("CapturedOn"))) Then e.NewValues("CapturedOn") = Now

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView.RowValidating

        If (IsNull(e.OldValues("CompanyNum"))) Then e.NewValues("CompanyNum") = Session("Managed").CompanyNum

        If (IsNull(e.OldValues("EmployeeNum"))) Then e.NewValues("EmployeeNum") = Session("Managed").EmployeeNum

        If (IsNull(e.OldValues("CapturedBy"))) Then e.NewValues("CapturedBy") = UDetails.UserID

        If (IsNull(e.OldValues("CapturedOn"))) Then e.NewValues("CapturedOn") = Now

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

#End Region

End Class