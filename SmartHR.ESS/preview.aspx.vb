Public Partial Class preview
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (Not IsNull(Request.QueryString("ID"))) Then ltHtml.Text = ReplaceKeys(Request.QueryString("ID"), Session("BulkEmail.Body"))

        End If

    End Sub

#End Region

End Class