Public Partial Class staff
    Inherits System.Web.UI.Page

    Private dteFrom As Date
    Private dteUntil As Date
    Private HeaderData As HtmlTable
    Private Saved() As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        UDetails = GetUserDetails(Session, "Staff Locator")

        With UDetails

            If (Not IsPostBack) Then

                deFrom.Date = Today.Date

                deUntil.Date = deFrom.Date.AddDays(14)

                values.Set("DateFrom", deFrom.Date)

                values.Set("DateUntil", deUntil.Date)

                values.Set("DateRange", cmbCategory.SelectedIndex)

                values.Set("Category", cmbDateRange.SelectedIndex)

            Else

                deFrom.Date = values.Get("DateFrom")

                deUntil.Date = values.Get("DateUntil")

                cmbDateRange.SelectedIndex = values.Get("DateRange")

                cmbCategory.SelectedIndex = values.Get("Category")

            End If

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpPage.Callback

        Dim SQLTypes As String = String.Empty

        Dim SQLStatus As String = String.Empty

        Dim Selected() As String = {String.Empty, String.Empty}

        If (IsString(cmbType.Value)) Then Selected(0) = cmbType.Value

        If (IsString(cmbStatus.Value)) Then Selected(1) = cmbStatus.Value

        Dim Values() As String = e.Parameter.Split(" ")

        If (Values(0) = "Back") Then

            pnlFilter.Visible = True

            pnlResults.Visible = False

        ElseIf (Values(0) = "Submit") Then

            HeaderData = New HtmlTable

            HeaderData.Attributes.Add("class", "dgHeader")

            HeaderData.Style.Add("width", "100%")

            HeaderData.CellPadding = 0

            HeaderData.CellSpacing = 0

            Saved = New String() {"Employee", "Type", "Status", Selected(0), Selected(1)}

            With deFrom.Date

                dteFrom = New Date(.Year, .Month, .Day, 0, 0, 0)

            End With

            With deUntil.Date

                Select Case cmbDateRange.Value

                    Case "0"
                        dteUntil = dteFrom.AddDays(14).AddHours(23).AddMinutes(59).AddSeconds(59)

                    Case "1"
                        dteUntil = dteFrom.AddMonths(1).AddHours(23).AddMinutes(59).AddSeconds(59)

                    Case "2"
                        dteUntil = dteFrom.AddMonths(2).AddHours(23).AddMinutes(59).AddSeconds(59)

                    Case "3"
                        dteUntil = New Date(.Year, .Month, .Day, 23, 59, 59)

                End Select

            End With

            With UDetails

                If (cmbCategory.Value = "0") Then

                    If (Not GetArrayItem(.Template, "eLeave.StaffOnLeave")) Then

                        rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[EndDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Employee], [l].[LeaveType] as [Type], [l].[LeaveStatus] as [Status], [l].[Duration] as [Duration] from [Leave] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where (" & If(IsString(Selected(0)), "[l].[LeaveType] = '" & Selected(0) & "' and ", String.Empty) & If(IsString(Selected(1)), "[l].[LeaveStatus] = '" & Selected(1) & "' and ", String.Empty) & "[ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

                        SQLTypes = "select distinct [l].[LeaveType] as [Type] from [Leave] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Type]"

                        SQLStatus = "select distinct [l].[LeaveStatus] as [Status] from [Leave] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Status]"

                    Else

                        Dim UserGroup As String = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

                        If (Not IsNull(UserGroup)) Then

                            rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[EndDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")).Replace("[e].", "[emp].").Replace("[c].", "[comp].") & " as [Employee], [l].[LeaveType] as [Type], [l].[LeaveStatus] as [Status], [l].[Duration] as [Duration] from [Leave] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where (" & If(IsString(Selected(0)), "[l].[LeaveType] = '" & Selected(0) & "' and ", String.Empty) & If(IsString(Selected(1)), "[l].[LeaveStatus] = '" & Selected(1) & "' and ", String.Empty) & "[l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

                            SQLTypes = "select distinct [l].[LeaveType] as [Type] from [Leave] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Type]"

                            SQLStatus = "select distinct [l].[LeaveStatus] as [Status] from [Leave] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Status]"

                        End If

                    End If

                ElseIf (cmbCategory.Value = "1") Then

                    If (Not GetArrayItem(.Template, "eTraining.StaffOnTraining")) Then

                        rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[CompletionDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Employee], [l].[CourseName] as [Type], [l].[TrainingStatus] as [Status], [l].[Duration] as [Duration] from [TrainingPlanned] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where (" & If(IsString(Selected(0)), "[l].[CourseName] = '" & Selected(0) & "' and ", String.Empty) & If(IsString(Selected(1)), "[l].[TrainingStatus] = '" & Selected(1) & "' and ", String.Empty) & "[ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

                        SQLTypes = "select distinct [l].[CourseName] as [Type] from [TrainingPlanned] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Type]"

                        SQLStatus = "select distinct [l].[TrainingStatus] as [Status] from [TrainingPlanned] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Status]"

                    Else

                        Dim UserGroup As String = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

                        If (Not IsNull(UserGroup)) Then

                            rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[CompletionDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")).Replace("[e].", "[emp].").Replace("[c].", "[comp].") & " as [Employee], [l].[CourseName] as [Type], [l].[TrainingStatus] as [Status], [l].[Duration] as [Duration] from [TrainingPlanned] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where (" & If(IsString(Selected(0)), "[l].[CourseName] = '" & Selected(0) & "' and ", String.Empty) & If(IsString(Selected(1)), "[l].[TrainingStatus] = '" & Selected(1) & "' and ", String.Empty) & "[l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

                            SQLTypes = "select distinct [l].[CourseName] as [Type] from [TrainingPlanned] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Type]"

                            SQLStatus = "select distinct [l].[TrainingStatus] as [Status] from [TrainingPlanned] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[CompletionDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[CompletionDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [Status]"

                        End If

                    End If

                End If

            End With

            If (IsData(rptItems.DataSource)) Then

                pnlNoData.Visible = False

                pnlData.Visible = True

            Else

                pnlNoData.Visible = True

                pnlData.Visible = False

            End If

            rptItems.DataBind()

            pnlFilter.Visible = False

            pnlResults.Visible = True

            LoadExpDS(dsTypes, SQLTypes)

            LoadExpDS(dsStatus, SQLStatus)

        End If

    End Sub

    Private Sub rptItems_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptItems.ItemDataBound

        If (e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem) Then GenerateGrid(sender, e, HeaderData, dteFrom, dteUntil, Saved)

    End Sub

#End Region

End Class