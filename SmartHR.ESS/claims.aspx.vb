Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class claims
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String = String.Empty
    Private RefreshData As Boolean
    Private RefreshDelete As Boolean
    Private RefreshParent As Boolean
    Private UDetails As Users = Nothing
    Private ValidatedText As String

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006") Then

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002)) Then e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

            If (Session("DocPath") = String.Empty) Then Session("DocPath") = Nothing

            e.NewValues("DocPath") = Session("DocPath")

            If (Session("ESSPath") = String.Empty) Then Session("ESSPath") = Nothing

            e.NewValues("ESSPath") = Session("ESSPath")

            If (sender.IsEditing AndAlso sender.IsNewRowEditing AndAlso (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002))) Then

                e.NewValues("Username") = Session("LoggedOn").UserID

                e.NewValues("CapturedDate") = Date.Now

            ElseIf (sender.IsEditing AndAlso (Not sender.IsNewRowEditing) AndAlso sender.Equals(dgView_002)) Then

                e.NewValues("Status") = "Unsubmitted"

            End If

        ElseIf (sender.Equals(dgView_010)) Then

            e.NewValues("SQLCalculate") = GetExpControl(sender, "SQLCalculate", "Text")

            e.NewValues("SQLSelect") = GetExpControl(sender, "SQLSelect", "Text")

            e.NewValues("SQLUpdate") = GetExpControl(sender, "SQLUpdate", "Text")

            e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

        End If

    End Sub

    Private Function GetColumns(ByRef dgView As ASPxGridView, ByVal iRowIndex As Integer, ByVal iIndex As Integer, ByVal IsSummary As Boolean) As String

        Dim ReturnText As String = String.Empty

        Dim Values() As String = dgView.GetMasterRowKeyValue().ToString().Split(" ")

        Dim dtColumns As DataTable = GetSQLDT("select [a].[Typename], [g].[TypeID], [Size], [Name], [Text], [IsView], [Index], [SQLSelect], [SQLCalculate] from (([ClaimMappingLU] as [m] left outer join [ClaimSetup] as [c] on [m].[ColumnID] = [c].[ID]) left outer join [AssemblyLU] as [a] on [c].[AssemblyID] = [a].[ID]) left outer join [GroupTypeLU] as [g] on [c].[GroupTypeID] = [g].[ID] where ([m].[ItemType] = '" & GetDataText(Values(3)) & "') order by [Index]")

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    If (IsSummary AndAlso Not .Item("TypeID") = 6) Then

                        ReturnText &= ", [" & .Item("Name").ToString() & "]"

                    ElseIf (Not IsSummary) Then

                        ReturnText &= ", [" & .Item("Name").ToString() & "]"

                    End If

                    If ((IsSummary AndAlso Not .Item("TypeID") = 6) OrElse (Not IsSummary)) Then

                        If (IsNull(dgView.Columns(.Item("Name").ToString()))) Then

                            Dim dvColumn As Object = Nothing

                            Select Case .Item("Typename").ToString().Replace("DevExpress.Web.ASPxEditors.", String.Empty).Replace("DevExpress.Web.ASPxGridView.", String.Empty)

                                Case "ASPxCheckBox"
                                    dvColumn = New GridViewDataCheckColumn()

                                Case "ASPxComboBox"
                                    dvColumn = New GridViewDataComboBoxColumn()

                                    Dim dtCombo As DataTable = Nothing

                                    Try

                                        dtCombo = GetSQLDT(.Item("SQLSelect").ToString())

                                        If (IsData(dtCombo)) Then

                                            dvColumn.PropertiesComboBox.TextField = dtCombo.Columns(0).ColumnName

                                            dvColumn.PropertiesComboBox.ValueField = dtCombo.Columns(0).ColumnName

                                            dvColumn.PropertiesComboBox.DataSource = dtCombo

                                        End If

                                    Catch ex As Exception

                                    Finally

                                        If (Not IsNull(dtCombo)) Then

                                            dtCombo.Dispose()

                                            dtCombo = Nothing

                                        End If

                                    End Try

                                Case "ASPxDateEdit"
                                    dvColumn = New GridViewDataDateColumn()

                                Case "ASPxLabel"
                                    dvColumn = New GridViewDataColumn()

                                Case "ASPxListBox"
                                    dvColumn = New GridViewDataColumn()

                                Case "ASPxMemo"
                                    dvColumn = New GridViewDataMemoColumn()

                                Case "ASPxRadioButtonList"
                                    dvColumn = New GridViewDataColumn()

                                Case "ASPxSpinEdit"
                                    dvColumn = New GridViewDataSpinEditColumn()

                                    dvColumn.PropertiesSpinEdit.DecimalPlaces = 2

                                Case "ASPxTextBox"
                                    dvColumn = New GridViewDataTextColumn()

                            End Select

                            dvColumn.Caption = .Item("Text").ToString()

                            dvColumn.FieldName = .Item("Name").ToString()

                            If (Not IsNull(.Item("SQLCalculate"))) Then dvColumn.EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.False

                            dvColumn.Name = .Item("Name").ToString()

                            dvColumn.Visible = True

                            If (Not .Item("TypeID") = DevExpress.Data.SummaryItemType.None) Then

                                dgView.GroupSummary.Add(.Item("TypeID"), dvColumn.Name)

                                dgView.TotalSummary.Add(.Item("TypeID"), dvColumn.Name)

                            End If

                            dgView.Columns.Add(dvColumn)

                            dvColumn.VisibleIndex = Convert.ToInt32(iIndex + .Item("Index"))

                        End If

                    End If

                End With

            Next

            dtColumns.Dispose()

            For Each column As GridViewColumn In dgView.Columns

                If (column.Caption = "#") Then column.VisibleIndex = 254

                If (column.Name = "delete") Then column.VisibleIndex = 255

            Next

        End If

        dtColumns = Nothing

        Return ReturnText

    End Function

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (Not IsPostBack) Then

            Session("Claims.Register.LoadSub") = Nothing

            Session("Claims.History.LoadSub") = Nothing

            Session("Claims.Types.LoadSub") = Nothing

            Session("Claims.Setup.LoadSub") = Nothing

        End If

        LoadExpDS(dsClaimType, "select [ItemType] from [ClaimTypeLU] order by [ItemType]")

        Dim dgView As ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabClaims.ActiveTabIndex

                Case 0
                    If (ClearCache) Then

                        ClearFromCache("Data.Claims.Register." & Session.SessionID)

                        ClearFromCache("Data.Claims.Register.Items." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Claims.Register.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Claims.Register.LoadSub"))

                    LoadExpGrid(Session, dgView_001, "Claims Module", "<Tablename=Claims><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Date], [Type], [Description], [DocPath], [ESSPath], [Username], [CapturedDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Status] = 'Unsubmitted')>", "Data.Claims.Register." & Session.SessionID)

                    If (IsNumeric(Session("Claims.Register.LoadSub"))) Then

                        iRowIndex = Session("Claims.Register.LoadSub")

                        If (IsRowExpanded) Then

                            Dim ClaimDate As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Date")).ToString("yyyy-MM-dd HH:mm:ss")
                            Dim ClaimType As String = dgView_001.GetRowValues(iRowIndex, "Type").ToString()

                            dgView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                LoadExpDS(dsClaimTypeSub, "select [SubItemType] from [ClaimSubTypeLU] where ([ItemType] = '" & GetDataText(ClaimType) & "') order by [SubItemType]")

                                LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] + ' ' + [ItemType] + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ClaimDate & "', '" & ClaimType & "'><Columns=[ItemType], [ItemName], [Amount], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 7, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Date] = '" & ClaimDate & "' and [Type] = '" & GetDataText(ClaimType) & "')>", "Data.Claims.Register.Items." & Session.SessionID)

                                dgView = Nothing

                            End If

                        End If

                    End If

                Case 1
                    If (ClearCache) Then

                        ClearFromCache("Data.Claims.Register." & Session.SessionID)

                        ClearFromCache("Data.Claims.Register.Items." & Session.SessionID)

                        ClearFromCache("Data.Claims.History." & Session.SessionID)

                        ClearFromCache("Data.Claims.History.Items." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Claims.History.LoadSub"))) Then IsRowExpanded = dgView_002.IsRowExpanded(Session("Claims.History.LoadSub"))

                    LoadExpGrid(Session, dgView_002, "Claims Module", "<Tablename=Claims><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Date], [Type], [Description], [DocPath], [ESSPath], [Status], [Username], [CapturedDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and not [Status] = 'Unsubmitted')>", "Data.Claims.History." & Session.SessionID)

                    If (IsNumeric(Session("Claims.History.LoadSub"))) Then

                        iRowIndex = Session("Claims.History.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_006"), ASPxGridView)

                            Dim ClaimDate As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "Date")).ToString("yyyy-MM-dd HH:mm:ss")
                            Dim ClaimType As String = dgView_002.GetRowValues(iRowIndex, "Type").ToString()

                            If (Not IsNull(dgView)) Then

                                LoadExpDS(dsClaimTypeSub, "select [SubItemType] from [ClaimSubTypeLU] where ([ItemType] = '" & GetDataText(ClaimType) & "') order by [SubItemType]")

                                LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] + ' ' + [ItemType] + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ClaimDate & "', '" & ClaimType & "'><Columns=[ItemType], [ItemName], [Amount], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 7, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Date] = '" & ClaimDate & "' and [Type] = '" & ClaimType & "')>", "Data.Claims.History.Items." & Session.SessionID)

                                dgView = Nothing

                            End If

                        End If

                    End If

                Case 2
                    If (ClearCache) Then

                        ClearFromCache("Data.Claims.Types." & Session.SessionID)

                        ClearFromCache("Data.Claims.Types.Items." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Claims.Types.LoadSub"))) Then IsRowExpanded = dgView_008.IsRowExpanded(Session("Claims.Types.LoadSub"))

                    LoadExpGrid(Session, dgView_008, "Claims Module", "<Tablename=ClaimTypeLU><PrimaryKey=[ItemType]><Columns=[ItemType]>", "Data.Claims.Types." & Session.SessionID)

                    If (IsNumeric(Session("Claims.Types.LoadSub"))) Then

                        iRowIndex = Session("Claims.Types.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_008.FindDetailRowTemplateControl(iRowIndex, "dgView_009"), ASPxGridView)

                            Dim ClaimType As String = dgView_008.GetRowValues(iRowIndex, "CompositeKey").ToString()

                            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimSubTypeLU><PrimaryKey=[ItemType] + ' ' + [SubItemType]><InsertKey='" & GetDataText(ClaimType) & "'><Columns=[SubItemType]><Where=([ItemType] = '" & GetDataText(ClaimType) & "')>", "Data.Claims.Types.Items." & Session.SessionID)

                        End If

                    End If

                Case 3
                    LoadExpDS(dsAssembly, "select [ID], [FriendlyName] from [AssemblyLU] where (not [FriendlyName] is null) order by [FriendlyName]")

                    LoadExpDS(dsDataType, "select [ID], [Typename] from [DataTypeLU] order by [Typename]")

                    LoadExpDS(dsGroupType, "select [ID], [Description] from [GroupTypeLU] order by [Description]")

                    If (ClearCache) Then

                        ClearFromCache("Data.Claims.Setup." & Session.SessionID)

                        ClearFromCache("Data.Claims.Setup.Types." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Claims.Setup.LoadSub"))) Then IsRowExpanded = dgView_010.IsRowExpanded(Session("Claims.Setup.LoadSub"))

                    LoadExpGrid(Session, dgView_010, "Claims Module", "<Tablename=ClaimSetup><PrimaryKey=[ID]><Columns=[Name], [Text], [IsView], [AssemblyID], [DataTypeID], [Size], [GroupTypeID], [Index], [SQLCalculate], [SQLSelect], [SQLUpdate], [Description]>", "Data.Claims.Setup." & Session.SessionID)

                    If (IsNumeric(Session("Claims.Setup.LoadSub"))) Then

                        iRowIndex = Session("Claims.Setup.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_010.FindDetailRowTemplateControl(iRowIndex, "dgView_011"), ASPxGridView)

                            Dim ColumnID As String = dgView_010.GetRowValues(iRowIndex, "CompositeKey").ToString()

                            If (Not IsNull(dgView)) Then

                                LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimMappingLU><PrimaryKey=cast([ColumnID] as nvarchar(3)) + ' ' + [ItemType]><InsertKey=" & ColumnID & "><Columns=[ColumnID], [ItemType]><Where=([ColumnID] = " & ColumnID & ")>", "Data.Claims.Setup.Types." & Session.SessionID)

                                dgView = Nothing

                            End If

                        End If

                    End If

            End Select

        End With

    End Sub

    Private Sub ValidateExpValues(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002)) Then

            If (IsNull(e.NewValues("Username"))) Then e.NewValues("Username") = e.OldValues("Username")

        End If

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006") Then

            If (Not IsNull(Session("DocPath"))) Then e.NewValues("DocPath") = GetDataText(Session("DocPath").ToString())

            If (Not IsNull(Session("ESSPath"))) Then e.NewValues("ESSPath") = GetDataText(Session("ESSPath").ToString())

        End If

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Claims Module")

        LoadData()

        With UDetails

            If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Claims", "Claims", ValidatedText) AndAlso Not IsPostBack) Then

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.ShowPopup('" & ReplaceJavaText(ValidatedText) & "'); }"

            Else

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }"

            End If

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim bSaved As Boolean

            Dim mValidatedText As String = String.Empty

            With UDetails

                For iLoop As Integer = 0 To (dgView_001.VisibleRowCount - 1)

                    bSaved = ExecSQL("update [Claims] set [Status] = 'New' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] = '" & dgView_001.GetRowValues(iLoop, "CompositeKey") & "')")

                    If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Claims", "Claims", ValidatedText, dgView_001.GetRowValues(iLoop, "Type"))) Then

                        If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Claims', 'Claims', 'Start', 'Start', '" & Convert.ToDateTime(dgView_001.GetRowValues(iLoop, "Date")).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                    Else

                        If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Claims', 'Claims', 'Start', 'Start', '" & Convert.ToDateTime(dgView_001.GetRowValues(iLoop, "Date")).ToString("yyyy-MM-dd HH:mm:ss") & "', '" & Session("LoggedOn").UserID & "', '" & dgView_001.GetRowValues(iLoop, "Type") & "'")

                    End If

                    If (Not bSaved) Then Exit For

                Next

            End With

            If (bSaved) Then

                ClearFromCache("Data.Claims.Register." & Session.SessionID)

                ClearFromCache("Data.Claims.History." & Session.SessionID)

                e.Result = "tasks.aspx tools/index.aspx"

            End If

        End If

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Private Sub dgView_010_CellEditorInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs) Handles dgView_010.CellEditorInitialize

        If (Not e.Column.FieldName = "GroupTypeID") Then Return

        Dim combo As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (Not IsNull(combo)) Then

            If (IsNull(combo.Value)) Then combo.SelectedIndex = 5

        End If

    End Sub

    Private Sub dgView_010_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_010.CustomButtonCallback

        If (e.ButtonID = "Up") Then

            ExecSQL("update [ClaimSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex - 1, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [ClaimSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex - 1, "CompositeKey") & ")")

            ClearFromCache("Data.Claims.Setup." & Session.SessionID)

        Else

            ExecSQL("update [ClaimSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex + 1, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [ClaimSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex + 1, "CompositeKey") & ")")

            ClearFromCache("Data.Claims.Setup." & Session.SessionID)

        End If

        RefreshData = True

    End Sub

    Private Sub dgView_010_CustomButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs) Handles dgView_010.CustomButtonInitialize

        If (e.Column.Name = "down") Then

            If (e.VisibleIndex = (sender.VisibleRowCount - 1)) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        ElseIf (e.Column.Name = "up") Then

            If (e.VisibleIndex = 0) Then e.Visible = DevExpress.Utils.DefaultBoolean.False

        End If

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_008.CustomJSProperties, dgView_010.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshData") = RefreshData

        e.Properties("cpRefreshDelete") = RefreshDelete

        e.Properties("cpRefreshParent") = RefreshParent

    End Sub

    Private Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged, dgView_002.DetailRowExpandedChanged, dgView_008.DetailRowExpandedChanged, dgView_010.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim dgView As ASPxGridView = Nothing

            With UDetails

                If (sender.Equals(dgView_001)) Then

                    ClearFromCache("Data.Claims.Register.Items." & Session.SessionID)

                    Dim ClaimDate As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Date")).ToString("yyyy-MM-dd HH:mm:ss")
                    Dim ClaimType As String = sender.GetRowValues(e.VisibleIndex, "Type").ToString()

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        LoadExpDS(dsClaimTypeSub, "select [SubItemType] from [ClaimSubTypeLU] where ([ItemType] = '" & GetDataText(ClaimType) & "') order by [SubItemType]")

                        LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] + ' ' + [ItemType] + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ClaimDate & "', '" & ClaimType & "'><Columns=[ItemType], [ItemName], [Amount], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 7, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Date] = '" & ClaimDate & "' and [Type] = '" & ClaimType & "')>", "Data.Claims.Register.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                    Session("Claims.Register.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_002)) Then

                    ClearFromCache("Data.Claims.History.Items." & Session.SessionID)

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_006"), ASPxGridView)

                    Dim ClaimDate As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Date")).ToString("yyyy-MM-dd HH:mm:ss")
                    Dim ClaimType As String = sender.GetRowValues(e.VisibleIndex, "Type").ToString()

                    If (Not IsNull(dgView)) Then

                        LoadExpDS(dsClaimTypeSub, "select [SubItemType] from [ClaimSubTypeLU] where ([ItemType] = '" & GetDataText(ClaimType) & "') order by [SubItemType]")

                        LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] + ' ' + [ItemType] + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ClaimDate & "', '" & ClaimType & "'><Columns=[ItemType], [ItemName], [Amount], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 7, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Date] = '" & ClaimDate & "' and [Type] = '" & ClaimType & "')>", "Data.Claims.History.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                    Session("Claims.History.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_008)) Then

                    ClearFromCache("Data.Claims.Types.Items." & Session.SessionID)

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_009"), ASPxGridView)

                    Dim ClaimType As String = sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString()

                    If (Not IsNull(dgView)) Then

                        LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimSubTypeLU><PrimaryKey=[ItemType] + ' ' + [SubItemType]><InsertKey='" & GetDataText(ClaimType) & "'><Columns=[SubItemType]><Where=([ItemType] = '" & GetDataText(ClaimType) & "')>", "Data.Claims.Types.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                    Session("Claims.Types.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_010)) Then

                    ClearFromCache("Data.Claims.Setup.Types." & Session.SessionID)

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_011"), ASPxGridView)

                    Dim ColumnID As String = sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString()

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimMappingLU><PrimaryKey=cast([ColumnID] as nvarchar(3)) + ' ' + [ItemType]><InsertKey=" & ColumnID & "><Columns=[ColumnID], [ItemType]><Where=([ColumnID] = " & ColumnID & ")>", "Data.Claims.Setup.Types." & Session.SessionID)

                    Session("Claims.Setup.LoadSub") = e.VisibleIndex

                End If

            End With

        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("Claims.Register.LoadSub"))) Then

            Session.Remove("Claims.Register.LoadSub")

        ElseIf (sender.Equals(dgView_002) AndAlso IsNumeric(Session("Claims.History.LoadSub"))) Then

            Session.Remove("Claims.History.LoadSub")

        ElseIf (sender.Equals(dgView_008) AndAlso IsNumeric(Session("Claims.Types.LoadSub"))) Then

            Session.Remove("Claims.Types.LoadSub")

        ElseIf (sender.Equals(dgView_010) AndAlso IsNumeric(Session("Claims.Setup.LoadSub"))) Then

            Session.Remove("Claims.Setup.LoadSub")

        End If

    End Sub

    Protected Sub dgView_002_HtmlCommandCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableCommandCellEventArgs) Handles dgView_002.HtmlCommandCellPrepared

        If (e.CommandCellType = DevExpress.Web.ASPxGridView.GridViewTableCommandCellType.Data) Then

            Dim Status As String = String.Empty

            If (sender.Equals(dgView_002)) Then

                Status = sender.GetRowValues(e.VisibleIndex, "Status")

            Else

                Status = sender.GetMasterRowFieldValues("Status")

            End If

            If (Not ((Status = "HOD Declined") Or (Status = "HR Declined"))) Then

                e.Cell.Controls(0).Visible = False

                e.Cell.Text = "&nbsp;"

            End If

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_008.RowDeleting, dgView_010.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006") Then

                FilePath = ServerPath & e.Values("ESSPath").ToString().Replace("~/", "\").Replace("/", "\")

                If (File.Exists(FilePath)) Then File.Delete(FilePath)

            ElseIf (sender.Equals(dgView_010)) Then

                Dim colname As String = e.Values("Name").ToString()

                colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                Dim SQL As String = "if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] drop column [" & colname & "]"

                ClearFromCache("Data.ClaimEntries.Structure")

                ClearFromCache("Data.ClaimEntries.Nullable")

                ExecSQL(SQL)

            End If

            If (sender.ID = "dgView_006") Then

                If (ExecSQL("update [Claims] set [Status] = 'Unsubmitted', [PathID] = null where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] = '" & sender.GetMasterRowKeyValue() & "')")) Then

                    Session("Claims.History.LoadSub") = Nothing

                    RefreshParent = True

                End If

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_004" OrElse sender.ID = "dgView_009" OrElse sender.ID = "dgView_011") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_008.RowInserting, dgView_010.RowInserting

        Dim SQLAudit As String = String.Empty

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004" OrElse sender.ID.ToString() = "dgView_009" OrElse sender.ID.ToString() = "dgView_011")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        If (sender.ID = "dgView_006") Then

            If (ExecSQL("update [Claims] set [Status] = 'Unsubmitted', [PathID] = null where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] = '" & sender.GetMasterRowKeyValue() & "')")) Then

                Session("Claims.History.LoadSub") = Nothing

                RefreshParent = True

            End If

        ElseIf (sender.Equals(dgView_010)) Then

            Dim maxIndex As Object = GetSQLField("select max([Index]) as [Index] from [ClaimSetup]", "Index")

            If (IsNull(maxIndex)) Then maxIndex = -1

            e.NewValues("Index") = Convert.ToByte(maxIndex + 1)

        End If

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.Equals(dgView_010)) Then

                Dim colname As String = e.NewValues("Name").ToString()

                colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                Dim objTypes() As Object = GetSQLFields("select [DataType], [Typename] from [DataTypeLU] where ([ID] = " & e.NewValues("DataTypeID").ToString() & ")")

                If (Not IsNull(objTypes)) Then

                    If (Not IsNull(e.NewValues("SQLCalculate")) AndAlso Not e.NewValues("SQLCalculate") = String.Empty) Then

                        ExecSQL("if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] add [" & colname & "] as (" & e.NewValues("SQLCalculate").ToString() & ")")

                    Else

                        Dim SQL As String = "if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] add [" & colname & "] [" & objTypes(1).ToString() & "] "

                        If (objTypes(0) = 3 OrElse objTypes(0) = 6) Then

                            If (Not objTypes(1) = "image" AndAlso Not objTypes(1) = "ntext" AndAlso Not objTypes(1) = "sql_variant" AndAlso Not objTypes(1) = "text" AndAlso Not objTypes(1) = "xml") Then SQL &= "(" & e.NewValues("Size").ToString() & ") "

                        End If

                        SQL &= "null"

                        ExecSQL(SQL)

                    End If

                    ClearFromCache("Data.ClaimEntries.Structure")

                    ClearFromCache("Data.ClaimEntries.Nullable")

                End If

                objTypes = Nothing

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

            Session.Remove("DocPath")
            Session.Remove("ESSPath")

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_008.RowUpdating, dgView_010.RowUpdating

        Dim SQLAudit As String = String.Empty

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.ID = "dgView_006") Then

                If (ExecSQL("update [Claims] set [Status] = 'Unsubmitted', [PathID] = null where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] = '" & sender.GetMasterRowKeyValue() & "')")) Then

                    Session("Claims.History.LoadSub") = Nothing

                    RefreshParent = True

                End If

            ElseIf (sender.Equals(dgView_010)) Then

                Dim colname As String = e.NewValues("Name").ToString()

                colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                Dim objTypes() As Object = GetSQLFields("select [DataType], [Typename] from [DataTypeLU] where ([ID] = " & e.NewValues("DataTypeID").ToString() & ")")

                If (Not IsNull(objTypes)) Then

                    If (Not IsNull(e.NewValues("SQLCalculate")) AndAlso Not e.NewValues("SQLCalculate") = String.Empty) Then

                        ExecSQL("if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] drop column [" & colname & "]")

                        Threading.Thread.Sleep(500)

                        ExecSQL("if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] add [" & colname & "] as (" & e.NewValues("SQLCalculate").ToString() & ")")

                    Else

                        Dim SQL As String = "if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ClaimEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table [ClaimEntries] alter column [" & colname & "] [" & objTypes(1).ToString() & "] "

                        If (objTypes(0) = 3 OrElse objTypes(0) = 6) Then

                            If (Not objTypes(1) = "image" AndAlso Not objTypes(1) = "ntext" AndAlso Not objTypes(1) = "sql_variant" AndAlso Not objTypes(1) = "text" AndAlso Not objTypes(1) = "xml") Then SQL &= "(" & e.NewValues("Size").ToString() & ") "

                        End If

                        SQL &= "null"

                        ExecSQL(SQL)

                    End If

                    ClearFromCache("Data.ClaimEntries.Structure")

                    ClearFromCache("Data.ClaimEntries.Nullable")

                End If

                objTypes = Nothing

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

            Session.Remove("DocPath")
            Session.Remove("ESSPath")

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_008.RowValidating, dgView_010.RowValidating

        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002)) Then

                If (IsNull(e.OldValues("Username"))) Then e.OldValues("Username") = sender.GetRowValues(iRowIndex, "Username")

            End If

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006") Then

                If (IsNull(e.OldValues("DocPath"))) Then e.OldValues("DocPath") = sender.GetRowValues(iRowIndex, "DocPath")

                If (IsNull(e.OldValues("ESSPath"))) Then e.OldValues("ESSPath") = sender.GetRowValues(iRowIndex, "ESSPath")

            End If

        ElseIf (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002)) Then

            e.NewValues("Username") = Session("LoggedOn").UserID

        End If

        Dim upDocument As ASPxUploadControl = Session("UploadedFile")

        If (IsNull(upDocument)) Then

            ValidateExpValues(sender, e)

        Else

            If (upDocument.UploadedFiles(0).IsValid) Then

                Dim sDocPath As String = GetFileData(Me, upDocument.UploadedFiles(0), "documents/claims")

                Session("DocPath") = GetDataText(GetXML(sDocPath, KeyName:="UNCPath"))

                Session("ESSPath") = GetDataText(GetXML(sDocPath, KeyName:="VirtualPath"))

                ValidateExpValues(sender, e)

                If (e.RowError.Length = 0) Then

                    If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

                        Dim FilePath As String = ServerPath & e.OldValues("ESSPath").ToString().Replace("~/", "\").Replace("/", "\")

                        If (File.Exists(FilePath)) Then File.Delete(FilePath)

                    End If

                    If (sDocPath.Length > 0) Then upDocument.UploadedFiles(0).SaveAs(GetXML(sDocPath, KeyName:="FilePath"))

                Else

                    Session.Remove("DocPath")
                    Session.Remove("ESSPath")

                End If

            Else

                ValidateExpValues(sender, e)

            End If

        End If

    End Sub

    Protected Function GetClickUrl(ByVal Container As GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As GridViewDataItemTemplateContainer) As String

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

    Protected Sub upDocument_001_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session("UploadedFile") = sender

    End Sub

    Private Sub tabClaims_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles tabClaims.CustomJSProperties

        Dim bVisible As Boolean

        If (Not IsNull(Session("Managed")) AndAlso Not IsNull(Session("Managed").Template)) Then

            If (Not IsNull(GetArrayItem(Session("Managed").Template, "eGeneral.ClaimsConfig"))) Then bVisible = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.ClaimsConfig"))

        End If

        e.Properties("cpVisible") = bVisible

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabClaims.TabPages(tabClaims.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabClaims.TabPages(tabClaims.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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