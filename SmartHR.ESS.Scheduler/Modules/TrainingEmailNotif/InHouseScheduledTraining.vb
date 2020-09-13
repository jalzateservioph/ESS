Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class InHouseScheduledTraining
    Implements IEmailNotification

    Private Const EMAIL_TEMPLATE As String = "Training: In-house: Scheduled Training Reminder"
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
            "   TrainingType = 'In-House', " &
            "   TP.CourseName, " &
            "   TP.ProviderName, " &
            "   TP.StartDate, " &
            "   TP.CompletionDate, " &
            "   TP.VenueName, " &
            "   P.Surname, " &
            "   P.FirstName, " &
            "   P.EMailAddress " &
            "FROM TrainingPlanned TP " &
            "INNER JOIN Personnel P " &
            "    ON P.[CompanyNum] = TP.[CompanyNum] " &
            "   AND P.[EmployeeNum] = TP.[EmployeeNum] " &
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
            "  AND C.[InternalCourse] = 1 " &
            "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " &
            "  AND TC.[CompanyNum] IS NULL " &
            "  AND DATEDIFF(DAY, GETDATE(), TP.StartDate) = @Frequency ",
            sqlConnection)

        sqlHelper.SetParameter("@Frequency", FREQUENCY)

        Return sqlHelper.ExecuteDataTable()
    End Function

End Class
