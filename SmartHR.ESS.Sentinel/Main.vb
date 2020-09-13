Imports SmartHR.ESS.Common
Imports System.Data.SqlClient
Imports System.IO

Public Class Main

    Private maxJobs, _delay, reconnectWaitTime, reconnectAttempts, maxMessageCount As Integer
    Private appName, dbName, dbServerName As String
    Private runSentinel, dbOnline As Boolean
    Private dateDiff As TimeSpan
    Private entitiesToQueue As String()

    Private sentinelProcesses As List(Of ISentinel)

    Private Sub Main_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing
        If runSentinel Then
            MessageBox.Show("Please stop the sentinel before closing the window.")

            e.Cancel = True
        End If
    End Sub

    Private Sub Main_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If GetAppSettings() Then
            Dim args As String() = Environment.GetCommandLineArgs()

            If args IsNot Nothing AndAlso args.Length > 1 AndAlso args(1).ToUpper() = "AUTO" Then
                Start(Nothing, Nothing)
            Else
                runSentinel = False
            End If
        Else
            Application.[Exit]()
        End If
    End Sub

    Private Async Sub Start(ByVal sender As Object, ByVal e As EventArgs) Handles btnStart.Click
        If runSentinel Then
            CloseSqlConnection()

            Me.btnStart.Text = "Start"

            runSentinel = False

            AddMessage(Me.Text & " stopped.")
        Else
            Me.btnStart.Text = "Stop"

            runSentinel = True

            Await PollAsync()

            If runSentinel AndAlso dbOnline Then
                SetSqlConnection()

                Dim currentDate As DateTime = SqlHelper.GetServerDateTime(SqlConnection)

                dateDiff = DateTime.Now.Subtract(currentDate)

                Await RunSentinelAsync()
            End If
        End If
    End Sub

    Private Function GetAppSettings() As Boolean
        Try
            appName = ConfigurationHelper.AppName
            dbName = ConfigurationHelper.DbName
            dbServerName = ConfigurationHelper.DbServerName
            _delay = ConfigurationHelper.Delay
            maxJobs = ConfigurationHelper.MaxJobs
            reconnectWaitTime = ConfigurationHelper.ReconnectWaitTime
            maxMessageCount = ConfigurationHelper.MaxMessageCount

            Me.lblAppName.Text = appName
            Me.lblDbName.Text = dbName

            reconnectAttempts = 0

            Return True
        Catch ex As Exception
            MessageBox.Show("Error encountered when retrieving the configuration. " & "Please make sure that user.config is existing or is properly configured.", Me.Text, MessageBoxButtons.OK, MessageBoxIcon.[Error])
            Return False
        End Try
    End Function

    Private Sub AddMessage(ByVal message As String)
        lbMessages.Items.Add(message)
        lbMessages.SelectedIndex = lbMessages.Items.Count - 1
        lbMessages.SelectedIndex = -1

        Application.DoEvents()
    End Sub

    Private Async Function Delay(ByVal seconds As Integer) As Task
        Try
            Await Task.Delay(1000 * seconds)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Async Function RunSentinelAsync() As Task
        Try
            Do
                Try
                    If sentinelProcesses IsNot Nothing AndAlso sentinelProcesses.Count > 0 Then
                        Await Task.WhenAll(sentinelProcesses.Select(Of Task)(
                            Async Function(sentinelProcess)
                                Await sentinelProcess.ExecuteAsync()
                            End Function))
                    End If

                    Await Delay(_delay)
                Catch ex As Exception
                    dbOnline = False
                    Throw ex
                End Try
            Loop While runSentinel

        Catch ex As Exception
            AddMessage("Error: " & ex.Message)

            Application.DoEvents()

            runSentinel = False

            Start(Nothing, Nothing)
        End Try
    End Function

    Private Async Function PollAsync() As Task
        Do
            Await PingDbServerAsync()

            If Not dbOnline Then
                AddMessage("Failed to detect database server " & dbServerName & ".")

                Application.DoEvents()

                Await Delay(reconnectWaitTime)

                If runSentinel Then
                    AddMessage("Pinging database server...")

                    Application.DoEvents()
                End If
            End If
        Loop While runSentinel AndAlso Not dbOnline

        Do
            Await ConnectDbServerAsync()

            If Not dbOnline Then
                AddMessage("Failed to connect to database " & dbName & ".")

                Application.DoEvents()

                Await Delay(reconnectWaitTime)

                If runSentinel Then
                    AddMessage("Connecting to database " & dbName & "...")

                    Application.DoEvents()
                End If
            End If
        Loop While runSentinel AndAlso Not dbOnline

        If runSentinel AndAlso dbOnline Then
            AddMessage("Database " & dbName & " is online.")

            Application.DoEvents()
        End If
    End Function

    Private Async Function PingDbServerAsync() As Task
        Dim exec As Process = Nothing
        Dim output As StreamReader = Nothing

        Try
            If dbServerName = "" Then
                dbOnline = True
                Return
            End If

            exec = Process.Start(New ProcessStartInfo("ping.exe", " -n 1 -w 1000 " & dbServerName) With {
                .UseShellExecute = False,
                .RedirectStandardOutput = True,
                .CreateNoWindow = True
            })

            output = exec.StandardOutput

            exec.WaitForExit()

            If exec.HasExited Then
                Dim str As String = Await output.ReadToEndAsync()

                Dim line As String = str.ToLower()

                If line.IndexOf("reply") >= 0 Then
                    dbOnline = True
                ElseIf line.IndexOf("host") >= 0 Then
                    dbOnline = False
                ElseIf line.IndexOf("timed") >= 0 Then
                    dbOnline = False
                Else
                    dbOnline = True
                End If
            End If
        Catch ex As Exception
            AddMessage("Error: " & ex.Message)

            dbOnline = False
        Finally
            If output IsNot Nothing Then output.Close()

            If exec IsNot Nothing Then exec.Close()

            output = Nothing
            exec = Nothing
        End Try
    End Function

    Private Async Function ConnectDbServerAsync() As Task
        Dim sqlConn As SqlConnection = Nothing

        Try
            sqlConn = New SqlConnection(ConfigurationHelper.SqlConnectionString)

            Await sqlConn.OpenAsync()

            dbOnline = True
        Catch ex As Exception
            AddMessage("Error: " & ex.Message)
            dbOnline = False
        Finally
            If sqlConn IsNot Nothing Then

                If sqlConn.State = ConnectionState.Open Then
                    sqlConn.Close()
                End If

                sqlConn.Dispose()
                sqlConn = Nothing
            End If
        End Try
    End Function

    Private Sub ResetReconnectionParameters()
        reconnectWaitTime = CommonFunctions.[CInt](ConfigurationHelper.ReconnectWaitTime)
        reconnectAttempts = 0
    End Sub

End Class
