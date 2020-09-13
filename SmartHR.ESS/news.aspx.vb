Public Partial Class news
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (IsGuid(Request.QueryString("ID"))) Then ltHtml.Text = GetSQLField("select [Article] from [ess.News] where ([ID] = '" & Request.QueryString("ID") & "')", "Article")

        End If

    End Sub

#End Region

End Class