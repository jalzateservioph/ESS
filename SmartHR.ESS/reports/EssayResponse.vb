Imports System
Imports DevExpress.XtraEditors
Imports DevExpress.XtraEditors.Controls
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraReports.UI
Public Class EssayResponse
    Dim RowNum As Integer
    
    Private Sub EssayResponse_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles MyBase.BeforePrint
        RowNum = 0
        Dim pSCode As String = Parameters("pSCode").Value.ToString()
        'Dim pEssay As String = Parameters("pEssay").Value.ToString()
        Dim ds As New DataSet
        'dt = GetSQLDT(String.Format("SELECT TOP 5 ROW_NUMBER( ) OVER(ORDER BY COUNT DESC) AS Rank, Items, Total, KPAName, Count, CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),[Percent])) + '% (' + CONVERT(VARCHAR,COUNT) + ' TMs)' [Percentage] FROM [ess.EssayResponse] WHERE KPACode = '{0}'", pEssay))
        ds = GetSQLDS(String.Format("EXEC spEssayResponse '{0}'", pSCode))
        Me.DataSource = ds

        ' Create a group header band and add it to the report.
        Dim ghBand As New GroupHeaderBand()
        Me.Bands.Add(ghBand)

        ' Create a group field, 
        ' and assign it to the group header band.
        Dim groupField As New GroupField("KPACode")
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