Public Class irman_001
    Inherits System.Web.UI.Page

    Private PathID As String = String.Empty
    Private ShowRemarks As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "I.R. Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlIR.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "IR Performance Acceptance: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadExpGrid(Session, dgView, "I.R. Tab", "<Tablename=Counselling_Work_Performance><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [fDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[fDate], [Manager], [Follow_Up_Date], [Venue], [Reason_For_Counselling], [Follow_Up_Assistance], [Follow_Up_Internal_Training], [Follow_Up_External_Training], [Follow_Up_Supervisor], [Follow_Up_Formal_Discipline], [Manager_Suggestions], [Employee_Suggestions], [Status]><Where=([PathID] = " & PathID & ")>", "Data.IR.Performance." & Session.SessionID)

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        Dim bSaved As Boolean

        Dim PathData As String = GetPathData(PathID)

        If (Values(0) = "Approve") Then

            Dim dteDate() As Date = {Nothing, Nothing}

            DateTime.TryParse(Values(2), dteDate(0))

            If (Not IsDate(dteDate)) Then dteDate(0) = Now

            DateTime.TryParse(Values(4), dteDate(1))

            If (Not IsDate(dteDate)) Then dteDate(1) = Now

            bSaved = ExecSQL("insert into [Counselling_Work_Performance]([CompanyNum], [EmployeeNum], [fDate], [Manager], [Follow_Up_Date], [Venue], [Reason_For_Counselling], [Manager_Suggestions], [Employee_Suggestions], [Status]) values('" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', '" & dteDate(0).ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(3)) & "', '" & dteDate(1).ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(5)) & "', " & GetNullText(Values(6)) & ", " & GetNullText(Values(7)) & ", " & GetNullText(Values(8)) & ", 'New')")

            If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', 0, 'IR', 'IR Performance', 'Start', 'Start', '" & dteDate(0).ToString("yyyy-MM-dd HH:mm:ss") & "'")

            ClearFromCache("Data.IR.Performance." & Session.SessionID)

        End If

        bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'IR', 'IR Performance', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

        If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpEmpRemarks") = txtRemarks_Employee.Text

        e.Properties("cpManRemarks") = txtRemarks_Manager.Text

        e.Properties("cpShowPopup") = ShowRemarks

    End Sub

    Private Sub dgView_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView.CustomButtonCallback

        If (e.ButtonID = "Select") Then

            If (Not IsNull(dgView.GetRowValues(e.VisibleIndex, "Employee_Suggestions"))) Then

                txtRemarks_Employee.Text = dgView.GetRowValues(e.VisibleIndex, "Employee_Suggestions").ToString()

            Else

                txtRemarks_Employee.Text = String.Empty

            End If

            If (Not IsNull(dgView.GetRowValues(e.VisibleIndex, "Manager_Suggestions"))) Then

                txtRemarks_Manager.Text = dgView.GetRowValues(e.VisibleIndex, "Manager_Suggestions").ToString()

            Else

                txtRemarks_Manager.Text = String.Empty

            End If

            ShowRemarks = True

        End If

    End Sub

#End Region

End Class