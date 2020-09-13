Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class PendingTrainingEvaluation
    Implements IEmailNotification

    Private Const EMAIL_TEMPLATE As String = "Training: Pending Training Evaluation"
    Private Const FREQUENCY As String = "1" ' Days

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
            Dim emailSetup As EmailSetup = GetEmailSetup(sqlConnection, sqlHelper, EMAIL_TEMPLATE)

            If emailSetup IsNot Nothing Then
                Using rslt As DataTable = GetTrainingRecords()
                    If rslt.Rows.Count > 0 Then
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

                            Dim bodyHtml As String = emailSetup.OrigBodyHtml
                            Dim bodyText As String = emailSetup.OrigBodyText

                            emailSetup.BodyHtml =
                                bodyHtml.ReplaceEmailParams(0, trainingType) _
                                        .ReplaceEmailParams(1, courseName) _
                                        .ReplaceEmailParams(2, providerName) _
                                        .ReplaceEmailParams(3, startDate) _
                                        .ReplaceEmailParams(4, completionDate) _
                                        .ReplaceEmailParams(5, venueName)

                            emailSetup.BodyText =
                                bodyText.ReplaceEmailParams(0, trainingType) _
                                        .ReplaceEmailParams(1, courseName) _
                                        .ReplaceEmailParams(2, providerName) _
                                        .ReplaceEmailParams(3, startDate) _
                                        .ReplaceEmailParams(4, completionDate) _
                                        .ReplaceEmailParams(5, venueName)

                            SendEmail(
                                sqlConnection,
                                sqlHelper,
                                emailSetup,
                                New MailAddress() {New MailAddress(toEmailAddress, firstName + " " + surname)})
                        Next
                    End If

                    rslt.Clear()
                End Using
            End If
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

    Private Function GetTrainingRecords() As DataTable
        If sqlConnection.State <> ConnectionState.Open Then
            Throw New Exception("Connection closed!")
        End If

        sqlHelper.SetSqlStatement(
            "SELECT " &
            "   TrainingType = " &
            "		CASE WHEN C.[InternalCourse] = 1 AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) THEN 'In-House' " &
            "		     WHEN (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) THEN 'External' " &
            "			 WHEN (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) AND C.[Overseas] = 1 THEN 'Overseas' " &
            "		END, " &
            "   TC.CourseName, " &
            "   TC.ProviderName, " &
            "   TC.StartDate, " &
            "   TC.CompletionDate, " &
            "   TC.VenueName, " &
            "   P.Surname, " &
            "   P.FirstName, " &
            "   P.EMailAddress " &
            "FROM TrainingCompleted TC " &
            "INNER JOIN Personnel P " &
            "	ON P.[CompanyNum] = TC.[CompanyNum] " &
            "   AND P.[EmployeeNum] = TC.[EmployeeNum] " &
            "LEFT JOIN CourseLU C " &
            "    ON C.[CourseName] = TC.[CourseName] " &
            "LEFT JOIN TrainingEvaluation TE " &
            "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " &
            "   AND TE.[CompanyNum] = TC.[CompanyNum] " &
            "   AND TE.[CourseName] = TC.[CourseName] " &
            "   AND TE.[ProviderName] = TC.[ProviderName] " &
            "WHERE TC.[CourseName] IS NOT NULL " &
            "  AND TC.[CourseName] <> '' " &
            "  AND TE.[PathID] IS NULL " &
            "  AND DATEDIFF(DAY, TC.CompletionDate, GETDATE()) >= @Frequency ",
            sqlConnection)

        sqlHelper.SetParameter("@Frequency", FREQUENCY)

        Return sqlHelper.ExecuteDataTable()
    End Function

End Class
