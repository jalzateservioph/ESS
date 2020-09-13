Imports DevExpress.Web.ASPxEditors

Partial Public Class notify
    Inherits System.Web.UI.Page

    Private PathID As String = String.Empty
    Private UDetails As Users = Nothing

    Private ValidatedText As String

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsNull(Request.QueryString("ID"))) Then

            PathID = Request.QueryString("ID").ToString()

            UDetails = GetUserDetails(Session, "Notify Admin", True)

        Else

            If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

            UDetails = GetUserDetails(Session, "Notify Admin")

        End If

        If (Not IsPostBack) Then

            With UDetails

                Dim lblPanel As ASPxLabel = pnlNotify.FindControl("lblPanel")

                If (Not IsNull(lblPanel)) Then

                    If (String.IsNullOrEmpty(PathID)) Then

                        txtSubject.Focus()

                    Else

                        Dim HtmlBody As String = String.Empty

                        CType(pnlNotify.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Notifications: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

                        Dim dtNotify As DataTable = GetSQLDT("select " & GetDisplayText("<%PreferredName%>, <%Surname%>") & " as [Text], [DateNotified], [Subject], [Description] from [ess.NotifyHR] as [n] left outer join [Personnel] as [e] on [n].[CompanyNum] = [e].[CompanyNum] and [n].[EmployeeNum] = [e].[EmployeeNum] where ([n].[PathID] = " & PathID & ")")

                        If (IsData(dtNotify)) Then

                            Dim SentDate As Date = dtNotify.Rows(0).Item("DateNotified")

                            txtSubject.Text = "RE: " & dtNotify.Rows(0).Item("Subject").ToString()

                            HtmlBody = "Dear " & dtNotify.Rows(0).Item("Text").ToString() & "<br /><br />Regards,<br />" & Session("LoggedOn").Name & " " & Session("LoggedOn").Surname & "<br /><br /><hr />"

                            HtmlBody &= "<table style=""font: 9pt Tahoma; margin: 0px; padding: 0px; width: 100%"">"

                            HtmlBody &= "<tr>"

                            HtmlBody &= "<td style=""text-align: right; width: 75px""><strong>From</strong></td><td style=""width: 10px""></td><td style=""text-align: left"">" & dtNotify.Rows(0).Item("Text").ToString() & "&nbsp;[mailto:" & .Email & "]</td>"

                            HtmlBody &= "</tr><tr>"

                            HtmlBody &= "<td style=""text-align: right; width: 75px""><strong>Sent</strong></td><td style=""width: 10px""></td><td style=""text-align: left"">" & SentDate.ToString(GetArrayItem(.Template, "eGeneral.DateFormat"))

                            HtmlBody &= "</tr><tr>"

                            HtmlBody &= "<td style=""text-align: right; width: 75px""><strong>Subject</strong></td><td style=""width: 10px""></td><td style=""text-align: left"">" & dtNotify.Rows(0).Item("Subject").ToString() & "</td>"

                            HtmlBody &= "</tr></table><br />"

                            HtmlBody &= dtNotify.Rows(0).Item("Description").ToString()

                            heBody.Html = HtmlBody

                            dtNotify.Dispose()

                        End If

                        dtNotify = Nothing

                        heBody.Focus()

                    End If

                End If

            End With

        End If

        With UDetails

            If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Notify", "Notify", ValidatedText) AndAlso Not IsPostBack) Then

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.ShowPopup('" & ReplaceJavaText(ValidatedText) & "'); }"

            Else

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }"

            End If

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Body As String = heBody.Html

        Body = Body.Replace(Request.UrlReferrer.Scheme & Uri.SchemeDelimiter & Request.UrlReferrer.Authority & "/", String.Empty)

        Dim SQL() As String = {String.Empty, String.Empty}

        Dim DateNotified As String = Now.ToString("yyyy-MM-dd HH:mm:ss")

        With UDetails

            If (IsNull(PathID) OrElse Not IsNumeric(PathID)) Then

                SQL(0) = "insert into [ess.NotifyHR]([CompanyNum], [EmployeeNum], [DateNotified], [Subject], [Description], [Status]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & DateNotified & "', '" & GetDataText(txtSubject.Text) & "', '" & GetDataText(Body) & "', 'New')"

                SQL(1) = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Notify', 'Notify', 'Start', 'Start', '" & DateNotified & "'"

            Else

                Dim PathData As String = GetPathData(PathID)

                SQL(0) = "update [ess.NotifyHR] set [Subject] = '" & GetDataText(txtSubject.Text) & "', [Description] = '" & GetDataText(Body) & "' where ([PathID] = " & PathID & ")"

                SQL(1) = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', " & PathID & ", 'Notify', 'Notify', '" & GetXML(PathData, KeyName:="StatusType") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & DateNotified & "'"

                ExecSQL("update [ess.NotifyHR] set [Reply] = [Description] where [PathID] = " & PathID)

            End If

            If (ExecSQL(SQL(0))) Then

                If (ExecSQL(SQL(1))) Then e.Result = "tasks.aspx tools/index.aspx"

            End If

        End With

    End Sub

#End Region

End Class