<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="documentmap.aspx.vb" Inherits="SmartHR.documentmap" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
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
        <form id="_documentmap" runat="server">
            <dxhf:ASPxHiddenField ID="hPanel" runat="server" ClientInstanceName="hPanel" />
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) { if (hPanel.Get('Submit') == 'Group') { dgView_002.Refresh(); ASPxClientEdit.ClearEditorsInContainerById('Group'); } else { ASPxClientEdit.ClearEditorsInContainerById('Individual'); } window.parent.reset(); window.parent.ShowPopup(e.result); }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabDocumentMap" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="History">
                            <TabImage Url="images/documentmap_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: left">
                                        <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                        <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                            <Columns>
                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                <dxwgv:GridViewDataDateColumn FieldName="DateLinked" Caption="Date Assigned" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                                <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="2" />
                                                <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="3" />
                                                <dxwgv:GridViewDataCheckColumn FieldName="Accepted" Caption="Accepted?" VisibleIndex="4" />
                                                <dxwgv:GridViewDataDateColumn FieldName="DateRead" Caption="Date Read" VisibleIndex="5" />
                                                <dxwgv:GridViewDataTextColumn FieldName="VirtualPath" VisibleIndex="6" Visible="false" />
                                                <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                                    <CellStyle Paddings-PaddingTop="5px" />
                                                    <DataItemTemplate>
                                                        <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                    </DataItemTemplate>
                                                    <EditFormSettings Visible="False" />
                                                </dxwgv:GridViewDataTextColumn>
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
                        <dxtc:TabPage Text="Group">
                            <TabImage Url="images/documentmap_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: left">
                                        <table id="Group" style="width: 100%">
                                            <tr>
                                                <td align="center" colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblCategory_002" runat="server" Text="Category" />
                                                            </td>
                                                            <td style="width: 15px"></td>
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbCategory_002" runat="server" DataSourceID="dsCategory" TextField="Description" ValueField="Description" EnableIncrementalFiltering="True" Width="160px">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 3px" />
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblDescription_002" runat="server" Text="Description" />
                                                            </td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxTextBox ID="txtDescription_002" runat="server" MaxLength="50" Width="325px">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 3px" />
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblDocument_002" runat="server" Text="Document" />
                                                            </td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dxuc:ASPxUploadControl ID="upDocument_002" runat="server" ClientInstanceName="upDocument_002" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete" Width="475px">
                                                                    <ClientSideEvents FileUploadComplete="function(s, e) { window.parent.lpPage.Show(); hPanel.Set('Submit', 'Group'); cpPage.PerformCallback('Group'); }" />
                                                                    <ValidationSettings MaxFileSize="4096000" />
                                                                </dxuc:ASPxUploadControl>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"></td>
                                                            <td style="text-align: left">
                                                                <span>*</span>
                                                                <dxe:ASPxLabel ID="lblFileSize_002" runat="server" Text="Maximum file size 4MB" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left" colspan="3">
                                                    <dxe:ASPxLabel ID="lblAssignedTo_002" runat="server" Text="Assign to" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left" colspan="3">
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <dxe:ASPxButton ID="cmdSubmit_002" runat="server" Text="Submit" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateEditorsInContainerById('Group')) { if (upDocument_002.GetText().length > 0) { upDocument_002.Upload(); } } }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Individual">
                            <TabImage Url="images/documentmap_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: left">
                                        <table id="Individual" style="width: 100%">
                                            <tr>
                                                <td align="center" colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblEmployee_003" runat="server" Text="Employee" />
                                                            </td>
                                                            <td style="width: 15px"></td>
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbEmployee" runat="server" ClientInstanceName="cmbEmployee" TextField="Text" ValueField="Value" EnableIncrementalFiltering="true" Width="325px">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 3px" />
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblCategory_003" runat="server" Text="Category" />
                                                            </td>
                                                            <td style="width: 15px"></td>
                                                            <td style="text-align: left">
                                                                <dxe:ASPxComboBox ID="cmbCategory_003" runat="server" DataSourceID="dsCategory" TextField="Description" ValueField="Description" EnableIncrementalFiltering="True" Width="160px">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 3px" />
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblDescription_003" runat="server" Text="Description" />
                                                            </td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxTextBox ID="txtDescription_003" runat="server" MaxLength="50" Width="325px">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 3px" />
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <dxe:ASPxLabel ID="lblDocument_003" runat="server" Text="Document" />
                                                            </td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dxuc:ASPxUploadControl ID="upDocument_003" runat="server" ClientInstanceName="upDocument_003" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete"  Width="475px">
                                                                    <ClientSideEvents FileUploadComplete="function(s, e) { window.parent.lpPage.Show(); hPanel.Set('Submit', 'Individual'); cpPage.PerformCallback('Individual'); }" />
                                                                    <ValidationSettings MaxFileSize="4096000" />
                                                                </dxuc:ASPxUploadControl>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"></td>
                                                            <td style="text-align: left">
                                                                <span>*</span>
                                                                <dxe:ASPxLabel ID="lblFileSize_003" runat="server" Text="Maximum file size 4MB" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><br /></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <dxe:ASPxButton ID="cmdSubmit_003" runat="server" Text="Submit" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateEditorsInContainerById('Individual')) { if (upDocument_003.GetText().length > 0) { upDocument_003.Upload(); } } }" />
                                                    </dxe:ASPxButton>
                                                </td>
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
		</form>
    </body>
</html>