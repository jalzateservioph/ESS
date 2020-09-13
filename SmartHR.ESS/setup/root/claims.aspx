<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="claims.aspx.vb" Inherits="SmartHR.claims" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_claims" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabClaims" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Claims: Register">
                            <TabImage Url="images/claims_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="Date" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Type" Caption="Type" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsClaimType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="ItemType" ValueField="ItemType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Username" Caption="Captured By" VisibleIndex="4">
                                                <EditFormSettings Visible="false" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" VisibleIndex="5">
                                                <EditFormSettings Visible="false" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="6" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="7" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="8" Width="16px">
                                                <CellStyle Paddings-PaddingTop="5px" />
                                                <DataItemTemplate>
                                                    <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                </DataItemTemplate>
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
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
                                                <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ItemType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsClaimTypeSub" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="SubItemType" ValueField="SubItemType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="ItemName" Caption="Description" VisibleIndex="3">
                                                            <PropertiesTextEdit MaxLength="50" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataSpinEditColumn FieldName="Amount" Caption="Amount" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="5" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="6" Visible="false" />
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
                                                    <GroupSummary>
                                                        <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                                    </GroupSummary>
                                                    <TotalSummary>
                                                        <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                                    </TotalSummary>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" ShowFooter="true" ShowGroupPanel="true" />
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
                                                    </Styles>
                                                    <Templates>
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
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_004" runat="server" ClientInstanceName="cmdCreate_004" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { dgView_004.AddNewRow(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <td style="width: 10px" />
                                                                    <td style="width: 105px">
                                                                        <dxm:ASPxMenu ID="mnuExport_004" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_004" Text="Export to">
                                                                                    <Items>
                                                                                        <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                                        <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                                        <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                                    </Items>
                                                                                    <SubMenuStyle Cursor="pointer" />
                                                                                </dxm:MenuItem>
                                                                            </Items>
                                                                        </dxm:ASPxMenu>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </StatusBar>
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
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_001" runat="server" ClientInstanceName="cmdCreate_001" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_001.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_001" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_001" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Claims: Status">
                            <TabImage Url="images/claims_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_006" runat="server" GridViewID="dgView_006" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="Date" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Type" Caption="Type" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsClaimType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="ItemType" ValueField="ItemType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="4">
                                                <EditFormSettings Visible="false" />
                                            </dxwgv:GridViewDataTextColumn>
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
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                        <SettingsEditing NewItemRowPosition="Bottom" />
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
                                                <dxwgv:ASPxGridView ID="dgView_006" runat="server" ClientInstanceName="dgView_006" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnHtmlCommandCellPrepared="dgView_002_HtmlCommandCellPrepared" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ItemType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsClaimTypeSub" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="SubItemType" ValueField="SubItemType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="ItemName" Caption="Description" VisibleIndex="3">
                                                            <PropertiesTextEdit MaxLength="50" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataSpinEditColumn FieldName="Amount" Caption="Amount" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="5" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="6" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="254" Width="16px">
                                                            <CellStyle Paddings-PaddingTop="5px" />
                                                            <DataItemTemplate>
                                                                <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                            </DataItemTemplate>
                                                            <EditFormSettings Visible="False" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="255" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_006" Image-Url="images/delete.png" Text="Delete Record" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpRefreshParent) { dgView_002.Refresh(); } else { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } } }" />
                                                    <GroupSummary>
                                                        <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                                    </GroupSummary>
                                                    <TotalSummary>
                                                        <dxwgv:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                                    </TotalSummary>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" ShowFooter="true" ShowGroupPanel="true" />
                                                    <SettingsBehavior AutoExpandAllGroups="true" />
                                                    <SettingsCookies StoreColumnsVisiblePosition="false" />
                                                    <SettingsDetail IsDetailGrid="true" />
                                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                                    <SettingsPager AlwaysShowPager="True" />
                                                    <Styles>
                                                        <AlternatingRow Enabled="true" />
                                                        <CommandColumn Spacing="8px" />
                                                        <CommandColumnItem Cursor="pointer" />
                                                        <Header HorizontalAlign="Center" />
                                                    </Styles>
                                                    <Templates>
                                                        <EditForm>
                                                            <div style="padding: 5px; width: 100%">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_006" ReplacementType="EditFormEditors" runat="server" />
                                                            </div>
                                                            <br />
                                                            <table cellpadding="0" style="text-align: center; width: 100%">
                                                                <tr>
                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                                    <td style="width: 15px"></td>
                                                                    <td style="text-align: left">
                                                                        <dxuc:ASPxUploadControl ID="upDocument_006" runat="server" ClientInstanceName="upDocument_006" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_001_FileUploadComplete">
                                                                            <ClientSideEvents FileUploadComplete="function(s, e) { dgView_006.UpdateEdit(); }" />
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
                                                                <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { upDocument_006.Upload(); if (upDocument_006.GetText().length == 0) { dgView_006.UpdateEdit(); } }" /></dxe:ASPxImage></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 105px">
                                                                        <dxm:ASPxMenu ID="mnuExport_006" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_006" Text="Export to">
                                                                                    <Items>
                                                                                        <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                                        <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                                        <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                                    </Items>
                                                                                    <SubMenuStyle Cursor="pointer" />
                                                                                </dxm:MenuItem>
                                                                            </Items>
                                                                        </dxm:ASPxMenu>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </StatusBar>
                                                    </Templates>
                                                </dxwgv:ASPxGridView>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxtc:ASPxPageControl ID="pageControl_002" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                        <br />
                                                                        <table cellpadding="0" style="text-align: center; width: 100%">
                                                                            <tr>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                                                <td style="width: 15px"></td>
                                                                                <td style="text-align: left">
                                                                                    <dxuc:ASPxUploadControl ID="upDocument_002" runat="server" ClientInstanceName="upDocument_002" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_001_FileUploadComplete">
                                                                                        <ClientSideEvents FileUploadComplete="function(s, e) { dgView_002.UpdateEdit(); }" />
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
                                                                            <dxe:ASPxMemo ID="descriptionEditor_002" runat="server" ClientInstanceName="descriptionEditor_002" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        descriptionEditor_002.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { upDocument_002.Upload(); if (upDocument_002.GetText().length == 0) { dgView_002.UpdateEdit(); } }" /></dxe:ASPxImage></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_002" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_002" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Claim Types">
                            <TabImage Url="images/claims_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_008" runat="server" GridViewID="dgView_008" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_009" runat="server" GridViewID="dgView_009" />
                                    <dxwgv:ASPxGridView ID="dgView_008" runat="server" ClientInstanceName="dgView_008" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataTextColumn FieldName="ItemType" Caption="Item Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="3" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_008" Image-Url="images/delete.png" Text="Delete Record" />
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
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <DetailRow>
                                                <table style="padding: 0px; width: 100%">
                                                    <tr>
                                                        <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Sub Items</td>
                                                        <td style="width: 10px"></td>
                                                        <td><hr /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 5px" />
                                                    </tr>
                                                </table>
                                                <dxwgv:ASPxGridView ID="dgView_009" runat="server" ClientInstanceName="dgView_009" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="SubItemType" Caption="Sub Item" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="3" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_009" Image-Url="images/delete.png" Text="Delete Record" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
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
                                                        <EditForm>
                                                            <div style="padding: 5px; width: 100%">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_009" ReplacementType="EditFormEditors" runat="server" />
                                                            </div>
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_009" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_009" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_009" runat="server" ClientInstanceName="cmdCreate_009" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { dgView_009.AddNewRow(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <td style="width: 10px" />
                                                                    <td style="width: 105px">
                                                                        <dxm:ASPxMenu ID="mnuExport_009" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_009" Text="Export to">
                                                                                    <Items>
                                                                                        <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                                        <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                                        <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                                    </Items>
                                                                                    <SubMenuStyle Cursor="pointer" />
                                                                                </dxm:MenuItem>
                                                                            </Items>
                                                                        </dxm:ASPxMenu>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </StatusBar>
                                                    </Templates>
                                                </dxwgv:ASPxGridView>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_008" ReplacementType="EditFormEditors" runat="server" />
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_008" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_008" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_008" runat="server" ClientInstanceName="cmdCreate_008" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_008.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_008" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_008" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Custom Columns">
                            <TabImage Url="images/claims_004.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_010" runat="server" GridViewID="dgView_010" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_011" runat="server" GridViewID="dgView_011" />
                                    <dxwgv:ASPxGridView ID="dgView_010" runat="server" ClientInstanceName="dgView_010" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataTextColumn FieldName="Name" Caption="Name" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Label" VisibleIndex="3" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="IsView" Caption="Read-only?" VisibleIndex="4" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="AssemblyID" Caption="Control Type" VisibleIndex="5">
                                                <PropertiesComboBox DataSourceID="dsAssembly" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="FriendlyName" ValueField="ID" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="DataTypeID" Caption="Data Type" VisibleIndex="6">
                                                <PropertiesComboBox DataSourceID="dsDataType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Typename" ValueField="ID" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Size" Caption="Data (Size)" VisibleIndex="7" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="GroupTypeID" Caption="Summarize?" VisibleIndex="8">
                                                <PropertiesComboBox DataSourceID="dsGroupType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Description" ValueField="ID" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Index" Visible="false" SortIndex="0" SortOrder="Ascending" VisibleIndex="9" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="up" VisibleIndex="10" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Up" Image-Url="images/move_up.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="down" VisibleIndex="11" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Down" Image-Url="images/move_down.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_010" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsBehavior AllowSort="false" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                        <SettingsEditing NewItemRowPosition="Bottom" />
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
                                                        <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Claim Types</td>
                                                        <td style="width: 10px"></td>
                                                        <td><hr /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 5px" />
                                                    </tr>
                                                </table>
                                                <dxwgv:ASPxGridView ID="dgView_011" runat="server" ClientInstanceName="dgView_011" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ItemType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsClaimType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="ItemType" ValueField="ItemType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="3" Width="16px">
                                                            <DeleteButton Visible="True">
                                                                <Image Url="images/delete.png" />
                                                            </DeleteButton>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents EndCallback="function(s, e) { if (s.cpCancelEdit) { dgView_011.CancelEdit(); } if (s.cpRefreshDelete) { dgView_011.Refresh(); } }" />
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
                                                        <EditForm>
                                                            <div style="padding: 5px; width: 100%">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_011" ReplacementType="EditFormEditors" runat="server" />
                                                            </div>
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_011" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_011" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_011" runat="server" ClientInstanceName="cmdCreate_011" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { dgView_011.AddNewRow(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <td style="width: 10px" />
                                                                    <td style="width: 105px">
                                                                        <dxm:ASPxMenu ID="mnuExport_011" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_011" Text="Export to">
                                                                                    <Items>
                                                                                        <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                                        <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                                        <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                                        <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                                    </Items>
                                                                                    <SubMenuStyle Cursor="pointer" />
                                                                                </dxm:MenuItem>
                                                                            </Items>
                                                                        </dxm:ASPxMenu>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </StatusBar>
                                                    </Templates>
                                                </dxwgv:ASPxGridView>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxtc:ASPxPageControl ID="pageControl_010" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_010" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Calculate">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="sqlcalculateEditor_010" runat="server" ClientInstanceName="sqlcalculateEditor_010" Rows="5" Text='<%# Eval("SQLCalculate") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Select">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="sqlselectEditor_010" runat="server" ClientInstanceName="sqlselectEditor_010" Rows="5" Text='<%# Eval("SQLSelect") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                         
                                                            <dxtc:TabPage Text="Update">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="sqlupdateEditor_010" runat="server" ClientInstanceName="sqlupdateEditor_010" Rows="5" Text='<%# Eval("SQLUpdate") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                         
                                                            <dxtc:TabPage Text="Description">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="descriptionEditor_010" runat="server" ClientInstanceName="descriptionEditor_010" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                         
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        sqlcalculateEditor_010.SetFocus();
                                                                                                        break;
                                                                                                    case 2:
                                                                                                        sqlselectEditor_010.SetFocus();
                                                                                                        break;
                                                                                                    case 3:
                                                                                                        sqlupdateEditor_010.SetFocus();
                                                                                                        break;
                                                                                                    case 4:
                                                                                                        descriptionEditor_010.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_010" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_010" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_010" runat="server" ClientInstanceName="cmdCreate_010" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_010.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_010" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_010" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_008.CollapseAllDetailRows();
                                                                    dgView_010.CollapseAllDetailRows();
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_001.CollapseAllDetailRows();
                                                                    dgView_008.CollapseAllDetailRows();
                                                                    dgView_010.CollapseAllDetailRows();
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_001.CollapseAllDetailRows();
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_010.CollapseAllDetailRows();
                                                                    dgView_008.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_001.CollapseAllDetailRows();
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_008.CollapseAllDetailRows();
                                                                    dgView_010.Refresh();
                                                                    break;
                                                            };
                                                        }" EndCallback="function(s, e) { s.GetTab(2).SetVisible(s.cpVisible); s.GetTab(3).SetVisible(s.cpVisible); }" Init="function(s, e) { s.GetTab(2).SetVisible(s.cpVisible); s.GetTab(3).SetVisible(s.cpVisible); }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsAssembly" runat="server" />
            <asp:SqlDataSource ID="dsClaimType" runat="server" />
            <asp:SqlDataSource ID="dsClaimTypeSub" runat="server" />
            <asp:SqlDataSource ID="dsDataType" runat="server" />
            <asp:SqlDataSource ID="dsGroupType" runat="server" />
        </form>
    </body>
</html>