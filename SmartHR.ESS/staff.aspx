<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="staff.aspx.vb" Inherits="SmartHR.staff" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_staff" runat="server">
            <dxpc:ASPxPopupControl ID="pcLegend" runat="server" ClientInstanceName="pcLegend" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Application Legend">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div class="centered" style="width: 250px">
                            <asp:Table ID="tblLegend" runat="server" Width="100%">
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>
                                        <asp:Table ID="tblColorKeys" runat="server" Font-Bold="true" ForeColor="#ffffff" Width="225px">
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#1e90ff">New</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#5f9ea0">Pending</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#32cd32">Approved</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#dc143c">Declined</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#996600">Cancelled</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                <asp:TableCell BackColor="#696969">Public Holiday</asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dxe:ASPxButton ID="cmdOK_Legend" runat="server" ClientInstanceName="cmdOK_Legend" Text="OK" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcLegend.Hide(); }" />
                            </dxe:ASPxButton>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { cmdOK_Legend.Focus(); }" />
                <HeaderStyle Font-Bold="true" />
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxcp:ASPxCallbackPanel ID="cpPage" runat="server" ClientInstanceName="cpPage" HideContentOnCallback="false" ShowLoadingPanel="false">
                    <ClientSideEvents EndCallback="function(s, e) {
                                                        window.parent.reset();
                                                    }" />
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxhf:ASPxHiddenField ID="values" runat="server" ClientInstanceName="values" />
                            <dxrp:ASPxRoundPanel ID="pnlStaffLocator" runat="server" ClientInstanceName="pnlStaffLocator" Width="100%">
                                <PanelCollection>
                                    <dxp:PanelContent runat="server">
                                        <dxp:ASPxPanel ID="pnlFilter" runat="server" ClientInstanceName="pnlFilter" Width="100%">
                                            <PanelCollection>
                                                <dxp:PanelContent runat="server">
                                                    <table style="padding: 0px; width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">Category</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbCategory" runat="server" ClientInstanceName="cmbCategory" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { values.Set('Category', s.GetSelectedIndex()); }" />
                                                                    <Items>
                                                                        <dxe:ListEditItem Text="Leave Module" Value="0" Selected="true" />
                                                                        <dxe:ListEditItem Text="Training Module" Value="1" />
                                                                    </Items>
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                            <td style="text-align: right">Data Range</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbDateRange" runat="server" ClientInstanceName="cmbDateRange" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { values.Set('DateRange', s.GetSelectedIndex()); }" />
                                                                    <Items>
                                                                        <dxe:ListEditItem Text="14 Days" Value="0" Selected="true" />
                                                                        <dxe:ListEditItem Text="1 Month" Value="1" />
                                                                        <dxe:ListEditItem Text="2 Months" Value="2" />
                                                                        <dxe:ListEditItem Text="* Own date selection" Value="3" />
                                                                    </Items>
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">From</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxDateEdit ID="deFrom" runat="server" ClientInstanceName="deFrom">
                                                                    <ClientSideEvents DateChanged="function(s, e) { values.Set('DateFrom', deFrom.GetDate()); }" />
                                                                </dxe:ASPxDateEdit>
                                                            </td>
                                                            <td style="text-align: right">Until</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxDateEdit ID="deUntil" runat="server" ClientInstanceName="deUntil">
                                                                    <ClientSideEvents DateChanged="function(s, e) { values.Set('DateUntil', deUntil.GetDate()); }" />
                                                                </dxe:ASPxDateEdit>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6">
                                                                <br />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: center">
                                                                <img id="btnSubmit" src="images/submit.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Submit\ ' + cmbCategory.GetValue() + '\ ' + cmbDateRange.GetValue() + '\ ' + deFrom.GetDate().toString() + '\ ' + deUntil.GetDate().toString());" style="cursor: pointer" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dxp:PanelContent>
                                            </PanelCollection>
                                        </dxp:ASPxPanel>
                                        <dxp:ASPxPanel ID="pnlResults" runat="server" ClientInstanceName="pnlResults" Width="100%" Visible="false">
                                            <PanelCollection>
                                                <dxp:PanelContent runat="server">
                                                    <table style="padding: 0px; width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">Type</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbType" runat="server" ClientInstanceName="cmbType" Width="250px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsTypes" TextField="Type" ValueField="Type">
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit\ ' + cmbCategory.GetValue() + '\ ' + cmbDateRange.GetValue() + '\ ' + deFrom.GetDate().toString() + '\ ' + deUntil.GetDate().toString()); }" />
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                            <td style="text-align: right">Status</td>
                                                            <td style="width: 10px" />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbStatus" runat="server" ClientInstanceName="cmbStatus" Width="250px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsStatus" TextField="Status" ValueField="Status">
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit\ ' + cmbCategory.GetValue() + '\ ' + cmbDateRange.GetValue() + '\ ' + deFrom.GetDate().toString() + '\ ' + deUntil.GetDate().toString()); }" />
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                            <td style="width: 10px" />
                                                            <td style="float: right">
                                                                <dxe:ASPxButton ID="cmdLegend" runat="server" Text="View legend" Width="125px" AutoPostBack="False">
                                                                    <ClientSideEvents Click="function(s, e) { pcLegend.Show(); }" />
                                                                </dxe:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <dxp:ASPxPanel ID="pnlNoData" runat="server" ClientInstanceName="pnlNoData" Width="100%" Visible="false">
                                                        <PanelCollection>
                                                            <dxp:PanelContent runat="server">
                                                                <p style="text-align: center">No data to display</p>
                                                            </dxp:PanelContent>
                                                        </PanelCollection>
                                                    </dxp:ASPxPanel>
                                                    <dxp:ASPxPanel ID="pnlData" runat="server" ClientInstanceName="pnlData" Width="100%" Visible="false">
                                                        <PanelCollection>
                                                            <dxp:PanelContent runat="server">
                                                                <asp:Repeater ID="rptItems" runat="server">
                                                                    <ItemTemplate>
                                                                        <asp:PlaceHolder ID="phControls_Rows" runat="server" Visible="true" />
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </dxp:PanelContent>
                                                        </PanelCollection>
                                                    </dxp:ASPxPanel>
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <img id="btnBack" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dxp:PanelContent>
                                            </PanelCollection>
                                        </dxp:ASPxPanel>
                                    </dxp:PanelContent>
                                </PanelCollection>
                                <HeaderTemplate>
                                    <table style="height: 16px; width: 100%">
                                        <tr valign="middle">
                                            <td style="width: 20px">
                                                <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/staff_001.png" />
                                            </td>
                                            <td>
                                                <dxe:ASPxLabel id="lblPanel" runat="server" Text="Staff Locator" />
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                            </dxrp:ASPxRoundPanel>
                        </dxp:PanelContent>
                    </PanelCollection>
                </dxcp:ASPxCallbackPanel>
            </div>
            <asp:SqlDataSource ID="dsTypes" runat="server" />
            <asp:SqlDataSource ID="dsStatus" runat="server" />
        </form>
    </body>
</html>