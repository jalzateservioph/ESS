Public Class TrainingEmailNotif
    Inherits ProcessBase

    Dim className As String = ""

    Public Sub New(ByVal scheduledDateTimeConfigName As String)
        MyBase.New(scheduledDateTimeConfigName)

        className = [GetType]().FullName.Split("."c).Last()
    End Sub

    Public Overrides Sub Execute()
        Dim eventLogs As List(Of String) = Nothing
        Dim emailNotifs As List(Of IEmailNotification) = Nothing

        Try
            InitializeNotifications(emailNotifs)

            ExecuteNotifications(emailNotifs)

            AddLog(className, className + " Completed")

            WriteEventLog(className,
                "Succesfully completed\n" + String.Join("\n", eventLogs.ToArray()), EventLogEntryType.Information)
        Catch ex As Exception
            AddLog(className, "Error encountered: " + ex.ToString())

            WriteEventLog(className, "Error encountered: " + ex.ToString())
        Finally
            If eventLogs IsNot Nothing Then
                eventLogs.Clear()
                eventLogs = Nothing
            End If
            If emailNotifs IsNot Nothing Then
                emailNotifs.Clear()
                emailNotifs = Nothing
            End If
        End Try
    End Sub

    Private Sub InitializeNotifications(ByRef emailNotifs As List(Of IEmailNotification))
        emailNotifs = New List(Of IEmailNotification)

        emailNotifs.Add(New InHouseScheduledTraining())
        emailNotifs.Add(New PendingTrainingEvaluation())
        emailNotifs.Add(New ExternalTrainingEmailNotif())
        emailNotifs.Add(New OverseasTrainingEmailNotif())
    End Sub

    Private Sub ExecuteNotifications(ByVal emailNotifs As List(Of IEmailNotification))
        Dim threads As List(Of Task) = Nothing

        Try
            threads = New List(Of Task)

            For Each emailNotif As IEmailNotification In emailNotifs
                threads.Add(Task.Run(
                    Sub()
                        emailNotif.ExecuteNotification()
                    End Sub))
            Next

            Task.WaitAll(threads.ToArray())
        Catch ex As Exception

        End Try
    End Sub

End Class
