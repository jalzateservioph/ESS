<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="homepage.aspx.vb" Inherits="SmartHR.homepage" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxNewsControl" TagPrefix="dxnc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
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
        <form id="_homepage" runat="server">
            <div class="padding">
                <div style="float: left; width: 45%">
                    <asp:Repeater ID="rptEmployee" runat="server">
                        <ItemTemplate>
                            <div id="divEmployee" runat="server" style="cursor: pointer; width: 100%">
                                <table style="padding: 0px; width: 100%">
                                    <tr>
                                        <td style="width: 60px">
                                            <dxe:ASPxImage ID="imgEmployeeItem" runat="server" Height="48px" Width="48px" />
                                        </td>
                                        <td style="vertical-align: top">
                                            <table style="padding: 0px; width: 100%">
                                                <tr>
                                                    <td>
                                                        <dxe:ASPxLabel ID="lblEmployeeTitle" runat="server" Font-Bold="true" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dxe:ASPxLabel ID="lblEmployeeItem" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <br />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div style="float: right; padding-right: 15px; width: 50%">
                    <dxrp:ASPxRoundPanel ID="pnlNews" runat="server" Width="100%">
                        <PanelCollection>
                            <dxp:PanelContent runat="server">
                                <div style="text-align: right">
                                    <dxe:ASPxHyperLink ID="hlMaintenance" runat="server" Text="maintain articles..." Cursor="pointer" Font-Underline="false" NavigateUrl="news_001.aspx" />
                                </div>
                                <dxnc:ASPxNewsControl ID="ncNewsItems" runat="server" ClientInstanceName="ncNewsItems" DateField="Date" HeaderTextField="Title" ImageUrlField="ImageURL" NameField="CompositeKey" TextField="Summary">
                                    <ClientSideEvents TailClick="function(s, e) { e.processOnServer = false; window.open('news.aspx?ID=' + e.name); }" />
                                    <ItemSettings DateVerticalPosition="Header" DateHorizontalPosition="Right" ShowImageAsLink="True" MaxLength="75" TailText="details" />
                                    <ItemTailStyle ForeColor="#749BCA" />
                                </dxnc:ASPxNewsControl>
                            </dxp:PanelContent>
                        </PanelCollection>
                        <HeaderTemplate>
                            <table style="height: 16px; width: 100%">
                                <tr valign="middle">
                                    <td style="width: 20px">
                                        <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/homepg_001.png" />
                                    </td>
                                    <td>
                                        <dxe:ASPxLabel id="lblPanel" runat="server" Text="Latest News" />
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                    </dxrp:ASPxRoundPanel>
                </div>
            </div>
        </form>
    </body>
</html>