Imports DevExpress.XtraEditors.Controls
Imports DevExpress.Web.ASPxUploadControl
Imports DevExpress.Web.ASPxGridView
Imports System.IO
Imports Microsoft.Reporting.WebForms
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraEditors
Imports DevExpress.XtraReports.UI
Imports DevExpress.XtraReports.Web
Imports System.Web.HttpUtility

Public Class twsreports
    Inherits System.Web.UI.Page
    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UDetails = GetUserDetails(Session, "TWS Reports", True)
        If (Not IsPostBack) Then
            Session("Data.TWS.Keyword.LoadSub") = Nothing
            If Session("Reprocessed.Data") = False Then
                BtnTWSReprocess.Enabled = False
                btnCorporate.Enabled = False
                btnDivisional.Enabled = False
                btnDepartment.Enabled = False
                btnSection.Enabled = False
                cboSchema.SelectedIndex = -1
            Else
                cboSchema.Text = Session("Data")
            End If
        End If
        LoadData()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs)
        DevExpress.Web.ASPxClasses.ASPxWebControl.SetIECompatibilityMode(8, Me.Page)
    End Sub

    Private Sub cpPage_Callback(source As Object, e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback
        If (e.Parameter = "Reprocess") Then
            Dim pSchema As String = cboSchema.Value.ToString()
            ExecQuery(String.Format("EXEC [spTWSReprocess] '{0}','{1}'", pSchema, Session("LoggedOn").UserID))
        ElseIf (e.Parameter = "GenerateEssay") Then
            Dim rpt As New EssayResponses()
            Dim pSCode As String = cboScheCode.Value.ToString()
            rpt.Parameters("pSCode").Value = pSCode
            rpvEssay.Report = rpt
            Session("Essay") = rpt
        ElseIf (e.Parameter = "GenerateGroup") Then
            Dim rpt As New CommentsGroup()
            Dim pKeyword As String = cboKeyword.Value.ToString()
            Dim pSchemeCode As String = cboScheme.Value.ToString()
            rpt.Parameters("pKeyword").Value = pKeyword
            rpt.Parameters("pSchemeCode").Value = pSchemeCode
            rpvComments.Report = rpt
            Session("Reports") = rpt
        ElseIf (e.Parameter = "Generate") Then
            If cboSuperiorList.SelectedIndex <> -1 Then
                Dim rpt As New Leadership()
                Dim pSuperior As String = ""
                Dim pScheme As String = ""
                pSuperior = cboSuperiorList.Value.ToString()
                pScheme = cboSchemeCode.Value.ToString()
                rpt.Parameters("pSuperior").Value = pSuperior
                rpt.Parameters("pScheme").Value = pScheme
                rpvSuperior.Report = rpt
                Session("Leadership") = rpt
            End If
        ElseIf (e.Parameter = "GenerateCom") Then
            If cboSuperiorList.SelectedIndex <> -1 Then
                Dim rpt As New LeadershipComments()
                Dim pSuperior As String = ""
                Dim pScheme As String = ""
                pSuperior = cboSuperiorList.Value.ToString()
                pScheme = cboSchemeCode.Value.ToString()
                rpt.Parameters("pSuperior").Value = pSuperior
                rpt.Parameters("pScheme").Value = pScheme
                rpvSuperior.Report = rpt
                Session("Leadership") = rpt
            End If
        End If
    End Sub

#Region "Keywords"
    Private Sub dgView_001_CellEditorInitialize(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs) Handles dgView_001.CellEditorInitialize

    End Sub
    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties
        e.Properties("cpCancelEdit") = CancelEdit
        e.Properties("cpRefreshDelete") = RefreshDelete
    End Sub
    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting
        Dim SQLAudit As String = String.Empty
        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004")) Then
            e.Cancel = True
            Exit Sub
        End If
        GetExpValues(sender, e)
        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating
        Dim SQLAudit As String = String.Empty
        GetExpValues(sender, e)
        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (sender.ID = "dgView_001") Then ExecSQL(String.Format("UPDATE [ESS.TWSKeywordList] SET Keyword = '{0}', CapturedBy = '{2}', CapturedDate = '{3}' WHERE Keyword = '{1}'", e.NewValues("Keyword"), e.OldValues("Keyword"), Session("LoggedOn").UserID, DateTime.Now.ToString()))
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting
        Dim SQLAudit As String = String.Empty
        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            If (sender.ID = "dgView_001") Then ExecSQL(String.Format("Delete FROM [ESS.TWSKeywordList] WHERE Keyword = '{0}'", e.Keys("CompositeKey").ToString()))
            If (sender.ID = "dgView_004") Then RefreshDelete = True
        End If
        LoadData()
    End Sub
    Private Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged
        If (e.Expanded) Then
            Dim dgView As ASPxGridView = Nothing
            With UDetails
                If (sender.Equals(dgView_001)) Then
                    ClearFromCache("Data.TWS.Keyword.Items." & Session.SessionID)
                    Dim Keyword As String = sender.GetRowValues(e.VisibleIndex, "Keyword").ToString()
                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), ASPxGridView)
                    If (Not IsNull(dgView)) Then
                        LoadExpGrid(Session, dgView, "TWS Reports", "<Tablename=ess.TWSKeywordList><PrimaryKey=[Keyword] + ' ' + [Items]><Columns=[Keyword], [Items], [CapturedBy], [CapturedDate]><Where=([Keyword] = '" & Keyword & "')>", "Data.TWS.Keyword.Items." & Session.SessionID)
                        dgView = Nothing
                    End If
                    Session("Data.TWS.Keyword.LoadSub") = e.VisibleIndex
                End If
            End With
        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("Data.TWS.Keyword.LoadSub"))) Then
            Session.Remove("Data.TWS.Keyword.LoadSub")
        End If
    End Sub
    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating
        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex
        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then
            If (sender.Equals(dgView_001)) Then
                If (IsNull(e.OldValues("CapturedBy"))) Then e.OldValues("CapturedBy") = sender.GetRowValues(iRowIndex, "CapturedBy")
            End If
        ElseIf (sender.Equals(dgView_001)) Then
            e.NewValues("CapturedBy") = Session("LoggedOn").UserID
        End If
        ValidateExpValues(sender, e)
    End Sub
    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)
        If (sender.Equals(dgView_001) OrElse sender.ID = "dgView_004") Then
            If ((sender.IsEditing Or sender.IsNewRowEditing) AndAlso (sender.Equals(dgView_001) Or sender.ID = "dgView_004")) Then
                e.NewValues("CapturedBy") = Session("LoggedOn").UserID
                e.NewValues("CapturedDate") = Date.Now
                If (sender.ID = "dgView_004") Then
                    e.NewValues("Keyword") = dgView_001.GetRowValues(Session("Data.TWS.Keyword.LoadSub"), "Keyword").ToString()
                End If
            End If
        End If
    End Sub
    Private Sub ValidateExpValues(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        If (sender.Equals(dgView_001)) Then
            If (IsNull(e.NewValues("CapturedBy"))) Then e.NewValues("CapturedBy") = e.OldValues("CapturedBy")
        End If
        e.RowError = ValidateExpGrid(sender, e)
    End Sub
#End Region

#Region "Essay Responses"
    Protected Sub dgView_EssRes_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_EssRes.CustomJSProperties
        e.Properties("cpCancelEdit") = CancelEdit
        e.Properties("cpRefreshDelete") = RefreshDelete
    End Sub
    Protected Sub dgView_EssRes_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_EssRes.RowInserting
        Dim SQLAudit As String = String.Empty
        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_EssRes")) Then
            e.Cancel = True
            Exit Sub
        End If
        GetExpValues1(sender, e)
        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_EssRes_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_EssRes.RowUpdating
        Dim SQLAudit As String = String.Empty
        GetExpValues(sender, e)
        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (sender.ID = "dgView_EssRes") Then ExecSQL(String.Format("UPDATE [ESS.TWSEssayItems] SET KPACode = '{0}', Keyword = '{2}', CapturedBy = '{3}', CapturedOn = '{4}' WHERE Keyword = '{2}'", e.NewValues("KPACode"), e.NewValues("Keyword"), e.OldValues("Keyword"), Session("LoggedOn").UserID, DateTime.Now.ToString()))
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_EssRes_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_EssRes.RowDeleting
        Dim SQLAudit As String = String.Empty
        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            If (sender.ID = "dgView_EssRes") Then ExecSQL(String.Format("DELETE FROM [ESS.TWSEssayItems] WHERE KPACode = '{0}'", e.Keys("CompositeKey").ToString()))
        End If
        LoadData()
    End Sub
    Protected Sub dgView_EssRes_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_EssRes.RowValidating
        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex
        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then
            If (sender.Equals(dgView_EssRes)) Then
                If (IsNull(e.OldValues("CapturedBy"))) Then e.OldValues("CapturedBy") = sender.GetRowValues(iRowIndex, "CapturedBy")
            End If
        ElseIf (sender.Equals(dgView_EssRes)) Then
            e.NewValues("CapturedBy") = Session("LoggedOn").UserID
        End If
        ValidateExpValues1(sender, e)
    End Sub
    Private Sub GetExpValues1(ByVal sender As Object, ByVal e As Object)
        If (sender.Equals(dgView_EssRes)) Then
            If (sender.IsEditing Or sender.IsNewRowEditing) AndAlso (sender.Equals(dgView_EssRes)) Then
                e.NewValues("CapturedBy") = Session("LoggedOn").UserID
                e.NewValues("CapturedOn") = Date.Now
            End If
        End If
    End Sub
    Private Sub ValidateExpValues1(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        If (sender.Equals(dgView_EssRes)) Then
            If (IsNull(e.NewValues("CapturedBy"))) Then e.NewValues("CapturedBy") = e.OldValues("CapturedBy")
        End If
        e.RowError = ValidateExpGrid(sender, e)
    End Sub
#End Region

#Region "Leadership Categories"
    Protected Sub dgView_LdrCtg_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_LdrCtg.CustomJSProperties
        e.Properties("cpCancelEdit") = CancelEdit
        e.Properties("cpRefreshDelete") = RefreshDelete
    End Sub
    Protected Sub dgView_LdrCtg_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_LdrCtg.RowInserting
        Dim SQLAudit As String = String.Empty
        If (CancelEdit) Then
            e.Cancel = True
            Exit Sub
        End If
        GetExpValues2(sender, e)
        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
        LoadData()
    End Sub
    Protected Sub dgView_LdrCtg_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_LdrCtg.RowUpdating
        Dim SQLAudit As String = String.Empty
        GetExpValues2(sender, e)
        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (sender.ID = "dgView_LdrCtg") Then ExecSQL(String.Format("UPDATE [ess.TWSLeadCategory] SET CategoryName = '{2}', KPACode = '{3}', Remarks = '{4}', CapturedBy = '{5}', CapturedDate = '{6}' WHERE CategoryName = '{0}' AND KPACode = '{0}'", e.OldValues("CategoryName"), e.OldValues("KPACode"), e.NewValues("CategoryName"), e.NewValues("KPACode"), e.NewValues("Remarks"), Session("LoggedOn").UserID, DateTime.Now.ToString()))
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            CancelEdit = True
        End If
    End Sub
    Protected Sub dgView_LdrCtg_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_LdrCtg.RowDeleting
        Dim SQLAudit As String = String.Empty
        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))
        If (e.Cancel) Then
            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)
            If (sender.ID = "dgView_LdrCtg") Then ExecSQL(String.Format("DELETE FROM [ess.TWSLeadCategory] WHERE CategoryName = '{0}'", e.Keys("CompositeKey").ToString()))
        End If
        LoadData()
    End Sub
    Protected Sub dgView_LdrCtg_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_LdrCtg.RowValidating
        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex
        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then
            If (sender.Equals(dgView_LdrCtg)) Then
                If (IsNull(e.OldValues("CapturedBy"))) Then e.OldValues("CapturedBy") = sender.GetRowValues(iRowIndex, "CapturedBy")
            End If
        ElseIf (sender.Equals(dgView_LdrCtg)) Then
            e.NewValues("CapturedBy") = Session("LoggedOn").UserID
        End If
        ValidateExpValues2(sender, e)
    End Sub
    Private Sub GetExpValues2(ByVal sender As Object, ByVal e As Object)
        If (sender.Equals(dgView_LdrCtg)) Then
            If ((sender.IsEditing Or sender.IsNewRowEditing) AndAlso (sender.Equals(dgView_LdrCtg))) Then
                e.NewValues("CapturedBy") = Session("LoggedOn").UserID
                e.NewValues("CapturedDate") = Date.Now
            End If
        End If
    End Sub
    Private Sub ValidateExpValues2(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        If (sender.Equals(dgView_LdrCtg)) Then
            If (IsNull(e.NewValues("CapturedBy"))) Then e.NewValues("CapturedBy") = e.OldValues("CapturedBy")
        End If
        e.RowError = ValidateExpGrid(sender, e)
    End Sub
#End Region

#Region "Method"
    Public Sub LoadData()
        LoadComboBoxValues()

        Dim dgView As ASPxGridView = Nothing
        Dim iRowIndex As Integer
        Dim IsRowExpanded As Boolean

        With UDetails
            If Session("Essay") IsNot Nothing Then
                rpvEssay.Report = TryCast(Session("Essay"), XtraReport)
                rpvComments.DataBind()
            End If
            If Session("Reports") IsNot Nothing Then
                rpvComments.Report = TryCast(Session("Reports"), XtraReport)
                rpvComments.DataBind()
            End If
            If Session("Leadership") IsNot Nothing Then
                rpvSuperior.Report = TryCast(Session("Leadership"), XtraReport)
                rpvSuperior.DataBind()
            End If

            Dim Sql_Superior As String = "SELECT SuperiorName FROM Superior_View ORDER BY SuperiorName"
            LoadExpDS(ds_Superior, Sql_Superior)
            Dim Sql_LdrCode_Ldr As String = "SELECT DISTINCT CategoryName FROM [ess.TWSLeadCategory]"
            LoadExpDS(ds_LdrCode_Ldr, Sql_LdrCode_Ldr)
            Dim Sql_KPACode_Ess As String = "SELECT DISTINCT KPACode FROM PerfKPA2014 WHERE ClassCode = 'Esy'"
            LoadExpDS(ds_KPACode_Ess, Sql_KPACode_Ess)
            Dim Sql_KPACode_Ldr As String = "SELECT DISTINCT KPACode FROM PerfKPA WHERE ClassCode = 'LDR' AND KPACode NOT IN (SELECT DISTINCT KPACode FROM [ess.TWSLeadCategory])"
            LoadExpDS(ds_KPACode_Ldr, Sql_KPACode_Ldr)
            Dim Sql_Remarks_Ldr As String = "SELECT DISTINCT Remarks FROM [FixedRemark]"
            LoadExpDS(ds_Remarks_Ldr, Sql_Remarks_Ldr)

            ClearFromCache("Data.TWS.Keyword." & Session.SessionID)
            ClearFromCache("Data.TWS.Keyword.Items." & Session.SessionID)
            ClearFromCache("Data.TWS.Category." & Session.SessionID)
            ClearFromCache("Data.TWS.EssayItems." & Session.SessionID)

            If (IsNumeric(Session("Data.TWS.Keyword.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Data.TWS.Keyword.LoadSub"))

            LoadExpGrid(Session, dgView_001, "TWS Reports", "<Tablename=ess.TWSKeywordMain><PrimaryKey=[Keyword]><Columns=[Keyword], [CapturedBy], [CapturedDate]>", "Data.TWS.Keyword." & Session.SessionID)
            LoadExpGrid(Session, dgView_LdrCtg, "TWS Reports", "<Tablename=ess.TWSLeadCategory><PrimaryKey=[CategoryName] + ' ' + [KPACode]><Columns=[CategoryName], [KPACode], [Remarks], [CapturedBy], [CapturedDate]>", "Data.TWS.Category." & Session.SessionID)
            LoadExpGrid(Session, dgView_EssRes, "TWS Reports", "<Tablename=ess.TWSEssayItems><PrimaryKey=[KPACode] + ' ' + [Items]><Columns=[KPACode], [Items], [CapturedBy], [CapturedOn]>", "Data.TWS.EssayItems." & Session.SessionID)

            If (IsNumeric(Session("Data.TWS.Keyword.LoadSub"))) Then
                iRowIndex = Session("Data.TWS.Keyword.LoadSub")
                If (IsNumeric(Session("Data.TWS.Keyword.LoadSub"))) Then
                    Dim Keyword As String = dgView_001.GetRowValues(iRowIndex, "Keyword").ToString()
                    dgView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)
                    If (Not IsNull(dgView)) Then
                        LoadExpGrid(Session, dgView, "TWS Reports", "<Tablename=ess.TWSKeywordList><PrimaryKey=[Keyword] + ' ' + [Items]><Columns=[Keyword], [Items], [CapturedBy], [CapturedDate]><Where=([Keyword] = '" & Keyword & "')>", "Data.TWS.Keyword.Items." & Session.SessionID)
                        dgView = Nothing
                    End If
                End If
            End If
        End With
    End Sub

    Private Sub LoadComboBoxValues()
        cboKeyword.DataSource = GetSQLDT("SELECT Keyword FROM [ESS.TWSKeywordMain] ORDER BY Keyword")
        cboKeyword.DataBind()

        cboScheCode.DataSource = GetSQLDT("SELECT DISTINCT(SchemeCode) FROM PerfEvalScheme ORDER BY SchemeCode")
        cboScheCode.DataBind()

        cboSchema.DataSource = GetSQLDT("SELECT DISTINCT(SchemeCode) FROM PerfEvalScheme ORDER BY SchemeCode")
        cboSchema.DataBind()

        cboScheme.DataSource = GetSQLDT("SELECT DISTINCT(SchemeCode) FROM PerfEvalScheme ORDER BY SchemeCode")
        cboScheme.DataBind()

        cboSchemeCode.DataSource = GetSQLDT("SELECT DISTINCT(SchemeCode) FROM PerfEvalScheme ORDER BY SchemeCode")
        cboSchemeCode.DataBind()

        cboSuperiorList.DataSource = GetSQLDT("SELECT DISTINCT SuperiorIDNum + ' - ' + SuperiorName [SuperiorName] ,SuperiorName [SupName] FROM Superior_View ORDER BY SuperiorName")
        cboSuperiorList.DataBind()
    End Sub
#End Region

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim PathID As String = Container.Grid.GetRowValues(Container.VisibleIndex, "CompositeKey")

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "Training Agreement Form"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=" & PathID & "><rparam=schema|" + cboSchema.Value.ToString() + "|string>", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function
    Private Sub btnCorporate_Click(sender As Object, e As EventArgs) Handles btnCorporate.Click
        'Response.Redirect("./TWSCorporation.aspx?Schema=" + cboSchema.Value.ToString())

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "TWS"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=Division><rparam0=schema|" + cboSchema.Value.ToString().Split("_")(1) + "|string>", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Response.Redirect("./reportsview.aspx?type=open&params=" + EncryptedURL)
    End Sub
    Private Sub btnDivisional_Click(sender As Object, e As System.EventArgs) Handles btnDivisional.Click
        'Response.Redirect("./TWSCorporation.aspx?Schema=" + cboSchema.Value.ToString())

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "TWS"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=Division><rparam0=schema|" + cboSchema.Value.ToString().Split("_")(1) + "|string>", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Response.Redirect("./reportsview.aspx?type=open&params=" + EncryptedURL)
    End Sub
    Private Sub btnDepartment_Click(sender As Object, e As System.EventArgs) Handles btnDepartment.Click
        'Response.Redirect("./TWSDivisional.aspx?Schema=" + cboSchema.Value.ToString())

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "TWS"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=Department><rparam0=schema|" + cboSchema.Value.ToString().Split("_")(1) + "|string>", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Response.Redirect("./reportsview.aspx?type=open&params=" + EncryptedURL)
    End Sub
    Private Sub btnSection_Click(sender As Object, e As System.EventArgs) Handles btnSection.Click
        'Response.Redirect("./TWSDepartmental.aspx?Schema=" + cboSchema.Value.ToString())
        'Response.Redirect("./TWSSectional.aspx?Schema=" + cboSchema.Value.ToString())

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "TWS"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=Section><rparam0=schema|" + cboSchema.Value.ToString().Split("_")(1) + ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Response.Redirect("./reportsview.aspx?type=open&params=" + EncryptedURL)
    End Sub
    Private Sub btnRespondents_Click(sender As Object, e As System.EventArgs) Handles btnRespondents.Click
        Response.Redirect("reports/Respondents.xlsx")
    End Sub
    Protected Sub rpvEssay_Unload(sender As Object, e As System.EventArgs) Handles rpvEssay.Unload
        DirectCast(sender, DevExpress.XtraReports.Web.ReportViewer).Report = Nothing
    End Sub
    Protected Sub rpvComments_Unload(sender As Object, e As EventArgs) Handles rpvComments.Unload
        DirectCast(sender, DevExpress.XtraReports.Web.ReportViewer).Report = Nothing
    End Sub
    Protected Sub rpvSuperior_Unload(sender As Object, e As System.EventArgs) Handles rpvSuperior.Unload
        DirectCast(sender, DevExpress.XtraReports.Web.ReportViewer).Report = Nothing
    End Sub
    Private Sub cboSchema_TextChanged(sender As Object, e As EventArgs) Handles cboSchema.TextChanged
        If cboSchema.SelectedIndex <> -1 Then
            BtnTWSReprocess.Enabled = True
        End If
    End Sub
    Private Sub BtnTWSReprocess_Click(sender As Object, e As EventArgs) Handles BtnTWSReprocess.Click
        btnCorporate.Enabled = True
        btnDivisional.Enabled = True
        btnDepartment.Enabled = True
        btnSection.Enabled = True
        Session("Reprocessed.Data") = True
        Session.Add("Data", cboSchema.Value.ToString())
    End Sub
    Private Sub cboSchemeCode_TextChanged(sender As Object, e As EventArgs) Handles cboSchemeCode.TextChanged
        If cboSchemeCode.SelectedIndex <> -1 AndAlso cboSuperiorList.SelectedIndex <> -1 Then
            btnGenerate.Enabled = True
            btnGenerateCom.Enabled = True
        End If
    End Sub
    Private Sub cboSuperiorList_TextChanged(sender As Object, e As EventArgs) Handles cboSuperiorList.TextChanged
        If cboSchemeCode.SelectedIndex <> -1 AndAlso cboSuperiorList.SelectedIndex <> -1 Then
            btnGenerate.Enabled = True
            btnGenerateCom.Enabled = True
        End If
    End Sub
    Private Sub cboScheme_TextChanged(sender As Object, e As EventArgs) Handles cboScheme.TextChanged
        If cboScheme.SelectedIndex <> -1 AndAlso cboKeyword.SelectedIndex <> -1 Then
            btnSubmit.Enabled = True
        End If
    End Sub
    Private Sub cboKeyword_TextChanged(sender As Object, e As EventArgs) Handles cboKeyword.TextChanged
        If cboScheme.SelectedIndex <> -1 AndAlso cboKeyword.SelectedIndex <> -1 Then
            btnSubmit.Enabled = True
        End If
    End Sub
    Private Sub cboScheCode_TextChanged(sender As Object, e As EventArgs) Handles cboScheCode.TextChanged
        If cboScheCode.SelectedIndex <> -1 Then
            btnEssay.Enabled = True
        End If
    End Sub
End Class
