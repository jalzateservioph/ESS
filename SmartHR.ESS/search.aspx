<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="search.aspx.vb" Inherits="SmartHR.search" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_search" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    var response = e.result.split('\ ');
                    switch(response[0]) {
                        case 'Back': case 'Next': {
                                tabSearch.SetActiveTab(tabSearch.GetTab(parseInt(response[1])));
                            };
                            break;
                        case 'Submit': {
                                if (response[1] == 'success') {
                                    window.parent.location.href = 'index.aspx';
                                }
                            };
                            break;
                    };
                    window.parent.reset();
                }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabSearch" runat="server" ClientInstanceName="tabSearch" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Search">
                            <TabImage Url="images/search_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <br />
                                    <div style="float: right">
                                        <img id="btnClear_001" src="images/clear.png" onclick="ASPxClientEdit.ClearEditorsInContainerById('_bulksms'); txtEmployeeNum.Focus();" style="cursor: pointer" />
                                    </div>
                                    <br />
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="text-align: right"><strong>Personal</strong></td>
                                            <td colspan="5"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Employee number</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtEmployeeNum" runat="server" Width="125px" ClientInstanceName="txtEmployeeNum" /></td>
                                            <td colspan="3" />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Name</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtName" runat="server" Width="100%" ClientInstanceName="txtName" /></td>
                                            <td style="text-align: right">Surname</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtSurname" runat="server" Width="100%" ClientInstanceName="txtSurname" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Gender</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbSex" runat="server" ClientInstanceName="cmbSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right">ID number</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtIDNum" runat="server" Width="100%" ClientInstanceName="txtIDNum" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><strong>Organizational</strong></td>
                                            <td colspan="5"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Job title</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbJobTitle" runat="server" ClientInstanceName="cmbJobTitle" DataSourceID="dsJobTitle" TextField="JobTitle" ValueField="JobTitle" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right">Job grade</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbJobGrade" runat="server" ClientInstanceName="cmbJobGrade" DataSourceID="dsJobGrade" TextField="JobGrade" ValueField="JobGrade" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Cost centre</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbCostCentre" runat="server" ClientInstanceName="cmbCostCentre" DataSourceID="dsCostCentre" TextField="CostCentre" ValueField="CostCentre" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right">Department</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbDeptName" runat="server" ClientInstanceName="cmbDeptName" DataSourceID="dsDeptName" TextField="DeptName" ValueField="DeptName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Appointment Date</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteAppointmentFrom" runat="server" ClientInstanceName="dteAppointmentFrom" /></td>
                                            <td style="text-align: right">Position</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtPosition" runat="server" Width="100%" ClientInstanceName="txtPosition" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Appointment type</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbAppointype" runat="server" ClientInstanceName="cmbAppointype" DataSourceID="dsAppointype" TextField="AppointmentType" ValueField="AppointmentType" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right">Location</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbLocation" runat="server" ClientInstanceName="cmbLocation" DataSourceID="dsLocation" TextField="Location" ValueField="Location" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 10px" />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Terminated?</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left" colspan="4"><dxe:ASPxCheckBox ID="chkTermination" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Termination Date</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteTerminationFrom" runat="server" ClientInstanceName="dteTerminationFrom" /></td>
                                            <td style="text-align: right">Termination Reason</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbTerminationReason" runat="server" ClientInstanceName="cmbTerminationReason" DataSourceID="dsTerminationReason" TextField="TerminationReason" ValueField="TerminationReason" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="width: 95px">
                                                <img id="btnNext_001" src="images/next.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Next');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Results">
                            <TabImage Url="images/search_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="3" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="4" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Visible="False" VisibleIndex="7" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="True" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_002" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_002" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="text-align: left; width: 105px">
                                                <img id="btnBack_002" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                                            </td>
                                            <td style="width: 95px">
                                                <img id="btnSubmit_002" src="images/submit.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Submit');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    txtEmployeeNum.Focus();
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsAppointype" runat="server" />
            <asp:SqlDataSource ID="dsCostCentre" runat="server" />
            <asp:SqlDataSource ID="dsDeptName" runat="server" />
            <asp:SqlDataSource ID="dsJobGrade" runat="server" />
            <asp:SqlDataSource ID="dsJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsLocation" runat="server" />
            <asp:SqlDataSource ID="dsSex" runat="server" />
            <asp:SqlDataSource ID="dsTerminationReason" runat="server" />
        </form>
    </body>
</html>