<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="cv.aspx.vb" Inherits="SmartHR.cv" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="styles/index.css" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
</head>
<body onload="window.parent.reset();">
    <form id="_cv" runat="server">

        <div class="padding">
            <dxtc:ASPxPageControl ID="tabCV" runat="server" Width="100%" ActiveTabIndex="0">
                <TabPages>
                    <dxtc:TabPage Text="Employment History">
                        <TabImage Url="images/cv_001.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl1" runat="server">

                                <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                <asp:PlaceHolder ID="phSpace_001" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--On-The-Job Training--%>
                                <dxrp:ASPxRoundPanel ID="panel_001" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_001" runat="server">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="From" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                        <PropertiesDateEdit>

                                                            <ClientSideEvents ValueChanged="function(s,e){var _start,_end; dgView_001.GetRowValues(s.VisibleIndex,'StartDate',_start);dgView_001.GetRowValues(s.VisibleIndex,'EndDate',_start);if(_start > _end){}}" />

                                                        </PropertiesDateEdit>
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="To" VisibleIndex="3">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="Company" Caption="Name of Company" VisibleIndex="4">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="OJTCompAddr" Caption="Company Address" VisibleIndex="5">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="OJTRespon" Caption="Responsibilities" VisibleIndex="6">
                                                        <%--<EditFormSettings ColumnSpan="2" />--%>
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                            <dxtc:ASPxPageControl ID="pageControl_001" runat="server" Width="100%">
                                                                <TabPages>
                                                                    <dxtc:TabPage Text="General">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl2" runat="server">
                                                                                <div style="width: 100%">
                                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Description">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl3" runat="server">
                                                                                <div style="text-align: center; width: 100%">
                                                                                    <dxe:ASPxMemo ID="descriptionEditor_001" runat="server" ClientInstanceName="descriptionEditor_001" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Skills Acquired">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl4" runat="server">
                                                                                <div style="text-align: center; width: 100%">
                                                                                    <dxe:ASPxMemo ID="skillsacquiredEditor_001" runat="server" ClientInstanceName="skillsacquiredEditor_001" Rows="5" Text='<%# Eval("SkillsAcquired") %>' Width="100%" />
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
                                                                                                                case 2:
                                                                                                                    skillsacquiredEditor_001.SetFocus();
                                                                                                                    break;
                                                                                                            };
                                                                                                        }" />
                                                            </dxtc:ASPxPageControl>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="On-The-Job Training" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                                <dxwgv:ASPxGridViewExporter ID="dgExports_007" runat="server" GridViewID="dgView_007" />
                                <asp:PlaceHolder ID="phSpace_007" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--Employment History--%>
                                <dxrp:ASPxRoundPanel ID="panel_007" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_007" runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_007" runat="server" ClientInstanceName="dgView_007" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                                    <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="From" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="To" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Company" Caption="Name of Company" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CVHistoryReason" Caption="Reason for Leaving" VisibleIndex="6" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CVHistorySalary" Caption="Salary" VisibleIndex="7" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="JobTitle" Caption="Position" VisibleIndex="4">
                                                        <PropertiesComboBox DataSourceID="dsJobTitle" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="JobTitle" ValueField="JobTitle" />
                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                    <%--<dxwgv:GridViewDataTextColumn FieldName="Duration" VisibleIndex="6">
                                                            <EditFormSettings Visible="false" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="7" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                            <PropertiesComboBox DataSourceID="dsJobGrade" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="JobGrade" ValueField="JobGrade" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="Department" Caption="Department" VisibleIndex="8" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="ReferenceName" Caption="Contact Person" VisibleIndex="9" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="ReferenceTel" Caption="Contact Number" VisibleIndex="10" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="11" Visible="false">
                                                            <EditFormSettings Visible="false" />
                                                        </dxwgv:GridViewDataMemoColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="SkillsAcquired" Caption="Skills Acquired" VisibleIndex="12" Visible="false">
                                                            <EditFormSettings Visible="false" />
                                                        </dxwgv:GridViewDataMemoColumn>--%>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_007" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                            <dxtc:ASPxPageControl ID="pageControl_007" runat="server" Width="100%">
                                                                <TabPages>
                                                                    <dxtc:TabPage Text="General">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl2" runat="server">
                                                                                <div style="width: 100%">
                                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_007" ReplacementType="EditFormEditors" runat="server" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Description">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl3" runat="server">
                                                                                <div style="text-align: center; width: 100%">
                                                                                    <dxe:ASPxMemo ID="descriptionEditor_007" runat="server" ClientInstanceName="descriptionEditor_007" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Skills Acquired">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl4" runat="server">
                                                                                <div style="text-align: center; width: 100%">
                                                                                    <dxe:ASPxMemo ID="skillsacquiredEditor_007" runat="server" ClientInstanceName="skillsacquiredEditor_007" Rows="5" Text='<%# Eval("SkillsAcquired") %>' Width="100%" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                </TabPages>
                                                                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                            switch(e.tab.index)
                                                                                                            {
                                                                                                                case 1:
                                                                                                                    descriptionEditor_007.SetFocus();
                                                                                                                    break;
                                                                                                                case 2:
                                                                                                                    skillsacquiredEditor_007.SetFocus();
                                                                                                                    break;
                                                                                                            };
                                                                                                        }" />
                                                            </dxtc:ASPxPageControl>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_007" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_007" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="Employment History" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Educational Background">
                        <TabImage Url="images/cv_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl5" runat="server">

                                <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                <asp:PlaceHolder ID="phSpace_002" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--Educational Background--%>
                                <dxrp:ASPxRoundPanel ID="panel_002" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_002" runat="server">
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

                                                    <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="From" VisibleIndex="2" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Qualification" Caption="Level" VisibleIndex="4">
                                                        <PropertiesComboBox DataSourceID="dsQualification" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Qualification" ValueField="Qualification" />
                                                    </dxwgv:GridViewDataComboBoxColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="DateObtained" Caption="To" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />

                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Institution" Caption="School" VisibleIndex="5">
                                                        <PropertiesComboBox DataSourceID="dsInstitution" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Institution" ValueField="Institution" />
                                                    </dxwgv:GridViewDataComboBoxColumn>

                                                    <dxwgv:GridViewDataCheckColumn FieldName="Proof_Provided" Caption="Proof?" VisibleIndex="9" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataCheckColumn>

                                                    <dxwgv:GridViewDataCheckColumn FieldName="HighestQualification" Caption="Highest?" VisibleIndex="10" />

                                                    <dxwgv:GridViewDataTextColumn FieldName="Course" Caption="Course" VisibleIndex="7" Visible="false">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="Awards" Caption="Awards" VisibleIndex="8" Visible="false">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <%--<dxwgv:GridViewDataComboBoxColumn FieldName="NQFLevel" Caption="NQF Level" VisibleIndex="8" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                            <PropertiesComboBox DataSourceID="dsNQFLevel" TextField="NQFLevel" ValueField="NQFLevel" />
                                                        </dxwgv:GridViewDataComboBoxColumn>--%>

                                                    <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="9" Visible="false" />

                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                                <dxwgv:GridViewDataComboBoxColumn FieldName="Subject" Caption="Subject" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                                    <PropertiesComboBox DataSourceID="dsSubject" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Subject" ValueField="Subject" />
                                                                </dxwgv:GridViewDataComboBoxColumn>
                                                                <dxwgv:GridViewDataTextColumn FieldName="Grading" Caption="Level" VisibleIndex="3" />
                                                                <dxwgv:GridViewDataTextColumn FieldName="MarkReceived" Caption="Marks" VisibleIndex="4" />
                                                                <dxwgv:GridViewDataTextColumn FieldName="Grade" Caption="Result" VisibleIndex="5" />
                                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
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
                                                                    <div style="text-align: right; padding: 5px">
                                                                        <span style="cursor: pointer; padding-right: 10px">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_004" ReplacementType="EditFormUpdateButton" runat="server" />
                                                                        </span>
                                                                        <span style="cursor: pointer">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_004" ReplacementType="EditFormCancelButton" runat="server" />
                                                                        </span>
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
                                                            <dxtc:ASPxPageControl ID="pageControl_002" runat="server" Width="100%">
                                                                <TabPages>
                                                                    <dxtc:TabPage Text="General">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl6" runat="server">
                                                                                <div style="width: 100%">
                                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Description">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl ID="ContentControl7" runat="server">
                                                                                <div style="text-align: center; width: 100%">
                                                                                    <dxe:ASPxMemo ID="descriptionEditor_002" runat="server" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
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
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_002" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_002" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="Educational Background" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>

                    <dxtc:TabPage Text="Organizational Affiliations">
                        <TabImage Url="images/cv_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl99" runat="server">

                                <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                <asp:PlaceHolder ID="phSpace_003" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--Organizational Affiliations--%>
                                <dxrp:ASPxRoundPanel ID="Panel_003" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_003" runat="server">
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

                                                    <dxwgv:GridViewDataTextColumn FieldName="ProfScoc" Caption="Description" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" Visible="true">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" Caption="Designation" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" Visible="true">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="DateJoined" Caption="Date of Membership" VisibleIndex="4" Visible="true">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataTextColumn FieldName="MembershipNum" Caption="Reference Number" VisibleIndex="5" Visible="false">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="RenewalDate" Caption="Expiry Date" VisibleIndex="6" Visible="true">
                                                        <EditFormSettings Visible="True" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_003" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_003" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_003" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_003" runat="server" Text="Organizational Affiliations" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>

                    <dxtc:TabPage Text="Licensures/Certifications">
                        <TabImage Url="images/cv_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl9" runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                <asp:PlaceHolder ID="phSpace_005" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--Licensures/Certifications--%>
                                <dxrp:ASPxRoundPanel ID="panel_005" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_005" runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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

                                                    <dxwgv:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="1" FieldName="LicenseCode">
                                                        <EditFormSettings ColumnSpan="4" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="ExamDate" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Exam Date">
                                                        <PropertiesDateEdit DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></PropertiesDateEdit>
                                                        <EditFormSettings ColumnSpan="2" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="2" FieldName="LICRate" PropertiesTextEdit-MaxLength="50" Caption="Grade">
                                                        <PropertiesTextEdit MaxLength="50"></PropertiesTextEdit>
                                                        <DataItemTemplate>
                                                            <div style="overflow: hidden; white-space: nowrap; width: 50px; text-overflow: ellipsis"><%# Container.Text%></div>
                                                        </DataItemTemplate>
                                                        <EditFormSettings ColumnSpan="2" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="LICAcquisitionDate" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Issued Date">
                                                        <PropertiesDateEdit DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></PropertiesDateEdit>
                                                        <EditFormSettings ColumnSpan="4" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="LICExpirationDate" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Expiry Date">
                                                        <PropertiesDateEdit DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></PropertiesDateEdit>
                                                        <EditFormSettings ColumnSpan="4" />
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="4" FieldName="LICLicenseNo" Visible="false" Caption="License No.">
                                                        <EditFormSettings ColumnSpan="4" Visible="True" />
                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton1" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_005" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_003" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_003" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="Licensures/Certifications" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>

                    <dxtc:TabPage Text="Seminars and Trainings Attended">
                        <TabImage Url="images/cv_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl10" runat="server">

                                <dxwgv:ASPxGridViewExporter ID="dgExports_006" runat="server" GridViewID="dgView_006" />
                                <asp:PlaceHolder ID="phSpace_006" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>

                                <%--Seminars and trainings attended--%>
                                <dxrp:ASPxRoundPanel ID="Panel_006" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="pcSpace_006" runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_006" runat="server" ClientInstanceName="dgView_006" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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

                                                    <dxwgv:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="3" FieldName="Description1" Caption="Description" PropertiesTextEdit-MaxLength="256">
                                                        <PropertiesTextEdit MaxLength="256">
                                                        </PropertiesTextEdit>

                                                        <DataItemTemplate>
                                                            <div style="overflow: hidden; white-space: nowrap; width: 300px; text-overflow: ellipsis"><%# Container.Text%></div>
                                                        </DataItemTemplate>

                                                    </dxwgv:GridViewDataTextColumn>

                                                    <dxwgv:GridViewDataDateColumn FieldName="Date" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Date">
                                                        <PropertiesDateEdit DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></PropertiesDateEdit>
                                                    </dxwgv:GridViewDataDateColumn>

                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton2" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_006" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_006" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_006" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_006" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_006" runat="server" Text="Seminars and Trainings Attended" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>

                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                </TabPages>
                <ClientSideEvents ActiveTabChanged="function(s, e) { switch(e.tab.index) { case 0: dgView_001.Refresh(); break; case 1: dgView_002.Refresh(); break; case 2: dgView_003.Refresh(); break; case 3: dgView_005.Refresh(); break; case 4: dgView_006.Refresh(); break; }; }" />
            </dxtc:ASPxPageControl>
        </div>
        <asp:SqlDataSource ID="dsInstitution" runat="server" />
        <asp:SqlDataSource ID="dsJobGrade" runat="server" />
        <asp:SqlDataSource ID="dsJobTitle" runat="server" />
        <asp:SqlDataSource ID="dsNQFLevel" runat="server" />
        <asp:SqlDataSource ID="dsQualification" runat="server" />
        <asp:SqlDataSource ID="dsSubject" runat="server" />
    </form>
</body>
</html>
