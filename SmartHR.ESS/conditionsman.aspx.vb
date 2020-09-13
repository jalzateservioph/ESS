Public Class conditionsman
    Inherits System.Web.UI.Page

    Private ExecPrint As Boolean
    Private PathID As String = String.Empty
    Private ShowRemarks As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "Basic Conditions", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlConditions.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Basic Conditions Acceptance: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadExpGrid(Session, dgView, "Basic Conditions", "<Tablename=PersonnelHistoryLog><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ActionDescription] + ' ' + convert(nvarchar(19), [ActionDate], 120)><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=upper([ActionDescription]) as [ActionDescription], [ActionDate], [ChangedFrom], [ChangedTo], [EffectiveFrom], [EffectiveTo], [Remarks]><Where=([PathID] = " & PathID & ")><ColumnOrder=[ActionDescription]>")

        End With

        LoadExpDS(dsReason, "select [Remark] from [PersonnelHistoryLogRemarkLU] order by [Remark]")

        If (dgView.VisibleRowCount > 0 AndAlso Not IsPostBack) Then

            Dim objDetails() As Object = dgView.GetRowValues(0, "EffectiveFrom", "EffectiveTo", "Remarks")

            If (Not IsNull(objDetails) AndAlso objDetails.Length > 0) Then

                If (IsDate(objDetails(0)) AndAlso Not IsDate(dteStart.Date)) Then dteStart.Date = objDetails(0)

                If (IsDate(objDetails(1)) AndAlso Not IsDate(dteUntil.Date)) Then dteUntil.Date = objDetails(1)

                If (Not IsNull(objDetails(2)) AndAlso IsString(objDetails(2)) AndAlso IsNull(cmbReason.Value)) Then cmbReason.Value = objDetails(2)

            End If

        End If

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Select Case e.Parameter

            Case "Print"
                ExecPrint = True

            Case Else

                Dim Values() As String = e.Parameter.Split(" ")

                Dim bSaved As Boolean

                Dim PathData As String = GetPathData(PathID)

                bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Basic Conditions', '" & GetXML(PathData, KeyName:="AppType") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                If (bSaved) Then bSaved = ExecSQL("update [PersonnelHistoryLog] set [EffectiveFrom] = '" & dteStart.Date.ToString("yyyy-MM-dd HH:mm:ss") & "', [EffectiveTo] = " & If(IsDate(dteUntil.Date), "'" & dteUntil.Date.ToString("yyyy-MM-dd HH:mm:ss") & "'", "null") & ", [Remarks] = " & If(IsString(cmbReason.Value), "'" & cmbReason.Value.ToString() & "'", "null") & " where ([PathID] = " & PathID & ")")

                If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

                If (bSaved) Then

                    e.Result = "tasks.aspx tools/index.aspx"

                Else

                    e.Result = String.Empty

                End If

        End Select

    End Sub

    Private Sub cpPage_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cpPage.CustomJSProperties

        e.Properties("cpExecPrint") = ExecPrint

    End Sub

    Private Sub dgView_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView.CustomButtonCallback

        If (e.ButtonID = "Select") Then

            If (IsNumeric(PathID)) Then txtRemarks_History.Text = GetRemarks(UDetails.Template, PathID, txtRemarks_History.Text)

            ShowRemarks = True

        End If

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        e.Properties("cpShow") = ShowRemarks

        e.Properties("cpRemarks") = txtRemarks_History.Text

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound

        If (dgView.VisibleRowCount > 0) Then

            Dim objData() As Object = sender.GetRowValues(0, "EffectiveFrom", "EffectiveTo", "Remarks")

            If (Not IsNull(objData) AndAlso objData.Length > -1) Then

                If (IsDate(objData(0)) AndAlso Not IsDate(dteStart.Date)) Then dteStart.Date = objData(0)

                If (IsDate(objData(1)) AndAlso Not IsDate(dteUntil.Date)) Then dteUntil.Date = objData(1)

                If (Not IsNull(objData(2)) AndAlso IsString(objData(2)) AndAlso IsNull(cmbReason.Value)) Then cmbReason.Value = objData(2)

            End If

        End If

    End Sub

#End Region

End Class