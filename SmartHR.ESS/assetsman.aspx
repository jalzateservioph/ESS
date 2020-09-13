<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="assetsman.aspx.vb" Inherits="SmartHR.assetsman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
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
        <form id="_assetsman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlAssets" runat="server" ClientInstanceName="pnlAssets" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="IssueDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="ItemCode" Caption="Description" VisibleIndex="2">
                                        <PropertiesComboBox DataSourceID="dsItemCode" TextField="ItemDescription" ValueField="ItemCode" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataSpinEditColumn FieldName="Quantity" Caption="Qty" VisibleIndex="3" />
                                    <dxwgv:GridViewDataDateColumn FieldName="ReturnDate" Caption="Return Date" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Reference" Caption="Ref #" VisibleIndex="5" />
                                </Columns>
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                    <Row HorizontalAlign="Left" />
                                    <PagerBottomPanel HorizontalAlign="Left" />
                                </Styles>
                            </dxwgv:ASPxGridView>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td colspan="3" style="text-align: left"><dxe:ASPxLabel ID="lblRemarks" runat="server" Text="Remarks (add comments for the applicant):" Font-Bold="true" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: left"><dxe:ASPxMemo ID="txtRemarks" runat="server" Height="75px" Width="100%" ClientInstanceName="txtRemarks" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br /></td>
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
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/assets_003.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Asset Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsItemCode" runat="server" />
        </form>
    </body>
</html>