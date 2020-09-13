<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="conditions.aspx.vb" Inherits="SmartHR.conditions" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_conditions" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabTraining" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Change">
                            <TabImage Url="images/training_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxrp:ASPxRoundPanel ID="pnlConditions" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <table style="padding: 0px; width: 100%">
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblWorkflow" runat="server" Text="Workflow" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbWorkflow" runat="server" ClientInstanceName="cmbWorkflow" DropDownStyle="DropDownList">
                                                                <ClientSideEvents EndCallback="function(s, e) { if (s.GetValue() != s.cpValue) { s.SetValue(s.cpValue); } }" />
                                                                <Items>
                                                                    <dxe:ListEditItem Value="0" Text="<select>" />
                                                                    <dxe:ListEditItem Value="1" Text="Grade: 1 to 6" />
                                                                    <dxe:ListEditItem Value="2" Text="Grade: General" />
                                                                    <dxe:ListEditItem Value="3" Text="Grade: Act on behalf of" />
                                                                </Items>
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left"></td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="height: 3px" />
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblDeptName" runat="server" Text="SBU" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbDeptName" runat="server" ClientInstanceName="cmbDeptName" DataSourceID="dsDeptName" TextField="DeptName" ValueField="DeptName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblIndividualJobTitle" runat="server" Text="Section" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbIndividualJobTitle" runat="server" ClientInstanceName="cmbIndividualJobTitle" DataSourceID="dsIndividualJobTitle" TextField="IndividualJobTitle" ValueField="IndividualJobTitle" DropDownStyle="DropDown" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="height: 3px" />
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblJobTitle" runat="server" Text="Occupation" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbJobTitle" runat="server" ClientInstanceName="cmbJobTitle" DataSourceID="dsJobTitle" TextField="JobTitle" ValueField="JobTitle" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblJobGrade" runat="server" Text="Grade" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbJobGrade" runat="server" ClientInstanceName="cmbJobGrade" DataSourceID="dsJobGrade" TextField="JobGrade" ValueField="JobGrade" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="height: 3px" />
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblWorkWeek" runat="server" Text="5/6 Day Worker" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxTextBox ID="txtWorkWeek" runat="server" Width="75px" ClientInstanceName="txtShiftType">
                                                                <ClientSideEvents TextChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblShiftType" runat="server" Text="Shift Type" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbShiftType" runat="server" ClientInstanceName="cmbShiftType" DataSourceID="dsShiftType" TextField="ShiftType" ValueField="ShiftType" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="height: 3px" />
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblCostCentre" runat="server" Text="Cost Centre" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbCostCentre" runat="server" ClientInstanceName="cmbCostCentre" DataSourceID="dsCostCentre" TextField="CostCentre" ValueField="CostCentre" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left"></td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"><br /></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblStartDate" runat="server" Text="Effective From" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxDateEdit ID="dteStart" runat="server" ClientInstanceName="dteStart">
                                                                <ClientSideEvents DateChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxDateEdit>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblUntilDate" runat="server" Text="Effective Until" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxDateEdit ID="dteUntil" runat="server" ClientInstanceName="dteUntil">
                                                                <ClientSideEvents DateChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxDateEdit>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"><br /></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblReason" runat="server" Text="Reason for Change" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbReason" runat="server" ClientInstanceName="cmbReason" DataSourceID="dsReason" TextField="Remark" ValueField="Remark" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbWorkflow.PerformCallback(null); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                        <td style="width: 135px; text-align: right"></td>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 260px; text-align: left"></td>
                                                        <td />
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="height: 3px" />
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 135px; text-align: right; vertical-align: top"><dxe:ASPxLabel ID="lblComments" runat="server" Text="Comments (optional):" /></td>
                                                        <td />
                                                        <td colspan="5" style="text-align: left"><dxe:ASPxMemo runat="server" ID="txtNotes" Rows="5" Width="100%" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"><br /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" style="text-align: center">
                                                            <div class="centered" style="width: 80px">
                                                                <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                                                </dxe:ASPxButton>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                        <HeaderTemplate>
                                            <table style="height: 16px; width: 100%">
                                                <tr valign="middle">
                                                    <td style="width: 20px">
                                                        <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/conditions_001.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel" runat="server" Text="Basic Conditions" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="History">
                            <TabImage Url="images/training_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports" runat="server" GridViewID="dgView" />
                                    <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False" >
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="PathID" VisibleIndex="0" Visible="false" />
                                            <dxwgv:GridViewDataDateColumn FieldName="Start" Caption="Start" SortIndex="1" SortOrder="Descending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataDateColumn FieldName="Until" Caption="Until" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Caption="Value" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ValueF" Caption="Changed From" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ValueT" Caption="Changed To" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="6" Width="16px">
                                                <CellStyle Paddings-PaddingTop="5px" />
                                                <DataItemTemplate>
                                                    <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="View Report" ImageUrl="images/select.png" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                </DataItemTemplate>
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsBehavior AutoExpandAllGroups="true" />
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
                                                            <dxm:ASPxMenu ID="mnuExport" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport" Text="Export to">
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsCostCentre" runat="server" />
            <asp:SqlDataSource ID="dsDeptName" runat="server" />
            <asp:SqlDataSource ID="dsIndividualJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsJobGrade" runat="server" />
            <asp:SqlDataSource ID="dsJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsReason" runat="server" />
            <asp:SqlDataSource ID="dsShiftType" runat="server" />
        </form>
    </body>
</html>