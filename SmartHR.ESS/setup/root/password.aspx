<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="password.aspx.vb" Inherits="SmartHR.password" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>SmartHR (Employee Self Service)</title>
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <script src="scripts/main.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="_passwords" runat="server">
            <dxlp:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    var response = e.result.split('\ ');
                    if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                        window.location.href=response[1];
                    }
                    else {
                        lpPage.Hide();
                        ShowPopup(response[1]);
                    }
                }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcPopup" runat="server" ClientInstanceName="pcPopup" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/info.png">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="width: 325px; text-align: center">
                            <dxe:ASPxLabel ID="lblMessage_Popup" runat="server" ClientInstanceName="lblMessage_Popup" />
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dxe:ASPxButton ID="cmdPopup" runat="server" ClientInstanceName="cmdPopup" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcPopup.Hide(); }" />
                            </dxe:ASPxButton>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcPopup.AdjustSize(); cmdPopup.SetFocus(); }" />
            </dxpc:ASPxPopupControl>
            <div class="page_full">
                <table style="height: 100%; padding: 0px; width: 100%">
                    <tr valign="middle">
                        <td align="center">
                            <dxrp:ASPxRoundPanel ID="pnlLogon" runat="server" ClientInstanceName="pnlLogon" HeaderImage-Url="images/default.png" HeaderText="Password Reset">
                                <PanelCollection>
                                    <dxp:PanelContent runat="server">
                                        <div style="max-width: 325px">
                                            <div>
                                                <img src="images/default.jpg" />
                                            </div>
                                            <br />
                                            <p style="text-align: left">Supply a new password in order to change your password.</p>
                                            <br />
                                            <table style="padding: 0px; width: 319px">
                                                <tr>
                                                    <td style="font-weight: bold; text-align: right; width: 35%">Password</td>
                                                    <td style="width: 10px"></td>
                                                    <td style="text-align: left">
                                                        <dxe:ASPxTextBox ID="txtPassword" runat="server" ClientInstanceName="txtPassword" Password="true" Width="100%" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 3px">
                                                    <td colspan="3" />
                                                </tr>
                                                <tr>
                                                    <td style="font-weight: bold; text-align: right">Retype Password</td>
                                                    <td />
                                                    <td style="text-align: left">
                                                        <dxe:ASPxTextBox ID="txtRPassword" runat="server" ClientInstanceName="txtRPassword" Password="true" Width="100%" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <div class="centered" style="width: 80px">
                                                <dxe:ASPxButton ID="cmdSubmit" runat="server" ClientInstanceName="cmdSubmit" Text="Submit" Height="25px" Width="80px" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { lpPage.Show(); cpPage.PerformCallback('resetpwd\ ' + txtPassword.GetText() + '\ ' + txtRPassword.GetText()); } }" />
                                                </dxe:ASPxButton>
                                            </div>
                                        </div>
                                    </dxp:PanelContent>
                                </PanelCollection>
                                <HeaderStyle HorizontalAlign="Left" />
                            </dxrp:ASPxRoundPanel>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>