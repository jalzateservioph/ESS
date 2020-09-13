Imports System.IO
Imports System.Runtime.CompilerServices

Public Class LogService
    Shared currentLogFile As String = ""

    Public Sub AddLog(ByVal message As String, ByVal className As String, <CallerMemberName> Optional ByVal caller As String = Nothing)
        Directory.CreateDirectory("SmartHRESS_SchedulerLogs")

        currentLogFile = "SmartHRESS_SchedulerLogs\" & DateTime.Now.ToString("MMddyyyy") & ".txt"

        Using writer As StreamWriter = New StreamWriter(currentLogFile, True)
            writer.WriteLine(message & " (at " & className & "." & caller & ")")
        End Using
    End Sub
End Class