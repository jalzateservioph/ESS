<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performance.aspx.vb" Inherits="SmartHR.performance" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
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
        <form id="_performance" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                        window.parent.postUrl(e.result, false);
                    }
                }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcCreate" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcCreate" HeaderText="Scheme Creation">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="padding: 0px; text-align: center; width: 325px">
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="text-align: right; vertical-align: top">Group</td>
                                    <td style="width: 15px"></td>
                                    <td style="text-align: left">
                                        <dxe:ASPxComboBox ID="cmbGroup" runat="server" ClientInstanceName="cmbGroup" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsGroup" TextField="GroupName" ValueField="PerfGroupCode">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                <RequiredField IsRequired="True" ErrorText="This field cannot be empty." />
                                            </ValidationSettings>
                                        </dxe:ASPxComboBox>
                                    </td>
                                </tr>
                                <tr style="height: 3px">
                                    <td colspan="3" />
                                </tr>
                                <tr>
                                    <td style="text-align: right">Name</td>
                                    <td />
                                    <td style="text-align: left">
                                        <dxe:ASPxTextBox ID="txtSchemeName_Create" runat="server" Width="100%" ClientInstanceName="txtSchemeName_Create" MaxLength="80">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                <RequiredField IsRequired="True" ErrorText="This field cannot be empty." />
                                            </ValidationSettings>
                                        </dxe:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr style="height: 3px">
                                    <td colspan="3" />
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top">Description</td>
                                    <td />
                                    <td style="text-align: left"><dxe:ASPxMemo ID="txtSchemeDescription_Create" runat="server" Width="100%" Rows="5" ClientInstanceName="txtSchemeDescription_Create" /></td>
                                </tr>
                                <tr style="height: 3px">
                                    <td colspan="3" />
                                </tr>
                                <tr>
                                    <td style="text-align: right">Workflow</td>
                                    <td style="width: 15px"></td>
                                    <td style="text-align: left">
                                        <dxe:ASPxComboBox ID="cmbWorkflow" runat="server" ClientInstanceName="cmbWorkflow" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsWorkflow" TextField="WFName" ValueField="WFName" />
                                    </td>
                                </tr>
                                <tr style="height: 3px">
                                    <td colspan="3" />
                                </tr>
                                <tr>
                                    <td colspan="2" />
                                    <td style="text-align: left"><dxe:ASPxCheckBox ID="chkScheme_MultiColumn" runat="server" ClientInstanceName="chkScheme_MultiColumn" Text="Side-by-Side evaluation?" /></td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        <div class="centered" style="width: 170px">
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="text-align: right">
                                        <dxe:ASPxButton ID="cmdCreate" runat="server" Text="OK" Width="80px" ClientInstanceName="cmdCreate" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { window.parent.lpPage.Show(); cmbScheme_003.PerformCallback('Create\ ' + cmbGroup.GetValue() + '\ ' + txtSchemeName_Create.GetText() + '\ ' + txtSchemeDescription_Create.GetText() + '\ ' + chkScheme_MultiColumn.GetChecked().toString() + '\ ' + cmbWorkflow.GetValue()); } }" />
                                        </dxe:ASPxButton>
                                    </td>
                                    <td style="width: 10px" />
                                    <td style="text-align: left">
                                        <dxe:ASPxButton ID="cmdCancel_Create" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcCreate.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents CloseUp="function(s, e) { if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } cmbScheme_003.Focus(); }" PopUp="function(s, e) { pcCreate.AdjustSize(); ASPxClientEdit.ClearEditorsInContainerById('pcCreate'); cmbGroup.Focus(); }" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcCopy" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcCopy" HeaderText="Scheme Creation">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="padding: 0px; text-align: center; width: 325px">
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="text-align: right; vertical-align: top">Scheme Name</td>
                                    <td style="width: 15px"></td>
                                    <td style="text-align: left">
                                        <dxe:ASPxTextBox ID="txtSchemeName_Copy" runat="server" Width="100%" ClientInstanceName="txtSchemeName_Copy" MaxLength="80">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                <RequiredField IsRequired="True" ErrorText="This field cannot be empty." />
                                            </ValidationSettings>
                                        </dxe:ASPxTextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        <div class="centered" style="width: 170px">
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="text-align: right">
                                        <dxe:ASPxButton ID="cmdCopy_OK" runat="server" Text="OK" Width="80px" ClientInstanceName="cmdCreate" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { cmbScheme_003.PerformCallback('Copy\ ' + cmbScheme_003.cpValue + '\ ' + txtSchemeName_Copy.GetText()); pcCopy.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                    <td style="width: 10px" />
                                    <td style="text-align: left">
                                        <dxe:ASPxButton ID="cmdCopy_Cancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcCopy.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents CloseUp="function(s, e) { if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } cmbScheme_003.Focus(); }" PopUp="function(s, e) { pcCopy.AdjustSize(); ASPxClientEdit.ClearEditorsInContainerById('pcCopy'); txtSchemeName_Copy.Focus(); }" />
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabEvaluations" runat="server" ClientInstanceName="tabEvaluations" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Results">
                            <TabImage Url="images/performance_008.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                    <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="3" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="4" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" Visible="False" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" Visible="False" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Visible="False" VisibleIndex="7" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EvalDate" Caption="Date" VisibleIndex="8" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Score" Caption="Score" VisibleIndex="9">
                                                <CellStyle HorizontalAlign="Center" />
                                            </dxwgv:GridViewDataTextColumn>
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="True" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
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
                        <dxtc:TabPage Text="History">
                            <TabImage Url="images/performance_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="0" Width="16px">
                                                <CellStyle Paddings-PaddingTop="5px" />
                                                <DataItemTemplate>
                                                    <dxe:ASPxImage ID="cmdSelect_002" runat="server" Cursor="pointer" ToolTip="View Report" ImageUrl="images/select.png" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                </DataItemTemplate>
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateCompleted" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="Completed" Caption="Completed?" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="SchemeCode" Caption="Code" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Name" Caption="Name" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="FullName" Caption="Employee" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="AppraiserType" Caption="Type" VisibleIndex="7" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PathID" Visible="false" VisibleIndex="8" />
                                            <dxwgv:GridViewDataDateColumn FieldName="EvalDate" Visible="false" VisibleIndex="9" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Groups">
                            <TabImage Url="images/performance_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Name" Caption="Group Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="individual" VisibleIndex="3" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Personal" Image-Url="images/user.png" Text="Self Assessments" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="group" VisibleIndex="4" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Group" Image-Url="images/users.png" Text="Group Assignments" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="Overview" VisibleIndex="5" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Overview" Image-Url="images/refresh.png" Text="360 Assessments" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="submit" VisibleIndex="6" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Submit" Image-Url="images/accept.png" Text="Submit Records" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { if (e.buttonID == 'delete_001') { window.parent.ExecDeleteCallback(s, e); } else { window.parent.lpPage.Show(); cpPage.PerformCallback('Setup\ ' + e.buttonID + '\ ' + e.visibleIndex.toString()); processOnServer = false; } }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Setup">
                            <TabImage Url="images/performance_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="width: 25%; text-align: right">Select a Scheme</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left; width: 50%">
                                                <dxe:ASPxComboBox ID="cmbScheme_003" runat="server" ClientInstanceName="cmbScheme_003" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsEvaluation" TextField="Name" ValueField="SchemeCode">
                                                    <ClientSideEvents EndCallback="function(s, e) { if (s.cpRefresh) { dgView_003.Refresh(); } if (s.cpHidePopup) { pcCreate.Hide(); } }" SelectedIndexChanged="function(s, e) { s.cpValue = s.GetValue(); dgView_003.PerformCallback('Clear\ ' + s.GetValue()); }" />
                                                </dxe:ASPxComboBox>
                                            </td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left">
                                                <dxm:ASPxMenu ID="mnuCreate" runat="server">
                                                    <Items>
                                                        <dxm:MenuItem Name="Create" Text="Create">
                                                            <Items>
                                                                <dxm:MenuItem Name="create" Text="a New Scheme" />
                                                                <dxm:MenuItem Name="copy" Text="Copy of Scheme" />
                                                            </Items>
                                                            <SubMenuStyle Cursor="pointer" />
                                                        </dxm:MenuItem>
                                                    </Items>
                                                    <ClientSideEvents ItemClick="function(s, e) { if (e.item.name == 'create') { pcCreate.Show(); } if (e.item.name == 'copy') { pcCopy.Show(); } }" />
                                                </dxm:ASPxMenu>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"><br /></td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold; text-align: right"><dxe:ASPxLabel ID="lblKA" runat="server" Text="Key Areas" /></td>
                                            <td />
                                            <td colspan="3"><hr /></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="KPACode" Caption="Code" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                <PropertiesTextEdit MaxLength="5" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="KPAName" Caption="Name" VisibleIndex="3">
                                                <PropertiesTextEdit MaxLength="500" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="4" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Target" Caption="Target" VisibleIndex="5">
                                                <PropertiesTextEdit MaxLength="100" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="RangeType" Caption="Range Type" VisibleIndex="6">
                                                <PropertiesComboBox DataSourceID="dsRangeType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Description" ValueField="RangeType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Weight" Caption="Weight" VisibleIndex="7">
                                                <PropertiesSpinEdit NumberFormat="Percent" NumberType="Float" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="Required" Caption="Required?" VisibleIndex="8" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
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
                                                <table style="padding: 0px; width: 100%">
                                                    <tr>
                                                        <td style="font-weight: bold; text-align: right; width: 25%"><dxe:ASPxLabel ID="lblCSE" runat="server" Text="Critical Success Elements" /></td>
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CSEName" Caption="Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesTextEdit MaxLength="150" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="3" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Target" Caption="Target" VisibleIndex="4">
                                                            <PropertiesTextEdit MaxLength="100" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="RangeType" Caption="Range Type" VisibleIndex="5">
                                                            <PropertiesComboBox DataSourceID="dsRangeType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Description" ValueField="RangeType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataSpinEditColumn FieldName="Weight" Caption="Weight" VisibleIndex="6">
                                                            <PropertiesSpinEdit NumberFormat="Percent" NumberType="Float" />
                                                        </dxwgv:GridViewDataSpinEditColumn>
                                                        <dxwgv:GridViewDataCheckColumn FieldName="Required" Caption="Required?" VisibleIndex="7" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="8" Width="16px">
                                                            <CustomButtons>
                                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                                <dxtc:ASPxPageControl ID="pageControl_004" runat="server" Width="100%">
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
                                                                        <dxtc:TabPage Text="Description">
                                                                            <ContentCollection>
                                                                                <dxw:ContentControl runat="server">
                                                                                    <div style="text-align: center; width: 100%">
                                                                                        <dxe:ASPxMemo ID="descriptionEditor_004" runat="server" ClientInstanceName="descriptionEditor_004" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                                    </div>
                                                                                </dxw:ContentControl>
                                                                            </ContentCollection>
                                                                        </dxtc:TabPage>
                                                                    </TabPages>
                                                                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                            switch(e.tab.index)
                                                                                                            {
                                                                                                                case 1:
                                                                                                                    descriptionEditor_004.SetFocus();
                                                                                                                    break;
                                                                                                            };
                                                                                                        }" />
                                                                </dxtc:ASPxPageControl>
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
                                            </DetailRow>
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
                                                            <dxtc:TabPage Text="Description">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="descriptionEditor_003" runat="server" ClientInstanceName="descriptionEditor_003" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        descriptionEditor_003.SetFocus();
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
                                                                    dgView_005.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" EndCallback="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); s.GetTab(2).SetVisible(s.cpVisible); s.GetTab(3).SetVisible(s.cpVisible); }" Init="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); s.GetTab(2).SetVisible(s.cpVisible); s.GetTab(3).SetVisible(s.cpVisible); }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsCSEName" runat="server" />
            <asp:SqlDataSource ID="dsEvaluation" runat="server" />
            <asp:SqlDataSource ID="dsGroup" runat="server" />
            <asp:SqlDataSource ID="dsKPACode" runat="server" />
            <asp:SqlDataSource ID="dsRangeType" runat="server" />
            <asp:SqlDataSource ID="dsWorkflow" runat="server" />
        </form>
    </body>
</html>