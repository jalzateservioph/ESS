Imports System.IO
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports CrystalDecisions.Web
Imports CrystalDecisions.ReportSource
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.ReportAppServer
Imports System.Threading

Public Class prReportViewer
    Inherits System.Web.UI.Page

    Public rdoc As New ReportDocument()
    Public name As String = ""
    Private UDetails As Users = Nothing
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        div.Visible = False
        UDetails = GetUserDetails(Session, "TWS Reports", True)
        lblusersname.Text = UDetails.Name + " " + UDetails.Surname
        If IsCallback Then
            ' Intentionally pauses server-side processing, 
            ' to demonstrate the Loading Panel functionality.
            Thread.Sleep(500)
        End If
        LoadingPanel.ContainerElementID = If(False, "Panel", "")
        If Not IsPostBack Then
            If (Not Session("pryear") Is Nothing) Then
                lblAsOf.Text = Session("prAsOf")
                lblHireDate.Text = Session("prHireDate")
                lblyear.Text = Session("prYear")
                lblReportType.Text = Session("prReportType")
                lblRatingType.Text = Session("prRatingType")
                lblFilter.Text = Session("prFilterDesc")

            End If
            If (lblReportType.Text = "0") Then
                reportupdateforPerformance()
            Else
                reportupdateforPromotions()

            End If
        Else

        End If
    End Sub
    Sub reportupdateforPerformance()

        Dim servers As String
        Dim database As String
        Dim username As String
        Dim password As String

        With SQLServer
            servers = .Server
            database = .Database
            username = .Username
            password = .Password
        End With
        rdoc.Load(Server.MapPath("~/prMidEnd.rpt").ToString(), OpenReportMethod.OpenReportByDefault)

        Dim crtableLogoninfos As New TableLogOnInfos()
        Dim crtableLogoninfo As New TableLogOnInfo()
        Dim crConnectionInfo As New ConnectionInfo()
        Dim Crtables As Tables

        crConnectionInfo.ServerName = servers
        crConnectionInfo.DatabaseName = database
        crConnectionInfo.UserID = username
        crConnectionInfo.Password = password

        Crtables = rdoc.Database.Tables

        For Each Crtable As CrystalDecisions.CrystalReports.Engine.Table In Crtables
            crtableLogoninfo = Crtable.LogOnInfo
            crtableLogoninfo.ConnectionInfo = crConnectionInfo
            Crtable.ApplyLogOnInfo(crtableLogoninfo)

        Next

        rViewer.ReportSource = rdoc

        If (lblRatingType.Text = "0") Then

            'rdoc.SetParameterValue("@dec", 12)
            'rdoc.SetParameterValue("@jun", 6)
            name = "Midyear Performance Appraisal Report"

        Else

            'rdoc.SetParameterValue("@dec", 6)
            'rdoc.SetParameterValue("@jun", 12)
            name = "Yearend Performance Appraisal Report"

        End If

        rdoc.SetDatabaseLogon(username, password, servers, database)

        rdoc.SetParameterValue("@years", Convert.ToInt32(lblyear.Text))
        rdoc.SetParameterValue("@hiredate", Convert.ToDateTime(lblHireDate.Text))
        rdoc.SetParameterValue("@asof", Convert.ToDateTime(lblAsOf.Text))
        rdoc.SetParameterValue("@filter", lblFilter.Text)
        rdoc.SetParameterValue("@FullName", lblusersname.Text)

        If (lblRatingType.Text = "0") Then

            rdoc.SetParameterValue("@JUN", 0)
            rdoc.SetParameterValue("@DEC", 1)

        Else

            rdoc.SetParameterValue("@JUN", 1)
            rdoc.SetParameterValue("@DEC", 0)

        End If
    End Sub

    Sub reportupdateforPromotions()
        Dim servers As String
        Dim database As String
        Dim username As String
        Dim password As String

        With SQLServer
            servers = .Server
            database = .Database
            username = .Username
            password = .Password
        End With


        rdoc.Load(Server.MapPath("~/prPromotions.rpt").ToString(), OpenReportMethod.OpenReportByDefault)


        Dim crtableLogoninfos As New TableLogOnInfos()
        Dim crtableLogoninfo As New TableLogOnInfo()
        Dim crConnectionInfo As New ConnectionInfo()
        Dim Crtables As Tables

        crConnectionInfo.ServerName = servers
        crConnectionInfo.DatabaseName = database
        crConnectionInfo.UserID = username
        crConnectionInfo.Password = password

        Crtables = rdoc.Database.Tables

        For Each Crtable As CrystalDecisions.CrystalReports.Engine.Table In Crtables
            crtableLogoninfo = Crtable.LogOnInfo
            crtableLogoninfo.ConnectionInfo = crConnectionInfo
            Crtable.ApplyLogOnInfo(crtableLogoninfo)

        Next
        rViewer.ReportSource = rdoc

        rdoc.SetDatabaseLogon(username, password, servers, database)
        rdoc.SetParameterValue("@years", Convert.ToInt32(lblyear.Text))
        rdoc.SetParameterValue("@hiredate", Convert.ToDateTime(lblHireDate.Text))
        rdoc.SetParameterValue("@asof", Convert.ToDateTime(lblAsOf.Text))
        rdoc.SetParameterValue("@filter", lblFilter.Text)
        rdoc.SetParameterValue("@fullName", lblusersname.Text)
        name = "Promotions Report"
    End Sub
    Protected Sub rViewer_DataBinding(sender As Object, e As EventArgs) Handles rViewer.DataBinding
        If (lblReportType.Text = "0") Then
            reportupdateforPerformance()
        Else
            reportupdateforPromotions()

        End If
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("prReports.aspx")
    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        Try
            LoadingPanel.ContainerElementID = If(True, "Panel", "")
            ASPxButton1.Enabled = False
            Response.Buffer = False
            Response.ClearContent()
            Response.ClearHeaders()
            If (cbExport.SelectedIndex = 0) Then
                rdoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, True, name)
            ElseIf (cbExport.SelectedIndex = 1) Then
                rdoc.ExportToHttpResponse(ExportFormatType.RichText, Response, True, name)
            ElseIf (cbExport.SelectedIndex = 2) Then
                rdoc.ExportToHttpResponse(ExportFormatType.CharacterSeparatedValues, Response, True, name)
            ElseIf (cbExport.SelectedIndex = 3) Then
                rdoc.ExportToHttpResponse(ExportFormatType.Excel, Response, True, name)
            ElseIf (cbExport.SelectedIndex = 4) Then
                rdoc.ExportToHttpResponse(ExportFormatType.ExcelWorkbook, Response, True, name)

            End If
            Response.End()
            LoadingPanel.ContainerElementID = If(False, "Panel", "")
        Catch ex As Exception
        Finally
            ASPxButton1.Enabled = True
        End Try
    End Sub
    
End Class