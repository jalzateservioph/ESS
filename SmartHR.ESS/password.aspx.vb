Public Partial Class password
    Inherits System.Web.UI.Page

    Private PasswordID As Guid = Guid.Empty

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsNull(Request.QueryString("ID"))) Then

            If (IsGuid(Request.QueryString("ID"))) Then PasswordID = New Guid(Request.QueryString("ID").ToString())

        End If

        If (Not IsPostBack) Then txtPassword.Focus()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Select Case Values(0)

            Case "resetpwd"
                If (Values(1) = Values(2)) Then

                    If (GetArrayItem(Nothing, "eSecurity.Strict") AndAlso Not CheckPassword(Values(1), GetArrayItem(Nothing, "eSecurity.MinLength"))) Then ErrorText = "information Your password do not match the security rules configured"

                    If (Not IsString(ErrorText)) Then

                        Dim objUserData() As Object = Nothing

                        Try

                            objUserData = GetSQLFields("select distinct [emp].[CompanyNum], [emp].[EmployeeNum], [EmailAddress], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]), [p].[Username] from ([Passwords] as [p] left outer join [Users] as [u] on [p].[CompanyNum] = [u].[CompanyNum] and [p].[EmployeeNum] = [u].[EmployeeNum]) left outer join [Personnel] as [emp] on [p].[CompanyNum] = [emp].[CompanyNum] and [p].[EmployeeNum] = [emp].[EmployeeNum] where ([p].[ID] = '" & GetDataText(PasswordID.ToString()) & "')")

                            If (Not IsNull(objUserData)) Then

                                Dim Password As String = String.Empty

                                If (Not Version.EncryptedPwd) Then

                                    Password = "'" & GetDataText(Values(1)) & "'"

                                Else

                                    Password = "pwdencrypt('" & GetDataText(Values(1)) & "')"

                                End If

                                Dim SQL As String = "update [Users] set [Password] = " & Password & " where ([Username] = '" & GetDataText(objUserData(4)) & "')"

                                If (ExecSQL(SQL)) Then

                                    ExecSQL("delete from [Passwords] where ([ID] = '" & GetDataText(PasswordID.ToString()) & "')")

                                    ErrorText = "default.aspx"

                                    SendEmail(Server.MapPath(String.Empty), GetEmailID("Password: Success"), "<SendTo=" & objUserData(2).ToString() & ">", String.Empty, False, String.Empty, objUserData(3).ToString())

                                Else

                                    ErrorText = DBERROR & SQL

                                End If

                            Else

                                ErrorText = INVALID_EMAIL

                            End If

                        Catch ex As Exception

                        Finally

                            objUserData = Nothing

                        End Try

                    End If

                Else

                    ErrorText = PASSWORDS_MATCH

                End If

        End Select

        e.Result = Values(0) & " " & ErrorText

    End Sub

#End Region

End Class