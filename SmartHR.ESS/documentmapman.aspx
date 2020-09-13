<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="documentmapman.aspx.vb" Inherits="SmartHR.documentmapman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>SmartHR (Employee Self Service)</title>
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
    </head>
    <body onload="window.parent.reset();">
        <form id="_documentmapman" runat="server">
            <dxhf:ASPxHiddenField ID="items_001" runat="server" ClientInstanceName="items_001" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) { dgView.Refresh(); pcReason.Hide(); }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcReason" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcReason" HeaderText="Decline Reason" AllowDragging="True" EnableAnimation="False" EnableViewState="False" Width="320px" ShowFooter="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="padding: 0px; text-align: center; width: 320px">
                            <table cellpadding="0" style="text-align: center; width: 320px">
                                <tr>
                                    <td colspan="3"><dxe:ASPxMemo ID="txtDeclineReason" runat="server" ClientInstanceName="txtDeclineReason" Height="75px" Width="100%" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        <dxe:ASPxButton ID="cmdOK" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { cpPage.PerformCallback(pcReason.GetFooterText()); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                    <td style="width: 10px"></td>
                                    <td style="text-align: left">
                                        <dxe:ASPxButton ID="cmdCancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcReason.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <HeaderStyle HorizontalAlign="Left" />
                <FooterStyle HorizontalAlign="Left" />
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlDocumentMap" runat="server" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                    <dxwgv:GridViewDataDateColumn FieldName="DateLinked" Caption="Date Assigned" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="3" />
                                    <dxwgv:GridViewDataCheckColumn FieldName="Accepted" Caption="Accepted?" VisibleIndex="4">
                                        <DataItemTemplate>
                                            <dxe:ASPxCheckBox ID="chkAccepted" runat="server" />
                                        </DataItemTemplate>
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="VirtualPath" VisibleIndex="5" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="DeclinedReason" Caption="Decline Reason" VisibleIndex="5">
                                        <CellStyle HorizontalAlign="Center" />
                                        <DataItemTemplate>
                                            <div class="centered" style="width: 80px">
                                                <dxe:ASPxButton ID="cmdDecline" runat="server" AutoPostBack="false" Text="Reason" Width="80px" ClientSideEvents-Click="<%# GetClickReason(Container) %>" />
                                            </div>
                                        </DataItemTemplate>
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="6" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                    </dxwgv:GridViewDataTextColumn>
                                </Columns>
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                </Styles>
                            </dxwgv:ASPxGridView>
                            <br />
                            <div class="centered" style="width: 240px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="text-align: right">
                                            <dxe:ASPxButton ID="cmdRemind" runat="server" Width="150px" Text="Remind me later...">
                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                            </dxe:ASPxButton>
                                        </td>
                                        <td style="width: 10px" />
                                        <td style="text-align: left">
                                            <dxe:ASPxButton ID="cmdSubmit" runat="server" Width="80px" Text="Submit">
                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                            </dxe:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/documentmapman_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Document Acceptance" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </form>
    </body>
</html>