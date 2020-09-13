Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class timesheets
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private ExecPrint As Boolean
    Private FilePath As String = String.Empty
    Private RefreshAll As Boolean
    Private RefreshData As Boolean
    Private RefreshDelete As Boolean
    Private RefreshParent As Boolean
    Private UDetails As Users = Nothing
    Private ValidatedText As String

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006" OrElse sender.ID = "dgView_012" OrElse sender.ID = "dgView_013") Then

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

    Private Function GetColumns(ByRef dgView As ASPxGridView, ByVal iRowIndex As Integer, ByVal iIndex As Integer, ByVal IsSummary As Boolean, ByVal IsChild As Boolean) As String

        Dim ReturnText As String = String.Empty

        Dim Values() As String = dgView.GetMasterRowKeyValue().ToString().Split(" ")

        Dim dtColumns As DataTable = GetSQLDT("select [a].[Typename], [g].[TypeID], [Size], [Name], [Text], [IsView], [Index], [SQLCalculate], [SQLSelect] from (([TimesheetMappingLU] as [m] left outer join [TimesheetSetup] as [c] on [m].[ColumnID] = [c].[ID]) left outer join [AssemblyLU] as [a] on [c].[AssemblyID] = [a].[ID]) left outer join [GroupTypeLU] as [g] on [c].[GroupTypeID] = [g].[ID] where ([IsChild] = " & IIf(IsChild, "1", "0") & " and [m].[ItemType] = '" & GetDataText(Values(4)) & "') order by [Index]")

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

            Session("Timesheets.Register.LoadSub") = Nothing

            Session("Timesheets.Register.LoadSub.Child") = Nothing

            Session("Timesheets.History.LoadSub") = Nothing

            Session("Timesheets.History.LoadSub.Child") = Nothing

            Session("Timesheets.Setup.LoadSub") = Nothing

        End If

        LoadExpDS(dsItemName, "select distinct [ItemName] from [TimesheetChildEntries] order by [ItemName]")

        LoadExpDS(dsTimesheetType, "select [ItemType] from [TimesheetTypeLU] order by [ItemType]")

        Dim dgView As ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim iRowIndexChild As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabTimesheets.ActiveTabIndex

                Case 0
                    If (ClearCache) Then

                        ClearFromCache("Data.Timesheets.Register." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Register.Items." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Register.Items.Child." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Timesheets.Register.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Timesheets.Register.LoadSub"))

                    LoadExpGrid(Session, dgView_001, "Timesheet Module", "<Tablename=Timesheets><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Start], [Until], [Type], [Description], [DocPath], [ESSPath], [Username], [CapturedDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Status] = 'Unsubmitted')>", "Data.Timesheets.Register." & Session.SessionID)

                    If (IsNumeric(Session("Timesheets.Register.LoadSub"))) Then

                        iRowIndex = Session("Timesheets.Register.LoadSub")

                        If (IsRowExpanded) Then

                            Dim deStart As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                            Dim deUntil As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                            Dim iType As String = dgView_001.GetRowValues(iRowIndex, "Type").ToString()

                            dgView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "'><Columns=[ItemDate], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 5, False, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "')>", "Data.Timesheets.Register.Items." & Session.SessionID)

                                If (IsNumeric(Session("Timesheets.Register.LoadSub.Child"))) Then

                                    iRowIndexChild = Session("Timesheets.Register.LoadSub.Child")

                                    dgView.ExpandRow(iRowIndexChild)

                                    Dim deDate As String = Convert.ToDateTime(dgView.GetRowValues(iRowIndexChild, "ItemDate")).ToString("yyyy-MM-dd HH:mm:ss")

                                    dgView = TryCast(dgView.FindDetailRowTemplateControl(iRowIndexChild, "dgView_012"), ASPxGridView)

                                    If (Not IsNull(dgView)) Then

                                        LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetChildEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120) + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "', '" & deDate & "'><Columns=[ItemName], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 5, False, True) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "' and [ItemDate] = '" & deDate & "')>", "Data.Timesheets.Register.Items.Child." & Session.SessionID)

                                        dgView = Nothing

                                    End If

                                End If

                            End If

                        End If

                    End If

                Case 1
                    If (ClearCache) Then

                        ClearFromCache("Data.Timesheets.Register." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Register.Items." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Register.Items.Child." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.History." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.History.Items." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.History.Items.Child." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Timesheets.History.LoadSub"))) Then IsRowExpanded = dgView_002.IsRowExpanded(Session("Timesheets.History.LoadSub"))

                    LoadExpGrid(Session, dgView_002, "Timesheet Module", "<Tablename=Timesheets><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Start], [Until], [Type], [Status], [Description], [DocPath], [ESSPath], [Username], [CapturedDate]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and not [Status] = 'Unsubmitted')>", "Data.Timesheets.History." & Session.SessionID)

                    If (IsNumeric(Session("Timesheets.History.LoadSub"))) Then

                        iRowIndex = Session("Timesheets.History.LoadSub")

                        If (IsRowExpanded) Then

                            Dim deStart As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                            Dim deUntil As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                            Dim iType As String = dgView_002.GetRowValues(iRowIndex, "Type").ToString()

                            dgView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_006"), ASPxGridView)

                            If (Not IsNull(dgView)) Then

                                LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "'><Columns=[ItemDate], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 5, False, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "')>", "Data.Timesheets.History.Items." & Session.SessionID)

                                If (IsNumeric(Session("Timesheets.History.LoadSub.Child"))) Then

                                    iRowIndexChild = Session("Timesheets.History.LoadSub.Child")

                                    dgView.ExpandRow(iRowIndexChild)

                                    Dim deDate As String = Convert.ToDateTime(dgView.GetRowValues(iRowIndexChild, "ItemDate")).ToString("yyyy-MM-dd HH:mm:ss")

                                    dgView = TryCast(dgView.FindDetailRowTemplateControl(iRowIndexChild, "dgView_013"), ASPxGridView)

                                    If (Not IsNull(dgView)) Then

                                        LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetChildEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120) + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "', '" & deDate & "'><Columns=[ItemName], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 5, False, True) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "' and [ItemDate] = '" & deDate & "')>", "Data.Timesheets.History.Items.Child." & Session.SessionID)

                                        dgView = Nothing

                                    End If

                                End If

                            End If

                        End If

                    End If

                Case 2
                    If (ClearCache) Then

                        ClearFromCache("Data.Timesheets.Types." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Types.Items." & Session.SessionID)

                    End If

                    LoadExpGrid(Session, dgView_008, "Timesheet Module", "<Tablename=TimesheetTypeLU><PrimaryKey=[ItemType]><Columns=[ItemType]>", "Data.Timesheets.Types." & Session.SessionID)

                Case 3
                    LoadExpDS(dsAssembly, "select [ID], [FriendlyName] from [AssemblyLU] where (not [FriendlyName] is null) order by [FriendlyName]")

                    LoadExpDS(dsDataType, "select [ID], [Typename] from [DataTypeLU] order by [Typename]")

                    LoadExpDS(dsGroupType, "select [ID], [Description] from [GroupTypeLU] order by [Description]")

                    If (ClearCache) Then

                        ClearFromCache("Data.Timesheets.Setup." & Session.SessionID)

                        ClearFromCache("Data.Timesheets.Setup.Types." & Session.SessionID)

                    End If

                    If (IsNumeric(Session("Timesheets.Setup.LoadSub"))) Then IsRowExpanded = dgView_010.IsRowExpanded(Session("Timesheets.Setup.LoadSub"))

                    LoadExpGrid(Session, dgView_010, "Timesheet Module", "<Tablename=TimesheetSetup><PrimaryKey=[ID]><Columns=[Name], [Text], [IsChild], [IsView], [AssemblyID], [DataTypeID], [Size], [GroupTypeID], [Index], [SQLCalculate], [SQLSelect], [SQLUpdate], [Description]>", "Data.Timesheets.Setup." & Session.SessionID)

                    If (IsNumeric(Session("Timesheets.Setup.LoadSub"))) Then

                        iRowIndex = Session("Timesheets.Setup.LoadSub")

                        If (IsRowExpanded) Then

                            dgView = TryCast(dgView_010.FindDetailRowTemplateControl(iRowIndex, "dgView_011"), ASPxGridView)

                            Dim ColumnID As String = dgView_010.GetRowValues(iRowIndex, "CompositeKey").ToString()

                            If (Not IsNull(dgView)) Then

                                LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetMappingLU><PrimaryKey=cast([ColumnID] as nvarchar(3)) + ' ' + [ItemType]><InsertKey=" & ColumnID & "><Columns=[ColumnID], [ItemType]><Where=([ColumnID] = " & ColumnID & ")>", "Data.Timesheets.Setup.Types." & Session.SessionID)

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

        If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006" OrElse sender.ID = "dgView_012" OrElse sender.ID = "dgView_013") Then

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

        UDetails = GetUserDetails(Session, "Timesheet Module")

        LoadData()

        With UDetails

            If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Timesheet", "Timesheet", ValidatedText) AndAlso Not IsPostBack) Then

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.ShowPopup('" & ReplaceJavaText(ValidatedText) & "'); }"

            Else

                cmdSubmit.ClientSideEvents.Click = "function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }"

            End If

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Select Case e.Parameter

            Case "Print"
                ExecPrint = True

            Case "Submit"

                Dim bSaved As Boolean

                With UDetails

                    For iLoop As Integer = 0 To (dgView_001.VisibleRowCount - 1)

                        bSaved = ExecSQL("update [Timesheets] set [Status] = 'New' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] = '" & dgView_001.GetRowValues(iLoop, "CompositeKey") & "')")

                        If (bSaved) Then bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Timesheet', 'Timesheet', 'Start', 'Start', '" & Convert.ToDateTime(dgView_001.GetRowValues(iLoop, "Start")).ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        If (Not bSaved) Then Exit For

                    Next

                End With

                If (bSaved) Then

                    ClearFromCache("Data.Timesheets.Register." & Session.SessionID)

                    ClearFromCache("Data.Timesheets.History." & Session.SessionID)

                    e.Result = "tasks.aspx tools/index.aspx"

                End If

        End Select

    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpExecPrint") = ExecPrint

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

            ExecSQL("update [TimesheetSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex - 1, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [TimesheetSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex - 1, "CompositeKey") & ")")

            ClearFromCache("Data.Timesheets.Setup." & Session.SessionID)

        Else

            ExecSQL("update [TimesheetSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex + 1, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex, "CompositeKey") & ")")

            ExecSQL("update [TimesheetSetup] set [Index] = " & sender.GetRowValues(e.VisibleIndex, "Index") & " where ([ID] = " & sender.GetRowValues(e.VisibleIndex + 1, "CompositeKey") & ")")

            ClearFromCache("Data.Timesheets.Setup." & Session.SessionID)

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

    Protected Sub dgView_002_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_002.CustomCallback

        If (e.Parameters = "Refresh" OrElse e.Parameters = "Reload") Then

            If (sender.Equals(dgView_002) AndAlso e.Parameters = "Reload") Then

                If (ExecSQL("update [Timesheets] set [Status] = 'Unsubmitted', [PathID] = null where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] = '" & sender.GetRowValues(Session("Timesheets.History.LoadSub"), "CompositeKey") & "')")) Then

                    Session("Timesheets.History.LoadSub") = Nothing

                    Session("Timesheets.History.LoadSub.Child") = Nothing

                    LoadData(True)

                End If

            Else

                RefreshAll = True

            End If

        End If

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_008.CustomJSProperties, dgView_010.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshAll") = RefreshAll

        e.Properties("cpRefreshData") = RefreshData

        e.Properties("cpRefreshDelete") = RefreshDelete

        e.Properties("cpRefreshParent") = RefreshParent

    End Sub

    Protected Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged, dgView_002.DetailRowExpandedChanged, dgView_008.DetailRowExpandedChanged, dgView_010.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim dgView As ASPxGridView = Nothing

            With UDetails

                If (sender.Equals(dgView_001)) Then

                    ClearFromCache("Data.Timesheets.Register.Items." & Session.SessionID)

                    Dim deStart As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                    Dim deUntil As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                    Dim iType As String = sender.GetRowValues(e.VisibleIndex, "Type").ToString()

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "'><Columns=[ItemDate], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 5, False, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & iType & "')>", "Data.Timesheets.Register.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                    Session("Timesheets.Register.LoadSub") = e.VisibleIndex

                ElseIf (sender.ID = "dgView_004") Then

                    ClearFromCache("Data.Timesheets.Register.Items.Child." & Session.SessionID)

                    Dim iRowIndex As Integer

                    If (IsNumeric(Session("Timesheets.Register.LoadSub"))) Then

                        iRowIndex = Session("Timesheets.Register.LoadSub")

                        Dim deStart As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                        Dim deUntil As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                        Dim iType As String = dgView_001.GetRowValues(iRowIndex, "Type").ToString()

                        Dim deDate As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "ItemDate")).ToString("yyyy-MM-dd HH:mm:ss")

                        dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_012"), ASPxGridView)

                        If (Not IsNull(dgView)) Then

                            LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetChildEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120) + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "', '" & deDate & "'><Columns=[ItemName], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 5, False, True) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "' and [ItemDate] = '" & deDate & "')>", "Data.Timesheets.Register.Items.Child." & Session.SessionID)

                            dgView = Nothing

                        End If

                    End If

                    Session("Timesheets.Register.LoadSub.Child") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_002)) Then

                    ClearFromCache("Data.Timesheets.History.Items." & Session.SessionID)

                    Dim deStart As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                    Dim deUntil As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                    Dim iType As String = sender.GetRowValues(e.VisibleIndex, "Type").ToString()

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_006"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "'><Columns=[ItemDate], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 5, False, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & iType & "')>", "Data.Timesheets.History.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                    Session("Timesheets.History.LoadSub") = e.VisibleIndex

                ElseIf (sender.ID = "dgView_006") Then

                    ClearFromCache("Data.Timesheets.History.Items.Child." & Session.SessionID)

                    Dim iRowIndex As Integer

                    If (IsNumeric(Session("Timesheets.History.LoadSub"))) Then

                        iRowIndex = Session("Timesheets.History.LoadSub")

                        Dim deStart As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "Start")).ToString("yyyy-MM-dd HH:mm:ss")

                        Dim deUntil As String = Convert.ToDateTime(dgView_002.GetRowValues(iRowIndex, "Until")).ToString("yyyy-MM-dd HH:mm:ss")

                        Dim iType As String = dgView_002.GetRowValues(iRowIndex, "Type").ToString()

                        Dim deDate As String = Convert.ToDateTime(sender.GetRowValues(e.VisibleIndex, "ItemDate")).ToString("yyyy-MM-dd HH:mm:ss")

                        dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_013"), ASPxGridView)

                        If (Not IsNull(dgView)) Then

                            LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetChildEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type] + ' ' + convert(nvarchar(19), [ItemDate], 120) + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart & "', '" & deUntil & "', '" & iType & "', '" & deDate & "'><Columns=[ItemName], [DocPath], [ESSPath]" & GetColumns(dgView, e.VisibleIndex, 5, False, True) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Start] = '" & deStart & "' and [Until] = '" & deUntil & "' and [Type] = '" & GetDataText(iType) & "' and [ItemDate] = '" & deDate & "')>", "Data.Timesheets.History.Items.Child." & Session.SessionID)

                            dgView = Nothing

                        End If

                    End If

                    Session("Timesheets.History.LoadSub.Child") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_010)) Then

                    ClearFromCache("Data.Timesheets.Setup.Types." & Session.SessionID)

                    dgView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_011"), ASPxGridView)

                    Dim ColumnID As String = sender.GetRowValues(e.VisibleIndex, "CompositeKey").ToString()

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Timesheet Module", "<Tablename=TimesheetMappingLU><PrimaryKey=cast([ColumnID] as nvarchar(3)) + ' ' + [ItemType]><InsertKey=" & ColumnID & "><Columns=[ColumnID], [ItemType]><Where=([ColumnID] = " & ColumnID & ")>", "Data.Timesheets.Setup.Types." & Session.SessionID)

                    Session("Timesheets.Setup.LoadSub") = e.VisibleIndex

                End If

            End With

        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("Timesheets.Register.LoadSub"))) Then

            Session.Remove("Timesheets.Register.LoadSub")

        ElseIf (sender.ID = "dgView_004" AndAlso IsNumeric(Session("Timesheets.Register.LoadSub.Child"))) Then

            Session.Remove("Timesheets.Register.LoadSub.Child")

        ElseIf (sender.Equals(dgView_002) AndAlso IsNumeric(Session("Timesheets.History.LoadSub"))) Then

            Session.Remove("Timesheets.History.LoadSub")

        ElseIf (sender.ID = "dgView_006" AndAlso IsNumeric(Session("Timesheets.History.LoadSub.Child"))) Then

            Session.Remove("Timesheets.History.LoadSub.Child")

        ElseIf (sender.Equals(dgView_010) AndAlso IsNumeric(Session("Timesheets.Setup.LoadSub"))) Then

            Session.Remove("Timesheets.Setup.LoadSub")

        End If

    End Sub

    Protected Sub dgView_002_HtmlCommandCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableCommandCellEventArgs) Handles dgView_002.HtmlCommandCellPrepared

        If (e.CommandCellType = DevExpress.Web.ASPxGridView.GridViewTableCommandCellType.Data) Then

            Dim iRowIndex As Integer

            Dim Status As String = String.Empty

            If (sender.Equals(dgView_002)) Then

                Status = sender.GetRowValues(e.VisibleIndex, "Status")

            ElseIf (IsNumeric(Session("Timesheets.History.LoadSub"))) Then

                iRowIndex = Session("Timesheets.History.LoadSub")

                Status = dgView_002.GetRowValues(iRowIndex, "Status").ToString()

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

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006" OrElse sender.ID = "dgView_012" OrElse sender.ID = "dgView_013") Then

                FilePath = ServerPath & e.Values("ESSPath").ToString().Replace("~/", "\").Replace("/", "\")

                If (File.Exists(FilePath)) Then File.Delete(FilePath)

            ElseIf (sender.Equals(dgView_010)) Then

                Dim colname As String = e.Values("Name").ToString()

                colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                Dim SQL As String = String.Empty

                Dim SQLTable As String = "[TimesheetEntries]"

                If (e.Values("IsChild")) Then SQLTable = "[TimesheetChildEntries]"

                SQL = "if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " drop column [" & colname & "]"

                ClearFromCache("Data." & SQLTable & ".Structure")

                ClearFromCache("Data." & SQLTable & ".Nullable")

                ExecSQL(SQL)

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (sender.ID = "dgView_006" OrElse sender.ID = "dgView_013") Then

                RefreshAll = True

            Else

                LoadData(True)

                If (sender.ID = "dgView_004" OrElse sender.ID = "dgView_011" OrElse sender.ID = "dgView_012") Then RefreshDelete = True

            End If

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_008.RowInserting, dgView_010.RowInserting

        Dim SQLAudit As String = String.Empty

        If (CancelEdit AndAlso (sender.ID = "dgView_004" OrElse sender.ID = "dgView_011" OrElse sender.ID = "dgView_012" OrElse sender.ID = "dgView_013")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        If (sender.Equals(dgView_010)) Then

            Dim maxIndex As Object = GetSQLField("select max([Index]) as [Index] from [TimesheetSetup]", "Index")

            If (IsNull(maxIndex)) Then maxIndex = -1

            e.NewValues("Index") = Convert.ToByte(maxIndex + 1)

        End If

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.Equals(dgView_001)) Then

                Dim deStart() As Date = {e.NewValues("Start"), e.NewValues("Start")}
                Dim deUntil As Date = e.NewValues("Until")

                While (deStart(1) <= deUntil)

                    With UDetails

                        ExecSQL("insert into [TimesheetEntries]([CompanyNum], [EmployeeNum], [Start], [Until], [Type], [ItemDate]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & deStart(0).ToString("yyyy-MM-dd HH:mm:ss") & "', '" & deUntil.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(e.NewValues("Type").ToString()) & "', '" & deStart(1).ToString("yyyy-MM-dd HH:mm:ss") & "')")

                    End With

                    deStart(1) = deStart(1).AddDays(1)

                End While

            ElseIf (sender.Equals(dgView_010)) Then

                Dim colname As String = e.NewValues("Name").ToString()

                colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                Dim objTypes() As Object = GetSQLFields("select [DataType], [Typename] from [DataTypeLU] where ([ID] = " & e.NewValues("DataTypeID").ToString() & ")")

                If (Not IsNull(objTypes)) Then

                    Dim SQL As String = String.Empty

                    Dim SQLTable As String = "[TimesheetEntries]"

                    If (e.NewValues("IsChild")) Then SQLTable = "[TimesheetChildEntries]"

                    If (Not IsNull(e.NewValues("SQLCalculate")) AndAlso Not e.NewValues("SQLCalculate") = String.Empty) Then

                        SQL = "if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " add [" & colname & "] as (" & e.NewValues("SQLCalculate").ToString() & ")"

                    Else

                        SQL = "if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " add [" & colname & "] [" & objTypes(1).ToString() & "] "

                        If (objTypes(0) = 3 OrElse objTypes(0) = 6) Then

                            If (Not objTypes(1) = "image" AndAlso Not objTypes(1) = "ntext" AndAlso Not objTypes(1) = "sql_variant" AndAlso Not objTypes(1) = "text" AndAlso Not objTypes(1) = "xml") Then SQL &= "(" & e.NewValues("Size").ToString() & ") "

                        End If

                        SQL &= "null"

                    End If

                    ClearFromCache("Data." & SQLTable & ".Structure")

                    ClearFromCache("Data." & SQLTable & ".Nullable")

                    ExecSQL(SQL)

                End If

                objTypes = Nothing

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (sender.ID = "dgView_006" OrElse sender.ID = "dgView_013") Then

                RefreshAll = True

            Else

                LoadData(True)

                CancelEdit = True

            End If

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

            If (sender.ID = "dgView_006" OrElse sender.ID = "dgView_013") Then

                RefreshAll = True

            Else

                If (sender.Equals(dgView_010)) Then

                    Dim colname As String = e.NewValues("Name").ToString()

                    colname = Regex.Replace(colname, "[^A-Za-z0-9]", String.Empty)

                    Dim objTypes() As Object = GetSQLFields("select [DataType], [Typename] from [DataTypeLU] where ([ID] = " & e.NewValues("DataTypeID").ToString() & ")")

                    If (Not IsNull(objTypes)) Then

                        Dim SQL() As String = {String.Empty, String.Empty}

                        Dim SQLTable As String = "[TimesheetEntries]"

                        If (e.NewValues("IsChild")) Then SQLTable = "[TimesheetChildEntries]"

                        If (Not IsNull(e.NewValues("SQLCalculate")) AndAlso Not e.NewValues("SQLCalculate") = String.Empty) Then

                            SQL(0) = "if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " drop column [" & colname & "]"

                            SQL(1) = "if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " add [" & colname & "] as (" & e.NewValues("SQLCalculate").ToString() & ")"

                        Else

                            SQL(0) = "if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'" & SQLTable & "') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = '" & colname & "') alter table " & SQLTable & " alter column [" & colname & "] [" & objTypes(1).ToString() & "] "

                            If (objTypes(0) = 3 OrElse objTypes(0) = 6) Then

                                If (Not objTypes(1) = "image" AndAlso Not objTypes(1) = "ntext" AndAlso Not objTypes(1) = "sql_variant" AndAlso Not objTypes(1) = "text" AndAlso Not objTypes(1) = "xml") Then SQL(0) &= "(" & e.NewValues("Size").ToString() & ") "

                            End If

                            SQL(0) &= "null"

                        End If

                        ClearFromCache("Data." & SQLTable & ".Structure")

                        ClearFromCache("Data." & SQLTable & ".Nullable")

                        ExecSQL(SQL(0))

                        If (SQL(1).Length > 0) Then

                            Threading.Thread.Sleep(500)

                            ExecSQL(SQL(1))

                        End If

                    End If

                    objTypes = Nothing

                End If

                LoadData(True)

                CancelEdit = True

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

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

            If (sender.Equals(dgView_001) OrElse sender.Equals(dgView_002) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_006" OrElse sender.ID = "dgView_012" OrElse sender.ID = "dgView_013") Then

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

                Dim sDocPath As String = GetFileData(Me, upDocument.UploadedFiles(0), "documents/Timesheets")

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

    Private Sub tabTimesheets_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles tabTimesheets.CustomJSProperties

        Dim bVisible As Boolean

        If (Not IsNull(Session("Managed")) AndAlso Not IsNull(Session("Managed").Template)) Then

            If (Not IsNull(GetArrayItem(Session("Managed").Template, "eGeneral.TimesheetsConfig"))) Then bVisible = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.TimesheetsConfig"))

        End If

        e.Properties("cpVisible") = bVisible

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabTimesheets.TabPages(tabTimesheets.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabTimesheets.TabPages(tabTimesheets.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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