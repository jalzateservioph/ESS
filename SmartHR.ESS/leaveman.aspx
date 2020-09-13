<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="leaveman.aspx.vb" Inherits="SmartHR.leaveman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
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
        <form id="_leaveman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
               <ClientSideEvents CallbackComplete="function(s, e) {
                        var response = e.result.split('\ ');
                        window.parent.reset();
                        if (response[1] != undefined) {
                            if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                                window.parent.postUrl(response[1] + '\ ' + response[2], false);
                            }
                            else {
                                window.parent.ShowPopup(response[1]);
                            }
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcBalance" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcBalance" HeaderText="Leave Balance" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <table cellpadding="0" style="text-align: left; width: 350px">
                            <tr>
                                <td style="text-align: right"><dxe:ASPxLabel ID="lblBalance_002" runat="server" Text="Balance (as at)" /></td>
                                <td style="width: 10px"></td>
                                <td style="text-align: left"><dxe:ASPxLabel ID="lblBalanceAsAt" runat="server" ClientInstanceName="lblBalanceAsAt" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><dxe:ASPxLabel ID="lblBalance_003" runat="server" Text="Balance" /></td>
                                <td />
                                <td style="text-align: left"><dxe:ASPxLabel ID="lblBalance" runat="server" ClientInstanceName="lblBalance" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><dxe:ASPxLabel ID="lblBalance_004" runat="server" Text="Duration" /></td>
                                <td />
                                <td style="text-align: left"><dxe:ASPxLabel ID="lblDuration" runat="server" ClientInstanceName="lblDuration" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><dxe:ASPxLabel ID="lblBalance_005" runat="server" Text="Balance (remaining)" /></td>
                                <td />
                                <td style="text-align: left"><dxe:ASPxLabel ID="lblRemaining" runat="server" ClientInstanceName="lblRemaining" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><dxe:ASPxLabel ID="lblBalance_006" runat="server" Text="* if approved" /></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="3"><br /></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align: center">
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdBalance" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcBalance.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcHistory" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcHistory" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <table cellpadding="0" style="text-align: left; width: 350px">
                            <tr>
                                <td style="text-align: center">
                                    <dxe:ASPxMemo ID="txtRemarks_History" runat="server" ClientInstanceName="txtRemarks_History" Width="325px" Height="125px" ReadOnly="true" />
                                </td>
                            </tr>
                            <tr>
                                <td><br /></td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdHistory" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcHistory.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabLeave" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Application">
                            <TabImage Url="images/leave_001.png" />
                            <Controls>
                                <div style="text-align: left">
                                    <dxrp:ASPxRoundPanel ID="pnlLeave" runat="server" ClientInstanceName="pnlLeave" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" VisibleIndex="0" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="Select" Image-Url="images/select.png" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="LeaveType" Caption="Unit Type" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="End Date" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Duration" Caption="Duration" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="LeaveStatus" Caption="Status" VisibleIndex="6" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CapturedByUsername" Caption="Captured By" VisibleIndex="7" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CaptureDate" Caption="Captured On" VisibleIndex="8" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Remarks" Visible="false" VisibleIndex="9" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="PathID" Visible="false" VisibleIndex="10" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="UnitType" Visible="false" VisibleIndex="11" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ESSPath" Visible="false" VisibleIndex="12" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="balance" VisibleIndex="13" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="Balance" Image-Url="images/question.png" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                        <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="14" Width="16px">
                                                            <CellStyle Paddings-PaddingTop="5px" />
                                                            <DataItemTemplate>
                                                                <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                            </DataItemTemplate>
                                                            <EditFormSettings Visible="False" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                    </Columns>
                                                    <ClientSideEvents EndCallback="function(s, e) { if (s.cpShow) { if (s.cpType == 0) { txtRemarks_History.SetText(s.cpRemarks); pcHistory.Show(); } else { if (s.cpType == 1) { lblBalance.SetText(s.cpBalance); lblRemaining.SetText(s.cpRemaining); pcBalance.Show(); } } } }" />
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
                                                        <td colspan="3" style="text-align: left">Comments (optional):</td>
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
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel" runat="server" Text="Leave Acceptance: (" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                </div>
                            </Controls>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Staff on Leave">
                            <TabImage Url="images/leave_004.png" />
                            <Controls>
                                <dxe:ASPxLabel ID="lblStaff" runat="server" Text="* Shown from 7 days prior to the start and 7 days after the end dates" Font-Bold="true" />
                                <br />
                                <asp:Repeater ID="rptItems" runat="server">
                                    <ItemTemplate>
                                        <asp:PlaceHolder ID="phControls_Rows" runat="server" Visible="true" />
                                    </ItemTemplate>
                                </asp:Repeater>                            
                            </Controls>
                        </dxtc:TabPage>
                    </TabPages>
                </dxtc:ASPxPageControl>
            </div>
		</form>
    </body>
</html>