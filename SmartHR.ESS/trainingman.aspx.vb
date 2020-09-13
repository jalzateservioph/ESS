Partial Public Class trainingman
    Inherits System.Web.UI.Page

    Private ButtonID As String

    Private bCancel As Boolean
    Private PathID As String
    Private UDetails As Users = Nothing

    Private dteFrom As Date
    Private dteUntil As Date
    Private HeaderData As HtmlTable
    Private Saved() As String
    Private ShowRemarks As String

    Private dteAppStart As Date
    Private dteAppUntil As Date

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        If (Not IsPostBack) Then

            UDetails = GetUserDetails(Session, "Training Tab", True)

            With UDetails

                CType(pnlTraining.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Training " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        UDetails = GetUserDetails(Session, "Training Tab")

        LoadExpGrid(Session, dgView, "Training Tab", "<Tablename=TrainingPlanned><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [CourseName] + ' ' + [ProviderName] + ' ' + convert(nvarchar(19), [StartDate], 120)><Columns=[CourseName], [StartDate], [CompletionDate], [Duration], [TrainingStatus], [CapturedByUsername], [Description], [PathID], [DurationType]><Where=([PathID] = " & PathID & ")>")

        'dgView.SettingsText.Title = "<Required=[CompanyNum][EmployeeNum][StartDate][ProviderName][CourseName]>"

        'LoadExpGrid(
        '    Session, dgView, "Training Tab",
        '    "<CustomSelectQuery=" +
        '    "Select " +
        '    "tp.[CourseName], " +
        '    "tp.[StartDate], " +
        '    "tp.[CompletionDate], " +
        '    "tp.[Duration], " +
        '    "tp.[TrainingStatus], " +
        '    "tp.[CapturedByUsername], " +
        '    "tp.[Description], " +
        '    "tp.[PathID], " +
        '    "tp.[DurationType] " +
        '    "FROM TrainingPlanned tp " +
        '    "WHERE tp.[PathID] = '" & PathID & "' " +
        '    ">", "Data.Training.TrainingCurriculum." & Session.SessionID)

        With GetUserDetails(Session, "Staff Locator")

            HeaderData = New HtmlTable

            HeaderData.Attributes.Add("class", "dgHeader")

            HeaderData.Style.Add("width", "100%")

            HeaderData.CellPadding = 0

            HeaderData.CellSpacing = 0

            Saved = New String() {"Employee", "Type"}

            If (Not GetArrayItem(.Template, "eTraining.StaffOnTraining")) Then

                rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[CompletionDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Employee], [l].[CourseName] as [Type], [l].[TrainingStatus] as [Status], [l].[Duration] as [Duration] from [TrainingPlanned] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

            Else

                Dim UserGroup As String = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

                If (Not IsNull(UserGroup)) Then rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[CompletionDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")).Replace("[e].", "[emp].").Replace("[c].", "[comp].") & " as [Employee], [l].[CourseName] as [Type], [l].[TrainingStatus] as [Status], [l].[Duration] as [Duration] from [TrainingPlanned] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

            End If

            rptItems.DataBind()

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        Dim ErrorText As String = SUCCESS

        Dim bSaved As Boolean

        Dim origCompanyNum As String = ""
        Dim origEmployeeNum As String = ""

        Using dtPath As DataTable = GetSQLDT("SELECT OriginatorCompanyNum, OriginatorEmployeeNum FROM [ess.Path] WHERE [ID] = '" & PathID & "'")

            With dtPath.Rows(0)

                origCompanyNum = .Item("OriginatorCompanyNum").ToString()
                origEmployeeNum = .Item("OriginatorEmployeeNum").ToString()

            End With

            dtPath.Clear()

        End Using

        If origCompanyNum <> "" AndAlso origEmployeeNum <> "" Then

            Dim PathData As String = GetPathData(PathID)

            bSaved = ExecSQL("exec [ess.WFProc] '" & origCompanyNum & "', '" & origEmployeeNum & "', '" & origCompanyNum & "', '" & origEmployeeNum & "', " & PathID & ", 'Training', '" & IIf(Not bCancel, "Training", "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

            If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        Else

            bSaved = True

        End If

        If (bSaved) Then

            ErrorText = "tasks.aspx tools/index.aspx"

        End If

        e.Result = Values(0) & " " & ErrorText

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpShow") = ShowRemarks

        e.Properties("cpRemarks") = txtRemarks_History.Text

    End Sub

    Private Sub dgView_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView.CustomButtonCallback

        ButtonID = e.ButtonID

        If (e.ButtonID = "Select") Then

            If (IsNumeric(sender.GetRowValues(e.VisibleIndex, "PathID"))) Then txtRemarks_History.Text = GetRemarks(UDetails.Template, PathID, txtRemarks_History.Text)

            ShowRemarks = True

        ElseIf (e.ButtonID = "Balance") Then

            ShowRemarks = True

        End If

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound

        If (Date.TryParse(sender.GetRowValues(0, "StartDate"), dteAppStart)) Then

            dteFrom = dteAppStart.AddDays(-7)

        Else

            dteFrom = Now

        End If

        dteFrom = New Date(dteFrom.Year, dteFrom.Month, dteFrom.Day, 0, 0, 0)

        If (Date.TryParse(sender.GetRowValues(0, "EndDate"), dteAppUntil)) Then

            dteUntil = dteAppUntil.AddDays(7)

        Else

            dteUntil = dteFrom.AddDays(14)

        End If

        dteUntil = New Date(dteUntil.Year, dteUntil.Month, dteUntil.Day, 23, 59, 59)

    End Sub

    Private Sub rptItems_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptItems.ItemDataBound

        If (e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem) Then GenerateGrid(sender, e, HeaderData, dteFrom, dteUntil, Saved)

    End Sub

#End Region

End Class
