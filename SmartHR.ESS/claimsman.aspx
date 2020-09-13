<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="claimsman.aspx.vb" Inherits="SmartHR.claimsman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
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
        <form id="_claimsman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlClaims" runat="server" ClientInstanceName="pnlClaims" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Date" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Type" Caption="Type" VisibleIndex="2">
                                        <PropertiesComboBox DataSourceID="dsClaimType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="ItemType" ValueField="ItemType" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="Username" Caption="Captured By" VisibleIndex="3">
                                        <EditFormSettings Visible="false" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" VisibleIndex="4">
                                        <EditFormSettings Visible="false" />
                                    </dxwgv:GridViewDataDateColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="5" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="6" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                </Columns>
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                </Styles>
                                <Templates>
                                    <DetailRow>
                                        <table style="padding: 0px; width: 100%">
                                            <tr>
                                                <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Claim Items</td>
                                                <td style="width: 10px"></td>
                                                <td><hr /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 5px" />
                                            </tr>
                                        </table>
                                        <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                            <Columns>
                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="ItemType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                                                    <PropertiesComboBox DataSourceID="dsClaimTypeSub" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="SubItemType" ValueField="SubItemType" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewDataTextColumn FieldName="ItemName" Caption="Description" VisibleIndex="2">
                                                    <PropertiesTextEdit MaxLength="50" />
                                                </dxwgv:GridViewDataTextColumn>
                                                <dxwgv:GridViewDataSpinEditColumn FieldName="Amount" Caption="Amount" VisibleIndex="3" />
                                                <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="4" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="5" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="254" Width="16px">
                                                    <CellStyle Paddings-PaddingTop="5px" />
                                                    <DataItemTemplate>
                                                        <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                    </DataItemTemplate>
                                                    <EditFormSettings Visible="False" />
                                                </dxwgv:GridViewDataTextColumn>
                                            </Columns>
                                            <GroupSummary>
                                                <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                            </GroupSummary>
                                            <TotalSummary>
                                                <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                            </TotalSummary>
                                            <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowFooter="true" ShowGroupPanel="true" />
                                            <SettingsBehavior AutoExpandAllGroups="true" />
                                            <SettingsCookies StoreColumnsVisiblePosition="false" />
                                            <SettingsDetail IsDetailGrid="true" />
                                            <SettingsPager AlwaysShowPager="True" />
                                            <Styles>
                                                <AlternatingRow Enabled="true" />
                                                <CommandColumn Spacing="8px" />
                                                <CommandColumnItem Cursor="pointer" />
                                                <Header HorizontalAlign="Center" />
                                            </Styles>
                                        </dxwgv:ASPxGridView>
                                    </DetailRow>
                                </Templates>
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/claims_005.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Claim Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsClaimType" runat="server" />
            <asp:SqlDataSource ID="dsClaimTypeSub" runat="server" />
        </form>
    </body>
</html>