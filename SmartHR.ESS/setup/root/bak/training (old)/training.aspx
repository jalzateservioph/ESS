<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="training.aspx.vb" Inherits="SmartHR.training" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
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
        <form id="_training" runat="server">
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabTraining" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Planned">
                            <TabImage Url="images/training_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxrp:ASPxRoundPanel ID="pnlTraining_001" runat="server" ClientInstanceName="pnlTraining_001" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    </Columns>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                    <SettingsPager AlwaysShowPager="True" />
                                                    <Styles>
                                                        <AlternatingRow Enabled="true" />
                                                        <Header HorizontalAlign="Center" />
                                                    </Styles>
                                                    <Templates>
                                                        <StatusBar>
                                                            <table style="padding: 2px; width: 100%">
                                                                <tr>
                                                                    <td></td>
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
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                        <HeaderTemplate>
                                            <table style="height: 16px; width: 100%">
                                                <tr valign="middle">
                                                    <td style="width: 20px">
                                                        <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/training_001.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Planned Training" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                    <br />
                                    <dxrp:ASPxRoundPanel ID="pnlTraining_002" runat="server" ClientInstanceName="pnlTraining_002" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    </Columns>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                    <SettingsPager AlwaysShowPager="True" />
                                                    <Styles>
                                                        <AlternatingRow Enabled="true" />
                                                        <Header HorizontalAlign="Center" />
                                                    </Styles>
                                                    <Templates>
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
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                        <HeaderTemplate>
                                            <table style="height: 16px; width: 100%">
                                                <tr valign="middle">
                                                    <td style="width: 20px">
                                                        <dxe:ASPxImage id="imgPanel_002" runat="server" ImageUrl="images/training_003.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel_002" runat="server" Text="Training Requests" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Completed">
                            <TabImage Url="images/training_005.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                            <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
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
                        <dxtc:TabPage Text="Skills">
                            <TabImage Url="images/training_007.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Skill_Name" Caption="Skill" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="dsSkillName" TextField="SkillName" ValueField="SkillName" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="Start_Date" Caption="Start Date" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="End_Date" Caption="End Date" VisibleIndex="4" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ContactType" Caption="Reference Type" VisibleIndex="5">
                                                <PropertiesComboBox DataSourceID="dsContactType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="ContactType" ValueField="ContactType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Reference_Person" Caption="Reference" VisibleIndex="6" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="CourseCategory" Caption="Category" VisibleIndex="7">
                                                <PropertiesComboBox DataSourceID="dsCourseCategory" TextField="CourseCategory" ValueField="CourseCategory">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { if (!s.GetValue() == undefined) { dgView_004.PerformCallback('<ID=CourseCategory><Value=' + s.GetValue().toString() + '>'); } }" />
                                                </PropertiesComboBox>
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="CourseSubCategory" Caption="Sub Category" VisibleIndex="8">
                                                <PropertiesComboBox DataSourceID="dsCourseSubCategory" TextField="CourseSubCategory" ValueField="CourseSubCategory" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="NQFLevel" Caption="NQF Level" VisibleIndex="9">
                                                <PropertiesComboBox DataSourceID="dsNQFLevel" TextField="NQFLevel" ValueField="NQFLevel" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="MainField" Caption="Field" Visible="false" VisibleIndex="10">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsMainField" TextField="MainField" ValueField="MainField">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { if (!s.GetValue() == undefined) { dgView_004.PerformCallback('<ID=MainField><Value=' + s.GetValue().toString() + '>'); } }" />
                                                </PropertiesComboBox>
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="SubField" Caption="Sub Field" Visible="False"  VisibleIndex="11">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsSubField" TextField="SubField" ValueField="SubField" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
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
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxtc:ASPxPageControl runat="server" ID="pageControl_004" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_004" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Comments">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo runat="server" ID="commentsEditor_004" ClientInstanceName="commentsEditor_004" Rows="5" Text='<%# Eval("Comments") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        commentsEditor_004.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" /></span>
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Courses">
                            <TabImage Url="images/training_009.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                    <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeliveryMethod" Caption="Type" VisibleIndex="3" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="InternalCourse" Caption="Internal?" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Duration" Caption="Duration" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DirectCost" Caption="Cost" VisibleIndex="6" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Application">
                            <TabImage Url="images/training_011.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
						            <table style="color: #000000; font: 9pt Tahoma; width: 100%">
							            <tr>
								            <td colspan="3"><br /></td>
							            </tr>
							            <tr>
								            <td style="text-align: right; width: 48.75%">Course:</td>
								            <td width="2.5%">&nbsp;</td>
								            <td style="text-align: left" width="48.75%">
								                <dxe:ASPxComboBox ID="cmbCourse_006" runat="server" ClientInstanceName="cmbCourse_006" DataSourceID="dsCourseLU" TextField="CourseName" ValueField="CourseName" EnableIncrementalFiltering="True" Width="75%">
								                    <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbProvider_006.PerformCallback(cmbCourse_006.GetValue().toString()); }"></ClientSideEvents>
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
								                </dxe:ASPxComboBox>
								            </td>
							            </tr>
							            <tr>
								            <td style="text-align: right">Provider:</td>
								            <td>&nbsp;</td>
								            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbProvider_006" runat="server" ClientInstanceName="cmbProvider_006" DataSourceID="dsProviders" TextField="ProviderName" ValueField="ProviderName" EnableIncrementalFiltering="True" Width="75%">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
                                                </dxe:ASPxComboBox>
                                            </td>
							            </tr>
							            <tr>
								            <td style="text-align: right">Start date:</td>
								            <td>&nbsp;</td>
								            <td style="text-align: left">
                                                <dxe:ASPxDateEdit ID="dteStart_006" runat="server" ClientInstanceName="dteStart_006">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
                                                </dxe:ASPxDateEdit>
                                            </td>
							            </tr>
							            <tr>
								            <td style="text-align: right">End date:</td>
								            <td>&nbsp;</td>
								            <td style="text-align: left">
                                                <dxe:ASPxDateEdit ID="dteEnd_006" runat="server" ClientInstanceName="dteEnd_006">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
                                                </dxe:ASPxDateEdit>
                                            </td>
							            </tr>
							            <tr>
								            <td colspan="3"><br /></td>
							            </tr>
							            <tr>
								            <td align="center" colspan="3">
                                                <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit">
                                                    <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                                </dxe:ASPxButton>
                                            </td>
							            </tr>
						            </table>
						        </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_001.Refresh();
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_004.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_005.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsContactType" runat="server" />
            <asp:SqlDataSource ID="dsCourseCategory" runat="server" />
            <asp:SqlDataSource ID="dsCourseLU" runat="server" />
            <asp:SqlDataSource ID="dsCourseSubCategory" runat="server" />
            <asp:SqlDataSource ID="dsMainField" runat="server" />
            <asp:SqlDataSource ID="dsNQFLevel" runat="server" />
            <asp:SqlDataSource ID="dsProviders" runat="server" />
            <asp:SqlDataSource ID="dsSkillName" runat="server" />
            <asp:SqlDataSource ID="dsSubField" runat="server" />
		</form>
    </body>
</html>