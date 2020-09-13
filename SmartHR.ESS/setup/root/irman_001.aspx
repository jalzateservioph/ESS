<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="irman_001.aspx.vb" Inherits="SmartHR.irman_001" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
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
        <form id="_irman_001" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcRemarks" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcRemarks" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <table cellpadding="0" style="text-align: left; width: 350px">
                            <tr>
                                <td style="font-weight: bold; text-align: left">Agreed Actions (Manager):</td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <dxe:ASPxMemo ID="txtRemarks_Manager" runat="server" ClientInstanceName="txtRemarks_Manager" Width="325px" Height="125px" ReadOnly="true" />
                                </td>
                            </tr>
                            <tr>
                                <td><br /></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: left">Agreed Actions (Employee):</td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <dxe:ASPxMemo ID="txtRemarks_Employee" runat="server" ClientInstanceName="txtRemarks_Employee" Width="325px" Height="125px" ReadOnly="true" />
                                </td>
                            </tr>
                            <tr>
                                <td><br /></td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdRemarks" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcRemarks.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcFollowup" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcFollowup" HeaderText="Create a new Follow-up Record" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <table cellpadding="0" style="text-align: left; width: 450px">
                            <tr>
                                <td style="font-weight: bold; text-align: right; width: 75px">Date</td>
                                <td style="width: 10px" />
                                <td style="text-align: left">
                                    <dxe:ASPxDateEdit ID="dtDate" runat="server" ClientInstanceName="dtDate" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right">Manager</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxTextBox ID="txtManage" runat="server" Width="100%" ClientInstanceName="txtManage" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right">Follow up</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxDateEdit ID="dtFollowup" runat="server" ClientInstanceName="dtFollowup" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right">Venue</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxTextBox ID="txtVenue" runat="server" Width="100%" ClientInstanceName="txtVenue" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right; vertical-align: top">Reason for Counselling</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxMemo ID="txtReason" runat="server" ClientInstanceName="txtReason" Width="100%" Height="75px" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right; vertical-align: top">Agreed Actions (Employee)</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxMemo ID="txtActions_Manager" runat="server" ClientInstanceName="txtActions_Manager" Width="100%" Height="75px" />
                                </td>
                            </tr>
                            <tr style="height: 3px">
                                <td colspan="3" />
                            </tr>
                            <tr>
                                <td style="font-weight: bold; text-align: right; vertical-align: top">Agreed Actions (Manager)</td>
                                <td />
                                <td style="text-align: left">
                                    <dxe:ASPxMemo ID="txtActions_Employee" runat="server" ClientInstanceName="txtActions_Employee" Width="100%" Height="75px" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3"><br /></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div class="centered" style="width: 175px">
                                        <table cellpadding="0" style="text-align: left; width: 175px">
                                            <tr>
                                                <td style="text-align: right; width: 80px">
                                                    <dxe:ASPxButton ID="cmdFollowup_OK" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                                        <ClientSideEvents Click="function(s, e) { pcFollowup.Hide(); window.parent.lpPage.Show(); cpPage.PerformCallback('Approve ' + txtRemarks.GetText() + ' ' + dtDate.GetText() + ' ' + txtManage.GetText() + ' ' + dtFollowup.GetText() + ' ' + txtVenue.GetText() + ' ' + txtReason.GetText() + ' ' + txtActions_Manager.GetText() + ' ' + txtActions_Employee.GetText()); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                                <td style="width: 15px" />
                                                <td style="text-align: left; width: 80px">
                                                    <dxe:ASPxButton ID="cmdFollowup_Cancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                        <ClientSideEvents Click="function(s, e) { pcFollowup.Hide(); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlIR" runat="server" ClientInstanceName="pnlIR" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" VisibleIndex="0" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="Select" Image-Url="images/select.png" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="fDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Manager" Caption="Manager" VisibleIndex="3" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Follow_Up_Date" Caption="Follow Up" VisibleIndex="4" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Venue" Caption="Venue" VisibleIndex="5" />
                                    <dxwgv:GridViewDataMemoColumn FieldName="Reason_For_Counselling" Caption="Reason" VisibleIndex="6" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="7" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Employee_Suggestions" VisibleIndex="8" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Manager_Suggestions" VisibleIndex="9" Visible="false" />
                                </Columns>
                                <ClientSideEvents EndCallback="function(s, e) { if (s.cpShowPopup) { txtRemarks_Employee.SetText(s.cpEmpRemarks); txtRemarks_Manager.SetText(s.cpManRemarks); pcRemarks.Show(); } }" />
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
                                                    <dxe:ASPxButton ID="cmdApprove" runat="server" Text="Follow up" Width="80px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { pcFollowup.Show(); }" />
                                                    </dxe:ASPxButton>
                                                </asp:TableCell>
                                                <asp:TableCell Width="10px" />
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <dxe:ASPxButton ID="cmdReject" runat="server" Text="Close" Width="80px" AutoPostBack="false">
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/ir_003.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="IR Performance Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </form>
    </body>
</html>
