Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class accidents
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

        e.NewValues("ActionTaken") = GetExpControl(sender, "ActionTaken", "Text")

        e.NewValues("Treatment") = GetExpControl(sender, "Treatment", "Text")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (ClearCache) Then ClearFromCache("Data.Accidents." & Session.SessionID)

        With UDetails

            LoadExpGrid(Session, dgView, "Accident Tab", "<Tablename=Accident><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [AccidentDate], 120) + ' ' + convert(nvarchar(19), [AccidentTime], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[AccidentDate], [AccidentTime], [DateReported], [ReportedTo], [AccidentType], [Category], [Witness], [Doctor], [ManHours], [WC_Number], [WC_Amount_Paid], [WC_Amount_Received], [Certificate_1], [Certificate_2], [Certificate_3], [Description], [ActionTaken], [Treatment]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Accidents." & Session.SessionID)

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

        LoadExpDS(dsAccidentType, "select distinct [AccidentType] from [Accident] order by [AccidentType]")

        LoadExpDS(dsCategory, "select distinct [Category] from [Accident] order by [Category]")

        LoadExpDS(dsDoctor, "select distinct [Doctor] from [Accident] order by [Doctor]")

        LoadExpDS(dsWitness, "select distinct [Witness] from [Accident] order by [Witness]")

        UDetails = GetUserDetails(Session, "Accident Tab")

        LoadData()

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView.RowDeleting

        Dim SQLAudit As String = "<Tablename=Accident><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><AccidentDate=" & Convert.ToDateTime(e.Values("AccidentDate")).ToString("yyyy-MM-dd") & "><AccidentTime=" & Convert.ToDateTime(e.Values("AccidentTime")).ToString("HH:mm") & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView.RowInserting

        Dim SQLAudit As String = "<Tablename=Accident><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView.RowUpdating

        Dim SQLAudit As String = "<Tablename=Accident><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><AccidentDate;2=" & Convert.ToDateTime(e.OldValues("AccidentDate")).ToString("yyyy-MM-dd") & "><AccidentTime;3=" & Convert.ToDateTime(e.OldValues("AccidentTime")).ToString("HH:mm") & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Try

            Dim xFilePath As String = "Accidents [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

        Catch ex As Exception

        Finally

        End Try

    End Sub

#End Region

End Class