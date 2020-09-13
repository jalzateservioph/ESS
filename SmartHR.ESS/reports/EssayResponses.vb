Imports System
Imports DevExpress.XtraEditors
Imports DevExpress.XtraReports.UI
Imports DevExpress.XtraEditors.Controls
Imports DevExpress.XtraReports.Parameters

Public Class EssayResponses
    Dim RowNum As Integer

    Private Sub EssayResponses_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles MyBase.BeforePrint
        RowNum = 0

        Dim pSCode As String = Parameters("pSCode").Value.ToString()

        Dim ds As New DataSet
        Dim ghBand As New GroupHeaderBand()
        Dim groupField As New GroupField("KPACode")

        ds = GetSQLDS(String.Format("EXEC spEssayResponse '{0}'", pSCode))

        Me.DataSource = ds
        Me.Bands.Add(ghBand)

        GroupHeader1.GroupFields.Add(groupField)

        xtcItem.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", ds, "Items", ""))
        xtcPrcnt.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", ds, "Percent", ""))
        xrQuestion.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", ds, "KPAName", ""))
        xrTotal.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", ds, "Total", "*Out of {0} Respondents"))
    End Sub

    Private Sub Detail_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles Detail.BeforePrint
        If (RowNum < 5) Then
            RowNum = RowNum + 1
        Else
            RowNum = 1
        End If
        xtcRank.Text = RowNum.ToString()
    End Sub
End Class