<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="workflow.aspx.vb" Inherits="SmartHR.workflow" ValidateRequest="false" %>

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
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v11.1" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dxhe" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v11.1" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dxwsc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
        <script language="javascript" type="text/javascript">
            function SubmitPwd() {
                if (ASPxClientEdit.ValidateGroup()) {
                    cpPage.PerformCallback('Password\ ' + passwordEditor_001.GetText());
                }
            }
        </script>
    </head>
    <body onload="window.parent.reset();">
        <form id="_workflow" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        window.parent.reset();
                        var response = e.result.split('\ ');
                        switch(response[0]) {
                            case 'Cascade': {
                                    dgView_001.Refresh();
                                    window.parent.ShowPopup(response[1]);
                                };
                                break;
                            case 'Unlock': {
                                    dgView_003.Refresh();
                                    window.parent.ShowPopup(response[1]);
                                };
                                break;
                            case 'Workflow': {
                                    if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                                        window.parent.postUrl(response[1] + '\ ' + response[2], false);
                                    }
                                };
                                break;
                        };
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabWorkflow" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Email Lookup">
                            <TabImage Url="images/workflow_001.png" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="Type" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Name" Caption="From (name)" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Address" Caption="From (address)" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Subject" Caption="Subject" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Server" Caption="Server" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Port" Caption="Port" VisibleIndex="7" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Username" Caption="Username" Visible="false" VisibleIndex="8">
                                                <EditFormSettings Visible="True" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Password" Caption="Password" Visible="false" VisibleIndex="9">
                                                <EditFormSettings Visible="True" />
                                                <PropertiesTextEdit Password="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
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
                                                    <dxtc:ASPxPageControl runat="server" ID="pageControl_001" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <table style="width: 100%">
                                                                            <tr>
                                                                                <td style="text-align: right">
                                                                                    <span>*</span>
                                                                                    <dxe:ASPxLabel ID="lblType" runat="server" Text="Type" />
                                                                                </td>
                                                                                <td style="width: 10px"></td>
                                                                                <td style="text-align: left; width: 35%">
                                                                                    <dxe:ASPxTextBox ID="typeEditor_001" runat="server" MaxLength="50" Text='<%# Eval("Type") %>' Width="100%">
                                                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                        </ValidationSettings>
                                                                                    </dxe:ASPxTextBox>
                                                                                </td>
                                                                                <td style="text-align: right"></td>
                                                                                <td style="width: 10px"></td>
                                                                                <td style="text-align: left; width: 35%"></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblFromName" runat="server" Text="From (name)" /></td>
                                                                                <td />
                                                                                <td style="text-align: left"><dxe:ASPxTextBox ID="fromnameEditor_001" runat="server" ClientInstanceName="fromnameEditor_001" Width="100%" Text='<%# Eval("Name") %>' /></td>
                                                                                <td style="text-align: right">
                                                                                    <span>*</span>
                                                                                    <dxe:ASPxLabel ID="lblFromAddress" runat="server" Text="From (address)" />
                                                                                </td>
                                                                                <td />
                                                                                <td style="text-align: left">
                                                                                    <dxe:ASPxTextBox ID="fromaddressEditor_001" runat="server" ClientInstanceName="fromaddressEditor_001" Width="100%" Text='<%# Eval("Address") %>'>
                                                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                        </ValidationSettings>
                                                                                    </dxe:ASPxTextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblServer" runat="server" Text="Server" /></td>
                                                                                <td />
                                                                                <td style="text-align: left">
                                                                                    <dxe:ASPxTextBox ID="serverEditor_001" runat="server" ClientInstanceName="serverEditor_001" MaxLength="256" Text='<%# Eval("Server") %>' Width="100%">
                                                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                        </ValidationSettings>
                                                                                    </dxe:ASPxTextBox>
                                                                                </td>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblPort" runat="server" Text="Port" /></td>
                                                                                <td />
                                                                                <td style="text-align: left">
                                                                                    <dxe:ASPxTextBox ID="portEditor_001" runat="server" ClientInstanceName="portEditor_001" MaxLength="5" Text='<%# Eval("Port") %>' Width="125px">
                                                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                        </ValidationSettings>
                                                                                    </dxe:ASPxTextBox>
                                                                                </td>
                                                                            </tr>                                                                        
                                                                            <tr>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblUsername" runat="server" Text="Username" /></td>
                                                                                <td />
                                                                                <td style="text-align: left"><dxe:ASPxTextBox ID="usernameEditor_001" runat="server" ClientInstanceName="usernameEditor_001" MaxLength="30" Text='<%# Eval("Username") %>' Width="100%" /></td>
                                                                                <td style="text-align: right"><dxe:ASPxLabel ID="lblPassword" runat="server" Text="Password" /></td>
                                                                                <td />
                                                                                <td style="text-align: left"><dxe:ASPxTextBox ID="passwordEditor_001" runat="server" ClientInstanceName="passwordEditor_001" Password="true" MaxLength="128" Width="100%" /></td>
                                                                            </tr>                                                                        
                                                                            <tr>
                                                                                <td style="text-align: right">
                                                                                    <span>*</span>
                                                                                    <dxe:ASPxLabel ID="lblSubject" runat="server" Text="Subject" />
                                                                                </td>
                                                                                <td />
                                                                                <td style="text-align: left">
                                                                                    <dxe:ASPxTextBox ID="subjectEditor_001" runat="server" MaxLength="256" Text='<%# Eval("Subject") %>' Width="100%">
                                                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                        </ValidationSettings>
                                                                                    </dxe:ASPxTextBox>
                                                                                </td>
                                                                                <td />
                                                                                <td />
                                                                                <td style="text-align: right">
                                                                                    <dxe:ASPxButton ID="cmdCascade" runat="server" Text="Cascade" AutoPostBack="false">
                                                                                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Cascade\ ' + fromnameEditor_001.GetText() + '\ ' + fromaddressEditor_001.GetText() + '\ ' + serverEditor_001.GetText() + '\ ' + portEditor_001.GetText() + '\ ' + usernameEditor_001.GetText() + '\ ' + passwordEditor_001.GetText()); } }" />
                                                                                    </dxe:ASPxButton>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Email Body">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxhe:ASPxHtmlEditor ID="bodyEditor_001" runat="server" ClientInstanceName="bodyEditor_001" Width="100%" Html='<%# Eval("Body") %>'>
                                                                                <Settings AllowDesignView="false" AllowHtmlView="false" AllowPreview="false" />
                                                                                <SettingsImageUpload>
                                                                                    <ValidationSettings AllowedContentTypes="image/jpeg, image/pjpeg, image/gif, image/png, image/x-png">
                                                                                    </ValidationSettings>
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
                                                                                                        bodyEditor_001.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px" onclick="SubmitPwd();"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
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
                        <dxtc:TabPage Text="SMS Lookup">
                            <TabImage Url="images/workflow_002.png" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="Type" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Body" Caption="Body" VisibleIndex="3">
                                                <DataItemTemplate>
                                                    <dxe:ASPxLabel id="lblBody_002" runat="server" ClientInstanceName="lblBody_002" />
                                                </DataItemTemplate>
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="4" Width="16px">
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
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: right">
                                                                <span>*</span>
                                                                <dxe:ASPxLabel ID="lblType" runat="server" Text="Type" />
                                                            </td>
                                                            <td style="width: 10px"></td>
                                                            <td style="text-align: left">
                                                                <dxe:ASPxTextBox ID="typeEditor_002" runat="server" MaxLength="50" Text='<%# Eval("Type") %>' Width="100%">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right; vertical-align: top"><dxe:ASPxLabel ID="lblBody" runat="server" Text="Body" /></td>
                                                            <td />
                                                            <td style="text-align: left">
                                                                <dxe:ASPxMemo ID="bodyEditor_002" runat="server" ClientInstanceName="bodyEditor_002" Rows="5" Text='<%# Eval("Body") %>' Width="100%" />
                                                            </td>
                                                        </tr>
                                                    </table>
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
                        <dxtc:TabPage Text="Workflow Setup">
                            <TabImage Url="images/workflow_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="WFType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="dsWFType" TextField="WFType" ValueField="WFType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="WFName" Caption="Name" VisibleIndex="3" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="processes" VisibleIndex="4" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Processes" Image-Url="images/workflow_006.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="unlock" VisibleIndex="5" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Unlock" Image-Url="images/default_001.png" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="LockedBy" Visible="false" VisibleIndex="6" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { if (e.buttonID == 'delete_003') { window.parent.ExecDeleteCallback(s, e); } else { window.parent.lpPage.Show(); if (e.buttonID == 'Processes') { cpPage.PerformCallback('Workflow\ ' + e.buttonID + '\ ' + e.visibleIndex.toString()); } else { cpPage.PerformCallback('Unlock\ ' + e.visibleIndex.toString()); } } }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
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
                                                <dxtc:ASPxPageControl ID="pageControl_003" runat="server" Width="100%">
                                                    <TabPages>
                                                        <dxtc:TabPage Text="Types">
                                                            <TabImage Url="images/workflow_004.png" />
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
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
                                                                            <dxwgv:GridViewDataComboBoxColumn FieldName="AppType" Caption="Type" VisibleIndex="2">
                                                                                <PropertiesComboBox DataSourceID="dsWFAppType" TextField="AppType" ValueField="AppType" />
                                                                            </dxwgv:GridViewDataComboBoxColumn>
                                                                            <dxwgv:GridViewDataCheckColumn FieldName="StopBalExc" Caption="Stop Balance?" VisibleIndex="3" />
                                                                            <dxwgv:GridViewDataTextColumn FieldName="MaxNegative" Caption="Max. Negative" VisibleIndex="4" />
                                                                            <dxwgv:GridViewDataTextColumn FieldName="WFType" Visible="false" VisibleIndex="5" />
                                                                            <dxwgv:GridViewDataTextColumn FieldName="WFName" Visible="false" VisibleIndex="6" />
                                                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
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
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                        <dxtc:TabPage Text="Departments">
                                                            <TabImage Url="images/workflow_005.png" />
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
                                                                    <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
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
                                                                            <dxwgv:GridViewDataTextColumn FieldName="WFLUID" Visible="false" VisibleIndex="2" />
                                                                            <dxwgv:GridViewDataComboBoxColumn FieldName="DeptName" Caption="Department" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                                                                                <PropertiesComboBox DataSourceID="dsWFDepartment" EnableIncrementalFiltering="True" TextField="DeptName" ValueField="DeptName" />
                                                                            </dxwgv:GridViewDataComboBoxColumn>
                                                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="4" Width="16px">
                                                                                <CustomButtons>
                                                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_005" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                    </TabPages>
                                                </dxtc:ASPxPageControl>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
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
            </div>
            <asp:SqlDataSource ID="dsWFAppType" runat="server" />
            <asp:SqlDataSource ID="dsWFDepartment" runat="server" />
            <asp:SqlDataSource ID="dsWFType" runat="server" />
        </form>
    </body>
</html>