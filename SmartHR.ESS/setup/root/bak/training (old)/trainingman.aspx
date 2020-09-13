<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="trainingman.aspx.vb" Inherits="SmartHR.trainingman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
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
        <form id="_trainingman" runat="server">
            <dxlp:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
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
                <dxtc:ASPxPageControl ID="tabTraining" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Application">
                            <TabImage Url="images/training_002.png" />
                            <Controls>
                                <div style="text-align: left">
                                    <dxrp:ASPxRoundPanel ID="pnlTraining" runat="server" ClientInstanceName="pnlTraining" Width="100%">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course Name" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="End Date" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Duration" Caption="Duration" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CapturedByUsername" Caption="Captured By" VisibleIndex="7" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Description" Visible="false" VisibleIndex="8" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="PathID" Visible="false" VisibleIndex="9" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DurationType" Visible="false" VisibleIndex="10" />
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
                                                        <dxe:ASPxLabel id="lblPanel" runat="server" Text="Training Acceptance: (" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                </div>
                            </Controls>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Staff on Training">
                            <TabImage Url="images/training_005.png" />
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