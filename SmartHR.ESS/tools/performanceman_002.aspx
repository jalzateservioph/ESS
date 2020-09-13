<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_002.aspx.vb"
    Inherits="SmartHR.performanceman_0021" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors"
    TagPrefix="dxe" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        html, body, form
        {
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
    <form id="_performanceman_0021" runat="server" style="height: 100%; width: 100%">
    <table class="title">
        <tr>
            <td>
                <table style="width: 160px">
                    <tr>
                        <td style="width: 40px">
                            <img style="cursor: pointer; height: 32px" src="../images/tools/performanceman_002_edit.png"
                                title="Edit" onclick="window.parent.lpPage.Show(); window.parent.frames[1].cpPage.PerformCallback('Edit');" />
                        </td>
                        <td style="width: 40px">
                            <img style="cursor: pointer; height: 32px" src="../images/tools/performanceman_002_save.png"
                                title="Save" onclick="window.parent.lpPage.Show(); window.parent.frames[1].cpPage.PerformCallback('Save');" />
                        </td>
                        <td style="width: 40px">
                            <img id="cmdEvaluation" runat="server" style="cursor: pointer; height: 32px" src="../images/tools/performanceman_002_print.png"
                                title="Print" />
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right">
                <table cellpadding="0" style="font-family: Arial Rounded MT Bold; font-size: 12pt;
                    text-align: left; width: 125px">
                    <tr>
                        <td style="text-align: right; width: 125px">
                            SCORE
                        </td>
                        <td style="width: 10px" />
                        <td style="text-align: left">
                            <dxe:ASPxLabel ID="lblScore" runat="server" ClientInstanceName="lblScore" Font-Names="Arial Rounded MT Bold, Tahoma, Arial, Helvetica, Sans-Serif, Verdana"
                                Font-Size="12pt" />
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right">
                <dxe:ASPxButton ID="cmdSignout" runat="server" Text="Signout" Width="80px" AutoPostBack="false">
                    <clientsideevents click="function(s, e) {
                                    window.parent.clearpanel();
                                    window.parent.lpPage.Show();
                                    window.parent.tmrCount.SetEnabled(false);
                                    window.parent.tmrTimeout.SetEnabled(false);
                                    window.parent.cpPanes.PerformCallback('signout');
                                }" />
                </dxe:ASPxButton>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
