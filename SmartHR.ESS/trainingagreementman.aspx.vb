Partial Public Class trainingagreementman
    Inherits System.Web.UI.Page

    Private PathID As String
    Private isTrainingAdmin As Boolean
    Private EDetails As Users = Nothing
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Private Sub PopulateFields()

        Dim dtColumns As DataTable = GetSQLDT("SELECT TOP 1 taf1.[TAFID] [TAFID],  taf1.[EmployeeNum] [ID],  taf1.[Name],  co1.[Division],  co1.[SubDivision] Department,  co1.[SubSubDivision] Section,  pers1.[OFOCode] [Level],  taf1.[ExternalPositionTitle],  pers.[HomeTel] [LocalNum],  taf1.[MobileNum],  taf1.[RTANum],  taf1.[DatePrepared],  tad1.[ProgramTitle],  tad1.[Type],  tad1.[ProgramType],  tad1.[Provider],  tad1.[DateFrom],  tad1.[DateTo],  tad1.[Investment],  [ServiceAgreement] = ( CASE 	WHEN tad1.[Type] = 'Functional Training Program' THEN 	(	SELECT TOP 1 [ServiceAgreement] = (	CASE 	WHEN ftp.Years > 0	THEN ftp.Years + cast((ftp.Months / CONVERT(decimal(4,2), 12))as float)	ELSE 	cast((ftp.Months / CONVERT(decimal(4,2), 12))as float) 	END)	FROM FunctionalTrainingProgram ftp	WHERE (tad1.[Investment] BETWEEN ftp.[Min] AND ftp.[Max]) 	OR (ftp.[Min] IS NULL AND tad1.[Investment] <= ftp.[Max]) 	OR (ftp.[Max] IS NULL AND tad1.[Investment] >= ftp.[Min]) 	) 	WHEN tad1.[Type] = 'Specialized Development Program' THEN 	(	SELECT TOP 1 [ServiceAgreement] 	FROM SpecializedDevelopmentProgram sdp 	WHERE sdp.[Program] = tad1.[ProgramType] 	) END ), [ExistingContract] = ( 	SELECT TOP 1 COUNT(*) 	FROM TrainingAgreementForm taf2 	INNER JOIN TAFProgramDetails tad2	ON taf2.[TAFID] = tad2.[TAFID]	AND tad2.[ProgramTitle] = tad1.[ProgramTitle] 	WHERE (taf2.[Status] = 'Approve' OR taf2.[Status] = 'Submitted') 	AND taf2.[EmployeeNum] = taf1.[EmployeeNum] 	AND NOT taf2.[TAFID] = taf1.[TAFID] ), taf1.[Status],  taf1.[CapturedBy],  taf1.[CapturedOn] FROM TrainingAgreementForm taf1  INNER JOIN Personnel1 pers1  	ON taf1.EmployeeNum = pers1.EmployeeNum  INNER JOIN Personnel pers  	ON taf1.EmployeeNum = pers.EmployeeNum  INNER JOIN Company co1  	ON taf1.CompanyNum = co1.CompanyNum  INNER JOIN TAFProgramDetails tad1  	ON taf1.TAFID = tad1.TAFID WHERE taf1.[PathID] = '" & PathID & "'")

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    txtEmployeeNum_007.Text = dtColumns.Rows(0).Item("ID").ToString()
                    txtDatePrep_007.Text = DateTime.Parse(dtColumns.Rows(0).Item("DatePrepared").ToString()).ToString("d")
                    txtName_007.Text = dtColumns.Rows(0).Item("Name").ToString()
                    txtLocal_007.Text = dtColumns.Rows(0).Item("LocalNum").ToString()
                    txtDivision_007.Text = dtColumns.Rows(0).Item("Division").ToString()
                    txtDepartment_007.Text = dtColumns.Rows(0).Item("Department").ToString()
                    txtSection_007.Text = dtColumns.Rows(0).Item("Section").ToString()
                    txtLevel_007.Text = dtColumns.Rows(0).Item("Level").ToString()
                    txtMobile_007.Text = dtColumns.Rows(0).Item("MobileNum").ToString()
                    txtExternalPos_007.Text = dtColumns.Rows(0).Item("ExternalPositionTitle").ToString()
                    txtProgramTitle_007.Text = dtColumns.Rows(0).Item("ProgramTitle").ToString()
                    txtType_007.Text = dtColumns.Rows(0).Item("Type").ToString()
                    txtProgramType_007.Text = dtColumns.Rows(0).Item("ProgramType").ToString()
                    txtProvider_007.Text = dtColumns.Rows(0).Item("Provider").ToString()
                    txtDuration_007.Text = String.Format("{0} - {1}", DateTime.Parse(dtColumns.Rows(0).Item("DateFrom").ToString()).ToString("d"), DateTime.Parse(dtColumns.Rows(0).Item("DateTo").ToString()).ToString("d"))
                    txtInvestment_007.Text = String.Format("{0:n}", Decimal.Parse(dtColumns.Rows(0).Item("Investment")))
                    '(dtColumns.Rows(0).Item("ServiceAgreement").ToString() & " years").Replace(" years", string.Empty)
                    txtSEDDuration_007.Text = dtColumns.Rows(0).Item("ServiceAgreement").ToString() & " years"

                    If (dtColumns.Rows(0).Item("ExistingContract").ToString() = "0") Then

                        'txtSEDExistingStart_007.Text = DateTime.Parse(dtColumns.Rows(0).Item("DateFrom").ToString()).ToString("d")
                        'dteSEDExistingStart_007.Value = DateTime.Parse(dtColumns.Rows(0).Item("DateFrom").ToString()).ToString("d")
                        dteSEDExistingStart_007.Date = DateTime.Parse(dtColumns.Rows(0).Item("DateFrom").ToString()).ToString("d")

                        Dim duration As Double = Double.Parse(dtColumns.Rows(0).Item("ServiceAgreement").ToString())
                        Dim totalMonths As Integer = (Math.Truncate(duration) * 12) + ((duration - Math.Truncate(duration)) * 0.12 * 100)

                        txtSEDExpiry_007.Text = DateTime.Parse(dteSEDExistingStart_007.Value).AddMonths(totalMonths)

                    End If

                    With EDetails

                        CType(pnlTrainingAgreement.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Training Agreement: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & dtColumns.Rows(0).Item("Name").ToString()

                    End With

                End With

            Next

            dtColumns.Dispose()

        End If

        dtColumns = Nothing

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        isTrainingAdmin = IsData(GetSQLDT("SELECT 1 FROM [ess.Path] p  INNER JOIN [ess.WF] wf 	ON p.[WFID] = wf.[ID] INNER JOIN [ess.ActionLU] alu 	ON wf.[ActionID] = alu.[ID] WHERE p.[ID] = '" & PathID & "' AND alu.[ReportsToType] = 'Training Admin - External'"))

        If (Not IsPostBack) Then

            EDetails = GetUserDetails(Session, "Training Tab", True)

            PopulateFields()

            LoadExpDS(dsCategoryBC_010, "SELECT DISTINCT [CategoryName] FROM TrainingExternalBudget ORDER BY [CategoryName]")

            txtBudgetCodeBC_010.Enabled = False

            txtBeginningBalanceBC_010.Enabled = False

            txtTrainingCostBC_010.Enabled = False

            txtBudgetBalanceBC_010.Enabled = False

            txtRTA_007.Enabled = isTrainingAdmin

            dteSEDExistingStart_007.Enabled = isTrainingAdmin

            cmbCategoryBC_010.Enabled = isTrainingAdmin

        End If

        UDetails = GetUserDetails(Session, "Training Tab")

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        Dim ErrorText As String = SUCCESS

        If (Values(0) = "Approve" AndAlso isTrainingAdmin) Then

            If (txtRTA_007.Text = String.Empty) Then

                ErrorText = "information RTA No. cannot be empty."

                GoTo ErrorMessage

            ElseIf (dteSEDExistingStart_007.Text = String.Empty) Then

                ErrorText = "information Existing/Start cannot be empty."

                GoTo ErrorMessage

            ElseIf (txtSEDExpiry_007.Text = String.Empty) Then

                ErrorText = "information Expiry cannot be empty."

                GoTo ErrorMessage

            ElseIf (cmbCategoryBC_010.SelectedIndex = -1) Then

                ErrorText = "information Category cannot be empty."

                GoTo ErrorMessage

            End If

        End If

        With UDetails

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

                Dim trainingStartDate As DateTime = DateTime.Parse(txtDuration_007.Text.Split("-")(0))

                Dim sql As StringBuilder = New StringBuilder()

                sql.AppendLine("exec [ess.WFProc]")
                sql.AppendLine("'" & origCompanyNum & "',")
                sql.AppendLine("'" & origEmployeeNum & "',")
                sql.AppendLine("'" & origCompanyNum & "',")
                sql.AppendLine("'" & origEmployeeNum & "',")
                sql.AppendLine("" & PathID & ",")
                sql.AppendLine("'Training',")
                sql.AppendLine("'Agreement',")
                sql.AppendLine("'" & Values(0) & "',")
                sql.AppendLine("'" & GetXML(PathData, KeyName:="ActionType") & "',")
                sql.AppendLine("'" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                sql.AppendLine()
                sql.AppendLine("UPDATE taf")
                sql.AppendLine("SET taf.[Status] = '" & IIf(Not isTrainingAdmin AndAlso Values(0) = "Approve", "PendingApproval", Values(0)) & "',")
                sql.AppendLine("taf.[RTANum] = '" & txtRTA_007.Text & "',")
                sql.AppendLine("taf.[DatePrepared] = '" & Now.ToString("MM/dd/yyyy") & "',")
                sql.AppendLine("taf.[Remarks] = '" & txtRemarks.Text.Trim() & "',")
                sql.AppendLine("taf.[Category] = '" & cmbCategoryBC_010.Text & "',")
                sql.AppendLine("taf.[BudgetCode] = '" & txtBudgetCodeBC_010.Text & "',")
                sql.AppendLine("taf.[BeginningBalance] = '" & txtBeginningBalanceBC_010.Text & "',")
                sql.AppendLine("taf.[EndingBalance] = '" & txtBudgetBalanceBC_010.Text & "'")
                sql.AppendLine("FROM [TrainingAgreementForm] taf")
                sql.AppendLine("WHERE taf.[PathID] = '" & PathID & "'")
                sql.AppendLine()
                sql.AppendLine("UPDATE tad")
                sql.AppendLine("SET tad.[Duration] = '" & txtSEDDuration_007.Text & "',")
                sql.AppendLine("tad.[ExistingStart] = '" & dteSEDExistingStart_007.Text & "',")
                sql.AppendLine("tad.[Expiry] = '" & txtSEDExpiry_007.Text & "'")
                sql.AppendLine("FROM [TAFProgramDetails] tad")
                sql.AppendLine("INNER JOIN [TrainingAgreementForm] taf")
                sql.AppendLine("ON taf.[TAFID] = tad.[TAFID]")
                sql.AppendLine("WHERE taf.[PathID] = '" & PathID & "'")
                sql.AppendLine()
                sql.AppendLine("UPDATE teb")
                sql.AppendLine("SET teb.[RemainingBudget] = '" & Decimal.Parse(IIf(txtBudgetBalanceBC_010.Text = String.Empty, 0D, txtBudgetBalanceBC_010.Text)).ToString() & "'")
                sql.AppendLine("FROM [TrainingExternalBudget] teb")
                sql.AppendLine("WHERE teb.[CategoryName] = '" & cmbCategoryBC_010.Text & "'")
                sql.AppendLine("AND teb.[Year] = '" & trainingStartDate.Year.ToString() & "'")
                sql.AppendLine("AND teb.[Month] = '" & trainingStartDate.Month.ToString() & "'")
                sql.AppendLine()
                sql.AppendLine("UPDATE tem")
                sql.AppendLine("SET tem.[SequenceNum] = '" & txtNewSequenceBC_010.Text & "',")
                sql.AppendLine("tem.[BudgetCode] = CONVERT(VARCHAR, tem.[Year]) + tem.[Text] + '" & txtNewSequenceBC_010.Text & "'")
                sql.AppendLine("FROM [TrainingExternalBudgetMonitoring] tem")
                sql.AppendLine("WHERE tem.[CategoryName] = '" & cmbCategoryBC_010.Text & "'")
                sql.AppendLine("AND tem.[Year] = '" & trainingStartDate.Year.ToString() & "'")

                If (Values(0) = "Approve" AndAlso isTrainingAdmin) Then

                    sql.AppendLine("UPDATE tp")
                    sql.AppendLine("	SET tp.[cfType] = tad.[Type],")
                    sql.AppendLine("	tp.[cfProgramType] = tad.[ProgramType],")
                    sql.AppendLine("	tp.[cfInvestment] = tad.[Investment],")
                    sql.AppendLine("	tp.[cfExistingStart] = tad.[ExistingStart],")
                    sql.AppendLine("	tp.[cfDuration] = tad.[Duration],")
                    sql.AppendLine("	tp.[cfExpiry] = tad.[Expiry],")
                    sql.AppendLine("	tp.[cfCELastDay] = IIF(tad.[Expiry] IS NULL, NULL, DATEDIFF(DAY, tad.[DateFrom], tad.[Expiry])),")
                    sql.AppendLine("	tp.[cfCEDateToday] = IIF(tad.[Expiry] IS NULL, NULL, DATEDIFF(DAY, GETDATE(), tad.[Expiry])),")
                    sql.AppendLine("	tp.[cfContractCompletion] = IIF(tad.[Expiry] IS NULL, NULL, IIF(CONVERT(DECIMAL(16,2), (CONVERT(DECIMAL(16,2), DATEDIFF(DAY, tad.[DateFrom], tad.[Expiry])) - CONVERT(DECIMAL(16,2), DATEDIFF(DAY, GETDATE(), tad.[Expiry]))) / CONVERT(DECIMAL(16,2), DATEDIFF(DAY, tad.[DateFrom], tad.[Expiry])) * 100) < 0, CONVERT(DECIMAL(16,2), 0), CONVERT(DECIMAL(16,2), (CONVERT(DECIMAL(16,2), DATEDIFF(DAY, tad.[DateFrom], tad.[Expiry])) - CONVERT(DECIMAL(16,2), DATEDIFF(DAY, GETDATE(), tad.[Expiry]))) / CONVERT(DECIMAL(16,2), DATEDIFF(DAY, tad.[DateFrom], tad.[Expiry])) * 100))),")
                    sql.AppendLine("	tp.[cfContractStatus] = IIF(tad.[Expiry] IS NULL, NULL, CASE WHEN GETDATE() > tad.[Expiry] THEN 'Served' WHEN GETDATE() <= tad.[Expiry] THEN 'Pending Completion' END),")
                    sql.AppendLine("	tp.[TrainingStatus] = 'Approved',")
                    sql.AppendLine("	tp.[cfDateReceived] = '" & Now.ToString("MM/dd/yyyy") & "',")
                    sql.AppendLine("	tp.[cfBudgetCode] = '" & txtBudgetCodeBC_010.Text & "',")
                    sql.AppendLine("	tp.[cfBudgetCategory] = '" & cmbCategoryBC_010.Text & "',")
                    sql.AppendLine("	tp.[cfDivision] = co.[Division],")
                    sql.AppendLine("	tp.[cfDepartment] = co.[SubDivision],")
                    sql.AppendLine("	tp.[cfSection] = co.[SubSubDivision],")
                    sql.AppendLine("	tp.[cfLevel] = pers1.[OFOCode]")
                    sql.AppendLine("FROM [TrainingPlanned] tp")
                    sql.AppendLine("INNER JOIN [TrainingAgreementForm] taf")
                    sql.AppendLine("	ON tp.[PathID] = taf.[PathID]")
                    sql.AppendLine("INNER JOIN [TAFProgramDetails] tad")
                    sql.AppendLine("	ON taf.[TAFID] = tad.[TAFID]")
                    sql.AppendLine("INNER JOIN [Personnel1] pers1")
                    sql.AppendLine("	ON taf.[EmployeeNum] = pers1.[EmployeeNum]")
                    sql.AppendLine("INNER JOIN [Company] co")
                    sql.AppendLine("	ON taf.[CompanyNum] = co.[CompanyNum]")
                    sql.AppendLine("WHERE tp.[PathID] = '" & PathID & "'")

                End If

                bSaved = ExecSQL(sql.ToString())

            Else

                bSaved = True

            End If

            If (bSaved) Then

                ErrorText = "tasks.aspx tools/index.aspx"

            End If

        End With

ErrorMessage:

        e.Result = Values(0) & " " & ErrorText

    End Sub

    Private Sub dteSEDExistingStart_007_DateChanged(sender As Object, e As EventArgs) Handles dteSEDExistingStart_007.DateChanged

        Dim duration As Double = Double.Parse(txtSEDDuration_007.Text.Replace(" years", String.Empty))
        Dim totalMonths As Integer = (Math.Truncate(duration) * 12) + ((duration - Math.Truncate(duration)) * 0.12 * 100)

        txtSEDExpiry_007.Text = DateTime.Parse(dteSEDExistingStart_007.Value).AddMonths(totalMonths)

        updExpiry_007.Update()

    End Sub

    Protected Sub cmbCategoryBC_010_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbCategoryBC_010.SelectedIndexChanged

        Dim sql As StringBuilder = New StringBuilder()
        Dim trainingStartDate As DateTime = DateTime.Parse(txtDuration_007.Text.Split("-")(0))

        sql.AppendLine("SELECT TOP 1 tem.[BudgetCode], teb.[RemainingBudget], tem.[SequenceNum]")
        sql.AppendLine("FROM [TrainingExternalBudgetMonitoring] tem")
        sql.AppendLine("INNER JOIN [TrainingExternalBudget] teb")
        sql.AppendLine("    ON tem.[Year] = teb.[Year]")
        sql.AppendLine("    AND tem.[CategoryName] = teb.[CategoryName]")
        sql.AppendLine("    AND teb.[Month] = '" & trainingStartDate.Month.ToString() & "'")
        sql.AppendLine("WHERE tem.[CategoryName] = '" & cmbCategoryBC_010.Text & "'")
        sql.AppendLine("AND tem.[Year] = '" & trainingStartDate.Year.ToString() & "'")

        Dim dtColumns As DataTable = GetSQLDT(sql.ToString())

        txtBudgetCodeBC_010.Text = String.Empty

        txtBeginningBalanceBC_010.Text = String.Empty

        txtTrainingCostBC_010.Text = String.Empty

        txtBudgetBalanceBC_010.Text = String.Empty

        txtNewSequenceBC_010.Value = String.Empty

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    txtBudgetCodeBC_010.Text = dtColumns.Rows(0).Item("BudgetCode").ToString()

                    txtBeginningBalanceBC_010.Text = String.Format("{0:n}", Decimal.Parse(dtColumns.Rows(0).Item("RemainingBudget").ToString()))

                    txtTrainingCostBC_010.Text = String.Format("{0:n}", Decimal.Parse(txtInvestment_007.Text))

                    txtBudgetBalanceBC_010.Text = IIf(txtBeginningBalanceBC_010.Text = String.Empty, String.Format("{0:n}", 0), String.Format("{0:n}", Decimal.Parse(dtColumns.Rows(0).Item("RemainingBudget").ToString()) - Decimal.Parse(txtInvestment_007.Text)))

                    txtNewSequenceBC_010.Text = (Integer.Parse(dtColumns.Rows(0).Item("SequenceNum").ToString()) + 1).ToString(New String("0", dtColumns.Rows(0).Item("SequenceNum").ToString().Length))

                    updBudgetCodeBC_010.Update()

                    updBeginningBalanceBC_010.Update()

                    updTrainingCostBC_010.Update()

                    updBudgetBalanceBC_010.Update()

                    updNewSequenceBC_010.Update()

                End With

            Next

            dtColumns.Dispose()

        End If

        dtColumns = Nothing

    End Sub

#End Region

End Class