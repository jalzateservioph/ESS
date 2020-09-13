<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="timesheetsman.aspx.vb" Inherits="SmartHR.timesheetsman" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
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
        <form id="_timesheetsman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlTimesheets" runat="server" ClientInstanceName="pnlTimesheets" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px" Visible="false">
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
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Start" Caption="Start" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Until" Caption="Until" VisibleIndex="3" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Type" Caption="Type" VisibleIndex="4">
                                        <PropertiesComboBox DataSourceID="dsTimesheetType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="ItemType" ValueField="ItemType" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="Username" Caption="Captured By" VisibleIndex="5">
                                        <EditFormSettings Visible="false" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" VisibleIndex="6">
                                        <EditFormSettings Visible="false" />
                                    </dxwgv:GridViewDataDateColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="7" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="8" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="9" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px" Visible="false">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Hidden" ShowStatusBar="Hidden" />
                                <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                <SettingsEditing NewItemRowPosition="Bottom" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                    <StatusBar HorizontalAlign="Right" />
                                </Styles>
                                <Templates>
                                    <DetailRow>
                                        <table style="padding: 0px; width: 100%">
                                            <tr>
                                                <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Days</td>
                                                <td style="width: 10px"></td>
                                                <td><hr /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 5px" />
                                            </tr>
                                        </table>
                                        <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnDetailRowExpandedChanged="dgView_001_DetailRowExpandedChanged" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                                <dxwgv:GridViewDataDateColumn FieldName="ItemDate" Caption="Day" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                    <PropertiesDateEdit DisplayFormatString="ddd" />
                                                </dxwgv:GridViewDataDateColumn>
                                                <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="3" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="4" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="254" Width="16px">
                                                    <CellStyle Paddings-PaddingTop="5px" />
                                                    <DataItemTemplate>
                                                        <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                    </DataItemTemplate>
                                                    <EditFormSettings Visible="False" />
                                                </dxwgv:GridViewDataTextColumn>
                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="255" Width="16px">
                                                    <CustomButtons>
                                                        <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
                                                    </CustomButtons>
                                                </dxwgv:GridViewCommandColumn>
                                            </Columns>
                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                            <Settings ShowHeaderFilterButton="true" />
                                            <SettingsBehavior AutoExpandAllGroups="true"  />
                                            <SettingsCookies StoreColumnsVisiblePosition="false" />
                                            <SettingsDetail AllowOnlyOneMasterRowExpanded="true" IsDetailGrid="true" ShowDetailRow="true" />
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
                                                            <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Hours</td>
                                                            <td style="width: 10px"></td>
                                                            <td><hr /></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 5px" />
                                                        </tr>
                                                    </table>
                                                    <dxwgv:ASPxGridView ID="dgView_012" runat="server" ClientInstanceName="dgView_012" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ItemName" Caption="Description" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                                <PropertiesComboBox DataSourceID="dsItemName" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="ItemName" ValueField="ItemName" />
                                                            </dxwgv:GridViewDataComboBoxColumn>
                                                            <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="3" Visible="false" />
                                                            <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="4" Visible="false" />
                                                            <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="254" Width="16px">
                                                                <CellStyle Paddings-PaddingTop="5px" />
                                                                <DataItemTemplate>
                                                                    <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                                </DataItemTemplate>
                                                                <EditFormSettings Visible="False" />
                                                            </dxwgv:GridViewDataTextColumn>
                                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="255" Width="16px">
                                                                <CustomButtons>
                                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_012" Image-Url="images/delete.png" Text="Delete Record" />
                                                                </CustomButtons>
                                                            </dxwgv:GridViewCommandColumn>
                                                        </Columns>
                                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                        <Settings ShowHeaderFilterButton="true" ShowStatusBar="Visible" ShowFooter="true" ShowGroupPanel="true" />
                                                        <SettingsBehavior AutoExpandAllGroups="true"  />
                                                        <SettingsCookies StoreColumnsVisiblePosition="false" />
                                                        <SettingsDetail IsDetailGrid="true" />
                                                        <SettingsEditing NewItemRowPosition="Bottom" />
                                                        <SettingsPager AlwaysShowPager="True" />
                                                        <Styles>
                                                            <AlternatingRow Enabled="true" />
                                                            <CommandColumn Spacing="8px" />
                                                            <CommandColumnItem Cursor="pointer" />
                                                            <Header HorizontalAlign="Center" />
                                                            <StatusBar HorizontalAlign="Right" />
                                                        </Styles>
                                                        <Templates>
                                                            <EditForm>
                                                                <div style="padding: 5px; width: 100%">
                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_012" ReplacementType="EditFormEditors" runat="server" />
                                                                </div>
                                                                <br />
                                                                <table cellpadding="0" style="text-align: center; width: 100%">
                                                                    <tr>
                                                                        <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                                        <td style="width: 15px"></td>
                                                                        <td style="text-align: left">
                                                                            <dxuc:ASPxUploadControl ID="upDocument_012" runat="server" ClientInstanceName="upDocument_012" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_001_FileUploadComplete">
                                                                                <ClientSideEvents FileUploadComplete="function(s, e) { dgView_012.UpdateEdit(); }" />
                                                                                <ValidationSettings MaxFileSize="4096000" />
                                                                            </dxuc:ASPxUploadControl>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2"></td>
                                                                        <td style="text-align: left">
                                                                            <span>*</span>
                                                                            <dxe:ASPxLabel ID="lblDocument" runat="server" Text="Maximum file size 4MB" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <div style="text-align:right; padding: 5px">
                                                                    <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { if (upDocument_012.GetText().length == 0) { dgView_012.UpdateEdit(); } else { upDocument_012.Upload(); } }" /></dxe:ASPxImage></span>
                                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                </div>
                                                            </EditForm>
                                                            <StatusBar>
                                                                <img id="btnCreate_012" src="images/create.png" title="Create Record" onclick="dgView_012.AddNewRow();" style="cursor: pointer" />
                                                            </StatusBar>
                                                        </Templates>
                                                    </dxwgv:ASPxGridView>
                                                </DetailRow>
                                                <EditForm>
                                                    <div style="padding: 5px; width: 100%">
                                                        <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_004" ReplacementType="EditFormEditors" runat="server" />
                                                    </div>
                                                    <br />
                                                    <table cellpadding="0" style="text-align: center; width: 100%">
                                                        <tr>
                                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                            <td style="width: 15px"></td>
                                                            <td style="text-align: left">
                                                                <dxuc:ASPxUploadControl ID="upDocument_004" runat="server" ClientInstanceName="upDocument_004" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_001_FileUploadComplete">
                                                                    <ClientSideEvents FileUploadComplete="function(s, e) { dgView_004.UpdateEdit(); }" />
                                                                    <ValidationSettings MaxFileSize="4096000" />
                                                                </dxuc:ASPxUploadControl>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"></td>
                                                            <td style="text-align: left">
                                                                <span>*</span>
                                                                <dxe:ASPxLabel ID="lblDocument" runat="server" Text="Maximum file size 4MB" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <div style="text-align:right; padding: 5px">
                                                        <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { if (upDocument_004.GetText().length == 0) { dgView_004.UpdateEdit(); } else { upDocument_004.Upload(); } }" /></dxe:ASPxImage></span>
                                                        <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                    </div>
                                                </EditForm>
                                            </Templates>
                                        </dxwgv:ASPxGridView>
                                    </DetailRow>
                                    <EditForm>
                                        <div style="padding: 5px; width: 100%">
                                            <dxtc:ASPxPageControl ID="pageControl_001" runat="server" Width="100%">
                                                <TabPages>
                                                    <dxtc:TabPage Text="General">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                </div>
                                                                <br />
                                                                <table cellpadding="0" style="text-align: center; width: 100%">
                                                                    <tr>
                                                                        <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                                        <td style="width: 15px"></td>
                                                                        <td style="text-align: left">
                                                                            <dxuc:ASPxUploadControl ID="upDocument_001" runat="server" ClientInstanceName="upDocument_001" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_001_FileUploadComplete">
                                                                                <ClientSideEvents FileUploadComplete="function(s, e) { dgView_001.UpdateEdit(); }" />
                                                                                <ValidationSettings MaxFileSize="4096000" />
                                                                            </dxuc:ASPxUploadControl>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2"></td>
                                                                        <td style="text-align: left">
                                                                            <span>*</span>
                                                                            <dxe:ASPxLabel ID="lblDocument" runat="server" Text="Maximum file size 4MB" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Description">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="text-align: center; width: 100%">
                                                                    <dxe:ASPxMemo ID="descriptionEditor_001" runat="server" ClientInstanceName="descriptionEditor_001" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>                                                                
                                                </TabPages>
                                                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                        switch(e.tab.index)
                                                                                        {
                                                                                            case 1:
                                                                                                descriptionEditor_001.SetFocus();
                                                                                                break;
                                                                                        };
                                                                                    }" />
                                            </dxtc:ASPxPageControl>
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { upDocument_001.Upload(); if (upDocument_001.GetText().length == 0) { dgView_001.UpdateEdit(); } }" /></dxe:ASPxImage></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <img id="btnCreate_001" src="images/create.png" title="Create Record" onclick="dgView_001.AddNewRow();" style="cursor: pointer" />
                                    </StatusBar>
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/timesheets_005.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Timesheet Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsAssembly" runat="server" />
            <asp:SqlDataSource ID="dsDataType" runat="server" />
            <asp:SqlDataSource ID="dsGroupType" runat="server" />
            <asp:SqlDataSource ID="dsItemName" runat="server" />
            <asp:SqlDataSource ID="dsTimesheetType" runat="server" />
        </form>
    </body>
</html>