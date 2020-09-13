Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class learn
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        Dim UserGroup As String = String.Empty

        If (Not IsNull(Session("LoggedOn"))) Then

            UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

            If (Not IsNull(UserGroup)) Then

                With UDetails

                    Select Case tabLearning.ActiveTabIndex

                        Case 0
                            If (ClearCache) Then ClearFromCache("Data.Learning." & Session.SessionID)

                            LoadExpDS(dsCategory, "select [CourseCategory] from [CourseCategoryLU] order by [CourseCategory]")

                            LoadExpDS(dsCourse, "select distinct [CourseName] from [CourseLU] order by [CourseName]")

                            LoadExpDS(dsProvider, "select [ProviderName] from [TrainingProviderLU] order by [ProviderName]")

                            LoadExpDS(dsSkills, "select distinct [SkillsPriority] from [CourseSkillsPriorityLU] order by [SkillsPriority]")

                            LoadExpDS(dsTraining, "select distinct [TrainingPriority] from [CourseTrainingPriorityLU] order by [TrainingPriority]")

                            LoadExpGrid(Session, dgView_001, "Learning Needs", "<Tablename=ess.LearningNeeds><PrimaryKey=[Username] + ' ' + [CompanyNum] + ' ' + [EmployeeNum] + ' ' + [CourseName] + ' ' + [ProviderName] + ' ' + convert(nvarchar(19), [StartDate], 120)><InsertKey='" & .UserID & "', '" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[CourseName], [ProviderName], [StartDate], [CompletionDate], [DirectCost], [CourseCategory], [InternalCourse], [IndividualPriority], [DepartmentalPriority]><Where=([Username] = '" & .UserID & "' and [CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Learning." & Session.SessionID)

                        Case 1
                            dgView_002.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                            dgView_002.DataBind()

                    End Select

                End With

            End If

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Learning Needs")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim bSaved As Boolean = True

            With UDetails

                Dim objValues() As Object = Nothing

                Dim CourseName As String = String.Empty

                Dim ProviderName As String = String.Empty

                Dim CompletionDate As String = String.Empty

                For iLoop As Integer = 0 To (dgView_001.VisibleRowCount - 1)

                    objValues = dgView_001.GetRowValues(iLoop, "CourseName", "ProviderName", "DirectCost", "CourseCategory", "InternalCourse", "TrainingPriority", "SkillsPriority", "StartDate", "CompletionDate")

                    If (Not IsNull(objValues)) Then

                        If (Not IsData(GetSQLDT("select [ProviderName] from [TrainingProviderLU] where ([ProviderName] = '" & GetDataText(objValues(1)) & "')"))) Then bSaved = ExecSQL("insert into [TrainingProviderLU]([ProviderName]) values('" & GetDataText(objValues(1)) & "')")

                        If (bSaved) Then

                            If (IsData(GetSQLDT("select [CourseName] from [CourseLU] where ([CourseName] = '" & GetDataText(objValues(0)) & "' and [ProviderName] = '" & GetDataText(objValues(1)) & "')"))) Then

                                bSaved = ExecSQL("update [CourseLU] set [DirectCost] = " & GetNullText(objValues(2)) & ", [CourseCategory] = " & GetNullText(objValues(3)) & ", [InternalCourse] = " & GetBitData(objValues(4)) & ", [TrainingPriority] = " & GetNullText(objValues(5)) & ", [SkillsPriority] = " & GetNullText(objValues(6)) & " where ([CourseName] = '" & GetDataText(objValues(0)) & "' and [ProviderName] = '" & GetDataText(objValues(1)) & "')")

                            Else

                                bSaved = ExecSQL("insert into [CourseLU]([CourseName], [ProviderName], [DirectCost], [CourseCategory], [InternalCourse], [TrainingPriority], [SkillsPriority]) values('" & GetDataText(objValues(0)) & "', '" & GetDataText(objValues(1)) & "', " & GetNullText(objValues(2)) & ", " & GetNullText(objValues(3)) & ", " & GetBitData(objValues(4)) & ", " & GetNullText(objValues(5)) & ", " & GetNullText(objValues(6)) & ")")

                            End If

                            If (bSaved) Then

                                For Each objKey As Object In dgView_002.GetSelectedFieldValues("Value")

                                    CompletionDate = "null"

                                    If (IsDate(objValues(8))) Then CompletionDate = "'" & Convert.ToDateTime(objValues(8)).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                                    bSaved = ExecSQL("insert into [TrainingPlanned]([CompanyNum], [EmployeeNum], [CourseName], [ProviderName], [StartDate], [CompletionDate], [DirectCost], [CourseCategory], [InternalCourse], [IndividualTrainingPriority], [IndividualSkillsPriority], [CapturedByUsername]) values('" & objKey.ToString().Split(" ")(0) & "', '" & objKey.ToString().Split(" ")(1) & "', '" & GetDataText(objValues(0)) & "', '" & GetDataText(objValues(1)) & "', '" & Convert.ToDateTime(objValues(7)).ToString("yyyy-MM-dd HH:mm:ss") & "', " & CompletionDate & ", " & GetNullText(objValues(2)) & ", " & GetNullText(objValues(3)) & ", " & GetBitData(objValues(4)) & ", " & GetNullText(objValues(5)) & ", " & GetNullText(objValues(6)) & ", '" & Session("LoggedOn").UserID & "')")

                                    If (Not bSaved) Then Exit For

                                Next

                            End If

                            If (bSaved) Then

                                bSaved = ExecSQL("delete from [ess.LearningNeeds] where ([Username] = '" & .UserID & "' and [CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [CourseName] = '" & GetDataText(objValues(0)) & "')")

                            Else

                                Exit For

                            End If

                        End If

                        objValues = Nothing

                    End If

                Next

            End With

            If (bSaved) Then ClearFromCache("Data.Learning." & Session.SessionID)

        End If

        e.Result = "tasks.aspx tools/index.aspx"

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabLearning.TabPages(tabLearning.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabLearning.TabPages(tabLearning.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

#End Region

End Class