Public Class contacts1
    Inherits System.Web.UI.Page

#Region " *** Web Form Functions *** "

    Private Sub SetTools(ByVal Template As String)

        tb_email.Visible = GetArrayItem(Template, "eGeneral.ShowEmail")

        tb_sms.Visible = GetArrayItem(Template, "eGeneral.ShowSMS")

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        SetTools(Session("Managed").Template)

        If (GetArrayItem(Nothing, "eSecurity.ADEnabled")) AndAlso (Not IsNull(GetArrayItem(Nothing, "eSecurity.ADServer")) AndAlso GetArrayItem(Nothing, "eSecurity.ADLogon")) Then cmdSignout.Visible = False

    End Sub

#End Region

End Class