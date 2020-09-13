Imports System
Imports DevExpress.XtraEditors
Imports DevExpress.XtraEditors.Controls
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraReports.UI
Public Class CommentsGroup
    Dim RowNum As Integer
    Private Sub CommentsGroup_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles MyBase.BeforePrint
        RowNum = 0
        Dim pKeyword As String = Parameters("pKeyword").Value.ToString()
        Dim pSchemeCode As String = Parameters("pSchemeCode").Value.ToString()
        Dim dt As New DataTable
        lblHeader.Text = String.Format(lblHeader.Text, pKeyword.ToUpper())
        lblDate.Text = DateTime.Now.ToShortDateString()

        dt = GetSQLDT("SELECT Items FROM [ESS.TWSKeywordList] Where Keyword = '" & pKeyword & "'")


        Dim pQuery As String
        pQuery = "SELECT	Distinct " &
                    "com.SubDivision + (CASE WHEN com.SubSubDivision != '-' THEN '/' + com.SubSubDivision ELSE ''END) [CommentFrom] " &
                    ", CAST(kpa.StickyNotes AS NVARCHAR(MAX)) StickyNotes " &
                    "FROM          PerfEvalKPA AS kpa INNER JOIN " &
                    "Company AS com ON com.CompanyNum = kpa.CompanyNum INNER JOIN " &
                    "PerfEvalScheme AS perfscheme ON perfscheme.EmployeeNum = kpa.EmployeeNum AND perfscheme.SchemeCode = kpa.SchemeCode LEFT JOIN " &
                    "PerfClass AS class ON class.ClassCode = kpa.ClassCode LEFT JOIN " &
                    "Personnel AS person ON SUBSTRING (kpa.Notes, 14, 7) = person.EmployeeNum " &
                    "WHERE(perfscheme.Completed = 1) " &
                    "AND perfscheme.SchemeCode = '{0}' " &
                    "AND (kpa.ElementName IS NOT NULL) " &
                    "AND (kpa.StickyNotes is not null and cast(kpa.StickyNotes as nvarchar(max)) != '') " &
                    "and  ( "

        For index As Integer = 0 To dt.Rows.Count - 1
            pQuery = pQuery & " cast(kpa.StickyNotes as nvarchar(max)) like '%" & dt.Rows(index)(0).ToString() & "%' "
            If index = dt.Rows.Count - 1 Then
                pQuery = pQuery & " ) "
            Else
                pQuery = pQuery & " OR "
            End If
        Next

        dt = GetSQLDT(String.Format(pQuery, pSchemeCode))
        Me.DataSource = dt
        xtcDept.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "CommentFrom", ""))
        xtcComments.DataBindings.Add(New DevExpress.XtraReports.UI.XRBinding("Text", dt, "StickyNotes", ""))


    End Sub

    'this.DataSource = dTable;
    '       this.xrtcEmpCode.DataBindings.Add(new DevExpress.XtraReports.UI.XRBinding("Text", dTable, "EmployeeCode", ""));
    '       this.xrtcEmpName.DataBindings.Add(new DevExpress.XtraReports.UI.XRBinding("Text", dTable, "EmployeeName", ""));
    '       this.xrtcDivision.DataBindings.Add(new DevExpress.XtraReports.UI.XRBinding("Text", dTable, "DivisionCode", ""));
    '       this.xrtcDeptCode.DataBindings.Add(new DevExpress.XtraReports.UI.XRBinding("Text", dTable, "DepartmentCode", ""));
    '       this.xrtcSection.DataBindings.Add(new DevExpress.XtraReports.UI.XRBinding("Text", dTable, "SectionCode", ""));
    '       this.xrLabel1.Text = string.Format("PERFECT ATTENDANCE - {0}", cutOffDate.AddMonths(-1).ToString("MMMM"));
    '       this.xrLabel2.Text = String.Format("Payout : {0}",cutOffDate.ToString("MMMM dd, yyyy"));
 
    Private Sub Detail_BeforePrint(sender As System.Object, e As System.Drawing.Printing.PrintEventArgs) Handles Detail.BeforePrint
        RowNum = RowNum + 1
        xtcCtr.Text = RowNum.ToString()
    End Sub
End Class

'private void XtraReport1_ParametersRequestBeforeShow(object sender, ParametersRequestEventArgs e) {
'            CategoriesDataSet dataSet = new CategoriesDataSet();
'            CategoriesDataSetTableAdapters.CategoriesTableAdapter adapter = 
'                    new CategoriesDataSetTableAdapters.CategoriesTableAdapter();
'            adapter.Fill(dataSet.Categories);

'foreach (ParameterInfo info in e.ParametersInformation) {
'    if (info.Parameter.Name == "parameter1") {
'        LookUpEdit lookUpEdit = new LookUpEdit();
'        lookUpEdit.Properties.DataSource = dataSet.Categories;
'        lookUpEdit.Properties.DisplayMember = "CategoryName";
'        lookUpEdit.Properties.ValueMember = "CategoryID";
'        lookUpEdit.Properties.Columns.Add(new LookUpColumnInfo("CategoryName", 0, "Category Name"));
'        lookUpEdit.Properties.NullText = "<Select Category>";

'        info.Editor = lookUpEdit;
'        info.Parameter.Value = DBNull.Value;
'    }
'}

'        }