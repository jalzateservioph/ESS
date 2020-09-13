Imports SmartHR.ESS.Common
Imports System.Globalization
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Xml

Public MustInherit Class ProcessBase
    Implements IDisposable

    Private Const CultureInfoName As String = "en-US"

    Private scheduledDateTimeConfigName As String

    Protected Property LogService As LogService
    Public Property SqlConnection As SqlConnection
    Public Property SqlHelper As SqlHelper
    Public Property OrganizationName As String
    Public Property ScheduledDateTime As DateTime
    Public Property LastRunDateTime As DateTime?

    Public Sub New(ByVal scheduledDateTimeConfigName As String)
        Me.SqlHelper = New SqlHelper(ConfigurationHelper.SqlRequestTimeout)
        Me.SqlConnection = SqlHelper.CreateSqlConnection()
        Me.LogService = New LogService()
        Me.scheduledDateTimeConfigName = scheduledDateTimeConfigName
    End Sub

    Public MustOverride Sub Execute()

    Public Function CanExecute(ByVal currentDateTime As DateTime) As Boolean
        Try
            GetScheduledDateTime()

            Return _
                (LastRunDateTime Is Nothing OrElse LastRunDateTime.Value.ToString("yyyyMMddHHmm") <> currentDateTime.ToString("yyyyMMddHHmm")) AndAlso
                (ScheduledDateTime.ToString("yyyy") = "0001" OrElse ScheduledDateTime.ToString("MMdd") = currentDateTime.ToString("MMdd")) AndAlso
                ScheduledDateTime.ToString("HHmm") = currentDateTime.ToString("HHmm")
        Catch ex As Exception
            Return False
        End Try
    End Function

    Protected Sub AddLog(ByVal className As String, ByVal message As String)
        LogService.AddLog(message, className)
    End Sub

    Protected Sub WriteEventLog(ByVal className As String, ByVal message As String, Optional ByVal entryType As EventLogEntryType = EventLogEntryType.[Error])
        CommonFunctions.WriteEventLog("SmartHR.ESS.Scheduler - " & className & " (" & OrganizationName & ")", "Application", message, entryType)
    End Sub

    Private Sub GetScheduledDateTime()
        Dim scheduledDateTime As String = GetConfig(scheduledDateTimeConfigName)
        Dim timeTemp As DateTime

        Dim scheduledDateTimeSplit As String() = scheduledDateTime.Split(" "c)

        If DateTime.TryParse("1/1/0001 " & scheduledDateTime, New CultureInfo(CultureInfoName), DateTimeStyles.None, timeTemp) OrElse
           DateTime.TryParse(scheduledDateTime & "/1900 00:00", New CultureInfo(CultureInfoName), DateTimeStyles.None, timeTemp) OrElse
           DateTime.TryParse(scheduledDateTimeSplit(0) & "/1900 " & scheduledDateTimeSplit(scheduledDateTimeSplit.Length - 2) & " " & scheduledDateTimeSplit(scheduledDateTimeSplit.Length - 1), New CultureInfo(CultureInfoName), DateTimeStyles.None, timeTemp) Then
            Me.ScheduledDateTime = timeTemp
        Else
            Me.ScheduledDateTime = DateTime.Parse("1/1/0001 00:00", New CultureInfo(CultureInfoName))
        End If
    End Sub

#Region "IDisposable Support"

    Private disposedValue As Boolean

    Protected Overridable Sub Dispose(disposing As Boolean)
        If Not Me.disposedValue Then
            If disposing Then
                If SqlConnection IsNot Nothing Then
                    If SqlConnection.State <> ConnectionState.Closed Then
                        SqlConnection.Close()
                    End If
                    SqlConnection.Dispose()
                    SqlConnection = Nothing
                End If
            End If
        End If
        Me.disposedValue = True
    End Sub

    Public Sub Dispose() Implements IDisposable.Dispose
        Dispose(True)
        GC.SuppressFinalize(Me)
    End Sub

#End Region

End Class
