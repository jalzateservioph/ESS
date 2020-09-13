Imports System.Data.SqlClient

Module AbsalomCOM

    Private Enum PositionEnum

        Insert = 0
        Append = 1

    End Enum

    Private Function FillChar(ByVal sText As String, ByVal sChar As Char, ByVal iLen As Integer, ByVal pLocation As PositionEnum) As String

        Dim CharValue As String = String.Empty

        Dim sTextAdd As String = New String(sChar, iLen - sText.Length)

        Select Case pLocation

            Case PositionEnum.Insert
                CharValue = sTextAdd & sText

            Case PositionEnum.Append
                CharValue = sText & sTextAdd

        End Select

        Return CharValue

    End Function

    Public Function GetSQLFieldObj(ByVal SQL As String, ByVal ItemName As String) As Object

        Dim ReturnObject As Object = Nothing

        Dim dtTable As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Try

            dtTable = GetSQLDT(SQL)

            If (IsData(dtTable)) Then

                If (dtTable.Columns.Contains(ItemName)) Then

                    dtRows = New DataRow() {dtTable.Rows(0)}

                    If (Not IsNull(dtRows)) Then

                        ReturnObject = dtRows(0).Item(ItemName)

                        If (IsDBNull(ReturnObject)) Then ReturnObject = Nothing

                    End If

                End If

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtTable)) Then

                dtTable.Dispose()

                dtTable = Nothing

            End If

        End Try

        Return ReturnObject

    End Function

    Private Function GetSQLField(ByVal index As Integer, ByRef dsData As DataSet, ByVal sField As String) As Object

        If (IsData(dsData)) Then

            If (index < dsData.Tables(0).Rows.Count) Then

                Return dsData.Tables(0).Rows(index).Item(sField)

            Else

                Return Nothing

            End If

        Else

            Return Nothing

        End If

    End Function

    Private Function GetSQLDS(ByVal sSQL As String) As DataSet

        Return GetSQLDS(SQLString, sSQL)

    End Function

    Private Function GetSQLDS(ByVal sSQLString As String, ByVal sSQL As String) As DataSet

        Try

            GetSQLDS = New DataSet()

            Dim dgAdap As New SqlDataAdapter(sSQL, sSQLString)

            dgAdap.Fill(GetSQLDS)

            dgAdap.Dispose()

            dgAdap = Nothing

        Catch ex As Exception

            Return Nothing

        End Try

    End Function

    Public Function calculate_balance(ByVal Template As String, ByRef Current_Company_Num As String, ByRef Current_Employee_Num As String, ByRef ipLeaveType As String, ByRef ipLeaveScheme As String, ByRef ipCalcDate As String) As String ' strupBalance As String, strupAccumBalance As String, strupTotBalance As String) totalaccrual, totaltaken, totalcapitalized, totalvalcapitalized, moneyvalbalance, cycle_leavesd, totalfuture, period, grandtottaken, atrisk, nextlostdate, total_lost

        Dim errs As String = String.Empty           ' Error message
        Dim calc_method As String = String.Empty    ' Calculation method
        Dim totalaccrual As Single    ' Total amount accrued within the current cycle
        Dim totaltaken As Single      ' Total taken within the current cycle
        Dim totalcapitalized As Single    ' Total number of units capitalized
        Dim totalvalcapitalized As Single ' Total value of the capitalizations
        Dim moneyvalbalance As Single ' Money value of the leave
        Dim grandtottaken As Single   ' Grand total taken, not just within current cycle
        Dim cycle_leavesd As Date     ' The Leave Start date within that cycle, different from Leave Start date (sd). Is equal to sd if no cycles are used
        Dim cycle_leaveed As Object = Nothing   ' The Leave End Date within that cycle
        Dim actualbalance As Single   ' Actual To Date balance
        Dim totalaccum As Single      ' Total amount accumulated (if leave is allowed to be accumulated)
        Dim totalfuture As Single     ' Total approved future leave
        Dim nextlostdate As Date      ' When leave is at risk (becoming lost), this date is the date by which the leave actually becomes lost. Eg. if on 1/1/2002 leave is marked as risk, then 6 months after it becomes lost, this date reflects the 6/1/2002
        Dim atrisk As Single          ' Number of leave to be lost on the above day
        Dim total_lost As Single      ' Total Lost leave

        Dim period As Byte            ' Current period of a leave cycle
        Dim unitofmeassure As String = String.Empty ' Unit of Meassure eg days, weeks etc.
        Dim capitmethod As String = String.Empty    ' Capitalization calculation method

        calculate_leave_balance(Current_Company_Num, Current_Employee_Num, ipLeaveType, ipLeaveScheme, DateValue(ipCalcDate), errs, calc_method, capitmethod, totalaccrual, totaltaken, totalcapitalized, totalvalcapitalized, moneyvalbalance, cycle_leavesd, actualbalance, totalaccum, totalfuture, period, unitofmeassure, grandtottaken, atrisk, nextlostdate, total_lost, False, False, False, cycle_leaveed)

        Dim Balances As String = String.Empty

        If (errs.Trim() = String.Empty) Then

            Balances = "<TotalAccrual=" & totalaccrual.ToString(NumericFormat) & ">"
            Balances &= "<TotalTaken=" & totaltaken.ToString(NumericFormat) & ">"
            Balances &= "<Balance=" & actualbalance.ToString(NumericFormat) & ">"
            Balances &= "<AccumBalance=" & totalaccum.ToString(NumericFormat) & ">"
            Balances &= "<TotalBalance=" & (totalaccum + actualbalance).ToString(NumericFormat) & ">"
            Balances &= "<TotalFuture=" & totalfuture.ToString(NumericFormat) & ">"
            Balances &= "<Preriod=" & period.ToString() & ">"
            Balances &= "<GrandTotalTaken=" & grandtottaken.ToString(NumericFormat) & ">"
            Balances &= "<AtRisk=" & atrisk.ToString(NumericFormat) & ">"

            If (nextlostdate = New Date(1960, 1, 1)) Then

                Balances &= "<NextLostDate=>"

            ElseIf (IsDate(nextlostdate)) Then

                If (atrisk > 0) Then

                    Balances &= "<NextLostDate=" & nextlostdate.ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

                Else

                    Balances &= "<NextLostDate=>"

                End If

            End If

            Balances &= "<TotalLost=" & total_lost.ToString(NumericFormat) & ">"
            Balances &= "<CycleStart=" & cycle_leavesd.ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

            If (IsDate(cycle_leaveed)) Then

                Balances &= "<CycleEnd=" & Convert.ToDateTime(cycle_leaveed).ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

            Else

                Balances &= "<CycleEnd=>"

            End If

            Balances &= "<LeaveType=" & ipLeaveType & ">"
            Balances &= "<UnitOfMeassure=" & unitofmeassure & ">"
            Balances &= "<CyclePeriod=" & period.ToString() & ">"

            Balances &= "<Count=0>"

            If (IsDate(cycle_leavesd) AndAlso IsDate(cycle_leaveed)) Then

                Dim cycle_end As Date = Convert.ToDateTime(cycle_leaveed)

                Dim iCount() As Object = GetSQLFields("select count([CompanyNum]) as [AppCount] from [Leave] where ([CompanyNum] = '" & Current_Company_Num & "' and [EmployeeNum] = '" & Current_Employee_Num & "' and [LeaveType] = '" & ipLeaveType & "' and [LeaveStatus] = 'HR Granted' and (([StartDate] >= '" & cycle_leavesd.ToString("yyyy-MM-dd HH:mm:ss") & "' and [StartDate] <= '" & cycle_end.ToString("yyyy-MM-dd HH:mm:ss") & "' and [StartDate] <= '" & Date.Today.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([EndDate] >= '" & cycle_leavesd.ToString("yyyy-MM-dd HH:mm:ss") & "' and [EndDate] <= '" & cycle_end.ToString("yyyy-MM-dd HH:mm:ss") & "')))")

                If (Not IsNull(iCount) AndAlso iCount.Length = 1) Then SetXML(Balances, "Count", iCount(0).ToString())

            End If

        Else

            Balances = "<Error=" & errs & ">"

        End If

        Return Balances

    End Function

    Private Sub calculate_leave_balance(ByRef ipcomp As String, ByRef ipemp As String, ByRef ipLeaveType As String, ByRef ipLeaveScheme As String, ByRef ipDate As Object, ByRef upErrs As String, ByRef upCalcMethod As String, ByRef upCapitMethod As String, ByRef uptotalaccrual As Single, ByRef uptotaltaken As Single, ByRef uptotalcapitalized As Single, ByRef uptotalvalcapitalized As Single, ByRef upmoneyvalbalance As Single, ByRef upcycle_leavesd As Date, ByRef upactualbalance As Single, ByRef uptotalaccum As Single, ByRef uptotalfuture As Single, ByRef upperiod As Byte, ByRef upUnitOfMeassure As String, ByRef upgrandtottaken As Single, ByRef upatrisk As Single, ByRef upnextlostdate As Date, ByRef uptotal_lost As Single, ByRef ipBuildLeaveStmt As Boolean, ByRef ipShowCapitMethod As Boolean, ByRef ipShowCalcMethod As Boolean, ByRef cycle_leaveed As Object)

        ' This procedure calculates a leave balance as per the parameters
        ' ===============================================================
        ' Explanation of some parameters:
        ' -------------------------------
        ' ipLeaveScheme : Leave as empty string if this procedure has to obtain the scheme, otherwise pass the leave scheme in this variable
        ' uptotalaccrual : Total amount accrued within the current cycle
        ' uptotaltaken : Total taken within the current cycle
        ' upcycle_leavesd : The Leave Start date within that cycle, different from Leave Start date (sd). Is equal to sd if no cycles are used
        ' upactualbalance : Actual To Date balance
        ' uptotalaccum : Total amount accumulated (if leave is allowed to be accumulated)
        ' uptotalfuture : Total approved future leave
        ' upnextlostdate : When leave is at risk (becoming lost), this date is the date by which the leave actually becomes lost. Eg. if on 1/1/2002 leave is marked as risk, then 6 months after it becomes lost, this date reflects the 6/1/2002
        ' upatrisk : Number of leave to be lost on the above day
        ' upperiod : Current period of a leave cycle
        ' uptotalcapitalized : Total number of units being capitalized
        ' uptotalvalcapitalized : Total value of the above
        ' upmoneyvalbalance : Monetary value of the leave
        ' upCapitMethod : Capitalization method
        ' ipShowCapitMethod : True if above must be shown, false otherwise


        ' ********************************************************************************************************
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Mail utility
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Scheduler utility
        ' NNB If any of this code changes, please remember to copy this function to the Absalom COM Object
        ' ********************************************************************************************************

        ' NOTE : Refer to function CDec to fix up rounding errors
        '        Use function round for rounding off
        Dim Rules As DataSet
        Dim Snap As DataSet
        Dim Snap1 As DataSet
        Dim sd As Object    ' Leave Start Date
        Dim los As String    ' Length Of Service
        Dim mos As Integer   ' Months of service
        Dim wos As Integer   ' Weeks of service
        Dim tmpdt As Date    ' Temporary date
        Dim tmpdt1 As Date    ' Temporary date
        Dim appointdate As Object  ' Appointment date, which can be either the appointment date or the date joined group
        Dim apptdate As Object     ' Appointment Date
        Dim groupdate As Object    ' Date Joined Group
        Dim termdate As Object     ' Termination date
        Dim lstworkdate As Object  ' Last working date

        Dim losrule As Boolean      '  True if there is a rule based on Length Of Service

        ' Leave rules array variables
        Dim servicetype() As String = Nothing
        Dim serviceinterval() As Integer = Nothing
        Dim dtjoinedgroup() As Boolean = Nothing
        Dim accrueamount() As Single = Nothing
        Dim accrueunit() As String = Nothing
        Dim accruetype() As String = Nothing
        Dim accruetypeamount() As String = Nothing
        Dim periodtype() As String = Nothing
        Dim periodlength() As Long = Nothing
        Dim periodnumber() As Byte = Nothing
        Dim rulename() As String = Nothing
        Dim rulevaliduntil() As Date = Nothing
        Dim allowaccum() As Boolean = Nothing       ' True when leave can be accumulated for a cycle
        Dim maxaccum() As Long = Nothing            ' Maximum Accumulation allowed
        Dim maxaccumgracelen() As Integer = Nothing ' Maximum accumulation grace length eg. 6 months. Leave must be taken within that period otherwise it is lost
        Dim maxaccumgracetyp() As String = Nothing  ' Maximum accumulation grace type eg. 6 months. Leave must be taken within that period otherwise it is lost
        Dim atriskstartdate As Date = Nothing       ' Date from which the At risk leave must be taken
        Dim totmaxaccum() As Long = Nothing     ' Total Maximum Accumulation allowed
        Dim tmaxaccumgracelen() As Integer = Nothing ' TOTAL Maximum accumulation grace length eg. 6 months. Leave must be taken within that period otherwise it is lost
        Dim tmaxaccumgracetyp() As String = Nothing  ' TOTAL Maximum accumulation grace type eg. 6 months. Leave must be taken within that period otherwise it is lost
        Dim maxtotbalance() As Long = Nothing        ' Maximum TOTAL (normal + accumulated) balance
        Dim paytemplate() As String = Nothing   ' Pay template name
        Dim fieldname() As String = Nothing     ' Pay template field name
        Dim maxrules As Byte          ' The number of rules
        Dim prev_rule As Byte         ' The index of the previous rule used
        Dim period_end_date As Object  ' The end date of a period within a cycle
        Dim current_period_num As Byte  ' The current period number within a cycle
        Dim maxperiods As Byte          ' The maximum number of periods within a cycle

        ' Rule validation array
        Dim rulevalid() As Date = Nothing          ' This variable is used to trigger the building of an array when the respective validation dates has been reached
        Dim maxrulevalid As Byte
        Dim lastvalidused As Date       ' Last validation date used

        ' Working hours/days array
        Dim max_hrs_days As Byte    '  The number of hrs/days records in the array below
        Dim wh_validfrom() As Date = Nothing
        Dim wh_hrs(,) As Single = Nothing   ' 2 Dimensional array
        Dim max_pub_hols As Integer ' The number of pub holidays in the array below
        Dim pub_hols() As Date = Nothing   ' Public holidays array
        Dim x_amount As Long     ' Eg. ... for ever 21 days worked

        ' Leave Adjustments
        Dim max_adjustments As Integer
        Dim adjust_date() As Date = Nothing
        Dim adjust_type() As String = Nothing
        Dim adjust_subtype() As String = Nothing
        Dim adjust_value() As Single = Nothing

        ' Leave taken NNB !!! Only applicable when ipBuildLeaveStmt = True
        Dim max_taken As Integer
        Dim taken_date() As Date = Nothing       ' Taken From date
        Dim taken_to_date() As Date = Nothing    ' Taken To Date; only used when Leave Statement is requested
        Dim taken_amount() As Single = Nothing

        ' Other variables
        Dim idx As Byte
        Dim found As Boolean
        Dim rule_not_found As Boolean   ' True when NO rule is found during the leave calculation
        Dim tmps As String = Nothing     ' Temporary String
        Dim tmps1 As String    ' Temporary String
        Dim tmpi As Integer    ' Temporary Integer
        Dim tmpi1 As Integer   ' Temporary Integer
        Dim tmpi2 As Integer   ' Temporary Integer
        Dim tmpb As Boolean    ' Temporary Boolean
        Dim tmpflag As Boolean ' Temporary boolean
        Dim tmpflag1 As Boolean ' Temporary boolean
        Dim tmpd As Single     ' Temporary Single
        Dim tmpd1 As Single    ' Temporary Single
        Dim tmpd2 As Single    ' Temporary Single
        Dim tmpd3 As Single    ' Temporary Single
        Dim tmpbt As Byte      ' Temporary byte
        Dim tmpl As Long       ' Temporary long
        Dim tmp_additional_remark As String   ' Temporary remark
        Dim tmp_tot_taken As Single ' Total leave taken, only applicable if the leave statement is requested
        Dim taken_sd As Date   ' This is the date from where the Leave Taken needs to be calculated, used to be the same as upCycleLeaveSd, but caused a problem when an adjustment of Leave Balance is set.
        Dim taken_sd_begin As Date   ' This is the date from where the Leave Taken needs to be calculated, and it is the same than taken_sd when we do not work with cycles, but if we work with cycles then it is the date from the first cycle start. Used for the calculation of the number of days taken for the capitalisation
        Dim last_accrue_date As Date ' Date of last accrual or start date, used only to calculate the proportions correctly on "For every x month(s) worked" rules
        Dim last_setbalance_date As Date  ' The date of the last set balance, used to fix up the pb that Megan had at RMB where their balances includes the proportion of the accrual.
        Dim delta As Single          ' Temporary variable used for an increment of some sort
        Dim delta1 As Single          ' Temporary variable used for an increment of some sort
        Dim balance_set As Boolean   ' True if a balance has been set for the current date. Used to omit the calculation of the proportion part on that same day where the balance is set, for the As At date of that day
        Dim calculate_proportion As Boolean   ' True if the proportion needs to be calculated : Refer to Werksmans bug where a Stop Accrual is done on 01 March 2007 (with the 2 adjustments) and then a leave statement is run for the 28 Feb 2007, a Single accrual is allocated

        Dim accruecount As Integer = 0            ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule
        Dim periodlengthmonths As Integer     ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule

        ' Monetary value (for the capatilisation part)
        ' --------------------------------------------
        ' Based on the leave rules array index (idx)
        Dim salary_template() As String = Nothing    ' Template name
        Dim salary_field() As String = Nothing       ' Field name
        Dim payfield_conversion_formula As String  ' Conversion formula
        Dim calc_on_present_sal As Boolean ' Calculate monetary value based on present salary
        ' Based as a separate array
        Dim salary_as_at_date() As Date = Nothing
        Dim salary() As Single = Nothing             ' This is the salary after the formula conversion
        Dim salarytcp() As Single = Nothing          ' Salary before conversion, as it is in the pay record; total cash package, Used only to display the value, not for any calculations
        Dim maxsalary As Integer
        Dim leave_value As Single          ' Value of the leave
        Dim value_remark As String = Nothing         ' Remark that is used for the statement that shows how the monetary value is calculated
        ' The array of accruals
        Dim accruedate() As Date = Nothing           ' Date of the accrual
        Dim accrual() As Single = Nothing            ' Accrual eg. 1.6
        Dim prevaccrual() As Single = Nothing        ' Previous Accrual. Remember that we set accrual to 0 as the days are taken. The prevaccrual is used to reverse this action, should days be given back, -5 days taken
        Dim accrualsalary() As Single = Nothing      ' Salary value PER UNIT (eg. per day/hour etc.) on the date of that accrual
        Dim accrualsalarytcp() As Single = Nothing   ' Salary value TCP on the date of that accrual. Used only for display purposes, not for calculations
        Dim maxaccrual As Long             ' Maximum number of values in the array
        ' Other variables
        Dim tmptaken As Single             ' Temporary taken field
        Dim tmpdbl1 As Single              ' Temporary Single

        ' Accrual stop process
        Dim maxaccrualstop As Integer
        Dim accrualstopfrom() As Date = Nothing
        Dim accrualstopto() As Date = Nothing

        ' Lost stop process : Stops the loosing of leave between certain dates
        Dim maxloststop As Integer
        Dim loststopfrom() As Date = Nothing
        Dim loststopto() As Date = Nothing

        ' Ignore history records
        Dim ignore_hist_prior As Object

        Dim year_end As Date               ' Financial year end, specify anything where the year part is not equal to 1900 to activate

        ' Financial year end, specify anything where the year part is not equal to 1900 to activate
        year_end = New Date(2000, 12, 31)

        ' If the financial year en date is specified, and the leave spans over this date, we need to take only the proportion of the days for the current financial year
        If DatePart("yyyy", year_end) <> 1900 Then
            If DatePart("m", ipDate) = DatePart("m", year_end) And DatePart("d", ipDate) = DatePart("d", year_end) Then
                year_end = ipDate
            Else
                year_end = New Date(1900, 12, 31) ' Not applicable
            End If
        End If

        ' ======================================
        ' ======================================
        ' Initialize variables and load settings
        ' ======================================
        ' ======================================
        'If ipLeaveType = "Annual" Then Exit Sub    ' do not calc annual leave for now
        'ipLeaveType = "Annual"
        sd = get_leave_start_date(ipcomp, ipemp, ipLeaveType)
        upErrs = String.Empty
        upperiod = 0
        uptotalaccrual = 0
        uptotalaccum = 0
        uptotaltaken = 0
        uptotalcapitalized = 0
        uptotalvalcapitalized = 0
        upmoneyvalbalance = 0
        upactualbalance = 0
        prev_rule = 0
        losrule = False
        mos = 0
        wos = 0
        upCalcMethod = String.Empty
        max_hrs_days = 255
        max_pub_hols = 0
        maxperiods = 0
        current_period_num = 0
        uptotalfuture = 0
        period_end_date = Nothing
        rule_not_found = True
        max_adjustments = 0
        max_taken = 0
        upUnitOfMeassure = "?"
        uptotal_lost = 0
        ipDate = DateAdd("d", 1, ipDate)
        leave_value = 0
        maxsalary = 0
        maxaccrual = 0
        last_setbalance_date = New Date(1960, 1, 1)
        upCapitMethod = String.Empty
        maxaccrualstop = 0
        payfield_conversion_formula = String.Empty
        ignore_hist_prior = Nothing
        upnextlostdate = New Date(1960, 1, 1)
        upatrisk = 0
        maxloststop = 0
        termdate = Nothing
        lstworkdate = Nothing

        lastvalidused = New Date(1900, 1, 1)
        calculate_proportion = True

        If (IsNull(sd)) Then

            upErrs = "Leave start date not specified or leave type not applicable"

            Exit Sub

        End If

        'If ipLeaveScheme = "" Then ipLeaveScheme = get_leave_scheme(ipcomp, ipemp)

        If ipDate <= sd Then

            upErrs = "Leave calculation date is less than the leave start date"

            Exit Sub

        End If

        upcycle_leavesd = sd
        taken_sd = upcycle_leavesd
        taken_sd_begin = sd
        last_accrue_date = sd
        ' Check if there are Rules set up
        ' zaq ---------- old code >
        '  Rules.Open convert_sql_syntax("Select count(*) as tot FROM LeaveAccrualRules WHERE CompanyNum = '" & ipcomp & "' and Leave_Scheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "'"), AdoMainCon, adOpenForwardOnly, adLockReadOnly, adCmdText
        '  If GetSQLField(iLoop, Rules, "tot = 0 Then
        '    upErrs = "Leave rules not set up for scheme " & ipLeaveScheme & " and type " & ipLeaveType
        '    Rules.Close
        '    Exit Sub
        '  Else
        '    Rules.Close
        '  End If
        ' zaq ---------- old code >

        Dim sSQLTemp As String = String.Empty

        If ipLeaveScheme = String.Empty Then   ' Individual Leave Rules are used

            sSQLTemp = "Select count(*) as tot FROM PersonnelLeaveRules WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "'"

        Else

            sSQLTemp = "Select count(*) as tot FROM LeaveSchemeRules WHERE LeaveScheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "'"

        End If

        Dim sSQLFieldTemp As Object = GetSQLFieldObj(sSQLTemp, "tot")

        If ((sSQLFieldTemp = 0) Or (sSQLFieldTemp.Equals(Nothing))) Then

            If ipLeaveScheme = String.Empty Then   ' Individual Leave Rules are used
                upErrs = "Individual Leave rules has not been set up"
            Else
                upErrs = "Leave rules not set up for scheme " & ipLeaveScheme & " and type " & ipLeaveType
            End If

            Exit Sub

        End If

        ' Check if an appointment date is specified
        Snap = GetSQLDS("SELECT appointdate,DateJoinedGroup,TerminationDate,Termination,LastWorkingDay FROM Personnel INNER JOIN Personnel1 ON Personnel1.CompanyNum = Personnel.CompanyNum and Personnel1.EmployeeNum = Personnel.EmployeeNum WHERE Personnel.CompanyNum = '" & ipcomp & "' and Personnel.EmployeeNum = '" & ipemp & "'")
        groupdate = GetSQLField(0, Snap, "datejoinedgroup")
        If Not IsNull(GetSQLField(0, Snap, "LastWorkingDay")) Then lstworkdate = GetSQLField(0, Snap, "LastWorkingDay")
        If IsNull(GetSQLField(0, Snap, "appointdate")) Then
            apptdate = Nothing
        Else
            apptdate = GetSQLField(0, Snap, "appointdate")
            If GetSQLField(0, Snap, "Termination") <> 0 Then
                If Not IsNull(GetSQLField(0, Snap, "TerminationDate")) Then termdate = DateAdd("d", 1, GetSQLField(0, Snap, "TerminationDate"))
            End If
        End If
        Snap.Dispose()

        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "NOTE : In order to increase peformance, this report only reflects the Accruals and Adjustments and the Leave taken is deducted at the end." & vbCrLf & vbCrLf
        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "Appointment date : " & apptdate & vbCrLf

        If Not IsNull(groupdate) Then

            If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "Date Joined Group : " & groupdate & vbCrLf

        End If

        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "Leave start date : " & sd & vbCrLf

        ' Populate an array of the different validation dates of the rules
        ' zaq ---------- old code >
        '  maxrulevalid = 0
        '  Rules.Open convert_sql_syntax("Select distinct RuleValidUntil FROM LeaveAccrualRules WHERE CompanyNum = '" & ipcomp & "' and Leave_Scheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "' ORDER BY rulevaliduntil"), AdoMainCon, adOpenForwardOnly, adLockReadOnly, adCmdText
        '  Do While Not Rules.EOF
        '    maxrulevalid = maxrulevalid + 1
        '    ReDim Preserve rulevalid(maxrulevalid)
        '    rulevalid(maxrulevalid) = DateSerial(Format(GetSQLField(iLoop, Rules, "rulevaliduntil, "yyyy"), Format(GetSQLField(iLoop, Rules, "rulevaliduntil, "mm"), Format(GetSQLField(iLoop, Rules, "rulevaliduntil, "dd"))
        '    Rules.MoveNext
        '  Loop
        '  Rules.Close
        ' zaq ---------- old code >

        maxrulevalid = 0
        If ipLeaveScheme = String.Empty Then   ' Individual Leave Rules are used
            Rules = GetSQLDS("Select distinct RuleValidUntil FROM PersonnelLeaverules WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' ORDER BY rulevaliduntil")
        Else
            Rules = GetSQLDS("Select distinct RuleValidUntil FROM LeaveSchemeRules WHERE LeaveScheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "' ORDER BY rulevaliduntil")
        End If

        Dim iLoop As Integer

        If (IsData(Rules)) Then

            For iLoop = 0 To (Rules.Tables(0).Rows.Count - 1)

                maxrulevalid = maxrulevalid + 1
                ReDim Preserve rulevalid(maxrulevalid)
                rulevalid(maxrulevalid) = GetSQLField(iLoop, Rules, "rulevaliduntil")

            Next

            Rules.Dispose()

        End If

        ' Populate the leave adjustments array
        Snap = GetSQLDS("SELECT EffectiveDate, AdjustmentType,AdjustmentSubType, AdjustmentValue FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and EffectiveDate < '" & Format(DateAdd("d", 1, ipDate), "yyyy-MM-dd") & "' and AdjustmentType <> 'Capitalize Units'")

        If (IsData(Snap)) Then

            For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                max_adjustments = max_adjustments + 1
                ReDim Preserve adjust_date(max_adjustments)
                ReDim Preserve adjust_type(max_adjustments)
                ReDim Preserve adjust_subtype(max_adjustments)
                ReDim Preserve adjust_value(max_adjustments)

                adjust_date(max_adjustments) = DateValue(GetSQLField(iLoop, Snap, "EffectiveDate"))
                adjust_type(max_adjustments) = UCase(GetSQLField(iLoop, Snap, "AdjustmentType").ToString())
                If Not IsNull(GetSQLField(iLoop, Snap, "AdjustmentSubType")) Then adjust_subtype(max_adjustments) = GetSQLField(iLoop, Snap, "AdjustmentSubType") Else adjust_subtype(max_adjustments) = String.Empty
                adjust_value(max_adjustments) = GetSQLField(iLoop, Snap, "AdjustmentValue")

                If UCase(GetSQLField(iLoop, Snap, "AdjustmentType").ToString()) = "IGNORE HISTORY PRIOR" Then  ' Check if there is a 'Ignore History Prior' adjustment, which means we must ignore the history records prior to the effective date
                    ignore_hist_prior = GetSQLField(iLoop, Snap, "EffectiveDate")
                End If

            Next

            Snap.Dispose()

        End If

        ' Populate the leave accrual stop array
        Snap = GetSQLDS("SELECT EffectiveDate FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and AdjustmentType = 'Stop Accrual' and EffectiveDate <= '" & Format(ipDate, "yyyy-MM-dd") & "' ORDER BY EffectiveDate")

        If (IsData(Snap)) Then

            For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                maxaccrualstop = maxaccrualstop + 1
                ReDim Preserve accrualstopfrom(maxaccrualstop)
                ReDim Preserve accrualstopto(maxaccrualstop)

                accrualstopfrom(maxaccrualstop) = DateValue(GetSQLField(iLoop, Snap, "EffectiveDate"))

                Snap1 = GetSQLDS("SELECT EffectiveDate FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and AdjustmentType = 'Start Accrual' and EffectiveDate >= '" & Format(GetSQLField(iLoop, Snap, "EffectiveDate"), "yyyy-MM-dd") & "' ORDER BY EffectiveDate")

                If (Not IsData(Snap1)) Then
                    accrualstopto(maxaccrualstop) = ipDate
                ElseIf (Not IsNull(GetSQLField(0, Snap1, "EffectiveDate"))) Then
                    accrualstopto(maxaccrualstop) = DateValue(DateAdd("d", -1, GetSQLField(0, Snap1, "EffectiveDate")))
                End If

                Snap1.Dispose()

            Next

            Snap.Dispose()

        End If

        ' Populate the leave lost stop array
        Snap = GetSQLDS("SELECT EffectiveDate FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and AdjustmentType = 'Stop Lost' and EffectiveDate <= '" & Format(ipDate, "yyyy-MM-dd") & "' ORDER BY EffectiveDate")

        If (IsData(Snap)) Then

            For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                maxloststop = maxloststop + 1
                ReDim Preserve loststopfrom(maxloststop)
                ReDim Preserve loststopto(maxloststop)

                loststopfrom(maxloststop) = DateValue(GetSQLField(iLoop, Snap, "EffectiveDate"))
                Snap1 = GetSQLDS("SELECT EffectiveDate FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and AdjustmentType = 'Start Lost' and EffectiveDate >= '" & Format(GetSQLField(iLoop, Snap, "EffectiveDate"), "yyyy-MM-dd") & "' ORDER BY EffectiveDate")
                If (Not IsData(Snap1)) Then
                    loststopto(maxloststop) = ipDate
                Else
                    loststopto(maxloststop) = DateValue(DateAdd("d", -1, GetSQLField(iLoop, Snap1, "EffectiveDate")))
                End If

                Snap1.Dispose()

            Next

            Snap.Dispose()

        End If

        ' Populate the Leave Taken array
        If IsNull(ignore_hist_prior) Then
            Snap = GetSQLDS("SELECT StartDate,EndDate, Duration FROM Leave WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate < '" & Format(DateAdd("d", 1, ipDate), "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted' ORDER BY StartDate")
        Else
            Snap = GetSQLDS("SELECT StartDate,EndDate, Duration FROM Leave WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate < '" & Format(DateAdd("d", 1, ipDate), "yyyy-MM-dd") & "' and StartDate >= '" & Format(ignore_hist_prior, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted' ORDER BY StartDate")
        End If

        If (IsData(Snap)) Then

            For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                max_taken = max_taken + 1
                ReDim Preserve taken_date(max_taken)
                ReDim Preserve taken_amount(max_taken)
                ReDim Preserve taken_to_date(max_taken)

                If max_taken > 1 Then
                    ' If days are taken on the same day, add them together
                    If taken_date(max_taken - 1) = DateValue(GetSQLField(iLoop, Snap, "startdate")) Then
                        taken_amount(max_taken - 1) = taken_amount(max_taken - 1) + GetSQLField(iLoop, Snap, "Duration")
                        max_taken = max_taken - 1
                    Else
                        taken_date(max_taken) = DateValue(GetSQLField(iLoop, Snap, "startdate"))
                        If Not IsNull(GetSQLField(iLoop, Snap, "EndDate")) Then taken_to_date(max_taken) = DateValue(GetSQLField(iLoop, Snap, "EndDate"))
                        If IsNull(GetSQLField(iLoop, Snap, "Duration")) Then taken_amount(max_taken) = 0 Else taken_amount(max_taken) = GetSQLField(iLoop, Snap, "Duration")
                    End If
                Else
                    taken_date(max_taken) = DateValue(GetSQLField(iLoop, Snap, "startdate"))
                    If Not IsNull(GetSQLField(iLoop, Snap, "EndDate")) Then taken_to_date(max_taken) = DateValue(GetSQLField(iLoop, Snap, "EndDate"))
                    If IsNull(GetSQLField(iLoop, Snap, "Duration")) Then taken_amount(max_taken) = 0 Else taken_amount(max_taken) = GetSQLField(iLoop, Snap, "Duration")
                End If

            Next

            Snap.Dispose()

        End If

        ' Populate this same leave taken array for the Capitalisation part, BUT set the taken_to_date to 1/1/1960 to indicate that it is a Capitalisation
        Snap = GetSQLDS("SELECT EffectiveDate, AdjustmentValue FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and EffectiveDate < '" & Format(DateAdd("d", 1, ipDate), "yyyy-MM-dd") & "' and AdjustmentType = 'Capitalize Units'")

        If (IsData(Snap)) Then

            For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                max_taken = max_taken + 1
                ReDim Preserve taken_date(max_taken)
                ReDim Preserve taken_amount(max_taken)
                ReDim Preserve taken_to_date(max_taken)

                taken_date(max_taken) = GetSQLField(iLoop, Snap, "EffectiveDate")
                taken_amount(max_taken) = GetSQLField(iLoop, Snap, "AdjustmentValue")
                taken_to_date(max_taken) = New Date(1960, 1, 1)
            Next

            Snap.Dispose()

        End If

        ' ===========================================================
        ' ===========================================================
        ' Loop through each date and match which accrual rule applies
        ' ===========================================================
        ' ===========================================================
        x_amount = 0
        tmpdt = sd
        Do
            ' Build the array of rules for the specific validation date
            If tmpdt > lastvalidused Then
                tmpflag = False
                For tmpi = 1 To maxrulevalid
                    If tmpdt <= rulevalid(tmpi) Then
                        populate_leave_rules_array(ipcomp, ipemp, ipLeaveScheme, ipLeaveType, ipDate, groupdate, upErrs, max_hrs_days, upUnitOfMeassure, upactualbalance, ipDate, uptotalfuture, sd, uptotaltaken, losrule, maxperiods, payfield_conversion_formula, calc_on_present_sal, servicetype, serviceinterval, dtjoinedgroup, accrueamount, accrueunit, accruetype, accruetypeamount, periodtype, periodlength, periodnumber, rulename, rulevaliduntil, allowaccum, maxaccum, maxaccumgracelen, maxaccumgracetyp, atriskstartdate, totmaxaccum, tmaxaccumgracelen, tmaxaccumgracetyp, maxtotbalance, paytemplate, fieldname, maxrules, rulevalid(tmpi), maxsalary, salary_as_at_date, salary, salarytcp, salary_template, salary_field, wh_validfrom, wh_hrs, max_pub_hols, pub_hols)
                        If prev_rule > maxrules Then prev_rule = maxrules ' 14/04/2005 : Was getting a Subscript Out Of Range error with ZamBrew
                        lastvalidused = rulevalid(tmpi)
                        tmpflag = True
                        Exit For
                    End If
                Next tmpi
                If Not tmpflag Then
                    upErrs = "No Leave Rules from " & tmpdt
                    Exit Sub
                End If
            End If

            ' Determine if the "at risk" leave needs to become "lost"
            ' -------------------------------------------------------
            If tmpdt = upnextlostdate Then
                ' Check if there were any leave taken between the 2 dates
                tmpd = 0  ' Count the total number taken within timeframe, including capitalisations
                tmpd1 = 0 ' Count the number of capitalisations only
                For tmpi = 1 To max_taken
                    If taken_date(tmpi) >= atriskstartdate And taken_date(tmpi) < upnextlostdate Then
                        tmpd = tmpd + taken_amount(tmpi)
                        If taken_to_date(tmpi) = New Date(1960, 1, 1) Then tmpd1 = tmpd1 + taken_amount(tmpi) ' Only the capitalisations
                    End If
                Next tmpi
                If tmpd < upatrisk Then   ' Leave now becomes LOST
                    uptotal_lost = uptotal_lost + upatrisk - tmpd
                    uptotalaccrual = uptotalaccrual - (upatrisk - tmpd)
                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : The Leave At Risk has not been taken/capitalized within the stipulated timeframe. " & upatrisk - tmpd & " " & upUnitOfMeassure & " Lost." & vbCrLf

                    ' Calculate the monetary value of the Lost leave
                    tmpd3 = uptotalaccrual - tmpd + tmpd1   ' Balance remaining
                    tmpd1 = upatrisk - tmpd   ' Lost part
                    tmpd2 = tmpd1   ' Temporary variable for Leave Statment later on
                    calc_monetary_value(upUnitOfMeassure, tmpdt, tmpd1, delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary, ipShowCapitMethod)

                    ' Add the Capitalisations as it is absorbed by the Accumulated Balance
                    upatrisk = 0
                Else
                    upatrisk = 0  ' Enough leave has been taken or Capitalized
                End If
            End If

            If tmpdt = New Date(2005, 08, 1) Then                 ' For testing purposes : enter as yyyy-MM-dd
                tmpdt = tmpdt
            End If

            ' Go through the rules and find the first accrual rule that matches current date (tmpdt)
            ' --------------------------------------------------------------------------------------
            found = False
            tmpb = False
            balance_set = False
            For idx = 1 To maxrules
                If losrule Then
                    If Not dtjoinedgroup(idx) Then appointdate = apptdate Else appointdate = groupdate
                    If (termdate > tmpdt Or IsNull(termdate)) And servicetype(idx) <> "Week(s)" Then los = calculate_service_length(appointdate, tmpdt) Else los = calculate_service_length(appointdate, termdate)
                    ' Get the length of service in months
                    If servicetype(idx) = "Week(s)" Then
                        If termdate > tmpdt Or IsNull(termdate) Then los = calculate_service_length_weeks(appointdate, tmpdt) Else los = calculate_service_length_weeks(appointdate, termdate)
                        wos = (Val(Mid$(los, 1, InStr(1, los, "weeks", 1) - 1)))
                    Else
                        mos = (Val(Mid$(los, 1, InStr(1, los, "years", 1) - 1)) * 12) + Val(Mid$(los, InStr(1, los, "years", 1) + 6, 2))
                    End If
                End If

                ' Check against the rule validation date
                If tmpdt <= rulevaliduntil(idx) Then
                    ' If there is a length of service interval
                    If serviceinterval(idx) <> -999 Then
                        ' ... and the rule is within the length of service
                        If servicetype(idx) = "Week(s)" Then
                            If wos <= serviceinterval(idx) Then
                                found = True
                                tmpb = True
                            End If
                        Else
                            If mos < serviceinterval(idx) Then
                                found = True
                                tmpb = True
                            End If

                            ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule
                            If Not found And serviceinterval(idx) Mod 12 = 0 And mos Mod 12 = 0 And mos > 0 And idx >= prev_rule And mos <= serviceinterval(idx) Then   ' Previously the part of the And was los = "1 years 0 months"
                                found = True
                                tmpb = True
                            End If

                        End If
                        ' If there is NOT a length of service interval
                    Else
                        tmpb = True
                    End If
                    ' If the rule stipulates a cycle, deal with the specific requirements for a period of that cycle
                    If periodtype(idx) <> String.Empty And tmpb Then
                        If (tmpdt = period_end_date Or IsNull(period_end_date)) Then
                            current_period_num = current_period_num + 1
                            If IsNull(period_end_date) Then
                                uptotalaccrual = 0   ' Reset back to 0
                                upcycle_leavesd = tmpdt
                                taken_sd = upcycle_leavesd
                            End If
                            If current_period_num = maxperiods + 1 Then
                                current_period_num = 1
                                ' Determine if this leave rule need to keep track of the total accumulated
                                ' NNB : Changed on 22/11/2002 - Everything in this section used to look at the current rule (idx), but I have changed it to look at the previous rule (prev_rule) as it still falls under the previous rule's definition
                                If allowaccum(prev_rule) Then
                                    '19/11/2002 : Add this part as leave can accrue on this specific day, but only if it is not an upfront accrual rule
                                    ' 14/06/2004 : In the case of Bank Windhoek where leave was accrued on the first day of each month, this accrual caused a cycle length of 13 months and not 12, and in the 2nd cycle the accrual was only counted from the 2nd month
                                    If UCase(accruetype(prev_rule)) <> "UPFRONT EVERY X MONTH(S)" And UCase(accruetype(prev_rule)) <> "FIRST DAY OF EACH MONTH" Then
                                        do_accrual_and_value(accruedate, accrual, prevaccrual, accrualsalary, accrualsalarytcp, maxaccrual, salary_template, salary_field, salary_as_at_date, salary, salarytcp, maxsalary, paytemplate, fieldname, leave_value, value_remark, max_hrs_days, tmp_tot_taken, taken_date, taken_to_date, taken_amount, max_taken, taken_sd, wh_validfrom, wh_hrs, pub_hols, max_pub_hols, rule_not_found, idx, termdate, last_accrue_date, last_setbalance_date, prev_rule, upcycle_leavesd, x_amount, found, delta, tmpdt, tmpb, tmps, tmpi, tmpd, rulename, allowaccum, accrueunit, accruetype, accruetypeamount, accrueamount, upCalcMethod, uptotalaccrual, upErrs, ipBuildLeaveStmt, accrualstopfrom, accrualstopto, maxaccrualstop, maxtotbalance, uptotaltaken, uptotalaccum, ipShowCalcMethod)
                                        If found Then
                                            ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule, I now count all the accruals
                                            accruecount = accruecount + 1
                                        End If
                                    End If

                                    ' Get the total taken portion during this time
                                    If IsNull(ignore_hist_prior) Then
                                        Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(taken_sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
                                    Else
                                        Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(taken_sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and StartDate >= '" & Format(ignore_hist_prior, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
                                    End If
                                    If Not IsNull(GetSQLField(0, Snap, "tot")) Then
                                        ' Leave statement

                                        accruecount = 0  ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule

                                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Accumulated total = " & Math.Round(CSng(uptotalaccum), 4) & " + " & Math.Round(uptotalaccrual, 4) & " (accrued) - " & GetSQLField(0, Snap, "tot") & " (taken) = "
                                        delta = uptotalaccrual - GetSQLField(0, Snap, "tot")
                                        uptotalaccum = uptotalaccum + delta
                                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & Math.Round(CSng(uptotalaccum), 4) & vbCrLf
                                    Else

                                        accruecount = 0   ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule

                                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Accumulated total = " & Math.Round(CSng(uptotalaccum), 4) & " + " & uptotalaccrual & " (accrued) - 0 (taken) = "
                                        delta = uptotalaccrual
                                        uptotalaccum = uptotalaccum + delta
                                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & Math.Round(CSng(uptotalaccum), 3) & vbCrLf
                                    End If
                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Accumulated total = " & Math.Round(CSng(uptotalaccum), 4) & vbCrLf
                                    ' If the accumulated total goes into a negative, adjust to 0 and set the next balance to a negative
                                    If uptotalaccum < 0 Then
                                        uptotalaccrual = uptotalaccum
                                        uptotalaccum = 0     ' Reset back to 0
                                        ' Leave statement
                                        accruecount = 0   ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule
                                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : Accumulated Balance cannot be negative, set next starting balance to negative." & vbCrLf & "    Accumulated total = 0" & vbCrLf
                                    Else
                                        uptotalaccrual = 0   ' Reset back to 0
                                    End If
                                    tmp_tot_taken = 0   ' Otherwise the display is wrong on the leave statement as it also adds the days taken before the Accum date

                                    ' If a maximum accumulation is specified, check that it falls within the max.
                                    ' ---------------------------------------------------------------------------
                                    If maxaccum(prev_rule) >= 0 Then
                                        If delta > 0 And delta > maxaccum(prev_rule) Then
                                            ' Check if Leave Lost is stopped
                                            tmpflag = True
                                            For tmpi2 = 1 To maxloststop
                                                If tmpdt >= loststopfrom(tmpi2) And tmpdt <= loststopto(tmpi2) Then
                                                    tmpflag = False
                                                    Exit For
                                                End If
                                            Next tmpi2

                                            ' Detemine if this leave must go at risk
                                            If tmpflag Then
                                                If maxaccumgracetyp(prev_rule) <> String.Empty And maxaccumgracelen(prev_rule) > 0 Then
                                                    If UCase(maxaccumgracetyp(prev_rule)) = "DAY(S)" Then upnextlostdate = DateAdd("d", maxaccumgracelen(prev_rule), tmpdt)
                                                    If UCase(maxaccumgracetyp(prev_rule)) = "MONTH(S)" Then upnextlostdate = DateAdd("m", maxaccumgracelen(prev_rule), tmpdt)
                                                    If UCase(maxaccumgracetyp(prev_rule)) = "WEEK(S)" Then upnextlostdate = DateAdd("ww", maxaccumgracelen(prev_rule), tmpdt)
                                                    upatrisk = delta - maxaccum(prev_rule)
                                                    atriskstartdate = tmpdt
                                                    uptotalaccum = uptotalaccum - upatrisk
                                                    uptotalaccrual = uptotalaccrual + upatrisk
                                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : A maximum of " & maxaccum(prev_rule) & " " & upUnitOfMeassure & " can be accum. " & Math.Round(upatrisk, 4) & " is at risk and must be taken/capitalized with the next " & maxaccumgracelen(prev_rule) & " " & maxaccumgracetyp(prev_rule) & ". New accum balance = " & uptotalaccum & vbCrLf
                                                    ' Leave statement
                                                    ' Calculate the monetary value of the Lost leave
                                                    'tmpd2 = upatrisk
                                                    'calc_monetary_value upUnitOfMeassure, tmpdt, tmpd2, delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary
                                                    'leave_value = leave_value + tmpd  ' The leave is not lost yet
                                                    ' 11/02/2003 Cannot calculate the value as it then sets the values as if the leave has been taken

                                                Else
                                                    tmpd1 = delta - maxaccum(prev_rule)
                                                    uptotal_lost = uptotal_lost + tmpd1
                                                    uptotalaccum = uptotalaccum - (tmpd1)
                                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : A maximum of " & maxaccum(prev_rule) & " " & upUnitOfMeassure & " can be accumulated. " & Math.Round(tmpd1, 4) & " Lost. New accum balance = " & uptotalaccum & vbCrLf
                                                    ' Leave statement
                                                    ' Calculate the monetary value of the Lost leave
                                                    calc_monetary_value(upUnitOfMeassure, tmpdt, delta - maxaccum(prev_rule), delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary, ipShowCapitMethod)
                                                End If
                                            Else
                                                ' Leave statement
                                            End If
                                        End If
                                    End If

                                    ' If a Total maximum accumulation is specified check that it falls within the total maximum
                                    ' -----------------------------------------------------------------------------------------
                                    If totmaxaccum(prev_rule) >= 0 Then
                                        If uptotalaccum > totmaxaccum(prev_rule) Then
                                            ' Check if Leave Lost is stopped
                                            tmpflag = True
                                            For tmpi2 = 1 To maxloststop
                                                If tmpdt >= loststopfrom(tmpi2) And tmpdt <= loststopto(tmpi2) Then
                                                    tmpflag = False
                                                    Exit For
                                                End If
                                            Next tmpi2

                                            ' Detemine if this leave must go at risk
                                            If tmpflag Then
                                                If tmaxaccumgracetyp(prev_rule) <> String.Empty And tmaxaccumgracelen(prev_rule) > 0 Then
                                                    If UCase(tmaxaccumgracetyp(prev_rule)) = "DAY(S)" Then upnextlostdate = DateAdd("d", tmaxaccumgracelen(prev_rule), tmpdt)
                                                    If UCase(tmaxaccumgracetyp(prev_rule)) = "MONTH(S)" Then upnextlostdate = DateAdd("m", tmaxaccumgracelen(prev_rule), tmpdt)
                                                    If UCase(tmaxaccumgracetyp(prev_rule)) = "WEEK(S)" Then upnextlostdate = DateAdd("ww", tmaxaccumgracelen(prev_rule), tmpdt)
                                                    tmpd1 = uptotalaccum - totmaxaccum(prev_rule)
                                                    upatrisk = upatrisk + tmpd1
                                                    atriskstartdate = tmpdt
                                                    uptotalaccum = uptotalaccum - tmpd1
                                                    uptotalaccrual = uptotalaccrual + tmpd1
                                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : A total maximum of " & totmaxaccum(prev_rule) & " " & upUnitOfMeassure & " can be accum. " & Math.Round(tmpd1, 4) & " is at risk and must be taken/capitalized with the next " & tmaxaccumgracelen(prev_rule) & " " & tmaxaccumgracetyp(prev_rule) & ". New accum balance = " & uptotalaccum & vbCrLf
                                                    ' Leave statement
                                                    ' Calculate the monetary value of the Lost leave
                                                    'tmpd2 = tmpd1
                                                    'calc_monetary_value upUnitOfMeassure, tmpdt, tmpd2, delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary
                                                    'leave_value = leave_value + tmpd  ' The leave is not lost yet
                                                    ' 11/02/2003 Cannot calculate the value as it then sets the values as if the leave has been taken

                                                Else
                                                    delta = uptotalaccum - totmaxaccum(prev_rule)
                                                    tmpd1 = delta   ' Lost
                                                    tmpd2 = tmpd1   ' Lost
                                                    uptotal_lost = uptotal_lost + delta
                                                    uptotalaccum = totmaxaccum(idx)

                                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : A Total maximum of " & totmaxaccum(prev_rule) & " " & upUnitOfMeassure & " can be accumulated. " & Math.Round(tmpd1, 4) & " Lost. New accum balance = " & uptotalaccum & vbCrLf
                                                    ' Leave statement
                                                    ' Calculate the monetary value of the Lost leave
                                                    calc_monetary_value(upUnitOfMeassure, tmpdt, tmpd2, delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary, ipShowCapitMethod)
                                                End If
                                            Else
                                                ' Leave statement
                                            End If
                                        End If
                                    End If

                                    Snap.Dispose()
                                Else
                                    ' Make a special provision for the Week(s) as service interval and Service Type
                                    If servicetype(prev_rule) = "Week(s)" And periodtype(prev_rule) = "Week(s)" Then
                                        uptotalaccrual = uptotalaccrual - tmp_tot_taken
                                    Else
                                        uptotalaccrual = 0   ' Reset back to 0
                                        tmp_tot_taken = 0    ' 30/09/2003 : See Mobil leave statement that did not show balance correctly reported by Margaret
                                        leave_value = 0      ' 26/01/2004 : See Marsh Bonus leave problem, specifically the Monetary value
                                    End If
                                End If
                                upcycle_leavesd = tmpdt
                                taken_sd = upcycle_leavesd
                            End If
                            For tmpi = idx To maxrules
                                If periodnumber(tmpi) = current_period_num Then
                                    ' Get the next period end date
                                    Select Case UCase(periodtype(tmpi))
                                        Case "YEAR(S)" : period_end_date = DateAdd("yyyy", periodlength(tmpi), tmpdt)
                                        Case "MONTH(S)" : period_end_date = DateAdd("m", periodlength(tmpi), tmpdt)
                                        Case "WEEK(S)" : period_end_date = DateAdd("ww", periodlength(tmpi), tmpdt)
                                        Case "DAY(S)" : period_end_date = DateAdd("d", periodlength(tmpi), tmpdt)
                                    End Select
                                    idx = tmpi
                                    found = True
                                    Exit For
                                End If
                            Next tmpi
                        Else
                            ' If the case is that a rule within a period and the period_end_Date has not yet been reached, take the last rule as the specific rule in action
                            If Not IsNull(period_end_date) And prev_rule > 0 Then
                                ' Anton 09/09/2010 : Calculate the periodlength  ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule
                                Select Case UCase(periodtype(prev_rule))
                                    Case "YEAR(S)" : periodlengthmonths = periodlength(prev_rule) * 12
                                    Case "MONTH(S)" : periodlengthmonths = periodlength(prev_rule)
                                    Case "WEEK(S)" : periodlengthmonths = 0
                                    Case "DAY(S)" : periodlengthmonths = 0
                                End Select
                                If periodlengthmonths > 0 Then   ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule
                                    If accruecount Mod periodlengthmonths = 0 And accruecount <> periodlengthmonths And accruecount <> 0 Then   ' Anton 09/09/2010 : Previously it was only this : idx = prev_rule
                                        idx = prev_rule
                                    End If
                                Else
                                    idx = prev_rule
                                End If
                                found = True
                                Exit For
                            End If
                        End If
                    Else
                        'If maxrules = 1 And serviceinterval(idx) = -999 Then found = True  ' If there is one rule with nou appt date match, take that rule
                        If maxrules >= 1 And serviceinterval(idx) = -999 Then found = True ' If there is at least one rule with nou appt date match, take that rule
                        'found = True
                        'Exit For
                    End If
                    If found Then Exit For
                End If
            Next idx

            ' ==========================================
            ' ==========================================
            ' Rule is found, check for Accrue Type match
            ' ==========================================
            ' ==========================================
            If found Then
                If idx > maxrules Then   ' 19/04/2004 : Problem at Atlas Copco with the move from old leave rules into new ones eg. Rules 1 - 2 is valid until 30/04/2004 and Rule 3 is valid from there onwards, then idx was set at 2 as a rsult of the idx = prev_rule statement earlier on
                    idx = maxrules
                    prev_rule = maxrules
                End If
                If last_accrue_date <> tmpdt Or sd = tmpdt Then   ' 03/05/2004 : Caused a problem with LIW Long Service where this procedure is called before, and the employee gets 2 accruals. The OR part is necessary for the FIRST accrual when leave is get Upfront
                    do_accrual_and_value(accruedate, accrual, prevaccrual, accrualsalary, accrualsalarytcp, maxaccrual, salary_template, salary_field, salary_as_at_date, salary, salarytcp, maxsalary, paytemplate, fieldname, leave_value, value_remark, max_hrs_days, tmp_tot_taken, taken_date, taken_to_date, taken_amount, max_taken, taken_sd, wh_validfrom, wh_hrs, pub_hols, max_pub_hols, rule_not_found, idx, termdate, last_accrue_date, last_setbalance_date, prev_rule, upcycle_leavesd, x_amount, found, delta, tmpdt, tmpb, tmps, tmpi, tmpd, rulename, allowaccum, accrueunit, accruetype, accruetypeamount, accrueamount, upCalcMethod, uptotalaccrual, upErrs, ipBuildLeaveStmt, accrualstopfrom, accrualstopto, maxaccrualstop, maxtotbalance, uptotaltaken, uptotalaccum, ipShowCalcMethod)

                    If found Then
                        ' Anton 09/09/2010 Fix the issue of the cycle of 1 year and monthly accruals but first cycle only gives 11 accruals before switching to the next rule, I now count all the accruals
                        accruecount += 1
                    End If

                End If
                prev_rule = idx ' See reference 18/11/2003 : Caused a problem if 2 leave cycles and 2 rules and for first cycle, max accum is taken of the 2nd rule instead of the 1st rule. Refer Megan at RMB

            End If

            ' Check if there are any adjustments for this date
            ' ------------------------------------------------
            If max_adjustments > 0 Then
                For tmpi = 1 To max_adjustments
                    If tmpdt = adjust_date(tmpi) Then
                        Select Case adjust_type(tmpi)
                            Case "ADJUSTMENT"
                                uptotalaccrual = uptotalaccrual + adjust_value(tmpi)
                                ' Calculate the monetary value of this adjustment based on the salary at that point in time
                                tmpd = 0   ' Value of that adjustment
                                If idx > maxrules Then idx = maxrules ' 08/04/2003 : Error if there is no rule that matches this date
                                For tmpi1 = maxsalary To 1 Step -1
                                    If tmpdt >= salary_as_at_date(tmpi1) And salary_template(tmpi1) = paytemplate(idx) And salary_field(tmpi1) = fieldname(idx) Then
                                        tmpd = (adjust_value(tmpi) * salary(tmpi1))
                                        leave_value = leave_value + tmpd
                                        value_remark = "Value = " & adjust_value(tmpi) & " x " & Math.Round(CSng(salary(tmpi1)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(tmpi1)), 2) & ") = " & Math.Round(tmpd, 2) & "  New total value = " & Format(leave_value, NumericFormat)
                                        Exit For
                                    End If
                                Next tmpi1
                                If adjust_subtype(tmpi) = String.Empty Then
                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjustment : " & adjust_value(tmpi)
                                Else
                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjustment (" & adjust_subtype(tmpi) & ") : " & adjust_value(tmpi)
                                End If
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New total = " & uptotalaccrual
                                ' Leave statement
                                If adjust_subtype(tmpi) = String.Empty Then
                                Else
                                End If
                                ' Add it to the Accrual array
                                maxaccrual = maxaccrual + 1
                                ReDim Preserve accruedate(maxaccrual)
                                ReDim Preserve accrual(maxaccrual)
                                ReDim Preserve prevaccrual(maxaccrual)
                                ReDim Preserve accrualsalary(maxaccrual)
                                ReDim Preserve accrualsalarytcp(maxaccrual)
                                accruedate(maxaccrual) = tmpdt
                                accrual(maxaccrual) = adjust_value(tmpi)
                                prevaccrual(maxaccrual) = accrual(maxaccrual)
                                If tmpi1 > 0 Then accrualsalary(maxaccrual) = salary(tmpi1) Else accrualsalary(maxaccrual) = 0
                                If tmpi1 > 0 Then accrualsalarytcp(maxaccrual) = salarytcp(tmpi1) Else accrualsalarytcp(maxaccrual) = 0


                            Case "SET LEAVE BALANCE"
                                ' If the latest accrual rule stipulates "Bypass Calculation", then it means the balance is coming from payroll and the monetary value needs to be reset to 0
                                If InStr(1, accruetype(prev_rule), "bypass", vbTextCompare) <> 0 Then
                                    leave_value = 0
                                End If
                                ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                tmpd1 = 0
                                upatrisk = 0   ' 07/07/2003 : Reset the at risk and total lost
                                uptotal_lost = 0
                                value_remark = String.Empty
                                If calc_on_present_sal And maxsalary > 0 Then
                                    tmpd1 = salary(maxsalary) * adjust_value(tmpi)
                                    value_remark = "Value = " & adjust_value(tmpi) & " x " & Math.Round(CSng(salary(maxsalary)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(maxsalary)), 2) & ") = " & Math.Round(tmpd1, 2)
                                    leave_value = leave_value + tmpd1
                                End If

                                last_accrue_date = tmpdt      ' This fixes up Megan's problem at RMB whereby they define their SET BALANCE as the balance that includes to proportionate accrual. Eg. person must get 2 days accrual on the 15th. Balance is set on the 1st of the next month, now this balance includes the accrual as from the previous month
                                last_setbalance_date = tmpdt  ' In conjunction with the above
                                uptotalaccrual = adjust_value(tmpi)
                                taken_sd = tmpdt ' Set the new date from which leave taken must be calculated
                                taken_sd_begin = tmpdt
                                uptotalaccrual = adjust_value(tmpi)
                                uptotalvalcapitalized = 0

                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Set balance to : " & adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New total = " & uptotalaccrual & vbCrLf
                                ' Leave statement
                                tmp_tot_taken = 0
                                balance_set = True
                                ' Fix up the array for the Capitalisation part  Code fragment id 1234; used twice in this procedure
                                ' -------------------------------------------------------------------------------------------------
                                If maxaccrual = 0 Then
                                    maxaccrual = maxaccrual + 1
                                    ReDim Preserve accruedate(maxaccrual)
                                    ReDim Preserve accrual(maxaccrual)
                                    ReDim Preserve prevaccrual(maxaccrual)
                                    ReDim Preserve accrualsalary(maxaccrual)
                                    ReDim Preserve accrualsalarytcp(maxaccrual)
                                    accruedate(maxaccrual) = tmpdt
                                    accrual(maxaccrual) = adjust_value(tmpi)
                                    prevaccrual(maxaccrual) = accrual(maxaccrual)
                                    ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                    If calc_on_present_sal And maxsalary > 0 Then
                                        accrualsalary(maxaccrual) = salary(maxsalary)   ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        accrualsalarytcp(maxaccrual) = salarytcp(maxsalary)
                                    Else
                                        accrualsalary(maxaccrual) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        accrualsalarytcp(maxaccrual) = 0
                                    End If
                                Else
                                    tmpflag = False
                                    For tmpi1 = 1 To maxaccrual
                                        ' Set all the previous accruals to 'cancelled'
                                        If accruedate(tmpi1) < tmpdt Then
                                            accrual(tmpi1) = 0
                                            prevaccrual(tmpi1) = accrual(tmpi1)
                                        End If
                                        If accruedate(tmpi1) = tmpdt Then
                                            accrual(tmpi1) = uptotalaccum + adjust_value(tmpi)  ' 23/05/2003 : Was before :  accrual(tmpi1) = adjust_value(tmpi); but also add the Accumulated balance so that the value is calculated correctly
                                            prevaccrual(tmpi1) = accrual(tmpi1)
                                            tmpflag = True
                                            Exit For
                                        End If
                                    Next tmpi1
                                    ' If the exact date was not found, we must insert it
                                    If Not tmpflag Then
                                        ' Find the date where this record must be inserted (actually it should always be at the end because at this point in time there are no accruals in the array, but lets just do it for safety sake)
                                        For tmpi1 = 1 To maxaccrual
                                            If accruedate(tmpi1) > tmpdt Then Exit For
                                        Next tmpi1
                                        maxaccrual = maxaccrual + 1
                                        ReDim Preserve accruedate(maxaccrual)
                                        ReDim Preserve accrual(maxaccrual)
                                        ReDim Preserve prevaccrual(maxaccrual)
                                        ReDim Preserve accrualsalary(maxaccrual)
                                        ReDim Preserve accrualsalarytcp(maxaccrual)
                                        For tmpi2 = tmpi1 To maxaccrual - 1
                                            accruedate(tmpi2) = accruedate(tmpi2 + 1)
                                            accrual(tmpi2) = accrual(tmpi2 + 1)
                                            prevaccrual(tmpi2) = prevaccrual(tmpi2 + 1)
                                            accrualsalary(tmpi2) = accrualsalary(tmpi2 + 1)
                                            accrualsalarytcp(tmpi2) = accrualsalarytcp(tmpi2 + 1)
                                        Next tmpi2
                                        accruedate(tmpi1) = tmpdt
                                        accrual(tmpi1) = adjust_value(tmpi)
                                        prevaccrual(tmpi1) = accrual(tmpi1)
                                        ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                        If calc_on_present_sal And maxsalary > 0 Then
                                            accrualsalary(tmpi1) = salary(maxsalary)   ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                            accrualsalarytcp(tmpi1) = salarytcp(maxsalary)
                                        Else
                                            accrualsalary(tmpi1) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                            accrualsalarytcp(tmpi1) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        End If
                                    End If
                                End If


                            Case "DAYS WORKED"
                                x_amount = x_amount + adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Days worked : " & adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New balance of days worked = " & x_amount

                            Case "HOURS WORKED"
                                x_amount = x_amount + adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Hours worked : " & adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New balance of hours worked = " & x_amount

                            Case "ADJUST ACCUM BALANCE"
                                uptotalaccum = uptotalaccum + adjust_value(tmpi)

                                ' 20/05/2003 : Calculate the monetary value of this adjustment based on the salary at that point in time
                                tmpd = 0   ' Value of that adjustment
                                If idx > maxrules Then idx = maxrules ' 08/04/2003 : Error if there is no rule that matches this date
                                For tmpi1 = maxsalary To 1 Step -1
                                    If tmpdt >= salary_as_at_date(tmpi1) And salary_template(tmpi1) = paytemplate(idx) And salary_field(tmpi1) = fieldname(idx) Then
                                        tmpd = (adjust_value(tmpi) * salary(tmpi1))
                                        leave_value = leave_value + tmpd
                                        value_remark = "Value = " & adjust_value(tmpi) & " x " & Math.Round(CSng(salary(tmpi1)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(tmpi1)), 2) & ") = " & Math.Round(tmpd, 2) & "  New total value = " & Format(leave_value, NumericFormat)
                                        Exit For
                                    End If
                                Next tmpi1
                                If adjust_subtype(tmpi) = String.Empty Then
                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Accum Bal Adjustment : " & adjust_value(tmpi)
                                Else
                                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Accum Bal Adjustment (" & adjust_subtype(tmpi) & ") : " & adjust_value(tmpi)
                                End If
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New accumulated balance = " & uptotalaccum
                                ' Leave statement
                                If adjust_subtype(tmpi) = String.Empty Then
                                Else
                                End If
                                ' Add it to the Accrual array
                                maxaccrual = maxaccrual + 1
                                ReDim Preserve accruedate(maxaccrual)
                                ReDim Preserve accrual(maxaccrual)
                                ReDim Preserve prevaccrual(maxaccrual)
                                ReDim Preserve accrualsalary(maxaccrual)
                                ReDim Preserve accrualsalarytcp(maxaccrual)
                                accruedate(maxaccrual) = tmpdt
                                accrual(maxaccrual) = adjust_value(tmpi)
                                prevaccrual(maxaccrual) = accrual(maxaccrual)
                                If tmpi1 > 0 Then accrualsalary(maxaccrual) = salary(tmpi1) Else accrualsalary(maxaccrual) = 0
                                If tmpi1 > 0 Then accrualsalarytcp(maxaccrual) = salarytcp(tmpi1) Else accrualsalarytcp(maxaccrual) = 0

                                'If adjust_subtype(tmpi) = "" Then
                                '  if ipShowCalcMethod then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjust Accumulated Balance : " & adjust_value(tmpi)
                                'Else
                                '  if ipShowCalcMethod then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjust Accumulated Balance (" & adjust_subtype(tmpi) & ") : " & adjust_value(tmpi)
                                'End If
                                'if ipShowCalcMethod then upCalcMethod = upCalcMethod & " New accumulated balance = " & uptotalaccum
                                '' Leave statement
                                'If ipBuildLeaveStmt Then
                                '  If adjust_subtype(tmpi) = "" Then
                                '    if not fgrid) then fgrid.AddItem vbTab & tmpdt & vbTab & "Adjust Accum Balance" & vbTab & adjust_value(tmpi) & vbTab & CDec(uptotalaccrual - tmp_tot_taken) & vbTab & vbTab & Format(leave_value, NumericFormat) & vbTab & "New accumulated balance = " & uptotalaccum
                                '  Else
                                '    if not fgrid) then fgrid.AddItem vbTab & tmpdt & vbTab & "Adjust Accum Balance (" & adjust_subtype(tmpi) & ")" & vbTab & adjust_value(tmpi) & vbTab & CDec(uptotalaccrual - tmp_tot_taken) & vbTab & vbTab & Format(leave_value, NumericFormat) & vbTab & "New accumulated balance = " & uptotalaccum
                                '  End If
                                'End If

                            Case "SET ACCUM BALANCE"
                                ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                tmpd1 = 0
                                value_remark = String.Empty
                                If calc_on_present_sal And maxsalary > 0 Then
                                    tmpd1 = salary(maxsalary) * adjust_value(tmpi)
                                    value_remark = "Value = " & adjust_value(tmpi) & " x " & Math.Round(CSng(salary(maxsalary)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(maxsalary)), 2) & ") = " & Math.Round(tmpd1, 2)
                                    leave_value = leave_value + tmpd1
                                End If

                                uptotalaccum = adjust_value(tmpi)

                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Set Accumulated Balance to : " & adjust_value(tmpi) & vbCrLf
                                ' Leave statement
                                ' Fix up the array for the Capitalisation part  Code fragment id 1234; used twice in this procedure
                                ' 20/05/2003 : Bug : Marsh database where the Accumulated balance and the normal balance is set, with a money value afterwards. When leave is taken, the money value is worngly calculated, because only the value for SET LEAVE BALANCE is taken into account and not for SET ACCUM BALANCE
                                ' -------------------------------------------------------------------------------------------------
                                If maxaccrual = 0 Then
                                    maxaccrual = maxaccrual + 1
                                    ReDim Preserve accruedate(maxaccrual)
                                    ReDim Preserve accrual(maxaccrual)
                                    ReDim Preserve prevaccrual(maxaccrual)
                                    ReDim Preserve accrualsalary(maxaccrual)
                                    ReDim Preserve accrualsalarytcp(maxaccrual)
                                    accruedate(maxaccrual) = tmpdt
                                    accrual(maxaccrual) = adjust_value(tmpi)
                                    prevaccrual(maxaccrual) = accrual(maxaccrual)
                                    ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                    If calc_on_present_sal And maxsalary > 0 Then
                                        accrualsalary(maxaccrual) = salary(maxsalary)   ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        accrualsalarytcp(maxaccrual) = salarytcp(maxsalary)
                                    Else
                                        accrualsalary(maxaccrual) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        accrualsalarytcp(maxaccrual) = 0
                                    End If
                                Else
                                    tmpflag = False
                                    For tmpi1 = 1 To maxaccrual
                                        ' If the same date is found, it might have been entered as a SET LEAVE BALANCE, therefor add the value to the balance
                                        If accruedate(tmpi1) = tmpdt Then
                                            accrual(tmpi1) = accrual(tmpi1) + adjust_value(tmpi)   ' <<< NNB !!
                                            prevaccrual(tmpi1) = accrual(tmpi1)
                                            tmpflag = True
                                            Exit For
                                        End If
                                    Next tmpi1
                                    ' If the exact date was not found, we must insert it : 20/05/2003 - NOTE : The dates of the Set Balance + Set Accum Balance + Set Money Value MUST all be on the same date, otherwise the first capitalisation is not correctly calculated as it does not add up the Balance + Accum Balance
                                    If Not tmpflag Then
                                        ' Find the date where this record must be inserted (actually it should always be at the end because at this point in time there are no accruals in the array, but lets just do it for safety sake)
                                        For tmpi1 = 1 To maxaccrual
                                            If accruedate(tmpi1) > tmpdt Then Exit For
                                        Next tmpi1
                                        maxaccrual = maxaccrual + 1
                                        ReDim Preserve accruedate(maxaccrual)
                                        ReDim Preserve accrual(maxaccrual)
                                        ReDim Preserve prevaccrual(maxaccrual)
                                        ReDim Preserve accrualsalary(maxaccrual)
                                        ReDim Preserve accrualsalarytcp(maxaccrual)
                                        For tmpi2 = tmpi1 To maxaccrual - 1
                                            accruedate(tmpi2) = accruedate(tmpi2 + 1)
                                            accrual(tmpi2) = accrual(tmpi2 + 1)
                                            prevaccrual(tmpi2) = prevaccrual(tmpi2 + 1)
                                            accrualsalary(tmpi2) = accrualsalary(tmpi2 + 1)
                                            accrualsalarytcp(tmpi2) = accrualsalarytcp(tmpi2 + 1)
                                        Next tmpi2
                                        accruedate(tmpi1) = tmpdt
                                        accrual(tmpi1) = adjust_value(tmpi)
                                        prevaccrual(tmpi1) = accrual(tmpi1)
                                        ' 23/05/2003 : A monetary value must be set if calculation is based on present salary, refer to Marsh problem
                                        If calc_on_present_sal And maxsalary > 0 Then
                                            accrualsalary(tmpi1) = salary(maxsalary)   ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                            accrualsalarytcp(tmpi1) = salarytcp(maxsalary)
                                        Else
                                            accrualsalary(tmpi1) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                            accrualsalarytcp(tmpi1) = 0  ' I don't think I should pull it from pay, because a balance should always be associated with a monetary value if they are using capitalisations
                                        End If
                                    End If
                                End If


                            Case "SET MONEY VALUE"
                                leave_value = adjust_value(tmpi)

                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Set Monetary Value to : " & adjust_value(tmpi) & vbCrLf
                                ' Leave statement
                                ' Fix up the array for the Capitalisation part
                                ' --------------------------------------------
                                If maxaccrual = 0 Then
                                Else
                                    tmpflag = False
                                    For tmpi1 = 1 To maxaccrual
                                        ' Set all the previous accruals to 'cancelled'
                                        If accruedate(tmpi1) < tmpdt Then
                                            accrual(tmpi1) = 0
                                        End If
                                        If accruedate(tmpi1) = tmpdt Then
                                            If accrual(tmpi1) = 0 Then
                                                accrualsalary(tmpi1) = 0
                                            Else
                                                accrualsalary(tmpi1) = adjust_value(tmpi) / accrual(tmpi1)
                                            End If
                                            tmpflag = True
                                            Exit For
                                        End If
                                    Next tmpi1
                                    ' If the exact date was not found, we must insert it : Should not be necessary as it should always be accompanied by a SET LEAVE BALANCE
                                End If

                            Case "ADD ACCRUAL"
                                uptotalaccrual = uptotalaccrual + adjust_value(tmpi)
                                ' Add it to the Accrual array
                                maxaccrual = maxaccrual + 1
                                ReDim Preserve accruedate(maxaccrual)
                                ReDim Preserve accrual(maxaccrual)
                                ReDim Preserve prevaccrual(maxaccrual)
                                ReDim Preserve accrualsalary(maxaccrual)
                                ReDim Preserve accrualsalarytcp(maxaccrual)
                                accruedate(maxaccrual) = tmpdt
                                accrual(maxaccrual) = adjust_value(tmpi)
                                prevaccrual(maxaccrual) = accrual(maxaccrual)
                                accrualsalary(maxaccrual) = 0  ' to be filled in when a Adjust Money Value is found
                                accrualsalarytcp(maxaccrual) = 0

                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Add Accrual to : " & adjust_value(tmpi) & vbCrLf
                                ' 09/03/2007 : Refer to Werksmans bug where a Stop Accrual is done on 01 March 2007 (with the 2 adjustments) and then a leave statement is run for the 28 Feb 2007, a Single accrual is allocated
                                If adjust_subtype(tmpi) = "Stop Accr Proportion" Then
                                    If DateAdd("d", -1, ipDate) = tmpdt Then calculate_proportion = False
                                End If

                                ' Leave statement

                            Case "ADJUST MONEY VALUE"
                                ' Check if there is an Add Accrual for this day, if found, add the value to the array
                                For tmpi1 = 1 To maxaccrual
                                    If accruedate(tmpi1) = tmpdt Then
                                        If accrual(tmpi1) = 0 Then
                                            accrualsalary(tmpi1) = accrualsalary(tmpi1) + 0
                                        Else
                                            accrualsalary(tmpi1) = accrualsalary(tmpi1) + (adjust_value(tmpi) / accrual(tmpi1))
                                        End If
                                        Exit For
                                    End If
                                Next tmpi1
                                leave_value = leave_value + adjust_value(tmpi)

                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjust Monetary Value to : " & adjust_value(tmpi) & vbCrLf
                                ' 09/03/2007 : Refer to Werksmans bug where a Stop Accrual is done on 01 March 2007 (with the 2 adjustments) and then a leave statement is run for the 28 Feb 2007, a Single accrual is allocated
                                If adjust_subtype(tmpi) = "Stop Accr Proportion" Then
                                    If DateAdd("d", -1, ipDate) = tmpdt Then calculate_proportion = False
                                End If


                            Case "IGNORE HISTORY PRIOR"
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Ignore History Prior"

                            Case "ADJUST TOTAL LOST"
                                uptotal_lost = uptotal_lost + adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & tmpdt & " : Adjust Lost : " & adjust_value(tmpi)
                                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & " New balance of total days lost = " & uptotal_lost & vbCrLf

                                'Case "CAPITALIZE UNITS":  ' This goes as Leave Taken even though it is an adjustment. Refer to the leave_taken array

                        End Select
                    End If
                Next tmpi
            End If


            ' Check if there is any leave taken for this date (NNB ! Only applicable for the Leave Statement ie. if ipBuildLeaveStmt  is True)
            ' ----------------------------------------------------------------------------Section 1000 ----------------------------------------------------
            If max_taken > 0 Then
                'tmp_tot_taken = 0
                If max_taken > 0 Then
                    For tmpi = 1 To max_taken ' The reason why I loop through the array on each pass is because of the change in cycle start date
                        If tmpdt = taken_date(tmpi) Then
                            tmp_tot_taken = tmp_tot_taken + taken_amount(tmpi)

                            tmptaken = taken_amount(tmpi)
                            If taken_amount(tmpi) > 0 Then
                                value_remark = "New value balance = " & Math.Round(leave_value, 2) & " - "
                            Else
                                value_remark = "New value balance = " & Math.Round(leave_value, 2) & " + "
                            End If
                            calc_monetary_value(upUnitOfMeassure, tmpdt, tmptaken, delta, delta1, tmpd, leave_value, maxaccrual, accrual, prevaccrual, accrualsalary, accrualsalarytcp, accruedate, ipBuildLeaveStmt, upCapitMethod, salary_as_at_date, salary, salarytcp, maxsalary, ipShowCapitMethod)
                            ' Correction on 06/01/2003 : was only uptotalvalcapitalized = uptotalvalcapitalized + tmpd
                            If tmptaken < 0 Then
                                uptotalvalcapitalized = uptotalvalcapitalized - tmpd
                            Else
                                uptotalvalcapitalized = uptotalvalcapitalized + tmpd
                            End If
                            value_remark = value_remark & " " & Math.Round(delta1, 2) & " - " & Math.Round(delta, 2) & " = " & Math.Round(leave_value, 2)

                            ' Leave statement
                            ' ---------------
                            If taken_to_date(tmpi) = New Date(1960, 1, 1) Then
                                ' It is Leave that has been Capitalized
                                ' 06/02/2003 : If it is capitalized from the normal balance in the case of no accumulation. After discussion with Willem, it was decided that ALL Capitilizations must be deducted off the Accumulated Balance
                                If Not allowaccum(prev_rule) Then
                                Else
                                    ' 06/02/2003 : If it is capitalized from the accumulated balance :
                                    tmp_tot_taken = tmp_tot_taken - taken_amount(tmpi)
                                    uptotalaccum = uptotalaccum - taken_amount(tmpi)
                                End If
                            Else
                                ' It is leave that has been taken
                            End If
                            If tmpi < max_taken Then  ' Determine if the loop can be exited from
                                If tmpdt <> taken_date(tmpi + 1) Then Exit For
                            End If
                        End If
                    Next tmpi
                End If
            End If

            tmpdt = DateAdd("d", 1, tmpdt)
        Loop Until tmpdt = ipDate


        ' ================================================================================================================================
        ' ================================================================================================================================
        ' Get the fraction for rules like ".... WORKED" eg. 1 hr for 17 hrs worked, and at this point the person might have worked 4 hours
        ' ================================================================================================================================
        ' ================================================================================================================================
        If idx <= maxrules And Not balance_set Then
            value_remark = String.Empty
            If UCase(accruetype(idx)) = "FOR EVERY X HOUR(S) WORKED" Or UCase(accruetype(idx)) = "FOR EVERY X DAY(S) WORKED" Then
                If x_amount <> 0 Then
                    ' Calculate the monetary value for the proportion
                    If maxsalary > 1 Then
                        ' Build the Accrual Array
                        maxaccrual = maxaccrual + 1
                        ReDim Preserve accruedate(maxaccrual)
                        ReDim Preserve accrual(maxaccrual)
                        ReDim Preserve prevaccrual(maxaccrual)
                        ReDim Preserve accrualsalary(maxaccrual)
                        ReDim Preserve accrualsalarytcp(maxaccrual)
                        accruedate(maxaccrual) = tmpdt
                        delta = x_amount / accruetypeamount(idx) * accrueamount(idx)
                        ' 23/06/2004 : Check if the TOTAL balance has not been reached
                        If maxtotbalance(idx) <> 0 Then
                            tmpdbl1 = uptotalaccrual + delta - tmp_tot_taken + uptotalaccum
                            If tmpdbl1 >= maxtotbalance(idx) Then
                                delta = Math.Round(delta - (tmpdbl1 - maxtotbalance(idx)), 6) ' Adjust the accrual to a portion of the total, so that the total balance does not exceed the max
                                'tmp_additional_remark = " : Max Balance of " & maxtotbalance(idx) & " reached"
                            End If
                        End If

                        tmpd = (delta) * accrualsalary(maxaccrual - 1)
                        leave_value = leave_value + (tmpd)
                        value_remark = "Value accrual = " & delta & " x " & Math.Round(accrualsalary(maxaccrual - 1), 4) & " (tcp=" & Math.Round(CSng(accrualsalarytcp(maxaccrual - 1)), 2) & ") = " & Math.Round(tmpd, 2)
                        accrual(maxaccrual) = delta
                        prevaccrual(maxaccrual) = accrual(maxaccrual)
                        accrualsalary(maxaccrual) = accrualsalary(maxaccrual - 1) ' Should be the same than the previous salary
                        accrualsalarytcp(maxaccrual) = accrualsalarytcp(maxaccrual - 1) ' Should be the same than the previous salary
                        value_remark = value_remark & "   New total value = " & Format(leave_value, NumericFormat)
                    End If

                    ' Determine if there is an accrual stop
                    tmpflag1 = True
                    For tmpi2 = 1 To maxaccrualstop
                        If tmpdt >= accrualstopfrom(tmpi2) And tmpdt <= accrualstopto(tmpi2) Then
                            tmpflag1 = False
                            Exit For
                        End If
                    Next tmpi2

                    If tmpflag1 Then
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & DateAdd("d", -1, tmpdt) & " : Proportion of " & x_amount & " " & LCase(upUnitOfMeassure) & " out of " & accruetypeamount(idx) & " = " & Format((x_amount / accruetypeamount(idx)) * accrueamount(idx), "0.000") & vbCrLf
                        uptotalaccrual = uptotalaccrual + CSng(Format((x_amount / accruetypeamount(idx) * accrueamount(idx)), "0.00000000"))  ' 03/09/2003 : Changed to 8 decimals due to problem with Willem Capitalisation not resulting in 0 when the entire balance is capitalised
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual
                    End If
                End If
            End If

            If UCase(accruetype(idx)) = "FOR EVERY X MONTH(S) WORKED" Then
                tmpi = DateDiff("d", last_accrue_date, DateAdd("d", -1, tmpdt))   ' Number of days since the last accrue date
                tmpi1 = DateDiff("d", last_accrue_date, DateAdd("m", CDbl(accruetypeamount(idx)), last_accrue_date))   ' Number of days between the 2 accrue dates
                ' 03/02/2003 : Problem in that it adds a proportion before the first month is completed. Reason is that tmpi <= 31 in this example. refer LIW 0707805 date 28/01/2003
                If tmpi / tmpi1 <> 0 And tmpi <= 31 Then
                    For tmpi2 = 1 To maxaccrualstop
                        tmpdt1 = DateAdd("d", -1, tmpdt)
                        If tmpdt1 >= accrualstopfrom(tmpi2) And tmpdt1 <= accrualstopto(tmpi2) Then
                            tmpi = 400 ' Ensures that next if is not entered
                            Exit For
                        End If
                    Next tmpi2
                End If

                tmps1 = String.Empty
                ' 22/05/2003 : Problem that if a person is terminated, it does not add the last proportion to the calculation, it only shows the last accrual
                If (Not IsNull(lstworkdate) And IsNull(termdate)) Or (Not IsNull(lstworkdate) And termdate > DateAdd("d", -1, tmpdt)) Then
                    ' If the last working day is filled in and the termination date is not filled in, take the last working day
                    If lstworkdate < tmpdt Then
                        tmpi2 = DateDiff("d", last_accrue_date, DateAdd("d", -0, lstworkdate))   ' Number of days since the last accrue date
                        If tmpi2 > 0 Then
                            tmps1 = " : Last working day on " & lstworkdate
                            tmpi = tmpi2
                            ' Bug 31/07/2003 : Reference Willem Potgieter (LIW), if accruals is stopped, the proportion is 1 day out
                            If tmpi < tmpi1 Then tmpi = tmpi + 1
                        End If
                    End If
                End If
                If Not IsNull(termdate) Then
                    ' If the person is terminated
                    If termdate < tmpdt Then
                        tmpi2 = DateDiff("d", last_accrue_date, DateAdd("d", -0, termdate))   ' Number of days since the last accrue date
                        If tmpi2 > 0 Then
                            tmps1 = " : Terminated on " & DateAdd("d", -1, termdate)
                            tmpi = tmpi2 - 1   ' 05/04/2006 : Add the -1 on this day as GLTA complained that the calculation is 1 day out on terminated employees
                        End If
                    End If
                End If

                If tmpi / tmpi1 <> 0 And tmpi <= 31 And calculate_proportion Then
                    ' Calculate the monetary value for the proportion
                    tmpd = 0
                    tmp_additional_remark = String.Empty
                    If maxsalary >= 1 Then
                        ' Build the Accrual Array
                        maxaccrual = maxaccrual + 1
                        ReDim Preserve accruedate(maxaccrual)
                        ReDim Preserve accrual(maxaccrual)
                        ReDim Preserve prevaccrual(maxaccrual)
                        ReDim Preserve accrualsalary(maxaccrual)
                        ReDim Preserve accrualsalarytcp(maxaccrual)
                        accruedate(maxaccrual) = tmpdt
                        ' 25/01/2003 : If there is a Proportion calculation directly after a money value adjustment, the accrualsalary(maxaccrual - 1) = 0 and we need to get the latest salary. Possibly occur if there is an Add Accrual, Adjust Money Value and an Accrual on the same day
                        If accrualsalary(maxaccrual - 1) = 0 Then
                            For tmpi2 = maxsalary To 1 Step -1
                                If salary_as_at_date(tmpi2) <= tmpdt Or tmpi2 = 1 Then Exit For
                            Next tmpi2
                            accrualsalary(maxaccrual - 1) = salary(tmpi2)
                            accrualsalarytcp(maxaccrual - 1) = salarytcp(tmpi2)
                        End If
                        delta = (tmpi / tmpi1) * accrueamount(idx)
                        ' 23/06/2004 : Check if the TOTAL balance has not been reached
                        If maxtotbalance(idx) <> 0 Then
                            tmpdbl1 = uptotalaccrual + delta - tmp_tot_taken + uptotalaccum
                            If tmpdbl1 >= maxtotbalance(idx) Then
                                delta = Math.Round(delta - (tmpdbl1 - maxtotbalance(idx)), 6) ' Adjust the accrual to a portion of the total, so that the total balance does not exceed the max
                                tmp_additional_remark = " : Max Balance of " & maxtotbalance(idx) & " reached"
                            End If
                        End If

                        tmpd = (delta) * accrualsalary(maxaccrual - 1)
                        leave_value = leave_value + (tmpd)
                        value_remark = "Value accrual = " & Math.Round(delta, 4) & " x " & Math.Round(accrualsalary(maxaccrual - 1), 4) & " (tcp=" & Math.Round(CSng(accrualsalarytcp(maxaccrual - 1)), 2) & ") = " & Math.Round(tmpd, 2)
                        accrual(maxaccrual) = delta
                        prevaccrual(maxaccrual) = accrual(maxaccrual)
                        accrualsalary(maxaccrual) = accrualsalary(maxaccrual - 1) ' Should be the same than the previous salary
                        accrualsalarytcp(maxaccrual) = accrualsalarytcp(maxaccrual - 1) ' Should be the same than the previous salary
                        value_remark = value_remark & "   New total value = " & Format(leave_value, NumericFormat)
                    Else
                        delta = (tmpi / tmpi1) * accrueamount(idx)
                    End If

                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & DateAdd("d", -1, tmpdt) & " : Proportion of " & tmpi & " days out of " & tmpi1 & " = " & Format(delta, "0.000") & vbCrLf
                    uptotalaccrual = uptotalaccrual + CSng(Format(delta, "0.00000000"))   ' 03/09/2003 : Changed to 8 decimals due to problem with Willem Capitalisation not resulting in 0 when the entire balance is capitalised
                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual
                    If maxaccrual > 0 Then
                        ' 13/10/2003 : If it is a "Last Working Day ..."  or "Terminated On" accrucal, insert at the correct row in the grid, in the past this "accrual" was shown against today's date, which is wrong
                        If InStr(1, tmps1, "Last Working Day", vbTextCompare) > 0 Or InStr(1, tmps1, "Terminated On", vbTextCompare) > 0 Then
                            tmpdt1 = tmpdt
                            If IsDate(lstworkdate) Then tmpdt1 = DateAdd("d", 1, lstworkdate)
                            If IsDate(termdate) Then tmpdt1 = termdate
                        End If
                    Else
                        ' 13/10/2003 : If it is a "Last Working Day ..."  or "Terminated On" accrucal, insert at the correct row in the grid, in the past this "accrual" was shown against today's date, which is wrong
                        If InStr(1, tmps1, "Last Working Day", vbTextCompare) > 0 Or InStr(1, tmps1, "Terminated On", vbTextCompare) > 0 Then
                            tmpdt1 = tmpdt
                            If IsDate(lstworkdate) Then tmpdt1 = DateAdd("d", 1, lstworkdate)
                            If IsDate(termdate) Then tmpdt1 = termdate
                        End If
                    End If
                End If
            End If
        End If


        ' Subtract the total taken and calculate the balance
        ' --------------------------------------------------
        ' Include the actual leave taken
        If IsNull(ignore_hist_prior) Then
            Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(taken_sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
        Else
            Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(taken_sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and StartDate >= '" & Format(ignore_hist_prior, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
        End If
        If Not IsNull(GetSQLField(0, Snap, "tot")) Then
            uptotaltaken = GetSQLField(0, Snap, "tot")
        End If
        Snap.Dispose()
        ' Total Capitalizations
        Snap = GetSQLDS("SELECT sum(AdjustmentValue) as tot FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and EffectiveDate >= '" & Format(taken_sd_begin, "yyyy-MM-dd") & "' and EffectiveDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and AdjustmentType = 'Capitalize Units'")
        If Not IsNull(GetSQLField(0, Snap, "tot")) Then
            uptotalcapitalized = GetSQLField(0, Snap, "tot")
        End If
        Snap.Dispose()
        ' 06/02/2003 : If it is capitalized from the normal balance in the case of no accumulation. After discussion with Willem, it was decided that ALL Capitilizations must be deducted off the Accumulated Balance
        If (Not IsNull(allowaccum)) Then

            If Not allowaccum(prev_rule) Then
                ' 01/10/2005 : Do not deduct total taken if Never Accrue. Refer CPS - Angus
                If UCase$(accruetype(prev_rule)) <> "NEVER ACCRUE (BYPASS CALCULATION)" Then
                    upactualbalance = Math.Round(uptotalaccrual - uptotaltaken - uptotalcapitalized, 8)  ' 03/09/2003 : Change from 4 to 8 digits because of Willems Capitalisation problem when full amount is capitalised
                End If
            Else
                ' 01/10/2005 : Do not deduct total taken if Never Accrue. Refer CPS - Angus
                If UCase$(accruetype(prev_rule)) <> "NEVER ACCRUE (BYPASS CALCULATION)" Then
                    upactualbalance = Math.Round(uptotalaccrual - uptotaltaken, 8)       ' 03/09/2003 : Change from 4 to 8 digits because of Willems Capitalisation problem when full amount is capitalised
                End If
            End If

        End If

        ' Get the grand total taken, but only if we work with cycles
        If taken_sd <> sd Then
            If IsNull(ignore_hist_prior) Then
                Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
            Else
                Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(tmpdt, "yyyy-MM-dd") & "' and StartDate >= '" & Format(ignore_hist_prior, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
            End If
            If IsNull(GetSQLField(0, Snap, "tot")) Then upgrandtottaken = 0 Else upgrandtottaken = GetSQLField(0, Snap, "tot")
            Snap.Dispose()
        Else
            upgrandtottaken = uptotaltaken
        End If

        ' If there is an accumulated balance, BUT the balance is negative, deduct from the accumulated balance
        If uptotalaccum > 0 And upactualbalance < 0 Then
            ' Balance is negative and LESS than the accum balance
            If uptotalaccum + upactualbalance >= 0 Then
                uptotalaccum = uptotalaccum + upactualbalance
                tmpd = upactualbalance
                upactualbalance = 0
                ' Changed on 21/11/2002 as per Megan (RMB) request, but in my opinion this is not correct
                'tmpd = upactualbalance
                'upactualbalance = uptotalaccum + upactualbalance
                'uptotalaccum = 0
            End If
            ' Balance is negative and MORE than the accum balance
            If uptotalaccum + upactualbalance < 0 Then
                upactualbalance = uptotalaccum + upactualbalance
                tmpd = -uptotalaccum
                uptotalaccum = 0
            End If

            If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & DateAdd("d", -1, tmpdt) & " : Balance is negative, deduct " & Math.Round(Math.Abs(tmpd), 4) & " " & LCase(upUnitOfMeassure) & " from Accumulated total. New accumulated balance = " & Math.Round(CSng(uptotalaccum), 4) & vbCrLf
        End If

        ' Get the total approved future leave
        Dim objFuture As Object = get_total_future_approved_leave(ipcomp, ipemp, ipLeaveType, tmpdt)

        If (Not IsNull(objFuture)) Then

            If (Not IsNull(objFuture)) Then uptotalfuture = objFuture

        End If


        ' Error if no rule is found
        If rule_not_found Then
            upErrs = "Invalid Seq Number OR at least 1 leave rule stipulates Days/Hours worked, but there are no working hours set up for the employee."
        End If

        ' Determine the leave period number, if we are working with cycles
        If maxperiods > 1 Then
            If idx <= maxperiods Then upperiod = periodnumber(idx) ' 07/06/2007 : Added "If idx <= maxperiods Then" to avoid subscript out of range if rules are not properly set up
        Else
            If maxperiods = 1 Then
                upperiod = 0
                ipDate = DateAdd("d", -1, ipDate)
                ' 21/02/2003 ; Replace all maxperiods with prev_rule in the array indexes
                If periodlength(prev_rule) <> -999 Then
                    For tmpbt = 1 To periodlength(prev_rule)
                        Select Case periodtype(prev_rule)
                            Case "Year(s)"
                                If DateAdd("yyyy", tmpbt, taken_sd) <= ipDate Then upperiod = upperiod + 1
                        End Select
                    Next tmpbt
                End If
                If periodlength(prev_rule) > 1 Then
                    upperiod = upperiod + 1
                Else
                    If periodlength(prev_rule) = 1 And upperiod = 0 Then upperiod = 1 ' Bug fix 10/01/2003 : emp 0000882 on demo db
                End If
            End If
        End If

        ' Get the Leave At Risk number as there may have been leave taken
        If DateAdd("d", -1, tmpdt) < upnextlostdate Then
            ' Check if there were any leave taken between the 2 dates
            tmpd = 0  ' Count the number taken within timeframe
            For tmpi = 1 To max_taken
                If taken_date(tmpi) >= atriskstartdate And taken_date(tmpi) < tmpdt Then tmpd = tmpd + taken_amount(tmpi)
            Next tmpi
            upatrisk = upatrisk - tmpd  ' New leave at risk
            If upatrisk < 0 Then upatrisk = 0 ' Cannot be negative, fixed on 24/06/2003
        End If

        uptotal_lost = Math.Round(uptotal_lost, 4)

        upmoneyvalbalance = Math.Round(leave_value, 2)

        ' ******************************************************************************************************************************************************************************************************************************************************
        ' ******************************************************************************************************************************************************************************************************************************************************
        ' NNB !!! 02/09/2003 : The monetary balance can still be out by a few cents when all the leave is capitalised. The reason is that upactualbalance is a Single, and some of the decimals get dropped. Change it to Single at some stage for 100% accuracy
        ' See code where the 6th decimal is dropped :    upactualbalance = Math.Round(uptotalaccrual - uptotaltaken - uptotalcapitalized, 8)  ' 03/09/2003 : Change from 4 to 8 digits because of Willems Capitalisation problem when full amount is capitalised
        ' ******************************************************************************************************************************************************************************************************************************************************
        ' ******************************************************************************************************************************************************************************************************************************************************

        ' Display the leave balance summary per TCP
        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "SUMMARY OF LEAVE CREDITS PER TCP CHANGE" & vbCrLf
        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "---------------------------------------" & vbCrLf
        If maxaccrual > 0 Then tmpd = accrualsalarytcp(1)
        tmpd1 = 0   ' Total units accrued within the specific salary bracket
        For tmpi = 1 To maxaccrual
            tmpd1 = tmpd1 + accrual(tmpi)
            If accrualsalarytcp(tmpi) <> tmpd Or tmpi = maxaccrual Then
                tmpd = accrualsalarytcp(tmpi)
                If tmpi < maxaccrual Then tmpd1 = tmpd1 - accrual(tmpi)
                If tmpi > 1 Then
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & DateAdd("d", -1, accruedate(tmpi)) & " : " & Format(tmpd1, "0.000000") & " at a TCP of " & accrualsalarytcp(tmpi - 1) & vbCrLf
                    tmpd1 = accrual(tmpi)
                End If
            End If
            'Debug.Print accruedate(tmpi) & " - " & accrual(tmpi) & " - " & accrualsalarytcp(tmpi)
        Next tmpi

        '13/12/2005 : Financial year end problem : Here we need to adjust the monetary value (liability)
        ' ----------------------------------------------------------------------------------------------
        ' If the financial year en date is specified, and the leave spans over this date, we need to take only the proportion of the days for the current financial year
        If DatePart("yyyy", year_end) <> 1900 And max_taken > 0 And UCase$(upUnitOfMeassure) = "DAY(S)" Then
            ' Loop through the array of leave taken
            For tmpi = 1 To max_taken
                If taken_date(tmpi) <= ipDate And taken_to_date(tmpi) >= ipDate Then
                    '        tmpl = frmLeave.leave_days(ipcomp, ipemp, ipDate, taken_to_date(tmpi), tmpb)
                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & DateAdd("d", -1, tmpdt) & " : Financial year end adjusted by " & tmpl & " days" & vbCrLf
                    tmp_tot_taken = tmp_tot_taken + tmpl
                    uptotaltaken = uptotaltaken - tmpl
                    upactualbalance = upactualbalance + tmpl
                    If maxaccrual > 0 Then
                        leave_value = leave_value + (tmpl * accrualsalary(maxaccrual))
                        upmoneyvalbalance = upmoneyvalbalance + (tmpl * accrualsalary(maxaccrual))
                    End If
                End If
            Next tmpi
        End If


        ' Summary
        upCalcMethod = upCalcMethod & vbCrLf & vbCrLf & "SUMMARY:"
        upCalcMethod = upCalcMethod & vbCrLf & "Unit Of Measure = " & upUnitOfMeassure
        upCalcMethod = upCalcMethod & vbCrLf & "Total Accrual     = " & uptotalaccrual
        If upperiod = 0 Then   ' No cycles
            upCalcMethod = upCalcMethod & vbCrLf & "Total Taken = " & uptotaltaken
        Else
            upCalcMethod = upCalcMethod & vbCrLf & "Current Period    = " & upperiod
            upCalcMethod = upCalcMethod & vbCrLf & "Total Taken (" & taken_sd & " - " & DateAdd("d", -1, ipDate) & ") = " & uptotaltaken
        End If
        upCalcMethod = upCalcMethod & vbCrLf & "Number Of Units Capitalized = " & uptotalcapitalized
        upCalcMethod = upCalcMethod & vbCrLf & "Value Of Units Capitalized/Taken = " & Format(uptotalvalcapitalized, NumericFormat)
        upCalcMethod = upCalcMethod & vbCrLf & "Value Balance = " & Format(leave_value, "0.0000")
        upCalcMethod = upCalcMethod & vbCrLf & "Grand Total Taken = " & upgrandtottaken
        upCalcMethod = upCalcMethod & vbCrLf & "Balance   = " & upactualbalance & vbCrLf 'Format(upactualbalance, "0.00000") & vbCrLf
        upCalcMethod = upCalcMethod & "Accumulated Balance = " & uptotalaccum & vbCrLf
        If upatrisk = 0 Then upCalcMethod = upCalcMethod & "At Risk           = " & upatrisk & vbCrLf Else upCalcMethod = upCalcMethod & "At Risk           = " & upatrisk & "   To Lose on " & upnextlostdate & vbCrLf
        upCalcMethod = upCalcMethod & "Total Lost        = " & uptotal_lost & vbCrLf
        upCalcMethod = upCalcMethod & "Total Future      = " & uptotalfuture & vbCrLf

        cycle_leaveed = period_end_date

    End Sub

    Private Function get_leave_start_date(ByRef CompanyNum As String, ByRef EmployeeNum As String, ByRef LeaveType As String) As Object

        Return GetSQLFieldObj("select [FromDate] from [LeaveCalculateFrom] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] = '" & LeaveType & "')", "FromDate")

    End Function

    Private Sub populate_leave_rules_array(ByRef ipcomp As String, ByRef ipemp As String, ByRef ipLeaveScheme As String, ByRef ipLeaveType As String, ByRef ipCalcDate As Object, ByRef groupdate As Object, ByRef upErrs As String, ByRef max_hrs_days As Byte, ByRef upUnitOfMeassure As String, ByRef upactualbalance As Single, ByRef ipDate As Object, ByRef uptotalfuture As Single, ByRef sd As Object, ByRef uptotaltaken As Single, ByRef losrule As Boolean, ByRef maxperiods As Byte, ByRef payfield_conversion_formula As String, ByRef calc_on_present_sal As Boolean, ByRef servicetype() As String, ByRef serviceinterval() As Integer, ByRef dtjoinedgroup() As Boolean, ByRef accrueamount() As Single, ByRef accrueunit() As String, ByRef accruetype() As String, ByRef accruetypeamount() As String, ByRef periodtype() As String, ByRef periodlength() As Long, ByRef periodnumber() As Byte, ByRef rulename() As String, ByRef rulevaliduntil() As Date, ByRef allowaccum() As Boolean, ByRef maxaccum() As Long, ByRef maxaccumgracelen() As Integer, ByRef maxaccumgracetyp() As String, ByRef atriskstartdate As Date, ByRef totmaxaccum() As Long, ByRef tmaxaccumgracelen() As Integer, ByRef tmaxaccumgracetyp() As String, ByRef maxtotbalance() As Long, ByRef paytemplate() As String, ByRef fieldname() As String, ByRef maxrules As Byte, ByRef ipRuleValid As Date, ByRef maxsalary As Integer, ByRef salary_as_at_date() As Date, ByRef salary() As Single, ByRef salarytcp() As Single, ByRef salary_template() As String, ByRef salary_field() As String, ByRef wh_validfrom() As Date, ByRef wh_hrs(,) As Single, ByRef max_pub_hols As Integer, ByRef pub_hols() As Date)
        ' ********************************************************************************************************
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Mail utility
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Scheduler utility
        ' ********************************************************************************************************

        ' NOTE : Refer to function CDec to fix up rounding errors
        '        Use function round for rounding off
        Dim Rules As DataSet
        Dim Snap As DataSet
        Dim tmpserviceinterval As Integer   ' Temporary variable used to build the leave rules array
        Dim tmps As String
        'Dim tmps1 As String
        Dim pos As Integer
        Dim tmpb As Boolean
        Dim iLoop As Integer

        ' Initialize
        tmpserviceinterval = -100
        maxrules = 0
        upErrs = String.Empty
        upUnitOfMeassure = "?"
        payfield_conversion_formula = String.Empty
        maxsalary = 0
        max_hrs_days = 255
        max_pub_hols = 0
        maxperiods = 0
        maxsalary = 0

        ' Populate the rules array
        ' ------------------------
        ' zaq ---------- old code >
        '  Rules.Open convert_sql_syntax("Select RuleName, ServiceType,BasedOnDtJoinGrp, ServiceInterval, AccrueAmount, AccrueUnit, AccrueType, AccrueTypeAmount, PeriodType, PeriodLength, PeriodNumber, AllowAccum,MaxAccum,MaxAccumGraceLen,MaxAccumGraceType,TotMaxAccum,TotMaxAccumGraceLen,TotMaxAccumGraceType, MaxTotBalance, RuleValidUntil, TemplateName, FieldName, ConversionFormula, CalcOnPresentSalary FROM LeaveAccrualRules WHERE CompanyNum = '" & ipcomp & "' and Leave_Scheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "' ORDER BY SequenceNumber,ServiceInterval"), AdoMainCon, adOpenForwardOnly, adLockReadOnly, adCmdText
        ' zaq ---------- old code >
        If ipLeaveScheme = String.Empty Then     ' Individual Leave Rules are used
            Rules = GetSQLDS("Select LeaveRules.RuleName, ServiceType,BasedOnDtJoinGrp, ServiceInterval, AccrueAmount, AccrueUnit, AccrueType, AccrueTypeAmount, PeriodType, PeriodLength, PeriodNumber, AllowAccum,MaxAccum,MaxAccumGraceLen,MaxAccumGraceType,TotMaxAccum,TotMaxAccumGraceLen,TotMaxAccumGraceType, MaxTotBalance, RuleValidUntil, TemplateName, FieldName, ConversionFormula, CalcOnPresentSalary FROM LeaveRules INNER JOIN PersonnelLeaveRules ON (LeaveRules.RuleName = PersonnelLeaveRules.RuleName) AND (LeaveRules.LeaveType = PersonnelLeaveRules.LeaveType) WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveRules.LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "' ORDER BY SequenceNumber,ServiceInterval")
        Else
            Rules = GetSQLDS("Select LeaveRules.RuleName, ServiceType,BasedOnDtJoinGrp, ServiceInterval, AccrueAmount, AccrueUnit, AccrueType, AccrueTypeAmount, PeriodType, PeriodLength, PeriodNumber, AllowAccum,MaxAccum,MaxAccumGraceLen,MaxAccumGraceType,TotMaxAccum,TotMaxAccumGraceLen,TotMaxAccumGraceType, MaxTotBalance, RuleValidUntil, TemplateName, FieldName, ConversionFormula, CalcOnPresentSalary FROM LeaveRules INNER JOIN LeaveSchemeRules ON (LeaveRules.RuleName = LeaveSchemeRules.RuleName) AND (LeaveRules.LeaveType = LeaveSchemeRules.LeaveType) WHERE LeaveScheme = '" & ipLeaveScheme & "' and LeaveRules.LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "' ORDER BY SequenceNumber,ServiceInterval")
        End If

        If (IsData(Rules)) Then

            For iLoop = 0 To (Rules.Tables(0).Rows.Count - 1)

                maxrules = maxrules + 1

                ReDim Preserve rulename(maxrules)
                ReDim Preserve servicetype(maxrules)
                ReDim Preserve dtjoinedgroup(maxrules)
                ReDim Preserve serviceinterval(maxrules)
                ReDim Preserve accrueamount(maxrules)
                ReDim Preserve accrueunit(maxrules)
                ReDim Preserve accruetype(maxrules)
                ReDim Preserve accruetypeamount(maxrules)
                ReDim Preserve periodtype(maxrules)
                ReDim Preserve periodlength(maxrules)
                ReDim Preserve periodnumber(maxrules)
                ReDim Preserve allowaccum(maxrules)
                ReDim Preserve maxaccum(maxrules)
                ReDim Preserve maxaccumgracelen(maxrules)
                ReDim Preserve maxaccumgracetyp(maxrules)
                ReDim Preserve totmaxaccum(maxrules)
                ReDim Preserve tmaxaccumgracelen(maxrules)
                ReDim Preserve tmaxaccumgracetyp(maxrules)
                ReDim Preserve maxtotbalance(maxrules)
                ReDim Preserve rulevaliduntil(maxrules)
                ReDim Preserve paytemplate(maxrules)
                ReDim Preserve fieldname(maxrules)

                rulevaliduntil(maxrules) = GetSQLField(iLoop, Rules, "rulevaliduntil")
                rulename(maxrules) = GetSQLField(iLoop, Rules, "rulename")
                If GetSQLField(iLoop, Rules, "BasedOnDtJoinGrp") = 0 Then
                    dtjoinedgroup(maxrules) = False
                Else
                    dtjoinedgroup(maxrules) = True
                    If IsNull(groupdate) Then
                        upErrs = "Date Joined Group not specified"
                        Rules.Dispose()
                        Exit Sub
                    End If
                End If
                If UCase(GetSQLField(iLoop, Rules, "accruetype").ToString()) = "FOR EVERY X HOUR(S) WORKED" Or UCase(GetSQLField(iLoop, Rules, "accruetype").ToString()) = "FOR EVERY X DAY(S) WORKED" Then max_hrs_days = 0
                ' The leave rules are set not to accrue, eg, balances are imported from Payroll
                ' Tis is a problem in that we will have to
                If UCase(GetSQLField(iLoop, Rules, "accruetype").ToString()) = "NEVER ACCRUE (BYPASS CALCULATION)" Then
                    upUnitOfMeassure = GetSQLField(iLoop, Rules, "accrueunit")
                    ' Get the balance out of the adjustments section
                    Snap = GetSQLDS("SELECT AdjustmentValue FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and AdjustmentType = 'Set Leave Balance' and EffectiveDate = (SELECT max(EffectiveDate) FROM LeaveAdjustments WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "')")
                    If (IsData(Snap)) Then upactualbalance = GetSQLField(iLoop, Snap, "AdjustmentValue")
                    Snap.Dispose()
                    ' Get the total future leave
                    Dim fLeave As Object = get_total_future_approved_leave(ipcomp, ipemp, ipLeaveType, DateAdd("d", -1, DateValue(ipDate)))

                    If (Not IsNull(fLeave)) Then

                        If (Not IsNull(fLeave)) Then uptotalfuture = fLeave

                    End If

                    ' Get the total taken
                    Snap = GetSQLDS("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(sd, "yyyy-MM-dd") & "' and StartDate < '" & Format(ipDate, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'")
                    If IsNull(GetSQLField(iLoop, Snap, "tot")) Then uptotaltaken = 0 Else uptotaltaken = GetSQLField(iLoop, Snap, "tot")
                    Snap.Dispose()
                End If
                If Not IsNull(GetSQLField(iLoop, Rules, "servicetype")) Then servicetype(maxrules) = GetSQLField(iLoop, Rules, "servicetype") Else servicetype(maxrules) = String.Empty
                If Not IsNull(GetSQLField(iLoop, Rules, "serviceinterval")) Then
                    If UCase(GetSQLField(iLoop, Rules, "servicetype").ToString()) = "YEAR(S)" Then
                        serviceinterval(maxrules) = GetSQLField(iLoop, Rules, "serviceinterval") * 12
                    Else
                        serviceinterval(maxrules) = GetSQLField(iLoop, Rules, "serviceinterval")
                    End If
                    losrule = True
                Else
                    serviceinterval(maxrules) = -999
                End If
                If serviceinterval(maxrules) = 0 Then serviceinterval(maxrules) = -999
                If Not IsNull(GetSQLField(iLoop, Rules, "accrueamount")) Then accrueamount(maxrules) = GetSQLField(iLoop, Rules, "accrueamount") Else accrueamount(maxrules) = -999
                If Not IsNull(GetSQLField(iLoop, Rules, "accrueunit")) Then accrueunit(maxrules) = GetSQLField(iLoop, Rules, "accrueunit") Else accrueunit(maxrules) = String.Empty
                If Not IsNull(GetSQLField(iLoop, Rules, "accruetype")) Then accruetype(maxrules) = GetSQLField(iLoop, Rules, "accruetype") Else accruetype(maxrules) = String.Empty
                If Not IsNull(GetSQLField(iLoop, Rules, "accruetypeamount")) Then
                    If GetSQLField(iLoop, Rules, "accruetypeamount") = 0 Then accruetypeamount(maxrules) = -999 Else accruetypeamount(maxrules) = GetSQLField(iLoop, Rules, "accruetypeamount")
                Else
                    accruetypeamount(maxrules) = -999
                End If
                If Not IsNull(GetSQLField(iLoop, Rules, "allowaccum")) Then
                    If GetSQLField(iLoop, Rules, "allowaccum") = 0 Then allowaccum(maxrules) = False Else allowaccum(maxrules) = True
                Else
                    allowaccum(maxrules) = False
                End If

                If Not IsNull(GetSQLField(iLoop, Rules, "maxaccum")) Then maxaccum(maxrules) = GetSQLField(iLoop, Rules, "maxaccum") Else maxaccum(maxrules) = 0
                If Not IsNull(GetSQLField(iLoop, Rules, "maxaccumgracelen")) Then maxaccumgracelen(maxrules) = GetSQLField(iLoop, Rules, "maxaccumgracelen") Else maxaccumgracelen(maxrules) = 0
                If Not IsNull(GetSQLField(iLoop, Rules, "MaxAccumGraceType")) Then maxaccumgracetyp(maxrules) = GetSQLField(iLoop, Rules, "MaxAccumGraceType") Else maxaccumgracetyp(maxrules) = String.Empty
                If Not IsNull(GetSQLField(iLoop, Rules, "totmaxaccumgracelen")) Then tmaxaccumgracelen(maxrules) = GetSQLField(iLoop, Rules, "totmaxaccumgracelen") Else tmaxaccumgracelen(maxrules) = 0
                If Not IsNull(GetSQLField(iLoop, Rules, "TotMaxAccumGraceType")) Then tmaxaccumgracetyp(maxrules) = GetSQLField(iLoop, Rules, "TotMaxAccumGraceType") Else tmaxaccumgracetyp(maxrules) = String.Empty

                If Not IsNull(GetSQLField(iLoop, Rules, "totmaxaccum")) Then totmaxaccum(maxrules) = GetSQLField(iLoop, Rules, "totmaxaccum") Else totmaxaccum(maxrules) = 0
                If Not IsNull(GetSQLField(iLoop, Rules, "periodtype")) Then
                    If GetSQLField(iLoop, Rules, "periodtype") <> "<not applicable>" Then
                        If tmpserviceinterval = -100 Then tmpserviceinterval = serviceinterval(maxrules)
                        periodtype(maxrules) = GetSQLField(iLoop, Rules, "periodtype")
                        If maxperiods = 0 Then
                            maxperiods = maxperiods + 1
                        Else
                            ' Caters for the situation that we can get the same maximum number of periods for different length of service cut-offs
                            If tmpserviceinterval <> serviceinterval(maxrules) Then
                                tmpserviceinterval = serviceinterval(maxrules)
                                maxperiods = 1  ' New service interval
                            Else
                                maxperiods = maxperiods + 1
                            End If
                        End If
                    Else
                        periodtype(maxrules) = String.Empty
                        allowaccum(maxrules) = False
                        maxaccum(maxrules) = 0
                        totmaxaccum(maxrules) = 0
                        periodlength(maxrules) = -999
                        periodnumber(maxrules) = 0
                    End If
                Else
                    periodtype(maxrules) = String.Empty
                    allowaccum(maxrules) = False
                    maxaccum(maxrules) = 0
                    totmaxaccum(maxrules) = 0
                    periodlength(maxrules) = -999
                    periodnumber(maxrules) = 0
                End If
                If periodtype(maxrules) <> String.Empty Then
                    If Not IsNull(GetSQLField(iLoop, Rules, "periodlength")) Then periodlength(maxrules) = GetSQLField(iLoop, Rules, "periodlength") Else periodlength(maxrules) = -999
                    If Not IsNull(GetSQLField(iLoop, Rules, "periodnumber")) Then
                        periodnumber(maxrules) = GetSQLField(iLoop, Rules, "periodnumber")
                        If GetSQLField(iLoop, Rules, "periodnumber") <> maxperiods Then
                            upErrs = "Period number " & GetSQLField(iLoop, Rules, "periodnumber") & " does not follow sequentially"
                            Rules.Dispose()
                            Exit Sub
                        End If
                    Else
                        periodnumber(maxrules) = 0
                    End If
                End If

                If IsNull(GetSQLField(iLoop, Rules, "maxtotbalance")) Then maxtotbalance(maxrules) = 0 Else maxtotbalance(maxrules) = GetSQLField(iLoop, Rules, "maxtotbalance")

                ' The accrue unit MUST be the same accross all rules, check if this is the case
                If maxrules > 1 Then
                    If accrueunit(maxrules) <> accrueunit(maxrules - 1) Then
                        Rules.Dispose()
                        upErrs = "The accrual unit must be the same for all rules. You are using '" & accrueunit(maxrules) & "' and '" & accrueunit(maxrules - 1) & "'"
                        Exit Sub
                    End If
                End If

                ' For the salary info
                If IsNull(GetSQLField(iLoop, Rules, "TemplateName")) Then paytemplate(maxrules) = String.Empty Else paytemplate(maxrules) = UCase(GetSQLField(iLoop, Rules, "TemplateName").ToString())
                If IsNull(GetSQLField(iLoop, Rules, "fieldname")) Then
                    fieldname(maxrules) = String.Empty
                Else
                    fieldname(maxrules) = UCase(GetSQLField(iLoop, Rules, "fieldname").ToString())
                    If Not IsNull(GetSQLField(iLoop, Rules, "Conversionformula")) Then payfield_conversion_formula = Trim$(GetSQLField(iLoop, Rules, "Conversionformula"))
                    If IsNull(GetSQLField(iLoop, Rules, "CalcOnPresentSalary")) Then
                        calc_on_present_sal = False
                    Else
                        If GetSQLField(iLoop, Rules, "CalcOnPresentSalary") = 0 Then calc_on_present_sal = False Else calc_on_present_sal = True
                    End If
                End If

            Next

            Rules.Dispose()

        End If

        If (Not IsNull(accrueunit)) Then upUnitOfMeassure = accrueunit(1)

        ' Build the pay values array for the capatilisation part
        ' ------------------------------------------------------
        ' zaq ---------- old code >
        '  Rules.Open convert_sql_syntax("Select distinct TemplateName, FieldName FROM LeaveAccrualRules WHERE CompanyNum = '" & ipcomp & "' and Leave_Scheme = '" & ipLeaveScheme & "' and LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "'"), AdoMainCon, adOpenForwardOnly, adLockReadOnly, adCmdText
        ' zaq ---------- old code >
        If ipLeaveScheme = String.Empty Then     ' Individual Leave Rules are used
            Rules = GetSQLDS("Select distinct TemplateName, FieldName FROM LeaveRules INNER JOIN PersonnelLeaveRules ON (LeaveRules.RuleName = PersonnelLeaveRules.RuleName) AND (LeaveRules.LeaveType = PersonnelLeaveRules.LeaveType) WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveRules.LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "'")
        Else
            Rules = GetSQLDS("Select distinct TemplateName, FieldName FROM LeaveRules INNER JOIN LeaveSchemeRules ON (LeaveRules.RuleName = LeaveSchemeRules.RuleName) AND (LeaveRules.LeaveType = LeaveSchemeRules.LeaveType) WHERE LeaveScheme = '" & ipLeaveScheme & "' and LeaveRules.LeaveType = '" & ipLeaveType & "' and RuleValidUntil = '" & Format(ipRuleValid, "yyyy-MM-dd") & "'")
        End If

        If (IsData(Rules)) Then

            For iLoop = 0 To (Rules.Tables(0).Rows.Count - 1)

                If Not IsNull(GetSQLField(iLoop, Rules, "TemplateName")) Then
                    If IsNull(GetSQLField(iLoop, Rules, "fieldname")) Then
                        upErrs = "The fieldname on one of the Leave Rules is empty"
                        Rules.Dispose()
                        Exit Sub
                    Else
                        tmps = GetSQLField(iLoop, Rules, "fieldname")
                    End If
                    If GetSQLField(iLoop, Rules, "fieldname") = "Monthly Salary" Then tmps = "Salary"
                    If GetSQLField(iLoop, Rules, "fieldname") = "Salary" Then tmps = "Rate"
                    pos = InStr(1, GetSQLField(iLoop, Rules, "fieldname"), " ", 1)
                    If pos > 0 Then
                        tmps = Mid$(GetSQLField(iLoop, Rules, "fieldname"), 1, pos - 2)
                    End If
                    'If access("Pay History Tab", "VIEW") Then  ' Only calculate the monetary values if the user has access rights to the Pay History
                    If calc_on_present_sal Then
                        'Snap.Open convert_sql_syntax("Select DateFrom," & tmps & " as salary FROM Pay WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and TemplateName = '" & GetSQLField(iLoop, Rules, "templateName & "' and DateFrom = (Select Max(DateFrom) FROM Pay WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and TemplateName = '" & GetSQLField(iLoop, Rules, "templateName & "')"), AdoMainCon, adOpenForwardOnly, adLockReadOnly, adCmdText
                        '01/09/2006 : Reported by Pauline from syspro, the system must look at the salary for that date entered
                        Snap = GetSQLDS("Select DISTINCT Top 1 DateFrom," & tmps & " as salary FROM Pay WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and TemplateName = '" & GetSQLField(iLoop, Rules, "TemplateName") & "' and DateFrom < '" & Format(ipCalcDate, "yyyy-MM-dd") & "' ORDER BY DateFrom DESC")
                    Else
                        Snap = GetSQLDS("Select DateFrom," & tmps & " as salary FROM Pay WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and TemplateName = '" & GetSQLField(iLoop, Rules, "TemplateName") & "' and DateFrom <= '" & Format(ipRuleValid, "yyyy-MM-dd") & "' ORDER BY DateFrom")
                    End If

                    If (IsData(Snap)) Then

                        Dim iLoop2 As Integer

                        For iLoop2 = 0 To (Snap.Tables(0).Rows.Count - 1)

                            ' Check if the salary record for the previous date does not already exist
                            If maxsalary >= 2 Then
                                If IsNull(GetSQLField(iLoop2, Snap, "salary")) Then
                                    If salary(maxsalary) = 0 Then tmpb = False Else tmpb = True
                                Else
                                    If salary(maxsalary) = GetSQLField(iLoop2, Snap, "salary") Then tmpb = False Else tmpb = True
                                End If
                            Else
                                tmpb = True
                            End If
                            If tmpb Then
                                maxsalary = maxsalary + 1
                                ReDim Preserve salary_template(maxsalary)
                                ReDim Preserve salary_field(maxsalary)
                                ReDim Preserve salary_as_at_date(maxsalary)
                                ReDim Preserve salary(maxsalary)
                                ReDim Preserve salarytcp(maxsalary)

                                If (Not IsNull(GetSQLField(iLoop2, Rules, "TemplateName"))) Then salary_template(maxsalary) = UCase(GetSQLField(iLoop2, Rules, "TemplateName").ToString())
                                If (Not IsNull(GetSQLField(iLoop2, Rules, "fieldname"))) Then salary_field(maxsalary) = UCase(GetSQLField(iLoop2, Rules, "fieldname").ToString())
                                If calc_on_present_sal Then
                                    salary_as_at_date(maxsalary) = sd
                                Else
                                    salary_as_at_date(maxsalary) = GetSQLField(iLoop2, Snap, "DateFrom")
                                End If
                                ' If there is a conversion formula
                                If payfield_conversion_formula <> String.Empty Then
                                    pos = InStr(1, payfield_conversion_formula, "x", 1)
                                    If pos = 0 Then
                                        upErrs = "Invalid conversion formula, no x variable in expression '" & payfield_conversion_formula & "'"
                                        Rules.Dispose()
                                        Snap.Dispose()
                                        Exit Sub
                                    Else
                                        'Removed: FERDI monetory value not needed >
                                        'If Not IsNull(GetSQLField(iLoop2, Snap, "salary")) Then
                                        '    tmps1 = Replace(payfield_conversion_formula, "X", GetSQLField(iLoop2, Snap, "salary"), , , CompareMethod.Text)
                                        '    tmps = Math.Formule(tmps1)
                                        '    If IsNumeric(tmps) Then
                                        '        salary(maxsalary) = Val(tmps)
                                        '    Else
                                        '        upErrs = "Error in pay conversion formula '" & tmps1 & "'"
                                        '        Rules.Dispose()
                                        '        Snap.Dispose()
                                        '        Exit Sub
                                        '    End If
                                        'End If
                                    End If
                                Else
                                    If IsNull(GetSQLField(iLoop2, Snap, "salary")) Then salary(maxsalary) = 0 Else salary(maxsalary) = GetSQLField(iLoop2, Snap, "salary")
                                End If
                                If Not IsNull(GetSQLField(iLoop2, Snap, "salary")) Then salarytcp(maxsalary) = GetSQLField(iLoop2, Snap, "salary") Else salarytcp(maxsalary) = 0
                            End If

                        Next

                        Snap.Dispose()

                    End If
                End If

            Next

            Rules.Dispose()

        End If

        ' If any of the rules state "... for every x hours / days worked ...." then  populate the working days/hours array as well as the public holidays array
        If max_hrs_days = 0 Then
            Snap = GetSQLDS("SELECT ValidFrom, MonHrs,TueHrs,WedHrs,ThuHrs,FriHrs,SatHrs,SunHrs FROM WorkingHours WHERE CompanyNum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' ORDER BY ValidFrom")

            If (IsData(Snap)) Then

                For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                    max_hrs_days = max_hrs_days + 1
                    ReDim Preserve wh_validfrom(max_hrs_days)
                    ReDim Preserve wh_hrs(8, max_hrs_days + 1)

                    wh_validfrom(max_hrs_days) = GetSQLField(iLoop, Snap, "ValidFrom")
                    If IsNull(GetSQLField(iLoop, Snap, "MonHrs")) Then wh_hrs(1, max_hrs_days) = 0 Else wh_hrs(1, max_hrs_days) = GetSQLField(iLoop, Snap, "MonHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "TueHrs")) Then wh_hrs(2, max_hrs_days) = 0 Else wh_hrs(2, max_hrs_days) = GetSQLField(iLoop, Snap, "TueHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "WedHrs")) Then wh_hrs(3, max_hrs_days) = 0 Else wh_hrs(3, max_hrs_days) = GetSQLField(iLoop, Snap, "WedHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "ThuHrs")) Then wh_hrs(4, max_hrs_days) = 0 Else wh_hrs(4, max_hrs_days) = GetSQLField(iLoop, Snap, "ThuHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "FriHrs")) Then wh_hrs(5, max_hrs_days) = 0 Else wh_hrs(5, max_hrs_days) = GetSQLField(iLoop, Snap, "FriHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "SatHrs")) Then wh_hrs(6, max_hrs_days) = 0 Else wh_hrs(6, max_hrs_days) = GetSQLField(iLoop, Snap, "SatHrs")
                    If IsNull(GetSQLField(iLoop, Snap, "SunHrs")) Then wh_hrs(7, max_hrs_days) = 0 Else wh_hrs(7, max_hrs_days) = GetSQLField(iLoop, Snap, "SunHrs")

                Next

                Snap.Dispose()

            End If

            If max_hrs_days = 0 Then
                upErrs = "At least 1 leave rule stipulates Days/Hours worked, but there are no working hours set up for the employee."
                Exit Sub
            End If

            Snap = GetSQLDS("SELECT Distinct(PubHolDate) FROM PersonnelPubHolCal INNER JOIN PublicHoliday ON PersonnelPubHolCal.CalendarType = PublicHoliday.CalendarType WHERE CompanyNum='" & ipcomp & "' AND EmployeeNum='" & ipemp & "' and PubHolDate >= '" & Format(sd, "yyyy-MM-dd") & "' and PubHolDate <= '" & Format(ipDate, "yyyy-MM-dd") & "' ORDER BY PubHolDate")

            If (IsData(Snap)) Then

                For iLoop = 0 To (Snap.Tables(0).Rows.Count - 1)

                    max_pub_hols = max_pub_hols + 1
                    ReDim Preserve pub_hols(max_pub_hols)
                    pub_hols(max_pub_hols) = GetSQLField(iLoop, Snap, "PubHolDate")

                Next

                Snap.Dispose()

            End If

            'If max_pub_hols = 0 Then ' Remove this code as there might not be a public holiday within the period specified
            '  upErrs = "At least 1 leave rule stipulates Days/Hours worked, but there is no public holiday calendar set up for the employee."
            '  Exit Sub
            'End If
        End If

    End Sub

    Private Sub calc_monetary_value(ByRef ipUnitOfMeassure As String, ByRef tmpdt As Date, ByRef tmptaken As Single, ByRef delta As Single, ByRef delta1 As Single, ByRef tmpd As Single, ByRef leave_value As Single, ByRef maxaccrual As Long, ByRef accrual() As Single, ByRef prevaccrual() As Single, ByRef accrualsalary() As Single, ByRef accrualsalarytcp() As Single, ByRef accruedate() As Date, ByRef ipBuildLeaveStmt As Boolean, ByRef upCapitMethod As String, ByRef salary_as_at_date() As Date, ByRef salary() As Single, ByRef salarytcp() As Single, ByRef maxsalary As Integer, ByRef ipShowCapitMethod As Boolean)
        ' ********************************************************************************************************
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Mail utility
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Scheduler utility
        ' ********************************************************************************************************
        ' This proc Calculate the monetary value for a given number of days as per value in tmptaken
        ' The leave_value is the new leave balance AFTER the calculation
        ' Delta is the value of the proportion carried over from the last remainder
        ' Delta1 is the value of the proportion carried over from the previous remainder + the values that are cancelled out
        ' Tmpd is the actual value of the number of days taken/capitalised/lost

        Dim tmpl As Long     ' Temporary long
        Dim tmpl1 As Long    ' Temporary long
        Dim cmstr As String  ' Calculation method string
        Dim tmpd1 As Single  ' Temporary Single
        Dim tmps As String   ' Temporary string
        Dim tel As Integer   ' Temnporary counter


        tmpd = 0
        cmstr = String.Empty
        If maxaccrual > 0 Then
            ' In the case of days that are taken/capitalized normally, eg 5 days
            ' ==================================================================
            tmps = tmpdt & " : " & tmptaken & " units taken/capitalized/lost"
            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & tmps & vbCrLf
            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & FillChar(String.Empty, "-", Len(tmps), PositionEnum.Append) & vbCrLf
            If tmptaken >= 0 Then

                For tmpl = 1 To maxaccrual
                    ' On the Accrual, mark those dates as being 'cancelled' by setting the values to zero
                    If tmptaken - accrual(tmpl) >= 0 Then

                        tmptaken = tmptaken - accrual(tmpl)
                        tmpd1 = accrual(tmpl) * accrualsalary(tmpl)

                        ' Calculation method
                        If accrual(tmpl) <> 0 Then
                            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl) & " : Available " & Math.Round(accrual(tmpl), 4) & " @ " & Math.Round(accrualsalary(tmpl), 4) & " (tcp=" & Math.Round(CSng(accrualsalarytcp(tmpl)), 2) & ") = " & Math.Round(accrual(tmpl) * accrualsalary(tmpl), 2) & vbCrLf
                        Else
                            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl) & " : All used" & vbCrLf
                        End If

                        If accrual(tmpl) <> 0 Then

                            If cmstr = String.Empty Then cmstr = Math.Round(tmpd1, 2) Else cmstr = cmstr & " + " & Math.Round(tmpd1, 2)

                        End If

                        leave_value = leave_value - tmpd1
                        tmpd = tmpd + accrual(tmpl) * accrualsalary(tmpl)    ' The total amount that is deducted
                        accrual(tmpl) = 0
                        tmpl1 = tmpl
                    Else
                        Exit For   ' Added on 03/12/2002. Fixes pb with proportion of accrual at the end being deducted and then tmpl1+1 > maxaccrual, which casues stmt 'The balance goes into a negative' to execute
                    End If
                Next tmpl
                delta1 = tmpd

                ' Add the remainder to the last accrual
                If tmpl1 + 1 <= maxaccrual Then
                    delta = tmptaken * accrualsalary(tmpl1 + 1)

                    ' Calculation method
                    If cmstr = String.Empty Then cmstr = Math.Round(delta, 2) Else cmstr = cmstr & " + " & Math.Round(delta, 2)
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl1 + 1) & " : Available " & accrual(tmpl1 + 1) & " @ " & Math.Round(accrualsalary(tmpl1 + 1), 4) & vbCrLf
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "                 Use remainder =  " & Math.Round(tmptaken, 3) & " x " & Math.Round(accrualsalary(tmpl1 + 1), 4) & " = " & Math.Round(tmptaken * accrualsalary(tmpl1 + 1), 2) & vbCrLf

                    tmpd = tmpd + delta
                    leave_value = leave_value - delta

                    accrual(tmpl1 + 1) = accrual(tmpl1 + 1) - tmptaken

                    ' Calculation method
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "                 Left Over = " & Math.Round(accrual(tmpl1 + 1), 4) & vbCrLf
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value = " & cmstr & vbCrLf

                    If InStr(1, cmstr, "+", vbTextCompare) <> 0 Then

                        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "          = " & Math.Round(tmpd, 2) & vbCrLf

                    End If

                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value Balance = " & Math.Round(leave_value, 2) + Math.Round(tmpd, 2) & " - " & Math.Round(tmpd, 2) & " = " & Math.Round(leave_value, 2) & vbCrLf
                Else
                    ' The balance goes into a negative
                    ' --------------------------------
                    tmptaken = Math.Round(tmptaken, 11)   ' 26/02/2003 : Round it off otherwise we might get a few cents difference.  Change from 4 to 11 on 03/09/2003 due to Willem Capitalisation cents difference when you capitalize the full amount
                    ' 22/01/2003 : Was before delta = tmptaken * accrualsalary(maxaccrual), but this causes a problem if the first record after a set balance is leave taken and it results in a negative balance. There has not been any accruals before the data when the leave was taken.
                    For tel = maxsalary To 1 Step -1
                        If salary_as_at_date(tel) <= tmpdt Or tel = 1 Then Exit For
                    Next tel
                    If maxsalary = 0 Then  ' Do this IF on 04/01/2003, otherwise we get a subscript out of range error in the else part
                        delta = 0
                    Else
                        delta = tmptaken * salary(tel)  ' Amount that goes into a negative
                        accrualsalary(maxaccrual) = salary(tel)
                    End If
                    tmpd = tmpd + (delta)
                    accrual(maxaccrual) = -tmptaken
                    leave_value = leave_value - (delta)
                    ' Calculation method
                    If tmptaken <> 0 Then  ' Add this condition on 26/02/2003
                        If cmstr = String.Empty Then cmstr = Math.Round(delta, 2) Else cmstr = cmstr & " + " & Math.Round(delta, 2)
                        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Balance goes into negative by " & Math.Round(tmptaken, 4) & " " & ipUnitOfMeassure & " @ " & Math.Round(accrualsalary(maxaccrual), 4) & " = " & Math.Round(delta, 2) & vbCrLf
                    End If
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value = " & cmstr & vbCrLf

                    If InStr(1, cmstr, "+", vbTextCompare) <> 0 Then

                        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "          = " & Math.Round(tmpd, 2) & vbCrLf

                    End If

                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value Balance = " & Math.Round(leave_value, 2) + Math.Round(tmpd, 2) & " - " & Math.Round(tmpd, 2) & " = " & Math.Round(leave_value, 2) & vbCrLf
                End If
            Else
                ' In the case of days that are taken/capitalized in reversal, eg -5 days
                ' ======================================================================
                For tmpl = maxaccrual To 1 Step -1
                    ' On the Accrual, mark those dates as being NOT 'cancelled' by setting the values back to the original accrual values
                    If accrual(tmpl) <> prevaccrual(tmpl) And tmptaken + prevaccrual(tmpl) <= 0 Then
                        delta = prevaccrual(tmpl) - accrual(tmpl)
                        tmpd1 = delta * accrualsalary(tmpl)
                        ' Calculation method
                        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl) & " : Available " & Math.Round(delta, 4) & " @ " & accrualsalary(tmpl) & " = " & Math.Round(delta * accrualsalary(tmpl), 2) & vbCrLf
                        If cmstr = String.Empty Then cmstr = Math.Round(tmpd1, 2) Else cmstr = cmstr & " + " & Math.Round(tmpd1, 2)
                        tmptaken = tmptaken + (delta)
                        leave_value = leave_value + (tmpd1)
                        tmpd = tmpd + tmpd1                ' The total amount that is added
                        accrual(tmpl) = prevaccrual(tmpl)  ' Reset it back to 'available'
                        tmpl1 = tmpl
                    End If
                Next tmpl
                delta1 = tmpd

                ' Add the remainder to the last accrual
                If tmpl1 >= 2 Then
                    delta = tmptaken * accrualsalary(tmpl1 - 1)
                    tmpd = tmpd - delta
                    leave_value = leave_value - delta
                    accrual(tmpl1 - 1) = -tmptaken

                    ' Calculation method
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl1 - 1) & " : Available " & Math.Abs(tmptaken) & " @ " & accrualsalary(tmpl1 - 1) & " = " & Math.Abs(tmptaken) * accrualsalary(tmpl1 - 1) & vbCrLf
                    If cmstr = String.Empty Then cmstr = delta Else cmstr = cmstr & " + " & Math.Round(Math.Abs(delta), 2)
                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value = " & cmstr & vbCrLf

                    If InStr(1, cmstr, "+", vbTextCompare) <> 0 Then

                        If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "          = " & Math.Round(tmpd, 2) & vbCrLf

                    End If

                    If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value Balance = " & Math.Round(leave_value, 2) - tmpd & " + " & tmpd & " = " & Math.Round(leave_value, 2) & vbCrLf

                Else
                    ' The balance goes into a negative
                    ' Go to the first non-zero accrual and add the value
                    For tmpl = 1 To maxaccrual
                        If accrual(tmpl) > 0 Then
                            accrual(tmpl) = accrual(tmpl) - tmptaken
                            If tmpd = 0 Then   ' 25/01/2003 : Don't know why, but it fixed something up. The If condition was not here
                                tmpd = Math.Abs(tmptaken * accrualsalary(tmpl))
                                leave_value = leave_value + tmpd
                            End If

                            ' Calculation method
                            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    " & accruedate(tmpl) & " : Left Over " & accrual(tmpl) + tmptaken & ", added " & Math.Abs(tmptaken) & " @ " & Math.Round(accrualsalary(tmpl), 4) & " = " & Math.Round(Math.Abs(tmptaken) * accrualsalary(tmpl), 2) & vbCrLf
                            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "                 Available " & accrual(tmpl) & " @ " & Math.Round(accrualsalary(tmpl), 4) & vbCrLf
                            If cmstr = String.Empty Then
                                If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value = " & Math.Round(tmpd, 2) & vbCrLf
                            Else
                                If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value = " & cmstr & vbCrLf
                                If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "          = " & Math.Round(tmpd, 2) & vbCrLf
                            End If
                            If ipShowCapitMethod Then upCapitMethod = upCapitMethod & "    Value Balance = " & Math.Round(leave_value, 2) - Math.Round(tmpd, 2) & " + " & Math.Round(tmpd, 2) & " = " & Math.Round(leave_value, 2) & vbCrLf
                            Exit For
                        End If
                    Next tmpl
                End If
            End If

            ' For testing purposes
            'For tmpl = 1 To maxaccrual
            ' Debug.Print accruedate(tmpl) & "   " & accrual(tmpl) & "     " & prevaccrual(tmpl) & "    " & accrualsalary(tmpl)
            'Next tmpl

        End If
        ' -----------------------------------------------------------------------------------------------------

    End Sub

    Private Function calculate_service_length(ByRef appointdt As Object, ByRef ipterminationdt As Object) As String
        Dim tmpdate As Object

        If IsNull(ipterminationdt) Then
            tmpdate = Now
        Else
            tmpdate = ipterminationdt
        End If
        calculate_service_length = Fix(DateDiff("m", appointdt, tmpdate) / 12) & " years "
        calculate_service_length = calculate_service_length & Fix(DateDiff("m", appointdt, tmpdate) Mod 12) & " months"

    End Function

    Private Function calculate_service_length_weeks(ByRef appointdt As Object, ByRef ipterminationdt As Object) As String
        Dim tmpdate As Object

        If IsNull(ipterminationdt) Then
            tmpdate = Now
        Else
            tmpdate = ipterminationdt
        End If
        calculate_service_length_weeks = Fix(DateDiff("ww", appointdt, tmpdate)) & " weeks "

    End Function

    Private Sub do_accrual_and_value(ByRef accruedate() As Date, ByRef accrual() As Single, ByRef prevaccrual() As Single, ByRef accrualsalary() As Single, ByRef accrualsalarytcp() As Single, ByRef maxaccrual As Long, ByRef salary_template() As String, ByRef salary_field() As String, ByRef salary_as_at_date() As Date, ByRef salary() As Single, ByRef salarytcp() As Single, ByRef maxsalary As Integer, ByRef paytemplate() As String, ByRef fieldname() As String, ByRef leave_value As Single, ByRef value_remark As String, ByRef max_hrs_days As Byte, ByRef tmp_tot_taken As Single, ByRef taken_date() As Date, ByRef taken_to_date() As Date, ByRef taken_amount() As Single, ByRef max_taken As Integer, ByRef taken_sd As Date, ByRef wh_validfrom() As Date, ByRef wh_hrs(,) As Single, ByRef pub_hols() As Date, ByRef max_pub_hols As Integer, ByRef rule_not_found As Boolean, ByRef idx As Byte, ByRef termdate As Object, ByRef last_accrue_date As Date, ByRef last_setbalance_date As Date, ByRef prev_rule As Byte, ByRef upcycle_leavesd As Object, ByRef x_amount As Long, ByRef found As Boolean, ByRef delta As Single, ByRef tmpdt As Date, ByRef tmpb As Boolean, ByRef tmps As String, ByRef tmpi As Integer, ByRef tmpd As Single, ByRef rulename() As String, ByRef allowaccum() As Boolean, ByRef accrueunit() As String, ByRef accruetype() As String, ByRef accruetypeamount() As String, ByRef accrueamount() As Single, ByRef upCalcMethod As String, ByRef uptotalaccrual As Single, ByRef upErrs As String, ByRef ipBuildLeaveStmt As Boolean, ByRef accrualstopfrom() As Date, ByRef accrualstopto() As Date, ByRef maxaccrualstop As Integer, ByRef maxtotbalance() As Long, ByRef uptotaltaken As Single, ByRef uptotalaccum As Single, ByRef ipShowCalcMethod As Boolean)


        ' ********************************************************************************************************
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Mail utility
        ' NNB If any of this code changes, please remember to copy this function to the Absalom Scheduler utility
        ' ********************************************************************************************************
        Dim tmp_additional_remark As String   ' Additional temporary remark that is added to the remark string
        Dim tmpi1 As Integer                  ' Temporary variable
        Dim tmpdbl As Single                  ' Temporary Single
        Dim tmpbt As Byte

        ' =====================================================
        ' This procedure does the accrual and value calculation
        ' =====================================================
        If Not IsNull(termdate) Then

            If termdate <= tmpdt Then Exit Sub ' 22/04/2003 : Put this stmt in to prevent any accruals after an employee is terminated

        End If

        rule_not_found = False
        ' If there is a change from the previous rule, do the necessary action eg. first rule said 1 days per 100 days worked; new rule says 2 days per 100 days worked
        ' -------------------------------------------------------------------------------------------------------------------------------------------------------------
        If idx <> prev_rule Then
            If prev_rule <> 0 Then
                ' If the previous rule was FOR EVERY X DAY(S) WORKED, do the conversion calculation
                Select Case UCase(accruetype(prev_rule))
                    Case "FOR EVERY X DAY(S) WORKED"
                        ' Get the fraction of the X days worked under the previous rule
                        tmpd = (x_amount / accruetypeamount(prev_rule)) * accrueamount(prev_rule)
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : " & rulename(idx) & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Accrual : " & accrueamount(prev_rule) & " " & accrueunit(prev_rule) & " @ " & Replace(accruetype(prev_rule), " x ", " " & accruetypeamount(prev_rule) & " ") & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Change in rule, get fraction based on " & x_amount & " Day(s) worked" & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual & " + " & tmpd & vbCrLf
                        uptotalaccrual = uptotalaccrual + tmpd
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual
                        x_amount = 0

                    Case "FOR EVERY X HOUR(S) WORKED"
                        ' Get the fraction of the X days worked under the previous rule
                        tmpd = (x_amount / accruetypeamount(prev_rule)) * accrueamount(prev_rule)
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : " & rulename(idx) & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Accrual : " & accrueamount(prev_rule) & " " & accrueunit(prev_rule) & " @ " & Replace(accruetype(prev_rule), " x ", " " & accruetypeamount(prev_rule) & " ") & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Change in rule, get fraction based on " & x_amount & " Hour(s) worked" & vbCrLf
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual & " + " & tmpd & vbCrLf
                        uptotalaccrual = uptotalaccrual + tmpd
                        If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & uptotalaccrual
                        x_amount = 0

                End Select
            End If
            ' prev_rule = idx  ' See reference 18/11/2003 : Caused a problem if 2 leave cycles and 2 rules and for first cycle, max accum is taken of the 2nd rule instead of the 1st rule. Refer Megan at RMB
        End If

        found = False
        Select Case UCase(accruetype(idx))
            Case "FIRST DAY OF EACH MONTH"
                If DatePart("d", tmpdt) = 1 Then found = True

            Case "LAST DAY OF EACH MONTH"
                If DatePart("d", DateAdd("d", 1, tmpdt)) = 1 Then found = True

            Case "EVERY DAY" : found = True

            Case "FOR EVERY X MONTH(S) WORKED", "UPFRONT EVERY X MONTH(S)", "UPFRONT EVERY X MONTH(S) - 1ST, HALF AFTER 15TH"
                ' It is the beginning of the new month
                'If DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Then
                ' 06/09/2003 : Fix for the accrual problem if a person started to work on 31/03/2003
                'If DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Or DatePart("d", DateAdd("d", 1, tmpdt)) = DatePart("d", DateAdd("d", 1, upcycle_leavesd)) Or (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("m", tmpdt) = 2 And DatePart("d", upcycle_leavesd) >= 29) Then
                ' If (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("d", DateAdd("d", 1, upcycle_leavesd)) = 1) Or DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Or (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("m", tmpdt) = 2 And DatePart("d", upcycle_leavesd) >= 29) Then  ' Does not work with 30/06
                ' If DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Or (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("m", tmpdt) = 2 And DatePart("d", upcycle_leavesd) >= 29) Then  ' Does not work with 31/07
                If (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("d", upcycle_leavesd) = 31) Or DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Or (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("m", tmpdt) = 2 And DatePart("d", upcycle_leavesd) >= 29) Then
                    ' Determine the months worked
                    If termdate > tmpdt Or IsNull(termdate) Then tmps = calculate_service_length(upcycle_leavesd, tmpdt) Else tmps = calculate_service_length(upcycle_leavesd, termdate)
                    ' Get the length of service in months
                    tmpi = (Val(Mid$(tmps, 1, InStr(1, tmps, "years", 1) - 1)) * 12) + Val(Mid$(tmps, InStr(1, tmps, "years", 1) + 6, 2))

                    If UCase(accruetype(idx)) = "FOR EVERY X MONTH(S) WORKED" Then
                        If tmpi Mod accruetypeamount(idx) = 0 And tmpi <> 0 Then found = True
                    Else
                        If tmpi Mod accruetypeamount(idx) = 0 Then found = True
                    End If
                    If tmpi < 0 Then found = False ' 05/04/2003 : The termination date is before todays date
                End If

                '25/05/2005
            Case "FOR EVERY X WEEK(S) WORKED", "UPFRONT EVERY X WEEK(S)"
                ' It is the beginning of the new week
                'If (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("d", upcycle_leavesd) = 31) Or DatePart("d", tmpdt) = DatePart("d", upcycle_leavesd) Or (DatePart("d", DateAdd("d", 1, tmpdt)) = 1 And DatePart("m", tmpdt) = 2 And DatePart("d", upcycle_leavesd) >= 29) Then
                'If DatePart("ww", tmpdt) = DatePart("ww", upcycle_leavesd) Then
                If DateDiff("d", upcycle_leavesd, tmpdt) Mod 7 = 0 Then
                    ' Determine the weeks worked
                    If termdate > tmpdt Or IsNull(termdate) Then tmps = calculate_service_length_weeks(upcycle_leavesd, tmpdt) Else tmps = calculate_service_length_weeks(upcycle_leavesd, termdate)
                    ' Get the length of service in weeks
                    tmpi = (Val(Mid$(tmps, 1, InStr(1, tmps, "weeks", 1) - 1)))

                    If UCase(accruetype(idx)) = "FOR EVERY X WEEK(S) WORKED" Then
                        If tmpi Mod accruetypeamount(idx) = 0 And tmpi <> 0 Then found = True
                    Else
                        If tmpi Mod accruetypeamount(idx) = 0 Then found = True
                    End If
                    If tmpi < 0 Then found = False ' 05/04/2003 : The termination date is before todays date
                End If


            Case "FOR EVERY X DAY(S) WORKED"
                ' Determine if this day is a working day
                tmpb = False
                For tmpi = max_hrs_days To 1 Step -1
                    If wh_validfrom(tmpi) <= tmpdt Then
                        tmpb = True   ' The working hours record is found
                        Exit For
                    End If
                Next tmpi
                If tmpb = False Then
                    upErrs = "No working hours record found for " & tmpdt
                    Exit Sub
                End If
                ' Check if it is a working day by looking at the days worked array; Use Monday as the first day of the week
                If wh_hrs(Weekday(tmpdt, vbMonday), tmpi) > 0 Then
                    x_amount = x_amount + 1
                    ' If this day was a public holiday, then DO NOT calculate as working day
                    For tmpi = 1 To max_pub_hols
                        If pub_hols(tmpi) = tmpdt Then   ' A public holiday is found deduct it as a working day
                            x_amount = x_amount - 1
                            Exit For
                        End If
                    Next tmpi
                End If
                ' Check if the number of days meets the rule
                If x_amount >= accruetypeamount(idx) Then
                    found = True
                End If

            Case "FOR EVERY X HOUR(S) WORKED"
                ' Determine if this day is a working day
                tmpb = False
                For tmpi = max_hrs_days To 1 Step -1
                    If wh_validfrom(tmpi) <= tmpdt Then
                        tmpb = True   ' The working hours record is found
                        Exit For
                    End If
                Next tmpi
                If tmpb = False Then
                    upErrs = "No working hours record found for " & tmpdt
                    Exit Sub
                End If
                ' Check if it is a working day by looking at the days worked array; Use Monday as the first day of the week
                tmpbt = wh_hrs(Weekday(tmpdt, vbMonday), tmpi)
                If tmpbt > 0 Then
                    x_amount = x_amount + tmpbt
                    ' If this day was a public holiday, then DO NOT calculate as working day
                    For tmpi = 1 To max_pub_hols
                        If pub_hols(tmpi) = tmpdt Then   ' A public holiday is found deduct it as a working day
                            x_amount = x_amount - tmpbt
                            Exit For
                        End If
                    Next tmpi
                End If
                ' Check if the number of days meets the rule
                If x_amount >= accruetypeamount(idx) Then
                    'x_amount = x_amount - accruetypeamount(idx)     ' Was : x_amount = 0, but this causes a pb when there is for eg. hrs, and there can be more than for example 17 hrs, eg 1 hr for 17 worked, it can be 20 at this point
                    found = True
                End If

            Case "SKIP ACCRUAL"
                ' A rule is found, but the accrual must not be added
                Exit Sub

        End Select

        ' ------------------------
        ' ------------------------
        ' An accrual rule is found
        ' ------------------------
        ' ------------------------
        If found And maxaccrualstop > 0 Then
            ' Determine if there is an accrual stop
            For tmpi1 = 1 To maxaccrualstop
                If tmpdt >= accrualstopfrom(tmpi1) And tmpdt <= accrualstopto(tmpi1) Then
                    If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf & tmpdt & " : Stop Accrual " & accrualstopfrom(tmpi1) & " - " & accrualstopto(tmpi1) & vbCrLf
                    ' 22/05/2003 : There was a problem in that the total accrual was not correct when running stmt into the future
                    'If tmp_tot_taken <> 0 Then
                    '  uptotalaccrual = uptotalaccrual - tmp_tot_taken
                    '  tmp_tot_taken = 0
                    'End If

                    'tmp_tot_taken = 0
                    found = False
                    Exit For
                End If
            Next tmpi1
        End If
        If found Then
            last_accrue_date = tmpdt
            tmp_additional_remark = String.Empty
            delta = accrueamount(idx)

            ' Anton : 14/02/2011. Incorporate the half accrual for Stefanutti if appointed after the 15th
            If UCase(accruetype(idx)) = "UPFRONT EVERY X MONTH(S) - 1ST, HALF AFTER 15TH" Then
                If tmpdt = CDate(upcycle_leavesd) Then  ' Only for the 1st accrual
                    If CInt(Format(CDate(upcycle_leavesd), "dd")) > 15 Then delta = accrueamount(idx) / 2
                End If
            End If

            If upCalcMethod <> String.Empty Then

                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & vbCrLf

            End If

            If ipShowCalcMethod Then upCalcMethod = upCalcMethod & tmpdt & " : " & rulename(idx) & vbCrLf
            If accruetypeamount(idx) <> -999 Then
                If x_amount <> 0 Then
                    delta = CSng(Format(((x_amount / accruetypeamount(idx)) * accrueamount(idx)), "0.000"))  ' Accrual amount
                Else
                    ' The problem that Megan had at RMB whereby they define their SET BALANCE as the balance that includes to proportionate accrual. Eg. person must get 2 days accrual on the 15th. Balance is set on the 1st of the next month, now this balance includes the accrual as from the previous month
                    If last_setbalance_date <> New Date(1960, 1, 1) Then
                        tmpi = DateDiff("d", last_setbalance_date, DateAdd("d", 0, tmpdt))   ' Number of days since the last accrue date
                        tmpi1 = DateDiff("d", last_setbalance_date, DateAdd("m", CDbl(accruetypeamount(idx)), last_setbalance_date))   ' Number of days between the 2 accrue dates
                        If tmpi <= 31 Then   ' Only when the first accrual happens a month after the set balance
                            If tmpi / tmpi1 <> 0 And tmpi / tmpi1 <> 1 And tmpi1 <= 31 Then ' 25/01/2003 : Added tmpi1 <= 31 otherwise we get a large amount if a Set Balance is done way back in the past
                                delta = Math.Round((tmpi / tmpi1) * accrueamount(idx), 4)
                                ' 23/06/2004 : Check if the TOTAL balance has not been reached
                                If maxtotbalance(idx) <> 0 Then
                                    tmpdbl = uptotalaccrual + delta - tmp_tot_taken + uptotalaccum
                                    If tmpdbl >= maxtotbalance(idx) Then
                                        delta = Math.Round(delta - (tmpdbl - maxtotbalance(idx)), 6) ' Adjust the accrual to a portion of the total, so that the total balance does not exceed the max
                                        'tmp_additional_remark = " : Max Balance of " & maxtotbalance(idx) & " reached"
                                        tmp_additional_remark = " (Proportion of " & tmpi & " days out of " & tmpi1 & " if assumed that Set Balance includes accrual as from " & last_accrue_date & ") : Max Balance of " & maxtotbalance(idx) & " reached"
                                    Else
                                        tmp_additional_remark = " (Proportion of " & tmpi & " days out of " & tmpi1 & " if assumed that Set Balance includes accrual as from " & last_accrue_date & ")"
                                    End If
                                Else
                                    tmp_additional_remark = " (Proportion of " & tmpi & " days out of " & tmpi1 & " if assumed that Set Balance includes accrual as from " & last_accrue_date & ")"
                                End If
                            End If
                        End If
                        last_setbalance_date = New Date(1960, 1, 1)
                    End If
                End If
                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Accrual : " & delta & " " & accrueunit(idx) & " @ " & Replace(accruetype(idx), " x ", " " & accruetypeamount(idx) & " ") & vbCrLf
            Else
                If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    Accrual : " & accrueamount(idx) & " " & accrueunit(idx) & " @ " & accruetype(idx) & vbCrLf
            End If
            If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & Math.Round(uptotalaccrual, 4) & " + " & accrueamount(idx) & vbCrLf

            ' 23/06/2004 : Check if the TOTAL balance has not been reached
            If maxtotbalance(idx) <> 0 Then
                tmpdbl = uptotalaccrual + delta - tmp_tot_taken + uptotalaccum
                If tmpdbl >= maxtotbalance(idx) Then
                    tmpdbl = tmpdbl
                    tmpdt = tmpdt
                    delta = Math.Round(delta - (tmpdbl - maxtotbalance(idx)), 6) ' Adjust the accrual to a portion of the total, so that the total balance does not exceed the max
                    tmp_additional_remark = " : Max Balance of " & maxtotbalance(idx) & " reached"
                End If
            End If

            If x_amount > 0 Then
                uptotalaccrual = uptotalaccrual + delta
                x_amount = 0
            Else
                uptotalaccrual = uptotalaccrual + delta
            End If
            If ipShowCalcMethod Then upCalcMethod = upCalcMethod & "    = " & Math.Round(uptotalaccrual, 4)

            ' Calculate the total value of the leave at this point in time
            ' ------------------------------------------------------------
            value_remark = String.Empty
            tmpd = 0
            If maxsalary > 0 Then
                For tmpi = maxsalary To 1 Step -1
                    If tmpdt >= salary_as_at_date(tmpi) And salary_template(tmpi) = paytemplate(idx) And salary_field(tmpi) = fieldname(idx) Then
                        ' Build the Accrual Array
                        maxaccrual = maxaccrual + 1
                        ReDim Preserve accruedate(maxaccrual)
                        ReDim Preserve accrual(maxaccrual)
                        ReDim Preserve prevaccrual(maxaccrual)
                        ReDim Preserve accrualsalary(maxaccrual)
                        ReDim Preserve accrualsalarytcp(maxaccrual)

                        accruedate(maxaccrual) = tmpdt
                        ' A salary record is found for the specific date
                        If accruetypeamount(idx) <> -999 Then
                            tmpd = delta * salary(tmpi)
                            leave_value = leave_value + (tmpd)
                            value_remark = "Value accrual = " & delta & " x " & Math.Round(CSng(salary(tmpi)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(tmpi)), 2) & ") = " & Math.Round(tmpd, 2)
                            accrual(maxaccrual) = delta
                        Else
                            tmpd = accrueamount(idx) * salary(tmpi)
                            leave_value = leave_value + (tmpd)
                            value_remark = "Value accrual = " & accrueamount(idx) & " x " & Math.Round(CSng(salary(tmpi)), 4) & " (tcp=" & Math.Round(CSng(salarytcp(tmpi)), 2) & ") = " & Math.Round(tmpd, 2)
                            accrual(maxaccrual) = accrueamount(idx)
                        End If
                        accrualsalary(maxaccrual) = salary(tmpi)
                        accrualsalarytcp(maxaccrual) = salarytcp(tmpi)
                        prevaccrual(maxaccrual) = accrual(maxaccrual)

                        value_remark = value_remark & "   New total value = " & Format(leave_value, NumericFormat)
                        Exit For
                    End If
                Next tmpi
            End If

            tmp_tot_taken = 0
            If max_taken > 0 Then
                For tmpi = 1 To max_taken ' The reason why I loop through the array on each pass is because of the change in cycle start date
                    If taken_date(tmpi) >= taken_sd And tmpdt > taken_date(tmpi) Then
                        ' 06/02/2003 : If it is capitalized from the normal balance in the case of no accumulation. After discussion with Willem, it was decided that ALL Capitilizations must be deducted off the Accumulated Balance
                        If Not allowaccum(idx) Then   ' No accumulation, all taken including capitalisations are deducted off normal balance
                            tmp_tot_taken = tmp_tot_taken + taken_amount(tmpi)
                        Else
                            If taken_to_date(tmpi) <> New Date(1960, 1, 1) Then tmp_tot_taken = tmp_tot_taken + taken_amount(tmpi) ' EXCLUDE the Capitalizations marked with a date as New Date(1960, 1, 1)
                        End If
                    End If
                Next tmpi
            End If
        End If

    End Sub

    Private Function get_total_future_approved_leave(ByRef ipcomp As String, ByRef ipemp As String, ByRef ipLeaveType As String, ByRef ipDate As Date) As Object

        Return GetSQLFieldObj("SELECT Sum(Duration) as Tot FROM Leave WHERE Companynum = '" & ipcomp & "' and EmployeeNum = '" & ipemp & "' and LeaveType = '" & ipLeaveType & "' and StartDate >= '" & Format(ipDate, "yyyy-MM-dd") & "' and LeaveStatus = 'HR Granted'", "Tot")

    End Function

End Module