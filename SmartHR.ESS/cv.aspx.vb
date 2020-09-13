Imports System.Globalization
Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class cv
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function CalcDate(ByVal dteStart As Date, ByVal dteEnd As Object) As String

        If (IsDate(dteStart)) Then

            If (Not IsDate(dteEnd)) Then dteEnd = Today

            Dim YOS As Integer = Convert.ToInt32(DateDiff("m", dteStart, dteEnd) / 12)

            If (dteStart.AddMonths(YOS * 12) > dteEnd) Then YOS -= 1

            Dim MOS As Integer = Convert.ToInt32(DateDiff("m", dteStart, dteEnd) - (YOS * 12))

            If (dteStart.AddMonths((YOS * 12) + MOS) > dteEnd) Then MOS -= 1

            If (YOS < 0) Or (MOS < 0) Then

                Return "Invalid date intervals"

            Else

                Return YOS.ToString() & " yrs, " & MOS.ToString() & " mnths"

            End If

        Else

            Return "Invalid date intervals"

        End If

    End Function

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

            e.NewValues("SkillsAcquired") = GetExpControl(sender, "SkillsAcquired", "Text")

        ElseIf (sender.Equals(dgView_002)) Then

            e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

        End If

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (Not IsPostBack) Then Session("CV.LoadSub") = Nothing

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabCV.ActiveTabIndex

                Case 0
                    If (ClearCache) Then ClearFromCache("Data.CV.ExperienceOJT." & Session.SessionID)
                    If (ClearCache) Then ClearFromCache("Data.CV.ExperienceEMP." & Session.SessionID)

                    LoadExpDS(dsJobGrade, "select distinct [JobGrade] from [Experience] order by [JobGrade]")

                    LoadExpDS(dsJobTitle, "select distinct [JobTitle] from [Experience] order by [JobTitle]")

                    LoadExpGrid(Session, dgView_001, "CV Tab", "<Tablename=Experience><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [Company]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[StartDate], [EndDate], [Company], 0 as [Duration], [JobTitle], [Description], [SkillsAcquired], [OJTCompAddr], [OJTRespon], [JobGrade]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [JobGrade] = 'OJT')>", "Data.CV.ExperienceOJT." & Session.SessionID)

                    LoadExpGrid(Session, dgView_007, "CV Tab", "<Tablename=Experience><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [Company]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[StartDate], [EndDate], [Company], 0 as [Duration], [JobTitle], [Description], [SkillsAcquired], [CVHistoryReason], [CVHistorySalary]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [JobGrade] = 'EMP')>", "Data.CV.ExperienceEMP." & Session.SessionID)

                Case 1
                    If (ClearCache) Then

                        ClearFromCache("Data.CV.Qualification." & Session.SessionID)

                        ClearFromCache("Data.CV.Qualification.Subjects." & Session.SessionID)

                    End If

                    LoadExpDS(dsInstitution, "select distinct [Institution] from [Qualifications] order by [Institution]")

                    LoadExpDS(dsNQFLevel, "select [NQFLevel] from [CourseNQFLevelLU] order by [NQFLevel]")

                    LoadExpDS(dsQualification, "select distinct [Qualification] from [QualificationLU] order by [Qualification]")

                    LoadExpDS(dsSubject, "select distinct [Subject] from [ess.QSubjects] order by [Subject]")

                    If (IsNumeric(Session("CV.LoadSub"))) Then IsRowExpanded = dgView_002.IsRowExpanded(Session("CV.LoadSub"))

                    LoadExpGrid(Session, dgView_002, "CV Tab", "<Tablename=Qualifications><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [Qualification]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[StartDate], [Qualification], [DateObtained], [Institution], [Proof_Provided], [HighestQualification], [Description], [Course], [Awards]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.CV.Qualification." & Session.SessionID)

                    If (IsNumeric(Session("CV.LoadSub"))) Then

                        Dim iRowIndex As Integer = Session("CV.LoadSub")

                        If (IsRowExpanded) Then

                            Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                Dim StartDate As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "StartDate")).ToString("yyyy-MM-dd HH:mm:ss")

                                LoadExpGrid(Session, dgView, "CV Tab", "<Tablename=ess.QSubjects><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [Subject]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & StartDate & "'><Columns=[Subject], [MarkReceived], [Grading], [Grade]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StartDate] = '" & StartDate & "')>", "Data.CV.Qualification.Subjects." & Session.SessionID)

                            End If

                        End If

                    End If

                Case 2
                    If (ClearCache) Then ClearFromCache("Data.CV.Membership." & Session.SessionID)

                    LoadExpGrid(Session, dgView_003, "CV Tab", "<Tablename=ProfSoc><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ProfScoc]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[ProfScoc], [DateJoined], [MembershipNum], [Remarks], [RenewalDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.CV.Membership." & Session.SessionID)

                Case 3
                    If (ClearCache) Then ClearFromCache("Data.CV.Certification." & Session.SessionID)

                    LoadExpGrid(Session, dgView_005, "CV Tab", "<Tablename=License><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [LicenseCode]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[LicenseCode], [LICRate], [LICAcquisitionDate], [LICExpirationDate], [LICLicenseNo], [ExamDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.CV.Certification." & Session.SessionID)
                Case 4
                    If (ClearCache) Then ClearFromCache("Data.CV.Seminar." & Session.SessionID)

                    LoadExpGrid(Session, dgView_006, "CV Tab", "<Tablename=AdditionalCVInfo><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Description1]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Description1], [Date]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.CV.Seminar." & Session.SessionID)

            End Select

            Dim Editable As Boolean = True

            Editable = GetArrayItem(.Template, "eCurriculumVitae.OnTheJobTraining.Editable")

            If (Not Editable) AndAlso ((dgView_001.Columns("edit").Visible) Or (dgView_001.Columns("delete").Visible)) Then

                dgView_001.Columns("edit").Visible = Editable

                dgView_001.Columns("delete").Visible = Editable

                dgView_001.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            Editable = GetArrayItem(.Template, "eCurriculumVitae.EmploymentHistory.Editable")

            If (Not Editable) AndAlso ((dgView_007.Columns("edit").Visible) Or (dgView_007.Columns("delete").Visible)) Then

                dgView_007.Columns("edit").Visible = Editable

                dgView_007.Columns("delete").Visible = Editable

                dgView_007.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            Editable = GetArrayItem(.Template, "eCurriculumVitae.EducationalBackground.Editable")

            If (Not Editable) AndAlso ((dgView_002.Columns("edit").Visible) Or (dgView_002.Columns("delete").Visible)) Then

                dgView_002.Columns("edit").Visible = Editable

                dgView_002.Columns("delete").Visible = Editable

                dgView_002.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            Editable = GetArrayItem(.Template, "eCurriculumVitae.Certifications.Editable")

            If (Not Editable) AndAlso ((dgView_005.Columns("edit").Visible) Or (dgView_005.Columns("delete").Visible)) Then

                dgView_005.Columns("edit").Visible = Editable

                dgView_005.Columns("delete").Visible = Editable

                dgView_005.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            Editable = GetArrayItem(.Template, "eCurriculumVitae.Seminars.Editable")

            If (Not Editable) AndAlso ((dgView_006.Columns("edit").Visible) Or (dgView_006.Columns("delete").Visible)) Then

                dgView_006.Columns("edit").Visible = Editable

                dgView_006.Columns("delete").Visible = Editable

                dgView_006.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            Editable = GetArrayItem(.Template, "eCurriculumVitae.OrganizationalAffiliations.Editable")

            If (Not Editable) AndAlso ((dgView_003.Columns("edit").Visible) Or (dgView_003.Columns("delete").Visible)) Then

                dgView_003.Columns("edit").Visible = Editable

                dgView_003.Columns("delete").Visible = Editable

                dgView_003.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

            End If

            panel_001.Visible = GetArrayItem(.Template, "eCurriculumVitae.OnTheJobTraining")

            pcSpace_001.Visible = panel_001.Visible

            panel_007.Visible = GetArrayItem(.Template, "eCurriculumVitae.EmploymentHistory")

            pcSpace_007.Visible = panel_007.Visible

            panel_002.Visible = GetArrayItem(.Template, "eCurriculumVitae.EducationalBackground")

            pcSpace_002.Visible = panel_002.Visible

            panel_005.Visible = GetArrayItem(.Template, "eCurriculumVitae.Certifications")

            pcSpace_005.Visible = panel_005.Visible
            'amanriza 05/31/219
            'changed keyname
            Panel_006.Visible = GetArrayItem(.Template, "eCurriculumVitae.SeminarsAndTraining")
            'amanriza end
            pcSpace_006.Visible = Panel_006.Visible

            Panel_003.Visible = GetArrayItem(.Template, "eCurriculumVitae.OrganizationalAffiliations")

            pcSpace_003.Visible = Panel_003.Visible

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

        UDetails = GetUserDetails(Session, "CV Tab")

        LoadData()

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Private Sub dgView_001_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_001.CustomColumnDisplayText, dgView_007.CustomColumnDisplayText

        If (e.Column.FieldName = "Duration") Then

            If (IsDate(e.GetFieldValue("StartDate"))) Then e.DisplayText = CalcDate(e.GetFieldValue("StartDate"), e.GetFieldValue("EndDate"))

        End If

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties, dgView_005.CustomJSProperties, dgView_006.CustomJSProperties, dgView_007.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

    End Sub

    Private Sub dgView_002_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowEventArgs) Handles dgView_002.DetailRowExpandedChanged

        If (e.Expanded) Then

            ClearFromCache("Data.CV.Qualification.Subjects." & Session.SessionID)

            Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

            If (Not IsNull(dgView)) Then

                With UDetails

                    Dim StartDate As String = Convert.ToDateTime(dgView_002.GetRowValues(e.VisibleIndex, "StartDate")).ToString("yyyy-MM-dd HH:mm:ss")

                    LoadExpGrid(Session, dgView, "CV Tab", "<Tablename=ess.QSubjects><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [Subject]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & StartDate & "'><Columns=[Subject], [MarkReceived], [Grading], [Grade]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [StartDate] = '" & StartDate & "')>", "Data.CV.Qualification.Subjects." & Session.SessionID)

                End With

            End If

            Session("CV.LoadSub") = e.VisibleIndex

        ElseIf (IsNumeric(Session("CV.LoadSub"))) Then

            Session.Remove("CV.LoadSub")

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting, dgView_005.RowDeleting, dgView_006.RowDeleting, dgView_007.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=Experience><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><StartDate=" & Convert.ToDateTime(e.Values("IncidentDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><Company=" & e.Values("Company").ToString() & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Qualifications><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><StartDate=" & Convert.ToDateTime(e.Values("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><Qualification=" & e.Values("Qualification").ToString() & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=ProfSoc><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><ProfScoc=" & e.Values("ProfScoc").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_004") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting, dgView_005.RowInserting, dgView_006.RowInserting, dgView_007.RowInserting

        'amanriza 05/31/2019
        'added a validation for start and end date.
        Dim StartDate As DateTime = Convert.ToDateTime(e.NewValues("StartDate"))


        Dim EndDate As DateTime = Convert.ToDateTime(e.NewValues("EndDate"))

        If StartDate.Date > EndDate.Date Then
            Throw New Exception("Start date cannot be later than the end date")
        End If

        'amanriza end
        Dim SQLAudit As String = String.Empty

        'amanriza 06/27/2019 
        'Changed the way of creating an insert query for OJT and Employment history.
        If (sender.Equals(dgView_001) Or sender.Equals(dgView_007)) Then



            Dim _jobgrade = Nothing, _company = e.NewValues("Company"), _description = e.NewValues("Description"), _skillsacq = e.NewValues("SkillsAcquired"),
                _reason4leaving = Nothing, _jobtitle = Nothing, _salary = Nothing, _ojtrespon = Nothing, _ojtcompaddr = Nothing

            If (sender.Equals(dgView_007)) Then

                _jobgrade = "EMP"
                _reason4leaving = e.NewValues("CVHistoryReason")
                _jobtitle = e.NewValues("JobTitle")
                _salary = e.NewValues("CVHistorySalary")

            Else

                _jobgrade = "OJT"
                _ojtcompaddr = e.NewValues("OJTCompAddr")
                _ojtrespon = e.NewValues("OJTRespon")

            End If

            'SQLAudit = "<Tablename=Experience><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

            Dim SQLQuery = String.Format("INSERT INTO[Experience]([CompanyNum],[EmployeeNum],[StartDate],[EndDate],[JobTitle],[Company],[OJTCompAddr],[OJTRespon],[CVHistoryReason],[CVHistorySalary],[Description],[SkillsAcquired],[JobGrade]) " +
                                         "VALUES('{0}','{1}', {2},'{3}','{4}','{5}','{6}','{7}', '{8}','{9}', '{10}', '{11}', '{12}');" +
                                         "", UDetails.CompanyNum, UDetails.EmployeeNum, StartDate.ToString("yyyy-MM-dd"), EndDate.ToString("yyyy-MM-dd"), _jobtitle, _company, _ojtcompaddr, _ojtrespon, _reason4leaving,
                                         _salary, _description, _skillsacq, _jobgrade)

            e.Cancel = ExecSQL(SQLQuery)

            'amanriza end

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Qualifications><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=ProfSoc><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_005)) Then

            SQLAudit = "<Tablename=License><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

            ExecQuery("IF NOT EXISTS (SELECT * FROM License WHERE LicenseCode = '" & e.NewValues("LicenseCode") & "') INSERT INTO LicenseLU VALUES ('" & e.NewValues("LicenseCode") & "','" & e.NewValues("LicenseCode") & "')")

        ElseIf (sender.Equals(dgView_006)) Then

            SQLAudit = "<Tablename=AdditionalCVInfo><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        End If

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004")) Then

            e.Cancel = True

            Exit Sub

        End If

        '27/06/2019 amanriza
        'Changed the way of creating an insert query for OJT and Employment history
        If (Not sender.Equals(dgView_001) AndAlso Not sender.Equals(dgView_007)) Then

            GetExpValues(sender, e)

            e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))
        End If

        'GetExpValues(sender, e)

        'e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        'amanriza end

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating, dgView_005.RowUpdating, dgView_006.RowUpdating, dgView_007.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=Experience><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><StartDate;2=" & Convert.ToDateTime(e.OldValues("IncidentDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><Company;3=" & e.OldValues("Company").ToString() & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=Qualifications><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><StartDate;2=" & Convert.ToDateTime(e.OldValues("fDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><Qualification;3=" & e.OldValues("Qualification").ToString() & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=ProfSoc><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><ProfScoc;2=" & e.OldValues("ProfScoc").ToString() & ">"

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating, dgView_005.RowValidating, dgView_006.RowValidating, dgView_007.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabCV.TabPages(tabCV.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabCV.TabPages(tabCV.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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