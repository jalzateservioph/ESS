Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxHiddenField

Partial Public Class workflowman_001
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

    Private dtRows() As DataRow = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            Dim pgControl As Control = Nothing

            Dim dgView As ASPxGridView = Nothing

            Try

                pgControl = sender.FindEditFormTemplateControl("pageControl_001")

                e.NewValues("WFLUID") = Session("WFLUID")

                e.NewValues("LockedBy") = Session("LoggedOn").UserID

                If (e.NewValues("SkipNonExt") = Nothing) Then e.NewValues("SkipNonExt") = False

                If (e.NewValues("ExecNonProc") = Nothing) Then e.NewValues("ExecNonProc") = False

                e.NewValues("EmailID") = GetExpControl(sender, "cmbEmail_003", "Value", False)

                If (e.NewValues("EmailID") = 0) Then e.NewValues("EmailID") = Nothing

                e.NewValues("SMSID") = GetExpControl(sender, "cmbSMS_003", "Value", False)

                If (e.NewValues("SMSID") = 0) Then e.NewValues("SMSID") = Nothing

                e.NewValues("EmailOrigID") = GetExpControl(sender, "cmbEmail_004", "Value", False)

                If (e.NewValues("EmailOrigID") = 0) Then e.NewValues("EmailOrigID") = Nothing

                e.NewValues("SMSOrigID") = GetExpControl(sender, "cmbSMS_004", "Value", False)

                If (e.NewValues("SMSOrigID") = 0) Then e.NewValues("SMSOrigID") = Nothing

                e.NewValues("EmailActID") = GetExpControl(sender, "cmbEmail_005", "Value", False)

                If (e.NewValues("EmailActID") = 0) Then e.NewValues("EmailActID") = Nothing

                e.NewValues("SMSActID") = GetExpControl(sender, "cmbSMS_005", "Value", False)

                If (e.NewValues("SMSActID") = 0) Then e.NewValues("SMSActID") = Nothing

                If (Not IsNull(pgControl)) Then

                    dgView = TryCast(pgControl.FindControl("dgView_002"), ASPxGridView)

                    If (Not IsNull(dgView)) Then e.NewValues("AccessibleBy") = GetRoles(dgView)

                    dgView = TryCast(pgControl.FindControl("dgView_003"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        e.NewValues("EmailCC") = GetRoles(dgView, "EmailCC")

                        e.NewValues("EmailBCC") = GetRoles(dgView, "EmailBCC")

                        e.NewValues("SMSCC") = GetRoles(dgView, "SMSCC")

                    End If

                    dgView = TryCast(pgControl.FindControl("dgView_004"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        e.NewValues("EmailOrigCC") = GetRoles(dgView, "EmailOrigCC")

                        e.NewValues("EmailOrigBCC") = GetRoles(dgView, "EmailOrigBCC")

                        e.NewValues("SMSOrigCC") = GetRoles(dgView, "SMSOrigCC")

                    End If

                    dgView = TryCast(pgControl.FindControl("dgView_005"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        e.NewValues("EmailActCC") = GetRoles(dgView, "EmailActCC")

                        e.NewValues("EmailActBCC") = GetRoles(dgView, "EmailActBCC")

                        e.NewValues("SMSActCC") = GetRoles(dgView, "SMSActCC")

                    End If

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(dgView)) Then

                    dgView.Dispose()

                    dgView = Nothing

                End If

                If (Not IsNull(pgControl)) Then

                    pgControl.Dispose()

                    pgControl = Nothing

                End If

            End Try

        End If

    End Sub

    Private Function GetRoles(ByRef dgView As ASPxGridView, Optional ByVal Type As String = "") As String

        Dim Roles As String = Nothing

        Dim items As ASPxHiddenField = Nothing

        Dim ItemKey As String = String.Empty

        Try

            If (Type.Length > 0) Then items = TryCast(FindControl(dgView.ID.ToString().Replace("dgView", "items")), ASPxHiddenField)

            For iLoop As Integer = 0 To (dgView.VisibleRowCount - 1)

                If (Type.Length = 0) Then

                    If (dgView.Selection.IsRowSelected(iLoop)) Then Roles &= Convert.ToString(Chr(dgView.GetRowValues(iLoop, "CompositeKey")))

                ElseIf (Not IsNull(items)) Then

                    ItemKey = dgView.ID.ToString() & "_" & Type & "_" & iLoop.ToString()

                    If (items.Contains(ItemKey)) Then

                        If (items.Get(ItemKey)) Then Roles &= Convert.ToString(Chr(dgView.GetRowValues(iLoop, "CompositeKey")))

                    End If

                End If

            Next

        Catch ex As Exception

        Finally

            If (Not IsNull(items)) Then

                items.Dispose()

                items = Nothing

            End If

        End Try

        Return Roles

    End Function

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache OrElse Not IsPostBack) Then ClearFromCache("Data.Workflow.Processes." & Session.SessionID)

        If (ClearCache) Then

            ClearFromCache("Data.Workflow.Setup")

            ClearFromCache("Data.Workflow.Processes.Setup")

            ClearFromCache("Data.Workflow.Processes.Accessible.Setup")

            ClearFromCache("Data.Workflow.Processes.ActionLU.Setup")

        End If

        LoadExpDS(dsActionLU, "select [ID], [ReportsToType] from [ess.ActionLU] order by [ReportsToType]")

        LoadExpDS(dsEmailLU, "select 0 as [EmailID], '<select>' as [Type] union select [ID], [Type] from [EmailLU] order by [Type]")

        LoadExpDS(dsProcessLU, "select [ID], ((select [ReportsToType] from [ess.ActionLU] where ([ID] = [ess.WF].[ActionID])) + ', ' + (select [Status] from [ess.StatusLU] where ([ID] = [ess.WF].[StatusID]))) as [Process] from [ess.WF] where ([WFLUID] = " & Session("WFLUID") & ") order by [Process]")

        LoadExpDS(dsProcessPProcLU, "select [Proc] from [ess.WFProcLU] where ([TypeID] in (select [ID] from [ess.WFTypeLU] where ([WFType] = '" & Session("WFType") & "'))) order by [Proc]")

        LoadExpDS(dsProcessResultLU, "select [ID], [PostActionType] from [ess.PALU] order by [PostActionType]")

        LoadExpDS(dsProcessRoleLU, "select [ID], [ReportsToType] from [ess.ActionLU] where ([ReportsToType] in(select distinct [ReportsToType] from [ReportsTo]) and not [ReportsToType] in('Dummy', 'Start')) order by [ReportsToType]")

        LoadExpDS(dsProcessTProcLU, "select [Task] from [ess.WFTaskLU] where ([TypeID] in (select [ID] from [ess.WFTypeLU] where ([WFType] = '" & Session("WFType") & "'))) order by [Task]")

        LoadExpDS(dsSMSLU, "select 0 as [ID], '<select>' as [Type] union select [ID], [Type] from [MessagingLU] order by [Type]")

        LoadExpDS(dsStatusLU, "select [ID], [Status] from [ess.StatusLU] order by [Status]")

        LoadExpGrid(Session, dgView_001, "Workflow Manager", "<Tablename=ess.WF><PrimaryKey=[ID]><Columns=[ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc], [TaskIDProc], [LockedBy], [EmailID], [SMSID], [EmailOrigID], [SMSOrigID], [EmailActID], [SMSActID]><Where=([WFLUID] = " & Session("WFLUID") & ")>", "Data.Workflow.Processes." & Session.SessionID)

    End Sub

    Private Sub LoadSubData(Optional ByVal ClearCache As Boolean = False)

        Dim pgControl As Control = Nothing

        Dim dgView As ASPxGridView = Nothing

        Try

            pgControl = dgView_001.FindEditFormTemplateControl("pageControl_001")

            If (Not IsNull(pgControl)) Then

                dgView = TryCast(pgControl.FindControl("dgView_002"), ASPxGridView)

                If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Select=distinct><Tablename=ReportsTo><Join=[{%Tablename%}] as [r] left outer join [ess.ActionLU] as [e] on [r].[ReportsToType] = [e].[ReportsToType]><PrimaryKey=[e].[ID]><Columns=[r].[ReportsToType]>", "Data.Workflow.Processes.Accessible.Setup")

                dgView = TryCast(pgControl.FindControl("dgView_003"), ASPxGridView)

                If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Select=distinct><Tablename=ReportsTo><Join=[{%Tablename%}] as [r] left outer join [ess.ActionLU] as [e] on [r].[ReportsToType] = [e].[ReportsToType]><PrimaryKey=[e].[ID]><Columns=[r].[ReportsToType], 0 as [CC], 0 as [BCC], 0 as [SMS]>", "Data.Workflow.Processes.ActionLU.Setup")

                dgView = TryCast(pgControl.FindControl("dgView_004"), ASPxGridView)

                If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Select=distinct><Tablename=ReportsTo><Join=[{%Tablename%}] as [r] left outer join [ess.ActionLU] as [e] on [r].[ReportsToType] = [e].[ReportsToType]><PrimaryKey=[e].[ID]><Columns=[r].[ReportsToType], 0 as [CC], 0 as [BCC], 0 as [SMS]>", "Data.Workflow.Processes.ActionLU.Setup")

                dgView = TryCast(pgControl.FindControl("dgView_005"), ASPxGridView)

                If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Workflow Manager", "<Select=distinct><Tablename=ReportsTo><Join=[{%Tablename%}] as [r] left outer join [ess.ActionLU] as [e] on [r].[ReportsToType] = [e].[ReportsToType]><PrimaryKey=[e].[ID]><Columns=[r].[ReportsToType], 0 as [CC], 0 as [BCC], 0 as [SMS]>", "Data.Workflow.Processes.ActionLU.Setup")

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(pgControl)) Then

                pgControl.Dispose()

                pgControl = Nothing

            End If

        End Try

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then CType(pnlWorkflow.FindControl("lblPanel"), ASPxLabel).Text = "Workflow Process Management: (" & Session("WFType") & ") - " & Session("WFName")

        UDetails = GetUserDetails(Session, "Workflow Manager")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Back") Then e.Result = "workflow.aspx?TabID=2 tools/index.aspx"

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Protected Sub dgView_001_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim dtWFProcess As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim objValue As Object = Nothing

        Try

            dtWFProcess = GetSQLDT("select [ID], [AccessibleBy], [EmailID], [EmailCC], [EmailBCC], [EmailOrigID], [EmailOrigCC], [EmailOrigBCC], [EmailActID], [EmailActCC], [EmailActBCC], [SMSID], [SMSCC], [SMSOrigID], [SMSOrigCC], [SMSActID], [SMSActCC] from [ess.WF]", "Data.Workflow.Processes.Setup")

            If (IsData(dtWFProcess)) Then

                If (dgView_001.EditingRowVisibleIndex > -1) Then

                    dtRows = dtWFProcess.Select("[ID] = " & dgView_001.GetRowValues(dgView_001.EditingRowVisibleIndex, "CompositeKey"))

                    If (Not IsNull(dtRows)) Then

                        If (dtRows.GetLength(0) > 0) Then

                            Dim bClearSelection As Boolean

                            If (Not Session("Index" & sender.ID.ToString().Replace("dgView", String.Empty)) = dgView_001.EditingRowVisibleIndex) Then bClearSelection = True

                            If (bClearSelection) Then

                                Select Case sender.ID.ToString()

                                    Case "dgView_003"
                                        items_003.Clear()

                                    Case "dgView_004"
                                        items_004.Clear()

                                    Case "dgView_005"
                                        items_005.Clear()

                                End Select

                            End If

                            For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                                If (sender.ID.ToString() = "dgView_002") Then

                                    If (dtRows(0).Item("AccessibleBy").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then sender.Selection.SelectRow(iLoop)

                                ElseIf (sender.ID.ToString() = "dgView_003") Then

                                    objValue = False

                                    If (dtRows(0).Item("EmailCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_003.Contains(sender.ID.ToString() & "_EmailCC_" & iLoop.ToString())) Then

                                        items_003.Add(sender.ID.ToString() & "_EmailCC_" & iLoop.ToString(), objValue)

                                        'ElseIf (bClearSelection) Then

                                        '    items_003.Set(sender.ID.ToString() & "_EmailCC_" & iLoop.ToString(), objValue)

                                    End If

                                    objValue = False

                                    If (dtRows(0).Item("EmailBCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_003.Contains(sender.ID.ToString() & "_EmailBCC_" & iLoop.ToString())) Then items_003.Add(sender.ID.ToString() & "_EmailBCC_" & iLoop.ToString(), objValue)

                                    objValue = False

                                    If (dtRows(0).Item("SMSCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_003.Contains(sender.ID.ToString() & "_SMSCC_" & iLoop.ToString())) Then items_003.Add(sender.ID.ToString() & "_SMSCC_" & iLoop.ToString(), objValue)

                                ElseIf (sender.ID.ToString() = "dgView_004") Then

                                    objValue = False

                                    If (dtRows(0).Item("EmailOrigCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_004.Contains(sender.ID.ToString() & "_EmailOrigCC_" & iLoop.ToString())) Then items_004.Add(sender.ID.ToString() & "_EmailOrigCC_" & iLoop.ToString(), objValue)

                                    objValue = False

                                    If (dtRows(0).Item("EmailOrigBCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_004.Contains(sender.ID.ToString() & "_EmailOrigBCC_" & iLoop.ToString())) Then items_004.Add(sender.ID.ToString() & "_EmailOrigBCC_" & iLoop.ToString(), objValue)

                                    objValue = False

                                    If (dtRows(0).Item("SMSOrigCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_004.Contains(sender.ID.ToString() & "_SMSOrigCC_" & iLoop.ToString())) Then items_004.Add(sender.ID.ToString() & "_SMSOrigCC_" & iLoop.ToString(), objValue)

                                ElseIf (sender.ID.ToString() = "dgView_005") Then

                                    objValue = False

                                    If (dtRows(0).Item("EmailActCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_005.Contains(sender.ID.ToString() & "_EmailActCC_" & iLoop.ToString())) Then items_005.Add(sender.ID.ToString() & "_EmailActCC_" & iLoop.ToString(), objValue)

                                    objValue = False

                                    If (dtRows(0).Item("EmailActBCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_005.Contains(sender.ID.ToString() & "_EmailActBCC_" & iLoop.ToString())) Then items_005.Add(sender.ID.ToString() & "_EmailActBCC_" & iLoop.ToString(), objValue)

                                    objValue = False

                                    If (dtRows(0).Item("SMSActCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(iLoop, "CompositeKey").ToString())))) Then objValue = True

                                    If (Not items_005.Contains(sender.ID.ToString() & "_SMSActCC_" & iLoop.ToString())) Then items_005.Add(sender.ID.ToString() & "_SMSActCC_" & iLoop.ToString(), objValue)

                                End If

                            Next

                            If (sender.ID.ToString() = "dgView_003" OrElse sender.ID.ToString() = "dgView_004" OrElse sender.ID.ToString() = "dgView_005") Then

                                If (Not Session("Index" & sender.ID.ToString().Replace("dgView", String.Empty)) = dgView_001.EditingRowVisibleIndex) Then Session("Index" & sender.ID.ToString().Replace("dgView", String.Empty)) = dgView_001.EditingRowVisibleIndex

                            End If

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(objValue)) Then objValue = Nothing

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtWFProcess)) Then

                dtWFProcess.Dispose()

                dtWFProcess = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_001_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs)

        If (e.RowType = GridViewRowType.Data) Then

            If (sender.ID.ToString() = "dgView_003" OrElse sender.ID.ToString() = "dgView_004" OrElse sender.ID.ToString() = "dgView_005") Then

                If (IsNull(dtRows)) Then

                    Dim dtWFProcess As DataTable = Nothing

                    Try

                        dtWFProcess = GetSQLDT("select [ID], [AccessibleBy], [EmailID], [EmailCC], [EmailBCC], [EmailOrigID], [EmailOrigCC], [EmailOrigBCC], [EmailActID], [EmailActCC], [EmailActBCC], [SMSID], [SMSCC], [SMSOrigID], [SMSOrigCC], [SMSActID], [SMSActCC] from [ess.WF]", "Data.Workflow.Processes.Setup")

                        If (IsData(dtWFProcess)) Then

                            If (dgView_001.EditingRowVisibleIndex >= 0) Then dtRows = dtWFProcess.Select("[ID] = " & dgView_001.GetRowValues(dgView_001.EditingRowVisibleIndex, "CompositeKey"))

                        End If

                    Catch ex As Exception

                    Finally

                        If (Not IsNull(dtWFProcess)) Then

                            dtWFProcess.Dispose()

                            dtWFProcess = Nothing

                        End If

                    End Try

                End If

                Dim pgControl As Control = Nothing

                Dim items As ASPxHiddenField = Nothing

                Dim chkCC As ASPxCheckBox = Nothing

                Dim chkBCC As ASPxCheckBox = Nothing

                Dim chkSMS As ASPxCheckBox = Nothing

                Dim objValue As Object = False

                Dim ItemKey As String = String.Empty

                Dim KeyType As String = String.Empty

                Select Case sender.ID.ToString()

                    Case "dgView_004"
                        KeyType = "Orig"

                    Case "dgView_005"
                        KeyType = "Act"

                End Select

                Try

                    pgControl = dgView_001.FindEditFormTemplateControl("pageControl_001")

                    If (Not IsNull(pgControl) AndAlso Not IsNull(dtRows)) Then

                        items = TryCast(FindControl(sender.ID.ToString().Replace("dgView", "items")), ASPxHiddenField)

                        If (Not IsNull(items)) Then

                            chkCC = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("CC"), GridViewDataColumn), "chkCC"), ASPxCheckBox)

                            chkBCC = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("BCC"), GridViewDataColumn), "chkBCC"), ASPxCheckBox)

                            chkSMS = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("SMS"), GridViewDataColumn), "chkSMS"), ASPxCheckBox)

                            If (Not IsNull(chkCC)) AndAlso (Not IsNull(chkBCC)) AndAlso (Not IsNull(chkSMS)) Then

                                ItemKey = sender.ID.ToString() & "_Email" & KeyType & "CC_" & e.VisibleIndex.ToString()

                                chkCC.ClientInstanceName = ItemKey

                                objValue = chkCC.Checked

                                If (dtRows(0).Item("Email" & KeyType & "CC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString())))) Then objValue = True

                                If (items.Contains(ItemKey)) Then

                                    objValue = items.Get(ItemKey)

                                Else

                                    items.Add(ItemKey, objValue)

                                End If

                                chkCC.Checked = objValue

                                chkCC.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "', s.GetChecked()); }"

                                objValue = False

                                ItemKey = sender.ID.ToString() & "_Email" & KeyType & "BCC_" & e.VisibleIndex.ToString()

                                chkBCC.ClientInstanceName = ItemKey

                                objValue = chkBCC.Checked

                                If (dtRows(0).Item("Email" & KeyType & "BCC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString())))) Then objValue = True

                                If (items.Contains(ItemKey)) Then

                                    objValue = items.Get(ItemKey)

                                Else

                                    items.Add(ItemKey, objValue)

                                End If

                                chkBCC.Checked = objValue

                                chkBCC.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "', s.GetChecked()); }"

                                objValue = False

                                ItemKey = sender.ID.ToString() & "_SMS" & KeyType & "CC_" & e.VisibleIndex.ToString()

                                chkSMS.ClientInstanceName = ItemKey

                                objValue = chkSMS.Checked

                                If (dtRows(0).Item("SMS" & KeyType & "CC").ToString().Contains(Convert.ToString(Chr(sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString())))) Then objValue = True

                                If (items.Contains(ItemKey)) Then

                                    objValue = items.Get(ItemKey)

                                Else

                                    items.Add(ItemKey, objValue)

                                End If

                                chkSMS.Checked = objValue

                                chkSMS.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "', s.GetChecked()); }"

                            End If

                        End If

                    End If

                Catch ex As Exception

                Finally

                    If (Not IsNull(objValue)) Then objValue = Nothing

                    If (Not IsNull(chkSMS)) Then

                        chkSMS.Dispose()

                        chkSMS = Nothing

                    End If

                    If (Not IsNull(chkBCC)) Then

                        chkBCC.Dispose()

                        chkBCC = Nothing

                    End If

                    If (Not IsNull(chkCC)) Then

                        chkCC.Dispose()

                        chkCC = Nothing

                    End If

                    If (Not IsNull(items)) Then

                        items.Dispose()

                        items = Nothing

                    End If

                    If (Not IsNull(pgControl)) Then

                        pgControl.Dispose()

                        pgControl = Nothing

                    End If

                End Try

            End If

        ElseIf (e.RowType = GridViewRowType.EditForm AndAlso sender.Equals(dgView_001)) Then

            If (e.VisibleIndex = sender.EditingRowVisibleIndex) Then LoadSubData()

        End If

    End Sub

    Private Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting

        Dim SQLAudit As String = String.Empty

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating

        Dim SQLAudit As String = String.Empty

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating

        GetExpValues(sender, e)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

#End Region

End Class