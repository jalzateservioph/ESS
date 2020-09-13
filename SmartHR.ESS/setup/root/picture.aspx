<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="picture.aspx.vb" Inherits="SmartHR.picture" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body>
        <form id="_picture" runat="server">
            <asp:Table ID="tblPicture" runat="server" Width="320px">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" Height="10px" />
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                        <dxcp:ASPxCallbackPanel ID="cpImage" runat="server" ClientInstanceName="cpImage" HideContentOnCallback="false" ShowLoadingPanel="false">
                            <ClientSideEvents EndCallback="function(s, e) { window.opener.cpImage.PerformCallback(); }" />
                            <PanelCollection>
                                <dxp:PanelContent runat="server">
                                    <dxe:ASPxBinaryImage ID="imgPicture" runat="server" ClientInstanceName="imgPicture" ToolTip="Preview" StoreContentBytesInViewState="true">
                                        <EmptyImage Url="images/photo_help.png" />
                                    </dxe:ASPxBinaryImage>
                                </dxp:PanelContent>
                            </PanelCollection>
                        </dxcp:ASPxCallbackPanel>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" Height="10px" />
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                        <dxuc:ASPxUploadControl ID="upDocument" runat="server" ClientInstanceName="upDocument" ShowProgressPanel="true" Size="30" OnFileUploadComplete="upDocument_FileUploadComplete">
                            <ClientSideEvents FileUploadComplete="function(s, e) { cpImage.PerformCallback();  }" />
                            <ValidationSettings MaxFileSize="4096000" />
                        </dxuc:ASPxUploadControl>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" CssClass="pad_left">* Maximum file size 4MB</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" Height="10px" />
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                        <dxe:ASPxButton ID="cmdUpload" runat="server" ClientInstanceName="cmdUpload" Text="Upload" Height="25px" Width="80px" AutoPostBack="false">
                            <ClientSideEvents Click="function(s, e) { upDocument.Upload(); }" />
                        </dxe:ASPxButton>
                    </asp:TableCell>
                    <asp:TableCell Width="15px">
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">
                        <dxe:ASPxButton ID="cmdClose" runat="server" ClientInstanceName="cmdClose" Text="Close" Height="25px" Width="80px" AutoPostBack="false">
                            <ClientSideEvents Click="function(s, e) { window.opener = top; window.close(); }" />
                        </dxe:ASPxButton>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </form>
    </body>
</html>