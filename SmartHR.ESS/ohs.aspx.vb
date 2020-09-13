Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class ohs
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            e.NewValues("TypeCode") = GetExpControl(sender, "TypeCode", "Value")

            e.NewValues("Cause") = GetExpControl(sender, "Cause", "Value")

            e.NewValues("BreakdownAgency") = GetExpControl(sender, "BreakdownAgency", "Value")

            e.NewValues("Location") = GetExpControl(sender, "Location", "Value")

            e.NewValues("Witness") = GetExpControl(sender, "Witness", "Text")

            e.NewValues("ItemObject") = GetExpControl(sender, "ItemObject", "Value")

            e.NewValues("TypeDescription") = GetExpControl(sender, "TypeDescription", "Text")

            e.NewValues("WorkplacePart") = GetExpControl(sender, "WorkplacePart", "Text")

            e.NewValues("WorkerAction") = GetExpControl(sender, "WorkerAction", "Text")

            e.NewValues("WhatHappened") = GetExpControl(sender, "WhatHappened", "Text")

            e.NewValues("ProcedureFollowed") = GetExpControl(sender, "ProcedureFollowed", "Text")

        ElseIf (sender.Equals(dgView_003)) Then

            e.NewValues("Cause") = GetExpControl(sender, "Cause", "Text")

        ElseIf (sender.ID.ToString().Contains("_005")) Then

            e.NewValues("NoteText") = GetExpControl(sender, "NoteText", "Text")

        End If

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (Not IsPostBack) Then

            Session("OHS.Incidents.LoadSub") = Nothing

            Session("OHS.Surveillance.LoadSub") = Nothing

            Session("OHS.Consultations.LoadSub") = Nothing

        End If

        LoadExpDS(dsClassification, "select [HSClassification] from [HSClassificationLU] order by [HSClassification]")

        LoadExpDS(dsBodilyLocation, "select [BodilyLocation] from [HSBodilyLocationLU] order by [BodilyLocation]")

        Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabOHS.ActiveTabIndex

                Case 0
                    If (ClearCache) Then

                        ClearFromCache("Data.OHS.Incidents." & Session.SessionID)

                        ClearFromCache("Data.OHS.Incidents.Body." & Session.SessionID)

                        ClearFromCache("Data.OHS.Incidents.Notes." & Session.SessionID)

                    End If

                    LoadExpDS(dsIncSubClassification, "select distinct [SubClassification] from [HSDetails] order by [SubClassification]")

                    LoadExpDS(dsConSubSubClassification, "select distinct [SubSubClassification] from [HSDetails] order by [SubSubClassification]")

                    LoadExpDS(dsConHSOccupational, "select [HSOccupational] from [HSOccupationalLU] order by [HSOccupational]")

                    LoadExpDS(dsConTypeCode, "select [TypeCode] from [HSDetailsTypeLU] order by [TypeCode]")

                    LoadExpDS(dsConBreakdownAgency, "select [BreakdownAgency] from [HSBreakdownAgencyLU] order by [BreakdownAgency]")

                    LoadExpDS(dsConLocation, "select [Location] from [LocationLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [Location]")

                    LoadExpDS(dsConItemObject, "select distinct [ItemObject] from [HSDetails] order by [ItemObject]")

                    LoadExpDS(dsIncNoteType, "select distinct [NoteType] from [HSDetailsNotes] order by [NoteType]")

                    LoadExpDS(dsConCause, "select [Cause] from [HSCauseLU] order by [Cause]")

                    If (IsNumeric(Session("OHS.Incidents.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("OHS.Incidents.LoadSub"))

                    LoadExpGrid(Session, dgView_001, "Occup. Health & Safety Tab", "<Tablename=HSDetails><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateOccurred], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[DateOccurred], [DateReported], [FilledInBy], [FilledInByJobTitle], [ReportedTo], [ReportedToJobTitle], [MultipleClassification], [Confirmed], [HSClassification], [SubClassification], [RefNo], [DateNotifEmp], [SubSubClassification], [HSOccupational], [RelatedToHazard], [TypeCode], [Cause], [BreakdownAgency], [Location], [Witness], [ItemObject], [TypeDescription], [WorkplacePart], [WorkerAction], [WhatHappened], [ProcedureFollowed]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.OHS.Incidents." & Session.SessionID)

                    If (IsNumeric(Session("OHS.Incidents.LoadSub"))) Then

                        iRowIndex = Session("OHS.Incidents.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "pageControl_001"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            Dim DateOccurred As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss")

                            If (Not IsNull(dgView)) Then

                                LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HSDetailsBodilyLocation><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateOccurred], 120) + ' ' + [BodilyLocation]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & DateOccurred & "'><Columns=[BodilyLocation], [Description]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [DateOccurred] = '" & DateOccurred & "')>", "Data.OHS.Incidents.Body." & Session.SessionID)

                                dgView = Nothing

                            End If

                            dgView = TryCast(TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "pageControl_001"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_005"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HSDetailsNotes><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateOccurred], 120) + ' ' + convert(nvarchar(19), [NoteDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & DateOccurred & "'><Columns=[NoteDate], [NoteType], [ContactName], [AttendedBy], [FollowUpDate], [NoteText]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [DateOccurred] = '" & DateOccurred & "')>", "Data.OHS.Incidents.Notes." & Session.SessionID)

                        End If

                    End If

                Case 1
                    If (ClearCache) Then

                        ClearFromCache("Data.OHS.Surveillance." & Session.SessionID)

                        ClearFromCache("Data.OHS.Surveillance.Tests." & Session.SessionID)

                    End If

                    LoadExpDS(dsMedTestName, "select [TestName] from [HCMedTestLU] order by [TestName]")

                    LoadExpDS(dsMedPerformedBy, "select distinct [PerformedBy] from [HCMedSurveillance] order by [PerformedBy]")

                    LoadExpDS(dsMedPerformedByContact, "select distinct [PerformedByContact] from [HCMedSurveillance] order by [PerformedByContact]")

                    LoadExpDS(dsMedActualValue, "select distinct [ActualValue] from [HCMedSurveillanceTestResult] order by [ActualValue]")

                    LoadExpDS(dsMedUnitOfMeassure, "select distinct [UnitOfMeassure] from [HCMedSurveillanceTestResult] order by [UnitOfMeassure]")

                    If (IsNumeric(Session("OHS.Surveillance.LoadSub"))) Then IsRowExpanded = dgView_002.IsRowExpanded(Session("OHS.Surveillance.LoadSub"))

                    LoadExpGrid(Session, dgView_002, "Occup. Health & Safety Tab", "<Tablename=HCMedSurveillance><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [TestDate], 120) + ' ' + [TestName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[TestDate], [TestName], [TestType], [PerformedBy], [PerformedByContact]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.OHS.Surveillance." & Session.SessionID)

                    If (IsNumeric(Session("OHS.Surveillance.LoadSub"))) Then

                        iRowIndex = Session("OHS.Surveillance.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_006"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                Dim TestDate As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "TestDate")).ToString("yyyy-MM-dd HH:mm:ss")
                                Dim TestName As String = dgView_002.GetRowValues(iRowIndex, "TestName")

                                LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HCMedSurveillanceTestResult><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [TestDate], 120) + ' ' + [TestName] + ' ' + [TestElement]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & TestDate & "', '" & TestName & "'><Columns=[TestElement], [ActualValue], [UnitOfMeassure], [Normal], [Abnormal]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [TestDate] = '" & TestDate & "' and [TestName] = '" & TestName & "')>", "Data.OHS.Surveillance.Tests." & Session.SessionID)

                            End If

                        End If

                    End If

                Case 2
                    If (ClearCache) Then

                        ClearFromCache("Data.OHS.Consultations." & Session.SessionID)

                        ClearFromCache("Data.OHS.Consultations.Body." & Session.SessionID)

                    End If

                    LoadExpDS(dsConConsultationType, "select [ConsultationType] from [HCConsultationTypeLU] order by [ConsultationType]")

                    LoadExpDS(dsConDiagnosis, "select [DiagnosisCode] from [DiagnosisLU] order by [DiagnosisCode]")

                    LoadExpDS(dsConConsultatation, "select distinct [Consultatation] from [HCConsultation] order by [Consultatation]")

                    LoadExpDS(dsAttendedBy, "select distinct [AttendedBy] from [HCConsultation] order by [AttendedBy]")

                    LoadExpDS(dsConReferral, "select distinct [Referral] from [HCConsultation] order by [Referral]")

                    If (IsNumeric(Session("OHS.Consultations.LoadSub"))) Then IsRowExpanded = dgView_003.IsRowExpanded(Session("OHS.Consultations.LoadSub"))

                    LoadExpGrid(Session, dgView_003, "Occup. Health & Safety Tab", "<Tablename=HCConsultation><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [ConsultationDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[ConsultationDate], [ConsultationType], [Classification], [DateDiagnosed], [Diagnosis], [Consultatation], [DateNextExam], [AttendedBy], [Referral], [Cause]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.OHS.Consultations." & Session.SessionID)

                    If (IsNumeric(Session("OHS.Consultations.LoadSub"))) Then

                        iRowIndex = Session("OHS.Consultations.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_003.FindDetailRowTemplateControl(iRowIndex, "dgView_007"), DevExpress.Web.ASPxGridView.ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                Dim ConsultationDate As String = Convert.ToDateTime(dgView_003.GetRowValues(iRowIndex, "ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss")

                                LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HCConsultBodilyLocation><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [ConsultationDate], 120) + ' ' + [BodilyLocation]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ConsultationDate & "'><Columns=[BodilyLocation], [Description]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [ConsultationDate] = '" & ConsultationDate & "')>", "Data.OHS.Consultations.Body." & Session.SessionID)

                            End If

                        End If

                    End If

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

        UDetails = GetUserDetails(Session, "Occup. Health & Safety Tab")

        LoadData()

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

    End Sub

    Private Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged, dgView_002.DetailRowExpandedChanged, dgView_003.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim dgView As DevExpress.Web.ASPxGridView.ASPxGridView = Nothing

            With UDetails

                If (sender.Equals(dgView_001)) Then

                    ClearFromCache("Data.OHS.Incidents.Body." & Session.SessionID)

                    ClearFromCache("Data.OHS.Incidents.Notes." & Session.SessionID)

                    dgView = TryCast(TryCast(dgView_001.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl_001"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_004"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    Dim DateOccurred As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss")

                    If (Not IsNull(dgView)) Then

                        LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HSDetailsBodilyLocation><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateOccurred], 120) + ' ' + [BodilyLocation]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & DateOccurred & "'><Columns=[BodilyLocation], [Description]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [DateOccurred] = '" & DateOccurred & "')>", "Data.OHS.Incidents.Body." & Session.SessionID)

                        dgView = Nothing

                    End If

                    dgView = TryCast(TryCast(dgView_001.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl_001"), DevExpress.Web.ASPxTabControl.ASPxPageControl).FindControl("dgView_005"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HSDetailsNotes><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateOccurred], 120) + ' ' + convert(nvarchar(19), [NoteDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & DateOccurred & "'><Columns=[NoteDate], [NoteType], [ContactName], [AttendedBy], [FollowUpDate], [NoteText]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [DateOccurred] = '" & DateOccurred & "')>", "Data.OHS.Incidents.Notes." & Session.SessionID)

                    Session("OHS.Incidents.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_002)) Then

                    ClearFromCache("Data.OHS.Surveillance.Tests." & Session.SessionID)

                    dgView = TryCast(dgView_002.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_006"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        dgView = TryCast(dgView_002.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_006"), DevExpress.Web.ASPxGridView.ASPxGridView)

                        If (Not IsNull(dgView)) Then

                            Dim TestDate As String = Convert.ToDateTime(dgView_002.GetRowValues(e.VisibleIndex, "TestDate")).ToString("yyyy-MM-dd HH:mm:ss")
                            Dim TestName As String = dgView_002.GetRowValues(e.VisibleIndex, "TestName")

                            LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HCMedSurveillanceTestResult><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [TestDate], 120) + ' ' + [TestName] + ' ' + [TestElement]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & TestDate & "', '" & TestName & "'><Columns=[TestElement], [ActualValue], [UnitOfMeassure], [Normal], [Abnormal]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [TestDate] = '" & TestDate & "' and [TestName] = '" & TestName & "')>", "Data.OHS.Surveillance.Tests." & Session.SessionID)

                        End If

                    End If

                    Session("OHS.Surveillance.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_003)) Then

                    ClearFromCache("Data.OHS.Consultations.Body." & Session.SessionID)

                    dgView = TryCast(dgView_003.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_007"), DevExpress.Web.ASPxGridView.ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        Dim ConsultationDate As String = Convert.ToDateTime(dgView_003.GetRowValues(e.VisibleIndex, "ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss")

                        LoadExpGrid(Session, dgView, "Occup. Health & Safety Tab", "<Tablename=HCConsultBodilyLocation><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [ConsultationDate], 120) + ' ' + [BodilyLocation]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ConsultationDate & "'><Columns=[BodilyLocation], [Description]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [ConsultationDate] = '" & ConsultationDate & "')>", "Data.OHS.Consultations.Body." & Session.SessionID)

                    End If

                    Session("OHS.Consultations.LoadSub") = e.VisibleIndex

                End If

            End With

        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("OHS.Incidents.LoadSub"))) Then

            Session.Remove("OHS.Incidents.LoadSub")

        ElseIf (sender.Equals(dgView_002) AndAlso IsNumeric(Session("OHS.Surveillance.LoadSub"))) Then

            Session.Remove("OHS.Surveillance.LoadSub")

        ElseIf (sender.Equals(dgView_003) AndAlso IsNumeric(Session("OHS.Consultations.LoadSub"))) Then

            Session.Remove("OHS.Consultations.LoadSub")

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=HSDetails><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><DateOccurred=" & Convert.ToDateTime(e.Values("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=HCMedSurveillance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><TestDate=" & Convert.ToDateTime(e.Values("TestDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><TestName=" & e.Values("TestName").ToString() & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=HCConsultation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><ConsultationDate=" & Convert.ToDateTime(e.Values("ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=HSDetailsBodilyLocation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><DateOccurred=" & Convert.ToDateTime(e.Values("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & "><BodilyLocation=" & e.Values("BodilyLocation").ToString() & ">"

        ElseIf (sender.ID = "dgView_005") Then

            SQLAudit = "<Tablename=HSDetailsNotes><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><DateOccurred=" & Convert.ToDateTime(e.Values("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & "><NoteDate=" & Convert.ToDateTime(e.Values("NoteDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.ID = "dgView_006") Then

            SQLAudit = "<Tablename=HCMedSurveillanceTestResult><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><TestDate=" & Convert.ToDateTime(e.Values("TestDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><TestName=" & e.Values("TestName").ToString() & "><TestElement=" & e.Values("TestElement").ToString() & ">"

        Else

            SQLAudit = "<Tablename=HCConsultBodilyLocation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><ConsultationDate=" & Convert.ToDateTime(e.Values("ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><BodilyLocation=" & e.Values("BodilyLocation").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_004" OrElse sender.ID = "dgView_005" OrElse sender.ID = "dgView_006" OrElse sender.ID = "dgView_007") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=HSDetails><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=HCMedSurveillance><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=HCConsultation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=HSDetailsBodilyLocation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.ID = "dgView_005") Then

            SQLAudit = "<Tablename=HSDetailsNotes><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.ID = "dgView_006") Then

            SQLAudit = "<Tablename=HCMedSurveillanceTestResult><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        Else

            SQLAudit = "<Tablename=HCConsultBodilyLocation><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        End If

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004" OrElse sender.ID.ToString() = "dgView_005" OrElse sender.ID.ToString() = "dgView_006" OrElse sender.ID.ToString() = "dgView_007")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=HSDetails><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><DateOccurred;2=" & Convert.ToDateTime(e.OldValues("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=HCMedSurveillance><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><TestDate;2=" & Convert.ToDateTime(e.OldValues("TestDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><TestName;3=" & e.OldValues("TestName").ToString() & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=HCConsultation><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><ConsultationDate;2=" & Convert.ToDateTime(e.OldValues("ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=HSDetailsBodilyLocation><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><DateOccurred;2=" & Convert.ToDateTime(e.OldValues("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & "><BodilyLocation;3=" & e.OldValues("BodilyLocation").ToString() & ">"

        ElseIf (sender.ID = "dgView_005") Then

            SQLAudit = "<Tablename=HSDetailsNotes><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><DateOccurred;2=" & Convert.ToDateTime(e.OldValues("DateOccurred")).ToString("yyyy-MM-dd HH:mm:ss") & "><NoteDate;3=" & Convert.ToDateTime(e.OldValues("NoteDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.ID = "dgView_006") Then

            SQLAudit = "<Tablename=HCMedSurveillanceTestResult><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><TestDate;2=" & Convert.ToDateTime(e.OldValues("TestDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><TestName;3=" & e.OldValues("TestName").ToString() & "><TestElement;4=" & e.OldValues("TestElement").ToString() & ">"

        Else

            SQLAudit = "<Tablename=HCConsultBodilyLocation><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><ConsultationDate;2=" & Convert.ToDateTime(e.OldValues("ConsultationDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><BodilyLocation;3=" & e.OldValues("BodilyLocation").ToString() & ">"

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabOHS.TabPages(tabOHS.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabOHS.TabPages(tabOHS.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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