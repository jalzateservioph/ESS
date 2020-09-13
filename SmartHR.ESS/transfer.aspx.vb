Public Class transfer
    Inherits System.Web.UI.Page

#Region " *** Web Form Functions *** "

    Private Sub LoadData()

        LoadExpDS(dsTransfer, "select distinct [TransferReason] from [Personnel] order by [TransferReason]")

        Dim UserGroup As String = String.Empty

        If (Not IsNull(Session("LoggedOn"))) Then

            UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

            If (Not IsNull(UserGroup)) Then

                dgView.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                dgView.DataBind()

            End If

        End If

        If (Not dteTransfer.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteTransfer.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteTransfer.EditFormatString = GetArrayItem(Nothing, "eGeneral.DateFormat")

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

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim iIndex As Integer = 0

            Dim bSaved As Boolean

            Dim SQL As String = String.Empty

            Dim CompanyNum As String = String.Empty

            Dim EmployeeNum As String = String.Empty

            Dim CostCentre As Object = Nothing

            Dim objEmpData() As Object = Nothing

            Dim objItems As DataTable = Nothing

            Try

                For Each objKey As Object In dgView.GetSelectedFieldValues("Value")

                    CompanyNum = objKey.ToString().Split(" ")(0)

                    EmployeeNum = objKey.ToString().Split(" ")(1)

                    If (IsNull(GetSQLField("select [CompanyNum] from [Personnel] where ([CompanyNum] = '" & Session("NodeValue") & "' and [EmployeeNum] = '" & EmployeeNum & "')", "CompanyNum"))) Then

                        objEmpData = GetSQLFields("select [emp].[JobTitle], [emp].[JobGrade], [emp1].[JobGradeBand], [emp].[DeptName], [emp].[CostCentre], [emp1].[ShiftType], [emp1].[Location] from [Personnel] as [emp] left outer join [Personnel1] as [emp1] on [emp].[CompanyNum] = [emp1].[CompanyNum] and [emp].[EmployeeNum] = [emp1].[EmployeeNum] where ([emp].[CompanyNum] = '" & CompanyNum & "' and [emp].[EmployeeNum] = '" & EmployeeNum & "')")

                        If (Not IsNull(objEmpData)) Then

                            Dim TransferDate As Date = New Date(dteTransfer.Date.Year, dteTransfer.Date.Month, dteTransfer.Date.Day)

                            bSaved = ExecSQL("update [Personnel] set [TransferDate] = '" & TransferDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [TransferReason] = " & GetNullText(cmbReason.Value) & ", [Status] = 'New', [PathID] = null where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

                            iIndex = 0

                            bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [JobTitle] where ([CompanyNum] = ''<CompanyNum>'' and [JobTitle] = ''<JobTitle>'')) insert into [JobTitle]([CompanyNum], [JobTitle], [Description], [Position]) select ''<CompanyNum>'', ''<JobTitle>'', [Description], [Position] from [JobTitle] where ([CompanyNum] = ''<OldCompanyNum>'' and [JobTitle] = ''<JobTitle>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><JobTitle=" & objEmpData(0).ToString() & ">', 'New')")

                            iIndex += 1

                            bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [JobGrade] where ([CompanyNum] = ''<CompanyNum>'' and [JobGrade] = ''<JobGrade>'')) insert into [JobGrade]([CompanyNum], [JobGrade], [Description], [Rate], [RateMin], [RateMax], [GradeBand]) select ''<CompanyNum>'', ''<JobGrade>'', [Description], [Rate], [RateMin], [RateMax], [GradeBand] from [JobGrade] where ([CompanyNum] = ''<OldCompanyNum>'' and [JobGrade] = ''<JobGrade>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><JobGrade=" & objEmpData(1).ToString() & ">', 'New')")

                            iIndex += 1

                            bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [JobGradeBandLU] where ([CompanyNum] = ''<CompanyNum>'' and [JobGradeBand] = ''<JobGradeBand>'')) insert into [JobGradeBandLU]([CompanyNum], [JobGradeBand]) values(''<CompanyNum>'', ''<JobGradeBand>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><JobGradeBand=" & objEmpData(2).ToString() & ">', 'New')")

                            objItems = GetSQLDT("select [ItemCode] from [StoresItems] where ([CompanyNum] = '" & CompanyNum & "' and [ItemCode] in(select [ItemCode] from [StoreIssued] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')))")

                            If (IsData(objItems)) Then

                                For i As Integer = 0 To (objItems.Rows.Count - 1)

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [StoresItems] where ([CompanyNum] = ''<CompanyNum>'' and [ItemCode] = ''<ItemCode>'')) insert into [StoresItems]([CompanyNum], [ItemCode], [ItemDescription], [Stock], [Value], [Location], [Category]) select ''<CompanyNum>'', ''<ItemCode>'', [ItemDescription], [Stock], [Value], [Location], [Category] from [StoresItems] where ([CompanyNum] = ''<OldCompanyNum>'' and [ItemCode] = ''<ItemCode>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><ItemCode=" & objItems.Rows(i).Item("ItemCode").ToString() & ">', 'New')")

                                Next

                                objItems.Dispose()

                                objItems = Nothing

                            End If

                            objItems = GetSQLDT("select [TeamNum] from [Team] where ([CompanyNum] = '" & CompanyNum & "' and [TeamNum] in(select [TeamNum] from [TeamMembership] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')))")

                            If (IsData(objItems)) Then

                                For i As Integer = 0 To (objItems.Rows.Count - 1)

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [Team] where ([CompanyNum] = ''<CompanyNum>'' and [TeamNum] = ''<TeamNum>'')) insert into [Team]([CompanyNum], [TeamNum], [TeamName], [TeamLeader]) select ''<CompanyNum>'', ''<TeamNum>'', [TeamName], [TeamLeader] from [Team] where ([CompanyNum] = ''<OldCompanyNum>'' and [TeamNum] = ''<TeamNum>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><TeamNum=" & objItems.Rows(i).Item("TeamNum").ToString() & ">', 'New')")

                                Next

                                objItems.Dispose()

                                objItems = Nothing

                            End If

                            If (Not IsNull(objEmpData(3))) Then

                                CostCentre = GetSQLField("select [CostCentre] from [Department] where ([CompanyNum] = '" & CompanyNum & "' and [DeptName] = '" & objEmpData(3).ToString() & "')", "CostCentre")

                                If (Not IsNull(CostCentre)) Then

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [CostCentreLU] where ([CompanyNum] = ''<CompanyNum>'' and [CostCentre] = ''<CostCentre>'')) insert into [CostCentreLU]([CompanyNum], [CostCentre]) values(''<CompanyNum>'', ''<CostCentre>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><CostCentre=" & CostCentre & ">', 'New')")

                                End If

                                iIndex += 1

                                bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [Department] where ([CompanyNum] = ''<CompanyNum>'' and [DeptName] = ''<DeptName>'')) insert into [Department]([CompanyNum], [DeptName], [DeptDescription], [ManagerName], [Budget], [CostCentre], [KPIDescription]) select ''<CompanyNum>'', ''<DeptName>'', [DeptDescription], [ManagerName], [Budget], [CostCentre], [KPIDescription] from [Department] where ([CompanyNum] = ''<OldCompanyNum>'' and [DeptName] = ''<DeptName>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><DeptName=" & objEmpData(3).ToString() & ">', 'New')")

                            End If

                            If (Not IsNull(objEmpData(4))) Then

                                iIndex += 1

                                bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [CostCentreLU] where ([CompanyNum] = ''<CompanyNum>'' and [CostCentre] = ''<CostCentre>'')) insert into [CostCentreLU]([CompanyNum], [CostCentre]) values(''<CompanyNum>'', ''<CostCentre>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><CostCentre=" & objEmpData(4).ToString() & ">', 'New')")

                            End If

                            If (Not IsNull(objEmpData(5))) Then

                                iIndex += 1

                                bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [ShiftTypeLU] where ([CompanyNum] = ''<CompanyNum>'' and [ShiftType] = ''<ShiftType>'')) insert into [ShiftTypeLU]([CompanyNum], [ShiftType]) values(''<CompanyNum>'', ''<ShiftType>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><ShiftType=" & objEmpData(5).ToString() & ">', 'New')")

                            End If

                            If (Not IsNull(objEmpData(6))) Then

                                iIndex += 1

                                bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [LocationLU] where ([CompanyNum] = ''<CompanyNum>'' and [Location] = ''<Location>'')) insert into [LocationLU]([CompanyNum], [Location]) values(''<CompanyNum>'', ''<Location>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><Location=" & objEmpData(6).ToString() & ">', 'New')")

                            End If

                            objItems = GetSQLDT("select [Location] from [LocationLU] where ([CompanyNum] = '" & CompanyNum & "' and [Location] in(select [Location] from [HSDetails] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')))")

                            If (IsData(objItems)) Then

                                For i As Integer = 0 To (objItems.Rows.Count - 1)

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [LocationLU] where ([CompanyNum] = ''<CompanyNum>'' and [Location] = ''<Location>'')) insert into [LocationLU]([CompanyNum], [Location]) values(''<CompanyNum>'', ''<Location>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><Location=" & objItems.Rows(i).Item("Location").ToString() & ">', 'New')")

                                Next

                                objItems.Dispose()

                                objItems = Nothing

                            End If

                            objItems = GetSQLDT("select [Committee] from [CommitteeLU] where ([CompanyNum] = '" & CompanyNum & "' and [Committee] in(select [Committee] from [CommitteeMembership] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')))")

                            If (IsData(objItems)) Then

                                For i As Integer = 0 To (objItems.Rows.Count - 1)

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'if not exists (select [CompanyNum] from [CommitteeLU] where ([CompanyNum] = ''<CompanyNum>'' and [Committee] = ''<Committee>'')) insert into [CommitteeLU]([CompanyNum], [Committee]) values(''<CompanyNum>'', ''<Committee>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & "><Committee=" & objItems.Rows(i).Item("Committee").ToString() & ">', 'New')")

                                Next

                                objItems.Dispose()

                                objItems = Nothing

                            End If

                            If (bSaved) Then

                                iIndex += 1

                                bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'update [Personnel] set [CompanyNum] = ''" & Session("NodeValue") & "'' where ([CompanyNum] = ''<OldCompanyNum>'' and [EmployeeNum] = ''<EmployeeNum>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & ">', 'New')")

                                If (bSaved) Then

                                    iIndex += 1

                                    bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'update [CompEmp] set [CompanyNum] = ''" & Session("NodeValue") & "'' where ([CompanyNum] = ''<OldCompanyNum>'' and [EmployeeNum] = ''<EmployeeNum>'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & ">', 'New')")

                                    If (bSaved) Then

                                        iIndex += 1

                                        bSaved = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & TransferDate.AddSeconds(iIndex).ToString("yyyy-MM-dd HH:mm:ss") & "', 'insert into [PersonnelHistoryLog]([CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedFrom], [ChangedTo], [ChangedBy]) values(''<CompanyNum>'', ''<EmployeeNum>'', ''Transfer'', ''" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'', ''Company : <OldCompanyNum>'', ''Company : <CompanyNum>'', ''" & Session("LoggedOn").UserID & "'')', '<OldCompanyNum=" & CompanyNum & "><CompanyNum=" & Session("NodeValue") & "><EmployeeNum=" & EmployeeNum & ">', 'New')")

                                        If (bSaved) Then

                                            SQL = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', 0, 'Transfers', 'Transfers', 'Start', 'Start', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "'"

                                            bSaved = ExecSQL(SQL)

                                        End If

                                    End If

                                End If

                            End If

                            If (Not bSaved) Then Exit For

                        End If

                    End If

                Next

            Catch ex As Exception

            Finally

                If (Not IsNull(objItems)) Then

                    objItems.Dispose()

                    objItems = Nothing

                End If

                If (Not IsNull(objEmpData)) Then objEmpData = Nothing

            End Try

            If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

        End If

    End Sub

#End Region

End Class