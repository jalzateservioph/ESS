<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_001.aspx.vb" Inherits="SmartHR.performanceman_001" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
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
        <form id="_performance" runat="server">
            <dxhf:ASPxHiddenField ID="items_004" runat="server" ClientInstanceName="items_004" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        var response = e.result.split('\ ');
                        window.parent.reset();
                        if (response[0] == 'Back') {
                            if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                                window.parent.postUrl(response[1] + '\ ' + response[2], false);
                            }
                        }
                        else {
                            if (response[1] != undefined) {
                                window.parent.ShowPopup(response[1]);
                            }
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabEvaluations" runat="server" Width="100%" 
                    ActiveTabIndex="0">
                    <TabPages>
                        <dxtc:TabPage Text="Self Assessments">
                            <TabImage Url="images/performance_004.png" />
<TabImage Url="images/performance_004.png"></TabImage>
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 150px">Scheme</td>
                                            <td style="width: 10px"></td>
                                            <td>
                                                <dxe:ASPxComboBox ID="cmbSchemeAll_001" runat="server" ClientInstanceName="cmbSchemeAll_001" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsScheme" TextField="Name" ValueField="SchemeCode" Width="375px">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { items_001.Set('SelectedKey', s.GetValue()); dgView_001.PerformCallback(''); }" />
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { items_001.Set(&#39;SelectedKey&#39;, s.GetValue()); dgView_001.PerformCallback(&#39;&#39;); }"></ClientSideEvents>
                                                </dxe:ASPxComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                                                <HeaderTemplate>
                                                    <input type="checkbox" onclick="dgView_001.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
                                                </HeaderTemplate>
                                                <HeaderStyle Paddings-PaddingTop="1" Paddings-PaddingBottom="1" 
                                                    HorizontalAlign="Center" >
<Paddings PaddingTop="1px" PaddingBottom="1px"></Paddings>
                                                </HeaderStyle>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EmployeeNum" Caption="Employee ID" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="4" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="5" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CareerLevel" Caption="Career Level" 
                                                VisibleIndex="6" Visible="false" />
<dxwgv:GridViewDataTextColumn FieldName="Position" ShowInCustomizationForm="True" Caption="Position" VisibleIndex="7"></dxwgv:GridViewDataTextColumn>
<dxwgv:GridViewDataTextColumn FieldName="JobTitle" ShowInCustomizationForm="True" Caption="Job Title" VisibleIndex="8" 
                                                Visible="False"></dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" 
                                                VisibleIndex="9" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" 
                                                VisibleIndex="10" />
                                            <dxwgv:GridViewDataTextColumn FieldName="SubDivision" Caption="Department" 
                                                VisibleIndex="11" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" 
                                                VisibleIndex="12">
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn Caption="Scheme" FieldName="Scheme" 
                                                ShowInCustomizationForm="True" VisibleIndex="13">
                                                <DataItemTemplate>
                                                    <dxe:ASPxComboBox ID="cmbScheme_001" runat="server" 
                                                        ClientInstanceName="cmbScheme_001" DataSourceID="dsScheme" 
                                                        DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TextField="Name" 
                                                        ValueField="SchemeCode" Width="100%" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataTextColumn>
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" />

<SettingsPager AlwaysShowPager="True"></SettingsPager>

<Settings ShowHeaderFilterButton="True" ShowFilterBar="Visible"></Settings>

                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
<AlternatingRow Enabled="True"></AlternatingRow>

<Header HorizontalAlign="Center"></Header>

<CommandColumn Spacing="8px"></CommandColumn>

<CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                        </Styles>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_001" runat="server" Text="Update" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); items_001.Set('Submitted', true); cpPage.PerformCallback('Submit'); }" />
<ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); items_001.Set(&#39;Submitted&#39;, true); cpPage.PerformCallback(&#39;Submit&#39;); }"></ClientSideEvents>
                                        </dxe:ASPxButton>
                                    </div>
                                    <dxhf:ASPxHiddenField ID="items_001" runat="server" ClientInstanceName="items_001" />
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Group Assignments">
                            <TabImage Url="images/performance_005.png" />
<TabImage Url="images/performance_005.png"></TabImage>
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 150px">Scheme</td>
                                            <td style="width: 10px"></td>
                                            <td>
                                                <dxe:ASPxComboBox ID="cmbSchemeAll_002" runat="server" ClientInstanceName="cmbSchemeAll_002" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsScheme" TextField="Name" ValueField="SchemeCode" Width="375px">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {console.log('key',s.GetValue(),s); items_004.Set('SelectedKey', s.GetValue()); dgView_004.PerformCallback(''); }" />
<ClientSideEvents SelectedIndexChanged="function(s, e) {console.log('key 2',s.GetValue(),s);  items_004.Set(&#39;SelectedKey&#39;, s.GetValue()); dgView_004.PerformCallback(&#39;&#39;); }"></ClientSideEvents>
                                                </dxe:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="height: 5px" />
                                        </tr>
                                        <tr>
                                            <td style="font-size: 10pt; font-weight: bold; text-align: right">Type</td>
                                            <td />
                                            <td>
                                                <dxe:ASPxComboBox ID="cmbTypeAll_002" runat="server" ClientInstanceName="cmbTypeAll_002" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" Width="175px">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {console.log('type',s.GetValue(),s);  items_004.Set('SelectedKeyType', s.GetValue()); dgView_004.PerformCallback(''); }" />
<ClientSideEvents SelectedIndexChanged="function(s, e) {console.log('type 2',s.GetValue(),s);  items_004.Set(&#39;SelectedKeyType&#39;, s.GetValue()); dgView_004.PerformCallback(&#39;&#39;); }"></ClientSideEvents>
                                                    <Items>
                                                        <dxe:ListEditItem Value="peer" Text="Peer" />
                                                        <dxe:ListEditItem Value="subordinate" Text="Subordinate" />
                                                        <dxe:ListEditItem Value="superior" Text="Superior" />
                                                    </Items>
                                                </dxe:ASPxComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="false" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="2" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="3" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="7" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="8" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                        <SettingsPager AlwaysShowPager="True" />

<SettingsPager AlwaysShowPager="True"></SettingsPager>

<Settings ShowHeaderFilterButton="True" ShowFilterBar="Visible"></Settings>

<SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>

                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
<AlternatingRow Enabled="True"></AlternatingRow>

<Header HorizontalAlign="Center"></Header>

<CommandColumn Spacing="8px"></CommandColumn>

<CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                        </Styles>
                                        <Templates>
                                            <DetailRow>
                                                <table style="padding: 0px; width: 100%">
                                                    <tr>
                                                        <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 150px">Will be Assessing</td>
                                                        <td style="width: 10px"></td>
                                                        <td><hr /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 5px" />
                                                    </tr>
                                                </table>
                                                <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="False" OnDataBound="dgView_001_DataBound" OnHtmlRowCreated="dgView_001_HtmlRowCreated">
                                                    <Columns>
                                                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                                                            <HeaderTemplate>
                                                                <input type="checkbox" onclick="dgView_004.SelectAllRowsOnPage(this.checked);if(this.checked){ items_004.Set('SelectedAll', true);}else{ items_004.Set('SelectedAll', false);}" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="ApprType" Caption="Type" VisibleIndex="10">
                                                            <DataItemTemplate>
                                                                <dxe:ASPxComboBox ID="cmbApprType_004" runat="server" ClientInstanceName="cmbApprType_004" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" />
                                                            </DataItemTemplate>
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="Scheme" Caption="Scheme" VisibleIndex="11">
                                                            <DataItemTemplate>
                                                                <dxe:ASPxComboBox ID="cmbScheme_004" runat="server" ClientInstanceName="cmbScheme_004" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsScheme" TextField="Name" ValueField="SchemeCode" />
                                                            </DataItemTemplate>
                                                        </dxwgv:GridViewDataTextColumn>
                                                    </Columns>
                                                    <ClientSideEvents SelectionChanged="function(s, e) {  }" />
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
                                                <div class="centered" style="width: 80px">
                                                    <dxe:ASPxButton ID="cmdSubmit_004" runat="server" Text="Update" Width="80px" AutoPostBack="False">
                                                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); items_004.Set('Submitted', true); cpPage.PerformCallback('Submit'); }" />
                                                    </dxe:ASPxButton>
                                                </div>
                                            </DetailRow>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_002" runat="server" Text="Update" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
<ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback(&#39;Submit&#39;); }"></ClientSideEvents>
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="360 Assessments">
                            <TabImage Url="images/performance_006.png" />
<TabImage Url="images/performance_006.png"></TabImage>
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="False">
<ClientSideEvents EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="false" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="2" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="3" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="7" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="8" />
                                        </Columns>
                                        <ClientSideEvents EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                        <SettingsPager AlwaysShowPager="True" />

<SettingsPager AlwaysShowPager="True"></SettingsPager>

<Settings ShowHeaderFilterButton="True" ShowFilterBar="Visible"></Settings>

<SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>

                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
<AlternatingRow Enabled="True"></AlternatingRow>

<Header HorizontalAlign="Center"></Header>

<CommandColumn Spacing="8px"></CommandColumn>

<CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                        </Styles>
                                        <Templates>
                                            <DetailRow>
                                                <table style="padding: 0px; width: 100%">
                                                    <tr>
                                                        <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 125px">Assessed By</td>
                                                        <td style="width: 10px"></td>
                                                        <td><hr /></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 5px" />
                                                    </tr>
                                                </table>
                                                <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCellEditorInitialize="dgView_001_CellEditorInitialize" OnCustomColumnDisplayText="dgView_001_CustomColumnDisplayText" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating" OnStartRowEditing="dgView_001_StartRowEditing">
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
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ApprCompanyNum" Caption="Company" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsCompNum" TextField="CompanyName" ValueField="CompanyNum">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_005.GetEditor(3).PerformCallback(s.GetValue().toString()); }" />
                                                            </PropertiesComboBox>
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ApprEmployeeNum" Caption="Employee" VisibleIndex="3">
                                                            <PropertiesComboBox DataSourceID="dsEmpNum" TextField="Name" ValueField="EmployeeNum" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ApprType" Caption="Type" VisibleIndex="4">
                                                            <PropertiesComboBox>
															    <Items>
																    <dxe:ListEditItem Text="Self" Value="self" />
																    <dxe:ListEditItem Text="Peer" Value="peer" />
																    <dxe:ListEditItem Text="Subordinate" Value="subordinate" />
																    <dxe:ListEditItem Text="Superior" Value="superior" />
                                                                </Items>
                                                            </PropertiesComboBox>
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="SchemeCode" Caption="Scheme" VisibleIndex="5">
                                                            <PropertiesComboBox DataSourceID="dsScheme" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Name" ValueField="SchemeCode" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="Employee" Visible="false" VisibleIndex="6" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_005" Image-Url="images/delete.png" Text="Delete Record" />
                                                            </CustomButtons>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpRefreshParent) { dgView_003.Refresh(); } else { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } } }" />
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_005" ReplacementType="EditFormEditors" runat="server" />
                                                            </div>
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { dgView_005.UpdateEdit(); }" /></dxe:ASPxImage></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <img id="btnCreate_005" src="images/create.png" title="Create Record" onclick="dgView_005.AddNewRow();" style="cursor: pointer" />
                                                        </StatusBar>
                                                    </Templates>
                                                </dxwgv:ASPxGridView>
                                            </DetailRow>
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
                                                                    cmbSchemeAll_001.SetSelectedIndex(-1);
                                                                    items_001.Remove('SelectedKey');
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_003.CollapseAllDetailRows();
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 1:
                                                                    cmbSchemeAll_002.SetSelectedIndex(-1);
                                                                    cmbTypeAll_002.SetSelectedIndex(-1);
                                                                    items_004.Remove('SelectedKey');
                                                                    items_004.Remove('SelectedKeyType');
                                                                    dgView_003.CollapseAllDetailRows();
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" />

<ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    cmbSchemeAll_001.SetSelectedIndex(-1);
                                                                    items_001.Remove(&#39;SelectedKey&#39;);
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_003.CollapseAllDetailRows();
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 1:
                                                                    cmbSchemeAll_002.SetSelectedIndex(-1);
                                                                    cmbTypeAll_002.SetSelectedIndex(-1);
                                                                    items_004.Remove(&#39;SelectedKey&#39;);
                                                                    items_004.Remove(&#39;SelectedKeyType&#39;);
                                                                    dgView_003.CollapseAllDetailRows();
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_002.CollapseAllDetailRows();
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }"></ClientSideEvents>
                </dxtc:ASPxPageControl>
                <br />
                <div style="text-align: right; width: 100%">
                    <img id="btnBack" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                </div>
            </div>
            <%--<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
            <asp:SqlDataSource ID="dsCompNum" runat="server" />
            <asp:SqlDataSource ID="dsEmpNum" runat="server" />
            <asp:SqlDataSource ID="dsScheme" runat="server" />
		</form>
	</body>
</html>