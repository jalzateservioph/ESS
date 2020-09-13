Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Public Class employee
    Inherits System.Web.UI.Page

    Private CompanyNum As String = String.Empty
    Private EmployeeNum As String = String.Empty
    Private PathID As String = String.Empty

    Private dPersonal As DataTable = Nothing

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing
    Private URL As String = String.Empty

#Region " *** Web Form Functions *** "

    Private Sub FillComboBox(ByVal cmb As DevExpress.Web.ASPxEditors.ASPxComboBox, ByVal ReportToCompNum As String)

        If (String.IsNullOrEmpty(ReportToCompNum)) Then Return

        LoadExpDS(dsReportToEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & GetDataText(ReportToCompNum) & "') order by [Name]")

        cmb.DataBind()

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        UDetails = GetUserDetails(Session, "Personal Tab")

        LoadExpDS(dsCategory, "select [Value], [Text] from [DocLinkCategoryLU] order by [Text]")

        LoadExpDS(dsEthnicGroup, "select [EthnicGroup] from [EthnicLU] order by [EthnicGroup]")

        LoadExpCmb(cmbEthnicGroup, "<select>")

        LoadExpDS(dsMaritalStatus, "select [MaritalStatus] from [MStatusLU] order by [MaritalStatus]")

        LoadExpCmb(cmbMaritalStatus, "<select>")

        LoadExpDS(dsNationality, "select [Nationality] from [NationalityLU] order by [Nationality]")

        LoadExpCmb(cmbNationality, "<select>")

        LoadExpDS(dsNoKRelationship, "select distinct [NoKRelationship] from [NextOfKin] order by [NoKRelationship]")

        LoadExpDS(dsRelationship, "select distinct [Sex] from [Dependants] order by [Sex]")

        LoadExpDS(dsTitle, "select distinct [Title] from [Personnel] order by [Title]")

        LoadExpCmb(cmbTitle, "<select>")

        LoadExpDS(dsSex, "select [Sex] from [SexLU] order by [Sex]")

        LoadExpCmb(cmbSex, "<select>")

        LoadExpDS(dsAppointype, "select [AppointmentType] from [AppointmentTypeLU] order by [AppointmentType]")

        LoadExpCmb(cmbAppointype, "<select>")

        LoadExpDS(dsSkill_Level, "select [OccupCategory] from [OccupCategoryLU] order by [OccupCategory]")

        LoadExpCmb(cmbSkill_Level, "<select>")

        LoadExpDS(dsPosition, "select [Position] from [PositionLU] order by [Position]")

        LoadExpCmb(cmbPosition, "<select>")

        LoadExpDS(dsCostCentre, "select [CostCentre] from [CostCentreLU] where ([CompanyNum] = '" & Session("NodeValue") & "') order by [CostCentre]")

        LoadExpCmb(cmbCostCentre, "<select>")

        LoadExpDS(dsDeptName, "select [DeptName] from [Department] where ([CompanyNum] = '" & Session("NodeValue") & "') order by [DeptName]")

        LoadExpCmb(cmbDeptName, "<select>")

        LoadExpDS(dsJobGrade, "select [JobGrade] from [JobGrade] where ([CompanyNum] = '" & Session("NodeValue") & "') order by [JobGrade]")

        LoadExpCmb(cmbJobGrade, "<select>")

        LoadExpDS(dsJobTitle, "select [JobTitle] from [JobTitle] where ([CompanyNum] = '" & Session("NodeValue") & "') order by [JobTitle]")

        LoadExpCmb(cmbJobTitle, "<select>")

        LoadExpDS(dsLocation, "select [Location] from [LocationLU] where ([CompanyNum] = '" & Session("NodeValue") & "') order by [Location]")

        LoadExpCmb(cmbLocation, "<select>")

        LoadExpDS(dsReportToCompNum, "select [CompanyName] + ' [' + [CompanyNum] + ']' as [CompanyName], [CompanyNum] from [Company] order by [CompanyName]")

        LoadExpDS(dsReportsToType, "select distinct [ReportsToType] from [ReportsTo] order by [ReportsToType]")

        If (Not IsPostBack) Then

            ClearFromCache("Data.Organizational.ReportsTo.TORoles." & Session.SessionID)

            If (Not dteBirthDate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                dteBirthDate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
                dteBirthDate.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

            End If

            If (Not dteAppointdate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                dteAppointdate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
                dteAppointdate.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

            End If

            If (Not dteDateJoinedGroup.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                dteDateJoinedGroup.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
                dteDateJoinedGroup.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

            End If

            Dim dtAutoNumber As DataTable = Nothing

            Try

                For i As Integer = 0 To 1

                    If (i = 0) Then

                        dtAutoNumber = GetSQLDT("select [EnableAutoNumbers], [Prefix], [Suffix], [NextNumber], [Length] from [Company] where ([CompanyNum] = '" & Session("NodeValue") & "')")

                    Else

                        dtAutoNumber = GetSQLDT("select [GlobalAutoEmplNumbers] as [EnableAutoNumbers], [Prefix], [Suffix], [NextNumber], [Length] from [Various]")

                    End If

                    If (IsData(dtAutoNumber)) Then

                        If (dtAutoNumber.Rows(0).Item("EnableAutoNumbers")) Then

                            txtEmployeeNum.Enabled = False

                            txtEmployeeNum.Text = "<calculated>"

                        End If

                    End If

                    If (Not IsNull(dtAutoNumber)) Then

                        dtAutoNumber.Dispose()

                        dtAutoNumber = Nothing

                    End If

                Next

            Catch ex As Exception

            Finally

                If (Not IsNull(dtAutoNumber)) Then

                    dtAutoNumber.Dispose()

                    dtAutoNumber = Nothing

                End If

            End Try

            SetEmployeeData(Session, Session("Selected.Value"))

            If (IsString(CompanyNum) AndAlso IsString(EmployeeNum)) Then

                If (ClearCache OrElse Not IsPostBack) Then ClearFromCache("Data.Personal.Creation." & Session.SessionID)

                dPersonal = GetSQLDT("select [Title], [PreferredName], [FirstName], [MiddleName], [Surname], [IDNum], [Sex], [Nationality], [BirthDate], [EthnicGroup], [MaritialStatus], [AddrUnit], [AddrComplex], [AddrStreetNo], [AddrStreetName], [AddrSuburb], [AddrCity], [AddrZip], [POBox], [POArea], [POCode], [CellTel], [HomeTel], [EMailAddress], [EMailAddress1], [JobTitle], [JobGrade], [CostCentre], [DeptName], [Skill_Level], [Appointype], [emp1].[Position], [emp1].[Location], [DateJoinedGroup], [Appointdate] from [Personnel] as [emp] left outer join [Personnel1] as [emp1] on [emp].[CompanyNum] = [emp1].[CompanyNum] and [emp].[EmployeeNum] = [emp1].[EmployeeNum] where ([emp].[CompanyNum] = '" & CompanyNum & "' and [emp].[EmployeeNum] = '" & EmployeeNum & "')", "Data.Personal.Creation." & Session.SessionID)

                If (IsData(dPersonal)) Then

                    txtEmployeeNum.Enabled = False

                    With dPersonal.Rows(0)

                        txtEmployeeNum.Text = EmployeeNum

                        txtPreferredName.Text = .Item("PreferredName").ToString()
                        txtFirstName.Text = .Item("FirstName").ToString()
                        txtOtherNames.Text = .Item("MiddleName").ToString()

                        cmbTitle.Value = .Item("Title").ToString()

                        txtFirstName.Text = .Item("FirstName").ToString()
                        txtSurname.Text = .Item("Surname").ToString()
                        txtIDNum.Text = .Item("IDNum").ToString()

                        cmbSex.Value = .Item("Sex").ToString()

                        cmbNationality.Value = .Item("Nationality").ToString()

                        If (Not IsNull(.Item("BirthDate"))) Then dteBirthDate.Value = .Item("BirthDate")

                        cmbEthnicGroup.Value = .Item("EthnicGroup").ToString()
                        cmbMaritalStatus.Value = .Item("MaritialStatus").ToString()

                        txtSARSAddress1.Text = .Item("AddrUnit").ToString()
                        txtSARSAddress2.Text = .Item("AddrComplex").ToString()
                        txtSARSAddress3.Text = .Item("AddrStreetNo").ToString()
                        txtSARSAddress4.Text = .Item("AddrStreetName").ToString()
                        txtSARSAddress5.Text = .Item("AddrSuburb").ToString()
                        txtSARSAddress6.Text = .Item("AddrCity").ToString()
                        txtSARSAddress7.Text = .Item("AddrZip").ToString()
                        txtPOBox.Text = .Item("POBox").ToString()
                        txtPOArea.Text = .Item("POArea").ToString()
                        txtPOCode.Text = .Item("POCode").ToString()
                        txtCellTel.Text = .Item("CellTel").ToString()
                        txtHomeTel.Text = .Item("HomeTel").ToString()
                        txtEmailAddress.Text = .Item("EMailAddress").ToString()
                        txtEmailAddress1.Text = .Item("EMailAddress1").ToString()

                        cmbJobTitle.Value = .Item("JobTitle").ToString()
                        cmbJobGrade.Value = .Item("JobGrade").ToString()
                        cmbCostCentre.Value = .Item("CostCentre").ToString()
                        cmbDeptName.Value = .Item("DeptName").ToString()
                        cmbSkill_Level.Value = .Item("Skill_Level").ToString()
                        cmbAppointype.Value = .Item("Appointype").ToString()
                        cmbPosition.Value = .Item("Position").ToString()
                        cmbLocation.Value = .Item("Location").ToString()

                        If (Not IsNull(.Item("DateJoinedGroup"))) Then dteDateJoinedGroup.Value = .Item("DateJoinedGroup")

                        If (Not IsNull(.Item("Appointdate"))) Then dteAppointdate.Value = .Item("Appointdate")

                    End With

                End If

            End If

        End If

        Select Case tabEmployee.ActiveTabIndex

            Case 0
                If (txtEmployeeNum.Enabled) Then

                    txtEmployeeNum.Focus()

                Else

                    txtPreferredName.Focus()

                End If

            Case 1
                If (IsString(CompanyNum) AndAlso IsString(EmployeeNum)) Then

                    If (ClearCache) Then ClearFromCache("Data.Organizational.ReportsTo.TORoles." & Session.SessionID)

                    LoadExpGrid(Session, dgView_002, "Organisational Tab", "<Tablename=ReportsTo><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ReportToCompNum] + ' ' + [ReportToEmpNum] + ' ' + [ReportsToType]><Columns=[CompanyNum], [EmployeeNum], [ReportToCompNum], [ReportToEmpNum], (select (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = [ReportToCompNum] + ':' + [ReportToEmpNum])) as [Employee], [ReportsToType]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')>", "Data.Organizational.ReportsTo.TORoles." & Session.SessionID)

                End If

            Case 2
                If (IsString(CompanyNum) AndAlso IsString(EmployeeNum)) Then

                    If (ClearCache) Then ClearFromCache("Data.LinkedDocs.TODocuments." & Session.SessionID)

                    LoadExpGrid(Session, dgView, "Linked Documents", "<Tablename=PersonnelDocLink><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [DocPath] + ' ' + [Category]><Columns=[Category], [DocDescription], [DocPath], [ESSLinked], [ESSPath], [UserLinked], [DateLinked]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [ESSLinked] = 1)>", "Data.LinkedDocs.TODocuments." & Session.SessionID)

                End If

        End Select

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsNull(Request.QueryString("CompanyNum"))) Then CompanyNum = Request.QueryString("CompanyNum")

        If (Not IsNull(Request.QueryString("EmployeeNum"))) Then EmployeeNum = Request.QueryString("EmployeeNum")

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID")

        LoadData()

    End Sub

    Protected Sub cmbEmployee_OnCallback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)

        FillComboBox(TryCast(source, DevExpress.Web.ASPxEditors.ASPxComboBox), e.Parameter)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        e.Result = Values(0) & " "

        Select Case Values(0)

            Case "Back"
                e.Result &= tabEmployee.ActiveTabIndex - 1

            Case "Next"
                e.Result &= tabEmployee.ActiveTabIndex + 1

            Case "Save", "Submit"
                Dim SavedEmployeeNum As String = String.Empty

                Dim NextNum As String = String.Empty

                Dim dtAutoNumber As DataTable = Nothing

                Dim docUpload As ASPxUploadControl = Nothing

                Dim DocPath As String = String.Empty

                Try

                    If (IsString(EmployeeNum)) Then

                        SavedEmployeeNum = EmployeeNum

                    Else

                        If (Not txtEmployeeNum.Text = "<calculated>") Then

                            SavedEmployeeNum = txtEmployeeNum.Text

                        Else

                            For i As Integer = 0 To 1

                                If (i = 0) Then

                                    dtAutoNumber = GetSQLDT("select [EnableAutoNumbers], [Prefix], [Suffix], [NextNumber], [Length] from [Company] where ([CompanyNum] = '" & Session("NodeValue") & "')")

                                Else

                                    dtAutoNumber = GetSQLDT("select [GlobalAutoEmplNumbers] as [EnableAutoNumbers], [Prefix], [Suffix], [NextNumber], [Length] from [Various]")

                                End If

                                If (IsData(dtAutoNumber)) Then

                                    If (dtAutoNumber.Rows(0).Item("EnableAutoNumbers")) Then

                                        SavedEmployeeNum = dtAutoNumber.Rows(0).Item("Prefix").ToString()

                                        If (IsNull(dtAutoNumber.Rows(0).Item("NextNumber"))) Then

                                            e.Result &= "error The next sequential number in the employee auto numbering setup, is not correctly configured"

                                        Else

                                            NextNum = dtAutoNumber.Rows(0).Item("NextNumber").ToString().Trim()

                                        End If

                                        If (Not IsNull(dtAutoNumber.Rows(0).Item("Length"))) Then

                                            If (dtAutoNumber.Rows(0).Item("Length") > 0) Then

                                                If (dtAutoNumber.Rows(0).Item("Length") - NextNum.Length > 0) Then NextNum = InsertText(NextNum, "0", dtAutoNumber.Rows(0).Item("Length") - NextNum.Length)

                                            End If

                                        End If

                                        SavedEmployeeNum &= NextNum & dtAutoNumber.Rows(0).Item("Suffix").ToString()

                                        If (Not IsNull(dtAutoNumber.Rows(0).Item("NextNumber"))) Then

                                            If (IsString(NextNum)) Then

                                                If (i = 0) Then

                                                    ExecSQL("update [Company] set [NextNumber] = " & Convert.ToString(Convert.ToInt32(NextNum) + 1) & " where ([CompanyNum] = '')")

                                                Else

                                                    ExecSQL("update [Various] set [NextNumber] = " & Convert.ToString(Convert.ToInt32(NextNum) + 1) & " where ([CompanyNum] = '')")

                                                End If

                                            End If

                                        End If

                                    End If

                                End If

                                If (Not IsNull(dtAutoNumber)) Then

                                    dtAutoNumber.Dispose()

                                    dtAutoNumber = Nothing

                                End If

                            Next

                        End If

                    End If

                    If (SavedEmployeeNum.Length > 0) Then

                        Dim SQL As String = String.Empty

                        Dim bSaved As Boolean

                        If (IsString(CompanyNum) AndAlso IsString(EmployeeNum)) Then

                            SQL = "update [Personnel] set [Title] = " & GetNullText(cmbTitle.Value) & ", [PreferredName] = " & GetNullText(txtPreferredName.Text) & ", [FirstName] = " & GetNullText(txtFirstName.Text) & ", [MiddleName] = " & GetNullText(txtOtherNames.Text) & ", [Surname] = " & GetNullText(txtSurname.Text) & ", [IDNum] = " & GetNullText(txtIDNum.Text) & ", [Sex] = " & GetNullText(cmbSex.Value) & ", [Nationality] = " & GetNullText(cmbNationality.Value) & ", [BirthDate] = " & GetNullDate(dteBirthDate.Date) & ", [EthnicGroup] = " & GetNullText(cmbEthnicGroup.Value) & ", [MaritialStatus] = " & GetNullText(cmbMaritalStatus.Value) & ", [AddrUnit] = " & GetNullText(txtSARSAddress1.Text) & ", [AddrComplex] = " & GetNullText(txtSARSAddress2.Text) & ", [AddrStreetNo] = " & GetNullText(txtSARSAddress3.Text) & ", [AddrStreetName] = " & GetNullText(txtSARSAddress4.Text) & ", [AddrSuburb] = " & GetNullText(txtSARSAddress5.Text) & ", [AddrCity] = " & GetNullText(txtSARSAddress6.Text) & ", [AddrZip] = " & GetNullText(txtSARSAddress7.Text) & ", [POBox] = " & GetNullText(txtPOBox.Text) & ", [POArea] = " & GetNullText(txtPOArea.Text) & ", [POCode] = " & GetNullText(txtPOCode.Text) & ", [Address2] = " & GetNullText(txtSARSAddress5.Text) & ", [Address3] = " & GetNullText(txtSARSAddress6.Text) & ", [Address4] = " & GetNullText(txtSARSAddress7.Text) & ", [CellTel] = " & GetNullText(txtCellTel.Text) & ", [EMailAddress] = " & GetNullText(txtEmailAddress.Text) & ", [HomeTel] = " & GetNullText(txtHomeTel.Text) & ", [EMailAddress1] = " & GetNullText(txtEmailAddress1.Text) & ", [JobTitle] = " & GetNullText(cmbJobTitle.Value).Replace("null", "'-'") & ", [CostCentre] = " & GetNullText(cmbCostCentre.Value).Replace("null", "'-'") & ", [Skill_Level] = " & GetNullText(cmbSkill_Level.Value) & ", [DateJoinedGroup] = " & GetNullDate(dteDateJoinedGroup.Date) & ", [JobGrade] = " & GetNullText(cmbJobGrade.Value).Replace("null", "'-'") & ", [DeptName] = " & GetNullText(cmbDeptName.Value).Replace("null", "'-'") & ", [Appointype] = " & GetNullText(cmbAppointype.Value) & ", [Appointdate] = " & GetNullDate(dteAppointdate.Date) & ", [Status] = 'New' where ([CompanyNum] = '" & Session("NodeValue") & "' and [EmployeeNum] = '" & SavedEmployeeNum.Replace("'", String.Empty) & "')"

                            bSaved = ExecSQL(SQL)

                            SQL = "update [Personnel1] set [Position] = " & GetNullText(cmbPosition.Value) & ", [Location] = " & GetNullText(cmbLocation.Value).Replace("null", "'-'") & " where ([CompanyNum] = '" & Session("NodeValue") & "' and [EmployeeNum] = '" & SavedEmployeeNum.Replace("'", String.Empty) & "')"

                            If (bSaved) Then bSaved = ExecSQL(SQL)

                        Else

                            SQL = "insert into [Personnel]([CompanyNum], [EmployeeNum], [Title], [PreferredName], [FirstName], [MiddleName], [Surname], [IDNum], [Sex], [Nationality], [BirthDate], [EthnicGroup], [MaritialStatus], [AddrUnit], [AddrComplex], [AddrStreetNo], [AddrStreetName], [AddrSuburb], [AddrCity], [AddrZip], [POBox], [POArea], [POCode], [Address2], [Address3], [Address4], [CellTel], [EMailAddress], [HomeTel], [EMailAddress1], [Recruit], [RecruitStatus], [JobTitle], [CostCentre], [Skill_Level], [DateJoinedGroup], [JobGrade], [DeptName], [Appointype], [Appointdate], [Status]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', " & GetNullText(cmbTitle.Value) & ", " & GetNullText(txtPreferredName.Text) & ", " & GetNullText(txtFirstName.Text) & ", " & GetNullText(txtOtherNames.Text) & ", " & GetNullText(txtSurname.Text) & ", " & GetNullText(txtIDNum.Text) & ", " & GetNullText(cmbSex.Value) & ", " & GetNullText(cmbNationality.Value) & ", " & GetNullDate(dteBirthDate.Date) & ", " & GetNullText(cmbEthnicGroup.Value) & ", " & GetNullText(cmbMaritalStatus.Value) & ", " & GetNullText(txtSARSAddress1.Text) & ", " & GetNullText(txtSARSAddress2.Text) & ", " & GetNullText(txtSARSAddress3.Text) & ", " & GetNullText(txtSARSAddress4.Text) & ", " & GetNullText(txtSARSAddress5.Text) & ", " & GetNullText(txtSARSAddress6.Text) & ", " & GetNullText(txtSARSAddress7.Text) & ", " & GetNullText(txtPOBox.Text) & ", " & GetNullText(txtPOArea.Text) & ", " & GetNullText(txtPOCode.Text) & ", " & GetNullText(txtSARSAddress5.Text) & ", " & GetNullText(txtSARSAddress6.Text) & ", " & GetNullText(txtSARSAddress7.Text) & ", " & GetNullText(txtCellTel.Text) & ", " & GetNullText(txtEmailAddress.Text) & ", " & GetNullText(txtHomeTel.Text) & ", " & GetNullText(txtEmailAddress1.Text) & ", 2, 'S', " & GetNullText(cmbJobTitle.Value).Replace("null", "'-'") & ", " & GetNullText(cmbCostCentre.Value).Replace("null", "'-'") & ", " & GetNullText(cmbSkill_Level.Value) & ", " & GetNullDate(dteDateJoinedGroup.Date) & ", " & GetNullText(cmbJobGrade.Value).Replace("null", "'-'") & ", " & GetNullText(cmbDeptName.Value).Replace("null", "'-'") & ", " & GetNullText(cmbAppointype.Value) & ", " & GetNullDate(dteAppointdate.Date) & ", 'New')"

                            bSaved = ExecSQL(SQL)

                            SQL = "insert into [CompEmp]([CompanyNum], [EmployeeNum]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "')"

                            If (bSaved) Then bSaved = ExecSQL(SQL)

                            SQL = "insert into [Personnel1]([CompanyNum], [EmployeeNum], [Position], [Location]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', " & GetNullText(cmbPosition.Value) & ", " & GetNullText(cmbLocation.Value) & ")"

                            If (bSaved) Then bSaved = ExecSQL(SQL)

                        End If

                        docUpload = Session("UploadedFile.upDoc_001")

                        If (bSaved AndAlso Not IsNull(docUpload)) Then

                            If (docUpload.UploadedFiles(0).IsValid) Then

                                DocPath = GetFileData(Me, docUpload.UploadedFiles(0), "documents/linked")

                                SQL = "insert into [PersonnelDocLink]([CompanyNum], [EmployeeNum], [DocPath], [Category], [DocDescription], [DateLinked], [UserLinked], [ESSLinked], [ESSPath]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', 'Organisat', '" & GetDataText(Path.GetFileNameWithoutExtension(GetXML(DocPath, KeyName:="UNCPath"))) & "', " & GetNullDate(dteAppointdate.Date) & ", '" & Session("LoggedOn").UserID & "', 1, '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "')"

                                bSaved = ExecSQL(SQL)

                                If (bSaved) Then

                                    docUpload.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                                    Session.Remove("UploadedFile.upDoc_001")

                                End If

                            End If

                            docUpload = Nothing

                        End If

                        docUpload = Session("UploadedFile.upDoc_002")

                        If (bSaved AndAlso Not IsNull(docUpload)) Then

                            If (docUpload.UploadedFiles(0).IsValid) Then

                                DocPath = GetFileData(Me, docUpload.UploadedFiles(0), "documents/linked")

                                SQL = "insert into [PersonnelDocLink]([CompanyNum], [EmployeeNum], [DocPath], [Category], [DocDescription], [DateLinked], [UserLinked], [ESSLinked], [ESSPath]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', 'Organisat', '" & GetDataText(Path.GetFileNameWithoutExtension(GetXML(DocPath, KeyName:="UNCPath"))) & "', " & GetNullDate(dteAppointdate.Date) & ", '" & Session("LoggedOn").UserID & "', 1, '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "')"

                                bSaved = ExecSQL(SQL)

                                If (bSaved) Then

                                    docUpload.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                                    Session.Remove("UploadedFile.upDoc_002")

                                End If

                            End If

                            docUpload = Nothing

                        End If

                        docUpload = Session("UploadedFile.upDoc_003")

                        If (bSaved AndAlso Not IsNull(docUpload)) Then

                            If (docUpload.UploadedFiles(0).IsValid) Then

                                DocPath = GetFileData(Me, docUpload.UploadedFiles(0), "documents/linked")

                                SQL = "insert into [PersonnelDocLink]([CompanyNum], [EmployeeNum], [DocPath], [Category], [DocDescription], [DateLinked], [UserLinked], [ESSLinked], [ESSPath]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', 'CV', '" & GetDataText(Path.GetFileNameWithoutExtension(GetXML(DocPath, KeyName:="UNCPath"))) & "', " & GetNullDate(dteAppointdate.Date) & ", '" & Session("LoggedOn").UserID & "', 1, '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "')"

                                bSaved = ExecSQL(SQL)

                                If (bSaved) Then

                                    docUpload.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                                    Session.Remove("UploadedFile.upDoc_003")

                                End If

                            End If

                            docUpload = Nothing

                        End If

                        docUpload = Session("UploadedFile.upDoc_004")

                        If (bSaved AndAlso Not IsNull(docUpload)) Then

                            If (docUpload.UploadedFiles(0).IsValid) Then

                                DocPath = GetFileData(Me, docUpload.UploadedFiles(0), "documents/linked")

                                SQL = "insert into [PersonnelDocLink]([CompanyNum], [EmployeeNum], [DocPath], [Category], [DocDescription], [DateLinked], [UserLinked], [ESSLinked], [ESSPath]) values('" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', '" & GetDataText(GetXML(DocPath, KeyName:="UNCPath")) & "', 'CV', '" & GetDataText(Path.GetFileNameWithoutExtension(GetXML(DocPath, KeyName:="UNCPath"))) & "', " & GetNullDate(dteAppointdate.Date) & ", '" & Session("LoggedOn").UserID & "', 1, '" & GetDataText(GetXML(DocPath, KeyName:="VirtualPath")) & "')"

                                bSaved = ExecSQL(SQL)

                                If (bSaved) Then

                                    docUpload.UploadedFiles(0).SaveAs(GetXML(DocPath, KeyName:="FilePath"))

                                    Session.Remove("UploadedFile.upDoc_004")

                                End If

                            End If

                            docUpload = Nothing

                        End If

                        If (Values(0) = "Save") Then

                            If (Not IsString(CompanyNum)) Then CompanyNum = Session("NodeValue")

                            If (Not IsString(EmployeeNum)) Then EmployeeNum = SavedEmployeeNum

                            bSaved = ExecSQL("update [Personnel] set [TODateSaved] = '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', [TOUsername] = '" & Session("LoggedOn").UserID & "' where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

                            URL = "employee.aspx?CompanyNum=" & CompanyNum & "&EmployeeNum=" & EmployeeNum & " tools/employee.aspx"

                        Else

                            If (Not IsString(PathID)) Then

                                SQL = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Session("NodeValue") & "', '" & SavedEmployeeNum.Replace("'", String.Empty) & "', 0, 'Onboarding', 'Onboarding', 'Start', 'Start', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'"

                            Else

                                Dim PathData As String = GetPathData(PathID)

                                SQL = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', " & PathID & ", 'Onboarding', 'Onboarding', '" & Values(1) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'"

                            End If

                            If (bSaved) Then bSaved = ExecSQL(SQL)

                            URL = "tasks.aspx tools/index.aspx"

                        End If

                        If (bSaved) Then

                            e.Result &= SUCCESS

                        Else

                            e.Result &= "error " & SQL

                        End If

                    End If

                Catch ex As Exception

                Finally

                    If (Not IsNull(dtAutoNumber)) Then

                        dtAutoNumber.Dispose()

                        dtAutoNumber = Nothing

                    End If

                End Try

        End Select

    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpURL") = URL

    End Sub

    Private Sub dgView_002_CellEditorInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs) Handles dgView_002.CellEditorInitialize

        If (Not sender.IsEditing OrElse Not e.Column.FieldName = "ReportToEmpNum") Then Return

        Dim combo As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (sender.IsEditing AndAlso Not sender.IsNewRowEditing) Then

            If (IsNull(e.KeyValue)) Then Return

            Dim val As String = sender.GetRowValuesByKeyValue(e.KeyValue, "ReportToCompNum")

            If (val Is DBNull.Value) Then Return

            FillComboBox(combo, val)

            'If (IsNumeric(combo.Value)) Then

            Session("orgEmployeeNum") = combo.Value

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        ElseIf (sender.IsEditing AndAlso sender.IsNewRowEditing) Then

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        End If

    End Sub

    Private Sub dgView_002_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_002.CustomColumnDisplayText

        If (e.Column.FieldName = "ReportToEmpNum") Then e.DisplayText = e.GetFieldValue("Employee")

    End Sub

    Private Sub dgView_002_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_002.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_002_HeaderFilterFillItems(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewHeaderFilterEventArgs) Handles dgView_002.HeaderFilterFillItems

        If (e.Column.FieldName = "ReportToEmpNum") Then

            Dim i As Integer = (e.Values.Count - 1)

            While (i > -1)

                If (e.Values(i).IsShowAllFilter OrElse e.Values(i).IsFilterByQuery) Then

                    Exit While

                Else

                    e.Values.RemoveAt(i)

                    i -= 1

                End If

            End While

            Dim xValues As String = String.Empty

            Dim arValues As ArrayList = Nothing

            arValues = New ArrayList()

            For i = 0 To (sender.VisibleRowCount - 1)

                If (Not xValues.Contains("[" & sender.GetRowValues(i, "ReportToEmpNum") & "]")) Then

                    xValues &= "[" & sender.GetRowValues(i, "ReportToEmpNum") & "]"

                    arValues.Add(sender.GetRowValues(i, "Employee") & ";" & sender.GetRowValues(i, "ReportToEmpNum"))

                End If

            Next

            arValues.Sort()

            For i = 0 To (arValues.Count - 1)

                e.Values.Add(New FilterValue(arValues(i).ToString().Split(";")(0), arValues(i).ToString().Split(";")(1), ""))

            Next

        End If

    End Sub

    Private Sub dgView_002_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_002.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_002_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_002.RowInserting

        Dim SQLAudit As String = String.Empty

        With UDetails

            e.NewValues("CompanyNum") = CompanyNum

            e.NewValues("EmployeeNum") = EmployeeNum

        End With

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_002_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_002.RowUpdating

        Dim SQLAudit As String = String.Empty

        e.NewValues("ReportToEmpNum") = Session("orgEmployeeNum")

        Session.Remove("orgEmployeeNum")

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_002_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_002.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Private Sub dgView_002_StartRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs) Handles dgView_002.StartRowEditing

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then LoadExpDS(dsReportToEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & sender.GetRowValuesByKeyValue(e.EditingKeyValue, "ReportToCompNum").ToString() & "') order by [Name]")

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            If (Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Length > 0) Then

                ReturnText = "the file could not be located"

            Else

                ReturnText = "no file attached"

            End If

        End If

        Return ReturnText

    End Function

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabEmployee.TabPages(tabEmployee.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabEmployee.TabPages(tabEmployee.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

                Select Case e.Item.Name

                    Case "mnuExp_CSV"
                        dgExports.WriteCsvToResponse(xFilePath)

                    Case "mnuExp_XLS"
                        dgExports.WriteXlsToResponse(xFilePath)

                    Case "mnuExp_XLSX"
                        dgExports.WriteXlsxToResponse(xFilePath)

                    Case "mnuExp_RTF"
                        dgExports.WriteRtfToResponse(xFilePath)

                    Case "mnuExp_PDF"
                        dgExports.WritePdfToResponse(xFilePath)

                End Select

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dgExports)) Then

                dgExports.Dispose()

                dgExports = Nothing

            End If

        End Try

    End Sub

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile." & sender.ID) = sender

    End Sub

#End Region

End Class