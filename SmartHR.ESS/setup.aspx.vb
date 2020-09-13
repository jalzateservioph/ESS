Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class setup
    Inherits System.Web.UI.Page

    Private asm As System.Reflection.Assembly = Nothing
    Private CancelEdit As Boolean
    Private RefreshData As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function GetItemSQL(ByRef dgView As ASPxGridView, ByVal sSQL As String) As String

        Dim bSaved As Boolean = True

        Dim ItemKey As String

        Dim SQL As String = String.Empty

        Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

        If (dgView.Equals(dgView_001)) Then

            items = items_001

        ElseIf (dgView.Equals(dgView_002)) Then

            items = items_002

        ElseIf (dgView.Equals(dgView_003)) Then

            items = items_003

        ElseIf (dgView.Equals(dgView_004)) Then

            items = items_004

        End If

        For iLoop As Integer = 0 To (dgView.VisibleRowCount - 1)

            If (iLoop = 53) Then

                Debug.Print("53")

            End If

            SQL = sSQL.Replace("<%ID%>", dgView.GetRowValues(iLoop, "ID").ToString())

            ItemKey = dgView.ID & "_" & dgView.GetRowValues(iLoop, "Category").ToString() & "_" & dgView.GetRowValues(iLoop, "Key").ToString()

            If (dgView.Equals(dgView_002) OrElse dgView.Equals(dgView_004)) Then ItemKey &= "_Visible"

            If (items.Contains(ItemKey)) Then

                Select Case dgView.GetRowValues(iLoop, "DataType")

                    Case 0
                        If (Not dgView.Equals(dgView_002) AndAlso Not dgView.Equals(dgView_004)) Then

                            SQL = SQL.Replace("<%Column%>", "YesNo").Replace("<%Value%>", IIf(items.Get(ItemKey), "1", "0"))

                        Else

                            SQL = SQL.Replace("<%Visible%>", IIf(items.Get(ItemKey), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_Editable"))) Then SQL = SQL.Replace("<%Editable%>", IIf(items.Get(ItemKey.Replace("_Visible", "_Editable")), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_Required"))) Then SQL = SQL.Replace("<%Required%>", IIf(items.Get(ItemKey.Replace("_Visible", "_Required")), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_Approval"))) Then SQL = SQL.Replace("<%Approval%>", IIf(items.Get(ItemKey.Replace("_Visible", "_Approval")), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_ApprovalLevel"))) Then SQL = SQL.Replace("<%ApprovalLevel%>", IIf(items.Get(ItemKey.Replace("_Visible", "_ApprovalLevel")), items.Get(ItemKey.Replace("_Visible", "_ApprovalLevel")), "0"))

                        End If

                    Case 1
                        SQL = SQL.Replace("<%Column%>", "Int").Replace("<%Value%>", GetNullText(items.Get(ItemKey)))

                    Case 2
                        SQL = SQL.Replace("<%Column%>", "Dec").Replace("<%Value%>", GetNullText(items.Get(ItemKey)))

                    Case 3
                        SQL = SQL.Replace("<%Column%>", "Text").Replace("<%Value%>", GetNullText(items.Get(ItemKey)))

                    Case 4
                        SQL = SQL.Replace("<%Column%>", "Date").Replace("<%Value%>", GetNullDate(items.Get(ItemKey)))

                    Case 5
                        SQL = SQL.Replace("<%Column%>", "GUID").Replace("<%Value%>", GetNullText(items.Get(ItemKey)))

                    Case 6
                        If ((Not dgView.Equals(dgView_002)) AndAlso (Not ItemKey.StartsWith("ePersonal_")) AndAlso (Not ItemKey.StartsWith("eOrganizational_"))) Then ' AndAlso (Not dgView.Equals(dgView_004))) Then

                            'TODO: v6.0.74 ENSURE THAT WE CREATE A PARAMETER WHEN UPDATING THE RELEVANT CONTENT

                        Else

                            SQL = SQL.Replace("<%Visible%>", IIf(items.Get(ItemKey), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_Editable"))) Then SQL = SQL.Replace("<%Editable%>", IIf(items.Get(ItemKey.Replace("_Visible", "_Editable")), "1", "0"))

                            If (items.Contains(ItemKey.Replace("_Visible", "_Required"))) Then SQL = SQL.Replace("<%Required%>", IIf(items.Get(ItemKey.Replace("_Visible", "_Required")), "1", "0"))

                        End If

                End Select

                If (Not (ItemKey.Contains("Pwd") Or ItemKey.Contains("Password"))) Then bSaved = ExecSQL(SQL)

                If (Not bSaved) Then Exit For

            End If

        Next

        If (bSaved) Then

            Return SUCCESS

        Else

            Return DBERROR & SQL

        End If

    End Function

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)


        With UDetails

            LoadExpDS(dsTemplates, "SELECT UPPER([Code]) AS Code, UPPER([Name]) AS Name FROM [UserGroupTemplates] " & IIf(.Template <> "SuperAdmin", "WHERE Code != 'SuperAdmin'", "") & " ORDER BY [Name]")

            Dim dtGlobal As DataTable = Nothing

            Try

                Dim SuperAdminsOnly As String = String.Empty

                Dim RestrictedItems As String = String.Empty

                If Session("LoggedOn").Template <> "SuperAdmin" Then

                    SuperAdminsOnly = "AND [Key] NOT IN ('AdminRestriction')"

                    If (Not IsNull(GetArrayItem(.Template, "eGeneral.AdminRestriction"))) Then

                        RestrictedItems = GetArrayItem(.Template, "eGeneral.AdminRestriction")
                        'amanriza 29/10/2019, Added functions to assist convertion of Key to PolicyId
                        If (Not IsNull(RestrictedItems) Or RestrictedItems <> "" Or RestrictedItems <> String.Empty) Then
                            RestrictedItems = ConvertKeysToPolicyID(RestrictedItems)
                        End If
                        'amanriza end
                        'RestrictedItems = "AND [ID] NOT IN ('" & GetDataText(RestrictedItems.Replace(", ", ",")).Replace(",", "', '") & "')"
                        RestrictedItems = String.Format("AND [ID] NOT IN ({0})", RestrictedItems)

                        'RestrictedItems = IIf(RestrictedItems = "AND [ID] NOT IN ('')", String.Empty, RestrictedItems) 'amanriza 09/05/2019, Added a conditiion to avoid syntax error / App crash on query execution

                    End If

                End If

                Select Case tabSetup.ActiveTabIndex

                    Case 0 'Global

                        dtGlobal = GetSQLDT("select [p].[ID], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], null as [Value] from (([ess.Policy] as [p] left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID]", "Data.Policy")

                        If (Not IsNull(dtGlobal)) Then

                            dtGlobal.DefaultView.RowFilter = "not [Category] in ('ePersonal','eOrganizational')" & SuperAdminsOnly

                            dgView_001.DataSource = dtGlobal

                            dgView_001.DataBind()

                        End If

                    Case 1 'Global forms
                        dtGlobal = GetSQLDT("SELECT [p].[ID], [m].[ModuleName], [m].[TabName], [m].[ItemName], [a].[Assembly], [a].[TypeName] AS [AssemblyTypeName], [d].[DataType], [d].[TypeName] AS [DataTypeName], [g].[Name] AS [Category], [p].[Key], ISNULL([p].[Label],[p].[Key]) AS [Label], [p].[Description], [p].[Visible], [p].[Editable], [p].[Required], [p].[Approval], [p].[ApprovalLevel], [p].[YesNo], [p].[Int], [p].[IntMin], [p].[IntMax], [p].[Dec], [p].[DecMin], [p].[DecMax], [p].[Date], [p].[DateMin], [p].[DateMax], [p].[Text], [p].[GUID], [p].[Object], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter], [p].[Validation], NULL AS [Value] FROM [ess.Policy] AS [p] LEFT JOIN [DataTypeLU] AS [d] ON [p].[SetupDataTypeID] = [d].[ID] LEFT JOIN [AssemblyLU] AS [a] ON [p].[SetupAssemblyID] = [a].[ID] LEFT JOIN [ess.PolicyGroups] AS [g] ON [p].[GroupID] = [g].[ID] LEFT JOIN [ess.PolicyMapping] AS [m] ON [p].[ID] = [m].[PolicyID]", "Data.Policy", True)

                        If (Not IsNull(dtGlobal)) Then

                            dtGlobal.DefaultView.RowFilter = String.Format("[Category] IN ('ePersonal','eOrganizational','eCurriculumVitae') {0}", RestrictedItems)

                            dgView_002.DataSource = dtGlobal

                            dgView_002.DataBind()

                        End If

                    Case 2 'Template

                        dtGlobal = GetSQLDT("select [pi].[ID], [pi].[Template], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [pi].[Visible], [pi].[Editable], [pi].[Required], [pi].[YesNo], [pi].[Int], [pi].[IntMin], [pi].[IntMax], [pi].[Dec], [pi].[DecMin], [pi].[DecMax], [pi].[Date], [pi].[DateMin], [pi].[DateMax], [pi].[Text], [pi].[GUID], [pi].[Object], [pi].[LookupTable], [pi].[LookupText], [pi].[LookupValue], [pi].[LookupFilter], [pi].[Validation], null as [Value] from ((([ess.PolicyItems] as [pi] left outer join [ess.Policy] as [p] on [pi].[PolicyID] = [p].[ID]) left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID]", "Data.PolicyItems")

                        If (Not IsNull(dtGlobal)) Then

                            dtGlobal.DefaultView.RowFilter = String.Format("[Template] = '{0}' AND NOT [Category] IN ('ePersonal', 'eOrganizational','eCurriculumVitae') {1}", cmbTemplate_003.Value, SuperAdminsOnly)

                            dgView_003.DataSource = dtGlobal

                            dgView_003.DataBind()

                        End If

                    Case 3 'Template forms

                        dtGlobal = GetSQLDT("SELECT [i].[ID], [p].[ID] AS [PolicyID], [m].[ModuleName], [m].[TabName], [m].[ItemName], [i].[Template], [a].[Assembly], [a].[TypeName] AS [AssemblyTypeName], [d].[DataType], [d].[TypeName] AS [DataTypeName], [g].[Name] AS [Category], [p].[Key], ISNULL([Label],[Key]) AS [Label], [p].[Description], [i].[Visible], [i].[Editable], [i].[Required], [i].[Approval], [i].[ApprovalLevel], [i].[YesNo], [i].[Int], [i].[IntMin], [i].[IntMax], [i].[Dec], [i].[DecMin], [i].[DecMax], [i].[Date], [i].[DateMin], [i].[DateMax], [i].[Text], [i].[GUID], [i].[Object], [i].[LookupTable], [i].[LookupText], [i].[LookupValue], [i].[LookupFilter], [i].[Validation], NULL AS [Value] FROM [ess.Policy] AS [p] LEFT JOIN [ess.PolicyItems] AS [i] ON [p].[ID] = [i].[PolicyID] LEFT JOIN [ess.PolicyGroups] AS [g] ON [p].[GroupID] = [g].ID LEFT JOIN [DataTypeLU] AS [d] ON [p].[SetupDataTypeID] = [d].[ID] LEFT JOIN [AssemblyLU] AS [a] ON [p].[AssemblyID] = [a].[ID] LEFT JOIN [ess.PolicyMapping] AS [m] ON [p].[ID] = [m].[PolicyID]", "Data.PolicyItems", True)

                        If (Not IsNull(dtGlobal)) Then

                            dtGlobal.DefaultView.RowFilter = String.Format("[Template] = '{0}' AND [Category] IN ('ePersonal', 'eOrganizational','eCurriculumVitae') {1}", cmbTemplate_004.Value, RestrictedItems)

                            dgView_004.DataSource = dtGlobal

                            dgView_004.DataBind()

                        End If

                    Case 4 'Configuration
                        If (ClearCache) Then ClearFromCache("Data.Menu")

                        LoadExpGrid(Session, dgView_005, "ESS Setup", "<Tablename=ess.Menu><PrimaryKey=[ID]><Columns=[OrderID], [ItemImage], [Description], [LoadURL], [TemplateElement], [LoggedOnUser]><Where=([Visible] = 1)>")

                End Select

            Catch ex As Exception

                WriteEventLog(ex.Message)

            Finally

                If (Not IsNull(dtGlobal)) Then

                    dtGlobal.Dispose()

                    dtGlobal = Nothing

                End If

            End Try

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "ESS Setup")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        LoadData()

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Dim SavedText As String = String.Empty

        Select Case Values(0)

            Case "ClearCache"
                ClearCache()

                ClearSessionCache(Session.SessionID)

                ErrorText = SUCCESS & " Successfully cleared the cache"

            Case "UpdatePwd"
                ErrorText = DBERROR

                If (Values(2).Length > 0) Then

                    If (ExecSQL("update [ess.Policy] set [Text] = '" & CryptoEncrypt(Values(2), EncPwd, SaltPwd, 5, EncVectorPwd, 256) & "' where ([ID] = " & Values(1) & ")")) Then ErrorText = SUCCESS

                Else

                    If (ExecSQL("update [ess.Policy] set [Text] = null where ([ID] = " & Values(1) & ")")) Then ErrorText = SUCCESS

                End If

                SavedText = " Successfully saved the password"

            Case "GlobalSubmit"
                ErrorText = GetItemSQL(dgView_001, "update [ess.Policy] set [<%Column%>] = <%Value%> where ([ID] = <%ID%>)")

            Case "GlobalSubmitCascade"
                Dim SQL As String = "exec [ess.Cascade]"

                If (ExecSQL(SQL)) Then

                    ErrorText = SUCCESS

                    SavedText = " Successfully cascaded the information"

                    LoadData()
                Else

                    ErrorText = DBERROR & SQL

                End If

            Case "GlobalFormsSubmit"
                ErrorText = GetItemSQL(dgView_002, "update [ess.Policy] set [Visible] = <%Visible%>, [Editable] = <%Editable%>, [Required] = <%Required%>, [Approval] = <%Approval%>, [ApprovalLevel] = <%ApprovalLevel%> where ([ID] = <%ID%>)")

                LoadData()

            Case "LocalSubmit"
                ErrorText = GetItemSQL(dgView_003, "update [ess.PolicyItems] set [<%Column%>] = <%Value%> where ([ID] = <%ID%>)")

            Case "LocalFormsSubmit"
                ErrorText = GetItemSQL(dgView_004, "update [ess.PolicyItems] set [Visible] = <%Visible%>, [Editable] = <%Editable%>, [Required] = <%Required%>, [Approval] = <%Approval%>, [ApprovalLevel] = <%ApprovalLevel%> where ([ID] = <%ID%>)")

        End Select

        If (ErrorText = SUCCESS) Then

            If (String.IsNullOrEmpty(SavedText)) Then SavedText = " Successfully saved the information"

            Initialize(True)

            InitializeItems(True)

        End If

        e.Result = Values(0) & " " & ErrorText & SavedText

    End Sub

    Private Sub cpItems_003_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpItems_003.Callback, cpItems_004.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim dtGlobal As DataTable = Nothing

        Try

            Select Case Values(0)

                Case "LoadLocal"
                    items_003.Clear()

                    dtGlobal = GetSQLDT("select [pi].[ID], [pi].[Template], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [pi].[Visible], [pi].[Editable], [pi].[Required], [pi].[YesNo], [pi].[Int], [pi].[IntMin], [pi].[IntMax], [pi].[Dec], [pi].[DecMin], [pi].[DecMax], [pi].[Date], [pi].[DateMin], [pi].[DateMax], [pi].[Text], [pi].[GUID], [pi].[Object], [pi].[LookupTable], [pi].[LookupText], [pi].[LookupValue], [pi].[LookupFilter], [pi].[Validation], null as [Value] from ((([ess.PolicyItems] as [pi] left outer join [ess.Policy] as [p] on [pi].[PolicyID] = [p].[ID]) left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID]", "Data.PolicyItems")

                    If (Not IsNull(dtGlobal)) Then

                        dtGlobal.DefaultView.RowFilter = "[Template] = '" & Values(1) & "' and not [Category] in ('ePersonal', 'eOrganizational')"

                        dgView_003.DataSource = dtGlobal

                        dgView_003.DataBind()

                        LoadData()
                    End If

                Case "LoadFormsLocal"
                    items_004.Clear()

                    dtGlobal = GetSQLDT("select [pi].[ID], [pi].[Template], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [pi].[Visible], [pi].[Editable], [pi].[Required], [pi].[YesNo], [pi].[Int], [pi].[IntMin], [pi].[IntMax], [pi].[Dec], [pi].[DecMin], [pi].[DecMax], [pi].[Date], [pi].[DateMin], [pi].[DateMax], [pi].[Text], [pi].[GUID], [pi].[Object], [pi].[LookupTable], [pi].[LookupText], [pi].[LookupValue], [pi].[LookupFilter], [pi].[Validation], null as [Value] from ((([ess.PolicyItems] as [pi] left outer join [ess.Policy] as [p] on [pi].[PolicyID] = [p].[ID]) left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID]", "Data.PolicyItems")

                    If (Not IsNull(dtGlobal)) Then

                        dtGlobal.DefaultView.RowFilter = "[Template] = '" & Values(1) & "' and [Category] in ('ePersonal', 'eOrganizational')"

                        dgView_004.DataSource = dtGlobal

                        dgView_004.DataBind()

                    End If

            End Select

        Catch ex As Exception

        Finally

            If (Not IsNull(dtGlobal)) Then

                dtGlobal.Dispose()

                dtGlobal = Nothing

            End If

        End Try

    End Sub

    Private Sub dgView_005_CustomButtonCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_005.CustomButtonCallback

        If (e.ButtonID = "Up") Then

            ExecSQL("update [ess.Menu] set [OrderID] = " & sender.GetRowValues(e.VisibleIndex - 1, "OrderID") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [ess.Menu] set [OrderID] = " & sender.GetRowValues(e.VisibleIndex, "OrderID") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex - 1, "CompositeKey") & ")")

            ClearFromCache("Data.Menu")

        Else

            ExecSQL("update [ess.Menu] set [OrderID] = " & sender.GetRowValues(e.VisibleIndex + 1, "OrderID") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [ess.Menu] set [OrderID] = " & sender.GetRowValues(e.VisibleIndex, "OrderID") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex + 1, "CompositeKey") & ")")

            ClearFromCache("Data.Menu")

        End If

        RefreshData = True

    End Sub

    Private Sub dgView_005_CustomButtonInitialize(ByVal sender As Object, ByVal e As ASPxGridViewCustomButtonEventArgs) Handles dgView_005.CustomButtonInitialize

        If (e.Column.Name = "down") Then

            If (e.VisibleIndex = (sender.VisibleRowCount - 1)) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        ElseIf (e.Column.Name = "up") Then

            If (e.VisibleIndex = 0) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        End If

    End Sub

    Private Sub dgView_005_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_005.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshData") = RefreshData

    End Sub

    Private Sub dgView_001_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_001.DataBound, dgView_002.DataBound, dgView_003.DataBound, dgView_004.DataBound

        If (sender.Equals(dgView_001) AndAlso Not tabSetup.ActiveTabIndex = 0) Then Exit Sub

        If (sender.Equals(dgView_002) AndAlso Not tabSetup.ActiveTabIndex = 1) Then Exit Sub

        If (sender.Equals(dgView_003) AndAlso Not tabSetup.ActiveTabIndex = 2) Then Exit Sub

        If (sender.Equals(dgView_004) AndAlso Not tabSetup.ActiveTabIndex = 3) Then Exit Sub

        Dim objValue As Object = Nothing
        Dim ItemKey As String = String.Empty

        Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

        Try

            If (sender.Equals(dgView_001)) Then

                items = items_001

            ElseIf (sender.Equals(dgView_002)) Then

                items = items_002

            ElseIf (sender.Equals(dgView_003)) Then

                items = items_003

            ElseIf (sender.Equals(dgView_004)) Then

                items = items_004

            End If

            For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                ItemKey = sender.ID & "_" & sender.GetRowValues(iLoop, "Category").ToString() & "_" & sender.GetRowValues(iLoop, "Key").ToString()

                If ((Not sender.Equals(dgView_002)) AndAlso (Not sender.Equals(dgView_004))) Then

                    If (Not items.Contains(ItemKey)) Then

                        objValue = Nothing

                        Select Case sender.GetRowValues(iLoop, "AssemblyTypeName").ToString()

                            Case "DevExpress.Web.ASPxEditors.ASPxCheckBox"
                                objValue = sender.GetRowValues(iLoop, "YesNo")

                            Case "DevExpress.Web.ASPxEditors.ASPxComboBox"
                                objValue = sender.GetRowValues(iLoop, "Text").ToString()

                            Case "DevExpress.Web.ASPxEditors.ASPxDateEdit"
                                objValue = sender.GetRowValues(iLoop, "Date")

                            Case "DevExpress.Web.ASPxEditors.ASPxSpinEdit"
                                objValue = sender.GetRowValues(iLoop, "Int")

                            Case "DevExpress.Web.ASPxEditors.ASPxTextBox"
                                objValue = sender.GetRowValues(iLoop, "Text").ToString()

                        End Select

                        If (Not items.Contains(ItemKey)) Then items.Add(ItemKey, objValue)


                    End If

                Else
                    If (Not items.Contains(ItemKey)) Then items.Add(ItemKey, objValue)

                    If (Not items.Contains(ItemKey & "_Visible")) Then items.Add(ItemKey & "_Visible", sender.GetRowValues(iLoop, "Visible"))

                    If (Not items.Contains(ItemKey & "_Editable")) Then items.Add(ItemKey & "_Editable", sender.GetRowValues(iLoop, "Editable"))

                    If (Not items.Contains(ItemKey & "_Required")) Then items.Add(ItemKey & "_Required", sender.GetRowValues(iLoop, "Required"))

                    If (Not items.Contains(ItemKey & "_Approval")) Then items.Add(ItemKey & "_Approval", sender.GetRowValues(iLoop, "Approval"))

                    If (Not items.Contains(ItemKey & "_ApprovalLevel")) Then items.Add(ItemKey & "_ApprovalLevel", sender.GetRowValues(iLoop, "ApprovalLevel"))
                End If

            Next

        Catch ex As Exception

        Finally

            If (Not IsNull(objValue)) Then objValue = Nothing

            If (Not IsNull(items)) Then items = Nothing

        End Try

    End Sub

    Private Sub dgView_001_HtmlRowCreated(ByVal sender As Object, ByVal e As ASPxGridViewTableRowEventArgs) Handles dgView_001.HtmlRowCreated, dgView_002.HtmlRowCreated, dgView_003.HtmlRowCreated, dgView_004.HtmlRowCreated

        If (sender.Equals(dgView_001) AndAlso Not tabSetup.ActiveTabIndex = 0) Then Exit Sub

        If (sender.Equals(dgView_002) AndAlso Not tabSetup.ActiveTabIndex = 1) Then Exit Sub

        If (sender.Equals(dgView_003) AndAlso Not tabSetup.ActiveTabIndex = 2) Then Exit Sub

        If (sender.Equals(dgView_004) AndAlso Not tabSetup.ActiveTabIndex = 3) Then Exit Sub

        If (e.RowType = GridViewRowType.Data) Then

            Dim objValue As Object = Nothing
            Dim ItemKey As String = String.Empty

            Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

            Try

                If (sender.Equals(dgView_001)) Then

                    items = items_001

                ElseIf (sender.Equals(dgView_002)) Then

                    items = items_002

                ElseIf (sender.Equals(dgView_003)) Then

                    items = items_003

                ElseIf (sender.Equals(dgView_004)) Then

                    items = items_004

                End If

                If (Not IsNull(items)) Then

                    ItemKey = sender.ID & "_" & sender.GetRowValues(e.VisibleIndex, "Category").ToString() & "_" & sender.GetRowValues(e.VisibleIndex, "Key").ToString()
                   
                    If ((Not sender.Equals(dgView_002)) AndAlso (Not sender.Equals(dgView_004))) Then

                        Dim objControl As Object = Nothing
                        Dim setValue As String = String.Empty

                        Dim phControl As PlaceHolder = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Value"), GridViewDataColumn), "phControls" & sender.ID.Replace("dgView", String.Empty)), PlaceHolder)

                        If (Not IsNull(phControl)) Then

                            If (IsNull(app)) Then app = AppDomain.CreateDomain("DevExpress")

                            asm = app.Load(Reflection.AssemblyName.GetAssemblyName(Server.MapPath("~\bin\") & sender.GetRowValues(e.VisibleIndex, "Assembly").ToString()))

                            If (Not IsNull(asm)) Then

                                objControl = Activator.CreateInstance(asm.GetType(sender.GetRowValues(e.VisibleIndex, "AssemblyTypeName").ToString()))

                                If (Not IsNull(objControl)) Then

                                    objValue = Nothing

                                    If (items.Contains(ItemKey)) Then objValue = items.Get(ItemKey)

                                    objControl.ID = ItemKey

                                    objControl.ClientInstanceName = objControl.ID

                                    setValue = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "', s.<%Parameter%>()); }"

                                    phControl.Controls.Add(objControl)

                                    Select Case sender.GetRowValues(e.VisibleIndex, "AssemblyTypeName").ToString()

                                        Case "DevExpress.Web.ASPxEditors.ASPxCheckBox"

                                            If (Not IsNull(objValue)) Then

                                                objControl.Checked = objValue

                                            Else

                                                objControl.Checked = sender.GetRowValues(e.VisibleIndex, "YesNo")

                                                objValue = objControl.Checked

                                            End If

                                            objControl.ClientSideEvents.CheckedChanged = setValue.Replace("<%Parameter%>", "GetChecked")

                                        Case "DevExpress.Web.ASPxEditors.ASPxComboBox"

                                            objControl.EnableIncrementalFiltering = True

                                            objControl.DropDownStyle = DropDownStyle.DropDownList

                                            objControl.Width = Unit.Pixel(250)

                                            Dim Table As String = sender.GetRowValues(e.VisibleIndex, "LookupTable").ToString()
                                            Dim Text As String = sender.GetRowValues(e.VisibleIndex, "LookupText").ToString()
                                            Dim Value As String = sender.GetRowValues(e.VisibleIndex, "LookupValue").ToString()
                                            Dim Filter As String = sender.GetRowValues(e.VisibleIndex, "LookupFilter").ToString()

                                            objControl.DataSource = GetSQLDT("select " & Value & ", " & Text & " from " & Table & IIf(Filter.Length = 0, String.Empty, " where (" & Filter & ")") & " union select '', ''" & If(Not Text = Value, " order by " & Text, ""))

                                            objControl.TextField = Text.Replace("[", String.Empty).Replace("]", String.Empty)

                                            objControl.ValueField = Value.Replace("[", String.Empty).Replace("]", String.Empty)

                                            If (Not IsNull(objValue)) Then

                                                objControl.Value = objValue

                                            ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "Text"))) Then

                                                objControl.Value = sender.GetRowValues(e.VisibleIndex, "Text").ToString()

                                                objValue = objControl.Value

                                            End If

                                            objControl.DataBind()

                                            objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                                        Case "DevExpress.Web.ASPxEditors.ASPxDateEdit"

                                            If (Not IsNull(objValue)) Then

                                                objControl.Date = objValue

                                            ElseIf (IsDate(sender.GetRowValues(e.VisibleIndex, "Date"))) Then

                                                objControl.Date = sender.GetRowValues(e.VisibleIndex, "Date")

                                                objValue = objControl.Date

                                            End If

                                            objControl.ClientSideEvents.DateChanged = setValue.Replace("<%Parameter%>", "GetValue")

                                            objControl.EditFormat = EditFormat.Custom

                                            objControl.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

                                        Case "DevExpress.Web.ASPxEditors.ASPxSpinEdit"

                                            If (Not IsNull(objValue)) Then

                                                objControl.Value = objValue

                                            ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "Int"))) Then

                                                objControl.Value = sender.GetRowValues(e.VisibleIndex, "Int")

                                                objValue = objControl.Value

                                            End If

                                            If (Not IsNull(sender.GetRowValues(e.VisibleIndex, "IntMin"))) Then objControl.MinValue = sender.GetRowValues(e.VisibleIndex, "IntMin")

                                            If (Not IsNull(sender.GetRowValues(e.VisibleIndex, "IntMax"))) Then objControl.MaxValue = sender.GetRowValues(e.VisibleIndex, "IntMax")

                                            objControl.Width = Unit.Pixel(75)

                                            objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                                        Case "DevExpress.Web.ASPxEditors.ASPxTextBox"

                                            If (Not IsNull(objValue)) Then

                                                objControl.Value = objValue

                                            Else

                                                objControl.Text = sender.GetRowValues(e.VisibleIndex, "Text").ToString()

                                                If (ItemKey.Contains("Pwd") OrElse ItemKey.Contains("Password")) Then

                                                    If (objControl.Text.Length > 0) Then objControl.Text = CryptoDecrypt(objControl.Text, EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                                                End If

                                                objValue = objControl.Text

                                            End If

                                            objControl.Width = Unit.Pixel(250)

                                            If (ItemKey.Contains("Pwd") OrElse ItemKey.Contains("Password")) Then

                                                Dim objUpdate As New ASPxImage()

                                                objUpdate.ID = ItemKey & "_Update"

                                                objUpdate.ClientInstanceName = objUpdate.ID

                                                objUpdate.ClientSideEvents.Click = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('UpdatePwd " & sender.GetRowValues(e.VisibleIndex, "ID") & " ' + " & objControl.ID & ".GetText()); }"

                                                objUpdate.Cursor = "hand"

                                                objUpdate.ImageUrl = "images/accept.png"

                                                objUpdate.ToolTip = "Update Password"

                                                objUpdate.Style.Add("height", "16px")

                                                objUpdate.Style.Add("float", "right")

                                                objUpdate.Style.Add("padding-right", "2px")

                                                objUpdate.Style.Add("padding-top", "3px")

                                                objUpdate.Style.Add("width", "16px")

                                                phControl.Controls.Add(objUpdate)

                                                objControl.Style.Add("float", "left")

                                                objControl.Width = Unit.Pixel(225)

                                                objControl.Password = True

                                            Else

                                                objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                                            End If

                                    End Select

                                    If (Not items.Contains(ItemKey)) Then items.Add(ItemKey, objValue)

                                End If

                            End If

                        End If

                    Else

                        Dim chkVisible As ASPxCheckBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Visible"), GridViewDataColumn), "chkVisible" & sender.ID.Replace("dgView", String.Empty)), ASPxCheckBox)

                        If (Not IsNull(chkVisible)) Then

                            chkVisible.Checked = sender.GetRowValues(e.VisibleIndex, "Visible")

                            chkVisible.ClientInstanceName = ItemKey & "_Visible"

                            chkVisible.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_Visible', " & chkVisible.ClientInstanceName & ".GetChecked()); }"

                            If (items.Contains(ItemKey & "_Visible")) Then

                                chkVisible.Checked = items.Get(ItemKey & "_Visible")

                            Else

                                items.Add(ItemKey & "_Visible", chkVisible.Checked)

                            End If

                        End If

                        Dim chkEditable As ASPxCheckBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Editable"), GridViewDataColumn), "chkEditable" & sender.ID.Replace("dgView", String.Empty)), ASPxCheckBox)

                        If (Not IsNull(chkEditable)) Then

                            chkEditable.Checked = sender.GetRowValues(e.VisibleIndex, "Editable")

                            chkEditable.ClientInstanceName = ItemKey & "_Editable"

                            chkEditable.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_Editable', " & chkEditable.ClientInstanceName & ".GetChecked()); }"

                            If (items.Contains(ItemKey & "_Editable")) Then

                                chkEditable.Checked = items.Get(ItemKey & "_Editable")

                            Else

                                items.Add(ItemKey & "_Editable", chkEditable.Checked)

                            End If

                        End If

                        Dim chkRequired As ASPxCheckBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Required"), GridViewDataColumn), "chkRequired" & sender.ID.Replace("dgView", String.Empty)), ASPxCheckBox)

                        If (Not IsNull(chkRequired)) Then

                            chkRequired.Checked = sender.GetRowValues(e.VisibleIndex, "Required")

                            chkRequired.ClientInstanceName = ItemKey & "_Required"

                            chkRequired.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_Required', " & chkRequired.ClientInstanceName & ".GetChecked()); }"

                            If (items.Contains(ItemKey & "_Required")) Then

                                chkRequired.Checked = items.Get(ItemKey & "_Required")

                            Else

                                items.Add(ItemKey & "_Required", chkRequired.Checked)

                            End If

                        End If

                        Dim chkApproval As ASPxCheckBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Approval"), GridViewDataColumn), "chkApproval" & sender.ID.Replace("dgView", String.Empty)), ASPxCheckBox)

                        If (Not IsNull(chkApproval)) Then

                            chkApproval.Checked = sender.GetRowValues(e.VisibleIndex, "Approval")

                            chkApproval.ClientInstanceName = ItemKey & "_Approval"

                            chkApproval.ClientSideEvents.CheckedChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_Approval', " & chkApproval.ClientInstanceName & ".GetChecked()); }"

                            If (items.Contains(ItemKey & "_Approval")) Then

                                chkApproval.Checked = items.Get(ItemKey & "_Approval")

                            Else

                                items.Add(ItemKey & "_Approval", chkApproval.Checked)

                            End If

                        End If

                        Dim chkApprovalLevel As ASPxSpinEdit = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("ApprovalLevel"), GridViewDataColumn), "chkLevel" & sender.ID.Replace("dgView", String.Empty)), ASPxSpinEdit)

                        If (Not IsNull(chkApprovalLevel)) Then

                            chkApprovalLevel.Value = sender.GetRowValues(e.VisibleIndex, "ApprovalLevel")

                            chkApprovalLevel.ClientInstanceName = ItemKey & "_ApprovalLevel"

                            'chkApprovalLevel.ClientSideEvents.ValueChanged = "function(s, e) { items_001.Set('" & ItemKey & "_Value', s.GetValue()); items_001.Set('" & ItemKey & "_Text', s.GetValue()); }"

                            chkApprovalLevel.ClientSideEvents.ValueChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_ApprovalLevel', " & chkApprovalLevel.ClientInstanceName & ".GetValue()); }"

                            If (items.Contains(ItemKey & "_ApprovalLevel")) Then

                                chkApprovalLevel.Value = items.Get(ItemKey & "_ApprovalLevel")

                            Else

                                items.Add(ItemKey & "_ApprovalLevel", chkApprovalLevel.Value)

                            End If

                        End If

                    End If

                    Dim lblText As ASPxLabel = TryCast(TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, TryCast(sender.Columns("Description"), GridViewDataColumn), "lblDescription" & sender.ID.Replace("dgView", String.Empty)), ASPxLabel), ASPxLabel)

                    If (Not IsNull(lblText)) Then lblText.Text = SplitText(sender.GetRowValues(e.VisibleIndex, "Description").ToString().Replace(Chr(9), String.Empty), 50) & "... "

                    Dim hlText As ASPxHyperLink = TryCast(TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, TryCast(sender.Columns("Description"), GridViewDataColumn), "hlDescription" & sender.ID.Replace("dgView", String.Empty)), ASPxHyperLink), ASPxHyperLink)

                    If (Not IsNull(hlText)) Then hlText.ClientSideEvents.Click = "function(s, e) { txtDescription.SetText('" & ReplaceJavaText(sender.GetRowValues(e.VisibleIndex, "Description").ToString().Replace(Chr(9), String.Empty)) & "'); pcText.Show(); }"

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(items)) Then items = Nothing

                If (Not IsNull(objValue)) Then objValue = Nothing

            End Try

        End If

    End Sub

    Private Sub dgView_005_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_005.RowUpdating

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_005_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_005.RowValidating

        e.NewValues("OrderID") = sender.GetRowValuesByKeyValue(e.Keys(0), "OrderID")

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabSetup.TabPages(tabSetup.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabSetup.TabPages(tabSetup.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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