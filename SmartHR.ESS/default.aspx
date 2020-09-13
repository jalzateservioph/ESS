<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="SmartHR._default" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>
    
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
        <form id="_default" runat="server">
        
            <dx:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
            <dx:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    var response = e.result.split('\ ');
                    if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                        window.location.href=response[1];
                    }
                    else {
                        lpPage.Hide();
                        if (response[1] == 'ShowMultiple') {
                            cmbMultiple.BeginUpdate();
                            var loop = 2;
                            while(response[loop] != undefined) {
                                cmbMultiple.AddItem(response[loop], response[loop]);
                                loop++;
                            }
                            cmbMultiple.EndUpdate();
                            pcMultiple.Show();
                        }
                        else {
                            ShowPopup(response[1]);
                        }
                    }
                }" />
            </dx:ASPxCallback>
            <dx:ASPxPopupControl ID="pcMultiple" runat="server" ClientInstanceName="pcMultiple" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Multiple Accounts" HeaderImage-Url="images/info.png">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <div style="width: 225px; text-align: left">Choose your default account for tasks:</div>
                        <br />
                        <div>
                            <dx:ASPxComboBox ID="cmbMultiple" runat="server" ClientInstanceName="cmbMultiple" Width="100%">
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { txtUsername.SetText(s.GetValue()); }" />
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dx:ASPxButton ID="cmdMultiple" runat="server" ClientInstanceName="cmdMultiple" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { lpPage.Show(); cpPage.PerformCallback('submit\ ' + txtUsername.GetText() + '\ ' + txtPassword.GetText() + '\ true'); }" />
                            </dx:ASPxButton>
                        </div>
                    </dx:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcMultiple.AdjustSize(); cmdMultiple.SetFocus(); }" />
                <HeaderStyle HorizontalAlign="Left" />
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="pcPopup" runat="server" ClientInstanceName="pcPopup" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/info.png">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <div style="width: 250px; text-align: center">
                            <dx:ASPxLabel ID="lblMessage_Popup" runat="server" ClientInstanceName="lblMessage_Popup" />
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dx:ASPxButton ID="cmdPopup" runat="server" ClientInstanceName="cmdPopup" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcPopup.Hide(); }" />
                            </dx:ASPxButton>
                        </div>
                    </dx:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcPopup.AdjustSize(); cmdPopup.SetFocus(); }" />
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="pcReset" runat="server" ClientInstanceName="pcReset" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/default.png" HeaderText="Password Reset">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <div style="width: 275px; text-align: center">
                            <p>Supply your username and email address.</p>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="font-weight: bold; text-align: right">Username</td>
                                    <td style="width: 10px" />
                                    <td style="text-align: left">
                                        <dx:ASPxTextBox ID="txtUsername_Reset" runat="server" ClientInstanceName="txtUsername_Reset" Width="175px" />
                                    </td>
                                </tr>
                                <tr style="height: 3px">
                                    <td colspan="3" />
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; text-align: right">Email</td>
                                    <td />
                                    <td style="text-align: left">
                                        <dx:ASPxTextBox ID="txtEmail_Reset" runat="server" ClientInstanceName="txtEmail_Reset" Width="175px" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        <div class="centered" style="width: 180px">
                            <table style="padding: 0px">
                                <tr>
                                    <td style="text-align: right">
                                        <dx:ASPxButton ID="cmdReset" runat="server" ClientInstanceName="cmdReset" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { pcReset.Hide(); lpPage.Show(); cpPage.PerformCallback('reset\ ' + txtUsername_Reset.GetText() + '\ ' + txtEmail_Reset.GetText()); }" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="width: 20px" />
                                    <td style="text-align: left">
                                        <dx:ASPxButton ID="cmdCancel_Reset" runat="server" ClientInstanceName="cmdCancel_Reset" Text="Cancel" Height="25px" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { pcReset.Hide(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcReset.AdjustSize(); txtUsername_Reset.SetFocus(); }" />
            </dx:ASPxPopupControl>
            <div class="page_full">
                <table style="height: 600px; padding: 0px; width: 100%">
                    <tr valign="middle">
                        <td align="center">
                            <dx:ASPxRoundPanel ID="pnlLogon" runat="server" ClientInstanceName="pnlLogon" HeaderImage-Url="images/default.png" HeaderText="Security Logon">
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        
                                        <div>
                                            <img src="images/default.jpg" />
                                        </div>
                                        <br />
                                        <dx:ASPxPanel ID="pnlServer" runat="server" Width="319px" Visible="false">
                                            <PanelCollection>
                                                <dx:PanelContent>
                                                    <table style="padding: 0px; width: 100%">
                                                        <tr>
                                                            <td style="font-weight: bold; text-align: right; width: 35%">Server</td>
                                                            <td style="width: 10px"></td>
                                                            <td style="text-align: left">
                                                                <dx:ASPxLabel id="lblServer" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 3px">
                                                            <td colspan="3" />
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: bold; text-align: right">Database</td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dx:ASPxLabel id="lblDatabase" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 3px">
                                                            <td colspan="3" />
                                                        </tr>
                                                    </table>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxPanel>
                                        <table style="padding: 0px; width: 319px">
                                            <tr>
                                                <td style="font-weight: bold; text-align: right; width: 35%">Application</td>
                                                <td style="width: 10px"></td>
                                                <td style="text-align: left">
                                                    <dx:ASPxLabel id="lblAppVersion" runat="server" />
                                                </td>
                                            </tr>
                                            <tr style="height: 3px">
                                                <td colspan="3" />
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; text-align: right">Database</td>
                                                <td />
                                                <td style="text-align: left">
                                                    <dx:ASPxLabel id="lblDBVersion" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><hr /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; text-align: right">Username</td>
                                                <td />
                                                <td style="text-align: left">
                                                    <dx:ASPxTextBox ID="txtUsername" runat="server" ClientInstanceName="txtUsername" Width="100%" />
                                                </td>
                                            </tr>
                                            <tr style="height: 3px">
                                                <td colspan="3" />
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; text-align: right">Password</td>
                                                <td />
                                                <td style="text-align: left">
                                                    <dx:ASPxTextBox ID="txtPassword" runat="server" ClientInstanceName="txtPassword" Password="true" Width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" />
                                                <td style="text-align: left">
                                                    <dx:ASPxHyperLink ID="hlPassword" runat="server" Text="Forgot your password?" Cursor="pointer" Font-Underline="false">
                                                        <ClientSideEvents Click="function(s, e) { pcReset.Show(); }" />
                                                    </dx:ASPxHyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <div class="centered" style="width: 80px">
                                            <dx:ASPxButton ID="cmdSubmit" runat="server" ClientInstanceName="cmdSubmit" Text="Submit" Height="25px" Width="80px" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { lpPage.Show(); cpPage.PerformCallback('submit\ ' + txtUsername.GetText() + '\ ' + txtPassword.GetText()); } }" />
                                            </dx:ASPxButton>
                                        </div>
                                        <div><br /><br /></div>
                                        <div style="text-align: right">
			<a href="<%$ ConnectionStrings:Application %>" runat="server">Application Form</a>
                                           
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <dx:ASPxHyperLink ID="hlChange" runat="server" Text="Change my password" Cursor="pointer" Font-Underline="false">
                                                <ClientSideEvents Click="function(s, e) { pcReset.SetHeaderText('Password Change'); pcReset.Show(); }" />
                                            </dx:ASPxHyperLink>
                                        </div>
                                    </dx:PanelContent>
                                </PanelCollection>
                                <HeaderStyle HorizontalAlign="Left" />
                            </dx:ASPxRoundPanel>
                            <span style="display: block;font-size: 7pt;margin-top: 5px;">
                                Build Number: <asp:Literal ID="ltBuildNum" runat="server"></asp:Literal>
                                <br />
                                <asp:Literal ID="ltConn" runat="server"></asp:Literal>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>