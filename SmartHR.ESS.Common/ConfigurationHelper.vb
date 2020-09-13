Imports System.Configuration

Public Module ConfigurationHelper
    Public ReadOnly Property SqlConnectionString As String
        Get
            Return ConfigurationManager.ConnectionStrings("SqlConnStr").ConnectionString
        End Get
    End Property

    Public ReadOnly Property SqlRequestTimeout As Integer
        Get
            Dim timeout As Integer = CommonFunctions.[CInt](ConfigurationManager.AppSettings("DbRequestTimeout"))
            Return If(timeout > 0, timeout, 30)
        End Get
    End Property

    Public ReadOnly Property AppName As String
        Get
            Return CommonFunctions.[CStr](ConfigurationManager.AppSettings("AppName"))
        End Get
    End Property

    Public ReadOnly Property DbName As String
        Get
            Return CommonFunctions.[CStr](ConfigurationManager.AppSettings("DbName"))
        End Get
    End Property

    Public ReadOnly Property DbServerName As String
        Get
            Return CommonFunctions.[CStr](ConfigurationManager.AppSettings("DbServerName"))
        End Get
    End Property

    Public ReadOnly Property MaxJobs As Integer
        Get
            Return CommonFunctions.[CInt](ConfigurationManager.AppSettings("MaxJobs"))
        End Get
    End Property

    Public ReadOnly Property ReconnectWaitTime As Integer
        Get
            Return CommonFunctions.[CInt](ConfigurationManager.AppSettings("ReconnectWaitTime"))
        End Get
    End Property

    Public ReadOnly Property MaxMessageCount As Integer
        Get
            Return CommonFunctions.[CInt](ConfigurationManager.AppSettings("MaxMessageCount"))
        End Get
    End Property

    Public ReadOnly Property Delay As Integer
        Get
            Return CommonFunctions.[CInt](ConfigurationManager.AppSettings("Delay"))
        End Get
    End Property

    Function GetAppSetting(ByVal name As String) As String
        Return CommonFunctions.[CStr](ConfigurationManager.AppSettings(name))
    End Function
End Module