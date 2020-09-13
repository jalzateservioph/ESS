<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="news.aspx.vb" Inherits="SmartHR.news" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body>
        <form id="_news" runat="server">
            <div class="padding">
                <div>
                    <asp:Literal ID="ltHtml" runat="server" />
                </div>
                <br />
                <br />
                <div class="centered" style="width: 80px">
                    <dxe:ASPxButton ID="cmdClose" runat="server" ClientInstanceName="cmdClose" Text="Close" Height="25px" Width="80px" AutoPostBack="false">
                        <ClientSideEvents Click="function(s, e) { window.opener = top; window.close(); }" />
                    </dxe:ASPxButton>
                </div>
            </div>
        </form>
    </body>
</html>