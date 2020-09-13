Imports System.IO

' LICENSE KEY FORMAT:
'( 65 + ( 90 - ( TWO-BYTE HEX ) ) )
'01234-56789-01234-56789-01234
'GQ4W9-KKWMH-FJFMJ-WHHRR-QPFWP

'2, 22 (2):

'Tasks = 0
'Notifications = 1
'Personal = 2
'Organizational = 3
'Leave = 4
'CV = 5
'Accidents = 6
'IR = 7

'6, 18 (2):

'Evaluations = 0
'Linked Documents = 1
'Assets = 2
'Loans = 3
'Training = 4
'Workflow = 5
'Setup = 6
'Staff Locator = 7

'11, 13 (2):

'OH&S = 0
'Reports = 1
'Claims = 2
'Policies = 3
'Financial = 4
'Pay Info = 5
'Learning Needs = 6
'Basic Conditions = 7

'4, 20 (2):

'Homepage = 0
'Timesheets = 1

'0, 15 (2) | 8, 17 (2) | 9, 24 (2) | 16, 10 (2):

'# of employees

'1, 3, 5, 7, 12, 14, 19, 21, 23 (9)

'Client ID ( Randomly Generated )

Partial Public Class _default
    Inherits System.Web.UI.Page

#Region " *** Web Form Functions *** "

    Private Sub InitForm()

        Dim enumerator As IDictionaryEnumerator = Cache.GetEnumerator

        While enumerator.MoveNext()

            Cache.Remove(enumerator.Key)

        End While

        With Version

            lblAppVersion.Text = .Application
            lblDBVersion.Text = .Database

        End With

        ' jalzate 04/12/2019
        ' added text to indicate which server and database the ESS is connected to
        ltConn.Text = "Not Connected"

        With SQLServer

            lblServer.Text = .Server
            lblDatabase.Text = .Database


            If (Not IsNothing(.Server) And Not IsNothing(.Database) And Not IsNothing(lblAppVersion.Text) And Not lblAppVersion.Text = "" And Not IsNothing(lblDBVersion.Text) And Not lblDBVersion.Text = "") Then
                ltConn.Text = "Conntected to: " & .Server & " - " & .Database
            End If

        End With
        ' jalzate - end

        ltBuildNum.Text = GetBuildNumber()

        pnlServer.Visible = GetArrayItem(Nothing, "eSecurity.Information")

        If (GetArrayItem(Nothing, "eSecurity.ADEnabled")) AndAlso (Not IsNull(GetArrayItem(Nothing, "eSecurity.ADServer"))) Then

            txtUsername.Text = HttpContext.Current.User.Identity.Name

            Dim objUser() As Object = GetSQLFields("select [CompanyNum], [EmployeeNum] from [Users] where ([ADUsername] = '" & txtUsername.Text & "')")

            If (Not IsNull(objUser)) Then

                hlPassword.Visible = False

                txtUsername.Enabled = False

                If (GetArrayItem(Nothing, "eSecurity.ADLogon")) Then

                    Dim ErrorText As String = String.Empty

                    Dim CompanyNum As String = String.Empty
                    Dim EmployeeNum As String = String.Empty

                    ErrorText = ValidateUser(CompanyNum, EmployeeNum, txtUsername.Text, String.Empty)

                    If (ErrorText.Length > 0) Then

                        Response.Write("<script language=""javascript"" type=""text/javascript"">ShowPopup('" & ErrorText & "');</script>")

                    Else

                        ClearSessionCache(Session.SessionID)

                        Dim docUnread As Integer = GetSQLField("select count([ID]) as [RecCount] from [ess.Documents] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [Acknowledged] = 0)", "RecCount")

                        Dim Username As String = GetSQLField("select [Username] from [Users] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')", "Username")

                        Dim objCompData() As Object = GetSQLFields("select [CompanyName], [Division], [SubDivision], [SubSubDivision] from [Company] where ([CompanyNum] = '" & CompanyNum & "')")

                        Dim objUserData() As Object = GetSQLFields("select [Leave_Scheme], [DeptName] from [Personnel] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

                        If (Not IsNull(objCompData) AndAlso Not IsNull(objUserData)) Then

                            Dim USRStruct As Users = New Users()

                            With USRStruct

                                .CompanyNum = CompanyNum

                                .EmployeeNum = EmployeeNum

                                .UserID = Username

                                If (Not IsNull(objCompData(0))) Then .CompanyName = objCompData(0).ToString()

                                If (Not IsNull(objCompData(1))) Then .Division = objCompData(1).ToString()

                                If (Not IsNull(objCompData(2))) Then .SubDivision = objCompData(2).ToString()

                                If (Not IsNull(objCompData(3))) Then .SubSubDivision = objCompData(3).ToString()

                                .LeaveScheme = objUserData(0).ToString()

                                .Department = objUserData(1).ToString()

                            End With

                            Session.Add("LoggedOn", USRStruct)
                            Session.Add("Managed", USRStruct)

                            Session.Add("docUnread", Convert.ToBoolean(docUnread > 0))

                            Session.Add("SetLoggedOn", False)

                            Session.Add("ChipCount", 0)

                            Response.Redirect("index.aspx", True)

                        End If

                    End If

                End If

            Else

                txtUsername.Text = String.Empty

            End If

        End If

    End Sub

    Private Function ValidateUser(ByRef CompanyNum As String, ByRef EmployeeNum As String, ByVal Username As String, ByVal Password As String, Optional ByVal SetUser As Boolean = False) As String

        Dim ReturnText As String = String.Empty

        Dim UserID As String = Username

        Dim UserPwd As String = Password

        If (Not GetArrayItem(Nothing, "eSecurity.ADEnabled")) Then

            If (Not Version.EncryptedPwd) Then

                Password = " and [Password] = '" & Password & "'"

            Else

                Password = " and pwdcompare('" & Password & "', [Password]) = 1"

            End If

            Username = "[Username] = '" & Username & "'"

        Else

            Password = "[ADUsername] = '" & HttpContext.Current.User.Identity.Name & "' and 1 = "

            If (GetArrayItem(Nothing, "eSecurity.ADLogon")) Then

                Password &= "1"

            Else

                Password &= IIf(IsActiveDirectoryUser(GetArrayItem(Nothing, "eSecurity.ADServer"), Username, Password), "1", "0")

            End If

            Username = String.Empty

        End If

Check:

        Dim objUser() As Object = GetSQLFields("select top 1 [CompanyNum], [EmployeeNum] from [Users] where (" & Username & Password & ")")

        If (Not IsNull(objUser)) Then

            If (Not IsNull(objUser(0)) AndAlso Not IsNull(objUser(1))) Then

                CompanyNum = objUser(0).ToString()

                EmployeeNum = objUser(1).ToString()

                Dim bTermination As Boolean = GetSQLField("select [Termination] from [Personnel] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')", "Termination")

                If (bTermination) Then

                    ReturnText = ACCOUNT_TERMINATED

                ElseIf (Not SetUser) Then

                    Dim iCount() As Object = GetSQLFields("select count([Username]) as [RecCount], (select count([Username]) as [RecCount] from [Users] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [DefaultUser] = 1)) as [DefCount] from [Users] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

                    If (Not IsNull(iCount)) Then

                        If (iCount(0) > 1) AndAlso (iCount(1) = 0) Then

                            ReturnText = MULTIPLE_ACCOUNTS & " "

                            Dim dtUsers As DataTable = GetSQLDT("select [Username] from [Users] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "') order by [Username]")

                            If (IsData(dtUsers)) Then

                                For iLoop As Integer = 0 To (dtUsers.Rows.Count - 1)

                                    With dtUsers.Rows(iLoop)

                                        ReturnText &= .Item("Username").ToString() & " "

                                    End With

                                Next

                                If (ReturnText.EndsWith(" ")) Then ReturnText = ReturnText.Substring(0, ReturnText.Length - 1)

                            End If

                            If (Not IsNull(dtUsers)) Then

                                dtUsers.Dispose()

                                dtUsers = Nothing

                            End If

                        End If

                    End If

                ElseIf (SetUser) Then

                    ExecSQL("update [Users] set [DefaultUser] = 1 where ([Username] = '" & UserID & "')")

                    ExecSQL("update [ess.Path] set [ActionerUsername] = '" & UserID & "' where ([ActionerCompanyNum] = '" & CompanyNum & "') and ([ActionerEmployeeNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.Path] set [ActionedByUsername] = '" & UserID & "' where ([ActionedByCompNum] = '" & CompanyNum & "') and ([ActionedByEmpNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.Path] set [OriginatorUsername] = '" & UserID & "' where ([OriginatorCompanyNum] = '" & CompanyNum & "') and ([OriginatorEmployeeNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.Path] set [PrevActionerUsername] = '" & UserID & "' where ([PrevActionerCompNum] = '" & CompanyNum & "') and ([PrevActionerEmpNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.WFAudit] set [ActionerUsername] = '" & UserID & "' where ([ActionerCompanyNum] = '" & CompanyNum & "') and ([ActionerEmployeeNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.WFAudit] set [ActionedByUsername] = '" & UserID & "' where ([ActionedByCompNum] = '" & CompanyNum & "') and ([ActionedByEmpNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.WFAudit] set [OriginatorUsername] = '" & UserID & "' where ([OriginatorCompanyNum] = '" & CompanyNum & "') and ([OriginatorEmployeeNum] = '" & EmployeeNum & "')")

                    ExecSQL("update [ess.WFAudit] set [PrevActionerUsername] = '" & UserID & "' where ([PrevActionerCompNum] = '" & CompanyNum & "') and ([PrevActionerEmpNum] = '" & EmployeeNum & "')")

                End If

            Else

                ReturnText = INVALID_LOGON

            End If

        Else

            If (GetArrayItem(Nothing, "eSecurity.ADEnabled") AndAlso UserID.Length > 0 AndAlso UserPwd.Length > 0) Then

                Username = "[Username] = '" & UserID & "'"

                Password = " and [Password] = '" & UserPwd & "'"

                UserID = String.Empty

                UserPwd = String.Empty

                GoTo Check

            Else

                ReturnText = INVALID_LOGON

            End If

        End If

        Return ReturnText

    End Function

    Public Function GetBuildNumber() As String

        Dim buildNumberPath As String = Server.MapPath("~/") + "buildversion.inc"

        If (Not File.Exists(buildNumberPath)) Then Return ""

        Return File.ReadAllText(buildNumberPath).Trim()

    End Function

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            InitForm()

            If (txtUsername.Enabled) Then

                txtUsername.Focus()

            Else

                txtPassword.Focus()

            End If

        End If

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Select Case Values(0)

            Case "reset"
                Dim SQL As String = String.Empty

                Dim objUserData() As Object = GetSQLFields("select [emp].[CompanyNum], [emp].[EmployeeNum], [Username], [EmailAddress], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]), (select top 1 [WebServer] from [Various]) from [Users] as [u] left outer join [Personnel] as [emp] on [u].[CompanyNum] = [emp].[CompanyNum] and [u].[EmployeeNum] = [emp].[EmployeeNum] where ([Username] = '" & GetDataText(Values(1)) & "' and [EmailAddress] = '" & GetDataText(Values(2)) & "')")

                If (Not IsNull(objUserData)) Then

                    Dim PasswordID As Guid = Guid.NewGuid()

                    Dim SendTo As String = objUserData(3).ToString()

                    SQL = "insert into [Passwords]([ID], [CompanyNum], [EmployeeNum], [Username], [CreatedOn]) values('" & PasswordID.ToString() & "', '" & objUserData(0).ToString() & "', '" & objUserData(1).ToString() & "', '" & objUserData(2).ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "')"

                    If (ExecSQL(SQL)) Then

                        If (objUserData(5).ToString().EndsWith("/")) Then objUserData(5) = objUserData(5).ToString().Substring(0, objUserData(5).ToString().Length - 1)

                        SendEmail(Server.MapPath(String.Empty), GetEmailID("Password: Reset"), "<SendTo=" & SendTo & ">", String.Empty, False, String.Empty, objUserData(4).ToString(), objUserData(5).ToString() & "/password.aspx?id=" & PasswordID.ToString())

                        ErrorText = SUCCESS & " Your password request has been sent to your registered email address"

                    Else

                        ErrorText = DBERROR & SQL

                    End If

                    objUserData = Nothing

                Else

                    ErrorText = INVALID_EMAIL

                End If

            Case "submit"
                Dim CompanyNum As String = String.Empty
                Dim EmployeeNum As String = String.Empty

                Dim SetUser As Boolean = False

                If (Values.GetLength(0) = 4) Then SetUser = Convert.ToBoolean(Values(3))

                ErrorText = ValidateUser(CompanyNum, EmployeeNum, Values(1), Values(2), SetUser)

                If (ErrorText.Length = 0) Then

                    Dim docUnread As Integer = GetSQLField("select count([ID]) as [RecCount] from [ess.Documents] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [Acknowledged] = 0)", "RecCount")

                    Dim Username As String = Values(1) 'GetSQLField("select [Username] from [Users] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')", "Username")

                    Dim objCompData() As Object = GetSQLFields("select [CompanyName], [Division], [SubDivision], [SubSubDivision] from [Company] where ([CompanyNum] = '" & CompanyNum & "')")

                    Dim objUserData() As Object = GetSQLFields("select [Leave_Scheme], [DeptName] from [Personnel] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

                    If (Not IsNull(objCompData) AndAlso Not IsNull(objUserData)) Then

                        Dim USRStruct As Users = New Users()

                        With USRStruct

                            .CompanyNum = CompanyNum

                            .EmployeeNum = EmployeeNum

                            .UserID = Username

                            If (Not IsNull(objCompData(0))) Then .CompanyName = objCompData(0).ToString()

                            If (Not IsNull(objCompData(1))) Then .Division = objCompData(1).ToString()

                            If (Not IsNull(objCompData(2))) Then .SubDivision = objCompData(2).ToString()

                            If (Not IsNull(objCompData(3))) Then .SubSubDivision = objCompData(3).ToString()

                            If (Not IsNull(objUserData(0))) Then .LeaveScheme = objUserData(0).ToString()

                            If (Not IsNull(objUserData(1))) Then .Department = objUserData(1).ToString()

                        End With

                        Session.Add("LoggedOn", USRStruct)
                        Session.Add("Managed", USRStruct)

                        Session.Add("docUnread", Convert.ToBoolean(docUnread > 0))

                        Session.Add("SetLoggedOn", False)

                        ErrorText = "index.aspx"

                    End If

                ElseIf (ErrorText.StartsWith(MULTIPLE_ACCOUNTS)) Then

                    ErrorText = ErrorText.Replace(MULTIPLE_ACCOUNTS & " ", String.Empty)

                    ErrorText = "ShowMultiple " & ErrorText

                End If

        End Select

        e.Result = Values(0) & " " & ErrorText

    End Sub

#End Region

End Class