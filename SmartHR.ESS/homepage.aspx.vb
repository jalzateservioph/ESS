Imports System.IO

Partial Public Class homepage
    Inherits System.Web.UI.Page

    Private UDetails As Users = Nothing

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Tasks")

        rptEmployee.DataSource = GetSQLDT("select [ID], [OrderID], [ItemImage], [Description], [LoadURL], [TemplateElement], [LoggedOnUser], [HomeType], [HomeImage], [HomeDescription], [HomeTooltip] from [ess.Menu] where (not [HomeType] = 255 and [Visible] = 1) order by [OrderID]", "Data.Menu.Home")

        rptEmployee.DataBind()

        ncNewsItems.DataSource = GetSQLDT("select [ID] as [CompositeKey], [Title], [Summary], [Date], [ImageUrl], [Article] from [ess.News] order by [Date] desc", "Data.NewsLU")

        ncNewsItems.DataBind()

    End Sub

    Private Sub rptEmployee_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptEmployee.ItemDataBound

        Dim SecElements As String = String.Empty

        Dim bView As Boolean

        SecElements = GetSecurity(Session, e.Item.DataItem.Item("TemplateElement").ToString())

        Boolean.TryParse(GetXML(SecElements, KeyName:="fView"), bView)

        Dim URL As String = e.Item.DataItem.Item("LoadURL").ToString()

        If (bView AndAlso Not Regex.IsMatch(URL, "^https?://", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then

            Dim pFile() As String = Nothing

            Dim pFilename As String = String.Empty

            pFile = URL.Split("?")

            pFile(0) = Path.GetFileName(Server.MapPath(pFile(0)))

            pFilename = Regex.Replace(pFile(0), "\.aspx", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

            If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & pFile(0))) Then

                If (pFile.GetLength(0) > 1) Then

                    pFilename &= ".aspx?" & pFile(1) & " tools/" & pFile(0)

                Else

                    pFilename &= Regex.Replace(" tools/" & pFile(0), "\.aspx", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                End If

            Else

                If (pFile.GetLength(0) > 1) Then

                    pFilename &= ".aspx?" & pFile(1) & " tools/index.aspx"

                Else

                    pFilename &= " tools/index"

                End If

            End If

            CType(e.Item.FindControl("divEmployee"), HtmlControls.HtmlContainerControl).Attributes.Add("onclick", "window.parent.postUrl('" & pFilename & "', true);")

            CType(e.Item.FindControl("imgEmployeeItem"), DevExpress.Web.ASPxEditors.ASPxImage).ImageUrl = e.Item.DataItem.Item("HomeImage").ToString()

            CType(e.Item.FindControl("lblEmployeeTitle"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = e.Item.DataItem.Item("Description").ToString()

            CType(e.Item.FindControl("lblEmployeeItem"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = e.Item.DataItem.Item("HomeDescription").ToString()

        End If

        e.Item.Visible = bView

    End Sub

#End Region

End Class