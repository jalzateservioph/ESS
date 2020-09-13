<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_004.aspx.vb"
    Inherits="SmartHR.performanceman_0041" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors"
    TagPrefix="dxe" %>

    
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dxt" %>
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
    <form id="_performanceman_004" runat="server" style="height: 100%; width: 100%">
    <dxt:ASPxTimer ID="tmrEvalTimer" runat="server" ClientInstanceName="tmrEvalTimer" Interval="1000" Enabled="false" >
                <ClientSideEvents Tick="function(s, e) {
                                                            
                                                            var value = parseInt(lblHello.GetText());
                                                            value += 1;
                                                            lblHello.SetText(value);
                                                            if(value == 6000)
                                                            {
                                                                lblAutoSaveProgress.SetText('Saving...')
                                                                window.parent.frames[1].cpPage.PerformCallback('AutoSave');
                                                                lblHello.SetText('0');
                                                                s.SetEnabled(false);
                                                            }
                                                        }" />
    </dxt:ASPxTimer>
    <table class="title">
        <tr>
            <td>
                <table style="width: 160px">
                    <tr>
                        <td style="width: 40px">
                           <%-- <img style="cursor: pointer; height: 32px" visible="false" src="../images/tools/performanceman_002_edit.png"
                                title="Edit" onclick="window.parent.lpPage.Show(); window.parent.frames[1].cpPage.PerformCallback('Edit');" /> --%>
                            <dxe:ASPxLabel ID="lblHello" runat="server" ClientInstanceName="lblHello" Text="0" ClientVisible="false" />
                        </td>
                        <td style="width: 40px">
                            <img style="cursor: pointer; height: 32px" src="../images/tools/performanceman_002_save.png"
                                title="Save" onclick="window.parent.lpPage.Show(); window.parent.frames[1].cpPage.PerformCallback('Save');" />
                        </td>
                        <td style="width: 40px">
                            <img id="cmdEvaluation" runat="server" style="cursor: pointer; height: 32px" src="../images/tools/performanceman_002_print.png"
                                title="Print" />
                        </td>
                        <td style="width: 40px"> 
                            <dxe:ASPxLabel ID="lblAutoSaveProgress" runat="server" ClientInstanceName="lblAutoSaveProgress" Text="" Font-Italic="true" />
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right">
                <table cellpadding="0" style="font-family: Arial Rounded MT Bold; font-size: 12pt;
                    text-align: left; width: 125px">
                    <tr>
                        <td style="text-align: right; width: 125px">
                                
                        </td>
                        <td style="width: 10px" />
                        <td style="text-align: left">
                            <dxe:ASPxLabel ID="lblScore" Visible="true" runat="server" Font-Names="Arial Rounded MT Bold, Tahoma, Arial, Helvetica, Sans-Serif, Verdana"
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
