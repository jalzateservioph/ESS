Imports System.Web.HttpUtility

Partial Public Class financial
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

                    SendSMS(mobile, "Your one time password is " & GeneratedPin & " - if you have any queries please contact your HR department.")

                    ExecSQL("update [Users] set [ChipnPin] = '" & GeneratedPin & "', [ChipnPinSent] = '" & dteSent.ToString("yyyy-MM-dd HH:mm:ss") & "' where ([Username] = '" & Session("LoggedOn").UserID & "')")

                End If

            End If

            Response.Redirect("chipnpin.aspx?url=financial.aspx")

            Exit Sub

        End If

        UDetails = GetUserDetails(Session, "Pay History Tab")

        With UDetails

            Select Case tabFinance.ActiveTabIndex

                Case 0
                    LoadExpGrid(Session, dgView_001, "Pay History Tab", "<Tablename=Pay><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120)><Columns=[DateFrom], [Val0], [Val1], [Val2]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay." & Session.SessionID)

                Case 1
                    LoadExpGrid(Session, dgView_002, "Pay History Tab", "<Tablename=LTIPTableData><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120)><Columns=[DateFrom], [LTIPproduct], [LTIPissuedate], [LTIPtransactiontype], [LTIPquantity], [LTIPwhatwasgiven], [LTIPwhathasbeentaken], [LTIPdistribution], [LTIPcurrentvalue]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay.LTIP." & Session.SessionID)

                Case 2
                    LoadExpGrid(Session, dgView_003, "Pay History Tab", "<Tablename=PensionSchemeHistory><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [PensionScheme] + ' ' + convert(nvarchar(19), [DateJoined], 120)><Columns=[PensionScheme], [DateJoined], [DateLeft], [MembershipNum], [CompPercent], [EmplPercent], [BenefitVal], [BenefitValDate], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay.Pension." & Session.SessionID)

                Case 3
                    LoadExpGrid(Session, dgView_004, "Pay History Tab", "<Tablename=MedicalSchemeHistory><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [MedicalScheme] + ' ' + convert(nvarchar(19), [DateJoined], 120)><Columns=[MedicalScheme], [DateJoined], [DateLeft], [MembershipNum], [CompPercent], [EmplPercent], case [MedSavingsAcct] when 1 then 'Yes' else 'No' end as [MedSavingsAcct], case [Vitality] when 1 then 'Yes' else 'No' end as [Vitality], [Dependants], [AdultDependants], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Pay.Medical." & Session.SessionID)

            End Select

        End With

    End Sub

    Private Sub dgView_003_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_003.CustomJSProperties, dgView_004.CustomJSProperties

        e.Properties("cpShow") = ShowRemarks
        e.Properties("cpRemarks") = txtRemarks_History.Text

    End Sub

    Private Sub dgView_003_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_003.CustomButtonCallback, dgView_004.CustomButtonCallback

        txtRemarks_History.Text = sender.GetRowValues(e.VisibleIndex, "Comments").ToString()

        ShowRemarks = True

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim EncryptedURL As String = UrlEncode(CryptoEncrypt("<Tablename=LTIPTableData><FieldType=lTipFile_Type><FieldData=lTipFile><param0=[Name=CompanyNum][Value=" & UDetails.CompanyNum & "]><param1=[Name=EmployeeNum][Value=" & UDetails.EmployeeNum & "]><param2=[Name=DateFrom][Value=" & Container.Grid.GetRowValues(Container.VisibleIndex, "DateFrom").ToString() & "]><param3=[Name=LTIPproduct][Value=" & Container.Grid.GetRowValues(Container.VisibleIndex, "LTIPproduct").ToString() & "]>", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Dim ReturnText As String = "function(s, e) { window.open('getfile.aspx?params=" & EncryptedURL & "', 'open'); }"

        If (IsNull(GetSQLField("select [lTipFile_Type] from [LTIPTableData] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120) + ' ' + [LTIPproduct] = '" & UDetails.CompanyNum & " " & UDetails.EmployeeNum & " " & Convert.ToDateTime(Container.Grid.GetRowValues(Container.VisibleIndex, "DateFrom")).ToString("yyyy-MM-dd HH:mm:ss") & " " & Container.Grid.GetRowValues(Container.VisibleIndex, "LTIPproduct").ToString() & "')", "lTipFile_Type"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (Not IsNull(GetSQLField("select [lTipFile_Type] from [LTIPTableData] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120) + ' ' + [LTIPproduct] = '" & UDetails.CompanyNum & " " & UDetails.EmployeeNum & " " & Convert.ToDateTime(Container.Grid.GetRowValues(Container.VisibleIndex, "DateFrom")).ToString("yyyy-MM-dd HH:mm:ss") & " " & Container.Grid.GetRowValues(Container.VisibleIndex, "LTIPproduct").ToString() & "')", "lTipFile_Type"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (IsNull(GetSQLField("select [lTipFile_Type] from [LTIPTableData] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [DateFrom], 120) + ' ' + [LTIPproduct] = '" & UDetails.CompanyNum & " " & UDetails.EmployeeNum & " " & Convert.ToDateTime(Container.Grid.GetRowValues(Container.VisibleIndex, "DateFrom")).ToString("yyyy-MM-dd HH:mm:ss") & " " & Container.Grid.GetRowValues(Container.VisibleIndex, "LTIPproduct").ToString() & "')", "lTipFile_Type"))) Then ReturnText = "no file attached"

        Return ReturnText

    End Function

#End Region

End Class