Imports System
Imports System.Data
Imports DevExpress.XtraPivotGrid
Imports System.Linq

Public Class TWSDepartmental
    Inherits System.Web.UI.Page

    Dim xInt As Integer
    Dim xYear As String
    Dim yYear As String
    Dim zYear As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Initialize()
        End If

        LoadDataSource()

        Try
            Dim xScheme() As Object = GetSQLFields("SELECT TOP(1) SchemeCode FROM [ess.TWSRawData] WHERE CreatedBy = '" & Session("LoggedOn").UserID & "'")
            xYear = xScheme(0).ToString().Substring(xScheme(0).ToString().Length - 4, 4)

            xInt = Int16.Parse(xYear) - 1
            yYear = xInt.ToString()

            xInt = Int16.Parse(xYear) - 2
            zYear = xInt.ToString()

            xCurrent.Caption = xYear
            yCurrent.Caption = xYear

            yPrevious.Caption = yYear
            xPrevious.Caption = zYear

            lblBanner.Text = xYear & " Workplace Survey"

            If Double.Parse(xYear) Mod 2.0 = 1.0 Then
                TWSCorporate.Visible = False
                btnExportTWS.Visible = False
            End If
        Catch x As Exception

        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        Session("DTLDRSection") = Nothing
        Session("DTTWSSection") = Nothing
        Session("DTGRAND") = Nothing
        Response.Redirect("./twsreports.aspx")
    End Sub

    Public Sub Initialize()
        Session("DTLDRSection") = GetSQLDT("SELECT RTRIM(LTRIM(Department)) Department, RTRIM(LTRIM(Section)) Section, RTRIM(LTRIM(Aspect)) Aspect, RTRIM(LTRIM(KPAName)) KPAName, PreviousYear, CurrentYear FROM [ess.TWSRawData] WHERE Aspect IN ('Leadership') AND CreatedBy = '" & Session("LoggedOn").UserID & "'")
        Session("DTTWSSection") = GetSQLDT("SELECT RTRIM(LTRIM(Department)) Department, RTRIM(LTRIM(Section)) Section, RTRIM(LTRIM(Aspect)) Aspect, RTRIM(LTRIM(KPAName)) KPAName, PreviousYear, CurrentYear FROM [ess.TWSRawData] WHERE Aspect != ('Leadership') AND CreatedBy = '" & Session("LoggedOn").UserID & "'")
        LDRCorporate.OptionsPager.PageIndex = -1
        TWSCorporate.OptionsPager.PageIndex = -1
        'LDRCorporate.OptionsPager.Visible = False
        'TWSCorporate.OptionsPager.Visible = False
        'LDRCorporate.OptionsView.ShowFilterHeaders = False
        'TWSCorporate.OptionsView.ShowFilterHeaders = False

        Session("DTGRAND") = GetSQLDT("SELECT Section, ISNULL(AVG([PreviousYear]), 0) [PreviousYear], ISNULL(AVG([CurrentYear]), 0) [CurrentYear], ISNULL(AVG([CurrentYear]) - AVG([PreviousYear]), 0) [Diff] FROM (SELECT RTRIM(LTRIM(Section)) Section, RTRIM(LTRIM(Aspect)) Aspect, AVG(PreviousYear) [PreviousYear], AVG(CurrentYear) [CurrentYear] FROM [ess.TWSRawData] WHERE KPAName NOT IN ('CO', 'ESY') AND CreatedBy = '" & Session("LoggedOn").UserID & "' GROUP BY RTRIM(LTRIM(Section)), RTRIM(LTRIM(Aspect))) X GROUP BY Section")
    End Sub

    Public Sub LoadDataSource()
        LDRCorporate.DataSource = CType(Session("DTLDRSection"), DataTable)
        LDRCorporate.DataBind()
        TWSCorporate.DataSource = CType(Session("DTTWSSection"), DataTable)
        TWSCorporate.DataBind()
    End Sub

    Protected Sub btnExportTWS_Click(sender As Object, e As EventArgs) Handles btnExportTWS.Click
        Dim xFileName As String = "Sectional TWS Result - " & DateTime.Now.ToString("yyyyMMdd")
        TWSCorporateExporter.ExportXlsxToResponse(xFileName, True)
    End Sub

    Protected Sub btnExportLDR_Click(sender As Object, e As EventArgs) Handles btnExportLDR.Click
        Dim xFileName As String = "Sectional LDR Result  - " & DateTime.Now.ToString("yyyyMMdd")
        LDRCorporateExporter.ExportXlsxToResponse(xFileName, True)
    End Sub

    Protected Sub TWSCorporate_CustomCellValue(sender As Object, e As DevExpress.Web.ASPxPivotGrid.PivotCellValueEventArgs) Handles TWSCorporate.CustomCellValue
        If e.RowValueType = PivotGridValueType.GrandTotal Then
            Dim xDiv As Object = e.GetFieldValue(xDivision)
            Dim xCol As Object = e.DataField

            Dim xTable As New DataTable()
            xTable = DirectCast(Session("DTGRAND"), DataTable)

            If xDiv <> Nothing Then
                Dim xRow As DataRow() = xTable.[Select](String.Format("Section = '{0}'", xDiv.ToString()))

                For Each row As DataRow In xRow
                    If (xCol.ToString() = "Diff +/-") Then
                        e.Value = Convert.ToDouble(row("Diff").ToString()).ToString("0.00")
                    Else
                        e.Value = Convert.ToDouble(row(If(xCol.ToString() = xYear, "CurrentYear", "PreviousYear")).ToString()).ToString("0.00")
                    End If
                Next
            End If

            If e.ColumnValueType = DevExpress.XtraPivotGrid.PivotGridValueType.GrandTotal Then

                Dim xGrand As New DataTable()
                xGrand = GetSQLDT(String.Format("SELECT AVG(PreviousYear) [PreviousYear], AVG(CurrentYear) [CurrentYear] FROM (SELECT Aspect, SUM(PreviousYear)/COUNT(PreviousYear) [PreviousYear], SUM(CurrentYear)/COUNT(CurrentYear) [CurrentYear] FROM [ess.TWSRawData] WHERE KPAName NOT IN ('CO','ESY') AND CreatedBy = '" & Session("LoggedOn").UserID & "' GROUP BY Aspect) X"))
                If xCol.ToString() = xYear Then
                    e.Value = Convert.ToDouble(xGrand.Rows(0)("CurrentYear")).ToString("0.00")
                ElseIf xCol.ToString() = yYear Then
                    e.Value = Convert.ToDouble(xGrand.Rows(0)("PreviousYear")).ToString("0.00")
                ElseIf Not IsDBNull(xGrand.Rows(0)("CurrentYear")) AndAlso Not IsDBNull(xGrand.Rows(0)("PreviousYear")) Then
                    e.Value = Convert.ToDouble(Convert.ToDouble(xGrand.Rows(0)("CurrentYear")) - Convert.ToDouble(xGrand.Rows(0)("PreviousYear"))).ToString("0.00")
                Else
                    e.Value = ""
                End If
            End If
        End If
    End Sub
End Class