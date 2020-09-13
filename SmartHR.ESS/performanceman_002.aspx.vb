Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class performanceman_002
    Inherits System.Web.UI.Page

    Private GenerateClass As Boolean

    Private ShowError As Boolean

    Private maxCount As Integer = 0
    Private CompanyNum As String = String.Empty
    Private EmployeeNum As String = String.Empty
    Private SchemeCode As String = String.Empty
    Private EvalDate As Date = Nothing
    Private EvalDateEnglish As String = String.Empty
    Private ConfigEvalDate As String = String.Empty
    Private CompNum As String = String.Empty
    Private EmpNum As String = String.Empty
    Private EvalYear As String = String.Empty
    Private EvalMonth As String = String.Empty
    Private SchemeName As String = String.Empty
    Private Score() As Single = {0, 0}
    Private MultiColumn As Boolean
    Private WorkFlow As String = String.Empty

    Private csCollection As Hashtable = Nothing

    Private PathID As String
    Private UDetails As Users = Nothing

    Private hColor As Drawing.Color = Drawing.Color.FromArgb(247, 250, 255)

    Private RedirectURL As String = String.Empty

    Private SavedText As String = String.Empty

    Private CalculateScore As Boolean

    Private ExecPrint As Boolean

#Region " *** Web Form Functions *** "

    Private Function GetSQLText(ByVal CompanyNum As String, ByVal EmployeeNum As String) As String

        Dim PathData As String = GetPathData(PathID)

        Dim ReturnText As String = String.Empty

        Dim dtScheme As DataTable = Nothing

        Dim SQLColumns() As String = {String.Empty, String.Empty}

        Dim dtColumns As DataTable = Nothing

        Dim SQLAnswers(2, 2) As String

        Try

            For iLoop As Integer = 0 To 2

                For iLoopType As Integer = 0 To 2

                    SQLAnswers(iLoop, iLoopType) = "''"

                Next

            Next

            dtScheme = GetSQLDT("select [CompanyNum], [EmployeeNum], [pes].[SchemeCode], [EvalDate], [pes].[Name], [Score], [MultiColumn], [WFName], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', YEAR([EvalDate]) AS 'YearEval', MONTH([EvalDate]) AS 'MonthEval' from [PerfEvalScheme] as [pes] left outer join [PerfScheme] as [ps] on [pes].[SchemeCode] = [ps].[SchemeCode] where ([AppraiserCompNum] = '" & CompanyNum & "' and [AppraiserEmpNum] = '" & EmployeeNum & "' and [pes].[PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Data.Evaluations.Scheme." & Session.SessionID)

            If (Not IsData(dtScheme)) Then

                If (Not IsPostBack) Then ClearFromCache("Data.Evaluations.Scheme." & Session.SessionID)

                dtScheme = GetSQLDT("select [CompanyNum], [EmployeeNum], [pes].[SchemeCode], [EvalDate], [pes].[Name], [Score], [MultiColumn], [WFName], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', YEAR([EvalDate]) AS 'YearEval', MONTH([EvalDate]) AS 'MonthEval' from [PerfEvalScheme] as [pes] left outer join [PerfScheme] as [ps] on [pes].[SchemeCode] = [ps].[SchemeCode] where ([pes].[PathID] = " & PathID & ")", "Data.Evaluations.Scheme." & Session.SessionID)

            End If

            If (IsData(dtScheme)) Then

                With dtScheme.Rows(0)

                    CompanyNum = .Item("CompanyNum").ToString()

                    CompNum = .Item("CompanyNum").ToString()

                    EmployeeNum = .Item("EmployeeNum").ToString()

                    EmpNum = .Item("EmployeeNum").ToString()

                    SchemeCode = .Item("SchemeCode").ToString()

                    EvalDate = .Item("EvalDate")

                    EvalDateEnglish = .Item("EvalDate")

                    ConfigEvalDate = .Item("DateEval")

                    EvalYear = .Item("YearEval")

                    EvalMonth = .Item("MonthEval")

                    SchemeName = .Item("Name").ToString()

                    Score(0) = .Item("Score")

                    Score(1) = Score(0)

                    If (Not IsNull(.Item("MultiColumn"))) Then MultiColumn = .Item("MultiColumn")

                    WorkFlow = .Item("WFName").ToString()

                End With

                If (MultiColumn) Then

                    dtColumns = GetSQLDT("select [wf].[ID], [ReportsToType], (select top 1 [Actioner] from [ess.WFAudit] where ([PathID] = " & PathID & " and [WFID] = [wf].[ID])) as [EmpName], (select top 1 [ActionerCompanyNum] + ' ' + [ActionerEmployeeNum] from [ess.WFAudit] where ([PathID] = " & PathID & " and [WFID] = [wf].[ID])) as [EmpData] from [ess.WF] as [wf] left outer join [ess.ActionLU] as [al] on [wf].[ActionID] = [al].[ID] where (not [wf].[ID] in(select [WFID] from [ess.Path] where ([ID] = " & PathID & ")) and [WFLUID] in(select [ID] from [ess.WFLU] where (not [StatusID] = 0 and [WFName] = '" & WorkFlow & "'))) order by [StatusID], [PostActID] desc", "Data.Evaluations.Scheme.Columns." & Session.SessionID)

                    If (IsData(dtColumns, False)) Then

                        Dim iRowIndex As Integer = 0

                        Dim iIndex As Integer = 15

                        While (iIndex < dgView.Columns.Count)

                            If (Not dgView.Columns(iIndex).Visible) Then

                                dgView.Columns(iIndex).Visible = True

                            Else

                                dgView.Columns(iIndex).Visible = True

                                If (iRowIndex < dtColumns.Rows.Count AndAlso Not IsNull(dtColumns.Rows(iRowIndex).Item("EmpData"))) Then

                                    With dtColumns.Rows(iRowIndex)

                                        SQLAnswers(1, iRowIndex) = "replace((select case [RangeType] when '-' then [Remarks] when '#' then convert(nvarchar(19), [ObtainBy], 120) else [ElementName] end from [PerfEvalKPA] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] = [pKPA].[CompanyNum] + ' ' + [pKPA].[EmployeeNum] + ' ' + [pKPA].[SchemeCode] + ' ' + [pKPA].[ClassCode] + ' ' + [pKPA].[KPACode] and [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = '" & .Item("ReportsToType").ToString() & "')))), 'Sum of CSE Scores', '')"

                                        SQLAnswers(2, iRowIndex) = "(select case [RangeType] when '-' then [Remarks] when '#' then convert(nvarchar(19), [ObtainBy], 120) else [ElementName] end from [PerfEvalCSE] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName] = [pCSE].[CompanyNum] + ' ' + [pCSE].[EmployeeNum] + ' ' + [pCSE].[SchemeCode] + ' ' + [pCSE].[ClassCode] + ' ' + [pCSE].[KPACode] + ' ' + [pCSE].[CSEName] and [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = '" & .Item("ReportsToType").ToString() & "'))))"

                                        dgView.Columns(iIndex).Caption = .Item("EmpName").ToString()

                                    End With

                                Else

                                    dgView.Columns(iIndex).Visible = False

                                End If

                            End If

                            iRowIndex += 1

                            iIndex += 1

                        End While

                    End If

                Else

                    For iLoop As Integer = 15 To 17

                        If (dgView.Columns(iLoop).Visible) Then dgView.Columns(iLoop).Visible = False

                    Next

                End If

                ReturnText = "select 0 as [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] as [CompositeKey],                   0 as [Type], [ClassCode], null as [Sort], upper([ClassName]) as [Name], '' as [RangeType], '' as [Value], [Weight], [RatingPercentage], [Score], '' as [Description],                getdate() as [ObtainBy], '' as [Desc],                                                                                                                                                                          0 as [Count],                                                                                                                                                '' as [StickyNotes],                   '' as [Answers], " & SQLAnswers(0, 0) & " as [Answers_010], " & SQLAnswers(0, 1) & " as [Answers_011], " & SQLAnswers(0, 2) & " as [Answers_012] from [PerfEvalClass] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                             "select [Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,           [ClassCode], [KPACode],      [KPAName],                    [RangeType],       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfKPA] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]),                                  (select count([CSEName]) from [PerfEvalCSE] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]), cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(1, 0) & ",                  " & SQLAnswers(1, 1) & ",                  " & SQLAnswers(1, 2) & "                  from [PerfEvalKPA] as [pKPA] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                             "select [Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,           [ClassCode], [KPACode],      [CSEName],                    [RangeType],       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfCSE] where [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode] = [pCSE].[ClassCode] and [KPACode] = [pCSE].[KPACode] and [CSEName] = [pCSE].[CSEName]), 0,                                                                                                                                                           cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(2, 0) & ",                  " & SQLAnswers(2, 1) & ",                  " & SQLAnswers(2, 2) & "                  from [PerfEvalCSE] as [pCSE] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') order by [ClassCode], [Sort], [Type], [Name]"

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dtColumns)) Then

                dtColumns.Dispose()

                dtColumns = Nothing

            End If

            If (Not IsNull(dtScheme)) Then

                dtScheme.Dispose()

                dtScheme = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        Dim dtTable As DataTable = Nothing

        Try

            With UDetails

                If (ClearCache) Then

                    ClearFromCache("Data.Evaluations.Scheme." & Session.SessionID)

                    ClearFromCache("Data.Evaluations.Scheme.Columns." & Session.SessionID)

                    ClearFromCache("Data.Evaluations.EvalForm." & Session.SessionID)

                End If

                dtTable = GetSQLDT(GetSQLText(.CompanyNum, .EmployeeNum), "Data.Evaluations.EvalForm." & Session.SessionID)

                'JR Code - Populate MYE Data

                Dim dv As DataView = New DataView(dtTable, "Description <> ''", "Description", DataViewRowState.CurrentRows)

                If (SchemeCode.Equals("MYE") And dv.ToTable().Rows.Count <= 0) Then

                    If (GetDataFromSGP(PathID, EvalDate)) Then

                        dtTable = GetSQLDT(GetSQLText(.CompanyNum, .EmployeeNum))

                    End If

                End If

                'End JR Code

                If (dtTable.Compute("Count([Type])", "[Type] = 0") <= 1) Then

                    dtTable.DefaultView.RowFilter = "not [Type] = 0"

                Else

                    GenerateClass = True

                End If

                'JR Code
                If (SchemeCode.Equals("MYE") Or SchemeCode.Equals("SGP") Or SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

                    'Code for Page Load
                    If (Session("SelectedComp").ToString().ToUpper().Equals(CompNum.ToUpper()) And Session("SelectedEmp").ToString().ToUpper().Equals(EmpNum.ToUpper())) Then
                        Session("CurrentUser") = "0"
                        Session("LblUser") = "0"
                        currUser.Value = "0"
                    Else
                        Dim userCheck As Object = GetSQLFields(String.Format("select [ReportToCompNum] + ':' + [ReportToEmpNum] AS 'UC' from [ReportsTo] where (ReportsToType = 'Manager' AND [CompanyNum] = '{0}' AND [EmployeeNum] = '{1}')", CompNum, EmpNum))
                        If (Not IsNull(userCheck) And Not userCheck Is Nothing) Then
                            If (Session("SelectedComp").ToString().ToUpper().Equals(userCheck(0).ToString().Split(":")(0).ToUpper()) And Session("SelectedEmp").ToString().ToUpper().Equals(userCheck(0).ToString().Split(":")(1).ToUpper())) Then
                                Session("LblUser") = "1"
                                currUser.Value = "1"
                            Else
                                Dim eCheck1 As Object = GetSQLFields(String.Format("select [ReportToCompNum] + ':' + [ReportToEmpNum] AS 'UC' from [ReportsTo] where (ReportsToType = 'Manager' AND [CompanyNum] = '{0}' AND [EmployeeNum] = '{1}')", CompNum, EmpNum))
                                If (IsNull(eCheck1) And eCheck1 Is Nothing) Then
                                    Session("LblUser") = "3"
                                    currUser.Value = "3"
                                Else
                                    Session("LblUser") = "2"
                                    currUser.Value = "2"
                                End If
                            End If
                            Session("CurrentUser") = "1"
                        Else
                            Dim eCheck1 As Object = GetSQLFields(String.Format("select [ReportToCompNum] + ':' + [ReportToEmpNum] AS 'UC' from [ReportsTo] where (ReportsToType = 'Manager' AND [CompanyNum] = '{0}' AND [EmployeeNum] = '{1}')", CompNum, EmpNum))
                            If (IsNull(eCheck1) And eCheck1 Is Nothing) Then
                                Session("LblUser") = "3"
                                currUser.Value = "3"
                            Else
                                Session("LblUser") = "2"
                                currUser.Value = "2"
                            End If
                            Session("CurrentUser") = "1"
                        End If
                    End If
                End If

                ''Check Cut Off Facility
                'Dim finEvalYear As String = String.Empty
                'If (SchemeCode.Equals("OP")) Then
                '    finEvalYear = EvalYear
                'ElseIf (SchemeCode.Equals("TL")) Then
                '    If (Convert.ToInt32(EvalMonth.ToString()) <= 3) Then
                '        Dim yearPR As Integer = Convert.ToInt32(EvalYear.ToString()) - 1
                '        finEvalYear = yearPR.ToString()
                '    Else
                '        finEvalYear = EvalYear
                '    End If
                'ElseIf (SchemeCode.Equals("IC")) Then
                '    If (Convert.ToInt32(EvalMonth.ToString()) > 6) Then
                '        finEvalYear = EvalYear
                '    Else
                '        Dim yearYE As Integer = Convert.ToInt32(EvalYear.ToString()) - 1
                '        finEvalYear = yearYE.ToString()
                '    End If
                'End If

                'Dim edFields() As Object = GetSQLFields(String.Format("SELECT DISTINCT CONVERT(VARCHAR(10), a.StartDate, 101) AS 'StartDate', CONVERT(VARCHAR(10), a.EndDate, 101) AS 'EndDate' FROM TableCOEmp a WHERE a.CompanyNum = '{0}' and a.EmployeeNum = '{1}' and a.SchemeCode = '{2}' and a.Year = '{3}'", CompNum, EmpNum, SchemeCode, finEvalYear))
                'If (Not IsNull(edFields) And Not edFields Is Nothing) Then
                '    If (Convert.ToDateTime(edFields(0).ToString()) <= Date.Today And Convert.ToDateTime(edFields(1).ToString()) >= Date.Today) Then
                '        Session("EDFields") = "1"
                '    Else
                '        Session("EDFields") = "0"
                '    End If
                'Else
                '    Dim edFields1() As Object = GetSQLFields(String.Format("SELECT DISTINCT CONVERT(VARCHAR(10), a.StartDate, 101) AS 'StartDate', CONVERT(VARCHAR(10), a.EndDate, 101) AS 'EndDate' FROM TableCOGlobal a WHERE a.SchemeCode = '{0}' and a.Year = '{1}'", SchemeCode, finEvalYear))
                '    If (Not IsNull(edFields1) And Not edFields1 Is Nothing) Then
                '        If (Convert.ToDateTime(edFields1(0).ToString()) <= Date.Today And Convert.ToDateTime(edFields1(1).ToString()) >= Date.Today) Then
                '            Session("EDFields") = "1"
                '        Else
                '            Session("EDFields") = "0"
                '        End If
                '    Else
                '        Session("EDFields") = "1"
                '    End If
                'End If

                ''End Check Cut Off Facility
                Session("EDFields") = "1"

                'End JR Code

                GetFirstTime()

                dgView.DataSource = dtTable

                dgView.DataBind()

                hPanel.Set("DisableAutoSave", GetArrayItem(Nothing, "ePerformance.DisableAutoSave"))

            End With

        Catch ex As Exception

        Finally

            If (Not IsNull(dtTable)) Then

                dtTable.Dispose()

                dtTable = Nothing

            End If

        End Try

    End Sub

    Private Sub HideFields(ByVal pPathID As String)

        Dim objData() As Object = GetSQLFields("SELECT WFLUID, WFID FROM [ess.Path] WHERE ID = '" & pPathID & "'")
        If (Not IsNull(objData)) Then

            Dim objData2() As Object = GetSQLFields("SELECT ActionID, StatusID FROM [ess.WF] WHERE WFLUID = '" & objData(0) & "' AND ID = '" & objData(1) & "'")

            If (Not IsNull(objData2)) Then

                Dim actionString As String = GetSQLField("SELECT ReportsToType FROM [ess.ActionLU] WHERE ID = '" & objData2(0) & "'", "ReportsToType")
                Dim statusString As String = GetSQLField("SELECT Status FROM [ess.StatusLU] WHERE ID = '" & objData2(1) & "'", "Status")

                ''If (actionString = "Dummy" And statusString = "Approve") Then
                'If (actionString = "Dummy") Then

                '    cmdAppraise.Enabled = False
                '    cmdAppraise2.Enabled = False

                'End If

            End If

            'Check the WFID
            If objData(1).ToString() = "213" Or objData(1).ToString() = "214" Or objData(1).ToString() = "215" Or objData(1).ToString() = "216" Then
                cmdAppraise.Enabled = False
                cmdAppraise2.Enabled = False
            End If

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (IsNull(csCollection)) Then

            csCollection = New Hashtable()

        Else

            csCollection.Clear()

        End If

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "Performance Tab")

        LoadData(Not IsPostBack)

        HideFields(PathID)

        UDetails = GetUserDetails(Session, "Performance Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlEvaluations.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Evaluation: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name & " [" & SchemeName & "]"

            End With

            SetMessage3.Set("SetMessage3", "Records cannot be submitted. Missing Required Fields: Comments by Appraisee and Ratings Agreement by Appraisee")
            SetMessage4.Set("SetMessage4", "Records cannot be submitted. Ratings Agreement has a 'Disagree' value.")
            SetMessage5.Set("SetMessage5", "Records cannot be submitted. Missing Required Fields: Comments by Manager and Ratings Agreement by Manager")
            SetMessage6.Set("SetMessage6", "Records cannot be submitted. Missing Required Fields: Comments by Next Level Manager and Ratings Agreement by Next Level Manager")

            CalculateScore = True

            Dim objData() As Object = GetSQLFields("select [CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [Score], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', Convert(Varchar(1), [Completed]) AS 'Completed' from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))")

            If (IsNull(objData)) Then objData = GetSQLFields("select [CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [Score], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', Convert(Varchar(1), [Completed]) AS 'Completed' from [PerfEvalScheme] where ([PathID] = " & PathID & ")")

            If (Not IsNull(objData)) Then

                Session("PathID") = PathID

                Session("EvalScheme") = objData(2)

                Session("Performance.CompanyNum") = objData(0)

                Session("Performance.EmployeeNum") = objData(1)

                Session("Performance.Selected") = objData(2)

                Session("Performance.EvalDate") = objData(3)

                If (IsDate(Session("Performance.EvalDate"))) Then

                    Dim dteConvert As Date = Session("Performance.EvalDate")

                    Session("Performance.EvalDate") = dteConvert.ToString("yyyy-MM-dd HH:mm:ss")

                End If

                Score(0) = objData(4)

                Score(1) = Score(0)

                If (IsNumeric(PathID)) Then

                    If (SchemeCode.Equals("MYE") Or SchemeCode.Equals("SGP") Or SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

                        If (SchemeCode.Equals("SGP") Or SchemeCode.Equals("MYE")) Then
                            cmdAppraise.Visible = False
                            rpanel1.Visible = False

                            If (currUser.Value.Equals("1")) Then
                                cmdAppraise2.Enabled = True
                            Else
                                cmdAppraise2.Enabled = False
                            End If

                        Else

                            'JR Code - Display of the external page.
                            Dim completed As String = objData(6)

                            If (completed.Equals("1")) Then
                                rpanel1.Visible = False
                            Else
                                rpanel1.Visible = True
                            End If
                            'End JR Code

                            EnableDisableControls()

                        End If

                    End If

                End If

            End If

            IsFirstLoading.Set("IsFirstLoading", "Loaded")

        End If

    End Sub

    Private Sub cpPage_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpPage.Callback


        Dim isValid As Boolean = True

        Dim ParamValue As String = e.Parameter

        If (ParamValue = "SavePrint") Then

            ExecPrint = True

            ParamValue = "Save"

        End If

        'If (ParamValue = "Save" OrElse ParamValue.StartsWith("SaveItem ") OrElse ParamValue = "Submit") Then
        If (ParamValue = "Save" OrElse ParamValue.StartsWith("SaveItem ") OrElse ParamValue = "Submit" OrElse ParamValue = "Reject" OrElse ParamValue = "Reject2") Then

            Dim dtScores As DataTable = Nothing

            Dim ItemKey As String = String.Empty

            Dim objValues() As Object = Nothing

            Dim objValue As Object = Nothing

            Dim objText As Object = Nothing

            Dim SQL As String = String.Empty

            Dim PathData() As String = {String.Empty, String.Empty}

            Dim bExecute As Boolean

            Dim bType As Byte

            Dim Values() As String = ParamValue.Split(" ")

            Dim valType As String = String.Empty

            Dim objNotes As Object = Nothing

            Try

                Dim iStart As Integer = 0

                Dim iUntil As Integer = (dgView.VisibleRowCount - 1)

                If (ParamValue.StartsWith("SaveItem ")) Then

                    iStart = Convert.ToInt32(Values(1))

                    iUntil = iStart

                End If

                For iLoop As Integer = iStart To iUntil

                    objValues = dgView.GetRowValues(iLoop, "Type", "Count", "RangeType", "CompositeKey", "Required")

                    If (objValues(0) > 0) Then

                        If (objValues(0) = 2 OrElse (objValues(0) = 1 AndAlso objValues(1) = 0)) Then

                            If (objValues(0) = 2 OrElse (objValues(0) = 1 AndAlso objValues(1) = 0)) Then

                                If (Values.GetLength(0) > 2 OrElse items_001.Contains("row_" & iLoop.ToString())) Then

                                    If (Values.GetLength(0) > 2) Then valType = "NOTES"

                                    If (valType = "NOTES" OrElse IsString(items_001.Get("row_" & iLoop.ToString()))) Then

                                        objNotes = Nothing

                                        If (valType = "NOTES") Then

                                            objNotes = Values(3)

                                        Else

                                            objNotes = items_001.Get("row_" & iLoop.ToString())

                                        End If

                                        If (Not IsNull(objNotes)) Then

                                            Select Case objValues(0)

                                                Case 1
                                                    SQL = "update [PerfEvalKPA] set [StickyNotes] = '" & GetDataText(objNotes.ToString()) & "' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] = '"

                                                Case 2
                                                    SQL = "update [PerfEvalCSE] set [StickyNotes] = '" & GetDataText(objNotes.ToString()) & "' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName] = '"

                                            End Select

                                            SQL &= GetDataText(objValues(3).ToString()) & "')"

                                            ExecSQL(SQL)

                                        End If

                                    End If

                                End If

                                ItemKey = "dgView_" & iLoop.ToString("000")

                                If (items_001.Contains(ItemKey & "_Value") AndAlso items_001.Contains(ItemKey & "_Text")) Then

                                    objValue = items_001.Get(ItemKey & "_Value")

                                    objText = items_001.Get(ItemKey & "_Text")

                                    If (Not IsNull(objValue) AndAlso Not IsNull(objText)) Then

                                        bExecute = True

                                        bType = Convert.ToByte(objValues(0))

                                        Select Case objValues(0)

                                            Case 1
                                                SQL = "update [PerfEvalKPA] set <%Values%>"

                                                SQL &= " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] = '"

                                            Case 2
                                                SQL = "update [PerfEvalCSE] set <%Values%>"

                                                SQL &= " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName] = '"

                                        End Select

                                        Select Case objValues(2)

                                            Case "-"
                                                SQL = SQL.Replace("<%Values%>", "[Remarks] = '" & GetDataText(objValue.ToString()) & "'")

                                            Case "#"
                                                If (IsDate(objValue)) Then

                                                    SQL = SQL.Replace("<%Values%>", "[ObtainBy] = '" & Convert.ToDateTime(objValue).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                                                Else

                                                    bExecute = False

                                                End If

                                            Case Else
                                                If (objValue = -1 AndAlso Not objValues(2) = "!") Then

                                                    SQL = SQL.Replace("<%Values%>", "[ElementName] = null, [RatingPercentage] = 0")

                                                Else

                                                    If (Regex.IsMatch(objValues(2).ToString(), "^" & EscapeRegex("$"))) Then

                                                        Dim iValue As Decimal = 0

                                                        Dim maxValue As Decimal = 0

                                                        Dim dtBounds As DataTable = Nothing

                                                        Try

                                                            Dim dsRangeID As String = "sp" & Regex.Replace(objValues(2), "\W", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                                            dtBounds = GetSQLDT("select [FromPerc], [ElementName] from [PerfRangeElements] where ([RangeType] = '" & GetDataText(objValues(2)) & "')", "Data.Evaluations.RangeElements." & dsRangeID)

                                                            If (IsData(dtBounds)) Then

                                                                For i As Integer = 0 To (dtBounds.Rows.Count - 1)

                                                                    If (IsNumeric(dtBounds.Rows(i).Item("FromPerc"))) Then

                                                                        Select Case dtBounds.Rows(i).Item("ElementName").ToString().ToLower()

                                                                            Case "maximum"
                                                                                maxValue = Convert.ToDecimal(dtBounds.Rows(i).Item("FromPerc"))

                                                                        End Select

                                                                    End If

                                                                Next

                                                            End If

                                                            If (IsNumeric(objValue)) Then iValue = Convert.ToDecimal(objValue)

                                                            If (maxValue > 0) Then iValue = ((iValue / maxValue) * 100)

                                                            SQL = SQL.Replace("<%Values%>", "[ElementName] = '" & GetDataText(objText.ToString()) & "', [RatingPercentage] = " & iValue.ToString("0.00"))

                                                        Catch ex As Exception

                                                        Finally

                                                            If (Not IsNull(dtBounds)) Then

                                                                dtBounds.Dispose()

                                                                dtBounds = Nothing

                                                            End If

                                                        End Try

                                                    ElseIf (objValues(2) = "!") Then

                                                        If (Not Convert.ToBoolean(objValue)) Then

                                                            objValue = 0

                                                        Else

                                                            objValue = 100

                                                        End If

                                                        SQL = SQL.Replace("<%Values%>", "[ElementName] = '" & GetDataText(objText.ToString()) & "', [RatingPercentage] = " & objValue.ToString())

                                                    Else

                                                        SQL = SQL.Replace("<%Values%>", "[ElementName] = '" & GetDataText(objText.ToString()) & "', [RatingPercentage] = " & objValue.ToString())

                                                    End If

                                                End If

                                        End Select

                                        SQL &= GetDataText(objValues(3).ToString()) & "')"

                                        If (bExecute) Then ExecSQL(SQL)

                                    ElseIf (Not IsNull(objValues(4))) Then

                                        If (objValues(4)) Then

                                            Dim bShowError As Boolean = False

                                            Select Case objValues(2)

                                                Case "-"
                                                    If (String.IsNullOrEmpty(objValue)) Then bShowError = True

                                                Case "#"
                                                    If (Not IsDate(objValue)) Then bShowError = True

                                                Case Else
                                                    If (String.IsNullOrEmpty(objValue) AndAlso String.IsNullOrEmpty(objText) AndAlso Not objValues(2) = "!") Then bShowError = True

                                            End Select

                                            If (bShowError) Then

                                                ShowError = True

                                                SavedText = "error Complete all fields marked with an asterisk."

                                                Exit Sub

                                            End If

                                        End If

                                    End If

                                End If

                            End If

                        End If

                    End If

                Next

                Dim CompositeKey As String = String.Empty

                For iLoop As Integer = 0 To 3

                    CompositeKey &= objValues(3).Split(" ")(iLoop) & " "

                Next

                If (CompositeKey.EndsWith(" ")) Then CompositeKey = CompositeKey.Substring(0, CompositeKey.Length - 1)

                If (ParamValue.StartsWith("SaveItem ") AndAlso bType = 1) Then GoTo SkipCSEScores

                ' ************************************************
                ' *** Update all the CSE Scores (just in case) ***
                ' ************************************************

                If (ExecSQL("update [PerfEvalCSE] set [Score] = [Weight] * ([RatingPercentage] / 100) where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")) Then

                    ' Update the Rating of all the KPA's with the scores of all the CSE's
                    dtScores = GetSQLDT("select [ClassCode], [KPACode], sum([Score]) as [Tot] from [PerfEvalCSE] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "') group by [ClassCode], [KPACode]")

                    Dim ratings2 As Decimal = 0
                    Dim ratings3 As Decimal = 0

                    If (currUser.Value <> "0" And SchemeCode <> "SGP" And SchemeCode <> "MYE") Then

                        Dim dv2 As DataView = dtScores.DefaultView
                        dv2.RowFilter = "[ClassCode] = '2' And [Tot] <> '0'"
                        ratings2 = 100 / dv2.ToTable().Rows.Count

                        Dim dv3 As DataView = dtScores.DefaultView
                        dv3.RowFilter = "[ClassCode] = '3' And [Tot] <> '0'"
                        ratings3 = 100 / dv3.ToTable().Rows.Count

                    End If

                    If (IsData(dtScores)) Then

                        For iLoop As Integer = 0 To (dtScores.Rows.Count - 1)

                            With dtScores.Rows(iLoop)

                                If (IsNull(.Item("Tot"))) Then

                                    ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = 0 where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                Else

                                    If (currUser.Value <> "0") Then

                                        If (.Item("Tot").ToString().Equals("0")) Then

                                            ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = 0, [Weight] = 0 where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                        Else

                                            If (.Item("ClassCode").ToString().Equals("2")) Then

                                                ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = " & .Item("Tot").ToString() & ", [Weight] = " & ratings2.ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                            ElseIf (.Item("ClassCode").ToString().Equals("3")) Then

                                                ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = " & .Item("Tot").ToString() & ", [Weight] = " & ratings3.ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                            End If

                                        End If

                                    Else

                                        ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = " & .Item("Tot").ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                    End If

                                End If

                            End With

                        Next

                    End If

                End If

SkipCSEScores:

                ' ************************************************
                ' *** Update all the KPA Scores (just in case) ***
                ' ************************************************

                'Dim percentValue As String = GetSQLField("select Count([KPACode]) * 10 as [NumValue] from [PerfEvalCSE] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' And CseName = '03. Manager Rating' And ElementName Not In ('Can`t Rate Clearly','Don`t Know'))", "NumValue")

                If (ExecSQL("update [PerfEvalKPA] set [Score] = [Weight] * ([RatingPercentage] / 100) where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")) Then

                    'If (ExecSQL("update [PerfEvalKPA] set [Score] = [Weight] * ([RatingPercentage] / " & percentValue & ") where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")) Then

                    dtScores = GetSQLDT("select [ClassCode], sum([Score]) as [Tot] from [PerfEvalKPA] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "') group by [ClassCode]")

                    If (IsData(dtScores)) Then

                        For iLoop As Integer = 0 To (dtScores.Rows.Count - 1)

                            With dtScores.Rows(iLoop)

                                If (IsNull(.Item("Tot"))) Then

                                    ExecSQL("update [PerfEvalClass] set [RatingPercentage] = 0 where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "')")

                                Else

                                    ExecSQL("update [PerfEvalClass] set [RatingPercentage] = " & .Item("Tot").ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "')")

                                End If

                            End With

                        Next

                        'End If

                    End If

                End If

                ' ***********************************
                ' *** Update all the Class Scores ***
                ' ***********************************

                If (ExecSQL("update [PerfEvalClass] set [Score] = [Weight] * ([RatingPercentage] / 100) where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")) Then

                    ' Update the final score
                    dtScores = GetSQLDT("select sum([Score]) as [Tot] from [PerfEvalClass] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")

                    If (IsData(dtScores)) Then

                        For iLoop As Integer = 0 To (dtScores.Rows.Count - 1)

                            With dtScores.Rows(iLoop)

                                If (IsNull(.Item("Tot"))) Then

                                    ExecSQL("update [PerfEvalScheme] set [Score] = 0 where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")

                                Else

                                    ExecSQL("update [PerfEvalScheme] set [Score] = " & .Item("Tot").ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "')")

                                End If

                            End With

                        Next

                    End If

                End If

                If (ParamValue = "Save") Then

                    If (GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then

                        CalculateScore = True

                        Score(0) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

                        Score(1) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

                        If (IsNull(Score(0))) Then Score(0) = 0

                        If (IsNull(Score(1))) Then Score(1) = 0

                        If (Score(0) = 0 AndAlso Score(1) > 0) Then Score(0) = Score(1)

                    End If

                    SavedText = SUCCESS & " Successfully saved the information"

                    'cpPage.JSProperties("cpFromSave") = "Saved"

                    Session("FromSave") = "Saved"

                    tblErrorMessage1.Visible = False

                ElseIf (ParamValue.StartsWith("SaveItem ")) Then

                    CalculateScore = True

                    Score(0) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

                    Score(1) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

                    If (IsNull(Score(0))) Then Score(0) = 0

                    If (IsNull(Score(1))) Then Score(1) = 0

                    If (Score(0) = 0 AndAlso Score(1) > 0) Then Score(0) = Score(1)

                    'cpPage.JSProperties("cpFromSave") = "Saved"

                    Session("FromSave") = "Saved"

                    tblErrorMessage1.Visible = False

                ElseIf (ParamValue = "Submit") Then

                    If (GetFilledValue()) Then

                        tblErrorMessage2.Visible = False

                        If (GetValuesSection()) Then

                            tblErrorMessage7.Visible = False

                            If (Session("FromSave") <> Nothing) Then

                                Session("FromSave") = Nothing

                                'ExecSQL("update [PerfEvalScheme] set [Remarks2] = NULL, [Remarks] = NULL WHERE [PathID] = '" & PathID & "'")

                                Dim GroupName As String = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

                                If (IsNull(GroupName)) Then GroupName = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

                                PathData(0) = GetPathData(PathID)

                                If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & objValues(3).Split(" ")(0) & "', '" & objValues(3).Split(" ")(1) & "', " & PathID & ", 'Performance', '" & GetXML(PathData(0), KeyName:="AppType") & "', '" & GetXML(PathData(0), KeyName:="StatusType") & "', '" & GetXML(PathData(0), KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & Session("LoggedOn").UserID & "', '" & GetDataText(WorkFlow) & "'")) Then

                                    If (MultiColumn) Then

                                        PathData(1) = GetPathData(PathID)

                                        If (Not GetXML(PathData(1), KeyName:="ActionType").ToLower() = "start" AndAlso Not GetXML(PathData(1), KeyName:="StatusType").ToLower() = "start") Then

                                            EvalDate = Now

                                            ExecSQL("insert into [PerfEvalScheme]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [Name], [AppraiserType], [AppraiserName], [AppraiserCompNum], [AppraiserEmpNum], [PathID], [GroupRole], [GroupName]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & SchemeName & "', 'ESS Multirater', isnull([PreferredName] + ' ', '') + [Surname], '" & GetXML(PathData(1), KeyName:="ActionerCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="ActionerEmployeeNum") & "', " & PathID & ", '" & GetXML(PathData(1), KeyName:="ActionType") & "', '" & GetDataText(GroupName) & "' from [Personnel] where ([CompanyNum] = '" & GetXML(PathData(1), KeyName:="ActionerCompanyNum") & "' and [EmployeeNum] = '" & GetXML(PathData(1), KeyName:="ActionerEmployeeNum") & "')")

                                            ExecSQL("insert into [PerfEvalClass]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [ClassName], [Weight]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [pc].[ClassCode], [pc].[ClassName], [ps].[Weight] from [PerfSchemeClass] as [ps] left outer join [PerfClass] as [pc] on [ps].[ClassCode] = [pc].[ClassCode] where ([SchemeCode] = '" & SchemeCode & "')")

                                            ExecSQL("insert into [PerfEvalKPA]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType] from [PerfKPA] where ([SchemeCode] = '" & SchemeCode & "')")

                                            ExecSQL("insert into [PerfEvalCSE]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType] from [PerfCSE] where ([SchemeCode] = '" & SchemeCode & "')")

                                        End If

                                    End If

                                    RedirectURL = "tasks.aspx tools/index.aspx"

                                End If

                            Else

                                tblErrorMessage1.Visible = True

                            End If

                        Else

                            tblErrorMessage7.Visible = True

                        End If

                    Else

                        tblErrorMessage2.Visible = True

                    End If

                ElseIf (ParamValue.Contains("Reject")) Then

                    If (GetFilledValue()) Then

                        tblErrorMessage2.Visible = False

                        If (GetValuesSection()) Then

                            tblErrorMessage7.Visible = False

                            If (Session("FromSave") <> Nothing) Then

                                Session("FromSave") = Nothing

                                Dim GroupName As String = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

                                If (IsNull(GroupName)) Then GroupName = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

                                PathData(0) = GetPathData(PathID)

                                If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', " & PathID & ", 'Performance', '" & GetXML(PathData(0), KeyName:="AppType") & "', '" & "Reject" & "', '" & GetXML(PathData(0), KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & Session("LoggedOn").UserID & "', '" & GetDataText(WorkFlow) & "'")) Then

                                    If (ParamValue.Equals("Reject2") And Session("LblUser").ToString().Equals("2")) Then

                                        Dim dtMan1 As DataTable = Nothing
                                        dtMan1 = GetSQLDT("select [ReportToCompNum], [ReportToEmpNum] from [ReportsTo] where [ReportsToType] = 'Manager' AND [CompanyNum] = '" & CompNum & "' AND [EmployeeNum] = '" & EmpNum & "'")
                                        Dim dtDetails As DataTable = Nothing
                                        dtDetails = GetSQLDT("select a.[PreferredName], a.[EmailAddress], b.[UserName] from [Personnel] a, [Users] b where a.[CompanyNum] = b.[CompanyNum] and a.[EmployeeNum] = b.[EmployeeNum] AND a.[CompanyNum] = '" & dtMan1.Rows(0)("ReportToCompNum").ToString() & "' AND a.[EmployeeNum] = '" & dtMan1.Rows(0)("ReportToEmpNum").ToString() & "'")

                                        ExecSQL("update [ess.Path] set [ActionID] = '24', [StatusID] = '4', [UserEmail] = '" & dtDetails.Rows(0)("EmailAddress").ToString() & "', [WFID] = '201', [Actioner] = '" & dtDetails.Rows(0)("PreferredName").ToString() & "', [ActionerCompanyNum] = '" & dtMan1.Rows(0)("ReportToCompNum").ToString() & "', [ActionerEmployeeNum] = '" & dtMan1.Rows(0)("ReportToEmpNum").ToString() & "', [ActionerUsername] = '" & dtDetails.Rows(0)("UserName").ToString() & "', [EmailCC] = NULL, [EmailOrigCC] = NULL WHERE [ID] = '" & PathID & "'")

                                    End If

                                    If (MultiColumn) Then

                                        PathData(1) = GetPathData(PathID)

                                        If (Not GetXML(PathData(1), KeyName:="ActionType").ToLower() = "start" AndAlso Not GetXML(PathData(1), KeyName:="StatusType").ToLower() = "start") Then

                                            EvalDate = Now

                                            ExecSQL("insert into [PerfEvalScheme]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [Name], [AppraiserType], [AppraiserName], [AppraiserCompNum], [AppraiserEmpNum], [PathID], [GroupRole], [GroupName]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & SchemeName & "', 'ESS Multirater', [PreferredName], '" & GetXML(PathData(1), KeyName:="ActionerCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="ActionerEmployeeNum") & "', " & PathID & ", '" & GetXML(PathData(1), KeyName:="ActionType") & "', '" & GetDataText(GroupName) & "' from [Personnel] where ([CompanyNum] = '" & GetXML(PathData(1), KeyName:="ActionerCompanyNum") & "' and [EmployeeNum] = '" & GetXML(PathData(1), KeyName:="ActionerEmployeeNum") & "')")

                                            ExecSQL("insert into [PerfEvalClass]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [ClassName], [Weight]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [pc].[ClassCode], [pc].[ClassName], [ps].[Weight] from [PerfSchemeClass] as [ps] left outer join [PerfClass] as [pc] on [ps].[ClassCode] = [pc].[ClassCode] where ([SchemeCode] = '" & SchemeCode & "')")

                                            ExecSQL("insert into [PerfEvalKPA]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType] from [PerfKPA] where ([SchemeCode] = '" & SchemeCode & "')")

                                            ExecSQL("insert into [PerfEvalCSE]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType]) select '" & GetXML(PathData(1), KeyName:="OriginatorCompanyNum") & "', '" & GetXML(PathData(1), KeyName:="OriginatorEmployeeNum") & "', '" & SchemeCode & "', '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "', [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType] from [PerfCSE] where ([SchemeCode] = '" & SchemeCode & "')")

                                        End If

                                    End If

                                    'If (currUser.Value.Equals("2")) Then

                                    '    ExecSQL("update [PerfEvalScheme] set [Remarks2] = 'Valid' WHERE [PathID] = '" & PathID & "'")

                                    'System.Threading.Thread.Sleep(10000)

                                    'Dim cKR As Boolean = False
                                    'While (cKR = False)
                                    '    Dim dtRemark2 As DataTable = Nothing
                                    '    dtRemark2 = GetSQLDT("select [Remarks], [Remarks2] from [PerfEvalScheme] where [PathID] = '" & PathID & "'")
                                    '    If (Not IsNull(dtRemark2)) Then
                                    '        If (dtRemark2.Rows.Count > 0) Then
                                    '            If ((dtRemark2.Rows(0)("Remarks").ToString().Equals("Reject") Or dtRemark2.Rows(0)("Remarks").ToString().Equals("Reject2")) And dtRemark2.Rows(0)("Remarks2").ToString().Equals("Valid")) Then
                                    '                cKR = True
                                    '            Else
                                    '                cKR = False
                                    '            End If
                                    '        Else
                                    '            cKR = False
                                    '        End If
                                    '    Else
                                    '        cKR = False
                                    '    End If

                                    '    If (cKR) Then
                                    '        If (ExecSQL("exec [ess.WFProc] '" & CompNum & "', '" & EmpNum & "', '" & CompNum & "', '" & EmpNum & "', " & PathID & ", 'Performance', '" & GetXML(PathData(0), KeyName:="AppType") & "', 'Approve', 'Dummy', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & EmpNum & "', '" & GetDataText(WorkFlow) & "'")) Then

                                    '            Dim str1 As String = String.Empty

                                    '        End If
                                    '    End If
                                    'End While

                                    'End If

                                    RedirectURL = "tasks.aspx tools/index.aspx"

                                End If

                            Else

                                tblErrorMessage1.Visible = True

                            End If

                        Else

                            tblErrorMessage7.Visible = True

                        End If

                    Else

                        tblErrorMessage2.Visible = True

                    End If

                End If

                'Code for Date Completion

                If (SchemeCode <> "MYE" And SchemeCode <> "SGP") Then

                    Dim dString As String = String.Empty
                    Dim kpaCode As String = String.Empty
                    Dim ratingValue As String = String.Empty
                    Dim hasChanged As Boolean = False

                    Select Case currUser.Value
                        Case "0"
                            kpaCode = "06"
                            hasChanged = Not (lblOrigRatingEmp.Get("lblOrigRatingEmp").ToString().Equals(lblRatingEmp.Get("lblRatingEmp")))
                            ratingValue = lblRatingEmp.Get("lblRatingEmp").ToString()
                        Case "1"
                            kpaCode = "03"
                            hasChanged = Not (lblOrigRatingMan.Get("lblOrigRatingMan").ToString().Equals(lblRatingMan.Get("lblRatingMan").ToString()))
                            ratingValue = lblRatingMan.Get("lblRatingMan").ToString()
                        Case "2"
                            kpaCode = "09"
                            hasChanged = Not (lblOrigRatingNLMan.Get("lblOrigRatingNLMan").ToString().Equals(lblRatingNLMan.Get("lblRatingNLMan").ToString()))
                            ratingValue = lblRatingNLMan.Get("lblRatingNLMan").ToString()
                    End Select

                    If (hasChanged) Then
                        If (ratingValue.ToUpper.Equals("AGREE") Or ratingValue.ToUpper.Equals("DISAGREE")) Then
                            dString = Now.ToString("dd/MM/yyyy HH:mm:ss")
                            ExecSQL("update [PerfEvalKPA] set [Remarks] = '" & dString & "' where [ClassCode] = '4' and [KPACode] = '" & kpaCode & "' and [CompanyNum] = '" & UDetails.CompanyNum & "' and [EmployeeNum] = '" & UDetails.EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                        Else
                            ExecSQL("update [PerfEvalKPA] set [Remarks] = '" & dString & "' where [ClassCode] = '4' and [KPACode] = '" & kpaCode & "' and [CompanyNum] = '" & UDetails.CompanyNum & "' and [EmployeeNum] = '" & UDetails.EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                        End If

                        Select Case currUser.Value
                            Case "0"
                                lblOrigRatingEmp.Set("lblOrigRatingEmp", lblRatingEmp.Get("lblRatingEmp"))
                            Case "1"
                                lblOrigRatingMan.Set("lblOrigRatingMan", lblRatingMan.Get("lblRatingMan"))
                            Case "2"
                                lblOrigRatingNLMan.Set("lblOrigRatingNLMan", lblRatingNLMan.Get("lblRatingNLMan"))
                        End Select
                    End If

                End If

                'End Code for Date Completion

            Catch ex As Exception

            Finally

                If (Not IsNull(objNotes)) Then objNotes = Nothing

                If (Not IsNull(dtScores)) Then

                    dtScores.Dispose()

                    dtScores = Nothing

                End If

                If (Not IsNull(objValue)) Then objValue = Nothing

                If (Not IsNull(objValues)) Then objValues = Nothing

            End Try

        ElseIf (ParamValue = "Edit") Then

            DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("performanceman_003.aspx?ID=" & Session("PathID"))

        End If

    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpExecPrint") = ExecPrint

        e.Properties("cpShowError") = ShowError

        e.Properties("cpRedirectURL") = RedirectURL

        e.Properties("cpSavedText") = SavedText

        If (GetArrayItem(UDetails.Template, "ePerformance.ShowScore")) Then

            e.Properties("cpScore") = Score(0).ToString(NumericFormat)

        Else

            e.Properties("cpScore") = "* hidden"

        End If

        e.Properties("cpCalculateScore") = CalculateScore

    End Sub

    Private Sub dgView_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView.CustomButtonInitialize

        Dim objValues() As Object = sender.GetRowValues(e.VisibleIndex, "StickyNotes", "Type", "Count")

        If (Not IsNull(objValues)) Then

            If (Not IsNull(objValues(0)) AndAlso Not items_001.Contains("row_" & e.VisibleIndex.ToString())) Then items_001.Set("row_" & e.VisibleIndex.ToString(), objValues(0))

            If (objValues(1) = 0 OrElse objValues(2) > 0) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        End If

    End Sub

    Private Sub dgView_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView.CustomColumnDisplayText

        If (e.Column.FieldName = "Name") Then

            Dim objValues() As Object = sender.GetRowValues(e.VisibleRowIndex, "Required", "Name", "Count")

            If (Not IsNull(objValues(0))) Then

                If (objValues(0) AndAlso objValues(2) = 0) Then e.DisplayText = "* " & objValues(1)

            End If

        End If

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound

        Dim ItemKey As String = String.Empty

        Dim dsRangeID As String = String.Empty

        Dim objValues() As Object = Nothing

        Dim objValue As Object = Nothing

        Dim objText As Object = Nothing

        Dim dgColumn As GridViewDataTextColumn = Nothing

        Dim cmbAnswers As ASPxComboBox = Nothing

        Dim txtAnswers As ASPxMemo = Nothing

        Dim dteAnswers As ASPxDateEdit = Nothing

        Dim spAnswers As ASPxSpinEdit = Nothing

        Dim chkAnswers As ASPxCheckBox = Nothing

        Dim sCode As String = String.Empty

        'JR Code

        Dim isFirst As Boolean = False

        isFirst = Convert.ToBoolean(GetFirstTimeHF.Get("GetFirstTimeHF"))

        'End JR Code

        Try

            For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                objValues = sender.GetRowValues(iLoop, "Type", "Count", "RangeType", "ClassCode", "Name", "Description")

                If (objValues(0) > 0) Then

                    If (objValues(1) > maxCount) Then maxCount = objValues(1)

                    If (objValues(0) = 2 OrElse (objValues(0) = 1 AndAlso objValues(1) = 0)) Then

                        ItemKey = "dgView_" & iLoop.ToString("000")

                        dgColumn = TryCast(sender.Columns("Answers"), GridViewDataTextColumn)

                        If (Not IsNull(dgColumn)) Then

                            objText = Nothing

                            Dim cc As String = String.Empty
                            Dim colorControl As String = String.Empty

                            If (Session("LblUser") <> Nothing) Then

                                'JR Code - Controls and Color
                                If (Session("LblUser").ToString().Equals("0")) Then
                                    If (objValues(4).ToString().Contains("Manager")) Then
                                        cc = "Y"
                                    Else
                                        cc = "N"
                                    End If
                                    If (objValues(4).ToString().Contains("Stopper")) Then
                                        cc = "Y"
                                    End If
                                Else
                                    If (objValues(4).ToString().Contains("Manager")) Then
                                        cc = "N"
                                    Else
                                        cc = "Y"
                                    End If
                                    If (objValues(3).ToString().Equals("3B") Or objValues(4).ToString().Contains("Stopper")) Then
                                        cc = "N"
                                    End If
                                End If
                                If (objValues(4).ToString().Contains("Manager") And Not objValues(4).ToString().Contains("Evaluation Concluded On")) Then
                                    colorControl = "Y"
                                Else
                                    colorControl = "N"
                                End If
                                'End JR Code

                                'JR Code - TL, IC
                                If (SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

                                    If (objValues(3).ToString().Equals("1") Or objValues(3).ToString().Equals("4")) Then cc = "Y"

                                    If (Session("LblUser").ToString().Equals("0") AndAlso objValues(3).ToString().Equals("4") AndAlso (objValues(4).ToString().Contains("04") Or objValues(4).ToString().Contains("05"))) Then cc = "N"

                                    If (Session("LblUser").ToString().Equals("1") AndAlso objValues(3).ToString().Equals("4") AndAlso (objValues(4).ToString().Contains("01") Or objValues(4).ToString().Contains("02"))) Then cc = "N"

                                    If (Session("LblUser").ToString().Equals("2") AndAlso objValues(3).ToString().Equals("4") AndAlso (objValues(4).ToString().Contains("02") Or objValues(4).ToString().Contains("07") Or objValues(4).ToString().Contains("08"))) Then cc = "N"

                                    If (Session("LblUser").ToString().Equals("3") AndAlso objValues(3).ToString().Equals("4") AndAlso (objValues(4).ToString().Contains("01") Or objValues(4).ToString().Contains("02") Or objValues(4).ToString().Contains("07") Or objValues(4).ToString().Contains("08"))) Then cc = "N"

                                    If (Session("LblUser").ToString().Equals("0") AndAlso isFirst = True AndAlso objValues(3).ToString().Equals("4") AndAlso objValues(4).ToString().Contains("Employee")) Then cc = "Y"

                                End If
                                'End JR Code

                                'JR Code - Cut off facility
                                'End JR Code

                            End If

                            Select Case objValues(2)

                                Case "-"
                                    objValue = sender.GetRowValues(iLoop, "Description")

                                    txtAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "txtAnswers"), ASPxMemo)

                                    If (Not IsNull(txtAnswers)) Then

                                        If (Not IsNull(objValue)) Then txtAnswers.Value = objValue

                                        If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then txtAnswers.ClientSideEvents.LostFocus = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                        If (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("04")) Then
                                            lblCommentEmp.Set("lblCommentEmp", IIf(IsDBNull(objValue), "", objValue))
                                            txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); EmployeeMethod(s.GetText(),'0'); }"
                                        ElseIf (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("01")) Then
                                            lblCommentMan.Set("lblCommentMan", IIf(IsDBNull(objValue), "", objValue))
                                            txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); ManagerMethod(s.GetText(),'0'); }"
                                        ElseIf (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("07")) Then
                                            lblCommentNLMan.Set("lblCommentNLMan", IIf(IsDBNull(objValue), "", objValue))
                                            txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); NLManagerMethod(s.GetText(),'0'); }"
                                        Else
                                            txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetText()); items_001.Set('" & ItemKey & "_Text', s.GetText()); }"
                                        End If

                                        If (Not txtAnswers.Visible) Then txtAnswers.Visible = True

                                        If (cc.Equals("Y")) Then
                                            txtAnswers.ReadOnly = True
                                        Else
                                            txtAnswers.ReadOnly = False
                                        End If

                                        If (colorControl.Equals("Y")) Then
                                            'If (objValues(3).ToString().Equals("3")) Then
                                            '    txtAnswers.BackColor = Drawing.Color.PaleGoldenrod
                                            'Else
                                            txtAnswers.BackColor = Drawing.Color.Pink
                                            'End If
                                        Else
                                            txtAnswers.BackColor = Drawing.Color.White
                                        End If

                                    End If

                                Case "#"
                                    objValue = sender.GetRowValues(iLoop, "ObtainBy")

                                    dteAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "dteAnswers"), ASPxDateEdit)

                                    If (Not IsNull(dteAnswers)) Then

                                        If (Not IsNull(objValue) AndAlso IsDate(objValue)) Then dteAnswers.Date = objValue

                                        dteAnswers.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

                                        If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then

                                            dteAnswers.ClientSideEvents.DateChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetValue()); window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                        Else

                                            dteAnswers.ClientSideEvents.DateChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetValue()); }"

                                        End If

                                        If (Not dteAnswers.Visible) Then dteAnswers.Visible = True

                                    End If

                                Case Else

                                    If (Regex.IsMatch(objValues(2).ToString(), "^" & EscapeRegex("$"))) Then

                                        objValue = sender.GetRowValues(iLoop, "Value")

                                        spAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "spAnswers"), ASPxSpinEdit)

                                        If (Not IsNull(spAnswers)) Then

                                            If (Not IsNull(objValue)) Then spAnswers.Value = objValue

                                            If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then spAnswers.ClientSideEvents.LostFocus = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                            spAnswers.ClientSideEvents.ValueChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetValue()); }"

                                            If (Not spAnswers.Visible) Then spAnswers.Visible = True

                                            Dim dtBounds As DataTable = Nothing

                                            Try

                                                dsRangeID = "sp" & Regex.Replace(objValues(2), "\W", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                                dtBounds = GetSQLDT("select [FromPerc], [ElementName] from [PerfRangeElements] where ([RangeType] = '" & GetDataText(objValues(2)) & "')", "Data.Evaluations.RangeElements." & dsRangeID)

                                                If (IsData(dtBounds)) Then

                                                    For i As Integer = 0 To (dtBounds.Rows.Count - 1)

                                                        If (IsNumeric(dtBounds.Rows(i).Item("FromPerc"))) Then

                                                            Select Case dtBounds.Rows(i).Item("ElementName").ToString().ToLower()

                                                                Case "increment"
                                                                    spAnswers.Increment = Convert.ToDecimal(dtBounds.Rows(i).Item("FromPerc"))

                                                                Case "minimum"
                                                                    spAnswers.MinValue = Convert.ToDecimal(dtBounds.Rows(i).Item("FromPerc"))

                                                                Case "maximum"
                                                                    spAnswers.MaxValue = Convert.ToDecimal(dtBounds.Rows(i).Item("FromPerc"))

                                                            End Select

                                                        End If

                                                    Next

                                                End If

                                            Catch ex As Exception

                                            Finally

                                                If (Not IsNull(dtBounds)) Then

                                                    dtBounds.Dispose()

                                                    dtBounds = Nothing

                                                End If

                                            End Try

                                        End If

                                    ElseIf (objValues(2) = "!") Then

                                        objValue = sender.GetRowValues(iLoop, "Value")

                                        chkAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "chkAnswers"), ASPxCheckBox)

                                        If (Not IsNull(chkAnswers)) Then

                                            If (Not IsNull(objValue)) Then chkAnswers.Checked = Convert.ToBoolean(objValue)

                                            chkAnswers.ClientSideEvents.CheckedChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetChecked()); items_001.Set('" & ItemKey & "_Text', s.GetChecked());"

                                            If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then chkAnswers.ClientSideEvents.CheckedChanged &= " window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & ");"

                                            chkAnswers.ClientSideEvents.CheckedChanged &= " }"

                                            If (Not chkAnswers.Visible) Then chkAnswers.Visible = True

                                        End If

                                    Else

                                        objValue = sender.GetRowValues(iLoop, "RatingPercentage")

                                        objText = sender.GetRowValues(iLoop, "Value")

                                        cmbAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "cmbAnswers"), ASPxComboBox)

                                        If (Not IsNull(cmbAnswers)) Then

                                            dsRangeID = "cmb" & Regex.Replace(objValues(2), "\W", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                            If (Not csCollection.ContainsKey(dsRangeID)) Then

                                                cmbAnswers.ClientInstanceName = dsRangeID

                                                cmbAnswers.DataSource = GetSQLDT("select [FromPerc], [ElementName] from [PerfRangeElements] where ([RangeType] = '" & GetDataText(objValues(2)) & "') union select -1, '' order by [FromPerc]", "Data.Evaluations.RangeElements." & dsRangeID)

                                                cmbAnswers.DataBind()

                                                If (Not IsNull(objText)) Then

                                                    If (Not IsNull(objValue)) Then cmbAnswers.Value = objValue

                                                    cmbAnswers.Text = objText.ToString()
                                                    cmbAnswers.Value = objText.ToString()

                                                End If

                                                If (SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then
                                                    If (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("05")) Then
                                                        If (Not IsFirstLoading.Contains("IsFirstLoading")) Then
                                                            lblRatingEmp.Set("lblRatingEmp", objText.ToString())
                                                            lblOrigRatingEmp.Set("lblOrigRatingEmp", objText.ToString())
                                                        End If
                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); EmployeeMethod(s.GetText(),'1'); }"
                                                    ElseIf (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("02")) Then
                                                        If (Not IsFirstLoading.Contains("IsFirstLoading")) Then
                                                            lblRatingMan.Set("lblRatingMan", objText.ToString())
                                                            lblOrigRatingMan.Set("lblOrigRatingMan", objText.ToString())
                                                        End If
                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); ManagerMethod(s.GetText(),'1'); }"
                                                    ElseIf (objValues(3).ToString().Equals("4") And objValues(4).ToString().Contains("08")) Then
                                                        If (Not IsFirstLoading.Contains("IsFirstLoading")) Then
                                                            lblRatingNLMan.Set("lblRatingNLMan", objText.ToString())
                                                            lblOrigRatingNLMan.Set("lblOrigRatingNLMan", objText.ToString())
                                                        End If
                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); NLManagerMethod(s.GetText(),'1'); }"
                                                    Else
                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); }"
                                                    End If
                                                Else

                                                    If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then

                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                                    Else

                                                        cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); }"

                                                    End If

                                                End If

                                                If (Not cmbAnswers.Visible) Then cmbAnswers.Visible = True

                                                csCollection.Add(dsRangeID, cmbAnswers.Items.Count)

                                            Else

                                                cmbAnswers.ClientSideEvents.GotFocus = "function(s, e) { copy(" & dsRangeID & ", s, " & csCollection(dsRangeID).ToString() & "); }"

                                                If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then

                                                    cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                                Else

                                                    cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); }"

                                                End If

                                                If (Not cmbAnswers.Visible) Then cmbAnswers.Visible = True

                                                If (Not IsNull(objText)) Then cmbAnswers.Text = objText.ToString()

                                            End If

                                            If (cc.Equals("Y")) Then
                                                cmbAnswers.Enabled = False
                                            Else
                                                cmbAnswers.Enabled = True
                                            End If

                                            If (colorControl.Equals("Y")) Then
                                                'If (objValues(3).ToString().Equals("3")) Then
                                                '    cmbAnswers.BackColor = Drawing.Color.PaleGoldenrod
                                                'Else
                                                cmbAnswers.BackColor = Drawing.Color.Pink
                                                'End If
                                            Else
                                                cmbAnswers.BackColor = Drawing.Color.White
                                            End If

                                        End If

                                    End If

                            End Select

                            If (Not items_001.Contains(ItemKey & "_Value")) Then items_001.Add(ItemKey & "_Value", objValue)

                            If (Not items_001.Contains(ItemKey & "_Text")) Then items_001.Add(ItemKey & "_Text", objText)

                        End If

                    End If

                End If

            Next

        Catch ex As Exception

            Dim stringVal As String = ex.Message

        Finally

            If (Not IsNull(dgColumn)) Then dgColumn = Nothing

            If (Not IsNull(cmbAnswers)) Then

                cmbAnswers.Dispose()

                cmbAnswers = Nothing

            End If

            If (Not IsNull(txtAnswers)) Then

                txtAnswers.Dispose()

                txtAnswers = Nothing

            End If

            If (Not IsNull(dteAnswers)) Then

                dteAnswers.Dispose()

                dteAnswers = Nothing

            End If

            If (Not IsNull(objValue)) Then objValue = Nothing

            If (Not IsNull(objText)) Then objText = Nothing

            If (Not IsNull(objValues)) Then objValues = Nothing

        End Try

    End Sub

    Private Sub dgView_HtmlDataCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableDataCellEventArgs) Handles dgView.HtmlDataCellPrepared

        If (e.DataColumn.FieldName = "Name") Then

            Dim objValues() As Object = sender.GetRowValues(e.VisibleIndex, "Type", "Count", "Desc")

            If (Not IsNull(objValues(2))) Then

                e.Cell.Style.Add("cursor", "pointer")

                e.Cell.ToolTip = objValues(2)

                If (Regex.IsMatch(objValues(2).ToString(), "^https?://")) Then e.Cell.Attributes.Add("onclick", "window.open('" & objValues(2) & "');")

            End If

            Select Case objValues(0)

                Case 0
                    e.Cell.Style.Add("font-family", "Arial Rounded MT Bold")
                    e.Cell.Style.Add("font-size", "12pt")
                    e.Cell.Style.Add("text-align", "center")

                Case 1
                    If (objValues(1) > 0 OrElse maxCount > 0) Then e.Cell.Style.Add("font-family", "Arial Rounded MT Bold")

                    If (Not GenerateClass) Then

                        e.Cell.Style.Add("font-size", "8pt")
                        e.Cell.Style.Add("padding-left", "15px")

                    Else

                        e.Cell.Style.Add("font-size", "8pt")
                        e.Cell.Style.Add("padding-left", "15px")

                    End If

                Case 2
                    e.Cell.Style.Add("font-size", "8pt")
                    e.Cell.Style.Add("padding-left", "45px")

            End Select

        End If

    End Sub

    Private Sub dgView_HtmlRowPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles dgView.HtmlRowPrepared

        If (Not e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.Data) Then Exit Sub

        Dim objValues() As Object = sender.GetRowValues(e.VisibleIndex, "Type", "Count")

        Select Case objValues(0)

            Case 0
                e.Row.BackColor = hColor

                e.Row.Font.Bold = True

            Case 1
                If (objValues(1) > 0 OrElse maxCount > 0) Then

                    e.Row.BackColor = hColor

                    e.Row.Font.Bold = True

                End If

        End Select

        If (Not IsNull(objValues)) Then objValues = Nothing

    End Sub

#End Region

#Region " *** JR Functions *** "

    Private Function GetDataFromSGP(ByVal PathID As String, ByVal EvalDate As Date) As Boolean

        Dim isSuccess As Boolean = False

        Try
            Dim dt As DataTable = GetSQLDT(String.Format("SELECT ClassCode, KPACode, CONVERT(VARCHAR(10),ObtainBy,101) AS 'ObtainBy', Remarks FROM PerfEvalKPA where (ObtainBy <> '' or Remarks <> '') and CompanyNum = '{0}' and EmployeeNum = '{1}' and KPAName Not Like '%Manager%' and EvalDate = (SELECT TOP 1 EvalDate FROM PerfEvalScheme where CompanyNum = '{0}' and EmployeeNum = '{1}' and EvalDate <= '{2}' and SchemeCode = 'SGP' order by EvalDate desc)", UDetails.CompanyNum, UDetails.EmployeeNum, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")))

            For Each row As DataRow In dt.Rows
                If (row("ObtainBy").ToString.Equals(String.Empty)) Then
                    ExecSQL(String.Format("UPDATE [PerfEvalKPA] Set [Remarks] = '{1}' WHERE [SchemeCode] = 'MYE' and [CompanyNum] = '{2}' and [EmployeeNum] = '{3}' and [EvalDate] = (SELECT TOP 1 EvalDate FROM PerfEvalScheme WHERE CompanyNum = '{2}' and EmployeeNum = '{3}' and SchemeCode = 'MYE' ORDER BY EvalDate DESC) and [ClassCode] = '{5}' and [KPACode] = '{6}'", row("ObtainBy"), row("Remarks"), UDetails.CompanyNum, UDetails.EmployeeNum, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000"), row("ClassCode"), row("KPACode")))
                Else
                    ExecSQL(String.Format("UPDATE [PerfEvalKPA] Set [ObtainBy] = '{0}' WHERE [SchemeCode] = 'MYE' and [CompanyNum] = '{2}' and [EmployeeNum] = '{3}' and [EvalDate] = (SELECT TOP 1 EvalDate FROM PerfEvalScheme WHERE CompanyNum = '{2}' and EmployeeNum = '{3}' and SchemeCode = 'MYE' ORDER BY EvalDate DESC) and [ClassCode] = '{5}' and [KPACode] = '{6}'", row("ObtainBy"), row("Remarks"), UDetails.CompanyNum, UDetails.EmployeeNum, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000"), row("ClassCode"), row("KPACode")))
                End If
            Next

            isSuccess = True

        Catch ex As Exception

        End Try

        Return isSuccess

    End Function

    Private Sub GetFirstTime()

        Dim valFirstTime As Boolean = GetSQLField(String.Format("SELECT MAX(Score) AS 'ScoreCount' FROM PerfEvalClass WHERE ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "ScoreCount") = 0

        GetFirstTimeHF.Set("GetFirstTimeHF", valFirstTime.ToString())

    End Sub

    Private Function GetFilledValue() As Boolean

        If (SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

            Dim comCount As Object = GetSQLField(String.Format("SELECT MAX(KPACode) AS 'ComCount' FROM PerfEvalCse WHERE ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "ComCount")

            Dim ratingsCount As Object

            If (currUser.Value.Equals("0")) Then

                ratingsCount = GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '01. Employee Rating' and ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            Else

                ratingsCount = GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '03. Manager Rating' and ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            End If

            Return comCount = ratingsCount

        Else

            Return True

        End If

    End Function

    Private Function GetValuesSection() As Boolean

        If (SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

            Dim ratingsCount As Object

            If (currUser.Value.Equals("0")) Then

                ratingsCount = GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '01. Employee Rating' and ClassCode = '3' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            Else

                ratingsCount = GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '03. Manager Rating' and ClassCode = '3' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            End If

            Return ratingsCount = 6

        Else

            Return True

        End If

    End Function

    Private Sub AddCompetency()

        If (SchemeCode.Equals("TL") Or SchemeCode.Equals("IC") Or SchemeCode.Equals("SL") Or SchemeCode.Equals("OL")) Then

            'If (currUser.Value.Equals("0")) Then

            '    GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '01. Employee Rating' and ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            'Else

            '    ratingsCount = GetSQLField(String.Format("SELECT COUNT(ElementName) AS 'RatingsCount' FROM PerfEvalCse WHERE CseName = '03. Manager Rating' and ClassCode = '2' and CompanyNum = '{0}' and EmployeeNum = '{1}' and SchemeCode = '{2}' and [EvalDate] = '{3}'", UDetails.CompanyNum, UDetails.EmployeeNum, SchemeCode, EvalDate.ToString("yyyy-MM-dd HH:mm:ss.000")), "RatingsCount")

            'End If

        End If

    End Sub

    Private Sub EnableDisableControls()

        If (currUser.Value.Equals("0")) Then

            cmdAppraise.Enabled = False
            cmdAppraise2.Enabled = False

            If (Not lblCommentEmp.Get("lblCommentEmp").Equals(String.Empty) And Not lblRatingEmp.Get("lblRatingEmp").Equals(String.Empty)) Then

                tblErrorMessage3.Text = String.Empty

            End If

        ElseIf (currUser.Value.Equals("1")) Then

            cmdAppraise.Enabled = False

            If (lblCommentEmp.Get("lblCommentEmp").Equals(String.Empty) Or lblRatingEmp.Get("lblRatingEmp").Equals(String.Empty)) Then

                cmdSubmit.Enabled = False
                tblErrorMessage3.Text = SetMessage3.Get("SetMessage3")

            End If

        ElseIf (currUser.Value.Equals("2")) Then

            If (lblCommentNLMan.Get("lblCommentNLMan").Equals(String.Empty) Or lblRatingNLMan.Get("lblRatingNLMan").Equals(String.Empty)) Then

                tblErrorMessage6.Text = SetMessage6.Get("SetMessage6")

            End If

        End If

    End Sub

#End Region

End Class