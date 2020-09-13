Imports System.Xml
Imports System.IO
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Runtime.CompilerServices

Public Module MainModule

    Public Function GetEmailSetup(ByVal sqlConnection As SqlConnection, ByVal sqlHelper As SqlHelper, ByVal type As String) As EmailSetup
        Dim emailSetup As EmailSetup = Nothing

        Try
            sqlHelper.SetSqlStatement("SELECT * FROM EmailLU WHERE [Type] = @Type", sqlConnection)
            sqlHelper.SetParameter("@Type", type)

            Using rslt As DataTable = sqlHelper.ExecuteDataTable()
                If rslt.Rows.Count > 0 Then
                    emailSetup = New EmailSetup()

                    With rslt.Rows(0)
                        emailSetup.ID = CInt(.Item("ID"))
                        emailSetup.Type = [CStr](.Item("Type"))
                        emailSetup.Server = [CStr](.Item("Server"))
                        emailSetup.Port = CInt(.Item("Port"))
                        emailSetup.Username = [CStr](.Item("Username"))
                        emailSetup.Password = [CStr](.Item("Password"))
                        emailSetup._From = New MailAddress([CStr](.Item("Address")), [CStr](.Item("Name")))
                        emailSetup.Subject = [CStr](.Item("Subject"))
                        emailSetup.OrigBodyHtml = [CStr](.Item("Body"))
                        emailSetup.BodyHtml = emailSetup.OrigBodyHtml
                        emailSetup.OrigBodyText = [CStr](.Item("BodyText"))
                        emailSetup.BodyText = emailSetup.OrigBodyText
                    End With
                End If

                rslt.Clear()
            End Using
        Catch ex As Exception
            WriteEventLog(ex)
        End Try

        Return emailSetup
    End Function

    <Extension()>
    Public Function ReplaceEmailParams(ByVal body As String, ByVal parameterIndex As Integer, ByVal parameterValue As String) As String
        Return body.Replace("&lt;%<%PARAM[" + parameterIndex.ToString() + "]%>%&gt;", parameterValue) _
                   .Replace("&lt;%PARAM[" + parameterIndex.ToString() + "]%&gt;", parameterValue)
    End Function

    Public Function GetConfig(ByVal configName As String) As String
        Try
            Dim userConfigPath As String = Environment.CurrentDirectory + "\user.config"
            Dim appConfigPath As String = Environment.CurrentDirectory + "\SmartHR.ESS.Scheduler.exe.config"

            Dim xmlDoc As XmlDocument = Nothing
            Dim node As XmlNode = Nothing

            If File.Exists(userConfigPath) Then
                xmlDoc = New XmlDocument()
                xmlDoc.Load(userConfigPath)

                node = xmlDoc.SelectSingleNode("//appSettings/add[@key='" + configName + "']")
            ElseIf File.Exists(appConfigPath) Then
                xmlDoc = New XmlDocument()
                xmlDoc.Load(appConfigPath)

                node = xmlDoc.SelectSingleNode("//configuration/appSettings/add[@key='" + configName + "']")
            End If

            If node IsNot Nothing Then
                Return node.Attributes("value").Value
            End If
        Catch ex As Exception
            ' Do Nothing...
        End Try

        Return ""
    End Function

End Module
