<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="organisational.aspx.vb" Inherits="SmartHR.organisational" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
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
        <form id="_organisational" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcCostCentre" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcCostCentre" HeaderText="Cost Centre Allocation" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:Table ID="tblCostCentre" runat="server" Width="450px">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Company" Caption="Company" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Allocation" Caption="% Allocation" VisibleIndex="3" />
                                        </Columns>
                                        <Settings ShowFilterBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" />
                                        <Styles>
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                    </dxwgv:ASPxGridView>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Height="5px">
                                <asp:TableCell />
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">
                                    <dxe:ASPxButton ID="cmdOK_CostCentre" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                        <ClientSideEvents Click="function(s, e) { pcCostCentre.Hide(); }" />
                                    </dxe:ASPxButton>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabOrganizational" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Particulars">
                            <TabImage Url="images/organizational_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px 0px 0px 0px">
                                        <tr style="height: 1px">
                                            <td style="width: 135px; text-align: right"></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left"></td>
                                            <td style="width: 135px; text-align: right"></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 250px; text-align: left"></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblJobTitle" runat="server" Text="Job title" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbJobTitle" runat="server" ClientInstanceName="cmbJobTitle" DataSourceID="dsJobTitle" TextField="JobTitle" ValueField="JobTitle" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblJobGrade" runat="server" Text="Job grade" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbJobGrade" runat="server" ClientInstanceName="cmbJobGrade" DataSourceID="dsJobGrade" TextField="JobGrade" ValueField="JobGrade" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblCostCentre" runat="server" Text="Cost centre" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <table cellpadding="0" style="margin-left: -2px; text-align: left; width: 100%">
                                                    <tr>
                                                        <td style="text-align: left">
                                                            <dxe:ASPxComboBox ID="cmbCostCentre" runat="server" ClientInstanceName="cmbCostCentre" DataSourceID="dsCostCentre" TextField="CostCentre" ValueField="CostCentre" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                                        </td>
                                                        <td style="text-align: left">
                                                            <dxe:ASPxButton ID="cmdCostCentre" runat="server" Text="Allocation" Width="80px" AutoPostBack="False">
                                                                <ClientSideEvents Click="function(s, e) { pcCostCentre.Show(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDeptName" runat="server" Text="Department" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbDeptName" runat="server" ClientInstanceName="cmbDeptName" DataSourceID="dsDeptName" TextField="DeptName" ValueField="DeptName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSkill_Level" runat="server" Text="Occupational category" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbSkill_Level" runat="server" ClientInstanceName="cmbSkill_Level" DataSourceID="dsSkill_Level" TextField="OccupCategory" ValueField="OccupCategory" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblAppointype" runat="server" Text="Appointment type" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbAppointype" runat="server" ClientInstanceName="cmbAppointype" DataSourceID="dsAppointype" TextField="AppointmentType" ValueField="AppointmentType" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblPosition" runat="server" Text="Position" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbPosition" runat="server" ClientInstanceName="cmbPosition" DataSourceID="dsPosition" TextField="Position" ValueField="Position" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblLocation" runat="server" Text="Location" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbLocation" runat="server" ClientInstanceName="cmbLocation" DataSourceID="dsLocation" TextField="Location" ValueField="Location" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDateJoinedGroup" runat="server" Text="Date joined group" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteDateJoinedGroup" runat="server" ClientInstanceName="dteDateJoinedGroup" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblAppointdate" runat="server" Text="Appointment date" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteAppointdate" runat="server" ClientInstanceName="dteAppointdate" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblYearsServiceG" runat="server" Text="Years of service (group)" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtYearsServiceG" runat="server" Width="250px" ClientInstanceName="txtYearsServiceG" ReadOnly="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblYearsServiceA" runat="server" Text="Years of service (appointment)" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtYearsServiceA" runat="server" Width="250px" ClientInstanceName="txtYearsServiceA" ReadOnly="true" /></td>
                                            <td />
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Reports To">
                            <TabImage Url="images/organizational_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ReportToCompNum" Caption="Company" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="dsReportToCompNum" TextField="CompanyName" ValueField="CompanyNum">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_002.GetEditor(3).PerformCallback(s.GetValue().toString()); }" />
                                                </PropertiesComboBox>
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ReportToEmpNum" Caption="Employee" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsReportToEmpNum" TextField="Name" ValueField="EmployeeNum" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ReportsToType" Caption="Reports To Type" VisibleIndex="4">
                                                <PropertiesComboBox DataSourceID="dsReportsToType" TextField="ReportsToType" ValueField="ReportsToType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Employee" Visible="false" VisibleIndex="5" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record" />
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
                        <dxtc:TabPage Text="Contracting">
                            <TabImage Url="images/organizational_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
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
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ContractName" Caption="Contract" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="dsContracts" TextField="ContractName" ValueField="ContractName" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="End Date" VisibleIndex="4" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="CurrentContract" Caption="Current Contract?" VisibleIndex="5" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ContractType" Caption="Contract (Type)" VisibleIndex="6">
                                                <PropertiesComboBox DataSourceID="dsContractTypes" TextField="ContractType" ValueField="ContractType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ContractStatus" Caption="Contract (Status)" VisibleIndex="7" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsContractStatus" DropDownStyle="DropDown" TextField="ContractStatus" ValueField="ContractStatus" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="CompanyName" Caption="Company" VisibleIndex="8" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsCompany" DropDownStyle="DropDown" TextField="CompanyName" ValueField="CompanyName" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="DeptName" Caption="Department" VisibleIndex="9" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsContractDept" DropDownStyle="DropDown" TextField="DeptName" ValueField="DeptName" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="10" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsContractCostCentre" DropDownStyle="DropDown" TextField="CostCentre" ValueField="CostCentre" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="11" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsContractJobTitle" DropDownStyle="DropDown" TextField="JobTitle" ValueField="JobTitle" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="12" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesComboBox DataSourceID="dsContractJobGrade" DropDownStyle="DropDown" TextField="JobGrade" ValueField="JobGrade" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Salary" Caption="Salary" VisibleIndex="13" Visible="false">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesSpinEdit DecimalPlaces="2" Increment="0.5" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="14" Width="16px">
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
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxtc:ASPxPageControl ID="pageControl_003" runat="server" Width="100%">
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
                                                            <dxtc:TabPage Text="Remarks">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="remarksEditor_003" runat="server" ClientInstanceName="remarksEditor_003" Rows="5" Text='<%# Eval("Remarks") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        remarksEditor_003.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
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
                <dxhf:ASPxHiddenField ID="items_saved" runat="server" ClientInstanceName="items_saved" />
                <br />
                <div class="centered" style="width: 80px">
                    <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } }" />
                    </dxe:ASPxButton>
                </div>
            </div>
            <asp:SqlDataSource ID="dsAppointype" runat="server" />
            <asp:SqlDataSource ID="dsContractCostCentre" runat="server" />
            <asp:SqlDataSource ID="dsContractDept" runat="server" />
            <asp:SqlDataSource ID="dsContractJobGrade" runat="server" />
            <asp:SqlDataSource ID="dsContractJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsCompany" runat="server" />
            <asp:SqlDataSource ID="dsContracts" runat="server" />
            <asp:SqlDataSource ID="dsContractStatus" runat="server" />
            <asp:SqlDataSource ID="dsContractTypes" runat="server" />
            <asp:SqlDataSource ID="dsCostCentre" runat="server" />
            <asp:SqlDataSource ID="dsDeptName" runat="server" />
            <asp:SqlDataSource ID="dsJobGrade" runat="server" />
            <asp:SqlDataSource ID="dsJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsLocation" runat="server" />
            <asp:SqlDataSource ID="dsPosition" runat="server" />
            <asp:SqlDataSource ID="dsReportToCompNum" runat="server" />
            <asp:SqlDataSource ID="dsReportToEmpNum" runat="server" />
            <asp:SqlDataSource ID="dsReportsToType" runat="server" />
            <asp:SqlDataSource ID="dsSkill_Level" runat="server" />
		</form>
    </body>
</html>