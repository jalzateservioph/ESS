Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxPanel
Imports System.IO
Imports System.Web.HttpUtility

Public Class contacts
    Inherits System.Web.UI.Page

    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False, Optional ByVal SQLFilter As String = "", Optional ByVal GridBind As Boolean = True)

        If (ClearCache Or Not IsPostBack) Then ClearFromCache("Data.Contacts")

        Dim dtContacts As DataTable = Nothing

        Dim SQLData As String = String.Empty

        Try

            SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [e].[CompanyNum] and [EmployeeNum] = [e].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [e].[CompanyNum] + ' ' + [e].[EmployeeNum] as [Value], [e].[Surname], [e].[PreferredName], [e].[FirstName], [JobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], 'mailto:' + isnull([EMailAddress], '') as [mailto], [EMailAddress], [OfficeNo], [CellTel], [Leave_Scheme], [e1].[ShiftType], [EmployeePicture], cast([OutOfficeStatus] as varchar(3)) as [OutOfficeStatus], 0 as [Processed] from ([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]<%Terminated%> order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [e].[CompanyNum], [e].[EmployeeNum]"

            If (GetArrayItem(Nothing, "eGeneral.ShowTerminated")) Then

                If (SQLFilter.Length = 0) Then

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                Else

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " where (" & SQLFilter & ")", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                End If

            Else

                If (SQLFilter.Length = 0) Then

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " where (((([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and (not [e].[Termination] = 1)) or (([e].[Termination] = 1) and ([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and ([e].[TerminationDate] > '" & Today.ToString("yyyy-MM-dd") & "'))))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                Else

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " where ((((([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and (not [e].[Termination] = 1)) or (([e].[Termination] = 1) and ([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and ([e].[TerminationDate] > '" & Today.ToString("yyyy-MM-dd") & "')))) and (" & SQLFilter & "))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                End If

            End If

            dtContacts = GetSQLDT(SQLData, "Data.Contacts")

            If (IsData(dtContacts)) Then

                For i As Integer = 0 To (dtContacts.Rows.Count - 1)

                    If (dtContacts.Rows(i).Item("Processed") = 0 AndAlso Not IsNull(dtContacts.Rows(i).Item("EmployeePicture"))) Then

                        dtContacts.Rows(i).Item("EmployeePicture") = GetThumbnail(dtContacts.Rows(i).Item("EmployeePicture"), 64, 64)

                        dtContacts.Rows(i).Item("Processed") = 1

                    End If

                Next

            End If

            If (GridBind) Then

                dgView.DataSource = dtContacts

                dgView.DataBind()

            End If

            Dim UserGroup As String = String.Empty

            If (IsPostBack AndAlso Not IsNull(Session("LoggedOn"))) Then

                UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

                If (Not IsNull(UserGroup)) Then

                    Dim SelectedValue As String = String.Empty

                    For Each objKey As Object In dgView.GetSelectedFieldValues("Value")

                        If (Not SelectedValue.Contains(objKey.ToString())) Then SelectedValue &= "'" & objKey.ToString() & "', "

                    Next

                    If (SelectedValue.EndsWith(", ")) Then SelectedValue = SelectedValue.Substring(0, SelectedValue.Length - 2)

                    With UDetails

                        If (hPanel.Get("ActiveIndex") = 2 AndAlso tabEmail.Visible) Then

                            Session("BulkEmail.Body") = heBody.Html

                            dgView_001.FilterExpression = "[Value] in(" & SelectedValue & ")"

                            dgView_001.DataSource = dtContacts

                            dgView_001.DataBind()

                        ElseIf (hPanel.Get("ActiveIndex") = 3 AndAlso tabSMS.Visible) Then

                            dgView_002.FilterExpression = "[Value] in(" & SelectedValue & ")"

                            dgView_002.DataSource = dtContacts

                            dgView_002.DataBind()

                        End If

                    End With

                End If

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dtContacts)) Then

                dtContacts.Dispose()

                dtContacts = Nothing

            End If

        End Try

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then

            hPanel.Set("ActiveIndex", 0)

            SetEmployeeData(Session, Session("Selected.Value"))

        End If

        UDetails = GetUserDetails(Session, "Notify Admin")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Progress As Object = Nothing

        e.Result = e.Parameter & " "

        Select Case e.Parameter

            Case "Progress"
                Progress = Cache(Session.SessionID & ".Progress")

                If (Not IsNull(Progress)) Then

                    If (Progress = 100) Then

                        e.Result &= "100 " & SUCCESS & " Successfully sent the messages"

                        ClearFromCache(Session.SessionID & ".Progress")

                    Else

                        e.Result &= Progress.ToString()

                    End If

                Else

                    e.Result &= "100 " & SUCCESS & " Successfully sent the messages"

                End If

            Case "Back"
                If (hPanel.Get("ActiveIndex") = 2 AndAlso tabEmail.Visible) Then

                    e.Result &= tabEmail.ActiveTabIndex - 1

                ElseIf (hPanel.Get("ActiveIndex") = 3 AndAlso tabSMS.Visible) Then

                    e.Result &= tabSMS.ActiveTabIndex - 1

                End If

            Case "Next"
                If (hPanel.Get("ActiveIndex") = 2 AndAlso tabEmail.Visible) Then

                    e.Result &= tabEmail.ActiveTabIndex + 1

                ElseIf (hPanel.Get("ActiveIndex") = 3 AndAlso tabSMS.Visible) Then

                    e.Result &= tabSMS.ActiveTabIndex + 1

                End If

            Case "Submit"
                If (hPanel.Get("ActiveIndex") = 2 AndAlso tabEmail.Visible) Then

                    Dim Body As String = heBody.Html

                    Body = Body.Replace(Request.UrlReferrer.Scheme & Uri.SchemeDelimiter & Request.UrlReferrer.Authority & "/", String.Empty)

                    Session.Remove("BulkEmail.Body")

                    Dim SendTo As String = String.Empty

                    Dim Email As String = String.Empty

                    Dim arSendTo() As String = Nothing

                    Dim arSubject() As String = Nothing

                    Dim arText() As String = Nothing

                    ReDim arSendTo(dgView_001.VisibleRowCount - 1)

                    ReDim arSubject(dgView_001.VisibleRowCount - 1)

                    ReDim arText(dgView_001.VisibleRowCount - 1)

                    For iLoop As Integer = 0 To (dgView_001.VisibleRowCount - 1)

                        Email = dgView_001.GetRowValues(iLoop, "EMailAddress")

                        If (Not IsNull(Email)) Then

                            SendTo &= Email

                            If (iLoop < (dgView_001.VisibleRowCount - 1)) Then SendTo &= ";"

                            arSendTo(iLoop) = Email

                            arSubject(iLoop) = ReplaceKeys(dgView_001.GetRowValues(iLoop, "Value"), txtSubject.Text)

                            arText(iLoop) = ReplaceKeys(dgView_001.GetRowValues(iLoop, "Value"), Body)

                        Else

                            arSendTo(iLoop) = Nothing

                            arSubject(iLoop) = Nothing

                            arText(iLoop) = Nothing

                        End If

                    Next

                    If (SendTo.Length > 0) Then

                        ClearFromCache(Session.SessionID & ".Progress")

                        SendBulkEmail(Server.MapPath(String.Empty), Session.SessionID, arSendTo, arSubject, arText)

                        e.Result &= "Progress"

                    Else

                        e.Result &= SUCCESS & " Successfully sent the messages"

                    End If

                ElseIf (hPanel.Get("ActiveIndex") = 3 AndAlso tabSMS.Visible) Then

                    Dim SendTo As String = String.Empty

                    Dim MobileNum As String = String.Empty

                    Dim arSendTo() As String = Nothing

                    Dim arText() As String = Nothing

                    ReDim arSendTo(dgView_002.VisibleRowCount - 1)

                    ReDim arText(dgView_002.VisibleRowCount - 1)

                    For iLoop As Integer = 0 To (dgView_002.VisibleRowCount - 1)

                        MobileNum = dgView_002.GetRowValues(iLoop, "CellTel")

                        If (Not IsNull(MobileNum)) Then

                            SendTo &= MobileNum

                            If (iLoop < (dgView_002.VisibleRowCount - 1)) Then SendTo &= ";"

                            arSendTo(iLoop) = MobileNum

                            arText(iLoop) = ReplaceKeys(dgView_002.GetRowValues(iLoop, "Value"), txtMessage_001.Text)

                        Else

                            arSendTo(iLoop) = Nothing

                            arText(iLoop) = Nothing

                        End If

                    Next

                    If (SendTo.Length > 0) Then

                        ClearFromCache(Session.SessionID & ".Progress")

                        SendBulkSMS(Session.SessionID, arSendTo, arText)

                        e.Result &= "Progress"

                    Else

                        e.Result &= SUCCESS & " Successfully sent the messages"

                    End If

                End If

        End Select

    End Sub

    Private Sub dgView_002_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_002.CustomColumnDisplayText

        If (e.Column.FieldName = "JobTitle") Then e.DisplayText = ReplaceKeys(sender.GetRowValues(e.VisibleRowIndex, "Value"), txtMessage_001.Text)

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Return "function(s, e) { window.open('preview.aspx?ID=" & UrlEncode(Container.Grid.GetRowValues(Container.VisibleIndex, "Value")) & "', 'open'); }"

    End Function

#End Region

End Class