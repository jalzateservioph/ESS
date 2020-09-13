<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="notify.aspx.vb" Inherits="SmartHR.notify" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
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
        <form id="_notify" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlNotify" runat="server" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <div>
                                <asp:Table ID="tblNotify" runat="server" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" Width="150px">
                                            <dxe:ASPxLabel ID="lblSubject" runat="server" Text="Subject" />
                                        </asp:TableCell>
                                        <asp:TableCell Width="10px">
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <dxe:ASPxTextBox ID="txtSubject" runat="server" Width="100%">
                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                </ValidationSettings>
                                            </dxe:ASPxTextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </div>
                            <div><br /></div>
                            <div>
                                <dxhe:ASPxHtmlEditor ID="heBody" runat="server" Width="100%">
                                    <Settings AllowDesignView="false" AllowHtmlView="false" AllowPreview="false" />
                                    <SettingsImageUpload UploadImageFolder="~/uploads">
                                        <ValidationSettings AllowedContentTypes="image/jpeg, image/pjpeg, image/gif, image/png, image/x-png" />
                                    </SettingsImageUpload>
                                    <SettingsSpellChecker Culture="English (United States)">
                                        <Dictionaries>
                                            <dxwsc:ASPxSpellCheckerISpellDictionary AlphabetPath="~/dictionaries/english.txt" GrammarPath="~/dictionaries/english.aff" DictionaryPath="~/dictionaries/american.xlg" CacheKey="ispellDic" Culture="English (United States)" EncodingName="Western European (Windows)" />
                                        </Dictionaries>
                                    </SettingsSpellChecker>
                                </dxhe:ASPxHtmlEditor>
                            </div>
                            <div><br /></div>
                            <div class="centered" style="width: 80px">
                                <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false" />
                            </div>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/notify_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Notifications" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </form>
    </body>
</html>