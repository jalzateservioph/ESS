<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class Leadership
    Inherits DevExpress.XtraReports.UI.XtraReport

    'XtraReport overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Designer
    'It can be modified using the Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim XrSummary1 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Dim XrSummary2 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Dim XrSummary3 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.XrTable2 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow2 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.xtcItem = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcKPAName = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcQuestion = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcCurr = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcPrev = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcDiff = New DevExpress.XtraReports.UI.XRTableCell()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.pSuperior = New DevExpress.XtraReports.Parameters.Parameter()
        Me.PageHeader = New DevExpress.XtraReports.UI.PageHeaderBand()
        Me.XrTable1 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow1 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell5 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell6 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.lblSection = New DevExpress.XtraReports.UI.XRLabel()
        Me.lblDepartment = New DevExpress.XtraReports.UI.XRLabel()
        Me.lblJobTitle = New DevExpress.XtraReports.UI.XRLabel()
        Me.lblSuperior = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.GroupFooter1 = New DevExpress.XtraReports.UI.GroupFooterBand()
        Me.XrTable3 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow3 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.xtcTotalCurr = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcTotaPrev = New DevExpress.XtraReports.UI.XRTableCell()
        Me.xtcTotalDiff = New DevExpress.XtraReports.UI.XRTableCell()
        Me.pScheme = New DevExpress.XtraReports.Parameters.Parameter()
        Me.XrTableCell7 = New DevExpress.XtraReports.UI.XRTableCell()
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrTable3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'Detail
        '
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrTable2})
        Me.Detail.HeightF = 25.0!
        Me.Detail.Name = "Detail"
        Me.Detail.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrTable2
        '
        Me.XrTable2.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 0.0!)
        Me.XrTable2.Name = "XrTable2"
        Me.XrTable2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 2, 2, 100.0!)
        Me.XrTable2.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow2})
        Me.XrTable2.SizeF = New System.Drawing.SizeF(750.0!, 25.0!)
        Me.XrTable2.StylePriority.UsePadding = False
        '
        'XrTableRow2
        '
        Me.XrTableRow2.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.xtcItem, Me.xtcKPAName, Me.xtcQuestion, Me.xtcCurr, Me.xtcPrev, Me.xtcDiff})
        Me.XrTableRow2.Name = "XrTableRow2"
        Me.XrTableRow2.Weight = 1.0R
        '
        'xtcItem
        '
        Me.xtcItem.Borders = CType((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcItem.Multiline = True
        Me.xtcItem.Name = "xtcItem"
        Me.xtcItem.StylePriority.UseBorders = False
        Me.xtcItem.Weight = 1.4R
        '
        'xtcKPAName
        '
        Me.xtcKPAName.Borders = CType((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcKPAName.Multiline = True
        Me.xtcKPAName.Name = "xtcKPAName"
        Me.xtcKPAName.StylePriority.UseBorders = False
        Me.xtcKPAName.Text = "KPAName"
        Me.xtcKPAName.Weight = 1.4000000000000001R
        '
        'xtcQuestion
        '
        Me.xtcQuestion.Borders = CType((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcQuestion.Multiline = True
        Me.xtcQuestion.Name = "xtcQuestion"
        Me.xtcQuestion.StylePriority.UseBorders = False
        Me.xtcQuestion.Text = "Question"
        Me.xtcQuestion.Weight = 3.0R
        '
        'xtcCurr
        '
        Me.xtcCurr.Borders = CType((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcCurr.Name = "xtcCurr"
        Me.xtcCurr.StylePriority.UseBorders = False
        Me.xtcCurr.StylePriority.UseTextAlignment = False
        XrSummary1.FormatString = "{0:n2}"
        Me.xtcCurr.Summary = XrSummary1
        Me.xtcCurr.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcCurr.Weight = 0.6R
        '
        'xtcPrev
        '
        Me.xtcPrev.Borders = CType((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcPrev.Name = "xtcPrev"
        Me.xtcPrev.StylePriority.UseBorders = False
        Me.xtcPrev.StylePriority.UseTextAlignment = False
        XrSummary2.FormatString = "{0:n2}"
        Me.xtcPrev.Summary = XrSummary2
        Me.xtcPrev.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcPrev.Weight = 0.60000000000000009R
        '
        'xtcDiff
        '
        Me.xtcDiff.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Right) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcDiff.Name = "xtcDiff"
        Me.xtcDiff.StylePriority.UseBorders = False
        Me.xtcDiff.StylePriority.UseTextAlignment = False
        XrSummary3.FormatString = "{0:n2}"
        Me.xtcDiff.Summary = XrSummary3
        Me.xtcDiff.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcDiff.Weight = 0.49999999999999978R
        '
        'TopMargin
        '
        Me.TopMargin.HeightF = 50.0!
        Me.TopMargin.Name = "TopMargin"
        Me.TopMargin.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'BottomMargin
        '
        Me.BottomMargin.HeightF = 50.0!
        Me.BottomMargin.Name = "BottomMargin"
        Me.BottomMargin.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'pSuperior
        '
        Me.pSuperior.Name = "pSuperior"
        '
        'PageHeader
        '
        Me.PageHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrTable1, Me.lblSection, Me.lblDepartment, Me.lblJobTitle, Me.lblSuperior, Me.XrLabel1})
        Me.PageHeader.HeightF = 180.2084!
        Me.PageHeader.Name = "PageHeader"
        '
        'XrTable1
        '
        Me.XrTable1.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 155.2084!)
        Me.XrTable1.Name = "XrTable1"
        Me.XrTable1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 2, 2, 100.0!)
        Me.XrTable1.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow1})
        Me.XrTable1.SizeF = New System.Drawing.SizeF(750.0!, 25.0!)
        Me.XrTable1.StylePriority.UsePadding = False
        '
        'XrTableRow1
        '
        Me.XrTableRow1.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell1, Me.XrTableCell2, Me.XrTableCell4, Me.XrTableCell5, Me.XrTableCell6, Me.XrTableCell3})
        Me.XrTableRow1.Name = "XrTableRow1"
        Me.XrTableRow1.Weight = 1.0R
        '
        'XrTableCell1
        '
        Me.XrTableCell1.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell1.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell1.Name = "XrTableCell1"
        Me.XrTableCell1.StylePriority.UseBorders = False
        Me.XrTableCell1.StylePriority.UseFont = False
        Me.XrTableCell1.StylePriority.UseTextAlignment = False
        Me.XrTableCell1.Text = "Skill Set"
        Me.XrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrTableCell1.Weight = 1.4R
        '
        'XrTableCell2
        '
        Me.XrTableCell2.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell2.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell2.Name = "XrTableCell2"
        Me.XrTableCell2.StylePriority.UseBorders = False
        Me.XrTableCell2.StylePriority.UseFont = False
        Me.XrTableCell2.StylePriority.UseTextAlignment = False
        Me.XrTableCell2.Text = "Item"
        Me.XrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrTableCell2.Weight = 1.4000000000000001R
        '
        'XrTableCell4
        '
        Me.XrTableCell4.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell4.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell4.Name = "XrTableCell4"
        Me.XrTableCell4.StylePriority.UseBorders = False
        Me.XrTableCell4.StylePriority.UseFont = False
        Me.XrTableCell4.StylePriority.UseTextAlignment = False
        Me.XrTableCell4.Text = "Questionnaire"
        Me.XrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrTableCell4.Weight = 3.0R
        '
        'XrTableCell5
        '
        Me.XrTableCell5.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell5.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell5.Name = "XrTableCell5"
        Me.XrTableCell5.StylePriority.UseBorders = False
        Me.XrTableCell5.StylePriority.UseFont = False
        Me.XrTableCell5.StylePriority.UseTextAlignment = False
        Me.XrTableCell5.Text = "Current"
        Me.XrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.XrTableCell5.Weight = 0.6R
        '
        'XrTableCell6
        '
        Me.XrTableCell6.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell6.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell6.Name = "XrTableCell6"
        Me.XrTableCell6.StylePriority.UseBorders = False
        Me.XrTableCell6.StylePriority.UseFont = False
        Me.XrTableCell6.StylePriority.UseTextAlignment = False
        Me.XrTableCell6.Text = "Previous"
        Me.XrTableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.XrTableCell6.Weight = 0.60000000000000009R
        '
        'XrTableCell3
        '
        Me.XrTableCell3.Borders = CType((((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Right) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell3.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell3.Name = "XrTableCell3"
        Me.XrTableCell3.StylePriority.UseBorders = False
        Me.XrTableCell3.StylePriority.UseFont = False
        Me.XrTableCell3.StylePriority.UseTextAlignment = False
        Me.XrTableCell3.Text = "Diff"
        Me.XrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.XrTableCell3.Weight = 0.49999999999999978R
        '
        'lblSection
        '
        Me.lblSection.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 107.6249!)
        Me.lblSection.Name = "lblSection"
        Me.lblSection.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.lblSection.SizeF = New System.Drawing.SizeF(502.0833!, 23.0!)
        Me.lblSection.Text = "SubSubDivision"
        '
        'lblDepartment
        '
        Me.lblDepartment.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 84.62495!)
        Me.lblDepartment.Name = "lblDepartment"
        Me.lblDepartment.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.lblDepartment.SizeF = New System.Drawing.SizeF(502.0833!, 23.0!)
        Me.lblDepartment.Text = "SubDivision"
        '
        'lblJobTitle
        '
        Me.lblJobTitle.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 61.62497!)
        Me.lblJobTitle.Name = "lblJobTitle"
        Me.lblJobTitle.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.lblJobTitle.SizeF = New System.Drawing.SizeF(502.0833!, 23.0!)
        Me.lblJobTitle.Text = "JobTitle"
        '
        'lblSuperior
        '
        Me.lblSuperior.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 38.62498!)
        Me.lblSuperior.Name = "lblSuperior"
        Me.lblSuperior.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.lblSuperior.SizeF = New System.Drawing.SizeF(502.0833!, 23.0!)
        Me.lblSuperior.Text = "Superior"
        '
        'XrLabel1
        '
        Me.XrLabel1.Font = New System.Drawing.Font("Times New Roman", 20.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.XrLabel1.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 0.0!)
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel1.SizeF = New System.Drawing.SizeF(750.0!, 38.625!)
        Me.XrLabel1.StylePriority.UseFont = False
        Me.XrLabel1.Text = "TMP Workplace Survey"
        '
        'GroupFooter1
        '
        Me.GroupFooter1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrTable3})
        Me.GroupFooter1.HeightF = 50.0!
        Me.GroupFooter1.Name = "GroupFooter1"
        '
        'XrTable3
        '
        Me.XrTable3.LocationFloat = New DevExpress.Utils.PointFloat(0.0!, 0.0!)
        Me.XrTable3.Name = "XrTable3"
        Me.XrTable3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 2, 2, 100.0!)
        Me.XrTable3.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow3})
        Me.XrTable3.SizeF = New System.Drawing.SizeF(750.0!, 25.0!)
        Me.XrTable3.StylePriority.UsePadding = False
        '
        'XrTableRow3
        '
        Me.XrTableRow3.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell7, Me.xtcTotalCurr, Me.xtcTotaPrev, Me.xtcTotalDiff})
        Me.XrTableRow3.Name = "XrTableRow3"
        Me.XrTableRow3.Weight = 1.4032260350952963R
        '
        'xtcTotalCurr
        '
        Me.xtcTotalCurr.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcTotalCurr.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.xtcTotalCurr.Name = "xtcTotalCurr"
        Me.xtcTotalCurr.StylePriority.UseBorders = False
        Me.xtcTotalCurr.StylePriority.UseFont = False
        Me.xtcTotalCurr.StylePriority.UseTextAlignment = False
        Me.xtcTotalCurr.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcTotalCurr.Weight = 0.59999999999999987R
        '
        'xtcTotaPrev
        '
        Me.xtcTotaPrev.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcTotaPrev.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.xtcTotaPrev.Name = "xtcTotaPrev"
        Me.xtcTotaPrev.StylePriority.UseBorders = False
        Me.xtcTotaPrev.StylePriority.UseFont = False
        Me.xtcTotaPrev.StylePriority.UseTextAlignment = False
        Me.xtcTotaPrev.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcTotaPrev.Weight = 0.6000000000000002R
        '
        'xtcTotalDiff
        '
        Me.xtcTotalDiff.Borders = CType((((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Right) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.xtcTotalDiff.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.xtcTotalDiff.Name = "xtcTotalDiff"
        Me.xtcTotalDiff.StylePriority.UseBorders = False
        Me.xtcTotalDiff.StylePriority.UseFont = False
        Me.xtcTotalDiff.StylePriority.UseTextAlignment = False
        Me.xtcTotalDiff.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        Me.xtcTotalDiff.Weight = 0.49999923706054666R
        '
        'pScheme
        '
        Me.pScheme.Name = "pScheme"
        '
        'XrTableCell7
        '
        Me.XrTableCell7.Borders = CType(((DevExpress.XtraPrinting.BorderSide.Left Or DevExpress.XtraPrinting.BorderSide.Top) _
            Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrTableCell7.Font = New System.Drawing.Font("Times New Roman", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrTableCell7.Name = "XrTableCell7"
        Me.XrTableCell7.StylePriority.UseBorders = False
        Me.XrTableCell7.StylePriority.UseFont = False
        Me.XrTableCell7.Text = "Leadership Rating Average:"
        Me.XrTableCell7.Weight = 5.8000007629394537R
        '
        'Leadership
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.Detail, Me.TopMargin, Me.BottomMargin, Me.PageHeader, Me.GroupFooter1})
        Me.ExportOptions.Xls.TextExportMode = DevExpress.XtraPrinting.TextExportMode.Text
        Me.ExportOptions.Xlsx.TextExportMode = DevExpress.XtraPrinting.TextExportMode.Text
        Me.Margins = New System.Drawing.Printing.Margins(51, 49, 50, 50)
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.pSuperior, Me.pScheme})
        Me.Version = "11.1"
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrTable3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub
    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents pSuperior As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents XrTable2 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow2 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents xtcItem As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcKPAName As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcQuestion As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcCurr As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcPrev As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcDiff As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents PageHeader As DevExpress.XtraReports.UI.PageHeaderBand
    Friend WithEvents XrTable1 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow1 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell5 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell6 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents lblSection As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents lblDepartment As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents lblJobTitle As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents lblSuperior As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupFooter1 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents XrTable3 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow3 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents xtcTotalCurr As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcTotaPrev As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents xtcTotalDiff As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents pScheme As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents XrTableCell7 As DevExpress.XtraReports.UI.XRTableCell
End Class
