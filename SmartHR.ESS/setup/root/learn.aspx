<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="learn.aspx.vb" Inherits="SmartHR.learn" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
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
        <form id="_learn" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabLearning" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Courses">
                            <TabImage Url="images/learn_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: left">
                                        <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
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
                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="CourseName" Caption="Course" VisibleIndex="2">
                                                    <PropertiesComboBox DataSourceID="dsCourse" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="CourseName" ValueField="CourseName" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="3">
                                                    <PropertiesComboBox DataSourceID="dsProvider" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="ProviderName" ValueField="ProviderName" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="4" />
                                                <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" Visible="false" VisibleIndex="5">
                                                    <EditFormSettings Visible="True" />
                                                </dxwgv:GridViewDataDateColumn>
                                                <dxwgv:GridViewDataSpinEditColumn FieldName="DirectCost" Caption="Budget" VisibleIndex="6" />
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="CourseCategory" Caption="Category" Visible="false" VisibleIndex="7">
                                                    <EditFormSettings Visible="True" />
                                                    <PropertiesComboBox DataSourceID="dsCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="CourseCategory" ValueField="CourseCategory" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewDataCheckColumn FieldName="InternalCourse" Caption="Internal?" Visible="false" VisibleIndex="8">
                                                    <EditFormSettings Visible="True" />
                                                </dxwgv:GridViewDataCheckColumn>
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="IndividualPriority" Caption="Training Priority" Visible="false" VisibleIndex="9">
                                                    <EditFormSettings Visible="True" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewDataComboBoxColumn FieldName="DepartmentalPriority" Caption="Skill Priority" Visible="false" VisibleIndex="10">
                                                    <EditFormSettings Visible="True" />
                                                    <PropertiesComboBox DataSourceID="dsSkills" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="SkillsPriority" ValueField="SkillsPriority" />
                                                </dxwgv:GridViewDataComboBoxColumn>
                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="11" Width="16px">
                                                    <CustomButtons>
                                                        <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                        <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
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
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Assign To (Group)">
                            <TabImage Url="images/learn_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: left">
                                        <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                            <Columns>
                                                <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                                                    <HeaderTemplate>
                                                        <input type="checkbox" onclick="dgView_002.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
                                                    </HeaderTemplate>
                                                    <HeaderStyle Paddings-PaddingTop="1" Paddings-PaddingBottom="1" HorizontalAlign="Center" />
                                                </dxwgv:GridViewCommandColumn>
                                                <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="false" VisibleIndex="1" />
                                                <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="3" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="4" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="5" />
                                                <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="6" />
                                                <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="7" />
                                                <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="8" />
                                                <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="9" />
                                            </Columns>
                                            <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                            <SettingsPager AlwaysShowPager="true" PageSize="25" />
                                            <Styles>
                                                <AlternatingRow Enabled="true" />
                                                <CommandColumn Spacing="8px" />
                                                <CommandColumnItem Cursor="pointer" />
                                                <Header HorizontalAlign="Center" />
                                            </Styles>
                                        </dxwgv:ASPxGridView>
                                    </div>
                                    <div>
                                        <br />
                                    </div>
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_002" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
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
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsCategory" runat="server" />
            <asp:SqlDataSource ID="dsCourse" runat="server" />
            <asp:SqlDataSource ID="dsProvider" runat="server" />
            <asp:SqlDataSource ID="dsSkills" runat="server" />
            <asp:SqlDataSource ID="dsTraining" runat="server" />
		</form>
    </body>
</html>