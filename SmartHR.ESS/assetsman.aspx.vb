Public Partial Class assetsman
    Inherits System.Web.UI.Page

    Private bCancel As Boolean
    Private PathID As String = String.Empty
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        UDetails = GetUserDetails(Session, "Stores/Loans Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlAssets.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Asset " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadExpDS(dsItemCode, "select distinct [ItemCode], [ItemDescription] from [StoresItems] where ([CompanyNum] = '" & .CompanyNum & "') order by [ItemDescription]")

            LoadExpGrid(Session, dgView, "Stores/Loans Tab", "<Tablename=StoreIssued><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ItemCode] + ' ' + convert(nvarchar(19), [IssueDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[ItemCode], [IssueDate], [Quantity], [ReturnDate], [Reference], [Remarks]><Where=([PathID] = " & PathID & ")>")

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim bSaved As Boolean

        Dim PathData As String = GetPathData(PathID)

        bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Stores', '" & IIf(Not bCancel, "Stores", "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

        If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

    End Sub

#End Region

End Class