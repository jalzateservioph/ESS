Imports System.Net.Mail
Imports System.Configuration
Imports System.Net
Imports System.Data.SqlClient

Public Module EmailService

    Public Sub SendEmail(ByVal sqlConnection As SqlConnection, ByVal sqlHelper As SqlHelper, ByVal emailSetup As EmailSetup, Optional ByVal toEmailAddresses As MailAddress() = Nothing, Optional ByVal ccEmailAddresses As MailAddress() = Nothing)
        Dim smtp As SmtpClient = Nothing
        Dim mailMessage As MailMessage = Nothing

        Try
            smtp = New SmtpClient(emailSetup.Server, emailSetup.Port)

            smtp.EnableSsl = ConfigurationManager.AppSettings("EmailEnableSsl") = "1"

            If (emailSetup.Username.Length > 0 AndAlso emailSetup.Password.Length > 0) Then
                Dim password As String = CryptoDecrypt(emailSetup.Password, EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                smtp.Credentials = New NetworkCredential(emailSetup.Username, password)
            End If

            mailMessage = New MailMessage() With
            {
                .From = emailSetup._From,
                .Subject = emailSetup.Subject
            }

            If toEmailAddresses IsNot Nothing Then
                For Each toEmailAddress As MailAddress In toEmailAddresses
                    mailMessage.To.Add(toEmailAddress)
                Next
            End If

            If ccEmailAddresses IsNot Nothing Then
                For Each ccEmailAddress As MailAddress In ccEmailAddresses
                    mailMessage.CC.Add(ccEmailAddress)
                Next
            End If

            If Not IsEmpty(emailSetup.BodyHtml) Then
                mailMessage.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(emailSetup.BodyHtml, Nothing, "text/html"))
            End If

            If Not IsEmpty(emailSetup.BodyText) Then
                mailMessage.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(emailSetup.BodyText, Nothing, "text/plain"))
            End If

            smtp.Send(mailMessage)

            If toEmailAddresses IsNot Nothing Then
                For Each toEmailAddress As MailAddress In toEmailAddresses
                    InsertEmailResult(sqlConnection, sqlHelper, emailSetup, toEmailAddress.Address, "Submitted")
                Next
            End If

            If ccEmailAddresses IsNot Nothing Then
                For Each ccEmailAddress As MailAddress In ccEmailAddresses
                    InsertEmailResult(sqlConnection, sqlHelper, emailSetup, ccEmailAddress.Address, "Submitted")
                Next
            End If

        Catch ex As Exception
            WriteEventLog(ex)

            If toEmailAddresses IsNot Nothing AndAlso toEmailAddresses.Length > 0 Then
                InsertEmailResult(sqlConnection, sqlHelper, emailSetup, toEmailAddresses(0).Address, "Undeliverable", GetErrorMessage(ex))
            End If
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
    End Sub

    Private Function InsertEmailResult(ByVal sqlConnection As SqlConnection, ByVal sqlHelper As SqlHelper, ByVal emailSetup As EmailSetup, ByVal toEmailAddress As String, ByVal status As String, Optional ByVal errorText As String = "") As Integer
        If sqlConnection.State <> ConnectionState.Open Then
            Throw New Exception("Connection closed!")
        End If

        Dim id As Guid = sqlHelper.GetNewGuid(sqlConnection)

        sqlHelper.SetSqlStatement(
            "INSERT INTO EmailResults( " &
            "   [ID], " &
            "   [Date], " &
            "   [Server], " &
            "   [Port], " &
            "   [Username], " &
            "   [Password], " &
            "   [From], " &
            "   [To], " &
            "   [Subject], " &
            "   [Message], " &
            "   [Status], " &
            "   [ErrorText] " &
            ") VALUES (" &
            "   @ID, " &
            "   @Date, " &
            "   @Server, " &
            "   @Port, " &
            "   @Username, " &
            "   @Password, " &
            "   @From, " &
            "   @To, " &
            "   @Subject, " &
            "   @Message, " &
            "   @Status, " &
            "   @ErrorText " &
            ") ",
            sqlConnection)

        sqlHelper.SetParameter("@ID", id)
        sqlHelper.SetParameter("@Date", Now.ToString("yyyy-MM-dd HH:mm:ss"))
        sqlHelper.SetParameter("@Server", emailSetup.Server)
        sqlHelper.SetParameter("@Port", emailSetup.Port)
        sqlHelper.SetParameter("@Username", emailSetup.Username)
        sqlHelper.SetParameter("@Password", emailSetup.Password)
        sqlHelper.SetParameter("@From", emailSetup._From.Address)
        sqlHelper.SetParameter("@To", toEmailAddress)
        sqlHelper.SetParameter("@Subject", emailSetup.Subject)
        sqlHelper.SetParameter("@Message", emailSetup.BodyHtml)
        sqlHelper.SetParameter("@Status", status)

        If Not IsEmpty(errorText) Then
            sqlHelper.SetParameter("@ErrorText", errorText)
        Else
            sqlHelper.SetParameter("@ErrorText", DBNull.Value)
        End If

        Return sqlHelper.ExecuteNonQuery()
    End Function

End Module
