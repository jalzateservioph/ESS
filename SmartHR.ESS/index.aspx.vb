'spIndex.GetPaneByName('content_menu').Collapse(spIndex.GetPaneByName('content_main'));
Imports DevExpress.Web.ASPxTreeList
Imports System.IO

Partial Public Class index
    Inherits System.Web.UI.Page

    Private cpURL As String = String.Empty
    Private Param As String = String.Empty

    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function CalcBirthDate(ByVal dteBirthDate As Date) As Integer
     
        If (IsDate(dteBirthDate)) Then

            Dim yrs As Integer = Convert.ToInt32(DateDiff("m", dteBirthDate, Today) / 12)

            If (dteBirthDate.AddMonths(yrs * 12) > Today) Then yrs -= 1

            Return yrs

        Else

            Return 0

        End If

    End Function

    Private Function GetUrl(ByVal sender As Object, ByVal iRowIndex As Integer) As String

        Dim ReturnText As String = String.Empty

        Try

            With sender

                Dim CompanyNum As String = .GetRowValues(iRowIndex, "CompanyNum").ToString()
                Dim EmployeeNum As String = .GetRowValues(iRowIndex, "EmployeeNum").ToString()

                Session("NodeValue") = CompanyNum

                ReturnText = "employee.aspx?CompanyNum=" & CompanyNum & "&EmployeeNum=" & EmployeeNum

            End With

        Catch ex As Exception

        Finally

        End Try

        Return ReturnText

    End Function

    Private Sub LoadEmpData(ByVal CompanyNum As String, ByVal EmployeeNum As String)

        Dim objValues() As Object = Nothing

        Try

            objValues = GetSQLFields("select [FormLogo] from [Company] where ([CompanyNum] = '" & CompanyNum & "')")

            If (Not IsNull(objValues)) Then

                objValues(0) = GetThumbnail(objValues(0), 75, 75)

                If (Not IsNull(objValues(0))) Then

                    imgCompany.ContentBytes = objValues(0)

                Else

                    imgCompany.ContentBytes = Nothing

                End If

                objValues = Nothing

            End If

            objValues = GetSQLFields("select [EmployeePicture], [JobTitle], [DeptName], [BirthDate] from [Personnel] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

            If (Not IsNull(objValues)) Then

                objValues(0) = GetThumbnail(objValues(0), 75, 75)

                If (Not IsNull(objValues(0))) Then

                    imgPicture.ContentBytes = objValues(0)

                Else

                    imgPicture.ContentBytes = Nothing

                End If

                lblSummary_001.Text = cmbEmployee.Text

                Session("SelectedComp") = CompanyNum
                Session("SelectedEmp") = EmployeeNum

                If (GetArrayItem(Nothing, "eGeneral.ShowAge")) Then

                    If (Not IsNull(objValues(3))) Then

                        Dim yrs As Integer = CalcBirthDate(objValues(3))

                        If (yrs < 16 OrElse yrs > 59) Then

                            lblSummary_001.ForeColor = Drawing.Color.Red

                        Else

                            lblSummary_001.ForeColor = Drawing.Color.Black

                        End If

                        lblSummary_001.Text &= " (" & yrs.ToString() & ")"

                    End If

                End If

                If (Not IsNull(objValues(1))) Then lblSummary_002.Text = objValues(1).ToString()

                If (Not IsNull(objValues(2))) Then lblSummary_003.Text = objValues(2).ToString()

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(objValues)) Then objValues = Nothing

        End Try

    End Sub

    Private Sub SetTools(ByVal Template As String)

        tb_search.Visible = GetArrayItem(Template, "eGeneral.ShowSearch")

        tb_employee.Visible = GetArrayItem(Template, "eGeneral.ShowCreate")

        tb_contacts.Visible = GetArrayItem(Template, "eGeneral.ShowContacts")

        tb_delete.Visible = GetArrayItem(Template, "eGeneral.ShowDelete")

        tb_transfer.Visible = GetArrayItem(Template, "eGeneral.ShowTransfer")

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            tmrTimeout.Interval = (((Session.Timeout * 60) - 45) * 1000)

            Dim dtMenu As DataTable = Nothing

            Dim UserGroup As String = String.Empty

            Try

                If (Not IsNull(Session("LoggedOn"))) Then

                    If (cmbEmployee.Items.Count = 0) Then

                        With Session("LoggedOn")

                            UserGroup = GetUserGroup(.UserID, Session.SessionID)

                            If (Not IsNull(UserGroup)) Then

                                cmbEmployee.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                                cmbEmployee.DataBind()

                            End If

                            If (IsNull(cmbEmployee.Value)) Then

                                If (Not IsNull(cmbEmployee.Items.FindByValue(.CompanyNum & " " & .EmployeeNum))) Then

                                    cmbEmployee.Value = .CompanyNum & " " & .EmployeeNum

                                    LoadEmpData(.CompanyNum, .EmployeeNum)

                                ElseIf (cmbEmployee.Items.Count > 0) Then

                                    cmbEmployee.Value = cmbEmployee.Items(0).Value

                                    LoadEmpData(cmbEmployee.Value.ToString().Split(" ")(0), cmbEmployee.Value.ToString().Split(" ")(1))

                                End If

                                Session("Selected") = cmbEmployee.SelectedItem.Text

                                Session("Selected.Value") = cmbEmployee.Value

                            End If

                        End With

                        If (Not IsNull(cmbEmployee.Value) AndAlso Not IsNull(Session("Selected.Value"))) Then

                            If (Not Session("SetLoggedOn")) Then

                                Session("SetLoggedOn") = True

                                SetEmployeeData(Session, cmbEmployee.Value, False)

                                spIndex.GetPaneByName("title_right").ContentUrl = String.Empty

                                spIndex.GetPaneByName("content_main").ContentUrl = String.Empty

                            End If

                            SetEmployeeData(Session, Session("Selected.Value"))

                        End If

                        With Session("Managed")

                            lblCompanyName.Text = .CompanyName

                            lblDivision.Text = .Division

                            lblSubDivision.Text = .SubDivision

                            lblSubSubDivision.Text = .SubSubDivision

                            If (GetArrayItem(.Template, "eGeneral.AllowPicUpload")) Then

                                imgPicture.ClientSideEvents.Click = "function(s, e) { window.open('picture.aspx', 'myUpload', 'toolbar=no,location=yes,status=no,menubar=no,scrollbars=no,modal=yes,resizable=no,width=320,height=240'); }"

                                imgPicture.Cursor = "pointer"

                            Else

                                imgPicture.ClientSideEvents.Click = String.Empty

                                imgPicture.Cursor = "default"

                            End If

                        End With

                        dtMenu = GetSQLDT("select [ID], [OrderID], [ItemImage], [Description], [LoadURL], [TemplateElement], [LoggedOnUser], [HomeType], [HomeImage], [HomeDescription], [HomeTooltip] from [ess.Menu] where ([Visible] = 1) order by [OrderID]", "Data.Menu")

                        If (IsData(dtMenu)) Then

                            navMenu.Groups.Clear()

                            Dim SecElements As String = String.Empty

                            Dim pFile() As String = Nothing

                            Dim pFilename As String = String.Empty

                            Dim bView As Boolean

                            For iLoop As Integer = 0 To (dtMenu.Rows.Count - 1)

                                With dtMenu.Rows(iLoop)

                                    SecElements = GetSecurity(Session, .Item("TemplateElement").ToString())

                                    Boolean.TryParse(GetXML(SecElements, KeyName:="fView"), bView)

                                    If (bView OrElse .Item("LoadURL").ToString().ToLower() = "homepage.aspx") Then

                                        If (Not Regex.IsMatch(.Item("LoadURL").ToString(), "^https?://", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then

                                            pFile = .Item("LoadURL").ToString().Split("?")

                                            If (pFile(0) = "homepage.aspx" AndAlso Not GetArrayItem(Nothing, "eGeneral.Homepage")) Then

                                                pFile(0) = "tasks.aspx"

                                                bView = False

                                            ElseIf (pFile(0) = "homepage.aspx" AndAlso GetArrayItem(Nothing, "eGeneral.Homepage")) Then

                                                pFile(0) = "homepage.aspx"

                                                bView = True

                                            End If

                                            pFile(0) = Regex.Replace(Path.GetFileName(Server.MapPath(pFile(0))), EscapeRegex(".aspx") & "$+", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                            pFilename = pFile(0)

                                            pFile(0) &= ".aspx"

                                            If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & pFile(0))) Then

                                                If (pFile.GetLength(0) > 1) Then

                                                    pFilename &= ".aspx?" & pFile(1) & " tools/" & pFile(0)

                                                Else

                                                    pFilename &= Regex.Replace(" tools/" & pFile(0), "\.aspx", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                                End If

                                            Else

                                                If (pFile.GetLength(0) > 1) Then

                                                    pFilename &= ".aspx?" & pFile(1) & " tools/index.aspx"

                                                Else

                                                    pFilename &= " tools/index"

                                                End If

                                            End If

                                        Else

                                            pFilename = .Item("LoadURL").ToString()

                                            UDetails = GetUserDetails(Session, .Item("TemplateElement").ToString())

                                            While (Regex.IsMatch(pFilename, EscapeRegex("{") & ".*?" & EscapeRegex("}"), RegexOptions.Multiline Or RegexOptions.Singleline))

                                                pFilename = Regex.Replace(pFilename, "{CompanyNum}", UDetails.CompanyNum, RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                                                pFilename = Regex.Replace(pFilename, "{EmployeeNum}", UDetails.EmployeeNum, RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                                            End While

                                        End If

                                        If (bView) Then

                                            If (Not Regex.IsMatch(.Item("LoadURL").ToString(), "^https?://", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then

                                                navMenu.Groups.Add(.Item("Description"), pFilename, .Item("ItemImage"), .Item("LoadURL"), "contentUrlPane")

                                            Else

                                                navMenu.Groups.Add(.Item("Description"), pFilename & " tools/index.aspx", .Item("ItemImage"), pFilename, "contentUrlPane")

                                            End If

                                        End If

                                    End If

                                End With

                            Next

                            If (navMenu.Groups.Count > 0) Then

                                If (Not IsString(spIndex.GetPaneByName("title_right").ContentUrl)) Then

                                    If (Regex.IsMatch(navMenu.Groups(0).Name.Split(" ")(1), EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                        spIndex.GetPaneByName("title_right").ContentUrl = navMenu.Groups(0).Name.Split(" ")(1)

                                    Else

                                        spIndex.GetPaneByName("title_right").ContentUrl = navMenu.Groups(0).Name.Split(" ")(1) & ".aspx"

                                    End If

                                End If

                                If (Not IsString(spIndex.GetPaneByName("content_main").ContentUrl)) Then

                                    If (Regex.IsMatch(navMenu.Groups(0).NavigateUrl, EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                        spIndex.GetPaneByName("content_main").ContentUrl = navMenu.Groups(0).NavigateUrl

                                    Else

                                        spIndex.GetPaneByName("content_main").ContentUrl = navMenu.Groups(0).NavigateUrl & ".aspx"

                                    End If

                                End If

                            End If

                        End If

                    End If

                Else

                    ' amanriza 04/12/2019
                    ' added code redirects user if not login
                    If IsNothing(UDetails) Or IsEmpty(UDetails.UserID) Then

                        Response.Redirect("default.aspx", True)

                    End If
                    ' end

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(dtMenu)) Then

                    dtMenu.Dispose()

                    dtMenu = Nothing

                End If

            End Try

        ElseIf (Not IsNull(cmbEmployee.Value) AndAlso IsNull(imgPicture.ContentBytes)) Then

            LoadEmpData(cmbEmployee.Value.ToString().Split(" ")(0), cmbEmployee.Value.ToString().Split(" ")(1))

        End If

        If (tlvCompanies.Nodes.Count = 0) Then

            Dim iCount As Integer = 0

            Dim dtCompanies As DataTable = Nothing

            Try

                dtCompanies = GetSQLDT("select [CompanyNum], [CompanyName], [Division], [SubDivision], [SubSubDivision], 0 as [Count] from [Company] as [c] where ([HRModule] = 1) order by [CompanyNum]", "Company")

                If (IsData(dtCompanies)) Then

                    Dim node As TreeListNode = Nothing

                    Dim pNode As TreeListNode = Nothing

                    For i As Integer = 0 To (dtCompanies.Rows.Count - 1)

                        If (IsNull(tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("CompanyName")))) Then

                            node = tlvCompanies.AppendNode(dtCompanies.Rows(i).Item("CompanyName"))

                            node("Name") = dtCompanies.Rows(i).Item("CompanyName")

                            iCount = GetSQLField("select count([Division]) as [dCount] from [Company] where ([CompanyName] = '" & node("Name").ToString() & "' and not [Division] is null)", "dCount")

                            If (iCount <= 1) Then node("CompanyNum") = dtCompanies.Rows(i).Item("CompanyNum").ToString()

                        End If

                    Next

                    For i As Integer = 0 To (dtCompanies.Rows.Count - 1)

                        If (IsNull(tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("Division"))) AndAlso Not IsNull(dtCompanies.Rows(i).Item("Division"))) Then

                            node = tlvCompanies.AppendNode(dtCompanies.Rows(i).Item("Division"), tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("CompanyName")))

                            node("Name") = dtCompanies.Rows(i).Item("Division")

                            iCount = GetSQLField("select count([SubDivision]) as [dCount] from [Company] where ([Division] = '" & node("Name").ToString() & "' and not [SubDivision] is null)", "dCount")

                            If (iCount <= 1) Then node("CompanyNum") = dtCompanies.Rows(i).Item("CompanyNum").ToString()

                        End If

                    Next

                    For i As Integer = 0 To (dtCompanies.Rows.Count - 1)

                        If (IsNull(tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("SubDivision"))) AndAlso Not IsNull(dtCompanies.Rows(i).Item("Division")) AndAlso Not IsNull(dtCompanies.Rows(i).Item("SubDivision"))) Then

                            node = tlvCompanies.AppendNode(dtCompanies.Rows(i).Item("SubDivision"), tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("Division")))

                            node("Name") = dtCompanies.Rows(i).Item("SubDivision")

                            iCount = GetSQLField("select count([SubSubDivision]) as [dCount] from [Company] where ([SubDivision] = '" & node("Name").ToString() & "' and not [SubSubDivision] is null)", "dCount")

                            If (iCount <= 1) Then node("CompanyNum") = dtCompanies.Rows(i).Item("CompanyNum").ToString()

                        End If

                    Next

                    For i As Integer = 0 To (dtCompanies.Rows.Count - 1)

                        If (IsNull(tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("SubSubDivision"))) AndAlso Not IsNull(dtCompanies.Rows(i).Item("Division")) AndAlso Not IsNull(dtCompanies.Rows(i).Item("SubDivision")) AndAlso Not IsNull(dtCompanies.Rows(i).Item("SubSubDivision"))) Then

                            node = tlvCompanies.AppendNode(dtCompanies.Rows(i).Item("SubSubDivision"), tlvCompanies.FindNodeByFieldValue("Name", dtCompanies.Rows(i).Item("SubDivision")))

                            node("Name") = dtCompanies.Rows(i).Item("SubSubDivision")

                            node("CompanyNum") = dtCompanies.Rows(i).Item("CompanyNum").ToString()

                        End If

                    Next

                End If

            Catch ex As Exception
                WriteEventLog(ex.Message)
            Finally

                If (Not IsNull(dtCompanies)) Then

                    dtCompanies.Dispose()

                    dtCompanies = Nothing

                End If

            End Try

        End If

        dgSavedAppz.DataSource = GetSQLDT("select [CompanyNum] + ':' + [EmployeeNum] as [CompositeKey], [CompanyNum], [EmployeeNum], [TODateSaved], [Surname], [PreferredName] from [Personnel] where ([TOUsername] = '" & Session("LoggedOn").UserID & "')")

        GridFormat(dgSavedAppz, Session("LoggedOn").Template)

        dgSavedAppz.DataBind()

        SetTools(Session("Managed").Template)

    End Sub

    Private Sub cpImage_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpImage.Callback

        Dim objManage As Object = Session("Managed")

        If (IsNull(objManage)) Then objManage = Session("LoggedOn")

        LoadEmpData(objManage.CompanyNum, objManage.EmployeeNum)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        ClearSessionCache(Session.SessionID)

        e.Result = "default.aspx"

    End Sub

    Private Sub cpPanes_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpPanes.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Select Case Values(0)

            Case "load"
                ClearSessionCache(Session.SessionID)

                Session("Selected") = Values(3)

                Session("Selected.Value") = Values(1) & " " & Values(2)

                SetEmployeeData(Session, Values(1) & " " & Values(2))

                If (GetArrayItem(Session("Managed").Template, "eGeneral.AllowPicUpload")) Then

                    imgPicture.ClientSideEvents.Click = "function(s, e) { window.open('picture.aspx', 'myUpload', 'toolbar=no,location=yes,status=no,menubar=no,scrollbars=no,modal=yes,resizable=no,width=320,height=240'); }"

                    imgPicture.Cursor = "pointer"

                Else

                    imgPicture.ClientSideEvents.Click = String.Empty

                    imgPicture.Cursor = "default"

                End If

                LoadEmpData(Values(1), Values(2))

                Dim aGroup As String = Values(4)

                Dim aTools As String = String.Empty

                Dim dtMenu As DataTable = Nothing

                Dim UserGroup As String = String.Empty

                Try

                    dtMenu = GetSQLDT("select [ID], [OrderID], [ItemImage], [Description], [LoadURL], [TemplateElement], [LoggedOnUser], [HomeType], [HomeImage], [HomeDescription], [HomeTooltip] from [ess.Menu] where ([Visible] = 1) order by [OrderID]", "Data.Menu")

                    If (IsData(dtMenu)) Then

                        navMenu.Groups.Clear()

                        Dim GroupURL As String = String.Empty

                        Dim SecElements As String = String.Empty

                        Dim pFile As String = String.Empty

                        Dim pFilename As String = String.Empty

                        Dim bView As Boolean

                        For iLoop As Integer = 0 To (dtMenu.Rows.Count - 1)

                            With dtMenu.Rows(iLoop)

                                SecElements = GetSecurity(Session, .Item("TemplateElement").ToString())

                                Boolean.TryParse(GetXML(SecElements, KeyName:="fView"), bView)

                                If (bView OrElse .Item("LoadURL").ToString().ToLower() = "homepage.aspx") Then

                                    If (Not Regex.IsMatch(.Item("LoadURL").ToString(), "^https?://", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then

                                        pFile = Regex.Replace(Path.GetFileName(Server.MapPath(.Item("LoadURL").ToString())), EscapeRegex(".aspx") & "$+", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                        pFilename = pFile

                                        pFile &= ".aspx"

                                        If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & pFile)) Then

                                            pFilename &= Regex.Replace(" tools/" & pFile, "\.aspx", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                        Else

                                            pFilename &= " tools/index"

                                        End If

                                    Else

                                        pFilename = .Item("LoadURL").ToString()

                                        UDetails = GetUserDetails(Session, .Item("TemplateElement").ToString())

                                        While (Regex.IsMatch(pFilename, EscapeRegex("{") & ".*?" & EscapeRegex("}"), RegexOptions.Multiline Or RegexOptions.Singleline))

                                            pFilename = Regex.Replace(pFilename, "{CompanyNum}", UDetails.CompanyNum, RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                                            pFilename = Regex.Replace(pFilename, "{EmployeeNum}", UDetails.EmployeeNum, RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                                        End While

                                    End If

                                    If (Not Regex.IsMatch(.Item("LoadURL").ToString(), "^https?://", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then

                                        navMenu.Groups.Add(.Item("Description"), pFilename, .Item("ItemImage"), .Item("LoadURL"), "contentUrlPane")

                                        GroupURL &= "[" & .Item("LoadURL").ToString().ToLower() & "]"

                                    Else

                                        navMenu.Groups.Add(.Item("Description"), pFilename & " tools/index.aspx", .Item("ItemImage"), pFilename, "contentUrlPane")

                                        pFilename &= " tools/index.aspx"

                                        GroupURL &= "[" & pFilename.ToLower() & "]"

                                    End If

                                End If

                            End With

                        Next

                        If (navMenu.Groups.Count > 0) Then

                            Dim GroupValue As String = aGroup

                            If (Regex.IsMatch(aGroup, Regex.Escape("?"))) Then aGroup = Regex.Split(aGroup, Regex.Escape("?"))(0)

                            Dim cActiveGroup As String = aGroup

                            If (String.IsNullOrEmpty(spIndex.GetPaneByName("content_main").ContentUrl)) Then

                                aTools = navMenu.Groups(0).NavigateUrl

                            Else

                                If (Not GroupURL.Contains("[" & aGroup.ToLower() & "]")) Then aGroup = navMenu.Groups(0).NavigateUrl

                                aTools = aGroup

                            End If

                            aGroup = cActiveGroup

                            pFile = Regex.Replace(Path.GetFileName(Server.MapPath(aTools)), EscapeRegex(".aspx") & "$+", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                            pFilename = pFile

                            pFile &= ".aspx"

                            If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & pFile)) Then

                                aTools = "tools/" & pFile

                            Else

                                aTools = "tools/index"

                            End If

                            If (Not IsString(spIndex.GetPaneByName("title_right").ContentUrl)) Then

                                If (Regex.IsMatch(navMenu.Groups(0).Name.Split(" ")(1), EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                    spIndex.GetPaneByName("title_right").ContentUrl = navMenu.Groups(0).Name.Split(" ")(1)

                                Else

                                    spIndex.GetPaneByName("title_right").ContentUrl = navMenu.Groups(0).Name.Split(" ")(1) & ".aspx"

                                End If

                            Else

                                If (Regex.IsMatch(aTools, EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                    spIndex.GetPaneByName("title_right").ContentUrl = aTools

                                Else

                                    spIndex.GetPaneByName("title_right").ContentUrl = aTools & ".aspx"

                                End If

                            End If

                            If (Not IsString(spIndex.GetPaneByName("content_main").ContentUrl)) Then

                                If (Regex.IsMatch(navMenu.Groups(0).NavigateUrl, EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                    spIndex.GetPaneByName("content_main").ContentUrl = navMenu.Groups(0).NavigateUrl

                                Else

                                    spIndex.GetPaneByName("content_main").ContentUrl = navMenu.Groups(0).NavigateUrl & ".aspx"

                                End If

                            Else

                                If (Not GroupURL.Contains("[" & aGroup.ToLower() & "]")) Then

                                    If (Regex.IsMatch(navMenu.Groups(0).NavigateUrl, EscapeRegex(".aspx") & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                        aGroup = navMenu.Groups(0).NavigateUrl

                                    Else

                                        aGroup = navMenu.Groups(0).NavigateUrl & ".aspx"

                                    End If

                                ElseIf (Regex.IsMatch(GroupValue, Regex.Escape("?"))) Then

                                    aGroup = GroupValue

                                End If

                                spIndex.GetPaneByName("content_main").ContentUrl = aGroup

                            End If

                        End If

                    End If

                Catch ex As Exception
                    WriteEventLog(ex.Message)
                Finally

                    If (Not IsNull(dtMenu)) Then

                        dtMenu.Dispose()

                        dtMenu = Nothing

                    End If

                End Try

                SetTools(Session("Managed").Template)

            Case "signout"
                ClearSessionCache(Session.SessionID)

                Session.RemoveAll()

        End Select

        Param = Values(0)

    End Sub

    Private Sub cpPanes_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPanes.CustomJSProperties

        e.Properties("cpParam") = Param

    End Sub

    Private Sub dgSavedAppz_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgSavedAppz.CustomCallback

        cpURL = GetUrl(sender, Convert.ToInt32(e.Parameters)).Replace("""", "\""").Replace("'", "\'")

    End Sub

    Private Sub dgSavedAppz_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgSavedAppz.CustomJSProperties

        Dim cpToolURL As String = cpURL

        If (cpToolURL.ToLower().Contains(".aspx")) Then

            cpToolURL = cpToolURL.Substring(0, cpToolURL.IndexOf(".aspx"))

            cpToolURL &= ".aspx"

            If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & cpToolURL.Replace("/", "\"))) Then

                cpToolURL = "tools/" & cpToolURL

            Else

                cpToolURL = "tools/employee.aspx"

            End If

        Else

            cpToolURL = "tools/employee.aspx"

        End If

        e.Properties("cpURL") = cpURL

        e.Properties("cpToolURL") = cpToolURL

    End Sub

    Private Sub mnuProfile_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs) Handles mnuProfile.ItemClick

        Dim iIndex As Integer = Convert.ToInt32(e.Item.Name.Replace("mnuExp_", String.Empty))

        Dim objManage As Object = Session("Managed")

        If (IsNull(objManage)) Then objManage = Session("LoggedOn")

        If (Not IsNull(objManage)) Then

            ExecSQL("update [Personnel] set [OutOfficeStatus] = " & iIndex & " where ([CompanyNum] = '" & objManage.CompanyNum & "' and [EmployeeNum] = '" & objManage.EmployeeNum & "')")

            If (GetArrayItem(objManage.Template, "eGeneral.AllowPicUpload")) Then

                imgPicture.ClientSideEvents.Click = "function(s, e) { window.open('picture.aspx', 'myUpload', 'toolbar=no,location=yes,status=no,menubar=no,scrollbars=no,modal=yes,resizable=no,width=320,height=240'); }"

                imgPicture.Cursor = "pointer"

            Else

                imgPicture.ClientSideEvents.Click = String.Empty

                imgPicture.Cursor = "default"

            End If

            LoadEmpData(objManage.CompanyNum, objManage.EmployeeNum)

        End If

    End Sub

    Private Sub tlvCompanies_FocusedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tlvCompanies.FocusedNodeChanged

        If (Not IsNull(tlvCompanies.FocusedNode)) Then

            If (Not tlvCompanies.FocusedNode.HasChildren) Then Session("NodeValue") = tlvCompanies.FocusedNode.DataItem("CompanyNum").ToString()

        End If

    End Sub

#End Region

End Class