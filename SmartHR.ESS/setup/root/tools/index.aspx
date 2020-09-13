<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="index.aspx.vb" Inherits="SmartHR.index1" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <style type="text/css">
            html, body, form {
                height: 100%;
                margin: 0px;
                padding: 0px;
                overflow: hidden;
            }
        </style>
        <link rel="icon" href="../favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
        <link href="../styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body>
        <form id="_tools_index" runat="server" style="height: 100%; width: 100%">
            <div class="title">
                <div style="float: left"></div>
                <div style="float: right; padding: 8px 10px 0px 0px">
                    <dxe:ASPxButton ID="cmdSignout" runat="server" Text="Signout" Width="80px" AutoPostBack="false">
                        <ClientSideEvents Click="function(s, e) {
                                window.parent.clearpanel();
                                window.parent.lpPage.Show();
                                window.parent.tmrCount.SetEnabled(false);
                                window.parent.tmrTimeout.SetEnabled(false);
                                window.parent.cpPanes.PerformCallback('signout');
                            }" />
                    </dxe:ASPxButton>
                </div>
            </div>
        </form>
    </body>
</html>