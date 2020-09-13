Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports System.IO
Imports System.Threading

Partial Public Class reportsview
    Inherits System.Web.UI.Page

    Private DecryptedURL As String = String.Empty

    Private blnPageIsTerminating As Boolean = False

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim reportString As String = String.Empty

        Dim pParams() As Object = Nothing

        Dim rParams() As Object = Nothing

        Dim cReport As ReportDocument = Nothing

        Dim dtParams As DataTable = Nothing

        Dim pValues() As Object = Nothing

        Try

            If (Not IsPostBack) Then

                If (Not IsNull(Request.QueryString("params"))) Then

                    DecryptedURL = CryptoDecrypt(Request.QueryString("params"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                    Dim iCount As Byte = 0

                    While (Not GetXML(DecryptedURL, KeyName:="param" & iCount.ToString()) = String.Empty)

                        iCount += 1

                    End While

                    If ((iCount - 1) >= 0) Then

                        Array.Resize(pParams, iCount)

                        For i As Byte = 0 To (iCount - 1)

                            pParams(i) = GetXML(DecryptedURL, KeyName:="param" & i.ToString())

                        Next

                    End If

                    ' jalzate - 04240219
                    ' added handling for report parameters
                    iCount = 0

                    While (Not GetXML(DecryptedURL, KeyName:="rparam" & iCount.ToString()) = String.Empty)

                        iCount += 1

                    End While

                    If ((iCount - 1) >= 0) Then

                        Array.Resize(rParams, iCount)

                        For i As Byte = 0 To (iCount - 1)

                            rParams(i) = GetXML(DecryptedURL, KeyName:="rparam" & i.ToString())

                        Next

                    End If
                    ' jalzate - end

                    If (GetXML(DecryptedURL, KeyName:="type") = "load") Then

                        Dim XRFile As String = String.Empty

                        Dim XRTitle As String = GetDataText(GetXML(DecryptedURL, KeyName:="id"))

                        Dim XRRoot As String = Server.MapPath(String.Empty)

                        Dim XRReport As String = String.Empty

                        If (Not IsNumeric(XRTitle)) Then

                            XRReport = GetSQLField("select [Path] from [ess.ReportsLU] where ([Title] = '" & XRTitle & "')", "Path")

                        Else

                            XRReport = GetSQLField("select [ReportUri] from [ess.Users.ReportsLU] where ([ID] = " & XRTitle & ")", "ReportUri")

                        End If

                        If (IsString(XRReport)) Then XRReport = XRReport.ToString().Replace("~/", String.Empty).Replace("/", "\")

                        If (XRReport.ToLower().EndsWith(".rpt")) Then

                            cReport = New ReportDocument()

                            If (XRRoot.EndsWith("\")) Then XRRoot = XRRoot.Substring(0, XRRoot.Length - 1)

                            If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                                XRRoot = XRRoot & "\" & ReplaceParams(True, XRReport, pParams)

                            Else

                                XRRoot = XRRoot & "\" & XRReport

                            End If

                            cReport.Load(XRRoot)

                            With cReport.DataDefinition

                                If (Not IsNull(.ParameterFields) AndAlso .ParameterFields.Count > 0) Then

                                    dtParams = New DataTable()

                                    dtParams.Columns.Add("Type", GetType(Byte))

                                    dtParams.Columns.Add("ID", GetType(Integer))

                                    dtParams.Columns.Add("Name", GetType(String))

                                    dtParams.Columns.Add("Description", GetType(String))

                                    dtParams.Columns.Add("Values", GetType(String))

                                    Array.Resize(pValues, 5)

                                    For i As Integer = 0 To (.ParameterFields.Count - 1)

                                        If (Not IsString(.ParameterFields(i).ReportName)) Then

                                            Select Case .ParameterFields(i).ValueType

                                                Case FieldValueType.BooleanField

                                                    pValues(0) = 0

                                                    pValues(4) = Nothing

                                                Case FieldValueType.DateField, FieldValueType.DateTimeField, FieldValueType.TimeField

                                                    pValues(0) = 1

                                                    pValues(4) = Nothing

                                                Case Else

                                                    If (Not IsNull(.ParameterFields(i).DefaultValues) AndAlso .ParameterFields(i).DefaultValues.Count > 0) Then

                                                        pValues(0) = 2

                                                        pValues(4) = String.Empty

                                                        For x As Integer = 0 To (.ParameterFields(i).DefaultValues.Count - 1)

                                                            pValues(4) &= CType(.ParameterFields(i).DefaultValues(x), ParameterDiscreteValue).Value

                                                            If (x < (.ParameterFields(i).DefaultValues.Count - 1)) Then pValues(4) &= " "

                                                        Next

                                                    Else

                                                        pValues(0) = 3

                                                        pValues(4) = Nothing

                                                    End If

                                            End Select

                                            pValues(1) = i

                                            pValues(2) = .ParameterFields(i).ParameterFieldName

                                            pValues(3) = .ParameterFields(i).PromptText

                                            dtParams.Rows.Add(pValues)

                                        End If

                                    Next

                                    UpdateCache(dtParams, "Params." & Session.SessionID, "<TimeSpan=Minutes><Duration=15>")

                                    dgView.DataSource = dtParams

                                    dgView.DataBind()

                                    lpPage.ClientSideEvents.Init = "function(s, e) { s.Hide(); }"

                                    cpParams.ClientVisible = True

                                Else

                                    If (Not IsNull(cReport)) Then

                                        cReport.Close()

                                        cReport.Dispose()

                                        cReport = Nothing

                                    End If

                                    If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                                        XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), XRRoot, XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"), rParams, pParams)

                                    Else

                                        XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), XRRoot, XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"), rParams)

                                    End If

                                End If

                            End With

                        Else

                            If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                                XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), XRRoot, XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"), rParams, pParams)

                            Else

                                XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), XRRoot, XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"), rParams)

                            End If

                        End If

                        If (File.Exists(XRFile)) Then

                            XRFile = XRFile.Replace(Server.MapPath(String.Empty) & "\", String.Empty).Replace("\", "/")

                            Response.Redirect("reportsview.aspx?type=open&path=" & XRFile, True)

                        End If

                    End If

                ElseIf (Request.QueryString("type") = "open" AndAlso Not IsNull(Request.QueryString("path"))) Then

                    DeleteReport(Request.QueryString("path"))

                    Response.Redirect(Request.QueryString("path"))

                End If

            ElseIf (Not IsNull(GetCacheObject("Params." & Session.SessionID))) Then

                dgView.DataSource = GetCacheObject("Params." & Session.SessionID)

                dgView.DataBind()

                If (Not IsString(lpPage.ClientSideEvents.Init)) Then lpPage.ClientSideEvents.Init = "function(s, e) { s.Hide(); }"

                If (Not cpParams.ClientVisible) Then cpParams.ClientVisible = True

            End If

        Catch ex As ThreadAbortException

            WriteEventLog(ex)

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(pValues)) Then pValues = Nothing

            If (Not IsNull(dtParams)) Then

                dtParams.Dispose()

                dtParams = Nothing

            End If

            If (Not IsNull(cReport)) Then

                cReport.Close()

                cReport.Dispose()

                cReport = Nothing

            End If

            If (Not IsNull(pParams)) Then pParams = Nothing

        End Try

    End Sub

    Private Sub cpParams_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cpParams.Callback

        Dim pParams() As Object = Nothing

        Dim cReport As ReportDocument = Nothing

        Dim dtParams As DataTable = Nothing

        Dim pValues() As Object = Nothing

        Try

            If (Not IsNull(Request.QueryString("params"))) Then

                DecryptedURL = CryptoDecrypt(Request.QueryString("params"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                Dim iCount As Byte = 0

                While (Not GetXML(DecryptedURL, KeyName:="param" & iCount.ToString()) = String.Empty)

                    iCount += 1

                End While

                Array.Resize(pParams, iCount + 1)

                If ((iCount - 1) >= 0) Then

                    For i As Byte = 0 To (iCount - 1)

                        pParams(i) = GetXML(DecryptedURL, KeyName:="param" & i.ToString())

                    Next

                End If

                Array.Resize(pValues, dgView.VisibleRowCount)

                For i As Integer = 0 To (dgView.VisibleRowCount - 1)

                    pValues(i) = hValues(dgView.GetRowValues(i, "Name"))

                Next

                pParams(pParams.Length - 1) = pValues

                Dim XRFile As String = String.Empty

                Dim XRTitle As String = GetDataText(GetXML(DecryptedURL, KeyName:="id"))

                If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                    XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), Server.MapPath(String.Empty), XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"), pParams)

                Else

                    XRFile = CreateReport(GetXML(DecryptedURL, KeyName:="SessionID"), GetXML(DecryptedURL, KeyName:="Group"), Server.MapPath(String.Empty), XRTitle, True, GetXML(DecryptedURL, KeyName:="openpwd"))

                End If

                If (File.Exists(XRFile)) Then

                    XRFile = XRFile.Replace(Server.MapPath(String.Empty) & "\", String.Empty).Replace("\", "/")

                    ASPxWebControl.RedirectOnCallback("reportsview.aspx?type=open&path=" & XRFile)

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(pValues)) Then pValues = Nothing

            If (Not IsNull(dtParams)) Then

                dtParams.Dispose()

                dtParams = Nothing

            End If

            If (Not IsNull(cReport)) Then

                cReport.Close()

                cReport.Dispose()

                cReport = Nothing

            End If

            If (Not IsNull(pParams)) Then pParams = Nothing

        End Try

    End Sub

    Private Sub dgView_HtmlRowCreated(ByVal sender As Object, ByVal e As ASPxGridViewTableRowEventArgs) Handles dgView.HtmlRowCreated

        If (e.RowType = GridViewRowType.Data) Then

            Dim objControl As Object = Nothing

            Dim phControl As PlaceHolder = Nothing

            Dim pValues() As String = Nothing

            Dim pName As String = String.Empty

            Try

                phControl = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Value"), GridViewDataColumn), "phControls"), PlaceHolder)

                pName = sender.GetRowValues(e.VisibleIndex, "Name").ToString()

                If (Not IsNull(phControl)) Then

                    Select Case sender.GetRowValues(e.VisibleIndex, "Type")

                        Case 0

                            objControl = Activator.CreateInstance(GetType(ASPxCheckBox))

                        Case 1

                            objControl = Activator.CreateInstance(GetType(ASPxDateEdit))

                        Case 2

                            objControl = Activator.CreateInstance(GetType(ASPxComboBox))

                        Case 3

                            objControl = Activator.CreateInstance(GetType(ASPxTextBox))

                    End Select

                    If (Not IsNull(objControl)) Then

                        phControl.Controls.Add(objControl)

                        Select Case sender.GetRowValues(e.VisibleIndex, "Type")

                            Case 0

                                If (hValues.Contains(pName)) Then

                                    objControl.Checked = hValues(pName)

                                Else

                                    hValues.Set(pName, False)

                                End If

                                objControl.ClientSideEvents.CheckedChanged = "function(s, e) { hValues.Set('" & pName & "', s.GetChecked()); }"

                            Case 1

                                If (hValues.Contains(pName)) Then

                                    objControl.Date = hValues(pName)

                                Else

                                    hValues.Set(pName, DateTime.Now)

                                End If

                                objControl.EditFormat = EditFormat.Custom

                                objControl.EditFormatString = GetArrayItem(Nothing, "eGeneral.DateFormat")

                                objControl.ClientSideEvents.DateChanged = "function(s, e) { hValues.Set('" & pName & "', s.GetValue()); }"

                            Case 2

                                objControl.EnableIncrementalFiltering = True

                                objControl.DropDownStyle = DropDownStyle.DropDown

                                objControl.Width = Unit.Pixel(250)

                                If (Not IsNull(sender.GetRowValues(e.VisibleIndex, "Values"))) Then

                                    pValues = sender.GetRowValues(e.VisibleIndex, "Values").ToString().Split(" ")

                                    For i As Integer = 0 To (pValues.Length - 1)

                                        objControl.Items.Add(pValues(i).ToString())

                                    Next

                                End If

                                If (hValues.Contains(pName)) Then

                                    objControl.Value = hValues(pName)

                                Else

                                    objControl.SelectedIndex = 0

                                    hValues.Set(pName, objControl.Value)

                                End If

                                objControl.ClientSideEvents.ValueChanged = "function(s, e) { hValues.Set('" & pName & "', s.GetValue()); }"

                            Case 3

                                objControl.Width = Unit.Pixel(250)

                                If (hValues.Contains(pName)) Then

                                    objControl.Text = hValues(pName)

                                Else

                                    hValues.Set(pName, String.Empty)

                                End If

                                objControl.ClientSideEvents.ValueChanged = "function(s, e) { hValues.Set('" & pName & "', s.GetValue()); }"

                        End Select

                    End If

                End If

            Catch ex As Exception

                WriteEventLog(ex)

            Finally

                If (Not IsNull(pValues)) Then pValues = Nothing

            End Try

        End If

    End Sub

#End Region

End Class