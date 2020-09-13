Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports DevExpress.Web.ASPxPanel

Partial Public Class performanceman_004
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

    Private iAnswered1 As Integer = 0

    Private blnIsPostback As Boolean = False

    Private CalculateScore As Boolean

    Private ExecPrint As Boolean

    Private iItemCounter As Integer

    Private didAutoSave As Boolean = False
#Region " *** Web Form Functions *** "


    Private Function IsLeadershipHeaderQuestion(ByVal iRowNumber As Integer) As Boolean
        Dim blnReturn As Boolean = False

        If iRowNumber + 1 < dgView.VisibleRowCount Then
            Dim row1 As Object() = dgView.GetRowValues(iRowNumber, "ClassCode", "Sort")
            Dim row2 As Object() = dgView.GetRowValues(iRowNumber + 1, "ClassCode", "Sort")
            Dim KPACode1 As String = If(row1(1).ToString().Length < 4, If(IsNull(row1(1)), "", row1(1).ToString()) & "       ", row1(1))
            Dim KPACode2 As String = If(row2(1).ToString().Length < 4, If(IsNull(row2(1)), "", row2(1).ToString()) & "       ", row2(1))
            If row1(0) = row2(0) AndAlso row1(0) = "LDR" AndAlso _
                KPACode1.Substring(0, 3) = KPACode2.Substring(0, 3) _
                AndAlso KPACode1(3) <> "z" AndAlso KPACode2(3) = "z" Then
                blnReturn = True
            End If
        End If

        Return blnReturn
    End Function


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

                'RNaanep 07012015
                Dim xTable As String = String.Empty
                Dim dtPreResponse As DataTable = Nothing
                dtPreResponse = GetSQLDT("SELECT * FROM [PerfEvalKPA] WHERE CompanyNum = '" & CompanyNum & "' AND EmployeeNum = '" & EmployeeNum & "' ORDER BY SchemeCode, EvalDate DESC")
                If dtPreResponse.Rows.Count > 0 Then
                    xTable = "PerfEvalKPA"
                Else
                    xTable = "GSC_PerfEvalKPAPrevious"
                End If


                'ReturnText = "select 0 as [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] as [CompositeKey],                   0 as [Type], [ClassCode], null as [Sort], upper([ClassName]) as [Name], '' as [RangeType],'' as [PreviousAnswer], '' as [Value], [Weight], [RatingPercentage], [Score], '' as [Description],                getdate() as [ObtainBy], '' as [Desc],                                                                                                                                                                          0 as [Count],                                                                                                                                                '' as [StickyNotes],                   '' as [Answers], " & SQLAnswers(0, 0) & " as [Answers_010], " & SQLAnswers(0, 1) & " as [Answers_011], " & SQLAnswers(0, 2) & " as [Answers_012] from [PerfEvalClass] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '             "select [Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,           [ClassCode], [KPACode],      [KPAName],                    [RangeType],       '' as [PreviousAnswer],       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfKPA] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]),                                  (select count([CSEName]) from [PerfEvalCSE] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]), cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(1, 0) & ",                  " & SQLAnswers(1, 1) & ",                  " & SQLAnswers(1, 2) & "                  from [PerfEvalKPA] as [pKPA] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '            "select [Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,           [ClassCode], [KPACode],      [CSEName],                    [RangeType],       '' as [PreviousAnswer],       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfCSE] where [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode] = [pCSE].[ClassCode] and [KPACode] = [pCSE].[KPACode] and [CSEName] = [pCSE].[CSEName]), 0,                                                                                                                                                           cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(2, 0) & ",                  " & SQLAnswers(2, 1) & ",                  " & SQLAnswers(2, 2) & "                  from [PerfEvalCSE] as [pCSE] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') order by [ClassCode], [Sort], [Type], [Name]"
                If EvalDate.Year = 2014 Then

                    ReturnText = "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END) as [Aspect], 0 as [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] as [CompositeKey],                   0 as [Type], [ClassCode], null as [Sort], upper([ClassName]) as [Name], '' as [RangeType],                                                                                                                                                                                                                                                                              '' as [Prev], '' as [Value], [Weight], [RatingPercentage], [Score], '' as [Description],                getdate() as [ObtainBy], '' as [Desc],                                                                                                                                                                          0 as [Count],                                                                                                                                                '' as [StickyNotes],                   '' as [Answers], " & SQLAnswers(0, 0) & " as [Answers_010], " & SQLAnswers(0, 1) & " as [Answers_011], " & SQLAnswers(0, 2) & " as [Answers_012] from [PerfEvalClass] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                            "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,           [ClassCode], [KPACode],      [KPAName],                    [RangeType],(select top 1 isnull(ElementName,'') from [" & xTable & "]  where ([CompanyNum] = [pKPA].CompanyNum and [KPACode] = [pKPA].[KPACode] and [ClassCode]=[pKPA].[ClassCode] and [EmployeeNum] = [pKPA].[EmployeeNum] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')ORDER BY SchemeCode, EvalDate DESC),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfKPA] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]),                                  (select count([CSEName]) from [PerfEvalCSE] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]), cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(1, 0) & ",                  " & SQLAnswers(1, 1) & ",                  " & SQLAnswers(1, 2) & "                  from [PerfEvalKPA] as [pKPA] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                            "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,           [ClassCode], [KPACode],      [CSEName],                    [RangeType],(select top 1 isnull(ElementName,'') from [PerfEvalCSE]  where ([CompanyNum] = [pCSE].[CompanyNum] and [EmployeeNum] = [pCSE].[EmployeeNum] and [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode]=[pCSE].[ClassCode] and [KPACode]=[pCSE].[KPACode] and [CSEName]=[pCSE].[CSEName] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfCSE] where [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode] = [pCSE].[ClassCode] and [KPACode] = [pCSE].[KPACode] and [CSEName] = [pCSE].[CSEName]), 0,                                                                                                                                                           cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(2, 0) & ",                  " & SQLAnswers(2, 1) & ",                  " & SQLAnswers(2, 2) & "                  from [PerfEvalCSE] as [pCSE] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') order by [Aspect],[ClassCode], [Sort], [Type], [Name]"

                Else
                    ReturnText = "SELECT (CASE WHEN [ClassCode] = 'COMV' THEN 2 WHEN [ClassCode] = 'ESY' THEN 3 ELSE 1 END) AS [Aspect], 0 AS [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + CONVERT(NVARCHAR(19), [EvalDate], 120) + ' ' + [ClassCode] AS [CompositeKey], 0 AS [Type],[ClassCode], NULL AS [Sort], UPPER([ClassName]) AS [Name], '' AS [RangeType], '' AS [Prev], '' AS [Value],[Weight],[RatingPercentage],[Score], '' AS [Description], GETDATE() AS [ObtainBy], '' AS [Desc], 0 AS [Count], '' AS [StickyNotes], '' AS [Answers], " & SQLAnswers(0, 0) & " AS [Answers_010], " & SQLAnswers(0, 1) & " AS [Answers_011], " & SQLAnswers(0, 2) & " AS [Answers_012] FROM [PerfEvalClass] WHERE ([CompanyNum] = '" & CompanyNum & "' AND [EmployeeNum] = '" & EmployeeNum & "' AND [SchemeCode] = '" & SchemeCode & "' AND [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') UNION " & _
                                 "SELECT (CASE WHEN [ClassCode] = 'COMV' THEN 2 WHEN [ClassCode] = 'ESY' THEN 3 ELSE 1 END),[Required],[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + CONVERT(NVARCHAR(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,[ClassCode],[KPACode],[KPAName],[RangeType]," & _
                                 "(SELECT TOP 1 ISNULL(ElementName,'') FROM (SELECT SchemeCode, EmployeeNum, MAX(EvalDate) AS [EvalDate] FROM PerfEvalScheme WHERE Completed = 1 AND EmployeeNum = '" & EmployeeNum & "' GROUP BY SchemeCode, EmployeeNum) AS xA INNER JOIN [" & xTable & "] AS xB ON xA.SchemeCode = xB.SchemeCode AND xA.EmployeeNum = xB.EmployeeNum AND xA.EvalDate = xB.EvalDate WHERE ([Notes] = [pKPA].[Notes] OR [ClassCode] != 'LDR') AND SUBSTRING(xB.KPACode,0,4) = SUBSTRING(pKPA.KPACode,0,4) AND xA.[EmployeeNum] = [pKPA].[EmployeeNum] AND [ClassCode] = [pKPA].[ClassCode] AND xA.[EvalDate] != '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "' ORDER BY xA.SchemeCode DESC, xA.EvalDate DESC)" & _
                                 ",[ElementName],[Weight],[RatingPercentage],[Score], CONVERT(NVARCHAR(4000),[Remarks]),[ObtainBy],(SELECT [Description] FROM [PerfKPA] WHERE [SchemeCode] = [pKPA].[SchemeCode] AND [ClassCode] = [pKPA].[ClassCode] AND [KPACode] = [pKPA].[KPACode]),(SELECT COUNT([CSEName]) FROM [PerfEvalCSE] WHERE [SchemeCode] = [pKPA].[SchemeCode] AND [ClassCode] = [pKPA].[ClassCode] AND [KPACode] = [pKPA].[KPACode]), CAST([StickyNotes] AS NVARCHAR(4000)), '', " & SQLAnswers(1, 0) & ", " & SQLAnswers(1, 1) & ", " & SQLAnswers(1, 2) & " FROM [PerfEvalKPA] AS [pKPA] WHERE ([CompanyNum] = '" & CompanyNum & "' AND [EmployeeNum] = '" & EmployeeNum & "' AND [SchemeCode] = '" & SchemeCode & "' AND [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') UNION " & _
                                 "SELECT (CASE WHEN [ClassCode] = 'COMV' THEN 2 WHEN [ClassCode] = 'ESY' THEN 3 ELSE 1 END),[Required],[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + CONVERT(NVARCHAR(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,[ClassCode],[KPACode],[CSEName],[RangeType],(SELECT TOP 1 ISNULL(ElementName,'') FROM [PerfEvalCSE]    WHERE ([CompanyNum] = [pCSE].[CompanyNum] AND [EmployeeNum] = [pCSE].[EmployeeNum] AND [KPACode] = [pCSE].[KPACode] AND [ClassCode] = [pCSE].[ClassCode] AND [SchemeCode] = [pCSE].[SchemeCode] AND [CSEName] = [pCSE].[CSEName] AND [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')),[ElementName],[Weight],[RatingPercentage],[Score], CONVERT(NVARCHAR(4000), [Remarks]), [ObtainBy],(SELECT [Description] FROM [PerfCSE] WHERE [SchemeCode] = [pCSE].[SchemeCode] AND [ClassCode] = [pCSE].[ClassCode] AND [KPACode] = [pCSE].[KPACode] AND [CSEName] = [pCSE].[CSEName]), 0, CAST([StickyNotes] AS NVARCHAR(4000)), '', " & SQLAnswers(2, 0) & ", " & SQLAnswers(2, 1) & ", " & SQLAnswers(2, 2) & " FROM [PerfEvalCSE] AS [pCSE] WHERE ([CompanyNum] = '" & CompanyNum & "' AND [EmployeeNum] = '" & EmployeeNum & "' AND [SchemeCode] = '" & SchemeCode & "' AND [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') ORDER BY [Aspect], [ClassCode], [Sort], [Type], [Name]"

                End If

                'ReturnText = "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END) as [Aspect], 0 as [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] as [CompositeKey],                   0 as [Type], [ClassCode], null as [Sort], upper([ClassName]) as [Name], '' as [RangeType],                                                                                                                                                                                                                                                                              '' as [Prev], '' as [Value], [Weight], [RatingPercentage], [Score], '' as [Description],                getdate() as [ObtainBy], '' as [Desc],                                                                                                                                                                          0 as [Count],                                                                                                                                                '' as [StickyNotes],                   '' as [Answers], " & SQLAnswers(0, 0) & " as [Answers_010], " & SQLAnswers(0, 1) & " as [Answers_011], " & SQLAnswers(0, 2) & " as [Answers_012] from [PerfEvalClass] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '            "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,           [ClassCode], [KPACode],      [KPAName],                    [RangeType],(select top 1 isnull(ElementName,'') from [" & xTable & "]  where ([CompanyNum] = [pKPA].CompanyNum and [KPACode] = [pKPA].[KPACode] and [ClassCode]=[pKPA].[ClassCode] and [EmployeeNum] = [pKPA].[EmployeeNum] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')ORDER BY SchemeCode, EvalDate DESC),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfKPA] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]),                                  (select count([CSEName]) from [PerfEvalCSE] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]), cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(1, 0) & ",                  " & SQLAnswers(1, 1) & ",                  " & SQLAnswers(1, 2) & "                  from [PerfEvalKPA] as [pKPA] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '            "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,           [ClassCode], [KPACode],      [CSEName],                    [RangeType],(select top 1 isnull(ElementName,'') from [PerfEvalCSE]  where ([CompanyNum] = [pCSE].[CompanyNum] and [EmployeeNum] = [pCSE].[EmployeeNum] and [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode]=[pCSE].[ClassCode] and [KPACode]=[pCSE].[KPACode] and [CSEName]=[pCSE].[CSEName] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfCSE] where [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode] = [pCSE].[ClassCode] and [KPACode] = [pCSE].[KPACode] and [CSEName] = [pCSE].[CSEName]), 0,                                                                                                                                                           cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(2, 0) & ",                  " & SQLAnswers(2, 1) & ",                  " & SQLAnswers(2, 2) & "                  from [PerfEvalCSE] as [pCSE] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') order by [Aspect],[ClassCode], [Sort], [Type], [Name]"

                'ReturnText = "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END) as [Aspect], 0 as [Required], [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] as [CompositeKey],                   0 as [Type], [ClassCode], null as [Sort], upper([ClassName]) as [Name], '' as [RangeType],                                                                                                                                                                                                                                                                              '' as [Prev], '' as [Value], [Weight], [RatingPercentage], [Score], '' as [Description],                getdate() as [ObtainBy], '' as [Desc],                                                                                                                                                                          0 as [Count],                                                                                                                                                '' as [StickyNotes],                   '' as [Answers], " & SQLAnswers(0, 0) & " as [Answers_010], " & SQLAnswers(0, 1) & " as [Answers_011], " & SQLAnswers(0, 2) & " as [Answers_012] from [PerfEvalClass] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '        "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode],                   1,           [ClassCode], [KPACode],      [KPAName],                    [RangeType],(select top 1 isnull(ElementName,'') from [PerfEvalKPA]  where ([CompanyNum] = [pKPA].CompanyNum and [KPACode] = [pKPA].[KPACode] and [ClassCode]=[pKPA].[ClassCode] and [EmployeeNum] = [pKPA].[EmployeeNum] and [SchemeCode] = [pKPA].[SchemeCode] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfKPA] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]),                                  (select count([CSEName]) from [PerfEvalCSE] where [SchemeCode] = [pKPA].[SchemeCode] and [ClassCode] = [pKPA].[ClassCode] and [KPACode] = [pKPA].[KPACode]), cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(1, 0) & ",                  " & SQLAnswers(1, 1) & ",                  " & SQLAnswers(1, 2) & "                  from [PerfEvalKPA] as [pKPA] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') union " & _
                '        "select (case when [ClassCode]='COMV' THEN 2 WHEN [ClassCode]= 'ESY' then 3 ELSE 1 END),[Required],      [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName], 2,           [ClassCode], [KPACode],      [CSEName],                    [RangeType],(select top 1 isnull(ElementName,'') from [PerfEvalCSE]  where ([CompanyNum] = [pCSE].[CompanyNum] and [EmployeeNum] = [pCSE].[EmployeeNum] and [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode]=[pCSE].[ClassCode] and [KPACode]=[pCSE].[KPACode] and [CSEName]=[pCSE].[CSEName] and [EvalDate] < '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "')),       [ElementName], [Weight], [RatingPercentage], [Score], convert(nvarchar(4000), [Remarks]), [ObtainBy],              (select [Description] from [PerfCSE] where [SchemeCode] = [pCSE].[SchemeCode] and [ClassCode] = [pCSE].[ClassCode] and [KPACode] = [pCSE].[KPACode] and [CSEName] = [pCSE].[CSEName]), 0,                                                                                                                                                           cast([StickyNotes] as nvarchar(4000)), '',              " & SQLAnswers(2, 0) & ",                  " & SQLAnswers(2, 1) & ",                  " & SQLAnswers(2, 2) & "                  from [PerfEvalCSE] as [pCSE] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [SchemeCode] = '" & SchemeCode & "' and [EvalDate] = '" & EvalDate.ToString("yyyy-MM-dd HH:mm:ss") & "') order by [Aspect],[ClassCode], [Sort], [Type], [Name]"

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

    Private Function GetTotalQuestion() As Single


        Dim Params() As Object = GetSQLFields("Select CompanyNum, EmployeeNum, SchemeCode, EvalDate from PerfEvalScheme where PathID = '" & PathID & "'")

        Dim sql As String = "select * from perfevalkpa where companynum='" & Params(0) & "' and EmployeeNum='" & Params(1) & "' and SchemeCode='" & Params(2) & "' and evaldate='" & Convert.ToDateTime(Params(3)).ToString("yyyy-MM-dd HH:mm:ss") & "' and not (ClassCode = 'LDR' and KPACode in (select KPACode from PerfKPA where SchemeCode='" & Params(2) & "' and ClassCode='LDR'))"

        Return GetSQLDT(sql).Rows.Count

    End Function

    Private Function GetTotalAnswer() As Single


        Dim Params() As Object = GetSQLFields("Select CompanyNum, EmployeeNum, SchemeCode, EvalDate from PerfEvalScheme where PathID = '" & PathID & "'")

        Dim sql As String = "select * from perfevalkpa where companynum='" & Params(0) & "' and EmployeeNum='" & Params(1) & "' and SchemeCode='" & Params(2) & "' and evaldate='" & Convert.ToDateTime(Params(3)).ToString("yyyy-MM-dd HH:mm:ss") & "' and not (ClassCode = 'LDR' and KPACode in (select KPACode from PerfKPA where SchemeCode='" & Params(2) & "' and ClassCode='LDR')) and (RatingPercentage > 0 Or (Remarks is not null and Remarks <> ''))"

        Return GetSQLDT(sql).Rows.Count

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
                Dim query As String = GetSQLText(.CompanyNum, .EmployeeNum)
                dtTable = GetSQLDT(query, "Data.Evaluations.EvalForm." & Session.SessionID)



                If (dtTable.Compute("Count([Type])", "[Type] = 0") <= 1) Then

                    dtTable.DefaultView.RowFilter = "not [Type] = 0"

                Else

                    GenerateClass = True

                End If

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

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        blnIsPostback = IsPostBack


        For ctr As Integer = 0 To (Session.Contents.Keys.Count - 1)

        Next


        If (IsNull(csCollection)) Then

            csCollection = New Hashtable()

        Else

            csCollection.Clear()

        End If

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "Performance Tab")

        LoadData(Not IsPostBack)

        UDetails = GetUserDetails(Session, "Performance Tab", True)

        If (Not IsPostBack) Then


            With UDetails

                CType(pnlEvaluations.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Evaluation: (" & .CompanyNum & ", " & If(Not IsNull(.EmployeeNum), .EmployeeNum, "") & ") - " & If(Not IsNull(.Surname), .Surname, "") & ", " & If(Not IsNull(.Name), .Name, "") & " [" & SchemeName & "]"

            End With

            CalculateScore = True


            Dim objData() As Object = GetSQLFields("select [CompanyNum], [EmployeeNum], [PerfEvalScheme].[SchemeCode], [EvalDate], [Score], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', Convert(Varchar(1), [Completed]) AS 'Completed',[Description] from [PerfEvalScheme] inner join [PerfScheme] on [PerfEvalScheme].[SchemeCode]=[PerfScheme].[SchemeCode] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))")


            If (IsNull(objData)) Then objData = GetSQLFields("select [CompanyNum], [EmployeeNum], [PerfEvalScheme].[SchemeCode], [EvalDate], [Score], CONVERT(VARCHAR(11), [EvalDate], 103) AS 'DateEval', Convert(Varchar(1), [Completed]) AS 'Completed',[Description] from [PerfEvalScheme] inner join [PerfScheme] on [PerfEvalScheme].[SchemeCode]=[PerfScheme].[SchemeCode]  where ([PathID] = " & PathID & ")")


            Dim logged As SmartHR.main.Users = Session("LoggedOn")

            lblInstruction.Text = If(IsNull(objData), "", String.Format("Instructions: {0}", If(objData(7).ToString().Contains("</br>"), objData(7).ToString().Replace("</br>", Environment.NewLine), objData(7))))
            lblDivision.Text = "Division: " & logged.Division
            lblDepartment.Text = "Department: " & logged.Department
            lblSection.Text = "Section: " & logged.SubDivision
            lblPosition.Text = ""

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


            End If

            Dim iTotalQuestion As Single
            Dim iTotalAnswer As Single

            iTotalQuestion = GetTotalQuestion()
            iTotalAnswer = GetTotalAnswer()

            cmdSubmit.ClientEnabled = (iTotalAnswer / iTotalQuestion) * 100.0 = 100.0

            ClientScript.RegisterStartupScript(Me.GetType(), "Javascript", "javascript:prgIndicator.SetPosition(" & (iTotalAnswer / iTotalQuestion) * 100.0 & ");", True)

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
        If (ParamValue.StartsWith("SaveItem ") OrElse ParamValue = "Save" OrElse ParamValue = "AutoSave" OrElse ParamValue.Contains("Submit")) Then

            If ParamValue = "AutoSave" Then didAutoSave = True

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

            Dim objComment As Object = Nothing

            Try

                Dim iStart As Integer = 0

                Dim iUntil As Integer = (dgView.VisibleRowCount - 1)

                If (ParamValue.StartsWith("SaveItem ")) Then

                    iStart = Convert.ToInt32(Values(1))

                    iUntil = iStart

                End If

                'RNaanep
                Dim xBulkUpdate As String = String.Empty

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

                                    objComment = items_001.Get(ItemKey & "_CommentValue")

                                    If (Not IsNull(objValue) AndAlso Not IsNull(objText)) Then

                                        bExecute = True

                                        bType = Convert.ToByte(objValues(0))

                                        Select Case objValues(0)

                                            Case 1
                                                SQL = "update [PerfEvalKPA] set <%Values%>"

                                                'SQL &= " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] = '"

                                            Case 2
                                                SQL = "update [PerfEvalCSE] set <%Values%>"

                                                'SQL &= " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName] = '"

                                        End Select

                                        Select Case objValues(2)

                                            Case "-"
                                                SQL = SQL.Replace("<%Values%>", "[Remarks] = '" & GetDataText(objValue.ToString()) & "'")
                                                'insert here
                                                Dim iRow As Integer
                                                If (ParamValue.Contains("SaveItem") OrElse ParamValue = "Save") AndAlso Not ParamValue.Contains("NOTES") Then

                                                    'iRow = Integer.Parse(Values(1))
                                                    iRow = Integer.Parse(iLoop)

                                                End If
                                            Case "#"
                                                If (IsDate(objValue)) Then

                                                    SQL = SQL.Replace("<%Values%>", "[ObtainBy] = '" & Convert.ToDateTime(objValue).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                                                Else

                                                    bExecute = False

                                                End If

                                            Case Else

                                                Dim iRow As Integer
                                                If (ParamValue.Contains("SaveItem")) Then
                                                    iRow = Integer.Parse(Values(1))
                                                End If

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

                                                            SQL = SQL.Replace("<%Values%>", "[ElementName] = '" & GetDataText(objText.ToString()) & "', [RatingPercentage] = " & iValue.ToString("0.00") & ", [StickyNotes] = '" & GetDataText(objComment) & "'")

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

                                                        SQL = SQL.Replace("<%Values%>", "[ElementName] = '" & GetDataText(objText.ToString()) & "', [RatingPercentage] = " & objValue.ToString() & ", [StickyNotes] = '" & GetDataText(objComment) & "'")

                                                    End If

                                                End If

                                        End Select

                                        'RNaanep
                                        Dim xPrimaryKeys() As String = GetDataText(objValues(3).ToString()).Split(" ")

                                        SQL &= " WHERE ([CompanyNum] = '" & xPrimaryKeys(0).ToString() & "' AND [EmployeeNum] = '" & xPrimaryKeys(1).ToString() & "' AND [SchemeCode] = '" & xPrimaryKeys(2).ToString() & "' AND [EvalDate] = '" & xPrimaryKeys(3).ToString() & "' AND [ClassCode] = '" & xPrimaryKeys(4).ToString() & "' AND [KPACode] = '" & xPrimaryKeys(5).ToString() & "') "

                                        xBulkUpdate &= SQL
                                        'SQL &= GetDataText(objValues(3).ToString()) & "')"

                                        'If (bExecute) Then ExecSQL(SQL)

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

                If (bExecute) Then ExecSQL(xBulkUpdate)

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

                    If (IsData(dtScores)) Then

                        For iLoop As Integer = 0 To (dtScores.Rows.Count - 1)

                            With dtScores.Rows(iLoop)

                                If (IsNull(.Item("Tot"))) Then

                                    ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = 0 where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

                                Else

                                    ExecSQL("update [PerfEvalKPA] set [ElementName] = 'Sum of CSE Scores', [RatingPercentage] = " & .Item("Tot").ToString() & " where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) = '" & GetDataText(CompositeKey) & "' and [ClassCode] = '" & GetDataText(.Item("ClassCode").ToString()) & "' and [KPACode] = '" & GetDataText(.Item("KPAcode").ToString()) & "')")

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

                ElseIf (ParamValue.StartsWith("SaveItem ")) Then

                    CalculateScore = True

                    Score(0) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

                    Score(1) = GetSQLField("select [Score] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

                    If (IsNull(Score(0))) Then Score(0) = 0

                    If (IsNull(Score(1))) Then Score(1) = 0

                    If (Score(0) = 0 AndAlso Score(1) > 0) Then Score(0) = Score(1)

                    'cpPage.JSProperties("cpFromSave") = "Saved"

                    Session("FromSave") = "Saved"

                ElseIf (ParamValue.Contains("Reject")) Then



                End If

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

        End If

        If (ParamValue.Contains("Submit")) Then


            Dim PathData() As String = {String.Empty, String.Empty}

            Dim GroupName As String = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & " and [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = " & PathID & ")))))))", "Score")

            If (IsNull(GroupName)) Then GroupName = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & PathID & ")", "Score")

            PathData(0) = GetPathData(PathID)

            If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Performance', '" & GetXML(PathData(0), KeyName:="AppType") & "', '" & GetXML(PathData(0), KeyName:="StatusType") & "', '" & GetXML(PathData(0), KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & Session("LoggedOn").UserID & "', '" & GetDataText(WorkFlow) & "'")) Then

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
        End If
    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpExecPrint") = ExecPrint

        e.Properties("cpShowError") = ShowError

        e.Properties("cpRedirectURL") = RedirectURL

        e.Properties("cpSavedText") = SavedText

        e.Properties("cpProgbarid") = TryCast(pnlEvaluations.FindControl("progIndicator"), ASPxProgressBar).ClientID

        e.Properties("cpProgVal") = (GetTotalAnswer() / GetTotalQuestion()) * 100.0

        If (GetArrayItem(UDetails.Template, "ePerformance.ShowScore")) Then

            e.Properties("cpScore") = Score(0).ToString(NumericFormat)

        Else

            e.Properties("cpScore") = "* hidden"

        End If

        e.Properties("cpCalculateScore") = CalculateScore

        e.Properties("cpDidAutoSave") = didAutoSave
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
                If (objValues(1) = "COMMUNICATION VENUES") Then e.DisplayText = objValues(1) & " 1) Effective<br " & Environment.NewLine & " 2) Needs Improvement " & Environment.NewLine & " 3) Not effective"
                'If dgView.GetRowValues(e.VisibleRowIndex, "Type") = 0 Then
                Dim lblQuestion As ASPxLabel = TryCast(sender.FindRowCellTemplateControl(e.VisibleRowIndex, TryCast(sender.Columns("Name"), GridViewDataTextColumn), "lblQuestion"), ASPxLabel)
                lblQuestion.Text = objValues(1)

                'End If


            End If

        End If

        If Not blnIsPostback Then
            If e.VisibleRowIndex = 0 Then
                iItemCounter = 0
            End If

            If e.Column.Caption = "№" Then
                If dgView.GetRowValues(e.VisibleRowIndex, "Type") <> 0 AndAlso Not IsLeadershipHeaderQuestion(e.VisibleRowIndex) Then
                    iItemCounter = iItemCounter + 1
                    e.DisplayText = If(iItemCounter <> 0, iItemCounter, "")
                Else
                    e.DisplayText = ""
                End If
            End If


        End If


    End Sub

    Private Function GetNextRow(ByVal iRow As Integer) As String
        Dim strReturn As String = ""
        Dim iStartRow As Integer = iRow
        Dim col As GridViewDataTextColumn = Nothing

        If iStartRow = dgView.VisibleRowCount Then
            iStartRow -= 1
            If dgView.GetRowValues(iStartRow, "Type") <> 0 AndAlso Not IsLeadershipHeaderQuestion(iStartRow) Then
                col = TryCast(dgView.Columns("Answers"), GridViewDataTextColumn)
                Dim pnlAnswers As ASPxPanel = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "pnlAnswers"), ASPxPanel)
                If dgView.GetRowValues(iStartRow, "RangeType") <> "-" AndAlso Not IsNull(pnlAnswers) Then
                    strReturn = "try{window.parent.frames[0].tmrEvalTimer.SetEnabled(true); " & pnlAnswers.ClientID & ".SetEnabled(true);" & pnlAnswers.ClientID & ".SetVisible(true);}catch(err){console.log(err);}"
                End If
                Dim memo As ASPxMemo = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "txtAnswers"), ASPxMemo)
                If dgView.GetRowValues(iStartRow, "RangeType") = "-" AndAlso Not IsNull(memo) Then
                    strReturn = "try{window.parent.frames[0].tmrEvalTimer.SetEnabled(true); " & strReturn & memo.ClientID & ".SetEnabled(true);" & memo.ClientID & ".SetVisible(true); }catch(err){console.log(err);}"
                End If
                Return strReturn
            End If

        End If

        While (iStartRow < dgView.VisibleRowCount)
            If dgView.GetRowValues(iStartRow, "Type") <> 0 AndAlso Not IsLeadershipHeaderQuestion(iStartRow) Then
                col = TryCast(dgView.Columns("Answers"), GridViewDataTextColumn)
                Dim pnlAnswers As ASPxPanel = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "pnlAnswers"), ASPxPanel)
                If dgView.GetRowValues(iStartRow, "RangeType") <> "-" AndAlso Not IsNull(pnlAnswers) Then
                    strReturn = "try{" & pnlAnswers.ClientID & ".SetEnabled(true);" & pnlAnswers.ClientID & ".SetVisible(true);}catch(err){console.log(err);}"
                End If
                Dim memo As ASPxMemo = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "txtAnswers"), ASPxMemo)
                If dgView.GetRowValues(iStartRow, "RangeType") = "-" AndAlso Not IsNull(memo) Then
                    strReturn = "try{" & strReturn & memo.ClientID & ".SetEnabled(true);" & memo.ClientID & ".SetVisible(true); }catch(err){console.log(err);}"
                End If
                Return strReturn
            End If
            iStartRow += 1
        End While

        Return strReturn
    End Function

    Private Sub GetNextRowServer(ByVal iRow As Integer)

        Dim iStartRow As Integer = iRow
        Dim col As GridViewDataTextColumn = Nothing
        While (iStartRow < dgView.VisibleRowCount)
            If dgView.GetRowValues(iStartRow, "Type") <> 0 AndAlso Not IsLeadershipHeaderQuestion(iStartRow) Then
                col = TryCast(dgView.Columns("Answers"), GridViewDataTextColumn)
                Dim pnlAnswers As ASPxPanel = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "pnlAnswers"), ASPxPanel)
                If dgView.GetRowValues(iStartRow, "RangeType") <> "-" AndAlso Not IsNull(pnlAnswers) Then
                    pnlAnswers.ClientVisible = True
                End If
                Dim memo As ASPxMemo = TryCast(dgView.FindRowCellTemplateControl(iStartRow, col, "txtAnswers"), ASPxMemo)
                If dgView.GetRowValues(iStartRow, "RangeType") = "-" AndAlso Not IsNull(memo) Then
                    memo.ClientVisible = True
                End If
                Return
            End If
            iStartRow += 1
        End While
        Return
    End Sub

    Private Sub dgView_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles dgView.HtmlRowCreated

        If e.RowType <> DevExpress.Web.ASPxGridView.GridViewRowType.Data Then
            Return
        End If

        Dim cmbAnswer As ASPxComboBox = TryCast(dgView.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "cmbAnswers"), ASPxComboBox)



    End Sub


    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound



        Dim ItemKey As String = String.Empty

        Dim dsRangeID As String = String.Empty

        Dim objValues() As Object = Nothing

        Dim objValue As Object = Nothing

        Dim ojbComment As Object = Nothing

        Dim objText As Object = Nothing

        Dim dgColumn As GridViewDataTextColumn = Nothing

        Dim cmbAnswers As ASPxComboBox = Nothing

        Dim txtAnswers As ASPxMemo = Nothing

        Dim dteAnswers As ASPxDateEdit = Nothing

        Dim spAnswers As ASPxSpinEdit = Nothing

        Dim chkAnswers As ASPxCheckBox = Nothing

        Dim sCode As String = String.Empty

        Try


            For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                Dim lblQuestion As ASPxLabel = TryCast(sender.FindRowCellTemplateControl(iLoop, TryCast(sender.Columns("Name"), GridViewDataTextColumn), "lblQuestion"), ASPxLabel)
                lblQuestion.Text = If(sender.GetRowValues(iLoop, "Name").ToString() = "COMMUNICATION VENUES", sender.GetRowValues(iLoop, "Name").ToString() & " (1=Not Effective  2=Needs Improvement 3=Effective)", sender.GetRowValues(iLoop, "Name").ToString())

                objValues = sender.GetRowValues(iLoop, "Type", "Count", "RangeType", "ClassCode", "Name", "Description")

                ojbComment = sender.GetRowValues(iLoop, "StickyNotes")

                If (objValues(0) > 0) Then

                    If (objValues(1) > maxCount) Then maxCount = objValues(1)

                    If (objValues(0) = 2 OrElse (objValues(0) = 1 AndAlso objValues(1) = 0)) Then

                        ItemKey = "dgView_" & iLoop.ToString("000")

                        dgColumn = TryCast(sender.Columns("Answers"), GridViewDataTextColumn)

                        If (Not IsNull(dgColumn)) Then

                            objText = Nothing

                            Dim cc As String = String.Empty
                            Dim colorControl As String = String.Empty

                            Select Case objValues(2)

                                Case "-"
                                    objValue = sender.GetRowValues(iLoop, "Description")


                                    Dim memoNotes As ASPxMemo = TryCast(sender.FindRowCellTemplateControl(iLoop, TryCast(sender.Columns("StickyNotes"), GridViewDataTextColumn), "memoStickyNotes"), ASPxMemo)
                                    memoNotes.Enabled = False
                                    memoNotes.Visible = False

                                    Dim lbl As ASPxLabel = TryCast(sender.FindRowCellTemplateControl(iLoop, TryCast(sender.Columns("Prev"), GridViewDataTextColumn), "lblPrev"), ASPxLabel)
                                    lbl.Text = ""


                                    txtAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "txtAnswers"), ASPxMemo)

                                    If (Not IsNull(txtAnswers)) Then

                                        If (Not IsNull(objValue)) Then
                                            txtAnswers.Value = objValue
                                            If objValue.ToString().Length > 0 Then
                                                txtAnswers.ClientVisible = True
                                                GetNextRowServer(iLoop + 1)
                                            End If
                                            If Not IsPostBack AndAlso objValue.ToString().Trim().Length > 0 Then iAnswered1 = iAnswered1 + 1
                                        End If

                                        'If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then txtAnswers.ClientSideEvents.LostFocus = "function(s, e) { window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"
                                        'disable auto save
                                        'txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { window.parent.frames[0].tmrEvalTimer.SetEnabled(true); items_001.Set('" & ItemKey & "_Value', s.GetText()); items_001.Set('" & ItemKey & "_Text', s.GetText()); " & GetNextRow(iLoop + 1) & "}"
                                        txtAnswers.ClientSideEvents.TextChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetText()); items_001.Set('" & ItemKey & "_Text', s.GetText()); " & GetNextRow(iLoop + 1) & "}"

                                        'txtAnswers.ClientSideEvents. = "function(s, e) { window.parent.frames[0].tmrEvalTimer.SetEnabled(true); items_001.Set('" & ItemKey & "_Value', s.GetText()); items_001.Set('" & ItemKey & "_Text', s.GetText()); alert('b');}"

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

                                            dteAnswers.ClientSideEvents.DateChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetValue()); window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

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

                                            If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then spAnswers.ClientSideEvents.LostFocus = "function(s, e) { window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

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

                                            If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then chkAnswers.ClientSideEvents.CheckedChanged &= " window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & ");"

                                            chkAnswers.ClientSideEvents.CheckedChanged &= " }"

                                            If (Not chkAnswers.Visible) Then chkAnswers.Visible = True

                                        End If

                                    Else

                                        objValue = sender.GetRowValues(iLoop, "RatingPercentage")

                                        objText = sender.GetRowValues(iLoop, "Value")
                                        Dim dgrow As Object = dgView.GetRow(iLoop)
                                        cmbAnswers = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "cmbAnswers"), ASPxComboBox)

                                        Dim memoNotes As ASPxMemo = TryCast(sender.FindRowCellTemplateControl(iLoop, TryCast(sender.Columns("StickyNotes"), GridViewDataTextColumn), "memoStickyNotes"), ASPxMemo)
                                        memoNotes.Text = sender.GetRowValues(iLoop, "StickyNotes").ToString()
                                        memoNotes.Visible = dgView.GetRowValues(iLoop, "Type") <> 0
                                        If IsLeadershipHeaderQuestion(iLoop) Then
                                            memoNotes.Visible = False
                                            Continue For
                                        End If

                                        Dim lbl As ASPxLabel = TryCast(sender.FindRowCellTemplateControl(iLoop, TryCast(sender.Columns("Prev"), GridViewDataTextColumn), "lblPrev"), ASPxLabel)
                                        lbl.Text = sender.GetRowValues(iLoop, "Prev").ToString()

                                        'Dim strEventHandler As String = "function(s, e) { items_001.Set('row_' + " & iLoop & " , " & memoNotes.ClientID & ".GetText()); " & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ " & iLoop & "\ NOTES\ ' +" & memoNotes.ClientID & ".GetText()); }"
                                        'Dim strEventHandler As String = "function(s, e) { window.parent.frames[0].tmrEvalTimer.SetEnabled(true); items_001.Set('" & ItemKey & "_CommentValue' , " & memoNotes.ClientID & ".GetText()); " & GetNextRow(iLoop + 1) & " }"
                                        'disable auto save
                                        'Dim strEventHandler As String = "function(s, e) { window.parent.frames[0].tmrEvalTimer.SetEnabled(true); items_001.Set('" & ItemKey & "_CommentValue' , " & memoNotes.ClientID & ".GetText()); }"
                                        Dim strEventHandler As String = "function(s, e) { items_001.Set('" & ItemKey & "_CommentValue' , " & memoNotes.ClientID & ".GetText()); }"


                                        'items_001.Set('" & ItemKey & "_Value', " & cmbAnswers.ClientInstanceName & ".GetValue())
                                        memoNotes.ClientSideEvents.TextChanged = strEventHandler
                                        'If (Not items_001.Contains(ItemKey & "_CommentValue")) Then items_001.Add(ItemKey & "_CommentValue", ojbComment)

                                        Dim dt As DataTable
                                        If (Not IsNull(cmbAnswers)) Then

                                            dsRangeID = "cmb" & Regex.Replace(objValues(2), "\W", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                            'If (Not csCollection.ContainsKey(dsRangeID)) Then

                                            cmbAnswers.ClientInstanceName = dsRangeID

                                            dt = GetSQLDT("select [FromPerc], [ElementName] from [PerfRangeElements] where ([RangeType] = '" & GetDataText(objValues(2)) & "') order by [FromPerc]", "Data.Evaluations.RangeElements." & dsRangeID)

                                            cmbAnswers.DataSource = dt

                                            cmbAnswers.DataBind()


                                            Dim pnlAnswers As ASPxPanel = TryCast(sender.FindRowCellTemplateControl(iLoop, dgColumn, "pnlAnswers"), ASPxPanel)
                                            Dim tblAnswers As Table = New Table
                                            Dim rowAnswers As TableRow = New TableRow

                                            If (Not IsNull(pnlAnswers)) Then
                                                For i As Integer = 0 To (dt.Rows.Count - 1)

                                                    Dim text As String = GetSQLField("select ElementName from PerfRangeElements where FromPerc = '" & objValue & "' and RangeType = '" & sender.GetRowValues(iLoop, "RangeType") & "'", "ElementName")

                                                    Dim rdo As ASPxRadioButton = New ASPxRadioButton
                                                    rdo.ID = String.Format("{0}_{1}", iLoop, i)
                                                    'rdo.AutoPostBack = True
                                                    Dim dWidth As Double = Integer.Parse(Regex.Replace(cmbAnswers.Width.ToString(), "[^0-9]", "")) / dt.Rows.Count
                                                    rdo.Checked = dt.Rows(i)(0) = objValue
                                                    If dt.Rows(i)(0) = objValue Then
                                                        pnlAnswers.ClientVisible = True
                                                        GetNextRowServer(iLoop + 1)
                                                    End If
                                                    rdo.Width = dWidth
                                                    rdo.GroupName = String.Format("Row{0}", iLoop)
                                                    rdo.ClientInstanceName = String.Format("Row{0}", iLoop)
                                                    'rdo.ClientSideEvents.CheckedChanged = "function(s,e){if(s.GetChecked()){" & cmbAnswers.ClientInstanceName & ".SetSelectedIndex(" & i & "); items_001.Set('" & ItemKey & "_Value', " & cmbAnswers.ClientInstanceName & ".GetValue()); items_001.Set('" & ItemKey & "_Text', " & cmbAnswers.ClientInstanceName & ".GetText()); window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }}"
                                                    'rdo.ClientSideEvents.CheckedChanged = "function(s,e){if(s.GetChecked()){" & cmbAnswers.ClientInstanceName & ".SetSelectedIndex(" & i & "); items_001.Set('" & ItemKey & "_Value', " & cmbAnswers.ClientInstanceName & ".GetValue()); items_001.Set('" & ItemKey & "_Text', " & cmbAnswers.ClientInstanceName & ".GetText());" & GetNextRow(iLoop + 1) & " }}"
                                                    'rdo.ClientSideEvents.CheckedChanged = "function(s,e){if(s.GetChecked()){ window.parent.frames[0].tmrEvalTimer.SetEnabled(true); " & cmbAnswers.ClientInstanceName & ".SetSelectedIndex(" & i & "); items_001.Set('" & ItemKey & "_Value', '" & dt.Rows(i)(0) & "'); items_001.Set('" & ItemKey & "_Text', '" & text & "');" & GetNextRow(iLoop + 1) & " }}"

                                                    'Enable Auto Save
                                                    rdo.ClientSideEvents.CheckedChanged = "function(s,e){if(s.GetChecked()){ window.parent.frames[0].tmrEvalTimer.SetEnabled(true); " & cmbAnswers.ClientInstanceName & ".SetSelectedIndex(" & i & "); items_001.Set('" & ItemKey & "_Value', " & cmbAnswers.ClientInstanceName & ".GetValue()); items_001.Set('" & ItemKey & "_Text', " & cmbAnswers.ClientInstanceName & ".GetText());" & GetNextRow(iLoop + 1) & " }}"
                                                    'Disable Auto Save
                                                    'rdo.ClientSideEvents.CheckedChanged = "function(s,e){if(s.GetChecked()){ " & cmbAnswers.ClientInstanceName & ".SetSelectedIndex(" & i & "); items_001.Set('" & ItemKey & "_Value', " & cmbAnswers.ClientInstanceName & ".GetValue()); items_001.Set('" & ItemKey & "_Text', " & cmbAnswers.ClientInstanceName & ".GetText());" & GetNextRow(iLoop + 1) & " }}"


                                                    'AddHandler rdo.CheckedChanged, AddressOf RdoCheckChanged
                                                    Dim lblAnswer As ASPxLabel = New ASPxLabel
                                                    lblAnswer.Text = (i + 1).ToString()
                                                    lblAnswer.Attributes.Add("style", "text-align:center")
                                                    Dim cellAnswer = New TableCell
                                                    cellAnswer.CssClass = "rbtnAnswer"
                                                    cellAnswer.Controls.Add(lblAnswer)
                                                    cellAnswer.Controls.Add(rdo)
                                                    rowAnswers.Cells.Add(cellAnswer)

                                                    If dt.Rows(i)(1) = dgView.GetRowValues(iLoop, "Prev").ToString() Then lbl.Text = i + 1.ToString()

                                                Next
                                                tblAnswers.Rows.Add(rowAnswers)
                                                pnlAnswers.Controls.Add(tblAnswers)
                                                If iLoop = 1 Then
                                                    pnlAnswers.ClientVisible = True
                                                End If
                                                cmbAnswers.Visible = False
                                            End If

                                            If (Not IsNull(objText)) Then

                                                If (Not IsNull(objValue)) Then cmbAnswers.Value = objValue

                                                cmbAnswers.Text = objText.ToString()
                                                cmbAnswers.Value = objText.ToString()
                                                cmbAnswers.Visible = False

                                            End If


                                            If (Not GetArrayItem(Nothing, "ePerformance.DisableAutoSave")) Then

                                                cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); window.parent.lpPage.Show();" & GetNextRow(iLoop + 1) & " cpPage.PerformCallback('SaveItem\ ' + " & iLoop.ToString() & "); }"

                                            Else

                                                cmbAnswers.ClientSideEvents.SelectedIndexChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetText()); }"

                                            End If



                                            If (Not cmbAnswers.Visible) Then cmbAnswers.Visible = True

                                            If Not csCollection.ContainsKey(dsRangeID) Then
                                                csCollection.Add(dsRangeID, cmbAnswers.Items.Count)
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

                            If (Not items_001.Contains(ItemKey & "_CommentValue")) Then items_001.Add(ItemKey & "_CommentValue", ojbComment)

                        End If

                    End If

                Else
                    If objValues(4).ToString().Contains("Communication") Then

                        ' 1) Effective<br /> 2) Needs Improvement <br /> 3) Not effective

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

End Class