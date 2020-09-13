<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="transferman.aspx.vb" Inherits="SmartHR.transferman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_transferman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <table style="padding: 0px; width: 100%">
                    <tr>
                        <td style="text-align: right; width: 175px">Employee to Transfer</td>
                        <td style="width: 10px" />
                        <td style="text-align: left">
                            <dxe:ASPxComboBox ID="cmbEmployee" runat="server" ClientInstanceName="cmbEmployee" Enabled="false" TextField="Text" ValueField="Value" EnableIncrementalFiltering="true" Width="325px">
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                </ValidationSettings>
                            </dxe:ASPxComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 5px" />
                    </tr>
                    <tr>
                        <td style="text-align: right">Transfer (From):</td>
                        <td />
                        <td style="text-align: left">
                            <dxe:ASPxLabel id="lblTransFrom" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 5px" />
                    </tr>
                    <tr>
                        <td style="text-align: right">Transfer (To):</td>
                        <td />
                        <td style="text-align: left">
                            <dxe:ASPxLabel id="lblTransTo" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 5px" />
                    </tr>
                    <tr>
                        <td style="text-align: right; vertical-align: top">Comments (optional):</td>
                        <td />
                        <td><dxe:ASPxMemo runat="server" ID="txtRemarks" Rows="5" Width="100%" /></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 10px" />
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Table ID="tblButtons" runat="server" Width="100%">
                                <asp:TableRow>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <dxe:ASPxButton ID="cmdApprove" runat="server" Text="Approve" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Approve ' + txtRemarks.GetText()); }" />
                                        </dxe:ASPxButton>
                                    </asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell HorizontalAlign="Left">
                                        <dxe:ASPxButton ID="cmdReject" runat="server" Text="Reject" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Reject ' + txtRemarks.GetText()); }" />
                                        </dxe:ASPxButton>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>