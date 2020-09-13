Imports System.Web.HttpUtility

Public Class timesheets1
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            Dim EncryptedURL As String = UrlEncode(CryptoEncrypt("<type=load><id=Timesheets><param0=" & Session("Managed").CompanyNum & "><param1=" & Session("Managed").EmployeeNum & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

            cmdPrint.Attributes.Add("onclick", "window.parent.lpPage.Show(); window.parent.frames[1].cpPage.PerformCallback('Print'); window.parent.frames[1].hPanel.Set('params', '" & EncryptedURL & "');")

            'select cast(newid() as nvarchar(36)) as [ID], [c].[EmployeeNum], (select isnull(isnull([PreferredName], [FirstName]), '') + ' ' + isnull([Surname], '') from [Personnel] where ([CompanyNum] = '<%PARAM[0]%>' and [EmployeeNum] = '<%PARAM[1]%>')) as [Name], getdate() as [Period], cast(datename(dw, [c].[ItemDate]) as nvarchar(3)) as [Day], [c].[ItemDate], (select [Text] from [TimesheetSetup] where ([Name] = 'Col1')) as [Name1], (select [Text] from [TimesheetSetup] where ([Name] = 'Col2')) as [Name2], (select [Text] from [TimesheetSetup] where ([Name] = 'Col3')) as [Name3], (select [Text] from [TimesheetSetup] where ([Name] = 'Col4')) as [Name4], (select [Text] from [TimesheetSetup] where ([Name] = 'Col5')) as [Name5], (select [Text] from [TimesheetSetup] where ([Name] = 'Col6')) as [Name6], (select [Text] from [TimesheetSetup] where ([Name] = 'Col7')) as [Name7], (select [Text] from [TimesheetSetup] where ([Name] = 'Col8')) as [Name8], [c].[Col1], [c].[Col2], [c].[Col3], [c].[Col4], [c].[Col5], [c].[Col6], [c].[Col7], [c].[Col8] from [Timesheets] as [p] right outer join [TimesheetChildEntries] as [c] on [p].[CompanyNum] = [c].[CompanyNum] and [p].[EmployeeNum] = [c].[EmployeeNum] and [p].[Start] = [c].[Start] and [p].[Until] = [c].[Until] and [p].[Type] = [c].[Type] where ([p].[CompanyNum] = '<%PARAM[0]%>' and [p].[EmployeeNum] = '<%PARAM[1]%>' and (([p].[Start] >= convert(nvarchar(7), getdate(), 120) + '-01 00:00:00' and [p].[Start] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + '-01 00:00:00') or ([p].[Until] >= convert(nvarchar(7), getdate(), 120) + '-01 00:00:00' and [p].[Until] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + '-01 00:00:00'))) order by [c].[ItemDate], [c].[ItemName]

        End If

    End Sub

#End Region

End Class