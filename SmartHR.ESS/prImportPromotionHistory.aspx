<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="prImportPromotionHistory.aspx.vb" Inherits="SmartHR.prPromotionHistoryMigrator" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTabControl" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxClasses" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxUploadControl" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #TextArea1 {
            width: 304px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxPageControl ID="tabpage" runat="server" ActiveTabIndex="1" AutoPostBack="True" Width="100%">
            <TabPages>
                <dx:TabPage Text="Import Attendance and Performance">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Import Promotion History">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                           <dx:ASPxRoundPanel ID="basePanel" runat="server" HeaderText="Select Excel files to be uploaded." Height="100%" Width="100%">
                            <HeaderStyle Font-Bold="True" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxPanel ID="Layer1" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table>
                                                    <tr>
                                                        <td style="margin-left: 40px">
                                                            <dx:ASPxUploadControl ID="uc" runat="server" Font-Bold="True" Width="318px">
                                                                <ValidationSettings AllowedFileExtensions=".xls, .xlsx" ShowErrors="False">
                                                                </ValidationSettings>
                                                            </dx:ASPxUploadControl>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <dx:ASPxButton ID="btnUpload" runat="server" Font-Bold="True" Text="Upload" Width="100%" Height="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                        <td>
                                                            
                                                        </td>
                                                        <td>
                                                             <dx:ASPxButton ID="btnDownloadTemplate" runat="server" Font-Bold="True" Text="Download Template" Width="100%" Height="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                    <dx:ASPxPanel ID="layer2" runat="server" Height="50px" Visible="False" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table>
                                                    <tr>
                                                        <td class="auto-style3">
                                                            <asp:Label ID="lblFileNamePA" runat="server" ForeColor="#1C5500" Text="FileName:" Visible="False" Width="100%"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style3">
                                                            <asp:Label ID="lblSelect" runat="server" Text="Select Sheet:    "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxComboBox ID="cbSheet" runat="server" AutoPostBack="True">
                                                            </dx:ASPxComboBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;</td>
                                                        <td></td>
                                                        <td>
                                                            <dx:ASPxButton ID="btnBack" runat="server" Font-Bold="True" Text="Back" Width="100px">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                    <dx:ASPxPanel ID="layer3" runat="server" Visible="False" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table style="width: 127px">
                                                    <tr>
                                                        <td class="auto-style2">
                                                            <dx:ASPxButton ID="btnSave" runat="server" Font-Bold="True" Text="Update" Width="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <dx:ASPxGridView ID="grid" runat="server" Width="100%">
                                                    <SettingsPager PageSize="5">
                                                    </SettingsPager>
                                                </dx:ASPxGridView>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Import Infractions">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Performance and Promotions Report">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>
    
    </div>
        
        <dx:ASPxPopupControl ID="popup" runat="server" Height="112px" Width="450px" Modal="True">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
                    <table style="width:100%;">
                        <tr>
                            <td align="center">
                                <dx:ASPxLabel ID="popuplabel" runat="server" Text="popuplabel"></dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="OK"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        
    </form>
</body>
</html>
