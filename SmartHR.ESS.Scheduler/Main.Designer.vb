<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Main
    Inherits SmartHR.ESS.Common.BaseForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
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
        Me.label1 = New System.Windows.Forms.Label()
        Me.btnStartStop = New System.Windows.Forms.Button()
        Me.lblStatus = New System.Windows.Forms.Label()
        Me.label4 = New System.Windows.Forms.Label()
        Me.fieldOutp = New System.Windows.Forms.ListBox()
        Me.lblTime = New System.Windows.Forms.Label()
        Me.label3 = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 7.8!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label1.Location = New System.Drawing.Point(17, 17)
        Me.label1.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(108, 13)
        Me.label1.TabIndex = 1
        Me.label1.Text = "Scheduler Status:"
        '
        'btnStartStop
        '
        Me.btnStartStop.Anchor = System.Windows.Forms.AnchorStyles.Bottom
        Me.btnStartStop.Location = New System.Drawing.Point(380, 287)
        Me.btnStartStop.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.btnStartStop.Name = "btnStartStop"
        Me.btnStartStop.Size = New System.Drawing.Size(78, 23)
        Me.btnStartStop.TabIndex = 2
        Me.btnStartStop.Text = "Start"
        Me.btnStartStop.UseVisualStyleBackColor = True
        '
        'lblStatus
        '
        Me.lblStatus.AutoSize = True
        Me.lblStatus.Location = New System.Drawing.Point(146, 17)
        Me.lblStatus.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.lblStatus.Name = "lblStatus"
        Me.lblStatus.Size = New System.Drawing.Size(37, 13)
        Me.lblStatus.TabIndex = 3
        Me.lblStatus.Text = "Status"
        '
        'label4
        '
        Me.label4.AutoSize = True
        Me.label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 7.8!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label4.Location = New System.Drawing.Point(17, 49)
        Me.label4.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(93, 13)
        Me.label4.TabIndex = 4
        Me.label4.Text = "Scheduler Log:"
        '
        'fieldOutp
        '
        Me.fieldOutp.FormattingEnabled = True
        Me.fieldOutp.Location = New System.Drawing.Point(20, 73)
        Me.fieldOutp.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.fieldOutp.Name = "fieldOutp"
        Me.fieldOutp.Size = New System.Drawing.Size(438, 199)
        Me.fieldOutp.TabIndex = 5
        '
        'lblTime
        '
        Me.lblTime.AutoSize = True
        Me.lblTime.Location = New System.Drawing.Point(412, 17)
        Me.lblTime.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.lblTime.Name = "lblTime"
        Me.lblTime.Size = New System.Drawing.Size(37, 13)
        Me.lblTime.TabIndex = 7
        Me.lblTime.Text = "Status"
        Me.lblTime.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 7.8!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label3.Location = New System.Drawing.Point(273, 17)
        Me.label3.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(127, 13)
        Me.label3.TabIndex = 6
        Me.label3.Text = "Current System Time:"
        '
        'Main
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(473, 321)
        Me.Controls.Add(Me.label3)
        Me.Controls.Add(Me.lblTime)
        Me.Controls.Add(Me.fieldOutp)
        Me.Controls.Add(Me.label4)
        Me.Controls.Add(Me.lblStatus)
        Me.Controls.Add(Me.btnStartStop)
        Me.Controls.Add(Me.label1)
        Me.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.Name = "Main"
        Me.Text = "Main"
        Me.ResumeLayout(False)
        Me.PerformLayout()

        SetSqlConnection()

        timer = New System.Timers.Timer()
        AddHandler timer.Elapsed, AddressOf timer_Elapsed
        timer.Interval = 1000

        processes = New List(Of ProcessBase)
    End Sub
    Friend WithEvents label1 As System.Windows.Forms.Label
    Friend WithEvents btnStartStop As System.Windows.Forms.Button
    Friend WithEvents lblStatus As System.Windows.Forms.Label
    Friend WithEvents label4 As System.Windows.Forms.Label
    Friend WithEvents fieldOutp As System.Windows.Forms.ListBox
    Friend WithEvents lblTime As System.Windows.Forms.Label
    Friend WithEvents label3 As System.Windows.Forms.Label
End Class
