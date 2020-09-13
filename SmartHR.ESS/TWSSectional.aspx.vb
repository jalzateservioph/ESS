Imports System
Imports System.Data
Imports DevExpress.XtraPivotGrid
Imports System.Linq

Public Class TWSSectional
    Inherits System.Web.UI.Page

    Dim xCur As String
    Dim xPre As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GetData()
        End If
        LoadDateSource()
        pgvCorporate.OptionsPager.PageIndex = -1
        Try
            Dim DTab As New DataTable
            Dim Code As String
            Dim xCtr As Integer
            DTab = GetSQLDT("SELECT TOP(1) SchemeCode FROM [ess.TWSRawData]")
            Code = DTab.Rows(0)("SchemeCode").ToString()

            If Code IsNot Nothing Then
                xCtr = Code.Length
                xCur = Code.Substring(xCtr - 4, 4)
                If xCur = "2014" Then
                    xCtr = Integer.Parse(xCur) - 2
                Else
                    xCtr = Integer.Parse(xCur) - 1
                End If
                xPre = (xCtr).ToString()

                lblBanner.Text = xCur + " Workplace Survey"
                fieldCurrent.Caption = xCur
                fieldPrevious.Caption = xPre
            End If
        Catch x As Exception

        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        Session("DTTWSSectional") = Nothing
        Response.Redirect("./twsreports.aspx")
    End Sub

    Private Sub btnExport_Click(sender As Object, e As System.EventArgs) Handles btnExport.Click
        ExportData()
    End Sub

    Public Sub GetData()
        Session("DTTWSSectional") = GetSQLDT("SELECT RTRIM(RTRIM(Section)) Section, RTRIM(RTRIM(Aspect)) Aspect, RTRIM(RTRIM(KPAName)) KPAName, PreviousYear, CurrentYear FROM [ess.TWSRawData] WHERE KPAName NOT IN ('CO', 'ESY')")
        Session("DTGRAND") = GetSQLDT("SELECT Section, ISNULL(AVG([PreviousYear]), 0) [PreviousYear], ISNULL(AVG([CurrentYear]), 0) [CurrentYear], ISNULL(AVG([CurrentYear]) - AVG([PreviousYear]), 0) [Diff] FROM (SELECT RTRIM(LTRIM(Section)) Section, RTRIM(LTRIM(Aspect)) Aspect, AVG(PreviousYear) [PreviousYear], AVG(CurrentYear) [CurrentYear] FROM [ess.TWSRawData] WHERE KPAName NOT IN ('CO', 'ESY') GROUP BY RTRIM(LTRIM(Section)), RTRIM(LTRIM(Aspect))) X GROUP BY Section")
    End Sub

    Public Sub LoadDateSource()
        pgvCorporate.DataSource = CType(Session("DTTWSSectional"), DataTable)
        pgvCorporate.DataBind()
    End Sub

    Public Sub ExportData()
        Dim strFileName As String = "SectionalResult_" & DateTime.Now.ToString("yyyyMMdd")
        pgeCorporate.ExportXlsxToResponse(strFileName, True)
    End Sub

    Private Sub pgvCorporate_CustomCellValue(sender As Object, e As DevExpress.Web.ASPxPivotGrid.PivotCellValueEventArgs) Handles pgvCorporate.CustomCellValue
        Dim objColumn As [Object], objSection As [Object]

        If e.RowValueType = PivotGridValueType.GrandTotal Then

            objSection = e.GetFieldValue(fieldSection)
            objColumn = e.DataField

            Dim dt As New DataTable()
            dt = DirectCast(Session("DTGRAND"), DataTable)
            Dim result As DataRow()

            If objSection <> Nothing Then
                result = dt.[Select](String.Format("Section = '{0}'", objSection.ToString()))

                For Each row As DataRow In result
                    If (objColumn.ToString() = "Diff +/-") Then
                        e.Value = Convert.ToDouble(row("Diff").ToString()).ToString("0.00")
                    Else
                        e.Value = Convert.ToDouble(row(If(objColumn.ToString() = xPre, "PreviousYear", "CurrentYear")).ToString()).ToString("0.00")
                    End If
                Next
            End If

            If e.ColumnValueType = DevExpress.XtraPivotGrid.PivotGridValueType.GrandTotal Then

                Dim objDiv As Object()
                Dim pDiv As String = String.Empty
                objDiv = fieldSection.FilterValues.ValuesIncluded

                For i As Integer = 0 To objDiv.Count() - 1
                    If i <> objDiv.Count() - 1 Then
                        pDiv = String.Format("{0}{1}',", (pDiv & Convert.ToString("'")), objDiv(i))
                    Else
                        pDiv = String.Format("{0}{1}'", (pDiv & Convert.ToString("'")), objDiv(i))
                    End If
                Next

                dt = GetSQLDT(String.Format("SELECT AVG(PreviousYear) [PreviousYear], AVG(CurrentYear) [CurrentYear] FROM (SELECT Aspect, SUM(PreviousYear)/COUNT(PreviousYear) [PreviousYear], SUM(CurrentYear)/COUNT(CurrentYear) [CurrentYear] FROM [ess.TWSRawData] WHERE KPAName NOT IN ('CO', 'ESY') AND Section IN ({0}) GROUP BY Aspect) X", pDiv))
                If objColumn.ToString() = xPre Then
                    e.Value = Convert.ToDouble(dt.Rows(0)("PreviousYear")).ToString("0.00")
                ElseIf objColumn.ToString() = xCur Then
                    e.Value = Convert.ToDouble(dt.Rows(0)("CurrentYear")).ToString("0.00")
                ElseIf Not IsDBNull(dt.Rows(0)("CurrentYear")) AndAlso Not IsDBNull(dt.Rows(0)("PreviousYear")) Then
                    e.Value = Convert.ToDouble(Convert.ToDouble(dt.Rows(0)("CurrentYear")) - Convert.ToDouble(dt.Rows(0)("PreviousYear"))).ToString("0.00")
                Else
                    e.Value = ""
                End If
            End If
        End If
    End Sub
End Class