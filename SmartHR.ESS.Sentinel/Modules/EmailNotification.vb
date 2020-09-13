Imports System.Data.SqlClient
Imports SmartHR.ESS.Common
Imports System.Net.Mail
Imports System.Net
Imports System.Configuration

Public Class EmailNotification
    Implements ISentinel

    Private _sqlConnection As SqlConnection
    Private _sqlHelper As SqlHelper

    Sub New(ByVal sqlConnection As SqlConnection, ByVal sqlHelper As SqlHelper)
        _sqlConnection = sqlConnection
        _sqlHelper = sqlHelper
    End Sub

    Public Async Function ExecuteAsync() As Task Implements ISentinel.ExecuteAsync
        Dim reader As SqlDataReader = Nothing
        Dim emailRslts As List(Of EmailResult) = Nothing

        Try
            reader = Await GetEmailResultsAsync()

            If reader.HasRows Then
                emailRslts = New List(Of EmailResult)

                While Await reader.ReadAsync()

                    Dim hasNoValue As Boolean =
                        Await reader.IsDBNullAsync(1) OrElse
                        Await reader.IsDBNullAsync(2) OrElse
                        Await reader.IsDBNullAsync(3) OrElse
                        Await reader.IsDBNullAsync(4) OrElse
                        Await reader.IsDBNullAsync(5) OrElse
                        Await reader.IsDBNullAsync(6) OrElse
                        Await reader.IsDBNullAsync(8)

                    If hasNoValue Then Continue While

                    emailRslts.Add(New EmailResult With
                    {
                        .ID = Await reader.GetFieldValueAsync(Of Guid)(0),
                        .Server = Await reader.GetFieldValueAsync(Of String)(1),
                        .Port = Await reader.GetFieldValueAsync(Of Int16)(2),
                        .Username = Await reader.GetFieldValueAsync(Of String)(3),
                        .Password = CryptoDecrypt(Await reader.GetFieldValueAsync(Of String)(4), EncPwd, SaltPwd, 5, EncVectorPwd, 256),
                        ._From = Await reader.GetFieldValueAsync(Of String)(5),
                        ._To = Await reader.GetFieldValueAsync(Of String)(6),
                        .Subject = Await reader.GetFieldValueAsync(Of String)(7),
                        .Message = Await reader.GetFieldValueAsync(Of String)(8)
                    })

                End While

                reader.Close()
                reader.Dispose()
                reader = Nothing

                Await SendEmails(emailRslts)
            End If
        Catch ex As Exception
            WriteEventLog(ex)

            Throw
        Finally
            If reader IsNot Nothing Then
                reader.Close()
                reader.Dispose()
                reader = Nothing
            End If

            If emailRslts IsNot Nothing Then
                emailRslts.Clear()
                emailRslts = Nothing
            End If
        End Try
    End Function

    Private Function SendEmails(ByVal emailRslts As List(Of EmailResult)) As Task
        Return Task.WhenAll(emailRslts.Select(Of Task)(
                Async Function(emailRslt)
                    Dim smtp As SmtpClient = Nothing
                    Dim mailMessage As MailMessage = Nothing

                    Try
                        Dim htmlText As AlternateView =
                            AlternateView.CreateAlternateViewFromString(emailRslt.Message, Nothing, "text/html")

                        smtp = New SmtpClient(emailRslt.Server, emailRslt.Port)

                        smtp.EnableSsl = ConfigurationManager.AppSettings("EmailEnableSsl") = "1"

                        If (emailRslt.Username.Length > 0 AndAlso emailRslt.Password.Length > 0) Then
                            smtp.Credentials = New NetworkCredential(emailRslt.Username, emailRslt.Password)
                        End If

                        mailMessage = New MailMessage() With
                        {
                            .From = New MailAddress(emailRslt._From),
                            .Subject = emailRslt.Subject
                        }

                        mailMessage.To.Add(emailRslt._To)
                        mailMessage.AlternateViews.Add(htmlText)

                        Dim success As Boolean = False
                        Dim errorText As String = Nothing

                        Try
                            Await smtp.SendMailAsync(mailMessage)

                            success = True
                        Catch ex As Exception
                            WriteEventLog(ex)

                            errorText = GetErrorMessage(ex)
                        End Try

                        If success Then
                            Await UpdateEmailResultStatusAsync(emailRslt.ID, "Submitted")
                        Else
                            Await UpdateEmailResultStatusAsync(emailRslt.ID, "Undeliverable", errorText)
                        End If
                    Catch ex As Exception
                        WriteEventLog(ex)

                        Throw
                    Finally
                        If smtp IsNot Nothing Then
                            smtp.Dispose()
                            smtp = Nothing
                        End If

                        If mailMessage IsNot Nothing Then
                            mailMessage.Dispose()
                            mailMessage = Nothing
                        End If
                    End Try
                End Function))
    End Function

    Private Async Function GetEmailResultsAsync() As Task(Of SqlDataReader)
        If _sqlConnection.State <> ConnectionState.Open Then
            Throw New Exception("Connection closed!")
        End If

        _sqlHelper.SetSqlStatement(
            "SELECT " &
            "   [ID], " &
            "   [Server], " &
            "   [Port], " &
            "   [Username], " &
            "   [Password], " &
            "   [From], " &
            "   [To], " &
            "   [Subject], " &
            "   [Message] " &
            "FROM EmailResults " &
            "WHERE [Status] = 'Pending'",
            _sqlConnection)

        Return Await _sqlHelper.ExecuteReaderAsync()
    End Function

    Private Async Function UpdateEmailResultStatusAsync(ByVal id As Guid, ByVal status As String, Optional ByVal errorText As String = Nothing) As Task(Of Integer)
        If _sqlConnection.State <> ConnectionState.Open Then
            Throw New Exception("Connection closed!")
        End If

        _sqlHelper.SetSqlStatement(
            "UPDATE EmailResults SET " &
            "   [Status] = @Status, " &
            "   [ErrorText] = @ErrorText " &
            "WHERE [ID] = @ID",
            _sqlConnection)

        _sqlHelper.SetParameter("@ID", id)
        _sqlHelper.SetParameter("@Status", status)

        If Not String.IsNullOrEmpty(errorText) Then
            _sqlHelper.SetParameter("@ErrorText", errorText)
        Else
            _sqlHelper.SetParameter("@ErrorText", DBNull.Value)
        End If

        Return Await _sqlHelper.ExecuteNonQueryAsync()
    End Function

End Class
