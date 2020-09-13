Imports System.Security.Cryptography
Imports System.IO
Imports System.Text

Public Module CrytoHelper

    Public Const EncPwd As String = "680224"
    Public Const EncVectorPwd As String = "<!#%([$@@$])%#!>"
    Public Const SaltPwd As String = "$@LT#Saved*Pwd!"

    Public Function CryptoDecrypt(ByVal cipher As String, ByVal password As String, ByVal salt As String, ByVal iterations As Integer, ByVal vector As String, ByVal keysize As Integer) As String

        Dim result As String = String.Empty

        Dim vBytes() As Byte = Nothing

        Dim sBytes() As Byte = Nothing

        Dim cBytes() As Byte = Nothing

        Dim pBytes() As Byte = Nothing

        Dim symmetricKey As RijndaelManaged = Nothing

        Dim decryptor As ICryptoTransform = Nothing

        Dim memStream As MemoryStream = Nothing

        Dim crStream As CryptoStream = Nothing

        Dim plainBytes() As Byte = Nothing

        Try

            If (Not IsNull(cipher) AndAlso cipher.Length > 0) Then

                vBytes = Encoding.ASCII.GetBytes(vector)

                sBytes = Encoding.ASCII.GetBytes(salt)

                cBytes = Convert.FromBase64String(cipher)

                pBytes = (New Rfc2898DeriveBytes(password, sBytes, iterations)).GetBytes(Convert.ToInt32(keysize / 8))

                symmetricKey = New RijndaelManaged()

                symmetricKey.Mode = CipherMode.CBC

                decryptor = symmetricKey.CreateDecryptor(pBytes, vBytes)

                memStream = New MemoryStream(cBytes)

                crStream = New CryptoStream(memStream, decryptor, CryptoStreamMode.Read)

                ReDim plainBytes(cBytes.Length)

                result = Encoding.UTF8.GetString(plainBytes, 0, crStream.Read(plainBytes, 0, plainBytes.Length))

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(plainBytes)) Then plainBytes = Nothing

            If (Not IsNull(crStream)) Then

                crStream.Close()

                crStream.Dispose()

                crStream = Nothing

            End If

            If (Not IsNull(memStream)) Then

                memStream.Close()

                memStream.Dispose()

                memStream = Nothing

            End If

            If (Not IsNull(decryptor)) Then

                decryptor.Dispose()

                decryptor = Nothing

            End If

            If (Not IsNull(symmetricKey)) Then

                symmetricKey.Clear()

                symmetricKey = Nothing

            End If

            If (Not IsNull(pBytes)) Then pBytes = Nothing

            If (Not IsNull(cBytes)) Then cBytes = Nothing

            If (Not IsNull(sBytes)) Then sBytes = Nothing

            If (Not IsNull(vBytes)) Then vBytes = Nothing

        End Try

        Return result

    End Function

    Public Function CryptoEncrypt(ByVal plaintext As String, ByVal password As String, ByVal salt As String, ByVal iterations As Integer, ByVal vector As String, ByVal keysize As Integer) As String

        Dim result As String = String.Empty

        Dim vBytes() As Byte = Nothing

        Dim sBytes() As Byte = Nothing

        Dim tBytes() As Byte = Nothing

        Dim pBytes() As Byte = Nothing

        Dim symmetricKey As RijndaelManaged = Nothing

        Dim encryptor As ICryptoTransform = Nothing

        Dim memStream As MemoryStream = Nothing

        Dim crStream As CryptoStream = Nothing

        Try

            If (Not IsNull(plaintext) AndAlso plaintext.Length > 0) Then

                vBytes = Encoding.ASCII.GetBytes(vector)

                sBytes = Encoding.ASCII.GetBytes(salt)

                tBytes = Encoding.UTF8.GetBytes(plaintext)

                pBytes = (New Rfc2898DeriveBytes(password, sBytes, iterations)).GetBytes(Convert.ToInt32(keysize / 8))

                symmetricKey = New RijndaelManaged()

                symmetricKey.Mode = CipherMode.CBC

                encryptor = symmetricKey.CreateEncryptor(pBytes, vBytes)

                memStream = New MemoryStream()

                crStream = New CryptoStream(memStream, encryptor, CryptoStreamMode.Write)

                crStream.Write(tBytes, 0, tBytes.Length)

                crStream.FlushFinalBlock()

                result = Convert.ToBase64String(memStream.ToArray())

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(crStream)) Then

                crStream.Close()

                crStream.Dispose()

                crStream = Nothing

            End If

            If (Not IsNull(memStream)) Then

                memStream.Close()

                memStream.Dispose()

                memStream = Nothing

            End If

            If (Not IsNull(encryptor)) Then

                encryptor.Dispose()

                encryptor = Nothing

            End If

            If (Not IsNull(symmetricKey)) Then

                symmetricKey.Clear()

                symmetricKey = Nothing

            End If

            If (Not IsNull(pBytes)) Then pBytes = Nothing

            If (Not IsNull(tBytes)) Then tBytes = Nothing

            If (Not IsNull(sBytes)) Then sBytes = Nothing

            If (Not IsNull(vBytes)) Then vBytes = Nothing

        End Try

        Return result

    End Function

    Private Function IsNull(ByVal value As Object) As Boolean

        Return (value Is Nothing OrElse IsDBNull(value))

    End Function

End Module
