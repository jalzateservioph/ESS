Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class ExternalTrainingEmailNotif
    Implements IEmailNotification

    Private Const EMAIL_TEMPLATE_UPDSTAT As String = "External: Update External Training Status"
    Private Const EMAIL_TEMPLATE_STEP2_HRD As String = "External: Request Assessment & Registration - HRD"
    Private Const EMAIL_TEMPLATE_STEP2_TM As String = "External: Request Assessment & Registration - TM"
    Private Const EMAIL_TEMPLATE_STEP3_HRD As String = "External: Budget Assessment - HRD"
    Private Const EMAIL_TEMPLATE_STEP3_TM As String = "External: Budget Assessment - TM"
    Private Const EMAIL_TEMPLATE_STEP4_HRD As String = "External: Payment Order (PO) Preparation - HRD"
    Private Const EMAIL_TEMPLATE_STEP4_TM As String = "External: Payment Order (PO) Preparation - TM"
    Private Const EMAIL_TEMPLATE_STEP5_HRD As String = "External: Check Preparation - HRD"
    Private Const EMAIL_TEMPLATE_STEP5_TM As String = "External: Check Preparation - TM"
    Private Const EMAIL_TEMPLATE_STEP6_HRD As String = "External: Claim Check - HRD"
    Private Const EMAIL_TEMPLATE_STEP6_TM As String = "External: Claim Check - TM"
    Private Const EMAIL_TEMPLATE_STEP7 As String = "External: Post Training Activity"

    Private Const FREQUENCY_UPDSTAT As String = "0" ' Days
    Private Const FREQUENCY_STEP2_HRD_1 As String = "17" ' Days
    Private Const FREQUENCY_STEP2_HRD_2 As String = "16" ' Days
    Private Const FREQUENCY_STEP2_TM As String = "15" ' Days
    Private Const FREQUENCY_STEP3_HRD_1 As String = "14" ' Days
    Private Const FREQUENCY_STEP3_HRD_2 As String = "13" ' Days
    Private Const FREQUENCY_STEP3_TM As String = "12" ' Days
    Private Const FREQUENCY_STEP4_HRD_1 As String = "10" ' Days
    Private Const FREQUENCY_STEP4_HRD_2 As String = "9" ' Days
    Private Const FREQUENCY_STEP4_TM As String = "8" ' Days
    Private Const FREQUENCY_STEP5_HRD_1 As String = "7" ' Days
    Private Const FREQUENCY_STEP5_HRD_2 As String = "6" ' Days
    Private Const FREQUENCY_STEP5_TM As String = "5" ' Days
    Private Const FREQUENCY_STEP6_HRD_1 As String = "3" ' Days
    Private Const FREQUENCY_STEP6_HRD_2 As String = "2" ' Days
    Private Const FREQUENCY_STEP6_TM As String = "1" ' Days
    Private Const FREQUENCY_STEP7 As String = "1" ' Days

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
                "Step2_HRD", "Step2_TM",
                "Step3_HRD", "Step3_TM",
                "Step4_HRD", "Step4_TM",
                "Step5_HRD", "Step5_TM",
                "Step6_HRD", "Step6_TM",
                "Step7"
            }

            Dim emailTemplateList As Dictionary(Of String, String) = New Dictionary(Of String, String)() From {
                {"UpdStat", EMAIL_TEMPLATE_UPDSTAT},
                {"Step2_HRD", EMAIL_TEMPLATE_STEP2_HRD},
                {"Step2_TM", EMAIL_TEMPLATE_STEP2_TM},
                {"Step3_HRD", EMAIL_TEMPLATE_STEP3_HRD},
                {"Step3_TM", EMAIL_TEMPLATE_STEP3_TM},
                {"Step4_HRD", EMAIL_TEMPLATE_STEP4_HRD},
                {"Step4_TM", EMAIL_TEMPLATE_STEP4_TM},
                {"Step5_HRD", EMAIL_TEMPLATE_STEP5_HRD},
                {"Step5_TM", EMAIL_TEMPLATE_STEP5_TM},
                {"Step6_HRD", EMAIL_TEMPLATE_STEP6_HRD},
                {"Step6_TM", EMAIL_TEMPLATE_STEP6_TM},
                {"Step7", EMAIL_TEMPLATE_STEP7}
            }

            Using rslt As DataTable = GetTrainingRecords()
                If rslt.Rows.Count > 0 Then
                    For Each externalEmailNotif As String In externalEmailNotifList
                        Dim emailSetup As EmailSetup =
                            GetEmailSetup(sqlConnection, sqlHelper, emailTemplateList(externalEmailNotif))

                        If emailSetup IsNot Nothing Then                            
                            If externalEmailNotif = "UpdStat" Then
                                rslt.DefaultView.RowFilter = "DaysAfterEnd = " & FREQUENCY_UPDSTAT
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step2_HRD" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP2_HRD_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP2_HRD_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step2_TM" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP2_TM
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step3_HRD" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP3_HRD_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP3_HRD_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step3_TM" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP3_TM
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step4_HRD" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP4_HRD_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP4_HRD_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step4_TM" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP4_TM
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step5_HRD" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP5_HRD_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP5_HRD_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step5_TM" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP5_TM
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step6_HRD" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP6_HRD_1
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)

                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP6_HRD_2
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step6_TM" Then
                                rslt.DefaultView.RowFilter = "DaysBeforeStart = " & FREQUENCY_STEP6_TM
                                SendEmailToTeamMember(rslt.DefaultView.ToTable(), emailSetup)
                            ElseIf externalEmailNotif = "Step7" Then
                                rslt.DefaultView.RowFilter = "DaysAfterEnd = " & FREQUENCY_STEP7
                                SendEmailToHRDTrainingTeam(rslt.DefaultView.ToTable(), emailSetup)
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
                "Surname", "FirstName", "EMailAddress",
                "DaysBeforeStart", "DaysAfterEnd")

            For Each row As DataRow In rslt.Rows
                Dim trainingType As String = [CStr](row("TrainingType"))
                Dim courseName As String = [CStr](row("CourseName"))
                Dim providerName As String = [CStr](row("ProviderName"))
                Dim startDate As String = [CDate](row("StartDate")).ToString("MM/dd/yyyy")
                Dim completionDate As String = [CDate](row("CompletionDate")).ToString("MM/dd/yyyy")
                Dim venueName As String = [CStr](row("VenueName"))
                Dim surname As String = [CStr](row("Surname"))
                Dim firstName As String = [CStr](row("FirstName"))
                Dim toEmailAddress As String = [CStr](row("EMailAddress"))
                Dim daysBeforeStart As String = [CStr](row("DaysBeforeStart"))
                Dim daysAfterEnd As String = [CStr](row("DaysAfterEnd"))

                Dim bodyHtml As String = emailSetup.OrigBodyHtml
                Dim bodyText As String = emailSetup.OrigBodyText

                emailSetup.BodyHtml =
                    bodyHtml.ReplaceEmailParams(0, trainingType) _
                            .ReplaceEmailParams(1, courseName) _
                            .ReplaceEmailParams(2, providerName) _
                            .ReplaceEmailParams(3, startDate) _
                            .ReplaceEmailParams(4, completionDate) _
                            .ReplaceEmailParams(5, venueName) _
                            .ReplaceEmailParams(6, daysBeforeStart) _
                            .ReplaceEmailParams(7, daysAfterEnd)

                emailSetup.BodyText =
                    bodyText.ReplaceEmailParams(0, trainingType) _
                            .ReplaceEmailParams(1, courseName) _
                            .ReplaceEmailParams(2, providerName) _
                            .ReplaceEmailParams(3, startDate) _
                            .ReplaceEmailParams(4, completionDate) _
                            .ReplaceEmailParams(5, venueName) _
                            .ReplaceEmailParams(6, daysBeforeStart) _
                            .ReplaceEmailParams(7, daysAfterEnd)

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
                        Dim daysBeforeStart As String = [CStr](rows(0)("DaysBeforeStart"))
                        Dim daysAfterEnd As String = [CStr](rows(0)("DaysAfterEnd"))

                        Dim bodyHtml As String = emailSetup.OrigBodyHtml
                        Dim bodyText As String = emailSetup.OrigBodyText

                        emailSetup.BodyHtml =
                            bodyHtml.ReplaceEmailParams(0, trainingType) _
                                    .ReplaceEmailParams(1, courseName) _
                                    .ReplaceEmailParams(2, providerName) _
                                    .ReplaceEmailParams(3, startDate) _
                                    .ReplaceEmailParams(4, completionDate) _
                                    .ReplaceEmailParams(5, venueName) _
                                    .ReplaceEmailParams(6, daysBeforeStart) _
                                    .ReplaceEmailParams(7, daysAfterEnd)

                        emailSetup.BodyText =
                            bodyText.ReplaceEmailParams(0, trainingType) _
                                    .ReplaceEmailParams(1, courseName) _
                                    .ReplaceEmailParams(2, providerName) _
                                    .ReplaceEmailParams(3, startDate) _
                                    .ReplaceEmailParams(4, completionDate) _
                                    .ReplaceEmailParams(5, venueName) _
                                    .ReplaceEmailParams(6, daysBeforeStart) _
                                    .ReplaceEmailParams(7, daysAfterEnd)

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
            "	TrainingType = 'External', " &
            "	A.*, " &
            "	P.Surname, " &
            "	P.FirstName, " &
            "	P.EMailAddress, " &
            "	ReportsTo_Surname = P_RT.Surname, " &
            "	ReportsTo_FirstName = P_RT.FirstName, " &
            "	ReportsTo_EMailAddress = P_RT.EMailAddress, " &
            "	DaysBeforeStart = DATEDIFF(DAY, GETDATE(), A.StartDate), " &
            "	DaysAfterEnd = DATEDIFF(DAY, A.CompletionDate, GETDATE()) " &
            "FROM ( " &
            "SELECT " &
            "	[CompanyNum] = TP.[CompanyNum], " &
            "	[EmployeeNum] = TP.[EmployeeNum], " &
            "   [CourseName] = TP.[CourseName], " &
            "	[ProviderName] = TP.[ProviderName], " &
            "   [StartDate] = TAD.[DateFrom], " &
            "   [StartDate_Formatted] = CONVERT(VARCHAR, TAD.[DateFrom], 101), " &
            "   [CompletionDate] = TAD.[DateTo], " &
            "	[VenueName] = TP.[VenueName] " &
            "FROM TrainingPlanned TP " &
            "LEFT JOIN CourseLU C " &
            "    ON C.[CourseName] = TP.[CourseName] " &
            "LEFT JOIN TrainingAgreementForm TAF " &
            "    ON TP.[PathID] = TAF.[PathID] " &
            "LEFT JOIN TAFProgramDetails TAD " &
            "    ON TAF.[TAFID] = TAD.[TAFID] " &
            "LEFT JOIN TrainingCompleted TC " &
            "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " &
            "   AND TC.[CompanyNum] = TP.[CompanyNum] " &
            "   AND TC.[CourseName] = TP.[CourseName] " &
            "   AND TC.[ProviderName] = TP.[ProviderName] " &
            "   AND TC.[StartDate] = TP.[StartDate] " &
            "WHERE TP.[CourseName] IS NOT NULL " &
            "  AND TP.[CourseName] <> '' " &
            "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " &
            "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " &
            "  AND TP.[TrainingStatus] LIKE 'Approve%' " &
            "  AND TC.[CompanyNum] IS NULL " &
            "UNION ALL " &
            "SELECT " &
            "	[CompanyNum] = TC.[CompanyNum], " &
            "	[EmployeeNum] = TC.[EmployeeNum], " &
            "   [CourseName] = TC.[CourseName], " &
            "   [ProviderName] = TC.[ProviderName], " &
            "   [StartDate] = TAD.[DateFrom], " &
            "   [StartDate_Formatted] = CONVERT(VARCHAR, TAD.[DateFrom], 101), " &
            "   [CompletionDate] = TAD.[DateTo], " &
            "   [VenueName] = TC.[VenueName] " &
            "FROM TrainingCompleted TC " &
            "LEFT JOIN CourseLU C " &
            "    ON C.[CourseName] = TC.[CourseName] " &
            "LEFT JOIN TrainingAgreementForm TAF " &
            "    ON TC.[PathID] = TAF.[PathID] " &
            "LEFT JOIN TAFProgramDetails TAD " &
            "    ON TAF.[TAFID] = TAD.[TAFID] " &
            "LEFT JOIN TrainingEvaluation TE " &
            "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " &
            "   AND TE.[CompanyNum] = TC.[CompanyNum] " &
            "   AND TE.[CourseName] = TC.[CourseName] " &
            "   AND TE.[ProviderName] = TC.[ProviderName] " &
            "WHERE TC.[CourseName] IS NOT NULL " &
            "  AND TC.[CourseName] <> '' " &
            "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " &
            "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " &
            "  AND TC.[TrainingStatus] LIKE 'Approve%' " &
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
