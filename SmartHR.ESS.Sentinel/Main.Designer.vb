<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Main
    Inherits SmartHR.ESS.Common.BaseForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If sentinelProcesses IsNot Nothing Then

                sentinelProcesses.Clear()
                sentinelProcesses = Nothing

            End If

            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblApp = New System.Windows.Forms.Label()
        Me.lblDb = New System.Windows.Forms.Label()
        Me.lblDt = New System.Windows.Forms.Label()
        Me.lblJob = New System.Windows.Forms.Label()
        Me.lblStatus = New System.Windows.Forms.Label()
        Me.lblAppName = New System.Windows.Forms.Label()
        Me.lblDbName = New System.Windows.Forms.Label()
        Me.lblDtValue = New System.Windows.Forms.Label()
        Me.lblJobName = New System.Windows.Forms.Label()
        Me.btnStart = New System.Windows.Forms.Button()
        Me.lbMessages = New System.Windows.Forms.ListBox()
        Me.SuspendLayout()
        '
        'lblApp
        '
        Me.lblApp.AutoSize = True
        Me.lblApp.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblApp.Location = New System.Drawing.Point(12, 18)
        Me.lblApp.Name = "lblApp"
        Me.lblApp.Size = New System.Drawing.Size(74, 13)
        Me.lblApp.TabIndex = 0
        Me.lblApp.Text = "Application:"
        '
        'lblDb
        '
        Me.lblDb.AutoSize = True
        Me.lblDb.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDb.Location = New System.Drawing.Point(12, 46)
        Me.lblDb.Name = "lblDb"
        Me.lblDb.Size = New System.Drawing.Size(65, 13)
        Me.lblDb.TabIndex = 1
        Me.lblDb.Text = "Database:"
        '
        'lblDt
        '
        Me.lblDt.AutoSize = True
        Me.lblDt.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDt.Location = New System.Drawing.Point(12, 71)
        Me.lblDt.Name = "lblDt"
        Me.lblDt.Size = New System.Drawing.Size(116, 13)
        Me.lblDt.TabIndex = 2
        Me.lblDt.Text = "Current Date/Time:"
        '
        'lblJob
        '
        Me.lblJob.AutoSize = True
        Me.lblJob.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblJob.Location = New System.Drawing.Point(12, 96)
        Me.lblJob.Name = "lblJob"
        Me.lblJob.Size = New System.Drawing.Size(119, 13)
        Me.lblJob.TabIndex = 3
        Me.lblJob.Text = "Last Job Launched:"
        '
        'lblStatus
        '
        Me.lblStatus.AutoSize = True
        Me.lblStatus.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblStatus.Location = New System.Drawing.Point(12, 122)
        Me.lblStatus.Name = "lblStatus"
        Me.lblStatus.Size = New System.Drawing.Size(47, 13)
        Me.lblStatus.TabIndex = 4
        Me.lblStatus.Text = "Status:"
        '
        'lblAppName
        '
        Me.lblAppName.AutoSize = True
        Me.lblAppName.Location = New System.Drawing.Point(138, 18)
        Me.lblAppName.Name = "lblAppName"
        Me.lblAppName.Size = New System.Drawing.Size(66, 13)
        Me.lblAppName.TabIndex = 5
        Me.lblAppName.Text = "<app name>"
        '
        'lblDbName
        '
        Me.lblDbName.AutoSize = True
        Me.lblDbName.Location = New System.Drawing.Point(138, 46)
        Me.lblDbName.Name = "lblDbName"
        Me.lblDbName.Size = New System.Drawing.Size(63, 13)
        Me.lblDbName.TabIndex = 6
        Me.lblDbName.Text = "<database>"
        '
        'lblDtValue
        '
        Me.lblDtValue.AutoSize = True
        Me.lblDtValue.Location = New System.Drawing.Point(138, 71)
        Me.lblDtValue.Name = "lblDtValue"
        Me.lblDtValue.Size = New System.Drawing.Size(0, 13)
        Me.lblDtValue.TabIndex = 7
        '
        'lblJobName
        '
        Me.lblJobName.AutoSize = True
        Me.lblJobName.Location = New System.Drawing.Point(138, 96)
        Me.lblJobName.Name = "lblJobName"
        Me.lblJobName.Size = New System.Drawing.Size(0, 13)
        Me.lblJobName.TabIndex = 8
        '
        'btnStart
        '
        Me.btnStart.Location = New System.Drawing.Point(196, 256)
        Me.btnStart.Name = "btnStart"
        Me.btnStart.Size = New System.Drawing.Size(75, 23)
        Me.btnStart.TabIndex = 10
        Me.btnStart.Text = "Start"
        Me.btnStart.UseVisualStyleBackColor = True
        '
        'lbMessages
        '
        Me.lbMessages.FormattingEnabled = True
        Me.lbMessages.Location = New System.Drawing.Point(141, 122)
        Me.lbMessages.Name = "lbMessages"
        Me.lbMessages.Size = New System.Drawing.Size(305, 121)
        Me.lbMessages.TabIndex = 11
        '
        'Main
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(467, 290)
        Me.Controls.Add(Me.lbMessages)
        Me.Controls.Add(Me.btnStart)
        Me.Controls.Add(Me.lblJobName)
        Me.Controls.Add(Me.lblDtValue)
        Me.Controls.Add(Me.lblDbName)
        Me.Controls.Add(Me.lblAppName)
        Me.Controls.Add(Me.lblStatus)
        Me.Controls.Add(Me.lblJob)
        Me.Controls.Add(Me.lblDt)
        Me.Controls.Add(Me.lblDb)
        Me.Controls.Add(Me.lblApp)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.MaximizeBox = False
        Me.Name = "Main"
        Me.Text = "SmartHR.ESS.Sentinel"
        Me.ResumeLayout(False)
        Me.PerformLayout()

        sentinelProcesses = New List(Of ISentinel) From
        {
            New EmailNotification(SqlConnection, SqlHelper)
        }

    End Sub
    Friend WithEvents lblApp As System.Windows.Forms.Label
    Friend WithEvents lblDb As System.Windows.Forms.Label
    Friend WithEvents lblDt As System.Windows.Forms.Label
    Friend WithEvents lblJob As System.Windows.Forms.Label
    Friend WithEvents lblStatus As System.Windows.Forms.Label
    Friend WithEvents lblAppName As System.Windows.Forms.Label
    Friend WithEvents lblDbName As System.Windows.Forms.Label
    Friend WithEvents lblDtValue As System.Windows.Forms.Label
    Friend WithEvents lblJobName As System.Windows.Forms.Label
    Friend WithEvents btnStart As System.Windows.Forms.Button
    Friend WithEvents lbMessages As System.Windows.Forms.ListBox

End Class
