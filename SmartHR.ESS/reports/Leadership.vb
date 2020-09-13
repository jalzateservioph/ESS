Imports System.Data
Imports System.Drawing.Printing

Public Class Leadership
    Private pCtrPrev As Integer = 0
    Private pCtrCurr As Integer = 0
    Private pCtrDiff As Integer = 0
    Private pTotalPrev As Double = 0
    Private pTotalCurr As Double = 0
    Private pTotalDiff As Double = 0

    Private Sub Leadership_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles MyBase.BeforePrint
        Dim pSuperior As String = Parameters("pSuperior").Value.ToString()
        Dim pScheme As String = Parameters("pScheme").Value.ToString()

        Dim xCtr As Integer = pScheme.Length
        Dim xVar As String = pScheme.Substring(xCtr - 4, 4)
        XrLabel1.Text = xVar + " TMP Workplace Survey"

        XrTableCell5.Text = xVar
        If xVar = "2014" Then
            XrTableCell6.Text = "2012"
        Else
            Dim xCurr As Integer = Convert.ToInt32(xVar)
            Dim xPrev As Integer = xCurr - 1
            XrTableCell6.Text = xPrev.ToString
        End If

        Dim xID As String = pSuperior.Substring(0, 6)

        Dim dt As New DataTable
        dt = GetSQLDT(String.Format("EXEC [spLDRReprocess] '{0}','{1}'", pScheme, xID))

        lblSuperior.Text = dt.Rows(0)("SuperiorName").ToString()
        lblJobTitle.Text = dt.Rows(0)("IndividualJobTitle").ToString()
        lblDepartment.Text = dt.Rows(0)("SubDivision").ToString()
        lblSection.Text = dt.Rows(0)("SubSubDivision").ToString()

        Me.DataSource = dt
        xtcItem.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "Item", ""))
        xtcKPAName.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "KPAName", ""))
        xtcQuestion.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "Question", ""))
        xtcPrev.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "PreviousYear", ""))
        xtcCurr.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "CurrentYear", ""))
        xtcDiff.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "DIFF", ""))

        xtcPrev.Summary.FormatString = "n2"
        xtcCurr.Summary.FormatString = "n2"
        xtcDiff.Summary.FormatString = "n2"

        Dim pPrev As Double
        Dim pCurr As Double

        For index As Integer = 0 To dt.Rows.Count - 1
            If (dt.Rows(index)("PreviousYear") <> 0) Then
                pPrev = Math.Truncate(Convert.ToDouble(dt.Rows(index)("PreviousYear")) * 100) / 100
                pTotalPrev = pTotalPrev + pPrev
                pCtrPrev = pCtrPrev + 1
            End If
            If (dt.Rows(index)("CurrentYear") <> 0) Then
                pCurr = Math.Truncate(Convert.ToDouble(dt.Rows(index)("CurrentYear")) * 100) / 100
                pTotalCurr = pTotalCurr + pCurr
                pCtrCurr = pCtrCurr + 1
            End If
        Next

        pTotalPrev = Convert.ToDouble(pTotalPrev / pCtrPrev)
        pTotalCurr = Convert.ToDouble(pTotalCurr / pCtrCurr)

        xtcTotaPrev.Text = pTotalPrev.ToString("n2")
        xtcTotalCurr.Text = pTotalCurr.ToString("n2")

        xtcTotalDiff.Text = Convert.ToDouble(pTotalCurr - pTotalPrev).ToString("n2")

        xtcTotaPrev.Text = IsNull(xtcTotaPrev.Text)
        xtcTotalCurr.Text = IsNull(xtcTotalCurr.Text)
        xtcTotalDiff.Text = IsNull(xtcTotalDiff.Text)

        pSuperior = ""
        pScheme = ""
    End Sub

    Private Sub Detail_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles Detail.BeforePrint

    End Sub

    Private Function IsNull(ByVal pText As String) As String
        If pText = "NaN" Then
            Return "0.00"
        Else
            Return pText
        End If
    End Function
End Class