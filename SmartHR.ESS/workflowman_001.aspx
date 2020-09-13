<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="workflowman_001.aspx.vb" Inherits="SmartHR.workflowman_001" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
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
        <form id="_workflowman_001" runat="server">
            <dxhf:ASPxHiddenField ID="items_003" runat="server" ClientInstanceName="items_003" />
            <dxhf:ASPxHiddenField ID="items_004" runat="server" ClientInstanceName="items_004" />
            <dxhf:ASPxHiddenField ID="items_005" runat="server" ClientInstanceName="items_005" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlWorkflow" runat="server" ClientInstanceName="pnlWorkflow" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnHtmlRowCreated="dgView_001_HtmlRowCreated">
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
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Caption="Process ID" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="ActionID" Caption="Process (Role)" VisibleIndex="2">
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsActionLU" TextField="ReportsToType" ValueField="ID" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="StatusID" Caption="Activity" VisibleIndex="3">
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsStatusLU" TextField="Status" ValueField="ID" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="PostActID" Caption="Next Process" VisibleIndex="4">
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsProcessLU" TextField="Process" ValueField="ID" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="PAID" Caption="Process Result" VisibleIndex="5">
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsProcessResultLU" TextField="PostActionType" ValueField="ID" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataCheckColumn FieldName="SkipNonExt" Caption="Skip Process?" VisibleIndex="6" Visible="false">
                                        <EditFormSettings Caption="Skip Process (if role unallocated)?" Visible="true" />
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewDataCheckColumn FieldName="ExecNonProc" Caption="Apply Outcome?" VisibleIndex="7" Visible="false">
                                        <EditFormSettings Caption="Apply Process Outcome (if skipped)?" Visible="true" />
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="TaskIDProc" Caption="Process Trigger" VisibleIndex="8" Visible="false">
                                        <EditFormSettings Visible="true" />
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsProcessTProcLU" TextField="Task" ValueField="Task" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="PostActProc" Caption="Process Outcome" VisibleIndex="9" Visible="false">
                                        <EditFormSettings Visible="true" />
                                        <PropertiesComboBox EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsProcessPProcLU" TextField="Proc" ValueField="Proc" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="WFLUID" Visible="false" VisibleIndex="10" />
                                    <dxwgv:GridViewDataTextColumn FieldName="LockedBy" Visible="false" VisibleIndex="11" />
                                    <dxwgv:GridViewDataTextColumn FieldName="EmailID" Visible="false" VisibleIndex="12" />
                                    <dxwgv:GridViewDataTextColumn FieldName="SMSID" Visible="false" VisibleIndex="13" />
                                    <dxwgv:GridViewDataTextColumn FieldName="EmailOrigID" Visible="false" VisibleIndex="14" />
                                    <dxwgv:GridViewDataTextColumn FieldName="SMSOrigID" Visible="false" VisibleIndex="15" />
                                    <dxwgv:GridViewDataTextColumn FieldName="EmailActID" Visible="false" VisibleIndex="16" />
                                    <dxwgv:GridViewDataTextColumn FieldName="SMSActID" Visible="false" VisibleIndex="17" />
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="18" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                <SettingsEditing NewItemRowPosition="Bottom" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <EditFormColumnCaption HorizontalAlign="Right" />
                                    <Header HorizontalAlign="Center" />
                                    <StatusBar HorizontalAlign="Right" />
                                </Styles>
                                <Templates>
                                    <DetailRow>
                                    </DetailRow>
                                    <EditForm>
                                        <div style="padding: 5px; width: 100%">
                                            <dxtc:ASPxPageControl runat="server" ID="pageControl_001" Width="100%">
                                                <TabPages>
                                                    <dxtc:TabPage Text="General" Visible="true">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                </div>
                                                                <div style="height: 10px; width: 100%"></div>
                                                                <div style="width: 100%"><b>Accessible By</b><br /><br /></div>
                                                                <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnDataBound="dgView_001_DataBound">
                                                                    <Columns>
                                                                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                                                                            <HeaderTemplate>
                                                                                <input type="checkbox" onclick="dgView_002.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle Paddings-PaddingTop="1" Paddings-PaddingBottom="1" HorizontalAlign="Center" />
                                                                        </dxwgv:GridViewCommandColumn>
                                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                                        <dxwgv:GridViewDataTextColumn FieldName="ReportsToType" Caption="Process (Role)" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
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
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Next"  Visible="true">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <table style="padding: 0px; width: 100%">
                                                                        <tr>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblEmail_003" runat="server" Text="Email template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 260px; text-align: left"><dxe:ASPxComboBox ID="cmbEmail_003" runat="server" ClientInstanceName="cmbEmail_003" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsEmailLU" TextField="Type" ValueField="EmailID" Value='<%# Bind("EmailID") %>' ValueType="System.Byte" /></td>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblSMS_003" runat="server" Text="SMS template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 250px; text-align: left"><dxe:ASPxComboBox ID="cmbSMS_003" runat="server" ClientInstanceName="cmbSMS_003" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsSMSLU" TextField="Type" ValueField="ID" Value='<%# Bind("SMSID") %>' ValueType="System.Byte" /></td>
                                                                            <td />
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="7"><br /></td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style="width: 100%"><b>Copy Roles</b><br /><br /></div>
                                                                <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnDataBound="dgView_001_DataBound" OnHtmlRowCreated="dgView_001_HtmlRowCreated">
                                                                    <Columns>
                                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                                        <dxwgv:GridViewDataTextColumn FieldName="ReportsToType" Caption="Process (Role)" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="CC" Caption="CC" VisibleIndex="2" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="BCC" Caption="BCC" VisibleIndex="3" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkBCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="SMS" Caption="SMS" VisibleIndex="4" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkSMS" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
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
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Original"  Visible="true">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <table style="padding: 0px; width: 100%">
                                                                        <tr>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblEmail_004" runat="server" Text="Email template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 260px; text-align: left"><dxe:ASPxComboBox ID="cmbEmail_004" runat="server" ClientInstanceName="cmbEmail_004" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsEmailLU" TextField="Type" ValueField="EmailID" Value='<%# Bind("EmailOrigID") %>' ValueType="System.Byte" /></td>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblSMS_004" runat="server" Text="SMS template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 250px; text-align: left"><dxe:ASPxComboBox ID="cmbSMS_004" runat="server" ClientInstanceName="cmbSMS_004" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsSMSLU" TextField="Type" ValueField="ID" Value='<%# Bind("SMSOrigID") %>' ValueType="System.Byte" /></td>
                                                                            <td />
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="7"><br /></td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style="width: 100%"><b>Copy Roles</b><br /><br /></div>
                                                                <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnDataBound="dgView_001_DataBound" OnHtmlRowCreated="dgView_001_HtmlRowCreated">
                                                                    <Columns>
                                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                                        <dxwgv:GridViewDataTextColumn FieldName="ReportsToType" Caption="Process (Role)" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="CC" Caption="CC" VisibleIndex="2" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="BCC" Caption="BCC" VisibleIndex="3" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkBCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="SMS" Caption="SMS" VisibleIndex="4" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkSMS" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
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
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Alternative"  Visible="true">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <table style="padding: 0px; width: 100%">
                                                                        <tr>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblEmail_005" runat="server" Text="Email template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 260px; text-align: left"><dxe:ASPxComboBox ID="cmbEmail_005" runat="server" ClientInstanceName="cmbEmail_005" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsEmailLU" TextField="Type" ValueField="EmailID" Value='<%# Bind("EmailActID") %>' ValueType="System.Byte" /></td>
                                                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblSMS_005" runat="server" Text="SMS template" /></td>
                                                                            <td style="width: 10px"></td>
                                                                            <td style="width: 250px; text-align: left"><dxe:ASPxComboBox ID="cmbSMS_005" runat="server" ClientInstanceName="cmbSMS_005" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsSMSLU" TextField="Type" ValueField="ID" Value='<%# Bind("SMSActID") %>' ValueType="System.Byte" /></td>
                                                                            <td />
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="7"><br /></td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style="width: 100%"><b>Copy Roles</b><br /><br /></div>
                                                                <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnDataBound="dgView_001_DataBound" OnHtmlRowCreated="dgView_001_HtmlRowCreated">
                                                                    <Columns>
                                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                                        <dxwgv:GridViewDataTextColumn FieldName="ReportsToType" Caption="Process (Role)" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="CC" Caption="CC" VisibleIndex="2" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="BCC" Caption="BCC" VisibleIndex="3" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkBCC" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
                                                                        <dxwgv:GridViewDataCheckColumn FieldName="SMS" Caption="SMS" VisibleIndex="4" Width="48px">
                                                                            <DataItemTemplate>
                                                                                <dxe:ASPxCheckBox ID="chkSMS" runat="server" />
                                                                            </DataItemTemplate>
                                                                        </dxwgv:GridViewDataCheckColumn>
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
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                </TabPages>
                                            </dxtc:ASPxPageControl>
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <img id="btnCreate_001" src="images/create.png" title="Create Record" onclick="dgView_001.AddNewRow();" style="cursor: pointer" />
                                    </StatusBar>
                                </Templates>
                            </dxwgv:ASPxGridView>
                            <br />
                            <div style="text-align: right; width: 100%">
                                <img id="btnBack" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                            </div>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/workflow_006.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Workflow Process Management: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsActionLU" runat="server" />
            <asp:SqlDataSource ID="dsEmailLU" runat="server" />
            <asp:SqlDataSource ID="dsProcessLU" runat="server" />
            <asp:SqlDataSource ID="dsProcessPProcLU" runat="server" />
            <asp:SqlDataSource ID="dsProcessResultLU" runat="server" />
            <asp:SqlDataSource ID="dsProcessRoleLU" runat="server" />
            <asp:SqlDataSource ID="dsProcessTProcLU" runat="server" />
            <asp:SqlDataSource ID="dsSMSLU" runat="server" />
            <asp:SqlDataSource ID="dsStatusLU" runat="server" />
		</form>
    </body>
</html>