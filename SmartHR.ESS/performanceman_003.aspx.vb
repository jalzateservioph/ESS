Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView

Partial Public Class performanceman_003
    Inherits System.Web.UI.Page

    Private PathID As String

    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001)) Then

            'e.NewValues("Remarks") = GetExpControl(sender, "remarks", "Text")

        ElseIf (sender.ID.ToString().Contains("_002")) Then

            'e.NewValues("Remarks") = GetExpControl(sender, "remarks", "Text")

        End If

    End Sub

    Private Sub LoadData()

        If (Not IsPostBack) Then Session("Evaluations.Edit.LoadSub") = Nothing

        Dim IsRowExpanded As Boolean

        With UDetails

            LoadExpDS(dsClassCode, "select [ClassCode], [ClassName] + ' (' + [ClassCode] + ')' as [ClassName] from [PerfClass] order by [ClassName] + ' (' + [ClassCode] + ')'")

            LoadExpDS(dsKPACode, "select [KPACode], [KPAName] + ' (' + [KPACode] + ')' as [KPAName] from [PerfKPA] order by [KPAName] + ' (' + [KPACode] + ')'")

            LoadExpDS(dsCSEName, "select [CSEName] from [PerfCSE] order by [CSEName]")

            LoadExpDS(dsRangeType, "select [RangeType], [Description] from [PerfRangeType] order by [Description]")

            If (IsNumeric(Session("Evaluations.Edit.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Evaluations.Edit.LoadSub"))

            LoadExpGrid(Session, dgView_001, "Performance Tab", "<Tablename=PerfEvalKPA><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode]><InsertKey='" & Session("Performance.CompanyNum") & "', '" & Session("Performance.EmployeeNum") & "', '" & Session("Performance.Selected") & "', '" & Session("Performance.EvalDate") & "'><Columns=[ClassCode], [KPACode], [KPAName], [Target], [RangeType], [Weight], [Remarks]><Where=([CompanyNum] = '" & Session("Performance.CompanyNum") & "' and [EmployeeNum] = '" & Session("Performance.EmployeeNum") & "' and [SchemeCode] = '" & Session("Performance.Selected") & "' and [EvalDate] = '" & Session("Performance.EvalDate") & "')>")

            If (IsNumeric(Session("Evaluations.Edit.LoadSub"))) Then

                Dim iRowIndex As Integer = Session("Evaluations.Edit.LoadSub")

                If (IsRowExpanded) Then

                    Dim dgView As ASPxGridView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_002"), ASPxGridView)

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=PerfEvalCSE><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName]><InsertKey='" & Session("Performance.CompanyNum") & "', '" & Session("Performance.EmployeeNum") & "', '" & Session("Performance.Selected") & "', '" & Session("Performance.EvalDate") & "', '" & dgView_001.GetRowValues(iRowIndex, "ClassCode") & "', '" & dgView_001.GetRowValues(iRowIndex, "KPACode") & "'><Columns=[CSEName], [Target], [RangeType], [Weight], [Remarks]><Where=([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] = '" & dgView_001.GetRowValues(iRowIndex, "CompositeKey") & "')>")

                End If

            End If

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            SetEmployeeData(Session, Session("Selected.Value"))

            lblKA.Text = GetArrayItem(Nothing, "ePerformance.KeyAreas")

        End If

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "Performance Tab")

        LoadData()

    End Sub

    Private Sub cmdReturn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdReturn.Click

        Response.Redirect("performanceman_002.aspx?ID=" & PathID, True)

    End Sub

    'TODO: Not Sure if needed
    'Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpPage.Callback

    '    Dim show As Boolean = True

    '    Dim Values() As String = e.Parameter.Split(" ")

    '    Dim ErrorText As String = ""

    '    Select Case Values(0)

    '        Case "Load"

    '            LoadExpGrid(Me, dgView_001, "Performance Tab", "<Tablename=PerfEvalKPA><PrimaryKey=[SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode]><InsertKey='" & Values(1) & "', 'ESS'><Columns=[KPACode], [KPAName], [Remarks], [Target], [RangeType], [Weight]><Where=([SchemeCode] = '" & Values(1) & "' and [ClassCode] = 'ESS')>")

    '            If (SessKeyExists(Session.Keys, "clLoadCSE")) Then

    '                Dim iRowIndex As Integer = Session("clLoadCSE")

    '                Dim dgView As ASPxGridView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_002"), ASPxGridView)

    '                LoadExpGrid(Me, dgView, "Performance Tab", "<Tablename=PerfEvalCSE><PrimaryKey=[SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName]><InsertKey=''><Columns=[CSEName], [Remarks], [Target], [RangeType], [Weight]><Where=([SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] = '" & dgView_001.GetRowValues(iRowIndex, "CompositeKey") & "')>")

    '            End If

    '            show = False

    '    End Select

    '    If (Not SessKeyExists(Session.Keys, "Performance.Selected")) Then

    '        Session.Add("Performance.Selected", Values(1))

    '    Else

    '        Session("Performance.Selected") = Values(1)

    '    End If

    '    pcError.ShowOnPageLoad = show

    'End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

    End Sub

    Private Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim lblCSE As ASPxLabel = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "lblCSE"), ASPxLabel)

            If (Not IsNull(lblCSE)) Then lblCSE.Text = GetArrayItem(Nothing, "ePerformance.KeyElements")

            Dim dgView As ASPxGridView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_002"), ASPxGridView)

            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=PerfEvalCSE><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName]><InsertKey='" & Session("Performance.CompanyNum") & "', '" & Session("Performance.EmployeeNum") & "', '" & Session("Performance.Selected") & "', '" & Session("Performance.EvalDate") & "', '" & dgView_001.GetRowValues(e.VisibleIndex, "ClassCode") & "', '" & dgView_001.GetRowValues(e.VisibleIndex, "KPACode") & "'><Columns=[CSEName], [Remarks], [Target], [RangeType], [Weight], [Remarks]><Where=([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [SchemeCode] + ' ' + convert(nvarchar(19), [EvalDate], 120) + ' ' + [ClassCode] + ' ' + [KPACode] = '" & dgView_001.GetRowValues(e.VisibleIndex, "CompositeKey") & "')>")

            Session("Evaluations.Edit.LoadSub") = e.VisibleIndex

        ElseIf (IsNumeric(Session("Evaluations.Edit.LoadSub"))) Then

            Session.Remove("Evaluations.Edit.LoadSub")

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=PerfEvalKPA><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><SchemeCode=" & Session("Performance.Selected") & "><EvalDate=" & Session("Performance.EvalDate") & "><ClassCode=" & e.Values("ClassCode").ToString() & "><KPACode=" & e.Values("KPACode").ToString() & ">"

        ElseIf (sender.ID = "dgView_002") Then

            SQLAudit = "<Tablename=PerfEvalCSE><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><SchemeCode=" & Session("Performance.Selected") & "><EvalDate=" & Session("Performance.EvalDate") & "><ClassCode=" & e.Values("ClassCode").ToString() & "><KPACode=" & e.Values("KPACode").ToString() & "><CSEName=" & e.Values("CSEName").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData()

            If (sender.ID = "dgView_002") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=PerfEvalKPA><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><SchemeCode=" & Session("Performance.Selected") & "><EvalDate=" & Session("Performance.EvalDate") & ">"

        ElseIf (sender.ID = "dgView_002") Then

            SQLAudit = "<Tablename=PerfEvalCSE><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><SchemeCode=" & Session("Performance.Selected") & "><EvalDate=" & Session("Performance.EvalDate") & ">"

        End If

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_002")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData()

            CancelEdit = True

        End If

        'GetExpValues(sender, e)

        'Dim ClassCreate As String = GetSQLField("select [CompanyNum] from [PerfEvalClass] where ([CompanyNum] = '" & Session("Performance.CompanyNum") & "' and [EmployeeNum] = '" & Session("Performance.EmployeeNum") & "' and [SchemeCode] = '" & Session("Performance.Selected") & "' and [EvalDate] = '" & Session("Performance.EvalDate") & "' and [ClassCode] = '" & e.NewValues("ClassCode") & "')", "CompanyNum")

        'If (IsNull(ClassCreate)) Then ExecSQL("insert into [PerfEvalClass]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [ClassName], [Weight]) select '" & Session("Performance.CompanyNum") & "', '" & Session("Performance.EmployeeNum") & "', '" & Session("Performance.Selected") & "', '" & Session("Performance.EvalDate") & "', [ClassCode], [ClassName], [DefaultWeight] from [PerfClass] where ([ClassCode] = '" & e.NewValues("ClassCode") & "')")

        'GetInsertExpSQL(sender, e)

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=PerfEvalKPA><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><SchemeCode;2=" & Session("Performance.Selected") & "><EvalDate;3=" & Session("Performance.EvalDate") & "><ClassCode;4=" & e.OldValues("ClassCode").ToString() & "><KPACode;5=" & e.OldValues("KPACode").ToString() & ">"

        ElseIf (sender.ID = "dgView_002") Then

            SQLAudit = "<Tablename=PerfEvalCSE><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><SchemeCode;2=" & Session("Performance.Selected") & "><EvalDate;3=" & Session("Performance.EvalDate") & "><ClassCode;4=" & e.OldValues("ClassCode").ToString() & "><KPACode;5=" & e.OldValues("KPACode").ToString() & "><CSEName;6=" & e.OldValues("CSEName").ToString() & ">"

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData()

            CancelEdit = True

        End If

        'GetExpValues(sender, e)

        'GetUpdateExpSQL(sender, e)

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating

        'GetExpValues(sender, e)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

#End Region

End Class