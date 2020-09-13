<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="news_001.aspx.vb" Inherits="SmartHR.news_001" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v11.1" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dxhe" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v11.1" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dxwsc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_news_001" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlNews" runat="server" Width="100%">
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
                                    <dxwgv:GridViewDataDateColumn FieldName="Date" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Title" Caption="Title" VisibleIndex="3" />
                                    <dxwgv:GridViewDataMemoColumn FieldName="Summary" Caption="Summary" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Article" Caption="Article" VisibleIndex="5" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ImageUrl" VisibleIndex="6" Visible="false" />
                                    <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                        <CellStyle Paddings-PaddingTop="5px" />
                                        <DataItemTemplate>
                                            <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
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
                                    <StatusBar HorizontalAlign="Right" />
                                </Styles>
                                <Templates>
                                    <EditForm>
                                        <div style="padding: 5px; width: 100%">
                                            <dxtc:ASPxPageControl runat="server" ID="pageControl" Width="100%">
                                                <TabPages>
                                                    <dxtc:TabPage Text="General">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <table style="width: 100%">
                                                                    <tr>
                                                                        <td style="text-align: right; width: 35%">
                                                                            <span>*</span>
                                                                            <dxe:ASPxLabel ID="lblDate" runat="server" Text="Date" />
                                                                        </td>
                                                                        <td style="width: 10px" />
                                                                        <td style="text-align: left">
                                                                            <dxe:ASPxDateEdit ID="dateEditor" runat="server" Date='<%# Eval("Date") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: right"><dxe:ASPxLabel ID="lblTitle" runat="server" Text="Title" /></td>
                                                                        <td />
                                                                        <td style="text-align: left"><dxe:ASPxTextBox ID="titleEditor" runat="server" ClientInstanceName="titleEditor" Width="100%" Text='<%# Eval("Title") %>' /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: right; vertical-align: top"><dxe:ASPxLabel ID="lblSummary" runat="server" Text="Summary" /></td>
                                                                        <td />
                                                                        <td style="text-align: left"><dxe:ASPxMemo ID="summaryEditor" runat="server" ClientInstanceName="summaryEditor" Rows="5" Text='<%# Eval("Summary") %>' Width="100%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: right"><dxe:ASPxLabel ID="lblUpload" runat="server" Text="Upload Image" /></td>
                                                                        <td style="width: 15px"></td>
                                                                        <td style="text-align: left">
                                                                            <dxuc:ASPxUploadControl ID="upDocument" runat="server" ClientInstanceName="upDocument" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                                <ClientSideEvents FileUploadComplete="function(s, e) { dgView.UpdateEdit(); }" />
                                                                                <ValidationSettings AllowedContentTypes="image/jpeg, image/pjpeg, image/gif, image/png, image/x-png" MaxFileSize="4096000" />
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
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="News Body">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="text-align: center; width: 100%">
                                                                    <dxhe:ASPxHtmlEditor ID="articleEditor" runat="server" ClientInstanceName="articleEditor" Width="100%" Html='<%# Eval("Article") %>'>
                                                                        <Settings AllowDesignView="false" AllowHtmlView="false" AllowPreview="false" />
                                                                        <SettingsImageUpload UploadImageFolder="~/documents/news">
                                                                            <ValidationSettings AllowedContentTypes="image/jpeg,image/pjpeg,image/gif,image/png,image/x-png" />
                                                                        </SettingsImageUpload>
                                                                        <SettingsSpellChecker Culture="English (United States)">
                                                                            <Dictionaries>
                                                                                <dxwsc:ASPxSpellCheckerISpellDictionary AlphabetPath="~/Dictionaries/EnglishAlphabet.txt" GrammarPath="~/Dictionaries/english.aff" DictionaryPath="~/Dictionaries/american.xlg" CacheKey="ispelldic" Culture="English (United States)" EncodingName="Western European (Windows)" />
                                                                            </Dictionaries>
                                                                        </SettingsSpellChecker>
                                                                    </dxhe:ASPxHtmlEditor>
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                </TabPages>
                                                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                        switch(e.tab.index)
                                                                                        {
                                                                                            case 1:
                                                                                                articleEditor.SetFocus();
                                                                                                break;
                                                                                        };
                                                                                    }" />
                                            </dxtc:ASPxPageControl>
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { upDocument.Upload(); if (upDocument.GetText().length == 0) { dgView.UpdateEdit(); } }" /></dxe:ASPxImage></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <img id="btnCreate" src="images/create.png" title="Create Record" onclick="dgView.AddNewRow();" style="cursor: pointer" />
                                    </StatusBar>
                                </Templates>
                            </dxwgv:ASPxGridView>
                            <br />
                            <div style="text-align: right; width: 100%">
                                <img id="btnBack" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                            </div>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/homepg_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="News: Maintenance" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </form>
    </body>
</html>