<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ohs.aspx.vb" Inherits="SmartHR.ohs" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
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
        <form id="_ohs" runat="server">
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabOHS" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Incidents">
                            <TabImage Url="images/ohs_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
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
                                            <dxwgv:GridViewDataDateColumn FieldName="DateOccurred" Caption="Date Occurred" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateReported" Caption="Date Repoted" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="FilledInBy" Caption="Reported By" VisibleIndex="4" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="FilledInByJobTitle" Caption="Job Title (reported by)" VisibleIndex="5" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="ReportedTo" Caption="Reported To" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ReportedToJobTitle" Caption="Job Title (reported to)" VisibleIndex="7" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="MultipleClassification" Caption="Multiple Class.?" VisibleIndex="8" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataCheckColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="Confirmed" Caption="Confirmed?" VisibleIndex="9" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="HSClassification" Caption="Classification" VisibleIndex="10" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsClassification" TextField="HSClassification" ValueField="HSClassification" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="SubClassification" Caption="Sub Classification" VisibleIndex="11" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsIncSubClassification" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="SubClassification" ValueField="SubClassification" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="RelatedToHazard" Caption="Related to Hazard?" VisibleIndex="12" />
                                            <dxwgv:GridViewDataTextColumn FieldName="RefNo" Caption="Ref #" VisibleIndex="13" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateNotifEmp" Caption="Notified On" VisibleIndex="14" Visible="false">
                                                <EditFormSettings Visible="True" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="SubSubClassification" Caption="Sub Sub Classification" VisibleIndex="15" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsConSubSubClassification" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="SubSubClassification" ValueField="SubSubClassification" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="HSOccupational" Caption="Occupational" VisibleIndex="16" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsConHSOccupational" TextField="HSOccupational" ValueField="HSOccupational" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="17" Width="16px">
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
                                                <dxtc:ASPxPageControl ID="pageControl_001" runat="server" Width="100%">
                                                    <TabPages>
                                                        <dxtc:TabPage Text="Bodily Location">
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
                                                                    <div style="text-align: left; width: 100%">
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
                                                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                                                <dxwgv:GridViewDataComboBoxColumn FieldName="BodilyLocation" Caption="Location" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                                                    <PropertiesComboBox DataSourceID="dsBodilyLocation" TextField="BodilyLocation" ValueField="BodilyLocation" />
                                                                                </dxwgv:GridViewDataComboBoxColumn>
                                                                                <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="3">
                                                                                    <PropertiesMemoEdit Rows="5" />
                                                                                </dxwgv:GridViewDataMemoColumn>
                                                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="4" Width="16px">
                                                                                    <CustomButtons>
                                                                                        <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
                                                                                    </CustomButtons>
                                                                                </dxwgv:GridViewCommandColumn>
                                                                            </Columns>
                                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                                            <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                                                    <div style="text-align:right; padding: 5px">
                                                                                        <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_004" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                                        <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_004" ReplacementType="EditFormCancelButton" runat="server" /></span> 
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
                                                                    </div>
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                        <dxtc:TabPage Text="Case Notes">
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
                                                                    <div style="text-align: left; width: 100%">
                                                                        <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="98%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                                                <dxwgv:GridViewDataDateColumn FieldName="NoteDate" Caption="Note Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                                                <dxwgv:GridViewDataComboBoxColumn FieldName="NoteType" Caption="Type" VisibleIndex="3">
                                                                                    <PropertiesComboBox DataSourceID="dsIncNoteType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="NoteType" ValueField="NoteType" />
                                                                                </dxwgv:GridViewDataComboBoxColumn>
                                                                                <dxwgv:GridViewDataTextColumn FieldName="ContactName" Caption="Contact Name" VisibleIndex="4" />
                                                                                <dxwgv:GridViewDataTextColumn FieldName="AttendedBy" Caption="Attended By" VisibleIndex="5" />
                                                                                <dxwgv:GridViewDataDateColumn FieldName="FollowUpDate" Caption="Follow up Date" VisibleIndex="6" />
                                                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                                                    <CustomButtons>
                                                                                        <dxwgv:GridViewCommandColumnCustomButton ID="delete_005" Image-Url="images/delete.png" Text="Delete Record" />
                                                                                    </CustomButtons>
                                                                                </dxwgv:GridViewCommandColumn>
                                                                            </Columns>
                                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                                            <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                                                        <dxtc:ASPxPageControl runat="server" ID="pageControl_005" Width="100%">
                                                                                            <TabPages>
                                                                                                <dxtc:TabPage Text="General">
                                                                                                    <ContentCollection>
                                                                                                        <dxw:ContentControl runat="server">
                                                                                                            <div style="width: 100%">
                                                                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_005" ReplacementType="EditFormEditors" runat="server" />
                                                                                                            </div>
                                                                                                        </dxw:ContentControl>
                                                                                                    </ContentCollection>
                                                                                                </dxtc:TabPage>
                                                                                                <dxtc:TabPage Text="Notes">
                                                                                                    <ContentCollection>
                                                                                                        <dxw:ContentControl runat="server">
                                                                                                            <div style="text-align: center; width: 100%">
                                                                                                                <dxe:ASPxMemo runat="server" ID="notetextEditor_005" Rows="5" Text='<%# Eval("NoteText") %>' Width="100%" />
                                                                                                            </div>
                                                                                                        </dxw:ContentControl>
                                                                                                    </ContentCollection>
                                                                                                </dxtc:TabPage>                                                                   
                                                                                            </TabPages>
                                                                                        </dxtc:ASPxPageControl>
                                                                                    </div>
                                                                                    <div style="text-align:right; padding: 5px">
                                                                                        <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_005" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                                        <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_005" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                                    </div>
                                                                                </EditForm>
                                                                                <StatusBar>
                                                                                    <table style="padding: 2px; width: 100%">
                                                                                        <tr>
                                                                                            <td></td>
                                                                                            <td style="width: 80px">
                                                                                                <dxe:ASPxButton ID="cmdCreate_005" runat="server" ClientInstanceName="cmdCreate_005" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                                                    <ClientSideEvents Click="function(s, e) { dgView_005.AddNewRow(); }" />
                                                                                                </dxe:ASPxButton>
                                                                                            </td>
                                                                                            <td style="width: 10px" />
                                                                                            <td style="width: 105px">
                                                                                                <dxm:ASPxMenu ID="mnuExport_005" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                                                    <Items>
                                                                                                        <dxm:MenuItem Name="mnuExport_005" Text="Export to">
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
                                                                    </div>
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                    </TabPages>
                                                </dxtc:ASPxPageControl>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxtc:ASPxPageControl runat="server" ID="pageControl_001" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Details">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <table style="width: 100%">
                                                                                <tr>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblTypeCode" runat="server" Text="Type" /></td>
                                                                                    <td style="width: 10px"></td>
                                                                                    <td style="text-align: left" style="width: 25%"><dxe:ASPxComboBox ID="typecodeEditor_001" runat="server" ClientInstanceName="typecodeEditor_001" DataSourceID="dsConTypeCode" TextField="TypeCode" ValueField="TypeCode" Value='<%# Eval("TypeCode") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblCause" runat="server" Text="Cause" /></td>
                                                                                    <td style="width: 10px"></td>
                                                                                    <td style="text-align: left" style="width: 25%"><dxe:ASPxComboBox ID="causeEditor_001" runat="server" DataSourceID="dsConCause" TextField="Cause" ValueField="Cause" Value='<%# Eval("Cause") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblBreakdownAgency" runat="server" Text="Breakdown agency" /></td>
                                                                                    <td style="width: 10px"></td>
                                                                                    <td style="text-align: left" style="width: 25%"><dxe:ASPxComboBox ID="breakdownagencyEditor_001" runat="server" DataSourceID="dsConBreakdownAgency" TextField="BreakdownAgency" ValueField="BreakdownAgency" Value='<%# Eval("BreakdownAgency") %>' Width="100%" /></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblLocation" runat="server" Text="Location" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxComboBox ID="locationEditor_001" runat="server" DataSourceID="dsConLocation" TextField="Location" ValueField="Location" Value='<%# Eval("Location") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblWitness" runat="server" Text="Witness" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxTextBox ID="witnessEditor_001" runat="server" Width="100%" Text='<%# Eval("Witness") %>' /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblItemObject" runat="server" Text="Item or Object" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxComboBox ID="itemobjectEditor_001" runat="server" DataSourceID="dsConItemObject" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="ItemObject" ValueField="ItemObject" Value='<%# Eval("ItemObject") %>' Width="100%" /></td>
                                                                                </tr>
                                                                                <tr style="vertical-align: top">
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblDescription" runat="server" Text="Description" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxMemo runat="server" ID="typedescriptionEditor_001" Rows="5" Text='<%# Eval("TypeDescription") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblWorkplacePart" runat="server" Text="Comments (workplace)" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxMemo runat="server" ID="workplacepartEditor_001" Rows="5" Text='<%# Eval("WorkplacePart") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblWorker" runat="server" Text="Comments (worker)" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxMemo runat="server" ID="workeractionEditor_001" Rows="5" Text='<%# Eval("WorkerAction") %>' Width="100%" /></td>
                                                                                </tr>
                                                                                <tr style="vertical-align: top">
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblWhatHappend" runat="server" Text="Comments (what happened)" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxMemo runat="server" ID="whathappenedEditor_001" Rows="5" Text='<%# Eval("WhatHappened") %>' Width="100%" /></td>
                                                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblProcedureFollowed" runat="server" Text="Comments (procedure followed)" /></td>
                                                                                    <td />
                                                                                    <td style="text-align: left"><dxe:ASPxMemo runat="server" ID="procedurefollowedEditor_001" Rows="5" Text='<%# Eval("ProcedureFollowed") %>' Width="100%" /></td>
                                                                                    <td colspan="3"></td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        typecodeEditor_001.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Surveillance">
                            <TabImage Url="images/ohs_002.png" />
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
                                            <dxwgv:GridViewDataDateColumn FieldName="TestDate" Caption="Date Tested" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="TestName" Caption="Test Name" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsMedTestName" TextField="TestName" ValueField="TestName" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="TestType" Caption="Test Type" VisibleIndex="4" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="PerformedBy" Caption="Performed By" VisibleIndex="5">
                                                <PropertiesComboBox DataSourceID="dsMedPerformedBy" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="PerformedBy" ValueField="PerformedBy" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="PerformedByContact" Caption="Performed By (contact)" VisibleIndex="6" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsMedPerformedByContact" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="PerformedByContact" ValueField="PerformedByContact" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                <dxwgv:ASPxGridView ID="dgView_006" runat="server" ClientInstanceName="dgView_006" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="TestElement" Caption="Element" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ActualValue" Caption="Value" VisibleIndex="3">
                                                            <PropertiesComboBox DataSourceID="dsMedActualValue" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="ActualValue" ValueField="ActualValue" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="UnitOfMeassure" Caption="Unit of Meassure" VisibleIndex="4">
                                                            <PropertiesComboBox DataSourceID="dsMedUnitOfMeassure" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="UnitOfMeassure" ValueField="UnitOfMeassure" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataCheckColumn FieldName="Normal" Caption="Normal?" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataCheckColumn FieldName="Abnormal" Caption="Abnormal?" VisibleIndex="6" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_006" Image-Url="images/delete.png" Text="Delete Record" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_006" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_006" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_006" runat="server" ClientInstanceName="cmdCreate_006" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { dgView_006.AddNewRow(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <td style="width: 10px" />
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
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_002" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_002" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_002" runat="server" ClientInstanceName="cmdCreate_002" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_002.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
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
                        <dxtc:TabPage Text="Consultations">
                            <TabImage Url="images/ohs_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_007" runat="server" GridViewID="dgView_007" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                            <dxwgv:GridViewDataDateColumn FieldName="ConsultationDate" Caption="Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ConsultationType" Caption="Type" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsConConsultationType" TextField="ConsultationType" ValueField="ConsultationType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Classification" Caption="Classification" VisibleIndex="4" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsClassification" TextField="HSClassification" ValueField="HSClassification" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="DateDiagnosed" Caption="Date Diagnosed" VisibleIndex="5" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Diagnosis" Caption="Diagnosis" VisibleIndex="6">
                                                <PropertiesComboBox DataSourceID="dsConDiagnosis" TextField="DiagnosisCode" ValueField="DiagnosisCode" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Consultatation" Caption="Consultation" VisibleIndex="7" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsConConsultatation" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="Consultatation" ValueField="Consultatation" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="DateNextExam" Caption="Next Exam. Date" VisibleIndex="8" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="AttendedBy" Caption="Attended By" VisibleIndex="9" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsAttendedBy" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="AttendedBy" ValueField="AttendedBy" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Referral" Caption="Referral" VisibleIndex="10" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsConReferral" DropDownStyle="DropDown" EnableIncrementalFiltering="true" TextField="Referral" ValueField="Referral" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="11" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                <dxwgv:ASPxGridView ID="dgView_007" runat="server" ClientInstanceName="dgView_007" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="BodilyLocation" Caption="Location" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsBodilyLocation" TextField="BodilyLocation" ValueField="BodilyLocation" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="3">
                                                            <PropertiesMemoEdit Rows="5" />
                                                        </dxwgv:GridViewDataMemoColumn>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="4" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_007" Image-Url="images/delete.png" Text="Delete Record" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_007" ReplacementType="EditFormEditors" runat="server" />
                                                            </div>
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_007" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_007" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_007" runat="server" ClientInstanceName="cmdCreate_007" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { dgView_007.AddNewRow(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <td style="width: 10px" />
                                                                    <td style="width: 105px">
                                                                        <dxm:ASPxMenu ID="mnuExport_007" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_007" Text="Export to">
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
                                                    <dxtc:ASPxPageControl runat="server" ID="pageControl_003" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Cause">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo runat="server" ID="causeEditor_003" Rows="5" Text='<%# Eval("Cause") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                        </TabPages>
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_003" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_003" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_003" runat="server" ClientInstanceName="cmdCreate_003" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_003.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_003" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_003" Text="Export to">
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
            <asp:SqlDataSource ID="dsAttendedBy" runat="server" />
            <asp:SqlDataSource ID="dsClassification" runat="server" />
            <asp:SqlDataSource ID="dsBodilyLocation" runat="server" />
            <asp:SqlDataSource ID="dsConBreakdownAgency" runat="server" />
            <asp:SqlDataSource ID="dsConCause" runat="server" />
            <asp:SqlDataSource ID="dsConConsultatation" runat="server" />
            <asp:SqlDataSource ID="dsConConsultationType" runat="server" />
            <asp:SqlDataSource ID="dsConDiagnosis" runat="server" />
            <asp:SqlDataSource ID="dsConHSOccupational" runat="server" />
            <asp:SqlDataSource ID="dsConItemObject" runat="server" />
            <asp:SqlDataSource ID="dsConLocation" runat="server" />
            <asp:SqlDataSource ID="dsConReferral" runat="server" />
            <asp:SqlDataSource ID="dsConSubSubClassification" runat="server" />
            <asp:SqlDataSource ID="dsConTypeCode" runat="server" />
            <asp:SqlDataSource ID="dsIncNoteType" runat="server" />
            <asp:SqlDataSource ID="dsIncSubClassification" runat="server" />
            <asp:SqlDataSource ID="dsMedActualValue" runat="server" />
            <asp:SqlDataSource ID="dsMedPerformedBy" runat="server" />
            <asp:SqlDataSource ID="dsMedPerformedByContact" runat="server" />
            <asp:SqlDataSource ID="dsMedTestName" runat="server" />
            <asp:SqlDataSource ID="dsMedUnitOfMeassure" runat="server" />
        </form>
    </body>
</html>