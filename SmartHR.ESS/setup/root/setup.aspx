<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="setup.aspx.vb" Inherits="SmartHR.setup" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
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
        <form id="_setup" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        var response = e.result.split('\ ');
                        window.parent.reset();
                        if (response[1] != undefined) {
                            window.parent.ShowPopup(response[1]);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxpc:ASPxPopupControl ID="pcText" runat="server" ClientInstanceName="pcText" AllowDragging="true" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="False" Width="375px" HeaderText="Information" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:Table ID="tblText" runat="server" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <dxe:ASPxMemo ID="txtDescription" runat="server" ClientInstanceName="txtDescription" Height="150px" Width="100%" HorizontalAlign="Left" ReadOnly="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Height="5px">
                                <asp:TableCell />
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">
                                    <dxe:ASPxButton ID="cmdText" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                        <ClientSideEvents Click="function(s, e) { pcText.Hide(); }" />
                                    </dxe:ASPxButton>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabSetup" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Global">
                            <TabImage Url="images/setup_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxhf:ASPxHiddenField ID="items_001" runat="server" ClientInstanceName="items_001" />
                                    <asp:Table ID="tblCascade_001" runat="server" Width="100%">
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right">
                                                <dxe:ASPxButton ID="cmdCache" runat="server" Text="Clear Cache" Width="95px" AutoPostBack="False">
                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('ClearCache'); }" />
                                                </dxe:ASPxButton>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Right" Width="90px">
                                                <dxe:ASPxButton ID="cmdCascade_001" runat="server" Text="Cascade" Width="80px" AutoPostBack="False">
                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GlobalSubmitCascade'); }" />
                                                </dxe:ASPxButton>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <br />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="ID" Caption="Item #" SortIndex="0" SortOrder="Ascending" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Assembly" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DataType" Visible="false" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DataTypeName" Visible="false" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Key" Visible="false" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Label" Caption="Item Name" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="7">
                                                <DataItemTemplate>
                                                    <dxe:ASPxLabel id="lblDescription_001" runat="server" ClientInstanceName="lblDescription_001" />
                                                    <dxe:ASPxHyperLink ID="hlDescription_001" runat="server" Text="read more" Font-Underline="true" Cursor="pointer" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="YesNo" Visible="false" VisibleIndex="8" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Int" Visible="false" VisibleIndex="9" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="IntMin" Visible="false" VisibleIndex="10" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="IntMax" Visible="false" VisibleIndex="11" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Dec" Visible="false" VisibleIndex="12">
                                                <PropertiesSpinEdit NumberType="Float" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="DecMin" Visible="false" VisibleIndex="13">
                                                <PropertiesSpinEdit NumberType="Float" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="DecMax" Visible="false" VisibleIndex="14">
                                                <PropertiesSpinEdit NumberType="Float" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="Date" Visible="false" VisibleIndex="15" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateMin" Visible="false" VisibleIndex="16" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateMax" Visible="false" VisibleIndex="17" />
                                            <dxwgv:GridViewDataMemoColumn FieldName="Text" Visible="false" VisibleIndex="18" />
                                            <dxwgv:GridViewDataTextColumn FieldName="GUID" Visible="false" VisibleIndex="19" />
                                            <dxwgv:GridViewDataBinaryImageColumn FieldName="Object" Visible="false" VisibleIndex="20" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Caption="Value" VisibleIndex="21" CellStyle-HorizontalAlign="Left" Width="250px">
                                                <DataItemTemplate>
                                                    <asp:PlaceHolder ID="phControls_001" runat="server" Visible="true" />
                                                </DataItemTemplate>
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
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_001" runat="server" Text="Submit" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GlobalSubmit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Global Forms">
                            <TabImage Url="images/setup_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxhf:ASPxHiddenField ID="items_002" runat="server" ClientInstanceName="items_002" />
                                    <asp:Table ID="tblCascade_002" runat="server" Width="100%">
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right">
                                                <dxe:ASPxButton ID="cmdCascade_002" runat="server" Text="Cascade" Width="80px" AutoPostBack="False">
                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GlobalSubmitCascade'); }" />
                                                </dxe:ASPxButton>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <br />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="ID" Caption="Item #" SortIndex="0" SortOrder="Ascending" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Assembly" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DataType" Visible="false" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DataTypeName" Visible="false" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Key" Visible="false" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Label" Caption="Item Name" VisibleIndex="6" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="Visible" Caption="Visible" VisibleIndex="7">
                                                <DataItemTemplate>
                                                    <dxe:ASPxCheckBox id="chkVisible_002" runat="server" ClientInstanceName="chkVisible_002" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataCheckColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="Editable" Caption="Editable" VisibleIndex="8">
                                                <DataItemTemplate>
                                                    <dxe:ASPxCheckBox id="chkEditable_002" runat="server" ClientInstanceName="chkEditable_002" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataCheckColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="Required" Caption="Required" VisibleIndex="9">
                                                <DataItemTemplate>
                                                    <dxe:ASPxCheckBox id="chkRequired_002" runat="server" ClientInstanceName="chkRequired_002" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataCheckColumn>
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
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_002" runat="server" Text="Submit" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GlobalFormsSubmit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Template">
                            <TabImage Url="images/setup_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxhf:ASPxHiddenField ID="items_003" runat="server" ClientInstanceName="items_003" />
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="text-align: left">
                                                <table style="padding: 0px 0px 0px 0px">
                                                    <tr>
                                                        <td style="text-align: right; width: 175px">Select a template to manage</td>
                                                        <td style="width: 10px"></td>
                                                        <td colspan="2" style="text-align: left; width: 275px">
                                                            <dxe:ASPxComboBox ID="cmbTemplate_003" runat="server" ClientInstanceName="cmbTemplate_003" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsTemplates" TextField="Name" ValueField="Code" SelectedIndex="0">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { var template = cmbTemplate_003.GetValue(); window.parent.lpPage.Show(); cpItems_003.PerformCallback('LoadLocal ' + template); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br /></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dxcp:ASPxCallbackPanel ID="cpItems_003" runat="server" ClientInstanceName="cpItems_003" HideContentOnCallback="false" ShowLoadingPanel="false">
                                                    <ClientSideEvents EndCallback="function(s, e) { window.parent.reset(); }" />
                                                    <PanelCollection>
                                                        <dxp:PanelContent runat="server">
                                                            <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                                <Columns>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="ID" Caption="Item #" SortIndex="0" SortOrder="Ascending" VisibleIndex="0" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Assembly" Visible="false" VisibleIndex="1" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="2" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="DataType" Visible="false" VisibleIndex="2" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="DataTypeName" Visible="false" VisibleIndex="3" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="4" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Key" Visible="false" VisibleIndex="5" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Label" Caption="Item Name" VisibleIndex="6" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="7">
                                                                        <DataItemTemplate>
                                                                            <dxe:ASPxLabel id="lblDescription_003" runat="server" ClientInstanceName="lblDescription_003" />
                                                                            <dxe:ASPxHyperLink ID="hlDescription_003" runat="server" Text="read more" Font-Underline="true" Cursor="pointer" />
                                                                        </DataItemTemplate>
                                                                    </dxwgv:GridViewDataTextColumn>
                                                                    <dxwgv:GridViewDataCheckColumn FieldName="YesNo" Visible="false" VisibleIndex="8" />
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="Int" Visible="false" VisibleIndex="9" />
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="IntMin" Visible="false" VisibleIndex="10" />
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="IntMax" Visible="false" VisibleIndex="11" />
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="Dec" Visible="false" VisibleIndex="12">
                                                                        <PropertiesSpinEdit NumberType="Float" />
                                                                    </dxwgv:GridViewDataSpinEditColumn>
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="DecMin" Visible="false" VisibleIndex="13">
                                                                        <PropertiesSpinEdit NumberType="Float" />
                                                                    </dxwgv:GridViewDataSpinEditColumn>
                                                                    <dxwgv:GridViewDataSpinEditColumn FieldName="DecMax" Visible="false" VisibleIndex="14">
                                                                        <PropertiesSpinEdit NumberType="Float" />
                                                                    </dxwgv:GridViewDataSpinEditColumn>
                                                                    <dxwgv:GridViewDataDateColumn FieldName="Date" Visible="false" VisibleIndex="15" />
                                                                    <dxwgv:GridViewDataDateColumn FieldName="DateMin" Visible="false" VisibleIndex="16" />
                                                                    <dxwgv:GridViewDataDateColumn FieldName="DateMax" Visible="false" VisibleIndex="17" />
                                                                    <dxwgv:GridViewDataMemoColumn FieldName="Text" Visible="false" VisibleIndex="18" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="GUID" Visible="false" VisibleIndex="19" />
                                                                    <dxwgv:GridViewDataBinaryImageColumn FieldName="Object" Visible="false" VisibleIndex="20" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Value" Caption="Value" VisibleIndex="21" CellStyle-HorizontalAlign="Left" Width="250px">
                                                                        <DataItemTemplate>
                                                                            <asp:PlaceHolder ID="phControls_003" runat="server" Visible="true" />
                                                                        </DataItemTemplate>
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
                                                </dxcp:ASPxCallbackPanel>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_003" runat="server" Text="Submit" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('LocalSubmit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Template Forms">
                            <TabImage Url="images/setup_004.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxhf:ASPxHiddenField ID="items_004" runat="server" ClientInstanceName="items_004" />
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="text-align: left">
                                                <table style="padding: 0px 0px 0px 0px">
                                                    <tr>
                                                        <td style="text-align: right; width: 175px">Select a template to manage</td>
                                                        <td style="width: 10px"></td>
                                                        <td colspan="2" style="text-align: left; width: 275px">
                                                            <dxe:ASPxComboBox ID="cmbTemplate_004" runat="server" ClientInstanceName="cmbTemplate_004" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsTemplates" TextField="Name" ValueField="Code" SelectedIndex="0">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { var template = cmbTemplate_004.GetValue(); window.parent.lpPage.Show(); cpItems_004.PerformCallback('LoadLocal ' + template); }" />
                                                            </dxe:ASPxComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br /></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dxcp:ASPxCallbackPanel ID="cpItems_004" runat="server" ClientInstanceName="cpItems_004" HideContentOnCallback="false" ShowLoadingPanel="false">
                                                    <ClientSideEvents EndCallback="function(s, e) { window.parent.reset(); }" />
                                                    <PanelCollection>
                                                        <dxp:PanelContent runat="server">
                                                            <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                                <Columns>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="ID" Caption="Item #" SortIndex="0" SortOrder="Ascending" VisibleIndex="0" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Assembly" Visible="false" VisibleIndex="1" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="2" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="DataType" Visible="false" VisibleIndex="2" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="DataTypeName" Visible="false" VisibleIndex="3" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Category" Caption="Category" VisibleIndex="4" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Key" Visible="false" VisibleIndex="5" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Label" Caption="Item Name" VisibleIndex="6" />
                                                                    <dxwgv:GridViewDataCheckColumn FieldName="Visible" Caption="Visible" VisibleIndex="7">
                                                                        <DataItemTemplate>
                                                                            <dxe:ASPxCheckBox id="chkVisible_004" runat="server" ClientInstanceName="chkVisible_004" />
                                                                        </DataItemTemplate>
                                                                    </dxwgv:GridViewDataCheckColumn>
                                                                    <dxwgv:GridViewDataCheckColumn FieldName="Editable" Caption="Editable" VisibleIndex="8">
                                                                        <DataItemTemplate>
                                                                            <dxe:ASPxCheckBox id="chkEditable_004" runat="server" ClientInstanceName="chkEditable_004" />
                                                                        </DataItemTemplate>
                                                                    </dxwgv:GridViewDataCheckColumn>
                                                                    <dxwgv:GridViewDataCheckColumn FieldName="Required" Caption="Required" VisibleIndex="9">
                                                                        <DataItemTemplate>
                                                                            <dxe:ASPxCheckBox id="chkRequired_004" runat="server" ClientInstanceName="chkRequired_004" />
                                                                        </DataItemTemplate>
                                                                    </dxwgv:GridViewDataCheckColumn>
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
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                </dxcp:ASPxCallbackPanel>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_004" runat="server" Text="Submit" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('LocalFormsSubmit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Configuration">
                            <TabImage Url="images/setup_005.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="OrderID" SortIndex="0" SortOrder="Ascending" Visible="false" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="TemplateElement" Caption="Template Element" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="4" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="up" VisibleIndex="5" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Up" Image-Url="images/move_up.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="down" VisibleIndex="6" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Down" Image-Url="images/move_down.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshData) { s.Refresh(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_005" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_005" ReplacementType="EditFormCancelButton" runat="server" /></span> 
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
                                                                case 3:
                                                                    dgView_004.Refresh();
                                                                    break;
                                                                case 4:
                                                                    dgView_005.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsTemplates" runat="server" />
        </form>
    </body>
</html>