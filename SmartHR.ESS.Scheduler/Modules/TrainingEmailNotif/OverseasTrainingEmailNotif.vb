Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class OverseasTrainingEmailNotif
    Implements IEmailNotification

    Private Const EMAIL_TEMPLATE_UPDSTAT As String = "Overseas: Update Overseas Training Status"
    Private Const EMAIL_TEMPLATE_ASSGN_START As String = "Overseas: Start of Assignment Reminder"
    Private Const EMAIL_TEMPLATE_ASSGN_END As String = "Overseas: End of Assignment Reminder"
    Private Const EMAIL_TEMPLATE_TBP_APPRV As String = "Overseas: TBP Theme Approval"
    Private Const EMAIL_TEMPLATE_TBP_MID As String = "Overseas: TBP Midterm Review"
    Private Const EMAIL_TEMPLATE_TBP_FINAL As String = "Overseas: TBP Final Report-out"

    Private Const FREQUENCY_UPDSTAT_LOCAL As String = "5" ' Days
    Private Const FREQUENCY_UPDSTAT_FOREIGN As String = "20" ' Days
    Private Const FREQUENCY_ASSGN_START_1 As String = "1" ' Months
    Private Const FREQUENCY_ASSGN_START_2 As String = "2" ' Months
    Private Const FREQUENCY_ASSGN_START_3 As String = "3" ' Months
    Private Const FREQUENCY_ASSGN_START_4 As String = "4" ' Months
    Private Const FREQUENCY_ASSGN_START_5 As String = "5" ' Months
    Private Const FREQUENCY_ASSGN_START_6 As String = "6" ' Months
    Private Const FREQUENCY_ASSGN_END_1 As String = "1" ' Months
    Private Const FREQUENCY_ASSGN_END_2 As String = "2" ' Months
    Private Const FREQUENCY_TBP_APPRV_1 As String = "2" ' Weeks
    Private Const FREQUENCY_TBP_APPRV_2 As String = "1" ' Months
    Private Const FREQUENCY_TBP_MID_1 As String = "2" ' Months
    Private Const FREQUENCY_TBP_MID_2 As String = "4" ' Months
    Private Const FREQUENCY_TBP_FINAL As String = "5" ' Months

    Private sqlConnection As SqlConnection
    Private sqlHelper As SqlHelper

    Dim className As String = ""

    Public Sub New()
        sqlHelper = New SqlHelper(ConfigurationHelper.SqlRequestTimeout)
        sqlConnection = sqlHelper.CreateSqlConnection()

        className = [GetType]().FullName.Split("."c).Last()
    End Sub

    Public Sub ExecuteNotification() Implements IEmailNotification.ExecuteNotification
        Try
            Dim externalEmailNotifList As List(Of String) = New List(Of String)() From {
                "UpdStat",
                "Assgn_Start", "Assgn_End",
                "TBP_Apprv", "TBP_Mid", "TBP_Final"
            }

            Dim emailTemplateList As Dictionary(Of String, String) = New Dictionary(Of String, String)() From {
                {"UpdStat", EMAIL_TEMPLATE_UPDSTAT},
                {"Assgn_Start", EMAIL_TEMPLATE_ASSGN_START},
                {"Assgn_End", EMAIL_TEMPLATE_ASSGN_END},
                {"TBP_Apprv", EMAIL_TEMPLATE_TBP_APPRV},
                {"TBP_Mid", EMAIL_TEMPLATE_TBP_MID},
                {"TBP_Final", EMAIL_TEMPLATE_TBP_FINAL}
            }

            Using rslt As DataTable = GetTrainingRecords()
                If rslt.Rows.Count > 0 Then
                    For Each externalEmailNotif As String In externalEmailNotifList
                        Dim emailSetup As EmailSetup =
                            GetEmailSetup(sqlConnection, sqlHelper, emailTemplateList(externalEmailNotif))

                        If emailSetup IsNot Nothing Then
                            If externalEmailNotif = "UpdStat" Then
                                rslt.DefaultView.RowFilter = "ICTType = 'Local' AND DaysAfterEnd = " & FREQUENCY_UPDSTAT_LOCAL
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "ICTType = 'Foreign' AND DaysBeforeEnd = " & FREQUENCY_UPDSTAT_FOREIGN
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Assgn_Start" Then
                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_3
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_4
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_5
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeStart = " & FREQUENCY_ASSGN_START_6
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Assgn_End" Then
                                rslt.DefaultView.RowFilter = "MonthsBeforeEnd = " & FREQUENCY_ASSGN_END_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsBeforeEnd = " & FREQUENCY_ASSGN_END_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "TBP_Apprv" Then
                                rslt.DefaultView.RowFilter = "WeeksAfterEnd = " & FREQUENCY_TBP_APPRV_1
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsAfterEnd = " & FREQUENCY_TBP_APPRV_2
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "TBP_Mid" Then
                                rslt.DefaultView.RowFilter = "MonthsAfterEnd = " & FREQUENCY_TBP_MID_1
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "MonthsAfterEnd = " & FREQUENCY_TBP_MID_2
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "TBP_Final" Then
                                rslt.DefaultView.RowFilter = "MonthsAfterEnd = " & FREQUENCY_TBP_FINAL
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            End If
                        End If
                    Next
                End If

                rslt.Clear()
            End Using
        Catch ex As Exception
            WriteEventLog("SmartHR.ESS.Scheduler - " & className, "Application", GetErrorMessage(ex))
        Finally
            If sqlConnection IsNot Nothing Then
                If sqlConnection.State <> ConnectionState.Closed Then
                    sqlConnection.Close()
                End If
                sqlConnection.Dispose()
                sqlConnection = Nothing
            End If
        End Try
    End Sub

    Private Sub SendEmailToTeamMember(ByVal rslt As DataTable, ByVal emailSetup As EmailSetup)
        If rslt.Rows.Count > 0 Then
            rslt = rslt.DefaultView.ToTable(True,
                "TrainingType", "CourseName", "ProviderName",
                "StartDate", "CompletionDate", "VenueName",
                "ICTType", "Surname", "FirstName", "EMailAddress",
                "DaysBeforeStart", "DaysBeforeEnd", "DaysAfterEnd",
                "WeeksBeforeStart", "WeeksBeforeEnd", "WeeksAfterEnd",
                "MonthsBeforeStart", "MonthsBeforeEnd", "MonthsAfterEnd")

            For Each row As DataRow In rslt.Rows
                Dim trainingType As String = [CStr](row("TrainingType"))
                Dim courseName As String = [CStr](row("CourseName"))
                Dim providerName As String = [CStr](row("ProviderName"))
                Dim startDate As String = [CDate](row("StartDate")).ToString("MM/dd/yyyy")
                Dim completionDate As String = [CDate](row("CompletionDate")).ToString("MM/dd/yyyy")
                Dim venueName As String = [CStr](row("VenueName"))
                Dim iCTType As String = [CStr](row("ICTType"))
                Dim surname As String = [CStr](row("Surname"))
                Dim firstName As String = [CStr](row("FirstName"))
                Dim toEmailAddress As String = [CStr](row("EMailAddress"))
                Dim daysBeforeStart As String = [CStr](row("DaysBeforeStart"))
                Dim daysBeforeEnd As String = [CStr](row("DaysBeforeEnd"))
                Dim daysAfterEnd As String = [CStr](row("DaysAfterEnd"))
                Dim weeksBeforeStart As String = [CStr](row("WeeksBeforeStart"))
                Dim weeksBeforeEnd As String = [CStr](row("WeeksBeforeEnd"))
                Dim weeksAfterEnd As String = [CStr](row("WeeksAfterEnd"))
                Dim monthsBeforeStart As String = [CStr](row("MonthsBeforeStart"))
                Dim monthsBeforeEnd As String = [CStr](row("MonthsBeforeEnd"))
                Dim monthsAfterEnd As String = [CStr](row("MonthsAfterEnd"))

                Dim bodyHtml As String = emailSetup.OrigBodyHtml
                Dim bodyText As String = emailSetup.OrigBodyText

                emailSetup.BodyHtml =
                    bodyHtml.ReplaceEmailParams(0, trainingType) _
                            .ReplaceEmailParams(1, courseName) _
                            .ReplaceEmailParams(2, providerName) _
                            .ReplaceEmailParams(3, startDate) _
                            .ReplaceEmailParams(4, completionDate) _
                            .ReplaceEmailParams(5, venueName) _
                            .ReplaceEmailParams(6, iCTType) _
                            .ReplaceEmailParams(7, daysBeforeStart) _
                            .ReplaceEmailParams(8, daysBeforeEnd) _
                            .ReplaceEmailParams(9, daysAfterEnd) _
                            .ReplaceEmailParams(10, weeksBeforeStart) _
                            .ReplaceEmailParams(11, weeksBeforeEnd) _
                            .ReplaceEmailParams(12, weeksAfterEnd) _
                            .ReplaceEmailParams(13, monthsBeforeStart) _
                            .ReplaceEmailParams(14, monthsBeforeEnd) _
                            .ReplaceEmailParams(15, monthsAfterEnd)

                emailSetup.BodyText =
                    bodyText.ReplaceEmailParams(0, trainingType) _
                            .ReplaceEmailParams(1, courseName) _
                            .ReplaceEmailParams(2, providerName) _
                            .ReplaceEmailParams(3, startDate) _
                            .ReplaceEmailParams(4, completionDate) _
                            .ReplaceEmailParams(5, venueName) _
                            .ReplaceEmailParams(6, iCTType) _
                            .ReplaceEmailParams(7, daysBeforeStart) _
                            .ReplaceEmailParams(8, daysBeforeEnd) _
                            .ReplaceEmailParams(9, daysAfterEnd) _
                            .ReplaceEmailParams(10, weeksBeforeStart) _
                            .ReplaceEmailParams(11, weeksBeforeEnd) _
                            .ReplaceEmailParams(12, weeksAfterEnd) _
                            .ReplaceEmailParams(13, monthsBeforeStart) _
                            .ReplaceEmailParams(14, monthsBeforeEnd) _
                            .ReplaceEmailParams(15, monthsAfterEnd)

                SendEmail(
                    sqlConnection,
                    sqlHelper,
                    emailSetup,
                    New MailAddress() {New MailAddress(toEmailAddress, firstName + " " + surname)})
            Next
        End If
    End Sub

    Private Sub SendEmailToHRDTrainingTeam(ByVal rslt As DataTable, ByVal emailSetup As EmailSetup)
        If rslt.Rows.Count > 0 Then
            Using empls As DataTable = rslt.DefaultView.ToTable(True, "CompanyNum", "EmployeeNum", "CourseName", "ProviderName", "StartDate")
                For Each empl As DataRow In empls.Rows
                    Dim companyNum As String = [CStr](empl("CompanyNum"))
                    Dim employeeNum As String = [CStr](empl("EmployeeNum"))
                    Dim courseName As String = [CStr](empl("CourseName"))
                    Dim providerName As String = [CStr](empl("ProviderName"))
                    Dim startDate As String = [CDate](empl("StartDate")).ToString("MM/dd/yyyy")

                    Dim rows As DataRow() = rslt.Select(
                        "CompanyNum = '" & companyNum & "' AND " & _
                        "EmployeeNum = '" & employeeNum & "' AND " & _
                        "CourseName = '" & courseName & "' AND " & _
                        "ProviderName = '" & providerName & "' AND " & _
                        "StartDate_Formatted = '" & startDate & "'")

                    If rows.Length > 0 Then
                        Dim trainingType As String = [CStr](rows(0)("TrainingType"))
                        Dim completionDate As String = [CDate](rows(0)("CompletionDate")).ToString("MM/dd/yyyy")
                        Dim venueName As String = [CStr](rows(0)("VenueName"))
                        Dim iCTType As String = [CStr](rows(0)("ICTType"))
                        Dim daysBeforeStart As String = [CStr](rows(0)("DaysBeforeStart"))
                        Dim daysBeforeEnd As String = [CStr](rows(0)("DaysBeforeEnd"))
                        Dim daysAfterEnd As String = [CStr](rows(0)("DaysAfterEnd"))
                        Dim weeksBeforeStart As String = [CStr](rows(0)("WeeksBeforeStart"))
                        Dim weeksBeforeEnd As String = [CStr](rows(0)("WeeksBeforeEnd"))
                        Dim weeksAfterEnd As String = [CStr](rows(0)("WeeksAfterEnd"))
                        Dim monthsBeforeStart As String = [CStr](rows(0)("MonthsBeforeStart"))
                        Dim monthsBeforeEnd As String = [CStr](rows(0)("MonthsBeforeEnd"))
                        Dim monthsAfterEnd As String = [CStr](rows(0)("MonthsAfterEnd"))

                        Dim bodyHtml As String = emailSetup.OrigBodyHtml
                        Dim bodyText As String = emailSetup.OrigBodyText

                        emailSetup.BodyHtml =
                            bodyHtml.ReplaceEmailParams(0, trainingType) _
                                    .ReplaceEmailParams(1, courseName) _
                                    .ReplaceEmailParams(2, providerName) _
                                    .ReplaceEmailParams(3, startDate) _
                                    .ReplaceEmailParams(4, completionDate) _
                                    .ReplaceEmailParams(5, venueName) _
                                    .ReplaceEmailParams(6, iCTType) _
                                    .ReplaceEmailParams(7, daysBeforeStart) _
                                    .ReplaceEmailParams(8, daysBeforeEnd) _
                                    .ReplaceEmailParams(9, daysAfterEnd) _
                                    .ReplaceEmailParams(10, weeksBeforeStart) _
                                    .ReplaceEmailParams(11, weeksBeforeEnd) _
                                    .ReplaceEmailParams(12, weeksAfterEnd) _
                                    .ReplaceEmailParams(13, monthsBeforeStart) _
                                    .ReplaceEmailParams(14, monthsBeforeEnd) _
                                    .ReplaceEmailParams(15, monthsAfterEnd)

                        emailSetup.BodyText =
                            bodyText.ReplaceEmailParams(0, trainingType) _
                                    .ReplaceEmailParams(1, courseName) _
                                    .ReplaceEmailParams(2, providerName) _
                                    .ReplaceEmailParams(3, startDate) _
                                    .ReplaceEmailParams(4, completionDate) _
                                    .ReplaceEmailParams(5, venueName) _
                                    .ReplaceEmailParams(6, iCTType) _
                                    .ReplaceEmailParams(7, daysBeforeStart) _
                                    .ReplaceEmailParams(8, daysBeforeEnd) _
                                    .ReplaceEmailParams(9, daysAfterEnd) _
                                    .ReplaceEmailParams(10, weeksBeforeStart) _
                                    .ReplaceEmailParams(11, weeksBeforeEnd) _
                                    .ReplaceEmailParams(12, weeksAfterEnd) _
                                    .ReplaceEmailParams(13, monthsBeforeStart) _
                                    .ReplaceEmailParams(14, monthsBeforeEnd) _
                                    .ReplaceEmailParams(15, monthsAfterEnd)

                        Dim toEmailAddresses As List(Of MailAddress) = New List(Of MailAddress)

                        For Each row As DataRow In rows
                            Dim surname As String = [CStr](row("ReportsTo_Surname"))
                            Dim firstName As String = [CStr](row("ReportsTo_FirstName"))
                            Dim toEmailAddress As String = [CStr](row("ReportsTo_EMailAddress"))

                            toEmailAddresses.Add(New MailAddress(toEmailAddress, firstName + " " + surname))
                        Next

                        SendEmail(
                            sqlConnection,
                            sqlHelper,
                            emailSetup,
                            toEmailAddresses.ToArray())

                        toEmailAddresses.Clear()
                    End If
                Next

                empls.Clear()
            End Using
        End If
    End Sub

    Private Function GetTrainingRecords() As DataTable
        If sqlConnection.State <> ConnectionState.Open Then
            Throw New Exception("Connection closed!")
        End If

        sqlHelper.SetSqlStatement(
            "DECLARE @TblRptTo TABLE (ReportsToType VARCHAR(100)) " &
            "INSERT INTO @TblRptTo (ReportsToType) " &
            "SELECT DISTINCT A.ReportsToType " &
            "FROM [ess.WF] WF " &
            "INNER JOIN [ess.WFLU] WFLU " &
            "	ON WFLU.ID = WF.WFLUID " &
            "INNER JOIN [ess.ActionLU] A " &
            "	ON A.ID = WF.ActionID " &
            "INNER JOIN [ess.StatusLU] S " &
            "	ON S.ID = WF.StatusID " &
            "WHERE WFLU.[WFType] = 'Training' " &
            "  AND WFLU.[WFName] = 'Training' " &
            "  AND S.[Status] = 'Approve' " &
            " " &
            "SELECT  " &
            "	TrainingType = 'Overseas', " &
            "	A.*, " &
            "	P.Surname, " &
            "	P.FirstName, " &
            "	P.EMailAddress, " &
            "	ReportsTo_Surname = P_RT.Surname, " &
            "	ReportsTo_FirstName = P_RT.FirstName, " &
            "	ReportsTo_EMailAddress = P_RT.EMailAddress, " &
            "	DaysBeforeStart = DATEDIFF(DAY, GETDATE(), A.StartDate), " &
            "	DaysBeforeEnd = DATEDIFF(DAY, GETDATE(), A.CompletionDate), " &
            "	DaysAfterEnd = DATEDIFF(DAY, A.CompletionDate, GETDATE()), " &
            "	WeeksBeforeStart = DATEDIFF(DAY, GETDATE(), A.StartDate) / 7, " &
            "	WeeksBeforeEnd = DATEDIFF(DAY, GETDATE(), A.CompletionDate) / 7, " &
            "	WeeksAfterEnd = DATEDIFF(DAY, A.CompletionDate, GETDATE()) / 7, " &
            "	MonthsBeforeStart = DATEDIFF(DAY, GETDATE(), A.StartDate) / 30, " &
            "	MonthsBeforeEnd = DATEDIFF(DAY, GETDATE(), A.CompletionDate) / 30, " &
            "	MonthsAfterEnd = DATEDIFF(DAY, A.CompletionDate, GETDATE()) / 30 " &
            "FROM ( " &
            "SELECT " &
            "	[CompanyNum] = TP.[CompanyNum], " &
            "	[EmployeeNum] = TP.[EmployeeNum], " &
            "   [CourseName] = TP.[CourseName], " &
            "	[ProviderName] = TP.[ProviderName], " &
            "   [StartDate] = TP.[StartDate], " &
            "   [StartDate_Formatted] = CONVERT(VARCHAR, TP.[StartDate], 101), " &
            "   [CompletionDate] = TP.[CompletionDate], " &
            "	[VenueName] = TP.[VenueName], " &
            "	[ICTType] = 'Local' " &
            "FROM TrainingPlanned TP " &
            "LEFT JOIN CourseLU C " &
            "    ON C.[CourseName] = TP.[CourseName] " &
            "LEFT JOIN TrainingCompleted TC " &
            "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " &
            "   AND TC.[CompanyNum] = TP.[CompanyNum] " &
            "   AND TC.[CourseName] = TP.[CourseName] " &
            "   AND TC.[ProviderName] = TP.[ProviderName] " &
            "   AND TC.[StartDate] = TP.[StartDate] " &
            "WHERE TP.[CourseName] IS NOT NULL " &
            "  AND TP.[CourseName] <> '' " &
            "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " &
            "  AND C.[Overseas] = 1 " &
            "  AND (TP.[TrainingStatus] LIKE 'Approve%' OR TP.[TrainingStatus] = 'Completed') " &
            "  AND TC.[CompanyNum] IS NULL " &
            "UNION ALL " &
            "SELECT " &
            "	[CompanyNum] = TC.[CompanyNum], " &
            "	[EmployeeNum] = TC.[EmployeeNum], " &
            "   [CourseName] = TC.[CourseName], " &
            "   [ProviderName] = TC.[ProviderName], " &
            "   [StartDate] = TC.[StartDate], " &
            "   [StartDate_Formatted] = CONVERT(VARCHAR, TC.[StartDate], 101), " &
            "   [CompletionDate] = TC.[CompletionDate], " &
            "   [VenueName] = TC.[VenueName], " &
            "	[ICTType] = ISNULL(TC.[cfICTType], 'Local') " &
            "FROM TrainingCompleted TC " &
            "LEFT JOIN CourseLU C " &
            "    ON C.[CourseName] = TC.[CourseName] " &
            "LEFT JOIN TrainingEvaluation TE " &
            "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " &
            "   AND TE.[CompanyNum] = TC.[CompanyNum] " &
            "   AND TE.[CourseName] = TC.[CourseName] " &
            "   AND TE.[ProviderName] = TC.[ProviderName] " &
            "WHERE TC.[CourseName] IS NOT NULL " &
            "  AND TC.[CourseName] <> '' " &
            "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " &
            "  AND C.[Overseas] = 1 " &
            "  AND (TC.[TrainingStatus] LIKE 'Approve%' OR TC.[TrainingStatus] = 'Completed') " &
            ") A " &
            "INNER JOIN ReportsTo RT " &
            "    ON RT.[CompanyNum] = A.[CompanyNum] " &
            "   AND RT.[EmployeeNum] = A.[EmployeeNum] " &
            "INNER JOIN Personnel P " &
            "	ON P.[CompanyNum] = A.[CompanyNum] " &
            "   AND P.[EmployeeNum] = A.[EmployeeNum] " &
            "INNER JOIN Personnel P_RT " &
            "	ON P_RT.[CompanyNum] = RT.[ReportToCompNum] " &
            "   AND P_RT.[EmployeeNum] = RT.[ReportToEmpNum] " &
            "INNER JOIN @TblRptTo T_RT " &
            "	ON T_RT.[ReportsToType] = RT.[ReportsToType] ",
            sqlConnection)

        Return sqlHelper.ExecuteDataTable()
    End Function

End Class
