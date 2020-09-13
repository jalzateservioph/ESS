<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="chipnpin.aspx.vb" Inherits="SmartHR.chipnpin" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_chipnpin" runat="server">
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlChipnPin" runat="server" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
						    <table style="padding: 0px; width: 100%">
							    <tr>
								    <td style="text-align: left"><asp:Label id="lblSentAt" runat="server" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: center"><asp:textbox id="txtChipnPin" runat="server" Width="125px" MaxLength="10" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: center"><asp:Button ID="cmdContinue" runat="server" Text="Continue" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: center"><asp:Label id="lblOR" runat="server" Text="OR" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: left"><asp:Label id="lblResend" runat="server" Text="If you did not receive the SMS password, you have the option to request a new SMS password:" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: center"><asp:Button ID="cmdResend" runat="server" Text="Resend" /></td>
							    </tr>
							    <tr>
								    <td><br /></td>
							    </tr>
							    <tr>
								    <td style="text-align: left"><asp:Label id="lblNote" runat="server" Text="Note:" Font-Bold="true" /></td>
							    </tr>
							    <tr>
								    <td align="left" style="padding-left: 15px"><asp:Label id="lblNote_001" runat="server" Text="1. If you request a new SMS password, your previous SMS password will no longer be valid." /></td>
							    </tr>
							    <tr>
								    <td align="left" style="padding-left: 15px"><asp:Label id="lblNote_002" runat="server" Text="2. Your SMS password is valid for this ESS session only." /></td>
							    </tr>
							    <tr>
								    <td align="left" style="padding-left: 15px"><asp:Label id="lblNote_003" runat="server" Text="3. Your SMS password is valid for 15 minutes." /></td>
							    </tr>
							    <tr>
								    <td align="left" style="padding-left: 15px"><asp:Label id="lblNote_004" runat="server" Text="4. If your SMS password has expired, click on the resend button to receive a new SMS password." /></td>
							    </tr>
							    <tr>
								    <td align="left" style="padding-left: 15px"><asp:Label id="lblNote_005" runat="server" Text="5. If your cellphone number has changed or is not correct, contact your HR Administrator or change your cellphone number in the personal details section." /></td>
							    </tr>
						    </table>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/default.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="One Time Password" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </form>
    </body>
</html>