Public Class employee1
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (GetArrayItem(Nothing, "eSecurity.ADEnabled")) AndAlso (Not IsNull(GetArrayItem(Nothing, "eSecurity.ADServer")) AndAlso GetArrayItem(Nothing, "eSecurity.ADLogon")) Then cmdSignout.Visible = False

    End Sub

#End Region

End Class