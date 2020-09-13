'TODO: v6.0.74 ENSURE WE FINALIZE THE BELOW ITEMS
'ShowReminder
'Adjustments
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView.Export
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class leave
    Inherits System.Web.UI.Page

    Private T1 As String = String.Empty
    Private T2 As String = String.Empty

    Private ShowBlocked As Boolean

    Private lInverse As String = String.Empty

    Private CancelEdit As Boolean
    Private Balances As String = String.Empty
    Private DurationType As String = String.Empty
    Private IsSelected As Boolean
    Private Remarks As String = String.Empty
    Private ResultText As String = String.Empty
    Private SelectedIndex As Integer = -1
    Private ShowCancel As Boolean
    Private ShowPopup As Boolean = False
    Private URL As String = String.Empty
    Private UDetails As Users = Nothing
    Private UserGroup As String = String.Empty
    Private Validated As Boolean
    Private ValidatedCancel As Boolean
    Private ValidatedCancelText As String = String.Empty
    Private ValidatedText As String = String.Empty

    Private Weekends() As Byte = Nothing

    Private pDays() As Date = Nothing

#Region " *** Web Form Functions *** "

    Private Function CalcDuration(Optional ByVal deStart As Date = Nothing, Optional ByVal deUntil As Date = Nothing) As Single

        If (Not IsDate(deStart)) Then deStart = calFrom.SelectedDate

        If (Not IsDate(deUntil)) Then deUntil = calUntil.SelectedDate

        Dim AddCalcShifts As Boolean
        Dim UseCalendar As Boolean
        Dim UseHours As Boolean
        Dim Shifts As String
        Dim ShiftTypes As String

        With UDetails

            Select Case lblDurationType.Text.ToLower()

                Case "hour(s)"
                    spnDuration.Value = CalculateLeave(UseCalendar, UseHours, 1, deStart:=deStart, deUntil:=deUntil)

                    'If (Not UseCalendar) Then MsgBoxASP("No calendar type has been set up for this employee thus resulting in public holidays not taken into account. The duration might therefor be incorrect.")

                    'If (Not UseHours) Then MsgBoxASP("No working hours have been set up for this employee thus calculating on the standard number of working hours per day.")

                Case "day(s)"
                    Dim ShiftType As String = GetSQLField("select [ShiftType] from [Personnel1] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')", "ShiftType")

                    Dim Use7DayWeek As Boolean = GetSQLField("select [Use7DayWeek] from [LeaveLU] where ([LeaveType] = '" & GetDataText(cmbLeaveType.Value) & "')", "Use7DayWeek")

                    spnDuration.Value = CalculateLeave(UseCalendar, UseHours, , Use7DayWeek, deStart:=deStart, deUntil:=deUntil, Shift:=ShiftType)

                    If (Not lInverse.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then

                        If (Not Use7DayWeek) Then

                            Shifts = GetArrayItem(.Template, "eLeave.ShiftTypes")

                            ShiftTypes = GetArrayItem(.Template, "eLeave.ShiftLeaveTypes")

                            If (Not IsNull(Shifts) AndAlso Not IsNull(ShiftTypes)) Then

                                Shifts = "'" & GetDataText(Shifts.Replace(", ", ",")).Replace(",", "', '") & "'"

                                ShiftTypes = "'" & GetDataText(ShiftTypes.Replace(", ", ",")).Replace(",", "', '") & "'"

                                If (Shifts.ToLower().Contains("'" & .ShiftType.ToString().ToLower() & "'") AndAlso ShiftTypes.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then AddCalcShifts = True

                            End If

                        End If

                        If (AddCalcShifts) Then

                            spnDuration.Enabled = False

                            spnDuration.Value = spnDuration.Value * 1.5

                        Else

                            spnDuration.Enabled = True

                        End If

                    End If

                    'If (Not UseCalendar) Then MsgBoxASP("No calendar type has been set up for this employee thus resulting in public holidays not taken into account. The duration might therefor be incorrect.")

                Case "week(s)"
                    spnDuration.Value = Convert.ToSingle(DateDiff(DateInterval.Weekday, deStart, deUntil))

                Case "month(s)"
                    spnDuration.Value = Math.Round(DateDiff(DateInterval.Day, deStart, deUntil) / 30.4375, 4).ToString()

            End Select

            If (lblDurationType.Text.ToLower() = "hour(s)") Then

                spnDuration.MinValue = 1

                spnDuration.MaxValue = spnDuration.Value

            Else

                If (GetArrayItem(UDetails.Template, "eLeave.QuarterDay")) Then

                    spnDuration.DecimalPlaces = 2

                    spnDuration.Increment = 0.25

                    spnDuration.MinValue = (spnDuration.Value - 0.75)

                    spnDuration.MaxValue = spnDuration.Value

                Else

                    spnDuration.MinValue = (spnDuration.Value - 0.5)

                    spnDuration.MaxValue = spnDuration.Value

                End If

            End If

            Return spnDuration.Value

        End With

    End Function

    Private Function CalculateLeave(ByRef UseCalendar As Boolean, ByRef UseHours As Boolean, Optional ByVal bType As Byte = 0, Optional ByVal Use7DayWeek As Boolean = False, Optional ByVal deStart As Date = Nothing, Optional ByVal deUntil As Date = Nothing, Optional ByVal Shift As String = "") As Single

        If (Not IsNull(Session("eLeave.Inverse"))) Then Session.Remove("eLeave.Inverse")

        If (Not IsDate(deStart)) Then deStart = calFrom.SelectedDate

        If (Not IsDate(deUntil)) Then deUntil = calUntil.SelectedDate

        Dim Duration As Single = DateDiff(DateInterval.Day, deStart, deUntil) + 1

        Dim dCalc As Single = 0

        Dim dtLoop As Date = deStart

        Dim dtPubHolidays As DataTable = Nothing

        Dim dtHours As DataTable = Nothing

        Dim dtDaysPerWeek As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim PublicDays As Single = 0

        With UDetails

            Try

                dtPubHolidays = GetSQLDT("select [c].[CalendarType], [PubHolDate] from [PersonnelPubHolCal] as [p] left outer join [PublicHoliday] as [c] on [p].[CalendarType] = [c].[CalendarType] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')", "Data.Leave.PubHolidays." & Session.SessionID)

                If (IsData(dtPubHolidays)) Then

                    UseCalendar = Convert.ToBoolean(dtPubHolidays.Rows.Count > 0)

                Else

                    UseCalendar = False

                End If

                dtHours = GetSQLDT("select count([ValidFrom]) as [Total] from [WorkingHours] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [ValidFrom] <= '" & deStart.ToString("yyyy-MM-dd") & "')")

                If (IsData(dtHours)) Then

                    UseHours = Convert.ToBoolean(dtHours.Rows(0).Item("Total") > 0)

                    dtHours.Dispose()

                Else

                    UseHours = False

                End If

                If (Not UseHours AndAlso IsString(Shift)) Then

                    dtHours = GetSQLDT("select coalesce([MonHrs], [TueHrs], [WedHrs], [ThuHrs], [FriHrs], [SatHrs], [SunHrs]) as [Total] from [ShiftTypeLU] where ([CompanyNum] = '" & .CompanyNum & "' and [ShiftType] = '" & Shift & "')")

                    If (IsData(dtHours)) Then

                        If (Not IsNull(dtHours.Rows(0).Item("Total"))) Then UseHours = Convert.ToBoolean(dtHours.Rows(0).Item("Total") > 0)

                        dtHours.Dispose()

                    End If

                End If

                dtHours = Nothing

                If (UseHours) Then

                    Duration = 0

                    Dim CalcPublic As Boolean

                    While (dtLoop <= deUntil)

                        If (Use7DayWeek) Then

                            Duration += 1

                        Else

                            dtHours = GetSQLDT("select top 1 [" & dtLoop.ToString("ddd") & "Hrs] as [TotalHrs] from [WorkingHours] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [ValidFrom] <= '" & dtLoop.ToString("yyyy-MM-dd") & "') order by [ValidFrom] desc")

                            If (Not IsData(dtHours) AndAlso IsString(Shift)) Then dtHours = GetSQLDT("select top 1 [" & dtLoop.ToString("ddd") & "Hrs] as [TotalHrs] from [ShiftTypeLU] where ([CompanyNum] = '" & .CompanyNum & "' and [ShiftType] = '" & Shift & "')")

                            CalcPublic = False

                            If (UseCalendar OrElse bType = 1) Then

                                dtRows = dtPubHolidays.Select("[PubHolDate] = '" & dtLoop.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                                If (Not IsNull(dtRows)) Then

                                    If (dtRows.GetLength(0) = 1) Then CalcPublic = True

                                End If

                            End If

                            If (IsData(dtHours)) Then

                                With dtHours.Rows(0)

                                    If (Not IsNull(.Item("TotalHrs"))) Then

                                        If (bType = 0) Then

                                            If (.Item("TotalHrs") > 0) Then

                                                If (CalcPublic) Then PublicDays += 1

                                                Duration += 1

                                            Else

                                                dCalc += 1

                                            End If

                                        ElseIf (bType = 1) Then

                                            If (.Item("TotalHrs") > 0) Then

                                                If (CalcPublic) Then PublicDays += .Item("TotalHrs")

                                                Duration += .Item("TotalHrs")

                                            End If

                                        End If

                                    ElseIf (bType = 0) Then

                                        dCalc += 1

                                    End If

                                End With

                            ElseIf (bType = 0) Then

                                dCalc += 1

                            End If

                        End If

                        dtLoop = dtLoop.AddDays(1)

                    End While

                    If (lInverse.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then

                        If (Duration > 0) Then Session("eLeave.Inverse") = True

                        Duration = dCalc + PublicDays

                    Else

                        Duration = (Duration - PublicDays)

                    End If

                Else

                    dtDaysPerWeek = GetSQLDT("select [DaysPerWeek] from [Personnel1] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')")

                    dtRows = dtPubHolidays.Select("[PubHolDate] >= '" & Convert.ToDateTime(deStart).ToString("yyyy-MM-dd HH:mm:ss") & "' and [PubHolDate] <= '" & Convert.ToDateTime(deUntil).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                    If (Not IsNull(dtRows)) Then

                        If (dtRows.GetLength(0) > 0) Then

                            Dim dtPubDay As Date

                            For iLoop As Integer = 0 To (dtRows.GetLength(0) - 1)

                                dtPubDay = Convert.ToDateTime(dtRows(iLoop).Item("PubHolDate"))

                                If (Not dtPubDay.DayOfWeek = DayOfWeek.Saturday AndAlso Not dtPubDay.DayOfWeek = DayOfWeek.Sunday) Then

                                    PublicDays += 1

                                ElseIf (IsData(dtDaysPerWeek)) Then

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 5.5 AndAlso dtPubDay.DayOfWeek = DayOfWeek.Saturday) Then PublicDays += 0.5

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 6 AndAlso dtPubDay.DayOfWeek = DayOfWeek.Saturday) Then PublicDays += 1

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 7 AndAlso dtPubDay.DayOfWeek = DayOfWeek.Sunday) Then PublicDays += 1

                                End If

                            Next

                        End If

                    End If

                    Dim Saturdays As Integer
                    Dim Sundays As Integer

                    While (dtLoop <= deUntil)

                        If (dtLoop.DayOfWeek = DayOfWeek.Saturday) Then Saturdays += 1

                        If (dtLoop.DayOfWeek = DayOfWeek.Sunday) Then Sundays += 1

                        dtLoop = dtLoop.AddDays(1)

                    End While

                    Duration = Duration - PublicDays - Saturdays - Sundays

                    If (Use7DayWeek) Then

                        Duration += (Saturdays + Sundays + PublicDays)

                    Else

                        If (IsData(dtDaysPerWeek)) Then

                            If (Not IsNull(dtDaysPerWeek.Rows(0).Item("DaysPerWeek"))) Then

                                If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 5.5) Then

                                    Saturdays *= 0.5

                                    Duration += Saturdays

                                ElseIf (GetArrayItem(.Template, "eLeave.SaturdayRule")) Then

                                    Saturdays *= 0.5

                                    Duration += Saturdays

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 7) Then Duration += Sundays

                                Else

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 6) Then Duration += Saturdays

                                    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 7) Then Duration += Saturdays + Sundays

                                End If

                            ElseIf (GetArrayItem(.Template, "eLeave.SaturdayRule")) Then

                                Saturdays *= 0.5

                                Duration += Saturdays

                            End If

                        End If

                        If (lInverse.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then

                            If (Duration > 0) Then Session("eLeave.Inverse") = True

                            Duration = Saturdays + Sundays + PublicDays

                        End If

                    End If

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(dtRows)) Then dtRows = Nothing

                If (Not IsNull(dtDaysPerWeek)) Then

                    dtDaysPerWeek.Dispose()

                    dtDaysPerWeek = Nothing

                End If

                If (Not IsNull(dtHours)) Then

                    dtHours.Dispose()

                    dtHours = Nothing

                End If

                If (Not IsNull(dtPubHolidays)) Then

                    dtPubHolidays.Dispose()

                    dtPubHolidays = Nothing

                End If

            End Try

        End With

        Return Duration

    End Function

    Private Sub LoadData(ByVal Type1 As String, ByVal Type2 As String, Optional ByVal ClearCache As Boolean = False)

        Dim gridCols As String = Nothing

        If (Not IsNull(GetArrayItem(UDetails.Template, "eLeave.BalanceGridColumns"))) Then

            gridCols = ";" & GetArrayItem(UDetails.Template, "eLeave.BalanceGridColumns").ToString().Trim().ToLower().Replace(",", ";") & ";"

            gridCols = gridCols.Replace("; ", ";").Replace(" ;", ";")

            For iLoop As Integer = 0 To (dgView_001.Columns.Count - 1)

                If (gridCols.Contains(";" & dgView_001.Columns(iLoop).Caption.ToLower() & ";")) Then

                    If (dgView_001.Columns(iLoop).Visible) Then dgView_001.Columns(iLoop).Visible = False

                End If

            Next

        End If

        ShowBlocked = GetArrayItem(UDetails.Template, "eLeave.LeaveBlock")

        trBlocked.Visible = ShowBlocked

        If (ShowBlocked) Then

            If (Not IsData(GetSQLDT("select distinct [ReportsToType] from [ReportsTo] where ([ReportToCompNum] = '" & UDetails.CompanyNum & "' and [ReportToEmpNum] = '" & UDetails.EmployeeNum & "' and [ReportsToType] in (select [ReportsToType] from [ess.ActionLU] where ([ID] in(select distinct [ActionID] from [ess.WF] where ([WFLUID] in(select [ID] from [ess.WFLU] where (not [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Leave'))and [WFType] = 'Leave')))) and not [ReportsToType] = 'Start')))", "Data.Leave.ReportsTo." & Session.SessionID))) Then

                If (ShowBlocked) Then ShowBlocked = False

            End If

        End If

        If (Not IsPostBack OrElse ClearCache) Then

            ClearFromCache("Data.Leave.Balances." & Session.SessionID)

            ClearFromCache("Data.Leave.History." & Session.SessionID)

            ClearFromCache("Data.Leave.Block." & Session.SessionID)

            If (Not dtBalances.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                dtBalances.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
                dtBalances.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

            End If

            If (IsDate(Session("Leave.CalcDate"))) Then

                dtBalances.Date = Session("Leave.CalcDate")

            Else

                dtBalances.Date = DateTime.Today

            End If

            calFrom.SelectedDate = Nothing

            calUntil.SelectedDate = Nothing

        End If

        LoadExpDS(dsTypes, "select [LeaveType] as [Type] from [LeaveLU] order by [Type]")

        Dim cmbType1 As ASPxComboBox = dgView_004.FindHeaderTemplateControl(dgView_004.Columns("Type1"), "cmbType1")

        If (Not IsString(Type1)) Then

            If (Not IsNull(cmbType1)) Then

                If (cmbType1.Items.Count < 1) Then cmbType1.DataBind()

                If (Not IsNull(cmbType1.Value)) Then

                    Type1 = cmbType1.Value

                Else

                    Type1 = GetArrayItem(Session("Managed").Template, "eLeave.LeaveResultType1").ToString()

                    cmbType1.Value = Type1

                End If

            End If

        End If

        Dim cmbType2 As ASPxComboBox = dgView_004.FindHeaderTemplateControl(dgView_004.Columns("Type2"), "cmbType2")

        If (Not IsString(Type2)) Then

            If (Not IsNull(cmbType2)) Then

                If (cmbType2.Items.Count < 1) Then cmbType2.DataBind()

                If (Not IsNull(cmbType2.Value)) Then

                    Type2 = cmbType2.Value

                Else

                    Type2 = GetArrayItem(Session("Managed").Template, "eLeave.LeaveResultType2").ToString()

                    cmbType2.Value = Type2

                End If

            End If

        End If

        T1 = Type1

        T2 = Type2

        With UDetails

            lInverse = String.Empty

            If (Not IsNull(GetArrayItem(.Template, "eLeave.LeaveInverse"))) Then

                lInverse = GetArrayItem(.Template, "eLeave.LeaveInverse")

                lInverse = "'" & GetDataText(lInverse.Replace(", ", ",")).Replace(",", "', '") & "'"

            End If

            Dim CacheChanged As Boolean

            Dim sqlDuration() As String = {String.Empty, String.Empty}

            sqlDuration(0) = "convert(nvarchar(10), [Duration], 0) + ' ' + (select distinct [lRules].[AccrueUnit] from [LeaveRules] as [lRules] left outer join "
            sqlDuration(1) = "(select distinct [lRules].[AccrueUnit] from [LeaveRules] as [lRules] left outer join "

            If (Not String.IsNullOrEmpty(.LeaveScheme)) Then

                sqlDuration(0) &= "[LeaveSchemeRules] as [lSchRules] on ([lRules].[RuleName] = [lSchRules].[RuleName]) and ([lRules].[LeaveType] = [lSchRules].[LeaveType]) where ([lSchRules].[LeaveScheme] = '" & .LeaveScheme & "' and [lSchRules]"
                sqlDuration(1) &= "[LeaveSchemeRules] as [lSchRules] on ([lRules].[RuleName] = [lSchRules].[RuleName]) and ([lRules].[LeaveType] = [lSchRules].[LeaveType]) where ([lSchRules].[LeaveScheme] = '" & .LeaveScheme & "' and [lSchRules]"

            Else

                sqlDuration(0) &= "[PersonnelLeaveRules] as [pRules] on ([lRules].[RuleName] = [pRules].[RuleName]) and ([lRules].[LeaveType] = [pRules].[LeaveType]) where ([pRules].[CompanyNum] = '" & .CompanyNum & "' and [pRules].[EmployeeNum] = '" & .EmployeeNum & "' and [pRules]"
                sqlDuration(1) &= "[PersonnelLeaveRules] as [pRules] on ([lRules].[RuleName] = [pRules].[RuleName]) and ([lRules].[LeaveType] = [pRules].[LeaveType]) where ([pRules].[CompanyNum] = '" & .CompanyNum & "' and [pRules].[EmployeeNum] = '" & .EmployeeNum & "' and [pRules]"

            End If

            sqlDuration(0) &= ".[LeaveType] = ([Leave].[LeaveType])))"
            sqlDuration(1) &= ".[LeaveType] = ([LeaveCalculateFrom].[LeaveType])))"

            Dim SQL As String = String.Empty

            If (tabLeave.ActiveTabIndex = 2 OrElse tabLeave.ActiveTabIndex = 3) Then

                If (tabLeave.ActiveTabIndex = 2) Then

                    If (dgView_001.VisibleRowCount > 0) Then

                        If (Not dtBalances.Date = Session("Leave.CalcDate")) Then

                            Session("Leave.CalcDate") = dtBalances.Date

                            CacheChanged = True

                            For iLoop As Integer = 0 To dgView_001.VisibleRowCount

                                ClearFromCache("Data.Leave.Balances[" & dgView_001.GetRowValues(iLoop, "LeaveType") & "]." & Session.SessionID)

                            Next

                        End If

                    End If

                    If (ClearCache OrElse CacheChanged) Then ClearFromCache("Data.Leave.Balances." & Session.SessionID)

                End If

                SQL = "<Tablename=LeaveCalculateFrom><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [LeaveType]><Columns=[LeaveType], " & IIf(tabLeave.ActiveTabIndex = 2, sqlDuration(1), sqlDuration(0)) & " as [UnitType], cast('" & dtBalances.Date.ToString("yyyy-MM-dd HH:mm:ss") & "' as datetime) as [CalcDate], 0 as [Balance], 0 as [AccumBalance], 0 as [TotalAccrual], %TotalTaken% as [TotalTaken], 0 as [TotalBalance], %TotalFuture% as [TotalFuture], 0 as [AtRisk], null as [NextLostDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "'"

                Dim BalanceType As String = ")>"

                If (Not IsNull(GetArrayItem(.Template, "eLeave.BalanceGrid"))) Then

                    BalanceType = GetArrayItem(.Template, "eLeave.BalanceGrid")

                    BalanceType = " and not [LeaveType] in('" & GetDataText(BalanceType.Replace(", ", ",")).Replace(",", "', '") & "'))>"

                End If

                SQL &= BalanceType

                If (GetArrayItem(.Template, "eLeave.FinancialTotal")) Then

                    If (IsDate(GetArrayItem(.Template, "eLeave.FinancialYear"))) Then

                        Dim dteFinance As Date = GetArrayItem(.Template, "eLeave.FinancialYear")

                        SQL = SQL.Replace("%TotalTaken%", "(select isnull(sum([Duration]), 0) from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [LeaveType] = [LeaveCalculateFrom].[LeaveType] and [LeaveStatus] = 'HR Granted' and ([StartDate] between '" & dteFinance.ToString("yyyy-MM-dd") & "' and '" & Now.ToString("yyyy-MM-dd") & "' or [EndDate] between '" & dteFinance.ToString("yyyy-MM-dd") & "' and '" & Now.ToString("yyyy-MM-dd") & "')))")

                        SQL = SQL.Replace("%TotalFuture%", "(select isnull(sum([Duration]), 0.00) from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [LeaveType] = [LeaveCalculateFrom].[LeaveType] and [LeaveStatus] = 'HR Granted' and ([StartDate] between '" & Now.ToString("yyyy-MM-dd") & "' and '" & dteFinance.AddYears(1).ToString("yyyy-MM-dd") & "' or [EndDate] between '" & Now.ToString("yyyy-MM-dd") & "' and '" & dteFinance.AddYears(1).ToString("yyyy-MM-dd") & "')))")

                    End If

                Else

                    SQL = SQL.Replace("%TotalTaken%", "0").Replace("%TotalFuture%", "0")

                End If

            End If

            ValidatedCancel = IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Leave", "Cancel", ValidatedCancelText)

            If (tabLeave.ActiveTabIndex = 2) Then

                LoadExpGrid(Session, dgView_001, "Leave History Tab", SQL, "Data.Leave.Balances." & Session.SessionID)

                dgView_001.Selection.UnselectAll()

            ElseIf (tabLeave.ActiveTabIndex = 3) Then

                LoadExpGrid(Session, dgView_002, "Leave History Tab", "<Tablename=Leave><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120)><Columns=[LeaveType], [StartDate], [EndDate], " & sqlDuration(0) & " as [Duration], [LeaveStatus], [CapturedByUsername], [CaptureDate], [Remarks], [PathID]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Leave.History." & Session.SessionID)

                dgView_002.Selection.UnselectAll()

                If (Not ShowCancel) Then dgView_002.Columns("cancel").Visible = False

            ElseIf (tabLeave.ActiveTabIndex = 4) Then

                LoadExpGrid(Session, dgView_003, "Leave History Tab", "<Tablename=ess.LeaveBlock><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [BlockFrom], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[BlockFrom], [BlockUntil], [Description], [CapturedBy], [CapturedOn]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Leave.Block." & Session.SessionID)

            End If

            Dim BalanceText As String = String.Empty

            Dim dtResults As DataTable = Nothing

            Dim objValues() As Object = Nothing

            Try

                dtResults = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Filter." & Session.SessionID)

                If (IsData(dtResults)) Then

                    If (dtResults.Columns.IndexOf("LastTaken") = -1) Then dtResults.Columns.Add("LastTaken")

                    If (dtResults.Columns.IndexOf("Remaining") = -1) Then dtResults.Columns.Add("Remaining")

                    If (dtResults.Columns.IndexOf("Balance") = -1) Then dtResults.Columns.Add("Balance")

                    If (dtResults.Columns.IndexOf("Taken") = -1) Then dtResults.Columns.Add("Taken")

                    If (dtResults.Columns.IndexOf("Applications") = -1) Then dtResults.Columns.Add("Applications")

                    'Var1 = Days since last taken - Last Taken (Days) - LastTaken
                    'Var1 = Days remaining - Remaining - Remaining
                    'Var1 = Total Balance - Balance - Balance
                    'Var2 = Days Taken ( in Cycle ) - Taken - Taken
                    'Var2 = # of Apps ( in Cycle ) - Applications - Applications

                    If (Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eLeave.LeaveResults"))) Then

                        For i As Integer = 0 To (dtResults.Rows.Count - 1)

                            objValues = GetSQLFields("select top 1 datediff(day, [EndDate], getdate()) as [LastTaken], (select [Leave_Scheme] from [Personnel] where ([CompanyNum] = [Leave].[CompanyNum] and [EmployeeNum] = [Leave].[EmployeeNum])) as [LeaveScheme], [CompanyNum], [EmployeeNum] from [Leave] where ([CompanyNum] + ' ' + [EmployeeNum] = '" & GetDataText(dtResults.Rows(i).Item("Value").ToString()) & "' and [LeaveType] = '" & Type1 & "' and [EndDate] <= '" & DateTime.Today.ToString("yyyy-MM-dd HH:mm:ss") & "' and [LeaveStatus] = 'HR Granted') order by [EndDate] desc")

                            If (Not IsNull(objValues)) Then

                                If (IsNumeric(objValues(0))) Then

                                    dtResults.Rows(i).Item("LastTaken") = Convert.ToSingle(objValues(0))

                                Else

                                    dtResults.Rows(i).Item("LastTaken") = 0

                                End If

                                If (IsNull(objValues(1))) Then objValues(1) = String.Empty

                                BalanceText = GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), objValues(2).ToString(), objValues(3).ToString(), Type1, objValues(1).ToString(), Date.Today, False, -1)

                                If (Not IsString(GetXML(BalanceText, KeyName:="Error"))) Then

                                    If (IsNumeric(GetXML(BalanceText, KeyName:="Balance"))) Then

                                        dtResults.Rows(i).Item("Remaining") = Convert.ToSingle(GetXML(BalanceText, KeyName:="Balance"))

                                    Else

                                        dtResults.Rows(i).Item("Remaining") = 0

                                    End If

                                    If (IsNumeric(GetXML(BalanceText, KeyName:="TotalBalance"))) Then

                                        dtResults.Rows(i).Item("Balance") = Convert.ToSingle(GetXML(BalanceText, KeyName:="TotalBalance"))

                                    Else

                                        dtResults.Rows(i).Item("Balance") = 0

                                    End If

                                End If

                            Else

                                dtResults.Rows(i).Item("LastTaken") = 0

                                dtResults.Rows(i).Item("Remaining") = 0

                                dtResults.Rows(i).Item("Balance") = 0

                            End If

                            objValues = GetSQLFields("select top 1 datediff(day, [EndDate], getdate()) as [LastTaken], (select [Leave_Scheme] from [Personnel] where ([CompanyNum] = [Leave].[CompanyNum] and [EmployeeNum] = [Leave].[EmployeeNum])) as [LeaveScheme], [CompanyNum], [EmployeeNum] from [Leave] where ([CompanyNum] + ' ' + [EmployeeNum] = '" & GetDataText(dtResults.Rows(i).Item("Value").ToString()) & "' and [LeaveType] = '" & Type2 & "' and [LeaveStatus] = 'HR Granted') order by [EndDate] desc")

                            If (Not IsNull(objValues)) Then

                                If (IsNull(objValues(1))) Then objValues(1) = String.Empty

                                BalanceText = GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), objValues(2).ToString(), objValues(3).ToString(), Type2, objValues(1).ToString(), Date.Today, False, -1)

                                If (Not IsString(GetXML(BalanceText, KeyName:="Error"))) Then

                                    If (IsNumeric(GetXML(BalanceText, KeyName:="TotalTaken"))) Then

                                        dtResults.Rows(i).Item("Taken") = Convert.ToSingle(GetXML(BalanceText, KeyName:="TotalTaken"))

                                    Else

                                        dtResults.Rows(i).Item("Taken") = 0

                                    End If

                                    If (IsNumeric(GetXML(BalanceText, KeyName:="Count"))) Then

                                        dtResults.Rows(i).Item("Applications") = Convert.ToSingle(GetXML(BalanceText, KeyName:="Count"))

                                    Else

                                        dtResults.Rows(i).Item("Applications") = 0

                                    End If

                                End If

                            Else

                                dtResults.Rows(i).Item("Taken") = 0

                                dtResults.Rows(i).Item("Applications") = 0

                            End If

                        Next

                    End If

                    dgView_004.DataSource = dtResults

                    dgView_004.DataBind()

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(objValues)) Then objValues = Nothing

                If (Not IsNull(dtResults)) Then

                    dtResults.Dispose()

                    dtResults = Nothing

                End If

            End Try

            If (Not IsNull(cmbLeaveType.Value)) Then

                Validated = IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Leave", cmbLeaveType.Value, ValidatedText)

                lblDurationType.Text = GetSQLField("select " & sqlDuration(1) & " as [UnitType] from [LeaveCalculateFrom] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [LeaveType] = '" & GetDataText(cmbLeaveType.Value) & "')", "UnitType")

                With UDetails

                    If (Not Validated) Then

                        cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.ShowPopup('" & ReplaceJavaText(ValidatedText) & "'); }"

                    Else

                        cmdSubmit.ClientSideEvents.Click = "function(s, e) { upDocument.Upload(); if (upDocument.GetText().length == 0) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } }"

                    End If

                End With

            End If

            DurationType = lblDurationType.Text

            Dim FilterType As String = String.Empty

            If (Not IsNull(GetArrayItem(.Template, "eLeave.Dropdown"))) Then

                FilterType = GetArrayItem(.Template, "eLeave.Dropdown")

                FilterType = " and not [LeaveType] in('" & GetDataText(FilterType.Replace(", ", ",")).Replace(",", "', '") & "') and [LeaveType] in(select distinct [AppType] from [ess.WFAppType] where ([WFType] = 'Leave'))"

            End If

            LoadExpDS(dsLeaveType, "select [LeaveType] from [LeaveCalculateFrom] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "'" & FilterType & ") order by [LeaveType]")

            If (Not IsPostBack OrElse ClearCache) Then

                If (cmbLeaveType.Items.Count = 0) Then cmbLeaveType.DataBind()

                If (Not IsNull(cmbLeaveType.Items.FindByValue(GetArrayItem(.Template, "eLeave.Default")))) Then

                    cmbLeaveType.Value = GetDataText(GetArrayItem(.Template, "eLeave.Default").ToString())

                    lblDurationType.Text = dgView_002.GetRowValuesByKeyValue(.CompanyNum & " " & .EmployeeNum & " " & cmbLeaveType.Value, "UnitType")

                End If

                ClearFromCache("Data.Leave.ColorKeys." & Session.SessionID)

                ClearFromCache("Data.Leave.PubHolidays." & Session.SessionID)

            End If

            Dim dtKeys As DataTable = Nothing

            Dim dtPubHolidays As DataTable = Nothing

            Try

                dtKeys = GetSQLDT("select [StartDate], [EndDate], [LeaveType], [LeaveStatus], [CaptureDate] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "') order by [StartDate] desc", "Data.Leave.ColorKeys." & Session.SessionID)

                dtPubHolidays = GetSQLDT("select [c].[CalendarType], [PubHolDate] from [PersonnelPubHolCal] as [p] left outer join [PublicHoliday] as [c] on [p].[CalendarType] = [c].[CalendarType] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')", "Data.Leave.PubHolidays." & Session.SessionID)

                If (IsData(dtPubHolidays)) Then

                    Array.Resize(pDays, dtPubHolidays.Rows.Count)

                    For i As Integer = 0 To (dtPubHolidays.Rows.Count - 1)

                        With dtPubHolidays.Rows(i)

                            pDays(i) = If(IsDate(.Item("PubHolDate")), Convert.ToDateTime(.Item("PubHolDate")), Nothing)

                        End With

                    Next

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(dtPubHolidays)) Then

                    dtPubHolidays.Dispose()

                    dtPubHolidays = Nothing

                End If

                If (Not IsNull(dtKeys)) Then

                    dtKeys.Dispose()

                    dtKeys = Nothing

                End If

            End Try

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (IsNumeric(Request.QueryString("TabID"))) Then tabLeave.ActiveTabIndex = Convert.ToInt32(Request.QueryString("TabID").ToString())

        If (Not IsPostBack) Then

            Session("Leave.CalcDate") = Nothing

            dtBalances.Date = DateTime.Today

            SetEmployeeData(Session, Session("Selected.Value"))

        End If

        If (Not IsNull(Session("LoggedOn"))) Then UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

        UDetails = GetUserDetails(Session, "Leave History Tab")

        LoadData(String.Empty, String.Empty)

    End Sub

    Private Sub calFrom_DayRender(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxEditors.DayRenderEventArgs) Handles calFrom.DayRender, calUntil.DayRender

        Dim dtKeys As DataTable = Nothing

        Dim dtPubHolidays As DataTable = Nothing

        Dim dtBlocked As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Try

            If (IsNull(UDetails) OrElse IsNull(UDetails.CompanyNum) OrElse IsNull(UDetails.EmployeeNum)) Then UDetails = GetUserDetails(Session, "Leave History Tab")

            With UDetails

                If (IsNull(Weekends)) Then Weekends = GetWeekends(.CompanyNum, .EmployeeNum)

                If (Not IsNull(Weekends) AndAlso Weekends.Length > 0) Then

                    e.Day.IsWeekend = Convert.ToBoolean(Weekends(e.Day.DateTime.DayOfWeek) = 0)

                    dtBlocked = GetSQLDT("select [BlockFrom], [BlockUntil], [CapturedBy] from [ess.LeaveBlock] where ([CompanyNum] + ':' + [EmployeeNum] = '" & Session("LoggedOn").CompanyNum & ":" & Session("LoggedOn").EmployeeNum & "' or [CompanyNum] + ':' + [EmployeeNum] in(select distinct [ReportToCompNum] + ':' + [ReportToEmpNum] from [ReportsTo] where ([CompanyNum] = '" & UDetails.CompanyNum & "' and [EmployeeNum] = '" & UDetails.EmployeeNum & "' and [ReportsToType] in (select [ReportsToType] from [ess.ActionLU] where ([ID] in(select distinct [ActionID] from [ess.WF] where ([WFLUID] in(select [ID] from [ess.WFLU] where (not [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Leave'))and [WFType] = 'Leave')))) and not [ReportsToType] = 'Start')))))", "Data.Leave.Block.Dates." & Session.SessionID)

                    If (IsData(dtBlocked)) Then

                        dtRows = dtBlocked.Select("[BlockFrom] <= '" & e.Day.DateTime.ToString("yyyy-MM-dd 23:59:59") & "' and [BlockUntil] >= '" & e.Day.DateTime.ToString("yyyy-MM-dd 00:00:00") & "'", "[BlockFrom] desc")

                        If (Not IsNull(dtRows)) Then

                            If (dtRows.GetLength(0) = 1 AndAlso Not Weekends(e.Day.DateTime.DayOfWeek) = 0) Then

                                e.Day.Style.Add("color", "#ffffff")

                                e.Day.Style.Add("background-color", "#a9a9a9")

                                e.Day.ToolTip = "Blocked by '" & dtRows(0).Item("CapturedBy").ToString() & "'"

                            End If

                        End If

                    End If

                    dtPubHolidays = GetSQLDT("select [c].[CalendarType], [PubHolDate] from [PersonnelPubHolCal] as [p] left outer join [PublicHoliday] as [c] on [p].[CalendarType] = [c].[CalendarType] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')", "Data.Leave.PubHolidays." & Session.SessionID)

                    If (IsData(dtPubHolidays)) Then

                        dtRows = dtPubHolidays.Select("[PubHolDate] = '" & e.Day.DateTime.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        If (Not IsNull(dtRows)) Then

                            If (dtRows.GetLength(0) = 1) Then

                                e.Day.Style.Add("color", "#ffffff")

                                e.Day.Style.Add("background-color", "#696969")

                            End If

                            dtRows = Nothing

                        End If

                    End If

                    dtKeys = GetSQLDT("select [StartDate], [EndDate], [LeaveType], [LeaveStatus], [CaptureDate] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "') order by [CaptureDate] desc", "Data.Leave.ColorKeys." & Session.SessionID)

                    If (IsData(dtKeys)) Then

                        dtRows = dtKeys.Select("[StartDate] <= '" & e.Day.DateTime.ToString("yyyy-MM-dd 23:59:59") & "' and [EndDate] >= '" & e.Day.DateTime.ToString("yyyy-MM-dd 00:00:00") & "'", "[CaptureDate] desc")

                        If (Not IsNull(dtRows)) Then

                            If (dtRows.GetLength(0) >= 1) Then

                                If (Not Weekends(e.Day.DateTime.DayOfWeek) = 0 OrElse lInverse.ToLower().Contains("'" & dtRows(0).Item("LeaveType").ToString().ToLower() & "'")) Then

                                    If (e.Day.DateTime = Date.Today) Then e.Day.Style.Add("border", "none")

                                    e.Day.Style.Add("color", "#ffffff")

                                    Select Case dtRows(0).Item("LeaveStatus").ToString().ToLower()

                                        Case "new"
                                            e.Day.Style.Add("background-color", "#1e90ff")

                                        Case "hod accepted"
                                            e.Day.Style.Add("background-color", "#5f9ea0")

                                        Case "hr granted"
                                            e.Day.Style.Add("background-color", "#32cd32")

                                        Case "hod declined", "hr declined"
                                            e.Day.Style.Add("background-color", "#dc143c")

                                        Case "cancelled"
                                            e.Day.Style.Add("background-color", "#996600")

                                    End Select

                                End If

                            End If

                            dtRows = Nothing

                        End If

                    End If

                End If

            End With

        Catch ex As Exception

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtBlocked)) Then

                dtBlocked.Dispose()

                dtBlocked = Nothing

            End If

            If (Not IsNull(dtPubHolidays)) Then

                dtPubHolidays.Dispose()

                dtPubHolidays = Nothing

            End If

            If (Not IsNull(dtKeys)) Then

                dtKeys.Dispose()

                dtKeys = Nothing

            End If

        End Try

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpPage.Callback

        Dim iTimeIndex As Integer = -1

        Dim iTimeIndexU As Integer = -1

        Dim FromTime() As String = {"00:00:00", "12:00:00"}

        Dim UntilTime() As String = {"11:59:59", "23:59:59"}

        Dim Values() As String = e.Parameter.Split(" ")

        If (Values(0) = "Select") Then

            LoadData(String.Empty, String.Empty)

            If (IsDate(calFrom.SelectedDate) AndAlso IsDate(calUntil.SelectedDate) AndAlso Not IsNull(cmbLeaveType.Value)) Then

                If (calFrom.SelectedDate <= calUntil.SelectedDate) Then CalcDuration()

            End If

        ElseIf (spnDuration.Value > 0) Then

            If (IsDate(calFrom.SelectedDate) AndAlso IsDate(calUntil.SelectedDate) AndAlso Not IsNull(cmbLeaveType.Value)) Then

                If (calFrom.SelectedDate <= calUntil.SelectedDate) Then

                    If (Values(0) = "Submit") Then

                        With UDetails

                            Dim LeaveTypes As String = String.Empty

                            If (Not IsNull(GetArrayItem(.Template, "eLeave.Negative"))) Then

                                LeaveTypes = GetArrayItem(.Template, "eLeave.Negative")

                                LeaveTypes = "'" & GetDataText(LeaveTypes.Replace(", ", ",")).Replace(",", "', '") & "'"

                            End If

                            Dim Balance As Single = 0

                            Dim BalanceText As String = String.Empty

                            Dim CheckPending As Boolean

                            Dim BalPending As Single = 0

                            Dim MaxNegative As Single = GetBalanceMaxNeg(.CompanyNum, .EmployeeNum, .Department, cmbLeaveType.Value, BalPending, 0)

                            CheckPending = Convert.ToBoolean(BalPending > 0)

                            BalanceText = GetXML(GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, cmbLeaveType.Value, .LeaveScheme, calUntil.SelectedDate, CheckPending), KeyName:="TotalBalance")

                            If (BalanceText.Length > 0) Then Balance = Convert.ToSingle(BalanceText)

                            If (CheckPending) Then

                                If (Balance < 0) Then

                                    Balance += spnDuration.Value

                                Else

                                    Balance -= BalPending

                                End If

                            End If

                            If (Not IsNull(Session("eLeave.Inverse"))) Then

                                ShowPopup = True

                                ResultText = "error APPLICATION REJECTED: You are not allowed to apply for '" & cmbLeaveType.Value & "' leave during or over normal working " & lblDurationType.Text & "."

                            End If

                            If (spnDuration.Value > Balance) Then

                                ShowPopup = True

                                If (LeaveTypes.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) AndAlso ((Balance - spnDuration.Value) > MaxNegative) Then

                                    If (ShowPopup) Then ShowPopup = False

                                Else

                                    If ((Balance - spnDuration.Value) >= 0) Then

                                        ResultText = "error APPLICATION REJECTED: Your current application will exceed your available balance by " & Convert.ToSingle(Math.Abs(Balance - spnDuration.Value + Math.Abs(MaxNegative))).ToString(NumericFormat) & " " & lblDurationType.Text & "."

                                    Else

                                        If (((Balance + Math.Abs(MaxNegative)) - spnDuration.Value) < 0) Then

                                            ResultText = "error APPLICATION REJECTED: Your current application will exceed your available balance by " & Convert.ToSingle(Math.Abs(Balance + Math.Abs(MaxNegative) - spnDuration.Value)).ToString(NumericFormat) & " " & lblDurationType.Text & "."

                                        Else

                                            ShowPopup = False

                                        End If

                                    End If

                                End If

                            End If

                            If (Not ShowPopup) Then

                                Dim upDocument As ASPxUploadControl = Nothing

                                Dim DocumentPath As String = String.Empty

                                Dim DocPath As String = String.Empty

                                Dim ESSPath As String = String.Empty

                                Dim Consecutive As String = String.Empty

                                Dim ConsecutiveMax As String = String.Empty

                                Dim ForceDoc As String = String.Empty

                                Dim ForceDocMax As String = String.Empty

                                Dim ForceDocMaxValue As String = String.Empty

                                Dim ForceDocDuration As String = String.Empty

                                Dim ForceDocDurationValue As String = String.Empty

                                Dim ForceDocWeekend As String = String.Empty

                                Dim DisallowWeekend As String = String.Empty

                                Dim ForceDocPublic As String = String.Empty

                                Dim DisallowPublic As String = String.Empty

                                Dim LeaveHistory As String = String.Empty

                                Dim LeaveFuture As String = String.Empty

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.Consecutive"))) Then

                                    Consecutive = GetArrayItem(.Template, "eLeave.Consecutive")

                                    Consecutive = "'" & GetDataText(Consecutive.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ConsecutiveMax"))) Then

                                    ConsecutiveMax = GetArrayItem(.Template, "eLeave.ConsecutiveMax")

                                    ConsecutiveMax = ConsecutiveMax.Replace(", ", ",").Replace(" ", String.Empty)

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocument"))) Then

                                    ForceDoc = GetArrayItem(.Template, "eLeave.ForceDocument")

                                    ForceDoc = "'" & GetDataText(ForceDoc.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentMax"))) Then

                                    ForceDocMax = GetArrayItem(.Template, "eLeave.ForceDocumentMax")

                                    ForceDocMax = "'" & GetDataText(ForceDocMax.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentMaxValue"))) Then

                                    ForceDocMaxValue = GetArrayItem(.Template, "eLeave.ForceDocumentMaxValue")

                                    ForceDocMaxValue = ForceDocMaxValue.Replace(", ", ",").Replace(" ", String.Empty)

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentDuration"))) Then

                                    ForceDocDuration = GetArrayItem(.Template, "eLeave.ForceDocumentDuration")

                                    ForceDocDuration = "'" & GetDataText(ForceDocDuration.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentDurationValue"))) Then

                                    ForceDocDurationValue = GetArrayItem(.Template, "eLeave.ForceDocumentDurationValue")

                                    ForceDocDurationValue = ForceDocDurationValue.Replace(", ", ",").Replace(" ", String.Empty)

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentWeekend"))) Then

                                    ForceDocWeekend = GetArrayItem(.Template, "eLeave.ForceDocumentWeekend")

                                    ForceDocWeekend = "'" & GetDataText(ForceDocWeekend.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.DisallowWeekend"))) Then

                                    DisallowWeekend = GetArrayItem(.Template, "eLeave.DisallowWeekend")

                                    DisallowWeekend = "'" & GetDataText(DisallowWeekend.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.ForceDocumentPublic"))) Then

                                    ForceDocPublic = GetArrayItem(.Template, "eLeave.ForceDocumentPublic")

                                    ForceDocPublic = "'" & GetDataText(ForceDocPublic.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.DisallowPublic"))) Then

                                    DisallowPublic = GetArrayItem(.Template, "eLeave.DisallowPublic")

                                    DisallowPublic = "'" & GetDataText(DisallowPublic.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.LeaveHistory"))) Then

                                    LeaveHistory = GetArrayItem(.Template, "eLeave.LeaveHistory")

                                    LeaveHistory = "'" & GetDataText(LeaveHistory.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Not IsNull(GetArrayItem(.Template, "eLeave.LeaveFuture"))) Then

                                    LeaveFuture = GetArrayItem(.Template, "eLeave.LeaveFuture")

                                    LeaveFuture = "'" & GetDataText(LeaveFuture.Replace(", ", ",")).Replace(",", "', '") & "'"

                                End If

                                If (Consecutive.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then

                                    Dim Consec() As String = Consecutive.Replace("'", String.Empty).Replace(" ", String.Empty).Split(",")

                                    Dim ConsecValue() As String = ConsecutiveMax.Split(",")

                                    For iLoop As Integer = 0 To (Consec.GetLength(0) - 1)

                                        If (Consec(iLoop).ToLower() = cmbLeaveType.Value.ToString().ToLower()) Then

                                            If (iLoop < ConsecValue.GetLength(0)) Then

                                                If (IsNumeric(ConsecValue(iLoop))) Then

                                                    Dim durMax As Single = Convert.ToSingle(ConsecValue(iLoop))

                                                    If (spnDuration.Value > durMax) Then

                                                        ShowPopup = True

                                                        ResultText = "information You are not allowed to apply for more than " & durMax.ToString() & " " & lblDurationType.Text & " - in a single application (according to your '" & cmbLeaveType.Value.ToString() & "' leave rules)."

                                                    ElseIf (IsData(GetSQLDT("select [CompanyNum] from [Leave] where (not [LeaveStatus] in('HOD Declined', 'HR Declined', 'Cancelled') and [CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [LeaveType] = '" & cmbLeaveType.Value.ToString() & "' and (([StartDate] >= '" & calFrom.SelectedDate.AddDays((durMax * -1) - 1).ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & calUntil.SelectedDate.AddDays(durMax + 1).ToString("yyyy-MM-dd 23:59:59") & "') or ([EndDate] >= '" & calFrom.SelectedDate.AddDays((durMax * -1) - 1).ToString("yyyy-MM-dd 00:00:00") & "' and [EndDate] <= '" & calUntil.SelectedDate.AddDays(durMax + 1).ToString("yyyy-MM-dd 23:59:59") & "')))"))) Then

                                                        ShowPopup = True

                                                        ResultText = "information You are not allowed to apply within " & durMax & " " & lblDurationType.Text & " - from your last application (according to your '" & cmbLeaveType.Value.ToString() & "' leave rules)."

                                                    End If

                                                End If

                                            End If

                                        End If

                                    Next

                                End If

                                If (Not ShowPopup AndAlso (ForceDoc.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'") AndAlso IsNull(Session("UploadedFile")))) Then

                                    ShowPopup = True

                                    ResultText = "information Please attach the relevent documentation before you continue with your application."

                                End If

                                If (Not ShowPopup AndAlso (ForceDocMax.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'") AndAlso IsNull(Session("UploadedFile")))) Then

                                    Dim Max() As String = ForceDocMax.Replace("'", String.Empty).Replace(" ", String.Empty).Split(",")

                                    Dim MaxValue() As String = ForceDocMaxValue.Split(",")

                                    For iLoop As Integer = 0 To (Max.GetLength(0) - 1)

                                        If (Max(iLoop).ToLower() = cmbLeaveType.Value.ToString().ToLower()) Then

                                            If (iLoop < MaxValue.GetLength(0)) Then

                                                If (IsNumeric(MaxValue(iLoop))) Then

                                                    If (spnDuration.Value > Convert.ToSingle(MaxValue(iLoop))) Then

                                                        ShowPopup = True

                                                        ResultText = "information Please attach the relevent documentation before you continue with your application."

                                                    End If

                                                End If

                                            End If

                                        End If

                                    Next

                                End If

                                If (Not ShowPopup AndAlso (ForceDocDuration.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'") AndAlso IsNull(Session("UploadedFile")))) Then

                                    Dim Duration() As String = ForceDocDuration.Replace("'", String.Empty).Replace(" ", String.Empty).Split(",")

                                    Dim DurationValue() As String = ForceDocDurationValue.Split(",")

                                    For iLoop As Integer = 0 To (Duration.GetLength(0) - 1)

                                        If (Duration(iLoop).ToLower() = cmbLeaveType.Value.ToString().ToLower()) Then

                                            If (iLoop < DurationValue.GetLength(0)) Then

                                                If (IsNumeric(DurationValue(iLoop))) Then

                                                    Dim wks As Single = Convert.ToSingle(DurationValue(iLoop)) * 7

                                                    If (IsData(GetSQLDT("select [CompanyNum] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [LeaveType] = '" & cmbLeaveType.Value.ToString() & "' and ([StartDate] >= '" & calFrom.SelectedDate.AddDays((wks * -1) - 1).ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & calUntil.SelectedDate.AddDays(wks + 1).ToString("yyyy-MM-dd 23:59:59") & "') or ([EndDate] >= '" & calFrom.SelectedDate.AddDays((wks * -1) - 1).ToString("yyyy-MM-dd 00:00:00") & "' and [EndDate] <= '" & calUntil.SelectedDate.AddDays(wks + 1).ToString("yyyy-MM-dd 23:59:59") & "'))"))) Then

                                                        ShowPopup = True

                                                        ResultText = "information Please attach the relevent documentation before you continue with your application."

                                                    End If

                                                End If

                                            End If

                                        End If

                                    Next

                                End If

                                If (Not ShowPopup AndAlso (ForceDocWeekend.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'") AndAlso IsNull(Session("UploadedFile")))) Then

                                    If (IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate, calUntil.SelectedDate, Weekends) OrElse IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate.AddDays(-1), calUntil.SelectedDate.AddDays(-1), Weekends) OrElse IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate.AddDays(1), calUntil.SelectedDate.AddDays(1), Weekends)) Then

                                        ShowPopup = True

                                        ResultText = "information Please attach the relevent documentation before you continue with your application."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (DisallowWeekend.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'"))) Then

                                    If (IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate, calUntil.SelectedDate, Weekends) OrElse IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate.AddDays(-1), calUntil.SelectedDate.AddDays(-1), Weekends) OrElse IsWeekend(.CompanyNum, .EmployeeNum, calFrom.SelectedDate.AddDays(1), calUntil.SelectedDate.AddDays(1), Weekends)) Then

                                        ShowPopup = True

                                        ResultText = "information '" & cmbLeaveType.Value & "' leave is not allowed over a weekend."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (ForceDocPublic.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'") AndAlso IsNull(Session("UploadedFile")))) Then

                                    If (IsPublic(.CompanyNum, .EmployeeNum, calFrom.SelectedDate, calUntil.SelectedDate, pDays)) Then

                                        ShowPopup = True

                                        ResultText = "information Please attach the relevent documentation before you continue with your application."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (DisallowPublic.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'"))) Then

                                    If (IsPublic(.CompanyNum, .EmployeeNum, calFrom.SelectedDate, calUntil.SelectedDate, pDays)) Then

                                        ShowPopup = True

                                        ResultText = "information '" & cmbLeaveType.Value & "' leave is not allowed over a public holiday."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (LeaveHistory.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'"))) Then

                                    Dim dtStartApp As Date = New Date(calFrom.SelectedDate.Year, calFrom.SelectedDate.Month, calFrom.SelectedDate.Day, 0, 0, 0)

                                    If (dtStartApp < New Date(Today.Year, Today.Month, Today.Day, 0, 0, 0)) Then

                                        ShowPopup = True

                                        ResultText = "information You cannot apply for '" & cmbLeaveType.Value & "' leave in the past."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (LeaveFuture.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'"))) Then

                                    Dim dtStartApp As Date = New Date(calFrom.SelectedDate.Year, calFrom.SelectedDate.Month, calFrom.SelectedDate.Day, 0, 0, 0)

                                    If (dtStartApp > New Date(Today.Year, Today.Month, Today.Day, 0, 0, 0)) Then

                                        ShowPopup = True

                                        ResultText = "information You cannot apply for '" & cmbLeaveType.Value & "' leave in the future."

                                    End If

                                End If

                                If (Not ShowPopup AndAlso (GetArrayItem(.Template, "eLeave.ForceComments") AndAlso txtRemarks.Text.Length = 0)) Then

                                    ShowPopup = True

                                    ResultText = "information Please supply remarks before you continue with your application."

                                End If

                                If (spnDuration.Value = 0.25 OrElse spnDuration.Value = 0.5 OrElse spnDuration.Value = 0.75) Then

                                    If (cmbTime.SelectedIndex = 0) Then

                                        iTimeIndex = 0

                                    Else

                                        iTimeIndex = 1

                                    End If

                                End If

                                iTimeIndexU = iTimeIndex

                                If (iTimeIndex = -1) Then

                                    iTimeIndex = 0

                                    iTimeIndexU = 1

                                End If

                                If (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CompanyNum] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and ((([StartDate] >= '" & calFrom.SelectedDate.ToString("yyyy-MM-dd " & FromTime(iTimeIndex)) & "' and [StartDate] <= '" & calUntil.SelectedDate.ToString("yyyy-MM-dd " & UntilTime(iTimeIndexU)) & "') or ([EndDate] >= '" & calFrom.SelectedDate.ToString("yyyy-MM-dd " & FromTime(iTimeIndex)) & "' and [EndDate] <= '" & calUntil.SelectedDate.ToString("yyyy-MM-dd " & UntilTime(iTimeIndexU)) & "')) or ([EndDate] >= '" & calFrom.SelectedDate.ToString("yyyy-MM-dd " & FromTime(iTimeIndex)) & "' and [StartDate] <= '" & calUntil.SelectedDate.ToString("yyyy-MM-dd " & UntilTime(iTimeIndexU)) & "')) and not [LeaveStatus] in('HOD Declined', 'HR Declined', 'Cancelled'))")))) Then

                                    ShowPopup = True

                                    ResultText = "information You already have a leave application between the start and end dates."

                                End If

                                Dim dtBlockStart As Date = New Date(calFrom.SelectedDate.Year, calFrom.SelectedDate.Month, calFrom.SelectedDate.Day, 0, 0, 0)

                                Dim dtBlockUntil As Date = New Date(calUntil.SelectedDate.Year, calUntil.SelectedDate.Month, calUntil.SelectedDate.Day, 23, 59, 59)

                                If (IsDate(dtBlockStart) AndAlso IsDate(dtBlockUntil)) Then

                                    If (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CapturedBy] from [ess.LeaveBlock] where (([CompanyNum] + ':' + [EmployeeNum] = '" & Session("LoggedOn").CompanyNum & ":" & Session("LoggedOn").EmployeeNum & "' or [CompanyNum] + ':' + [EmployeeNum] in(select distinct [ReportToCompNum] + ':' + [ReportToEmpNum] from [ReportsTo] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [ReportsToType] in (select [ReportsToType] from [ess.ActionLU] where ([ID] in(select distinct [ActionID] from [ess.WF] where ([WFLUID] in(select [ID] from [ess.WFLU] where (not [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Leave'))and [WFType] = 'Leave')))) and not [ReportsToType] = 'Start'))))) and (([BlockFrom] between '" & dtBlockStart.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dtBlockUntil.ToString() & "') or ([BlockUntil] between '" & dtBlockStart.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dtBlockUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ('" & dtBlockStart.ToString("yyyy-MM-dd HH:mm:ss") & "' between [BlockFrom] and [BlockUntil]) or ('" & dtBlockUntil.ToString("yyyy-MM-dd HH:mm:ss") & "' between [BlockFrom] and [BlockUntil])))", "Data.Leave.Block.Rules." & Session.SessionID)))) Then

                                        ShowPopup = True

                                        ResultText = "information You have a leave blocking rule between the start and end dates, please change your start and end date range."

                                    End If

                                End If

                                If (Not ShowPopup) Then

                                    If (Not IsNull(Session("UploadedFile"))) Then

                                        upDocument = Session("UploadedFile")

                                        If (upDocument.UploadedFiles(0).IsValid) Then

                                            DocumentPath = GetFileData(Me, upDocument.UploadedFiles(0), "documents/linked")

                                            DocPath = GetDataText(GetXML(DocumentPath, KeyName:="UNCPath"))

                                            ESSPath = GetDataText(GetXML(DocumentPath, KeyName:="VirtualPath"))

                                            If (DocumentPath.Length > 0) Then upDocument.UploadedFiles(0).SaveAs(GetXML(DocumentPath, KeyName:="FilePath"))

                                        Else

                                            ShowPopup = True

                                            ResultText = "information The maximum file size (4M) has been exceeded. Please resave before you continue your application."

                                        End If

                                    End If

                                    If (Not ShowPopup) Then

                                        Dim iAppCount As Byte = 0

                                        Dim deFinance As Date = Nothing

                                        If (Not IsNull(GetArrayItem(.Template, "eLeave.FinancialYear"))) Then deFinance = GetArrayItem(.Template, "eLeave.FinancialYear")

                                        Dim deStart() As Date = {calFrom.SelectedDate, calFrom.SelectedDate}
                                        Dim deUntil() As Date = {calUntil.SelectedDate, calUntil.SelectedDate}

                                        Dim durValue() As Single = {spnDuration.Value, spnDuration.Value}

                                        deStart(0) = New Date(deStart(0).Year, deStart(0).Month, deStart(0).Day, 0, 0, 0)

                                        While IsData(GetSQLDT("select [StartDate] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StartDate] = '" & deStart(0).ToString("yyyy-MM-dd HH:mm:ss") & "')"))

                                            deStart(0) = deStart(0).AddSeconds(1)

                                        End While

                                        deStart(1) = deStart(0)

                                        deUntil(0) = New Date(deUntil(0).Year, deUntil(0).Month, deUntil(0).Day, 23, 59, 59)

                                        deUntil(1) = deUntil(0)

                                        If (IsDate(deFinance)) Then

                                            deFinance = New Date(deStart(0).Year, deFinance.Month, deFinance.Day, 23, 59, 59)

                                            If (deFinance > deStart(0) AndAlso deFinance < deUntil(0)) Then

                                                Dim found As Boolean = False

                                                Dim deLoop As Date = deStart(0)

                                                While (Not found)

                                                    If (deLoop.Day = deFinance.Day AndAlso deLoop.Month = deFinance.Month) Then

                                                        iAppCount += 1

                                                        deFinance = deLoop

                                                        found = True

                                                    Else

                                                        deLoop = deLoop.AddDays(1)

                                                    End If

                                                End While

                                            End If

                                        End If

                                        Dim FridayRule As String = String.Empty

                                        If (Not IsNull(GetArrayItem(.Template, "eLeave.FridayRule"))) Then

                                            FridayRule = GetArrayItem(.Template, "eLeave.FridayRule")

                                            FridayRule = "'" & GetDataText(FridayRule.Replace(", ", ",")).Replace(",", "', '") & "'"

                                        End If

                                        For iLoop As Integer = 0 To iAppCount

                                            If (IsDate(deFinance) AndAlso iAppCount > 0) Then

                                                If (iLoop = 0) Then

                                                    deUntil(0) = New Date(deFinance.Year, deFinance.Month, deFinance.Day, 23, 59, 59)

                                                    durValue(0) = CalcDuration(deStart(0), deUntil(0))

                                                    deStart(1) = New Date(deUntil(0).AddDays(1).Year, deUntil(0).AddDays(1).Month, deFinance.AddDays(1).Day, 0, 0, 0)

                                                    durValue(1) = CalcDuration(deStart(1), deUntil(1))

                                                End If

                                            End If

                                            If (spnDuration.Value = 0.25 OrElse spnDuration.Value = 0.5 OrElse spnDuration.Value = 0.75) Then

                                                If (cmbTime.SelectedIndex = 0) Then

                                                    deStart(iLoop) = New Date(deStart(iLoop).Year, deStart(iLoop).Month, deStart(iLoop).Day, 0, 0, 0)

                                                    deUntil(iLoop) = New Date(deUntil(iLoop).Year, deUntil(iLoop).Month, deUntil(iLoop).Day, 11, 59, 59)

                                                Else

                                                    deStart(iLoop) = New Date(deStart(iLoop).Year, deStart(iLoop).Month, deStart(iLoop).Day, 12, 0, 0)

                                                    deUntil(iLoop) = New Date(deUntil(iLoop).Year, deUntil(iLoop).Month, deUntil(iLoop).Day, 23, 59, 59)

                                                End If

                                                While IsData(GetSQLDT("select [StartDate] from [Leave] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StartDate] = '" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "')"))

                                                    deStart(iLoop) = deStart(iLoop).AddSeconds(1)

                                                End While

                                            End If

                                            Dim TimeText As String = String.Empty

                                            If ((spnDuration.Value = 0.25 OrElse spnDuration.Value = 0.5 OrElse spnDuration.Value = 0.75) AndAlso cmbTime.SelectedIndex = 0) Then TimeText = " AM"

                                            Dim SQL As String = "insert into [Leave]([CompanyNum], [EmployeeNum], [StartDate], [EndDate], [CaptureDate], [Duration], [UnitOfMeassure], [LeaveType], [MedicalCert], [LeaveStatus], [EmailSent], [CapturedByUsername], [Remarks]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & TimeText & "', '" & deUntil(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & TimeText & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & durValue(iLoop).ToString() & ", '" & lblDurationType.Text.Substring(0, 1).ToUpper() & "', '" & cmbLeaveType.Value & "', 0, 'New', 0, '" & Session("LoggedOn").UserID & "', " & GetNullText(txtNotes.Text) & ")"

                                            If (ExecSQL(SQL)) Then

                                                SaveAudit(UDetails, Session("LoggedOn").UserID, "<Type=Insert><Tablename=Leave><CompanyNum=" & .CompanyNum & "><EmployeeNum=" & .EmployeeNum & "><StartDate=" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "><EndDate=" & deUntil(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "><CaptureDate=" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "><Duration=" & durValue(iLoop).ToString() & "><UnitOfMeassure=" & lblDurationType.Text.Substring(0, 1).ToUpper() & "><LeaveType=" & cmbLeaveType.Value & "><MedicalCert=0><LeaveStatus=New><EmailSent=0><CapturedByUsername=" & Session("LoggedOn").UserID & "><Remarks=" & GetNullText(txtNotes.Text) & ">")

                                                SQL = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Leave', '" & cmbLeaveType.Value & "', 'Start', 'Start', '" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                                                If (ExecSQL(SQL)) Then

                                                    ExecSQL("update [Leave] set [TemplateCode] = '" & .Template & "' where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StartDate] = '" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "')")

                                                    If (IsString(txtNotes.Text)) Then ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(txtNotes.Text) & "', " & GetXML(SQL, KeyName:="PathID") & ")")

                                                    If (FridayRule.ToLower().Contains("'" & cmbLeaveType.Value.ToString().ToLower() & "'")) Then

                                                        Dim iCount As Integer = 0

                                                        Dim dteTemp As Date = deStart(iLoop)

                                                        While (dteTemp <= deUntil(iLoop))

                                                            If (dteTemp.DayOfWeek = DayOfWeek.Friday) Then iCount += 1

                                                            dteTemp = dteTemp.AddDays(1)

                                                        End While

                                                        If (iCount > 0) Then ExecSQL("insert into [LeaveAdjustments]([CompanyNum], [EmployeeNum], [LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [Remarks], [PathID]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & cmbLeaveType.Value & "', '" & deStart(iLoop).ToString("yyyy-MM-dd HH:mm:ss") & "', 'Adjustment', " & (iCount * -1).ToString() & ", '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', 'ESS: friday leave rule adjustment', " & GetXML(SQL, KeyName:="PathID") & ")")

                                                    End If

                                                    If (Not IsNull(Session("UploadedFile"))) Then

                                                        ExecSQL("insert into [PersonnelDocLink]([CompanyNum], [EmployeeNum], [DocPath], [Category], [DocDescription], [DateLinked], [UserLinked], [ESSLinked], [ESSPath], [PathID]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & GetDataText(DocPath) & "', 'Leave', '" & Path.GetFileNameWithoutExtension(GetXML(DocumentPath, KeyName:="FilePath")) & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & .UserID & "', 1, '" & GetDataText(ESSPath) & "', " & GetXML(SQL, KeyName:="PathID") & ")")

                                                        Session.Remove("UploadedFile")

                                                    End If

                                                End If

                                                URL = "tasks.aspx tools/index.aspx"

                                            End If

                                        Next

                                    End If

                                End If

                            End If

                        End With

                        If (ShowPopup) Then

                            Dim value As Single = spnDuration.Value

                            CalcDuration()

                            spnDuration.Value = value

                        End If

                    End If

                Else

                    ShowPopup = True

                    ResultText = "information Your start date cannot be greater than your end date!"

                End If

            Else

                ShowPopup = True

                ResultText = "information You need to ensure that you select a valid leave type, start date and end date!"

            End If

        Else

            ShowPopup = True

            ResultText = "information You need to select a valid leave type, start and end date!"

        End If

    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpDurationType") = DurationType

        e.Properties("cpResultText") = ResultText

        e.Properties("cpShowPopup") = ShowPopup

        e.Properties("cpURL") = URL

    End Sub

    Private Sub dgView_002_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_002.CustomButtonCallback

        If (e.ButtonID = "Cancel") Then

            With UDetails

                Dim SQL As String = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Leave', 'Cancel', 'Start', 'Start', '" & Convert.ToDateTime(dgView_002.GetRowValues(e.VisibleIndex, "StartDate")).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                If (ExecSQL(SQL)) Then

                    URL = "tasks.aspx tools/index.aspx"

                Else

                End If

            End With

        End If

    End Sub

    Private Sub dgView_002_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView_002.CustomButtonInitialize

        If (e.Column.Name = "cancel") Then

            e.Visible = DevExpress.Utils.DefaultBoolean.False

            If (ValidatedCancel) Then

                Dim dteStart As Date = sender.GetRowValues(e.VisibleIndex, "StartDate")

                If (IsDate(dteStart)) Then

                    If (dteStart > Date.Now AndAlso Not sender.GetRowValues(e.VisibleIndex, "LeaveStatus").ToString().ToLower() = "cancelled") Then

                        If (Not ShowCancel) Then

                            ShowCancel = True

                            sender.Columns("cancel").Visible = True

                        End If

                        e.Visible = DevExpress.Utils.DefaultBoolean.True

                    End If

                End If

            End If

        End If

    End Sub

    Private Sub dgView_001_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_001.CustomCallback, dgView_002.CustomCallback

        If (IsNumeric(e.Parameters)) Then

            IsSelected = True

            SelectedIndex = Convert.ToInt32(e.Parameters)

            If (sender.Equals(dgView_001)) Then

                Session("eLeave.LeaveType") = sender.GetRowValues(SelectedIndex, "LeaveType")

            Else

                If (Not IsNull(sender.GetRowValues(SelectedIndex, "PathID"))) Then

                    If (IsNumeric(sender.GetRowValues(SelectedIndex, "PathID"))) Then Remarks = GetRemarks(UDetails.Template, sender.GetRowValues(SelectedIndex, "PathID"), Remarks)

                End If

            End If

        End If

    End Sub

    Private Sub dgView_004_CustomCallback(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_004.CustomCallback

        Dim Values() As String = e.Parameters.Split(" ")

        Dim cmbType As ASPxComboBox = sender.FindHeaderTemplateControl(sender.Columns("Type" & Values(0)), "cmbType" & Values(0))

        If (Not IsNull(cmbType)) Then

            cmbType.DataBind()

            cmbType.Value = Values(1)

            If (Convert.ToInt32(Values(0)) = 1) Then

                LoadData(Values(1), String.Empty)

            ElseIf (Convert.ToInt32(Values(0)) = 2) Then

                LoadData(String.Empty, Values(1))

            End If

        End If

    End Sub

    Private Sub dgView_001_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_001.CustomColumnDisplayText, dgView_004.CustomColumnDisplayText

        Dim LeaveType As String = String.Empty

        Dim ItemKey As String = String.Empty

        With UDetails

            If (sender.Equals(dgView_001)) Then

                LeaveType = sender.GetRowValues(e.VisibleRowIndex, "LeaveType")

                ItemKey = "Data.Leave.Balances[" & LeaveType & "]." & Session.SessionID

            End If

            If (IsString(LeaveType) AndAlso IsString(ItemKey) AndAlso IsNull(Cache(ItemKey))) Then

                UpdateCache(GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, LeaveType, .LeaveScheme, dtBalances.Date, False, -1), ItemKey, "<TimeSpan=Hours><Duration=1>")

            End If

            Select Case e.Column.FieldName

                Case "AccumBalance", "AtRisk", "Balance", "NextLostDate", "TotalAccrual", "TotalFuture", "TotalTaken"

                    If (sender.Equals(dgView_001)) Then e.DisplayText = GetXML(Cache(ItemKey), KeyName:=e.Column.FieldName)

                Case "TotalBalance"

                    If (sender.Equals(dgView_001)) Then

                        If (Not GetArrayItem(.Template, "eLeave.FinancialTotal")) Then

                            e.DisplayText = GetXML(Cache(ItemKey), KeyName:=e.Column.FieldName)

                        Else

                            Dim Balance As String = Cache(ItemKey)

                            SetXML(Balance, "TotalBalance", Convert.ToDouble(e.Value).ToString(NumericFormat))

                            UpdateCache(Balance, ItemKey, "<TimeSpan=Hours><Duration=1>")

                            e.DisplayText = Convert.ToDouble(e.Value).ToString(NumericFormat)

                        End If

                    End If

                Case "LastTaken"

                    If (IsNull(e.Value) OrElse Not Convert.ToDouble(e.Value) > 0) Then e.DisplayText = String.Empty

            End Select

        End With

        If (IsNumeric(e.DisplayText)) Then e.Value = Convert.ToDouble(e.DisplayText)

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties

        If (sender.Equals(dgView_001)) Then

            e.Properties("cpIsSelected") = IsSelected

            e.Properties("cpDate") = dtBalances.Date.ToString(GetArrayItem(UDetails.Template, "eGeneral.DateFormat"))

            If (SelectedIndex > -1) Then

                Dim Balances As String = String.Empty

                'Balances = Cache("Data.Leave.Balances[" & GetXML(Balances, KeyName:="LeaveType") & "]." & Session.SessionID)

                With UDetails

                    Balances = GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, Session("eLeave.LeaveType"), .LeaveScheme, dtBalances.Date, False, -1)

                End With

                e.Properties("cpLeaveType") = GetXML(Balances, KeyName:="LeaveType")
                e.Properties("cpUnitOfMeassure") = GetXML(Balances, KeyName:="UnitOfMeassure")
                e.Properties("cpCycleStart") = GetXML(Balances, KeyName:="CycleStart")
                e.Properties("cpCycleEnd") = GetXML(Balances, KeyName:="CycleEnd")
                e.Properties("cpCyclePeriod") = GetXML(Balances, KeyName:="CyclePeriod")

                e.Properties("cpTotalBalance") = GetXML(Balances, KeyName:="TotalBalance")

                e.Properties("cpRemaining") = GetXML(Balances, KeyName:="Balance")
                e.Properties("cpTaken") = GetXML(Balances, KeyName:="TotalTaken")
                e.Properties("cpAccrued") = GetXML(Balances, KeyName:="TotalAccrual")

                e.Properties("cpAccumulated") = GetXML(Balances, KeyName:="AccumBalance")
                e.Properties("cpNoRisk") = GetXML(Balances, KeyName:="AtRisk")
                e.Properties("cpLoseAt") = GetXML(Balances, KeyName:="NextLostDate")
                e.Properties("cpTotalTaken") = GetXML(Balances, KeyName:="GrandTotalTaken")
                e.Properties("cpFuture") = GetXML(Balances, KeyName:="TotalFuture")
                e.Properties("cpTotalLost") = GetXML(Balances, KeyName:="TotalLost")

            End If

        ElseIf (sender.Equals(dgView_002)) Then

            e.Properties("cpIsSelected") = IsSelected

            e.Properties("cpRemarks") = Remarks

            e.Properties("cpURL") = URL

        ElseIf (sender.Equals(dgView_003)) Then

            e.Properties("cpCancelEdit") = CancelEdit

        End If

    End Sub

    Private Sub dgView_001_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_001.DataBound

        Dim CacheChanged As Boolean = False

        If (dgView_001.VisibleRowCount > 0) Then

            If (Not dtBalances.Date = Session("Leave.CalcDate")) Then

                Session("Leave.CalcDate") = dtBalances.Date

                CacheChanged = True

                For iLoop As Integer = 0 To dgView_001.VisibleRowCount

                    ClearFromCache("Data.Leave.Balances[" & dgView_001.GetRowValues(iLoop, "LeaveType") & "]." & Session.SessionID)

                Next

            End If

        End If

        If (CacheChanged) Then ClearFromCache("Data.Leave.Balances." & Session.SessionID)

    End Sub

    Private Sub dgView_004_DataBound(sender As Object, e As System.EventArgs) Handles dgView_004.DataBound

        Dim cmbType1 As ASPxComboBox = dgView_004.FindHeaderTemplateControl(dgView_004.Columns("Type1"), "cmbType1")

        Dim cmbType2 As ASPxComboBox = dgView_004.FindHeaderTemplateControl(dgView_004.Columns("Type2"), "cmbType2")

        If (IsNull(cmbType1.Value) AndAlso IsString(T1)) Then cmbType1.Value = T1

        If (IsNull(cmbType2.Value) AndAlso IsString(T2)) Then cmbType2.Value = T2

    End Sub

    Private Sub dgView_004_HtmlDataCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableDataCellEventArgs) Handles dgView_004.HtmlDataCellPrepared

        If (e.DataColumn.FieldName = "Text") Then

            e.Cell.Style.Add("color", "#5689c5")

            e.Cell.Style.Add("cursor", "pointer")

            e.Cell.Style.Add("text-decoration", "none")

            e.Cell.Attributes.Add("onclick", "window.parent.cmbEmployee.SetValue('" & sender.GetRowValues(e.VisibleIndex, "Value").ToString() & "'); window.parent.lpPage.Show(); window.parent.cpPanes.PerformCallback('load\ ' + '" & sender.GetRowValues(e.VisibleIndex, "Value").ToString() & "' + '\ ' + '" & sender.GetRowValues(e.VisibleIndex, "Text").ToString() & "' + '\ leave.aspx?TabID=2');")

        End If

    End Sub

    Protected Sub dgView_003_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_003.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(String.Empty, String.Empty, True)

        End If

    End Sub

    Protected Sub dgView_003_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_003.RowInserting

        Dim SQLAudit As String = String.Empty

        e.NewValues("CapturedBy") = UDetails.UserID

        e.NewValues("CapturedOn") = Now

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(String.Empty, String.Empty, True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (IsNull(e.OldValues("CapturedBy"))) Then e.NewValues("CapturedBy") = UDetails.UserID

        If (IsNull(e.OldValues("CapturedOn"))) Then e.NewValues("CapturedOn") = Now

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(String.Empty, String.Empty, True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating

        If (IsNull(e.OldValues("CapturedBy"))) Then e.NewValues("CapturedBy") = UDetails.UserID

        If (IsNull(e.OldValues("CapturedOn"))) Then e.NewValues("CapturedOn") = Now

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile") = sender

    End Sub

    Private Sub tabLeave_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles tabLeave.CustomJSProperties

        e.Properties("cpVisible") = ShowBlocked

        e.Properties("cpVisibleResults") = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eLeave.LeaveResults"))

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabLeave.TabPages(tabLeave.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabLeave.TabPages(tabLeave.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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