<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="contacts.aspx.vb" Inherits="SmartHR.contacts1" ValidateRequest="false" %>

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
        <form id="_contacts_001" runat="server" style="height: 100%; width: 100%">
            <div class="title">
                <div style="float: left">
                    <div style="padding: 3px 0px 3px 5px">
                        <div style="float: left; width: 40px">
                            <img id="tb_email" runat="server" style="cursor: pointer; height: 32px" src="../images/tools/contacts_003.png" title="Bulk E-mail" onclick="if (window.parent.frames[1].dgView.GetSelectedRowCount() == 0) { window.parent.pcPopup.SetHeaderText('INFORMATION'); window.parent.pcPopup.SetHeaderImageUrl('images/info.png'); window.parent.lblMessage_Popup.SetText('You need to select at least one employee.'); window.parent.pcPopup.Show(); } else { window.parent.frames[1].dgView.SetVisible(false); window.parent.frames[1].tabSMS.SetVisible(false); window.parent.frames[1].tabEmail.SetVisible(true); window.parent.frames[1].hPanel.Set('ActiveIndex', 2); }" />
                        </div>
                        <div style="float: left; width: 40px">
                            <img id="tb_sms" runat="server" style="cursor: pointer; height: 32px" src="../images/tools/contacts_004.png" title="Bulk SMS" onclick="if (window.parent.frames[1].dgView.GetSelectedRowCount() == 0) { window.parent.pcPopup.SetHeaderText('INFORMATION'); window.parent.pcPopup.SetHeaderImageUrl('images/info.png'); window.parent.lblMessage_Popup.SetText('You need to select at least one employee.'); window.parent.pcPopup.Show(); } else { window.parent.frames[1].dgView.SetVisible(false); window.parent.frames[1].tabEmail.SetVisible(false); window.parent.frames[1].tabSMS.SetVisible(true); window.parent.frames[1].hPanel.Set('ActiveIndex', 3); }" />
                        </div>
                    </div>
                </div>
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