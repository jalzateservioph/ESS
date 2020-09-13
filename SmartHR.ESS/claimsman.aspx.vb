Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Partial Public Class claimsman
    Inherits System.Web.UI.Page

    Private bCancel As Boolean
    Private FilePath As String = String.Empty
    Private PathID As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

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

        LoadExpDS(dsClaimType, "select [ItemType] from [ClaimTypeLU] order by [ItemType]")

        Dim dgView As ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim IsRowExpanded As Boolean

        With UDetails

            If (ClearCache) Then

                ClearFromCache("Data.Claims.Register." & Session.SessionID)

                ClearFromCache("Data.Claims.Register.Items." & Session.SessionID)

            End If

            If (Not IsPostBack) Then Session("Claims.Register.LoadSub") = Nothing

            If (IsNumeric(Session("Claims.Register.LoadSub"))) Then IsRowExpanded = dgView_001.IsRowExpanded(Session("Claims.Register.LoadSub"))

            LoadExpGrid(Session, dgView_001, "Claims Module", "<Tablename=Claims><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Date], [Type], [Description], [DocPath], [ESSPath], [Username], [CapturedDate]><Where=([PathID] = " & PathID & ")>", "Data.Claims.Register." & Session.SessionID)

            If (IsNumeric(Session("Claims.Register.LoadSub"))) Then

                iRowIndex = Session("Claims.Register.LoadSub")

                If (IsRowExpanded) Then

                    Dim ClaimDate As String = Convert.ToDateTime(dgView_001.GetRowValues(iRowIndex, "Date")).ToString("yyyy-MM-dd HH:mm:ss")
                    Dim ClaimType As String = dgView_001.GetRowValues(iRowIndex, "Type").ToString()

                    dgView = TryCast(dgView_001.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                    If (Not IsNull(dgView)) Then

                        LoadExpDS(dsClaimTypeSub, "select [SubItemType] from [ClaimSubTypeLU] where ([ItemType] = '" & GetDataText(ClaimType) & "') order by [SubItemType]")

                        LoadExpGrid(Session, dgView, "Claims Module", "<Tablename=ClaimEntries><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] + ' ' + [ItemType] + ' ' + [ItemName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & ClaimDate & "', '" & ClaimType & "'><Columns=[ItemType], [ItemName], [Amount], [DocPath], [ESSPath]" & GetColumns(dgView, iRowIndex, 7, False) & "><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Date] = '" & ClaimDate & "' and [Type] = '" & ClaimType & "')>", "Data.Claims.Register.Items." & Session.SessionID)

                        dgView = Nothing

                    End If

                End If

            End If

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        UDetails = GetUserDetails(Session, "Claims Module", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlClaims.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Claim " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

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

        Dim ValidatedText As String = String.Empty

        Dim PathData As String = GetPathData(PathID)

        With UDetails

            If (Not IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Claims", "Claims", ValidatedText, GetXML(PathData, KeyName:="Summary"))) Then

                bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', " & PathID & ", 'Claims', '" & IIf(Not bCancel, "Claims", "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

            Else

                bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', " & PathID & ", 'Claims', '" & IIf(Not bCancel, GetXML(PathData, KeyName:="Summary"), "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & Session("LoggedOn").UserID & "', '" & GetXML(PathData, KeyName:="Summary") & "'")

            End If

        End With

        If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

        If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

    End Sub

    Private Sub dgView_001_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_001.DetailRowExpandedChanged

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

                End If

            End With

        ElseIf (sender.Equals(dgView_001) AndAlso IsNumeric(Session("Claims.Register.LoadSub"))) Then

            Session.Remove("Claims.Register.LoadSub")

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