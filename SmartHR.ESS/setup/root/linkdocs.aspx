<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="linkdocs.aspx.vb" Inherits="SmartHR.linkdocs" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
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
        <form id="_linkdocs" runat="server">
            <dxwgv:ASPxGridViewExporter ID="dgExports" runat="server" GridViewID="dgView" />
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlLinkDocs" runat="server" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Category" Caption="Category" VisibleIndex="2">
                                        <PropertiesComboBox DataSourceID="dsCategory" TextField="Text" ValueField="Value" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="DocDescription" Caption="Description" VisibleIndex="3" />
                                    <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="4" Visible="false" />
                                    <dxwgv:GridViewDataCheckColumn FieldName="ESSLinked" VisibleIndex="5" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="6" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="DateLinked" VisibleIndex="7">
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataDateColumn>
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="8" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete" Image-Url="images/delete.png" Text="Delete Record" />
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
                                        <div style="padding: 5px">
                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors" runat="server" />
                                            <br />
                                            <table cellpadding="0" style="text-align: center; width: 100%">
                                                <tr>
                                                    <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Document" /></td>
                                                    <td style="width: 15px"></td>
                                                    <td style="text-align: left">
                                                        <dxuc:ASPxUploadControl ID="upDocument" runat="server" ClientInstanceName="upDocument" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                            <ClientSideEvents FileUploadComplete="function(s, e) { dgView.UpdateEdit(); }" />
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
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { upDocument.Upload(); if (upDocument.GetText().length == 0) { dgView.UpdateEdit(); } }" /></dxe:ASPxImage></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <table style="padding: 2px; width: 100%">
                                            <tr>
                                                <td></td>
                                                <td style="width: 80px">
                                                    <dxe:ASPxButton ID="cmdCreate" runat="server" ClientInstanceName="cmdCreate" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                        <ClientSideEvents Click="function(s, e) { dgView.AddNewRow(); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                                <td style="width: 10px" />
                                                <td style="width: 105px">
                                                    <dxm:ASPxMenu ID="mnuExport" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                        <Items>
                                                            <dxm:MenuItem Name="mnuExport" Text="Export to">
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/linkdocs_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Linked Documents" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsCategory" runat="server" />
        </form>
    </body>
</html>