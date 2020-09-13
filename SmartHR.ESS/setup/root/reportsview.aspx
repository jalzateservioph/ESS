<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="reportsview.aspx.vb" Inherits="SmartHR.reportsview" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>SmartHR (Employee Self Service)</title>
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <script src="scripts/main.js" type="text/javascript"></script>
    </head>
    <body onload="lpPage.Show();">
        <form id="_reportsview" runat="server">
            <dx:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
            <div class="page_full">
                <table style="height: 100%; padding: 0px; width: 100%">
                    <tr valign="middle">
                        <td align="center">
                            <dx:ASPxCallbackPanel ID="cpParams" runat="server" ClientInstanceName="cpParams" ClientVisible="false" HideContentOnCallback="false" ShowLoadingPanel="false">
                                <PanelCollection>
                                    <dxp:PanelContent runat="server">
                                        <dx:ASPxRoundPanel ID="pParams" runat="server" ClientInstanceName="pParams" HeaderImage-Url="images/accept.png" HeaderText="Parameters">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <PanelCollection>
                                                <dxp:PanelContent runat="server">
                                                    <dxhf:ASPxHiddenField ID="hValues" runat="server" ClientInstanceName="hValues" />
                                                    <div class="centered">
                                                        <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                            <Columns>
                                                                <dxwgv:GridViewDataTextColumn FieldName="Type" VisibleIndex="0" Visible="false" />
                                                                <dxwgv:GridViewDataTextColumn FieldName="ID" Caption="#" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" Visible="false" />
                                                                <dxwgv:GridViewDataTextColumn FieldName="Name" VisibleIndex="2" Visible="false" />
                                                                <dxwgv:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="3">
                                                                    <CellStyle HorizontalAlign="Right" />
                                                                </dxwgv:GridViewDataTextColumn>
                                                                <dxwgv:GridViewDataTextColumn FieldName="Value" Caption="Value" VisibleIndex="4" CellStyle-HorizontalAlign="Left" Width="250px">
                                                                    <DataItemTemplate>
                                                                        <asp:PlaceHolder ID="phControls" runat="server" Visible="true" />
                                                                    </DataItemTemplate>
                                                                </dxwgv:GridViewDataTextColumn>
                                                                <dxwgv:GridViewDataTextColumn FieldName="Values" VisibleIndex="5" Visible="false" />
                                                            </Columns>
                                                            <SettingsPager AlwaysShowPager="false" />
                                                            <Styles>
                                                                <AlternatingRow Enabled="true" />
                                                                <CommandColumn Spacing="8px" />
                                                                <CommandColumnItem Cursor="pointer" />
                                                                <Header HorizontalAlign="Center" />
                                                            </Styles>
                                                        </dxwgv:ASPxGridView>
                                                        <br />
                                                        <table style="height: 100%; padding: 0px; width: 100%">
                                                            <tr valign="middle">
                                                                <td align="center">
                                                                    <div class="centered" style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="False">
                                                                            <ClientSideEvents Click="function(s, e) { lpPage.Show(); cpParams.PerformCallback(null); }" />
                                                                        </dxe:ASPxButton>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </dxp:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>
                                    </dxp:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>