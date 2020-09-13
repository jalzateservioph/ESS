Public Partial Class loansman
    Inherits System.Web.UI.Page

    Private bCancel As Boolean
    Private PathID As String = String.Empty
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        UDetails = GetUserDetails(Session, "Stores/Loans Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlLoans.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Loan " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadExpDS(dsDescription, "select distinct [Description] from [Loan] order by [Description]")

            LoadExpGrid(Session, dgView, "Stores/Loans Tab", "<Tablename=Loan><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [LoanDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[LoanDate], [Amount], [Term], [IntRate], [Amount_Paid], [NotificationDate], [FirstInstallment], [Description], [Remarks]><Where=([PathID] = " & PathID & ")>")

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()
        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        Dim bSaved As Boolean

        Dim PathData As String = GetPathData(PathID)

        bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Loans', '" & IIf(Not bCancel, "Loans", "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

        If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

    End Sub

#End Region

End Class