Public Partial Class chipnpin
    Inherits System.Web.UI.Page

    Private URLString As String = String.Empty

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsNull(Request.QueryString("url"))) Then URLString = Request.QueryString("url").ToString()

        Dim dteSend As Date = Nothing

        Try

            dteSend = Session("ChipnPinSentAt")

            If (Not IsDate(dteSend)) Then dteSend = Now

        Catch ex As Exception

        End Try

        If (dteSend = Nothing) Then dteSend = Now

        Dim Cellphone As String = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] = '" & Session("LoggedOn").CompanyNum & "' and [EmployeeNum] = '" & Session("LoggedOn").EmployeeNum & "')", "CellTel")

        If (Not IsNull(Cellphone)) Then

            lblSentAt.Text = "Please enter the one time password sent to your cellphone '" & Cellphone & "' on '" & dteSend.ToString("yyyy-MM-dd HH:mm:ss") & "'"

        Else

            lblSentAt.Text = "*** Error: No cellphone number detected ***"

        End If

    End Sub

    Private Sub cmdContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdContinue.Click

        Dim dChipnPin As DataTable = GetSQLDT("select [ChipnPin], [ChipnPinSent] from [Users] where ([Username] = '" & Session("LoggedOn").UserID & "')")

        If (IsData(dChipnPin)) Then

            With dChipnPin.Rows(0)

                If (.Item("ChipnPin").ToString() = txtChipnPin.Text) Then

                    If (DateAdd(DateInterval.Minute, 15, .Item("ChipnPinSent")) > Now) Then

                        Session("ChipnPin") = True

                        Response.Redirect(URLString)

                        Session("ChipCount") = 0

                    End If

                End If

            End With

            dChipnPin.Dispose()

        End If

        dChipnPin = Nothing

    End Sub

    Private Sub cmdResend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdResend.Click

        Dim mobile As String = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] = '" & Session("LoggedOn").CompanyNum & "' and [EmployeeNum] = '" & Session("LoggedOn").EmployeeNum & "')", "CellTel")

        If (Not IsNull(mobile)) Then

            Dim GeneratedPin As String = CreatePin(5)

            Dim dteSent As Date = Now

            Session("ChipnPinSentAt") = dteSent

            If (URLString.ToLower() = "pay.aspx") Then

                SendSMS(mobile, "Your one time password is " & GeneratedPin & " (keep this pin safe as you will need it to open the document) - if you have any queries please contact your HR department.")

            Else

                SendSMS(mobile, "Your one time password is " & GeneratedPin & " - if you have any queries please contact your HR department.")

            End If

            ExecSQL("update [Users] set [ChipnPin] = '" & GeneratedPin & "', [ChipnPinSent] = '" & dteSent.ToString("yyyy-MM-dd HH:mm:ss") & "' where ([Username] = '" & Session("LoggedOn").UserID & "')")

        End If

    End Sub

#End Region

End Class