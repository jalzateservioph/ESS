Imports System.Reflection
Imports System.Xml
Imports System.IO

Public Class Main
    Dim processes As List(Of ProcessBase)

    Dim timer As System.Timers.Timer

    Private Sub Main_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        AddMessage("Creating processes...")

        LoadProcesses()

        AddMessage("Scheduler is ready")

        Dim args As String() = Environment.GetCommandLineArgs()

        If args IsNot Nothing Then
            If args.Length > 1 AndAlso args(1).ToUpper() = "AUTO" Then
                btnStartStop_Click(Nothing, Nothing)
            End If

            If args.Length > 2 AndAlso args(2).ToUpper() = "START_SENTINEL" Then
                StartApplication(
                    Environment.CurrentDirectory,
                    "SmartHR.ESS.Sentinel", "auto",
                    Not (args.Length > 3 AndAlso args(3).ToUpper() = "HIDDEN"))
            End If
        End If
    End Sub

    Public Sub timer_Elapsed(ByVal sender As Object, ByVal e As System.Timers.ElapsedEventArgs)
        Dim forProcessing As List(Of ProcessBase) = Nothing

        Try
            Dim currentDateTime As DateTime = DateTime.Now

            forProcessing = processes.FindAll(Function(item) item.CanExecute(currentDateTime))

            If forProcessing.Count > 0 Then
                AddMessage("Found " & forProcessing.Count & " processes")

                For Each process As ProcessBase In forProcessing
                    process.OrganizationName = OrganizationName
                    process.LastRunDateTime = currentDateTime

                    Task.Run(Sub()
                                 process.Execute()
                             End Sub)

                    Dim processName As String = process.ToString().Split("."c).Last()

                    AddMessage(processName & ": " & process.ScheduledDateTime.ToString("hh:mm tt"))
                Next
            End If

            SetControlPropertyThreadSafe(lblTime, "Text", currentDateTime.ToString("HH:mm:ss"))
        Catch ex As Exception
            WriteEventLog(ex)

            Throw New Exception(ex.Message)
        Finally

            If forProcessing IsNot Nothing Then
                forProcessing.Clear()
                forProcessing = Nothing
            End If
        End Try
    End Sub

    Private Sub btnStartStop_Click(sender As Object, e As EventArgs) Handles btnStartStop.Click
        If timer.Enabled Then
            timer.[Stop]()

            btnStartStop.Text = "Start"

            AddMessage("Scheduler stopped")
        Else
            timer.Start()

            btnStartStop.Text = "Stop"

            AddMessage("Scheduler started")
        End If
    End Sub

    Private Sub LoadProcesses()
        processes.Add(New TrainingEmailNotif("DateTime_TrainingEmailNotif"))
    End Sub

    Private Sub AddMessage(ByVal Message As String)
        If fieldOutp.InvokeRequired Then
            Me.Invoke(CType((Sub()
                                 fieldOutp.Items.Add(DateTime.Now.ToString("hh:mm:ss tt") & " >> " & Message)
                                 fieldOutp.SelectedIndex = fieldOutp.Items.Count - 1
                                 fieldOutp.SelectedIndex = -1
                             End Sub), MethodInvoker))
        Else
            fieldOutp.Items.Add(DateTime.Now.ToString("hh:mm:ss tt") & " >> " & Message)
            fieldOutp.SelectedIndex = fieldOutp.Items.Count - 1
            fieldOutp.SelectedIndex = -1
        End If

        SetControlPropertyThreadSafe(fieldOutp, "SelectedIndex", -1)
    End Sub

    Private Delegate Sub SetControlPropertyThreadSafeDelegate(ByVal control As Control, ByVal propertyName As String, ByVal propertyValue As Object)

    Public Shared Sub SetControlPropertyThreadSafe(ByVal control As Control, ByVal propertyName As String, ByVal propertyValue As Object)
        If control.InvokeRequired Then
            control.Invoke(New SetControlPropertyThreadSafeDelegate(AddressOf SetControlPropertyThreadSafe), New Object() {control, propertyName, propertyValue})
        Else
            control.[GetType]().InvokeMember(propertyName, BindingFlags.SetProperty, Nothing, control, New Object() {propertyValue})
        End If
    End Sub

    Private Sub StartApplication(ByVal workingDirectory As String, ByVal applicationName As String, Optional ByVal arguments As String = "", Optional ByVal showWindow As Boolean = True)
        If File.Exists(workingDirectory + "\" + applicationName + ".exe") Then
            Process.Start(New ProcessStartInfo(applicationName + ".exe") With
            {
                .WorkingDirectory = workingDirectory,
                .Arguments = arguments,
                .Verb = "runas",
                .CreateNoWindow = Not showWindow,
                .WindowStyle = IIf(showWindow, ProcessWindowStyle.Normal, ProcessWindowStyle.Hidden)
            })
        End If

    End Sub

End Class