Imports System.Text

Public Class ini

#Region " *** Declarations (Private) *** "

    Private Const MAX_ENTRY As Integer = 32768

    Private Declare Ansi Function GetPrivateProfileInt Lib "kernel32.dll" Alias "GetPrivateProfileIntA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Integer, ByVal lpFileName As String) As Integer
    Private Declare Ansi Function GetPrivateProfileString Lib "kernel32.dll" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As StringBuilder, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
    Private Declare Ansi Function GetPrivateProfileString Lib "kernel32.dll" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Integer, ByVal lpDefault As String, ByVal lpResult() As Byte, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
    Private Declare Ansi Function GetPrivateProfileSectionNames Lib "kernel32" Alias "GetPrivateProfileSectionNamesA" (ByVal lpszReturnBuffer() As Byte, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
    Private Declare Ansi Function WritePrivateProfileSection Lib "kernel32.dll" Alias "WritePrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer
    Private Declare Ansi Function WritePrivateProfileString Lib "kernel32.dll" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer

    Private m_Filename As String
    Private m_Section As String

#End Region

#Region " *** Constructors *** "

    Public Sub New(ByVal file As String)

        m_Filename = file

    End Sub

    Public Sub New(ByVal file As String, ByVal section As String)

        m_Filename = file

        m_Section = section

    End Sub

#End Region

#Region " *** Properties (Public) *** "

    Public Property Filename() As String

        Get

            Return m_Filename

        End Get

        Set(ByVal Value As String)

            m_Filename = Value

        End Set

    End Property

    Public Property Section() As String

        Get

            Return m_Section

        End Get

        Set(ByVal Value As String)

            m_Section = Value

        End Set

    End Property

#End Region

#Region " *** Logic Functions (Public) *** "

    Public Function DeleteKey(ByVal section As String, ByVal key As String) As Boolean

        Return (WritePrivateProfileString(section, key, Nothing, m_Filename) <> 0)

    End Function

    Public Function DeleteKey(ByVal key As String) As Boolean

        Return (WritePrivateProfileString(m_Section, key, Nothing, m_Filename) <> 0)

    End Function

    Public Function DeleteSection(ByVal section As String) As Boolean

        Return WritePrivateProfileSection(section, Nothing, m_Filename) <> 0

    End Function

    Public Function GetSectionEntries(ByVal section As String) As ArrayList

        Try

            Dim buffer(MAX_ENTRY) As Byte

            GetPrivateProfileString(section, 0, String.Empty, buffer, MAX_ENTRY, m_Filename)

            Dim parts() As String = Encoding.ASCII.GetString(buffer).Trim(ControlChars.NullChar).Split(ControlChars.NullChar)

            Return New ArrayList(parts)

        Catch ex As Exception

        End Try

        Return Nothing

    End Function

    Public Function GetSectionNames() As ArrayList

        Try

            Dim buffer(MAX_ENTRY) As Byte

            GetPrivateProfileSectionNames(buffer, MAX_ENTRY, m_Filename)

            Dim parts() As String = Encoding.ASCII.GetString(buffer).Trim(ControlChars.NullChar).Split(ControlChars.NullChar)

            Return New ArrayList(parts)

        Catch

        End Try

        Return Nothing

    End Function

    Public Function KeyExists(ByVal section As String, ByVal key As String) As Boolean

        Dim Result As Boolean

        If (SectionExists(section)) Then

            Dim arKeys As ArrayList = Nothing

            Try

                arKeys = GetSectionEntries(section)

                If (Not IsNull(arKeys)) Then Result = Convert.ToBoolean(arKeys.IndexOf(key) > -1)

            Catch ex As Exception

            Finally

                If (Not IsNull(arKeys)) Then

                    arKeys.Clear()

                    arKeys = Nothing

                End If

            End Try

        End If

        Return Result

    End Function

    Public Function ReadBoolean(ByVal section As String, ByVal key As String, ByVal defVal As Boolean) As Boolean

        Return Boolean.Parse(ReadString(section, key, defVal.ToString()))

    End Function

    Public Function ReadBoolean(ByVal section As String, ByVal key As String) As Boolean

        Return ReadBoolean(section, key, False)

    End Function

    Public Function ReadBoolean(ByVal key As String, ByVal defVal As Boolean) As Boolean

        Return ReadBoolean(m_Section, key, defVal)

    End Function

    Public Function ReadBoolean(ByVal key As String) As Boolean

        Return ReadBoolean(m_Section, key)

    End Function

    Public Function ReadByteArray(ByVal section As String, ByVal key As String) As Byte()

        Try

            Return Convert.FromBase64String(ReadString(section, key))

        Catch

        End Try

        Return Nothing

    End Function

    Public Function ReadByteArray(ByVal key As String) As Byte()

        Return ReadByteArray(m_Section, key)

    End Function

    Public Function ReadInteger(ByVal section As String, ByVal key As String, ByVal defVal As Integer) As Integer

        Return GetPrivateProfileInt(section, key, defVal, m_Filename)

    End Function

    Public Function ReadInteger(ByVal section As String, ByVal key As String) As Integer

        Return ReadInteger(section, key, 0)

    End Function

    Public Function ReadInteger(ByVal key As String, ByVal defVal As Integer) As Integer

        Return ReadInteger(m_Section, key, defVal)

    End Function

    Public Function ReadInteger(ByVal key As String) As Integer

        Return ReadInteger(key, 0)

    End Function

    Public Function ReadLong(ByVal section As String, ByVal key As String, ByVal defVal As Long) As Long

        Return Long.Parse(ReadString(section, key, defVal.ToString()))

    End Function

    Public Function ReadLong(ByVal section As String, ByVal key As String) As Long

        Return ReadLong(section, key, 0)

    End Function

    Public Function ReadLong(ByVal key As String, ByVal defVal As Long) As Long

        Return ReadLong(m_Section, key, defVal)

    End Function

    Public Function ReadLong(ByVal key As String) As Long

        Return ReadLong(key, 0)

    End Function

    Public Function ReadString(ByVal section As String, ByVal key As String, ByVal defVal As String) As String

        Dim sb As New StringBuilder(MAX_ENTRY)

        Dim Ret As Integer = GetPrivateProfileString(section, key, defVal, sb, MAX_ENTRY, m_Filename)

        Return sb.ToString()

    End Function

    Public Function ReadString(ByVal section As String, ByVal key As String) As String

        Return ReadString(section, key, String.Empty)

    End Function

    Public Function ReadString(ByVal key As String) As String

        Return ReadString(m_Section, key)

    End Function

    Public Function SectionExists(ByVal section As String) As Boolean

        Dim Result As Boolean

        Dim arSections As ArrayList = Nothing

        Try

            arSections = GetSectionNames()

            If (Not IsNull(arSections)) Then Result = Convert.ToBoolean(arSections.IndexOf(section) > -1)

        Catch ex As Exception

        Finally

            If (Not IsNull(arSections)) Then

                arSections.Clear()

                arSections = Nothing

            End If

        End Try

        Return Result

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value As Boolean) As Boolean

        Return Write(section, key, value.ToString())

    End Function

    Public Function Write(ByVal key As String, ByVal value As Boolean) As Boolean

        Return Write(m_Section, key, value)

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value() As Byte) As Boolean

        If (IsNull(value)) Then

            Return Write(section, key, CType(Nothing, String))

        Else

            Return Write(section, key, value, 0, value.Length)

        End If

    End Function

    Public Function Write(ByVal key As String, ByVal value() As Byte) As Boolean

        Return Write(m_Section, key, value)

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value() As Byte, ByVal offset As Integer, ByVal length As Integer) As Boolean

        If (IsNull(value)) Then

            Return Write(section, key, CType(Nothing, String))

        Else

            Return Write(section, key, Convert.ToBase64String(value, offset, length))

        End If

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value As Integer) As Boolean

        Return Write(section, key, value.ToString())

    End Function

    Public Function Write(ByVal key As String, ByVal value As Integer) As Boolean

        Return Write(m_Section, key, value)

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value As Long) As Boolean

        Return Write(section, key, value.ToString())

    End Function

    Public Function Write(ByVal key As String, ByVal value As Long) As Boolean

        Return Write(m_Section, key, value)

    End Function

    Public Function Write(ByVal section As String, ByVal key As String, ByVal value As String) As Boolean

        Return (WritePrivateProfileString(section, key, value, m_Filename) <> 0)

    End Function

    Public Function Write(ByVal key As String, ByVal value As String) As Boolean

        Return Write(m_Section, key, value)

    End Function

#End Region

End Class