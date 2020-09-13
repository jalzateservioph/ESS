<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="conditionsman.aspx.vb" Inherits="SmartHR.conditionsman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_conditionsman" runat="server">
            <dxhf:ASPxHiddenField ID="hPanel" runat="server" ClientInstanceName="hPanel" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (s.cpExecPrint) {
                            window.open('reportsview.aspx?params=' + hPanel.Get('params').toString(), 'open');
                            window.parent.lpPage.Hide();
                        }
                        else {
                            if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                                window.parent.postUrl(e.result, false);
                            }
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcHistory" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcHistory" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
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
                <dxrp:ASPxRoundPanel ID="pnlConditions" runat="server" ClientInstanceName="pnlConditions" Width="100%">
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
                                    <dxwgv:GridViewDataTextColumn FieldName="ActionDescription" Caption="Details" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ChangedFrom" Caption="Value (from)" VisibleIndex="3" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ChangedTo" Caption="Value (to)" VisibleIndex="4" />
                                    <dxwgv:GridViewDataDateColumn FieldName="EffectiveFrom" VisibleIndex="5" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="EffectiveTo" VisibleIndex="6" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" VisibleIndex="7" Visible="false" />
                                </Columns>
                                <ClientSideEvents EndCallback="function(s, e) { if (s.cpShow) { txtRemarks_History.SetText(s.cpRemarks); pcHistory.Show(); } }" />
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
                                    <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblStartDate" runat="server" Text="Effective From" /></td>
                                    <td style="width: 10px"></td>
                                    <td style="width: 260px; text-align: left"><dxe:ASPxDateEdit ID="dteStart" runat="server" ClientInstanceName="dteStart" /></td>
                                    <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblUntilDate" runat="server" Text="Effective Until" /></td>
                                    <td style="width: 10px"></td>
                                    <td style="width: 260px; text-align: left"><dxe:ASPxDateEdit ID="dteUntil" runat="server" ClientInstanceName="dteUntil" /></td>
                                    <td />
                                </tr>
                                <tr>
                                    <td colspan="7"><br /></td>
                                </tr>
                                <tr>
                                    <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblReason" runat="server" Text="Reason for Change" /></td>
                                    <td style="width: 10px"></td>
                                    <td style="width: 260px; text-align: left"><dxe:ASPxComboBox ID="cmbReason" runat="server" ClientInstanceName="cmbReason" DataSourceID="dsReason" TextField="Remark" ValueField="Remark" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                    <td style="width: 135px; text-align: right"></td>
                                    <td style="width: 10px"></td>
                                    <td style="width: 260px; text-align: left"></td>
                                    <td />
                                </tr>
                            </table>
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/conditions_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Basic Conditions Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsReason" runat="server" />
        </form>
    </body>
</html>