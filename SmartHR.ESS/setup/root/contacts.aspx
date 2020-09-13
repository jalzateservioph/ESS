<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="contacts.aspx.vb" Inherits="SmartHR.contacts" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxDataView" TagPrefix="dxdv" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dxt" %>
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
        <form id="_contacts" runat="server">
            <dxhf:ASPxHiddenField ID="hPanel" runat="server" ClientInstanceName="hPanel" />
            <dxt:ASPxTimer ID="tmrThread" runat="server" ClientInstanceName="tmrThread" Enabled="false" Interval="2500">
                <ClientSideEvents Tick="function(s, e) { cpPage.PerformCallback('Progress'); }" />
            </dxt:ASPxTimer>
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    var response = e.result.split('\ ');
                    switch(response[0]) {
                        case 'Progress': {
                                var pos = parseInt(response[1]);
                                window.parent.pbProgress.SetPosition(pos);
                                if (pos == 100) {
                                    tmrThread.SetEnabled(false);
                                    window.parent.pcProgress.Hide();
                                    window.parent.ShowPopup(response[2]);
                                }
                            };
                            break;
                        case 'Back': case 'Next': {
                                if (tabEmail.GetVisible()) {
                                    tabEmail.SetActiveTab(tabEmail.GetTab(parseInt(response[1])));
                                }
                                if (tabSMS.GetVisible()) {
                                    tabSMS.SetActiveTab(tabSMS.GetTab(parseInt(response[1])));
                                }
                            };
                            break;
                        case 'Submit': {
                                if (response[1] == 'Progress') {
                                    window.parent.pcProgress.Show();
                                    tmrThread.SetEnabled(true);
                                }
                                if (response[1] == '000 SUCCESS') {
                                    window.parent.ShowPopup(response[1]);
                                }
                            };
                            break;
                    };
                    window.parent.reset();
                }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                    <Columns>
                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" CellStyle-VerticalAlign="Top" VisibleIndex="0">
                            <HeaderTemplate>
                                <input type="checkbox" onclick="dgView.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" >
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                        </dxwgv:GridViewCommandColumn>
                        <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="1" />
                        <dxwgv:GridViewDataBinaryImageColumn FieldName="EmployeePicture" Caption="Employee" PropertiesBinaryImage-EmptyImage-Url="images/photo_helpx.png" VisibleIndex="2" Width="64px" />
                        <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />
                        <dxwgv:GridViewDataHyperLinkColumn FieldName="mailto" Caption="E-mail" PropertiesHyperLinkEdit-TextField="EMailAddress" VisibleIndex="4" />
                        <dxwgv:GridViewDataTextColumn FieldName="OfficeNo" Caption="Office No" VisibleIndex="5" />
                        <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="6" />
                        <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="7" />
                        <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="8" />
                        <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="9" />
                        <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="10" />
                    </Columns>
                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                    <SettingsPager AlwaysShowPager="True" PageSize="25" />
                    <Styles>
                        <AlternatingRow Enabled="True" />
                        <Cell VerticalAlign="Top" />
                        <CommandColumn Spacing="8px" />
                        <CommandColumnItem Cursor="pointer" />
                        <Header HorizontalAlign="Center" />
                    </Styles>
                </dxwgv:ASPxGridView>
                <dxtc:ASPxPageControl ID="tabEmail" runat="server" ClientInstanceName="tabEmail" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Content">
                            <TabImage Url="images/email_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="text-align: right">Subject</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left">
                                                <dxe:ASPxTextBox ID="txtSubject" runat="server" ClientInstanceName="txtSubject" Width="100%">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
                                                </dxe:ASPxTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <dxhe:ASPxHtmlEditor ID="heBody" runat="server" ClientInstanceName="heBody" Width="100%">
                                        <Settings AllowDesignView="False" AllowHtmlView="False" AllowPreview="False" />
                                        <SettingsImageUpload UploadImageFolder="~/uploads">
                                            <ValidationSettings AllowedContentTypes="image/jpeg,image/pjpeg,image/gif,image/png,image/x-png" />
                                        </SettingsImageUpload>
                                        <SettingsSpellChecker Culture="English (United States)">
                                            <Dictionaries>
                                                <dxwsc:ASPxSpellCheckerISpellDictionary AlphabetPath="~/dictionaries/english.txt" GrammarPath="~/dictionaries/english.aff" DictionaryPath="~/dictionaries/american.xlg" CacheKey="ispellDic" Culture="English (United States)" EncodingName="Western European (Windows)" />
                                            </Dictionaries>
                                        </SettingsSpellChecker>
                                    </dxhe:ASPxHtmlEditor>
                                    <br />
                                    <p style="font-size: 8pt"><strong>* Keywords</strong>: You can use the following three keywords; that will be replace for each employee:</p>
                                    <br />
                                    <p style="font-size: 8pt; padding-left: 15px">{Title} Refers to the employee's title (example: Mr, Mrs, Miss)</p>
                                    <p style="font-size: 8pt; padding-left: 15px">{Name} Refers to the employee's preferred name or first name (if preferred name is blank, first name will be used; preferred name is always used first)</p>
                                    <p style="font-size: 8pt; padding-left: 15px">{Surname} Refers to the employee's surname</p>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="width: 95px">
                                                <img id="btnNext_001" src="images/next.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Next');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Preview">
                            <TabImage Url="images/email_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                                <CellStyle Paddings-PaddingTop="5px" />
                                                <DataItemTemplate>
                                                    <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="Preview Message" ImageUrl="images/select.png" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                </DataItemTemplate>
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="True" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="text-align: left; width: 105px">
                                                <img id="btnBack_002" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                                            </td>
                                            <td style="width: 95px">
                                                <img id="btnSubmit_002" src="images/submit.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Submit');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    heBody.Focus();
                                                                    break;
                                                                case 1:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                            };
                                                        }" Init="function(s, e) { s.SetVisible(false); }" />
                </dxtc:ASPxPageControl>
                <dxtc:ASPxPageControl ID="tabSMS" runat="server" ClientInstanceName="tabSMS" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Content">
                            <TabImage Url="images/sms_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="text-align: right; vertical-align: top">Message</td>
                                            <td style="width: 10px" />
                                            <td style="text-align: left">
                                                <dxe:ASPxMemo ID="txtMessage_001" ClientInstanceName="txtMessage_001" runat="server" Rows="5" Width="100%">
                                                    <ClientSideEvents KeyUp="function(s, e) { lblMessage_001.SetText(s.GetText().length.toString() + ' character(s)'); }" />
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                    </ValidationSettings>
                                                </dxe:ASPxMemo>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" />
                                            <td style="text-align: left">
                                                <dxe:ASPxLabel ID="lblMessage_001" runat="server" ClientInstanceName="lblMessage_001" Text="0 character(s)" Font-Bold="true" Font-Size="8pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" />
                                            <td>
                                                <p style="font-size: 8pt"><strong>* Keywords</strong>: You can use the following three keywords; that will be replace for each employee:</p>
                                                <br />
                                                <p style="font-size: 8pt; padding-left: 15px">{Title} Refers to the employee's title (example: Mr, Mrs, Miss)</p>
                                                <p style="font-size: 8pt; padding-left: 15px">{Name} Refers to the employee's preferred name or first name (if preferred name is blank, first name will be used; preferred name is always used first)</p>
                                                <p style="font-size: 8pt; padding-left: 15px">{Surname} Refers to the employee's surname</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" />
                                            <td>
                                                <p style="font-size: 8pt"><strong>* Note</strong>: You can send up to 160 characters per text message;</p>
                                                <br />
                                                <p style="font-size: 8pt; padding-left: 15px">a) exceeding 160 characters will cause the message to be sent as a <strong>long text message</strong> - up to 38808 characters (or 252 messages, combined);</p>
                                                <p style="font-size: 8pt; padding-left: 15px">b) the entire message will appear as a <strong>single text message</strong> on the recipient's mobile;</p>
                                                <p style="font-size: 8pt; padding-left: 15px">c) credits are deducted per 160 characters used; as multiple messages are sent to the recipient's operator</p>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="width: 95px">
                                                <img id="btnNext_003" src="images/next.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Next');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Preview">
                            <TabImage Url="images/sms_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Message" VisibleIndex="5" />
                                        </Columns>
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="True" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                    </dxwgv:ASPxGridView>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="text-align: left; width: 105px">
                                                <img id="btnBack_004" src="images/back.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Back');" style="cursor: pointer" />
                                            </td>
                                            <td style="width: 95px">
                                                <img id="btnSubmit_004" src="images/submit.png" onclick="window.parent.lpPage.Show(); cpPage.PerformCallback('Submit');" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    txtMessage_001.Focus();
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                            };
                                                        }" Init="function(s, e) { s.SetVisible(false); }" />
                </dxtc:ASPxPageControl>
            </div>
        </form>
    </body>
</html>