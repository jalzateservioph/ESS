<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="pay.aspx.vb" Inherits="SmartHR.pay" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
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
		<form id="_financial" runat="server">
            <dxpc:ASPxPopupControl ID="pcHistory" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcHistory" HeaderImage-Url="images/info.png" HeaderText="Information: Remarks">
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
                                    <dxe:ASPxButton ID="cmdHistory" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                        <ClientSideEvents Click="function(s, e) { pcHistory.Hide(); }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabFinance" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Pay History">
                            <TabImage Url="images/financial_001.png" />
                            <Controls>
                                <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                    <Columns>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                        <dxwgv:GridViewDataDateColumn FieldName="DateFrom" Caption="Pay Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Salary" Caption="Salary" VisibleIndex="2" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Rate" Caption="Rate" VisibleIndex="3" />
                                        <dxwgv:GridViewDataTextColumn FieldName="RateUnit" Caption="Unit Type" VisibleIndex="4" />
                                        <dxwgv:GridViewDataTextColumn FieldName="TemplateName" Visible="false" VisibleIndex="5" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Date" Visible="false" VisibleIndex="6" />
                                        <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                            <CellStyle Paddings-PaddingTop="5px" />
                                            <DataItemTemplate>
                                                <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="Open Report" ImageUrl="images/select.png" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dxwgv:GridViewDataTextColumn>
                                    </Columns>
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                    <SettingsPager AlwaysShowPager="True" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
                                        <CommandColumn Spacing="8px" />
                                        <CommandColumnItem Cursor="pointer" />
                                        <Header HorizontalAlign="Center" />
                                        <StatusBar HorizontalAlign="Right" />
                                    </Styles>
                                </dxwgv:ASPxGridView>
                            </Controls>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Pension Benefits">
                            <TabImage Url="images/financial_003.png" />
                            <Controls>
                                <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                    <Columns>
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" VisibleIndex="0" Width="16px">
                                            <CustomButtons>
                                                <dxwgv:GridViewCommandColumnCustomButton ID="Select_002" Image-Url="images/select.png" />
                                            </CustomButtons>
                                        </dxwgv:GridViewCommandColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                        <dxwgv:GridViewDataTextColumn FieldName="PensionScheme" Caption="Scheme" VisibleIndex="2" />
                                        <dxwgv:GridViewDataDateColumn FieldName="DateJoined" Caption="Joined" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                        <dxwgv:GridViewDataDateColumn FieldName="DateLeft" Caption="Termination" VisibleIndex="4" />
                                        <dxwgv:GridViewDataTextColumn FieldName="MembershipNum" Caption="Membership #" VisibleIndex="5" Visible="false" />
                                        <dxwgv:GridViewDataTextColumn FieldName="CompPercent" Caption="Company (%)" VisibleIndex="6" />
                                        <dxwgv:GridViewDataTextColumn FieldName="EmplPercent" Caption="Employee (%)" VisibleIndex="7" />
                                        <dxwgv:GridViewDataTextColumn FieldName="BenefitVal" Caption="Value" VisibleIndex="8" Visible="false" />
                                        <dxwgv:GridViewDataDateColumn FieldName="BenefitValDate" Caption="Value at" VisibleIndex="9" Visible="false" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Comments" VisibleIndex="10" />
                                    </Columns>
                                    <ClientSideEvents EndCallback="function(s, e) { if (s.cpShow) { txtRemarks_History.SetText(s.cpRemarks); pcHistory.Show(); } }" />
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                    <SettingsPager AlwaysShowPager="True" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
                                        <CommandColumn Spacing="8px" />
                                        <CommandColumnItem Cursor="pointer" />
                                        <Header HorizontalAlign="Center" />
                                        <StatusBar HorizontalAlign="Right" />
                                    </Styles>
                                </dxwgv:ASPxGridView>
                            </Controls>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Medical Benefits">
                            <TabImage Url="images/financial_004.png" />
                            <Controls>
                                <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                    <Columns>
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" VisibleIndex="0" Width="16px">
                                            <CustomButtons>
                                                <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton1" Image-Url="images/select.png" />
                                            </CustomButtons>
                                        </dxwgv:GridViewCommandColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                        <dxwgv:GridViewDataTextColumn FieldName="MedicalScheme" Caption="Scheme" VisibleIndex="2" />
                                        <dxwgv:GridViewDataDateColumn FieldName="DateJoined" Caption="Joined" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                        <dxwgv:GridViewDataDateColumn FieldName="DateLeft" Caption="Termination" VisibleIndex="4" />
                                        <dxwgv:GridViewDataTextColumn FieldName="MembershipNum" Caption="Membership #" VisibleIndex="5" />
                                        <dxwgv:GridViewDataTextColumn FieldName="CompPercent" Caption="Company (%)" VisibleIndex="6" />
                                        <dxwgv:GridViewDataTextColumn FieldName="EmplPercent" Caption="Employee (%)" VisibleIndex="7" />
                                        <dxwgv:GridViewDataTextColumn FieldName="MedSavingsAcct" Caption="Savings?" VisibleIndex="8" Visible="false" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Vitality" Caption="Vitality?" VisibleIndex="9" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Dependants" Caption="# of Dependants" VisibleIndex="10" />
                                        <dxwgv:GridViewDataTextColumn FieldName="AdultDependants" Caption="# of Adult Dep." VisibleIndex="11" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Comments" VisibleIndex="12" />
                                    </Columns>
                                    <ClientSideEvents EndCallback="function(s, e) { if (s.cpShow) { txtRemarks_History.SetText(s.cpRemarks); pcHistory.Show(); } }" />
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                    <SettingsPager AlwaysShowPager="True" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
                                        <CommandColumn Spacing="8px" />
                                        <CommandColumnItem Cursor="pointer" />
                                        <Header HorizontalAlign="Center" />
                                        <StatusBar HorizontalAlign="Right" />
                                    </Styles>
                                </dxwgv:ASPxGridView>
                            </Controls>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
		</form>
	</body>
</html>