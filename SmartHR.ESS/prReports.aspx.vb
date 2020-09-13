Imports System.Data.SqlClient
Imports System.Threading

Public Class prReports
    Inherits System.Web.UI.Page
#Region "design Purpose Only"
    Public count As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsCallback Then
            ' Intentionally pauses server-side processing, 
            ' to demonstrate the Loading Panel functionality.
            Thread.Sleep(500)
        End If
        LoadingPanel.ContainerElementID = If(False, "Panel", "")
        If Not IsPostBack Then
            hidetags(False)
            fillFilters()
            togglefiltercriteria(False)
            updateYear()
            btnDelete.Enabled = False
        End If
    End Sub

    'clearnavbarsitems
    Sub clearitemsofnavbars()
        For i = 0 To nbFirst.Groups.Count - 1
            nbFirst.Groups(i).Items.Clear()
        Next
        For i = 0 To nbSecond.Groups.Count - 1
            nbSecond.Groups(i).Items.Clear()
        Next
    End Sub
#End Region
#Region "Events"
    'when criteria changes
    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbCriteria.SelectedIndexChanged
        Dim cmd As New SqlCommand()
        If (cbCriteria.SelectedItem.ToString = "") Then
            lbCriteriaItems.Items.Clear()
        Else
            If (cbCriteria.SelectedItem.ToString = "Civil Status") Then
                cmd.CommandText = "select distinct maritialstatus from personnel where maritialstatus is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Attendance Rating") Then
                cmd.CommandText = "select 1 union all select 2 union all select 3 union all select 4 union all select 5"
            ElseIf (cbCriteria.SelectedItem.ToString = "Category") Then
                cmd.CommandText = "Select distinct ofocode from OFOCodeLU where ofocode <> 'Student Trainee'"
            ElseIf (cbCriteria.SelectedItem.ToString = "Cost Centre") Then
                cmd.CommandText = "select distinct Costcentre from personnel where costcentre is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Department") Then
                cmd.CommandText = "select distinct subdivision from company where subdivision is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Division") Then
                cmd.CommandText = "select distinct division from company where division is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Employment Type") Then
                cmd.CommandText = "select distinct employmenttype from personnel where employmenttype is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Group") Then
                '  cmd.CommandText = "select distinct employmenttype from personnel where employmenttype is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Institution") Then
                cmd.CommandText = "SELECT DISTINCT INSTITUTION FROM QUALIFICATIONS where INSTITUTION is not null and institution <> '' order by institution asc"

            ElseIf (cbCriteria.SelectedItem.ToString = "Job Title") Then
                cmd.CommandText = "select distinct jobtitle from personnel where jobtitle is not null order by jobtitle asc"
            ElseIf (cbCriteria.SelectedItem.ToString = "Job Type") Then
                cmd.CommandText = "select distinct jobtype from personnel where jobtype is not null order by jobtype asc"
            ElseIf (cbCriteria.SelectedItem.ToString = "Nationality") Then
                cmd.CommandText = "select distinct nationality from personnel where nationality is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Pay Grade") Then
                cmd.CommandText = "select distinct jobgrade from personnel where jobgrade is not null order by jobgrade asc"
            ElseIf (cbCriteria.SelectedItem.ToString = "Pay Level") Then
                cmd.CommandText = "SELECT DISTINCT OFOOccupation FROM Personnel1 order by ofooccupation"
            ElseIf (cbCriteria.SelectedItem.ToString = "Pay Mode") Then
                cmd.CommandText = "select distinct PAYMODE from personnel where PAYMODE is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Plant") Then
                cmd.CommandText = "select distinct LocationCategory from Personnel1 where locationcategory is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Section") Then
                cmd.CommandText = "select distinct subsubdivision from company where subsubdivision is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Sex") Then
                cmd.CommandText = "select distinct sex from personnel where sex is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Subsection") Then
                cmd.CommandText = "select distinct deptname from personnel where employmenttype is not null"
            ElseIf (cbCriteria.SelectedItem.ToString = "Surname") Then
                cmd.CommandText = "select distinct surname from personnel where employmenttype is not null"


            End If
            updateListbox(cmd)
        End If
        If (cbCriteria.SelectedIndex > 10) Then
            checkitems(nbSecond, cbCriteria.SelectedIndex - 11)
        Else
            checkitems(nbFirst, cbCriteria.SelectedIndex - 1)
        End If

        checkuncheck.Enabled = True
        checkuncheck.Checked = False
    End Sub
    'when ok is clicked
    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        listboxretrieve()
    End Sub
    Sub listboxretrieve()

        If (cbCriteria.SelectedIndex > 10) Then
            insertToRespectiveNavBar(nbSecond, cbCriteria.SelectedIndex - 11)
        Else
            insertToRespectiveNavBar(nbFirst, cbCriteria.SelectedIndex - 1)
        End If
    End Sub
    'when report type cHanges
    Protected Sub DropDownList2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbReportType.SelectedIndexChanged
        If (cbReportType.SelectedIndex = 1) Then
            hidetags(True)
        Else
            hidetags(False)
        End If
    End Sub
    'when filter changes
    Protected Sub cbFilter_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbFilter.SelectedIndexChanged
        cbCriteria.SelectedIndex = 0
        lbCriteriaItems.Items.Clear()
        clearitemsofnavbars()
        If (cbFilter.SelectedIndex = 0) Then
            togglefiltercriteria(False)
            txtFilterDesc.Text = ""
            btnSaveGo.Enabled = False
            btnDelete.Enabled = False
            checkuncheck.Checked = False
            checkuncheck.Enabled = False
            checkuncheck.Text = "Select All"
        ElseIf (cbFilter.SelectedIndex = 1) Then
            togglefiltercriteria(True)
            txtFilterDesc.Text = ""
            checkuncheck.Enabled = True
            checkuncheck.Checked = False
            checkuncheck.Text = "Select All"
        Else
            togglefiltercriteria(False)
            txtFilterDesc.Text = cbFilter.SelectedItem.Text
            retrieveItems(nbFirst)
            retrieveItems(nbSecond)
            checkuncheck.Enabled = False
            checkuncheck.Checked = False
            checkuncheck.Text = "Select All"
        End If
    End Sub
    'when clear filters button clicked
    Protected Sub ASPxButton4_Click(sender As Object, e As EventArgs) Handles btnClearFilters.Click

        txtFilterDesc.Text = ""
        cbCriteria.SelectedIndex = 0
        lbCriteriaItems.Items.Clear()
        clearitemsofnavbars()


        'Dim lbl As New Label
        'lbl.Text = "<script language='javascript'>" & Environment.NewLine & _
        '       "window.alert('asdasdasdasds" + "')</script>"
        'Page.Controls.Add(lbl)
    End Sub
    Sub displayMessage(ByVal Text As String)
        popuplabel.Text = Text
        popup.EnableAnimation = True
        popup.CloseAction = DevExpress.Web.ASPxClasses.CloseAction.CloseButton
        popup.PopupHorizontalAlign = DevExpress.Web.ASPxClasses.PopupHorizontalAlign.WindowCenter
        popup.PopupVerticalAlign = DevExpress.Web.ASPxClasses.PopupVerticalAlign.WindowCenter
        popup.ShowOnPageLoad = True
    End Sub

    'when save and go is selected
    Protected Sub btnSaveGo_Click(sender As Object, e As EventArgs) Handles btnSaveGo.Click


        If checkifFilterDescriptionExists() = False Then
            displayMessage("Filter Description Already Exists.")
        ElseIf (Not txtFilterDesc.Text.ToString.Trim() = "") Then
            checkNavBarGroupItems(nbFirst)
            checkNavBarGroupItems(nbSecond)
            LoadingPanel.ContainerElementID = If(True, "Panel", "")
            GoToReportViewer()
        ElseIf (txtFilterDesc.Text.Trim() = "") Then
            displayMessage("Filter Description is Required.")
        End If
    End Sub

    Function checkifFilterDescriptionExists()
        Dim des As Boolean = True
        For i = 0 To cbFilter.Items.Count - 1
            If (cbFilter.Items(i).Text.ToUpper = txtFilterDesc.Text.ToUpper) Then
                des = False
            End If
        Next
        Return des
    End Function
    'when go is selected
    Protected Sub btnGo_Click(sender As Object, e As EventArgs) Handles btnGo.Click
        LoadingPanel.ContainerElementID = If(True, "Panel", "")
        GoToReportViewer()
    End Sub
#End Region
#Region "sub"
    'retrieves the saved filter 
    Sub checkitems(ByVal navbar As DevExpress.Web.ASPxNavBar.ASPxNavBar, ByVal index As Integer)
        For i = 0 To lbCriteriaItems.Items.Count - 1
            For j = 0 To navbar.Groups(index).Items.Count - 1

                If (lbCriteriaItems.Items(i).Text = navbar.Groups(index).Items(j).Text) Then
                    lbCriteriaItems.Items(i).Selected = True
                End If

            Next
        Next
    End Sub
    'when cbfilters changes , retrieves the data from criteria
    Sub updateListbox(ByRef cmd As SqlCommand)
        lbCriteriaItems.Items.Clear()
        Dim con As New SqlConnection(SQLString())
        cmd.Connection = con
        Try
            con.Open()
            Dim rd As SqlDataReader = cmd.ExecuteReader()
            While rd.Read()
                lbCriteriaItems.Items.Add(rd.GetValue(0).ToString())
            End While
        Catch ex As Exception
        Finally
            con.Close()
        End Try

    End Sub
    'report type changes hide and show necessary fields
    Sub hidetags(ByVal condition As Boolean)
        promotionstag.Visible = condition
        promotionstag1.Visible = condition
        promotionstag2.Visible = condition
        performancetag.Visible = Not condition
    End Sub
    'retrieves the custom filters 
    Sub fillFilters()
        cbFilter.Items.Clear()
        cbFilter.Items.Add("None")
        cbFilter.Items.Add("Create New Filter")
        txtFilterDesc.Text = "None"
        Dim con As New SqlConnection(SQLString())
        Dim cmd As New SqlCommand("select distinct filtername from prCustomFilter", con)
        Dim dr As SqlDataReader
        Try
            con.Open()
            dr = cmd.ExecuteReader
            While dr.Read()
                cbFilter.Items.Add(dr.GetValue(0).ToString())
            End While
        Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
    'update some dates
    Sub updateYear()
        'update the cbYear
        cbYear.Items.Clear()
        For i = Date.Today.Year To 2010 Step -1
            cbYear.Items.Add(i)
        Next
        dateHired.Value = Date.Today()
        dateAsOf.Value = Date.Today()
        datesuspendFrom.Value = Date.Today()
        dateSuspendTo.Value = Date.Today()
        cbYear.SelectedIndex = 0
    End Sub
    'enables or disables filter builder 
    Sub togglefiltercriteria(ByVal condition As Boolean)
        btnGo.Enabled = Not condition
        btnClearFilters.Enabled = condition
        btnSaveGo.Enabled = condition
        btnDelete.Enabled = Not condition
        cbCriteria.Enabled = condition
        btnOk.Enabled = condition
        txtFilterDesc.Enabled = condition
    End Sub
    'when ok is clicked... this supports the event of BTNOK
    Sub insertToRespectiveNavBar(ByRef navbar As DevExpress.Web.ASPxNavBar.ASPxNavBar, ByVal index As Integer)
        If (cbCriteria.SelectedIndex > 0) Then

            navbar.Groups(index).Items.Clear()
            For i = 0 To lbCriteriaItems.Items.Count - 1
                If (lbCriteriaItems.Items(i).Selected) Then
                    navbar.Groups(index).Items.Add(lbCriteriaItems.Items(i).ToString())
                End If
            Next
        End If
    End Sub

    Sub retrieveItems(ByRef navbar As DevExpress.Web.ASPxNavBar.ASPxNavBar)
        For I = 0 To navbar.Groups.Count - 1
            retrieveItems(navbar, I)
        Next
    End Sub
    'retrieve item when criteria is changed
    Sub retrieveItems(ByRef navbar As DevExpress.Web.ASPxNavBar.ASPxNavBar, ByVal index As Integer)
        Dim con As New SqlConnection(SQLString())
        Dim cmd As New SqlCommand("select filters from prCustomFilter where filtercolumn = '" + navbar.Groups(index).Text + "' and filtername= '" + cbFilter.SelectedItem.ToString() + "'", con)

        Try
            con.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                navbar.Groups(index).Items.Add(dr.GetValue(0))
            End While
        Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
    'when go or save&go is selected... proceed to reportviewer
    Sub GoToReportViewer()
        Session("prReportType") = cbReportType.SelectedIndex
        Session("prRatingType") = cbRating.SelectedIndex
        Session("prYear") = cbYear.SelectedItem.ToString()
        Session("prHireDate") = Convert.ToDateTime(dateHired.Value).ToString("MM/dd/yyyy")
        Session("prAsOf") = Convert.ToDateTime(dateAsOf.Value).ToString("MM/dd/yyyy")
        Session("prFrom") = Convert.ToDateTime(datesuspendFrom.Value).ToString("MM/dd/yyyy")
        Session("prTo") = Convert.ToDateTime(dateSuspendTo.Value).ToString("MM/dd/yyyy")
        Session("prFilterDesc") = txtFilterDesc.Text
        Response.Redirect("prReportViewer.aspx")
        'Server.Transfer("prReportViewer.aspx", False)
    End Sub
#End Region
#Region "asp to MSSQl"
    'determines if navbar.group.item has items (di pa connected sa save and go)
    Sub checkNavBarGroupItems(ByVal navbar As DevExpress.Web.ASPxNavBar.ASPxNavBar)
        For i = 0 To navbar.Groups.Count - 1
            If (navbar.Groups(i).Items.Count > 0) Then
                'If (navbar.Groups(i).Text = "Surname") Then
                '    Dim surnameinitials As String = surname_concat(i)
                '    insertToCustomFilter(navbar.Groups(i).Text, surnameinitials)

                'Else
                For j = 0 To navbar.Groups(i).Items().Count - 1
                    insertToCustomFilter(navbar.Groups(i).Text, navbar.Groups(i).Items(j).Text)
                Next
                'End If
            End If
        Next
    End Sub
    Function surname_concat(ByVal index As Integer)
        Dim strings As String = ""
        For i = 0 To nbSecond.Groups(index).Items.Count - 1
            strings += nbSecond.Groups(index).Items(i).Text
        Next
        Return strings
    End Function
    'if meron iinsert ito sa prCustomFilter table
    Sub insertToCustomFilter(ByVal filterColumn As String, ByVal filter As String)
        Dim cmd As New SqlCommand("insert into prCustomFilter values ('" + txtFilterDesc.Text.Trim() + "','" + filterColumn + "','" + filter + "')")
        Dim con As New SqlConnection(SQLString())
        cmd.Connection = con
        Try
            con.Open()
            cmd.ExecuteNonQuery()
        Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
#End Region

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        popup.ShowOnPageLoad = False
    End Sub


    Protected Sub tabMenu_ActiveTabChanged(source As Object, e As DevExpress.Web.ASPxTabControl.TabControlEventArgs) Handles tabMenu.ActiveTabChanged
        If tabMenu.ActiveTabIndex = 0 Then
            Server.Transfer("prFileImporter.aspx", False)
        ElseIf tabMenu.ActiveTabIndex = 2 Then
            Server.Transfer("prImportInfractions.aspx", False)
        ElseIf tabMenu.ActiveTabIndex = 1 Then
            Server.Transfer("prImportPromotionHistory.aspx", False)
        End If
    End Sub

    Protected Sub checkuncheck_CheckedChanged(sender As Object, e As EventArgs) Handles checkuncheck.CheckedChanged
        If checkuncheck.Checked = True Then
            For i = 0 To lbCriteriaItems.Items.Count - 1
                lbCriteriaItems.Items(i).Selected = True
            Next
        Else
            For i = 0 To lbCriteriaItems.Items.Count - 1
                lbCriteriaItems.Items(i).Selected = False
            Next
        End If
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        Dim con As New SqlConnection(SQLString())
        Dim confirmValue As String = Request.Form("confirm_value")
        If confirmValue = "Yes" Then
            Try
                Dim cmd As New SqlCommand("delete from prCustomFilter where filtername=@name", con)
                cmd.Parameters.AddWithValue("@name", cbFilter.SelectedItem.ToString())
                con.Open()
                cmd.ExecuteNonQuery()
                displayMessage("Successfully deleted Filter " + cbFilter.SelectedItem.ToString() + " .")
            Catch ex As Exception
            Finally
                con.Close()
                fillFilters()
                clearitemsofnavbars()
            End Try

        End If


    End Sub
End Class