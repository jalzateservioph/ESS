Imports System.IO
Imports System.Web.SessionState

Public Class Global_asax
    Inherits System.Web.HttpApplication

#Region " *** App Global Events *** "

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires when the application is started

    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires when the session is started

        If (IsNull(ServerPath)) Then ServerPath = Server.MapPath(String.Empty)

        Dim iniFile As ini = Nothing

        Try

            iniFile = New ini(Path.Combine(ServerPath, "settings\settings.ini"), "Connection")

            iniFile.KeyExists("Connection", "Server")

            'If (IsNull(SQLServer.Server)) Then

            Dim SQLConnect As SQLStruct

            With SQLConnect

                .Server = iniFile.ReadString("Server")

                .Database = iniFile.ReadString("Database")

                .Username = iniFile.ReadString("Username")

                .Password = iniFile.ReadString("Password")

                If (.Password.Length > 0) Then .Password = CryptoDecrypt(.Password, EncPwd, SaltPwd, 5, EncVectorPwd, 256)

            End With

            SQLServer = SQLConnect

            'End If

            Initialize()

            If (IsNull(Version.Application)) Then

                Dim objVersion As Object() = GetSQLFields("select top 1 [AppVersion], [DBVersion], (select top 1 [LicenseNumber] from [Database_Version]) as [LicenseKey], (select top 1 ascii(left([Password], 1)) from [Users] where (len([Password]) > 0)) as [EncryptedPwd] from [ess.Properties]", "Data.Properties")

                Dim AppVersion As VerStruct = Nothing

                With AppVersion

                    .Application = objVersion(0).ToString()
                    .Database = objVersion(1).ToString()
                    .LisenceKey = objVersion(2).ToString()
                    .EncryptedPwd = Convert.ToBoolean(objVersion(3) = 1)

                End With

                Version = AppVersion

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(iniFile)) Then iniFile = Nothing

        End Try

    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires at the beginning of each request

    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires upon attempting to authenticate the use

    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires when an error occurs

    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires when the session ends

        If (Not IsNull(Session)) Then

            ClearSessionCache(Session.SessionID)

            Session.RemoveAll()

        End If

    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)

        ' Fires when the application ends

    End Sub

#End Region

End Class