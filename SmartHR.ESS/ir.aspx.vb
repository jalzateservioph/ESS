Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class ir
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing
    Private URL As String

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            If (Not IsNull(e.NewValues("IncidentTime"))) Then

                Dim dteIncidentDate As Date = e.NewValues("IncidentDate")
                Dim dteIncidentTime As Date = e.NewValues("IncidentTime")

                e.NewValues("IncidentDate") = New Date(dteIncidentDate.Year, dteIncidentDate.Month, dteIncidentDate.Day, dteIncidentTime.Hour, dteIncidentTime.Minute, dteIncidentTime.Second)

            End If

            e.NewValues("DisciplineReport") = GetExpControl(sender, "DisciplineReport", "Text")

        ElseIf (sender.Equals(dgView_002)) Then

            e.NewValues("GrievanceDetails") = GetExpControl(sender, "GrievanceDetails", "Text")

        ElseIf (sender.Equals(dgView_003)) Then

            e.NewValues("Follow_Up_Assistance") = GetExpControl(sender, "follow_up_assistance", "Checked")
            e.NewValues("Follow_Up_Internal_Training") = GetExpControl(sender, "follow_up_internal_training", "Checked")
            e.NewValues("Follow_Up_External_Training") = GetExpControl(sender, "follow_up_external_training", "Checked")
            e.NewValues("Follow_Up_Supervisor") = GetExpControl(sender, "follow_up_supervisor", "Checked")
            e.NewValues("Follow_Up_Formal_Discipline") = GetExpControl(sender, "follow_up_formal_discipline", "Checked")
            e.NewValues("Manager_Suggestions") = GetExpControl(sender, "manager_suggestions", "Text")
            e.NewValues("Employee_Suggestions") = GetExpControl(sender, "employee_suggestions", "Text")

        Else

            e.NewValues("Incident") = GetExpControl(sender, "incident", "Text")
            e.NewValues("Did_What") = GetExpControl(sender, "did_what", "Text")
            e.NewValues("Why_Wrong") = GetExpControl(sender, "why_wrong", "Text")
            e.NewValues("When_Had_To_Behave_Properly") = GetExpControl(sender, "when_had_to_behave_properly", "Text")

        End If

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        With UDetails

            Select Case tabIR.ActiveTabIndex

                Case 0
                    If (ClearCache) Then ClearFromCache("Data.IR.Discipline." & Session.SessionID)

                    LoadExpDS(dsOffenceCategory, "select [OffenceCatagory] from [OffenceLU] order by [OffenceCatagory]")

                    LoadExpDS(dsIncCategory, "select distinct [Category] from [Grievance] order by [Category]")

                    LoadExpDS(dsIncSubCategory, "select distinct [SubCategory] from [Grievance] order by [SubCategory]")

                    LoadExpDS(dsDisciplinaryAction, "select [DisciplinaryAction] from [DisciplineActionLU] order by [DisciplinaryAction]")

                    LoadExpDS(dsPeriod, "select distinct [Period] from [Discipline] order by [Period]")

                    LoadExpGrid(Session, dgView_001, "I.R. Tab", "<Tablename=Discipline><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [IncidentDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[IncidentDate], [IncidentDate] as [IncidentTime], [Manager], [OffenceCategory], [HearingDate], [HearingTime], [Category], [SubCategory], [DisciplinaryAction], [Period], [Cost], [EndDate], [FollowUpDate], [Resolved], [DisciplineReport]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "'" & IIf(GetArrayItem(UDetails.Template, "eIR.Discipline"), " and [EndDate] is null", String.Empty) & ")>", "Data.IR.Discipline." & Session.SessionID)

                Case 1
                    If (ClearCache) Then ClearFromCache("Data.IR.Conduct." & Session.SessionID)

                    LoadExpDS(dsWarningIssued, "select distinct [DisciplinaryAction] from [DisciplineActionLU] order by [DisciplinaryAction]")

                    LoadExpGrid(Session, dgView_004, "I.R. Tab", "<Tablename=Counselling_Conduct><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [fDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[fDate], [Manager], [Warning_Issued], [Follow_Up_Date], [Spoken_Before], [Spoken_Date], [Disciplinary_Hearing], [Incident], [Did_What], [Why_Wrong], [When_Had_To_Behave_Properly], [Status]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.IR.Conduct." & Session.SessionID)

                Case 2
                    If (ClearCache) Then ClearFromCache("Data.IR.Grievance." & Session.SessionID)

                    LoadExpDS(dsCategory, "select distinct [Category] from [Grievance] order by [Category]")

                    LoadExpDS(dsSubCategory, "select distinct [SubCategory] from [Grievance] order by [SubCategory]")

                    LoadExpGrid(Session, dgView_002, "I.R. Tab", "<Tablename=Grievance><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [GrievanceDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[GrievanceDate], [Manager], [Category], [SubCategory], [Cost], [GrievanceSolved], [GrievanceDetails]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.IR.Grievance." & Session.SessionID)

                Case 3
                    If (ClearCache) Then ClearFromCache("Data.IR.Performance." & Session.SessionID)

                    LoadExpDS(dsCategory, "select distinct [Category] from [Grievance] order by [Category]")

                    LoadExpDS(dsSubCategory, "select distinct [SubCategory] from [Grievance] order by [SubCategory]")

                    LoadExpGrid(Session, dgView_003, "I.R. Tab", "<Tablename=Counselling_Work_Performance><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [fDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[fDate], [Manager], [Follow_Up_Date], [Venue], [Reason_For_Counselling], [Follow_Up_Assistance], [Follow_Up_Internal_Training], [Follow_Up_External_Training], [Follow_Up_Supervisor], [Follow_Up_Formal_Discipline], [Manager_Suggestions], [Employee_Suggestions], [Status]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.IR.Performance." & Session.SessionID)

            End Select

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "I.R. Tab")

        LoadData()

    End Sub

    Private Sub dgView_003_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_003.CustomCallback, dgView_004.CustomCallback

        If (e.Parameters = "Submit") Then

            Dim bSaved As Boolean

            With UDetails

                If (sender.Equals(dgView_003)) Then

                    For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                        If (IsNull(sender.GetRowValues(iLoop, "Status")) OrElse Not sender.GetRowValues(iLoop, "Status") = "New") Then

                            bSaved = ExecSQL("update [Counselling_Work_Performance] set [Status] = 'New' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [fDate], 120) = '" & sender.GetRowValues(iLoop, "CompositeKey") & "')")

                            If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'IR', 'IR Performance', 'Start', 'Start', '" & Convert.ToDateTime(sender.GetRowValues(iLoop, "fDate")).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                            If (Not bSaved) Then Exit For

                        End If

                    Next

                Else

                    For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                        If (IsNull(sender.GetRowValues(iLoop, "Status")) OrElse Not sender.GetRowValues(iLoop, "Status") = "New") Then

                            bSaved = ExecSQL("update [Counselling_Conduct] set [Status] = 'New' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [fDate], 120) = '" & sender.GetRowValues(iLoop, "CompositeKey") & "')")

                            'If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'IR', 'IR Performance', 'Start', 'Start', '" & Convert.ToDateTime(sender.GetRowValues(iLoop, "fDate")).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                            If (Not bSaved) Then Exit For

                        End If

                    Next

                End If

            End With

            If (bSaved) Then

                URL = "tasks.aspx tools/index.aspx"

            Else

            End If

        End If

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties, dgView_004.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        If (IsNull(URL)) Then URL = String.Empty

        e.Properties("cpURL") = URL

    End Sub

    Private Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting, dgView_004.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=Discipline><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><IncidentDate=" & Convert.ToDateTime(e.Values("IncidentDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Counselling_Conduct><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><fDate=" & Convert.ToDateTime(e.Values("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=Grievance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><GrievanceDate=" & Convert.ToDateTime(e.Values("GrievanceDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        Else

            SQLAudit = "<Tablename=Counselling_Work_Performance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><fDate=" & Convert.ToDateTime(e.Values("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting, dgView_004.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=Discipline><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Counselling_Conduct><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=Grievance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        Else

            SQLAudit = "<Tablename=Counselling_Work_Performance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        End If

        If (sender.Equals(dgView_003) OrElse sender.Equals(dgView_004)) Then e.NewValues("Status") = "Unsubmitted"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating, dgView_004.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=Discipline><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><IncidentDate;2=" & Convert.ToDateTime(e.OldValues("IncidentDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Counselling_Conduct><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><fDate;2=" & Convert.ToDateTime(e.OldValues("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=Grievance><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><GrievanceDate;2=" & Convert.ToDateTime(e.OldValues("GrievanceDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        Else

            SQLAudit = "<Tablename=Counselling_Work_Performance><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><fDate;2=" & Convert.ToDateTime(e.OldValues("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating, dgView_004.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabIR.TabPages(tabIR.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabIR.TabPages(tabIR.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

                Select Case e.Item.Name

                    Case "mnuExp_CSV"
                        dgExports.WriteCsvToResponse(xFilePath)

                    Case "mnuExp_XLS"
                        dgExports.WriteXlsToResponse(xFilePath)

                    Case "mnuExp_XLSX"
                        dgExports.WriteXlsxToResponse(xFilePath)

                    Case "mnuExp_RTF"
                        dgExports.WriteRtfToResponse(xFilePath)

                    Case "mnuExp_PDF"
                        dgExports.WritePdfToResponse(xFilePath)

                End Select

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dgExports)) Then

                dgExports.Dispose()

                dgExports = Nothing

            End If

        End Try

    End Sub

#End Region

End Class