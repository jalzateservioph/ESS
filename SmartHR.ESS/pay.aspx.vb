Imports System.Web.HttpUtility

Partial Public Class pay
    Inherits System.Web.UI.Page

    Private ShowRemarks As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        If (Not Session("ChipnPin")) Then

            Dim mobile As String = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] = '" & Session("LoggedOn").CompanyNum & "' and [EmployeeNum] = '" & Session("LoggedOn").EmployeeNum & "')", "CellTel")

            If (Not IsNull(mobile)) Then

                Dim GeneratedPin As String = CreatePin(5)

                Dim dteSent As Date = Now

                Session("ChipCount") += 1

                If (Session("ChipCount") = 1) Then

                    Session("ChipnPinSentAt") = dteSent

                    SendSMS(mobile, "Your one time password is " & GeneratedPin & " (keep this pin safe as you will need it to open the document) - if you have any queries please contact your HR department.")

                    ExecSQL("update [Users] set [ChipnPin] = '" & GeneratedPin & "', [ChipnPinSent] = '" & dteSent.ToString("yyyy-MM-dd HH:mm:ss") & "' where ([Username] = '" & Session("LoggedOn").UserID & "')")

                End If

            End If

            Response.Redirect("chipnpin.aspx?url=pay.aspx")

            Exit Sub

        End If

        UDetails = GetUserDetails(Session, "Pay History Tab")

        With UDetails

            Select Case tabFinance.ActiveTabIndex

                Case 0
                    LoadExpGrid(Session, dgView_001, "Pay History Tab", "<Tablename=Pay><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120)><Columns=[DateFrom], [Salary], [Rate], [RateUnit], [TemplateName], convert(nvarchar(19), [DateFrom], 120) as [Date]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay." & Session.SessionID)

                Case 1
                    LoadExpGrid(Session, dgView_002, "Pay History Tab", "<Tablename=PensionSchemeHistory><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [PensionScheme] + ' ' + convert(nvarchar(19), [DateJoined], 120)><Columns=[PensionScheme], [DateJoined], [DateLeft], [MembershipNum], [CompPercent], [EmplPercent], [BenefitVal], [BenefitValDate], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay.Pension." & Session.SessionID)

                Case 2
                    LoadExpGrid(Session, dgView_003, "Pay History Tab", "<Tablename=MedicalSchemeHistory><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [MedicalScheme] + ' ' + convert(nvarchar(19), [DateJoined], 120)><Columns=[MedicalScheme], [DateJoined], [DateLeft], [MembershipNum], [CompPercent], [EmplPercent], case [MedSavingsAcct] when 1 then 'Yes' else 'No' end as [MedSavingsAcct], case [Vitality] when 1 then 'Yes' else 'No' end as [Vitality], [Dependants], [AdultDependants], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay.Medical." & Session.SessionID)

            End Select

        End With

    End Sub

    Private Sub dgView_002_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_002.CustomJSProperties, dgView_003.CustomJSProperties

        e.Properties("cpShow") = ShowRemarks
        e.Properties("cpRemarks") = txtRemarks_History.Text

    End Sub

    Private Sub dgView_002_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_002.CustomButtonCallback, dgView_003.CustomButtonCallback

        txtRemarks_History.Text = sender.GetRowValues(e.VisibleIndex, "Comments").ToString()

        ShowRemarks = True

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim GeneratedPin As String = String.Empty

        Dim dChipnPin As DataTable = GetSQLDT("select [ChipnPin], [ChipnPinSent] from [Users] where ([Username] = '" & Session("LoggedOn").UserID & "')")

        If (IsData(dChipnPin)) Then

            GeneratedPin = dChipnPin.Rows(0).Item("ChipnPin").ToString()

            dChipnPin.Dispose()

        End If

        dChipnPin = Nothing

        Dim EncryptedURL As String = UrlEncode(CryptoEncrypt("<type=load><id=Pay Report><openpwd=" & GeneratedPin & "><param0=" & UDetails.CompanyNum & "><param1=" & UDetails.EmployeeNum & "><param2=" & Container.Grid.GetRowValues(Container.VisibleIndex, "Date").ToString() & "><param3=" & Container.Grid.GetRowValues(Container.VisibleIndex, "TemplateName").ToString() & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function

#End Region

End Class