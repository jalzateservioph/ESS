Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class timesheetsman
    Inherits System.Web.UI.Page

    Private bCancel As Boolean
    Private CancelEdit As Boolean
    Private FilePath As String = String.Empty
    Private PathID As String
    Private RefreshData As Boolean
    Private RefreshDelete As Boolean
    Private RefreshParent As Boolean
    Private UDetails As Users = Nothing
    Private ValidatedText As String

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (sender.Equals(dgView_001) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_012") Then

            If (sender.Equals(dgView_001)) Then e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

            If (Session("DocPath") = String.Empty) Then Session("DocPath") = Nothing

            e.NewValues("DocPath") = Session("DocPath")

            If (Session("ESSPath") = String.Empty) Then Session("ESSPath") = Nothing

            e.NewValues("ESSPath") = Session("ESSPath")

            If (sender.IsEditing AndAlso sender.IsNewRowEditing AndAlso sender.Equals(dgView_001)) Then

                e.NewValues("Username") = Session("LoggedOn").UserID

                e.NewValues("CapturedDate") = Date.Now

            ElseIf (sender.IsEditing AndAlso Not sender.IsNewRowEditing) Then

                e.NewValues("Status") = "Unsubmitted"

            End If

        End If

    End Sub

    Private Function GetColumns(ByRef dgView As ASPxGridView, ByVal iRowIndex As Integer, ByVal iIndex As Integer, ByVal IsSummary As Boolean, ByVal IsChild As Boolean) As String

        Dim ReturnText As String = String.Empty

        Dim Values() As String = dgView.GetMasterRowKeyValue().ToString().Split(" ")

        Dim dtColumns As DataTable = GetSQLDT("select [a].[Typename], [g].[TypeID], [Size], [Name], [Text], [IsView], [Index], [SQLCalculate] from (([TimesheetMappingLU] as [m] left outer join [TimesheetSetup] as [c] on [m].[ColumnID] = [c].[ID]) left outer join [AssemblyLU] as [a] on [c].[AssemblyID] = [a].[ID]) left outer join [GroupTypeLU] as [g] on [c].[GroupTypeID] = [g].[ID] where ([IsChild] = " & IIf(IsChild, "1", "0") & " and [m].[ItemType] = '" & GetDataText(Values(4)) & "') order by [Index]")

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

        End If

        LoadExpDS(dsItemName, "select distinct [ItemName] from [TimesheetChildEntries] order by [ItemName]")

        LoadExpDS(dsTimesheetType, "select [ItemType] from [TimesheetTypeLU] order by [ItemType]")

        Dim dgView As ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim iRowIndexChild As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            If (ClearCache) Then

                ClearFromCache("Data.Timesheets.Register." & Session.SessionID)

                ClearFromCache("Data.Timesheets.Register.Items." & Session.SessionID)

                ClearFromCache("Data.Timesheets.Register.Items.Child." & Session.SessionID)

            End If

            If (IsNumeric(Session("Timesheets.Register.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Timesheets.Register.LoadSub"))

            LoadExpGrid(Session, dgView_001, "Timesheet Module", "<Tablename=Timesheets><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Start], 120) + ' ' + convert(nvarchar(19), [Until], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Start], [Until], [Type], [Description], [DocPath], [ESSPath], [Username], [CapturedDate]><Where=([PathID] = " & PathID & ")>", "Data.Timesheets.Register." & Session.SessionID)

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

        End With

    End Sub

    Private Sub ValidateExpValues(ByRef sender As Object, ByRef e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        If (sender.Equals(dgView_001)) Then

            If (IsNull(e.NewValues("Username"))) Then e.NewValues("Username") = e.OldValues("Username")

        End If

        If (sender.Equals(dgView_001) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_012") Then

            If (Not IsNull(Session("DocPath"))) Then e.NewValues("DocPath") = GetDataText(Session("DocPath").ToString())

            If (Not IsNull(Session("ESSPath"))) Then e.NewValues("ESSPath") = GetDataText(Session("ESSPath").ToString())

        End If

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        UDetails = GetUserDetails(Session, "Timesheet Module", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlTimesheets.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Timesheet " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        LoadData(Not IsPostBack)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        Dim bSaved As Boolean

        Dim PathData As String = GetPathData(PathID)

        bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Timesheet', '" & IIf(Not bCancel, "Timesheet", "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

        If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshData") = RefreshData

        e.Properties("cpRefreshDelete") = RefreshDelete

        e.Properties("cpRefreshParent") = RefreshParent

    End Sub

    Protected Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged

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

                End If

            End With

        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("Timesheets.Register.LoadSub"))) Then

            Session.Remove("Timesheets.Register.LoadSub")

        ElseIf (sender.ID = "dgView_004" AndAlso IsNumeric(Session("Timesheets.Register.LoadSub.Child"))) Then

            Session.Remove("Timesheets.Register.LoadSub.Child")

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.Equals(dgView_001) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_012") Then

                FilePath = ServerPath & e.Values("ESSPath").ToString().Replace("~/", "\").Replace("/", "\")

                If (File.Exists(FilePath)) Then File.Delete(FilePath)

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_004" OrElse sender.ID = "dgView_012") Then RefreshDelete = True

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting

        Dim SQLAudit As String = String.Empty

        If (CancelEdit AndAlso (sender.ID = "dgView_004" OrElse sender.ID = "dgView_012")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

            Session.Remove("DocPath")
            Session.Remove("ESSPath")

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating

        Dim SQLAudit As String = String.Empty

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

            Session.Remove("UploadedFile")

            Session.Remove("DocPath")
            Session.Remove("ESSPath")

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating

        Dim iRowIndex As Integer = sender.EditingRowVisibleIndex

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            If (sender.Equals(dgView_001)) Then

                If (IsNull(e.OldValues("Username"))) Then e.OldValues("Username") = sender.GetRowValues(iRowIndex, "Username")

            End If

            If (sender.Equals(dgView_001) OrElse sender.ID = "dgView_004" OrElse sender.ID = "dgView_012") Then

                If (IsNull(e.OldValues("DocPath"))) Then e.OldValues("DocPath") = sender.GetRowValues(iRowIndex, "DocPath")

                If (IsNull(e.OldValues("ESSPath"))) Then e.OldValues("ESSPath") = sender.GetRowValues(iRowIndex, "ESSPath")

            End If

        ElseIf (sender.Equals(dgView_001)) Then

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

#End Region

End Class