<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="leaveadjust.aspx.vb" Inherits="SmartHR.leaveadjust" ValidateRequest="false" %>

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
        <form id="_leaveadjust" runat="server">
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
                <dxrp:ASPxRoundPanel ID="pnlLeave" runat="server" ClientInstanceName="pnlLeave" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="13" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                </Columns>
                                <ClientSideEvents EndCallback="function(s, e) { if (s.cpShow) { if (s.cpType == 0) { txtRemarks_History.SetText(s.cpRemarks); pcHistory.Show(); } } }" />
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
                            </table>
                            <br />
                            <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                    <dxwgv:GridViewDataTextColumn FieldName="LeaveType" Caption="Unit Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                    <dxwgv:GridViewDataDateColumn FieldName="CalcDate" Caption="As At" VisibleIndex="2" Visible="false" />
                                    <dxwgv:GridViewDataSpinEditColumn FieldName="TotalBalance" Caption="Total Balance" VisibleIndex="3" HeaderStyle-Font-Bold="true" />
                                    <dxwgv:GridViewDataSpinEditColumn FieldName="Balance" Caption="Balance (current cycle)" VisibleIndex="4" />
                                    <dxwgv:GridViewDataSpinEditColumn FieldName="AccumBalance" Caption="Accum Balance" VisibleIndex="5" />
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
                            <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                        <EditButton Visible="True">
                                            <Image Url="images/edit.png" />
                                        </EditButton>
                                        <CancelButton Visible="True">
                                            <Image Url="images/cancel.png" />
                                        </CancelButton>
                                        <UpdateButton Visible="True">
                                            <Image Url="images/update.png" />
                                        </UpdateButton>
                                    </dxwgv:GridViewCommandColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="LeaveType" Caption="Unit Type" VisibleIndex="2">
                                        <PropertiesComboBox DataSourceID="dsLeaveTypes" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="LeaveType" ValueField="LeaveType" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataDateColumn FieldName="EffectiveDate" Caption="Effective (From)" SortIndex="0" SortOrder="Descending" VisibleIndex="3">
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataDateColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="AdjustmentType" Caption="Adjustment (Type)" VisibleIndex="4">
                                        <PropertiesComboBox DropDownStyle="DropDown" TextField="AdjustmentType" ValueField="AdjustmentType">
                                            <Items>
                                                <dxe:ListEditItem Text="Adjust Accum Balance" Value="Adjust Accum Balance" />
                                                <dxe:ListEditItem Text="Adjustment" Value="Adjustment" />
                                            </Items>
                                        </PropertiesComboBox>
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataSpinEditColumn FieldName="AdjustmentValue" Caption="Value" VisibleIndex="5" />
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                <SettingsEditing NewItemRowPosition="Bottom" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                </Styles>
                                <Templates>
                                    <StatusBar>
                                        <table style="padding: 2px; width: 100%">
                                            <tr>
                                                <td></td>
                                                <td style="width: 80px">
                                                    <dxe:ASPxButton ID="cmdCreate_003" runat="server" ClientInstanceName="cmdCreate_003" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                        <ClientSideEvents Click="function(s, e) { dgView_003.AddNewRow(); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </StatusBar>
                                </Templates>
                            </dxwgv:ASPxGridView>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td colspan="3"><br /></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="centered" style="width: 80px">
                                            <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Adjust ' + txtRemarks.GetText()); }" />
                                            </dxe:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Leave Adjustment: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsLeaveTypes" runat="server" />
		</form>
    </body>
</html>