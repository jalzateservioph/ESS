<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="index.aspx.vb" Inherits="SmartHR.index" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxGlobalEvents" TagPrefix="dxge" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dxnb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxSplitter" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dxt" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v11.1" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>SmartHR (Employee Self Service)</title>
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <script src="scripts/main.js" type="text/javascript"></script>
        <style type="text/css">
            html, body, form {
                height: 100%;
                margin: 0px;
                padding: 0px;
                overflow: hidden;
            }
        </style>
    </head>
    <body onload="window.history.forward(); reset();">
        <form id="_index" runat="server">
            <dxm:ASPxPopupMenu ID="mnuProfile" runat="server" ClientInstanceName="mnuProfile" PopupElementID="cpPanes_spIndex_cpImage_imgPicture" PopupAction="RightMouseClick" ShowPopOutImages="True">
                <Items>
                    <dxm:MenuItem Name="mnuExp_001" Text="Out of Office" />
                    <dxm:MenuItem Name="mnuExp_000" Text="Back in Office" />
                </Items>
            </dxm:ASPxPopupMenu>
            <dxhf:ASPxHiddenField ID="hPanel" runat="server" ClientInstanceName="hPanel" />
            <dxlp:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
            <dxge:ASPxGlobalEvents ID="geTimeout" runat="server">
                <ClientSideEvents EndCallback="function(s, e) { tmrTimeout.SetEnabled(false); tmrTimeout.SetEnabled(true); }" />
            </dxge:ASPxGlobalEvents>
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.location.href=e.result;
                        }
                    }" />
            </dxcb:ASPxCallback>
            <dxt:ASPxTimer ID="tmrCount" runat="server" ClientInstanceName="tmrCount" Enabled="false" Interval="1000">
                <ClientSideEvents Tick="function(s, e) {
                        var value = hPanel.Get('Count');
                        value -= 1;
                        if(value == 0) {
                            pcTimeout.Hide();
                            lpPage.Show();
                            tmrCount.SetEnabled(false);
                            tmrTimeout.SetEnabled(false);
                            window.location.href = 'default.aspx';
                        }
                        else {
                           lblTimeout.SetText('Your session will expire in ' + value.toString() + ' second(s)');
                           hPanel.Set('Count', value);
                        }
                    }" />
            </dxt:ASPxTimer>
            <dxt:ASPxTimer ID="tmrTimeout" runat="server" ClientInstanceName="tmrTimeout">
                <ClientSideEvents Tick="function(s, e) { pcTimeout.Show(); }" />
            </dxt:ASPxTimer>
            <dxpc:ASPxPopupControl ID="pcDelete" runat="server" ClientInstanceName="pcDelete" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Confirmation" HeaderImage-Url="images/question.png">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="width: 275px; text-align: center">
                            <p>Are you sure you want to delete this record?</p>
                            <br />
                            <table cellpadding="0" style="text-align: left; width: 275px">
                                <tr>
                                    <td><dxe:ASPxCheckBox ID="chkConfirm" runat="server" ClientInstanceName="chkConfirm" Text="Don't ask confirmation" /></td>
                                    <td />
                                    <td style="text-align: right">
                                        <dxe:ASPxButton ID="cmdYes_001" runat="server" ClientInstanceName="cmdYes_001" Text="Yes" Width="50px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { hPanel.Set('Confirm', chkConfirm.GetChecked()); pcDelete.Hide(); frames[1].ASPxClientControl.GetControlCollection().Get(hPanel.Get('dgClientGridID')).DeleteRow(hPanel.Get('SelectedIndex')); hPanel.Remove('dgClientGridID'); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                    <td style="width: 10px" />
                                    <td style="text-align: left">
                                        <dxe:ASPxButton ID="cmdNo_001" runat="server" ClientInstanceName="cmdNo_001" Text="No" Width="50px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { pcDelete.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcDelete.AdjustSize(); cmdYes_001.Focus(); }" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcCompany" runat="server" ClientInstanceName="pcCompany" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderStyle-Font-Bold="true" HeaderText="Select a Company/Branch/Division/Sub Division / Saved Application" HeaderImage-Url="images/info.png">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="overflow: auto; height: 250px; width: 450px">
                            <dx:ASPxTreeList ID="tlvCompanies" runat="server" ClientInstanceName="tlvCompanies" AutoGenerateColumns="False" Border-BorderStyle="Solid" Height="250px" Width="100%">
                                <Columns>
                                    <dx:TreeListTextColumn FieldName="CompanyNum" Visible="false" />
                                    <dx:TreeListTextColumn FieldName="Name" Caption="Company" SortIndex="0" SortOrder="Ascending">
                                        <PropertiesTextEdit EncodeHtml="false" />
                                    </dx:TreeListTextColumn>                     
                                </Columns>
                                <ClientSideEvents FocusedNodeChanged="function(s, e) {
                                        if (s.GetNodeState(s.GetFocusedNodeKey()) == 'Child') {
                                            cmdOK_Company.SetEnabled(true);
                                        }
                                        else {
                                            cmdOK_Company.SetEnabled(false);
                                        }
                                        e.processOnServer = true;
                                    }" />
                                <Settings SuppressOuterGridLines="true" />
                                <SettingsBehavior AllowFocusedNode="true" AutoExpandAllNodes="true" FocusNodeOnLoad="false" />
                                <Styles>
                                    <Node Cursor="pointer" />
                                </Styles>
                            </dx:ASPxTreeList>
                            <dxwgv:ASPxGridView ID="dgSavedAppz" runat="server" ClientInstanceName="dgSavedAppz" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                <Columns>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px">
                                        <SelectButton Visible="true">
                                            <Image Url="images/select.png" />
                                        </SelectButton>
                                    </dxwgv:GridViewCommandColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="TODateSaved" Caption="Date Saved" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="CompanyNum" Caption="CompanyNum" VisibleIndex="3" />
                                    <dxwgv:GridViewDataTextColumn FieldName="EmployeeNum" Caption="EmployeeNum" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Surname" Caption="Surname" VisibleIndex="5" />
                                    <dxwgv:GridViewDataTextColumn FieldName="PreferredName" Caption="Name" VisibleIndex="6" />
                                </Columns>
                                <ClientSideEvents EndCallback="function(s, e) { if (s.cpURL.length != 0 && s.cpToolURL.length != 0) { pcCompany.Hide(); postUrl(s.cpURL + '\ ' + s.cpToolURL, false); } }" SelectionChanged="function(s, e) { if (e.isSelected) { lpPage.Show(); s.PerformCallback(e.visibleIndex); } }" />
                                <SettingsPager AlwaysShowPager="true" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                </Styles>
                            </dxwgv:ASPxGridView>
                        </div>
                        <dxp:ASPxPanel ID="pnlCompanySwitch" runat="server" ClientInstanceName="pnlCompanySwitch" Width="450px">
                            <PanelCollection>
                                <dxp:PanelContent>
                                    <br />
                                    <div class="centered" style="width: 95px">
                                        <table cellpadding="0">
                                            <tr>
                                                <td>
                                                    <dxe:ASPxButton ID="cmdSwitch_Company" runat="server" ClientInstanceName="cmdSwitch_Company" Text="Switch View" Width="95px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
                                                                tlvCompanies.SetVisible(!tlvCompanies.GetVisible());
                                                                dgSavedAppz.SetVisible(!dgSavedAppz.GetVisible());
                                                                pnlCompany.SetVisible(tlvCompanies.GetVisible());
                                                                if (tlvCompanies.GetVisible()) {
                                                                    pcCompany.SetHeaderText('Select a Company/Branch/Division/Sub Division');
                                                                }
                                                                if (dgSavedAppz.GetVisible()) {
                                                                    pcCompany.SetHeaderText('Select a Saved Application');
                                                                }
                                                                pcCompany.AdjustSize();
                                                            }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dxp:PanelContent>
                            </PanelCollection>
                        </dxp:ASPxPanel>
                        <dxp:ASPxPanel ID="pnlCompany" runat="server" ClientInstanceName="pnlCompany" Width="450px">
                            <PanelCollection>
                                <dxp:PanelContent>
                                    <br />
                                    <div class="centered" style="width: 180px">
                                        <table cellpadding="0">
                                            <tr>
                                                <td>
                                                    <dxe:ASPxButton ID="cmdOK_Company" runat="server" ClientInstanceName="cmdOK_Company" Text="OK" Width="80px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
                                                                var key = tlvCompanies.GetFocusedNodeKey();
                                                                if (tlvCompanies.GetNodeState(key) == 'Child') {
                                                                    pcCompany.Hide();
                                                                    if (hPanel.Contains('PostUri')) {
                                                                        if (hPanel.Get('PostUri') == 'transfer.aspx') {
                                                                            frames[1].cpPage.PerformCallback('Submit');
                                                                        }
                                                                        else {
                                                                            postUrl((hPanel.Get('PostUri') + '\ tools/index.aspx').split('\ '), false);
                                                                        }
                                                                        hPanel.Remove('PostUri');
                                                                    }
                                                                    else {
                                                                        postUrl('employee.aspx\ tools/employee.aspx'.split('\ '), false);
                                                                    }
                                                                }
                                                            }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                                <td style="width: 10px" />
                                                <td>
                                                    <dxe:ASPxButton ID="cmdCancel_Company" runat="server" ClientInstanceName="cmdCancel_Company" Text="Cancel" Width="80px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { pcCompany.Hide(); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dxp:PanelContent>
                            </PanelCollection>
                        </dxp:ASPxPanel>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) {
                        dgSavedAppz.SetVisible(false);
                        tlvCompanies.SetVisible(true);
                        pnlCompany.SetVisible(true);
                        pnlCompanySwitch.SetVisible(false);
                        pcCompany.SetHeaderText('Select a Company/Branch/Division/Sub Division');
                        if (hPanel.Contains('ShowSaved') && dgSavedAppz.GetVisibleRowsOnPage() != 0) {
                            dgSavedAppz.UnselectAllRowsOnPage();
                            dgSavedAppz.SetVisible(true);
                            tlvCompanies.SetVisible(false);
                            pnlCompany.SetVisible(false);
                            pnlCompanySwitch.SetVisible(true);
                            pcCompany.SetHeaderText('Select a Saved Application');
                        }
                        s.AdjustSize();
                        if (tlvCompanies.GetNodeState(tlvCompanies.GetFocusedNodeKey()) == 'Child') {
                            cmdOK_Company.SetEnabled(true);
                        }
                        else {
                            cmdOK_Company.SetEnabled(false);
                        }
                    }" />
                <HeaderStyle HorizontalAlign="Left" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcPopup" runat="server" ClientInstanceName="pcPopup" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/info.png">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="width: 325px; text-align: center">
                            <dxe:ASPxLabel ID="lblMessage_Popup" runat="server" ClientInstanceName="lblMessage_Popup" />
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dxe:ASPxButton ID="cmdPopup" runat="server" ClientInstanceName="cmdPopup" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcPopup.Hide(); }" />
                            </dxe:ASPxButton>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pcPopup.AdjustSize(); cmdPopup.SetFocus(); }" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcProgress" runat="server" ClientInstanceName="pcProgress" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowHeader="false" ShowFooter="false">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="width: 175px; text-align: center">
                            <div style="text-align: left">
                                <img src="images/loading-small.gif" />
                                <div style="margin-top: -22px; text-align: center">Please wait...</div>
                            </div>
                            <br />
                            <div><dxe:ASPxProgressBar ID="pbProgress" runat="server" ClientInstanceName="pbProgress" Height="25px" Width="100%" /></div>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { pbProgress.SetPosition(0); pcProgress.AdjustSize(); }" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcTimeout" runat="server" ClientInstanceName="pcTimeout" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowHeader="false" ShowFooter="false">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div style="width: 250px; text-align: center">
                            <div>
                                <dxe:ASPxLabel ID="lblTimeout" runat="server" ClientInstanceName="lblTimeout" Text="Your session will expire in 30 second(s)" />
                            </div>
                            <br />
                            <div>Do you wish to extend your session?</div>
                            <br />
                            <div class="centered" style="width: 125px">
                                <table style="padding: 0px; width: 125px">
                                    <tr>
                                        <td style="text-align: right">
                                            <dxe:ASPxButton ID="cmdYes_002" runat="server" ClientInstanceName="cmdYes_002" Text="Yes" Width="50px" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { tmrCount.SetEnabled(false); tmrTimeout.SetEnabled(false); pcTimeout.Hide(); lpPage.Show(); cpPanes.PerformCallback('refresh'); }" />
                                            </dxe:ASPxButton>
                                        </td>
                                        <td style="width: 10px" />
                                        <td style="text-align: left">
                                            <dxe:ASPxButton ID="cmdNo_002" runat="server" ClientInstanceName="cmdNo_002" Text="No" Width="50px" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { pcTimeout.Hide(); lpPage.Show(); tmrCount.SetEnabled(false); tmrTimeout.SetEnabled(false); cpPage.PerformCallback('signout'); }" />
                                            </dxe:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { hPanel.Set('Count', 30); tmrCount.SetEnabled(true); pcTimeout.AdjustSize(); }" />
            </dxpc:ASPxPopupControl>
            <dxcp:ASPxCallbackPanel ID="cpPanes" runat="server" ClientInstanceName="cpPanes" HideContentOnCallback="false" ShowLoadingPanel="false" Height="100%" Width="100%">
                <ClientSideEvents EndCallback="function(s, e) {
                        switch(s.cpParam)
                        {
                            case 'signout': {
                                    window.location.href='default.aspx';
                                };
                                break;
                        };
                    }" />
                <PanelCollection>
                    <dxp:PanelContent runat="server">
                        <div style="height: 100%">
                            <dx:ASPxSplitter ID="spIndex" runat="server" ClientInstanceName="spIndex" Width="100%" Height="100%" Orientation="Vertical">
                                <Panes>
                                    <dx:SplitterPane Name="banner" AllowResize="False" ShowSeparatorImage="False" Size="88px">
                                        <ContentCollection>
                                            <dx:SplitterContentControl runat="server">
                                                <div style="padding: 5px">
                                                    <div style="float: left">
                                                        <img style="cursor: pointer; height: 75px; width: 250px" src="images/toolbar.jpg" onclick="window.open('http://www.absalomsystems.com');" />
                                                    </div>
                                                    <div style="float: left; height: 75px; width: 115px">
                                                        <asp:Table runat="server" Height="75px" Width="115px">
                                                            <asp:TableRow>
                                                                <asp:TableCell CssClass="cpCenter maxPicture">
                                                                    <dxcp:ASPxCallbackPanel ID="cpImage" runat="server" ClientInstanceName="cpImage" HideContentOnCallback="false" ShowLoadingPanel="false">
                                                                        <PanelCollection>
                                                                            <dxp:PanelContent runat="server">
                                                                                <dxe:ASPxBinaryImage ID="imgPicture" runat="server" ClientInstanceName="imgPicture" CssClass="maxPicture">
                                                                                    <EmptyImage Url="images/photo_help.png" />
                                                                                </dxe:ASPxBinaryImage>
                                                                            </dxp:PanelContent>
                                                                        </PanelCollection>
                                                                    </dxcp:ASPxCallbackPanel>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </div>
                                                    <div style="float: left; padding-top: 5px">
                                                        <table style="padding: 0px">
                                                            <tr>
                                                                <td colspan="3" style="font-weight: bold; text-align: left">
                                                                    <dxe:ASPxLabel ID="lblSummary_001" runat="server" ClientInstanceName="lblSummary_001" Font-Bold="true" Font-Size="10pt" />
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 3px">
                                                                <td />
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: left">
                                                                    <dxe:ASPxLabel ID="lblSummary_002" runat="server" ClientInstanceName="lblSummary_002" Font-Size="8pt" Cursor="pointer" ToolTip="Job Title" />
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 3px">
                                                                <td />
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: left">
                                                                    <dxe:ASPxLabel ID="lblSummary_003" runat="server" ClientInstanceName="lblSummary_003" Font-Size="8pt" Cursor="pointer" ToolTip="Department" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div style="float: right">
                                                        <div style="float: left; height: 75px; width: 115px">
                                                            <asp:Table runat="server" Height="75px" Width="115px">
                                                                <asp:TableRow>
                                                                    <asp:TableCell CssClass="cpCenter maxPicture">
                                                                        <dxe:ASPxBinaryImage ID="imgCompany" runat="server" ClientInstanceName="imgCompany">
                                                                            <EmptyImage Url="images/absalom.png" />
                                                                        </dxe:ASPxBinaryImage>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </dx:SplitterContentControl>
                                        </ContentCollection>
                                    </dx:SplitterPane>
                                    <dx:SplitterPane Name="title" AllowResize="False" ShowSeparatorImage="False" Size="31px">
                                        <Panes>
                                            <dx:SplitterPane Name="title_left" AllowResize="False" ShowSeparatorImage="False" Size="260px">
                                                <ContentCollection>
                                                    <dx:SplitterContentControl runat="server">
                                                        <div class="title" style="padding: 3px 0px 3px 5px">
                                                            <div style="float: left; width: 40px">
                                                                <img id="tb_search" runat="server" style="cursor: pointer; height: 32px" src="images/toolbar_001.png" title="Search" onclick="postUrl('search.aspx\ tools/index.aspx'.split('\ '), false);" />
                                                            </div>
                                                            <div style="float: left; width: 40px">
                                                                <img id="tb_contacts" runat="server" style="cursor: pointer; height: 32px" src="images/toolbar_005.png" title="Contacts" onclick="postUrl('contacts.aspx\ tools/contacts.aspx'.split('\ '), false);" />
                                                            </div>
                                                            <div style="float: left; width: 40px">
                                                                <img id="tb_employee" runat="server" style="cursor: pointer; height: 32px" src="images/toolbar_004.png" title="Create an Employee" onclick="hPanel.Set('CreateEmployee', true); hPanel.Set('ShowSaved', true); pcCompany.Show();" />
                                                            </div>
                                                            <div style="float: left; width: 40px">
                                                                <img id="tb_delete" runat="server" style="cursor: pointer; height: 32px" src="images/toolbar_006.png" title="Terminate an Employee" onclick="postUrl('terminate.aspx\ tools/index.aspx'.split('\ '), false);" />
                                                            </div>
                                                            <div style="float: left; width: 40px">
                                                                <img id="tb_transfer" runat="server" style="cursor: pointer; height: 32px" src="images/toolbar_007.png" title="Transfer Employee(s)" onclick="if(hPanel.Contains('ShowSaved')) { hPanel.Remove('ShowSaved'); }; postUrl('transfer.aspx\ tools/index.aspx'.split('\ '), false);" />
                                                            </div>
                                                        </div>
                                                    </dx:SplitterContentControl>
                                                </ContentCollection>
                                                <PaneStyle>
                                                    <Paddings Padding="0px" />
                                                </PaneStyle>
                                            </dx:SplitterPane>
                                            <dx:SplitterPane Name="title_right" AllowResize="False" ShowSeparatorImage="False" ContentUrl="tools/index.aspx" ContentUrlIFrameName="toolUrlPane">
                                                <ContentCollection>
                                                    <dx:SplitterContentControl runat="server">
                                                    </dx:SplitterContentControl>
                                                </ContentCollection>
                                            </dx:SplitterPane>
                                        </Panes>
                                    </dx:SplitterPane>
                                    <dx:SplitterPane Name="content" AllowResize="False" ShowSeparatorImage="False">
                                        <Panes>
                                            <dx:SplitterPane Name="content_menu" ShowCollapseBackwardButton="True" ShowCollapseForwardButton="True" ShowSeparatorImage="True" ScrollBars="Auto" Size="260px">
                                                <ContentCollection>
                                                    <dx:SplitterContentControl runat="server">
                                                        <div style="overflow: auto; text-align: center; width: 100%">
                                                            <div style="padding: 10px; text-align: left">Select an Employee</div>
                                                            <div style="padding: 0px 10px 10px 10px">
                                                                <dxe:ASPxComboBox ID="cmbEmployee" runat="server" ClientInstanceName="cmbEmployee" TextField="Text" ValueField="Value" EnableIncrementalFiltering="true" Width="100%">
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                                            clearpanel();
                                                                            lpPage.Show();
                                                                            e.processOnServer = false;
                                                                            cpPanes.PerformCallback('load\ ' + s.GetValue().toString() + '\ ' + s.GetText() + '\ ' + spIndex.GetPaneByName('content_main').GetContentUrl());
                                                                        }" />
                                                                </dxe:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                        <div style="overflow: auto; text-align: center; width: 100%">
                                                            <div>
                                                                <dxe:ASPxLabel ID="lblCompanyName" runat="server" ClientInstanceName="lblCompanyName" Font-Bold="true" Font-Size="8pt" />
                                                            </div>
                                                            <div>
                                                                <dxe:ASPxLabel ID="lblDivision" runat="server" ClientInstanceName="lblDivision" Font-Bold="true" Font-Size="8pt" />
                                                            </div>
                                                            <div>
                                                                <dxe:ASPxLabel ID="lblSubDivision" runat="server" ClientInstanceName="lblSubDivision" Font-Size="8pt" />
                                                            </div>
                                                            <div>
                                                                <dxe:ASPxLabel ID="lblSubSubDivision" runat="server" ClientInstanceName="lblSubSubDivision" Font-Size="8pt" />
                                                            </div>
                                                        </div>
                                                        <div style="height: 10px"></div>
                                                        <dxnb:ASPxNavBar ID="navMenu" runat="server" ClientInstanceName="navMenu" ShowExpandButtons="false" Width="100%">
                                                            <ClientSideEvents HeaderClick="function(s, e) { postUrl(e.group.name.split('\ '), true); }" />
                                                            <GroupHeaderStyle Font-Underline="false">
                                                                <BackgroundImage ImageUrl="images/buttons.jpg" />
                                                                <HoverStyle>
                                                                    <BackgroundImage ImageUrl="images/buttons.jpg" VerticalPosition="bottom" />
                                                                </HoverStyle>
                                                            </GroupHeaderStyle>
                                                            <LinkStyle Color="#283B56" HoverColor="#283B56" VisitedColor="#283B56" />
                                                            <Paddings Padding="0px" />
                                                        </dxnb:ASPxNavBar>
                                                    </dx:SplitterContentControl>
                                                </ContentCollection>
                                            </dx:SplitterPane>
                                            <dx:SplitterPane Name="content_main" ShowCollapseBackwardButton="True" ShowCollapseForwardButton="True" ShowSeparatorImage="True" ScrollBars="Auto" ContentUrl="tasks.aspx" ContentUrlIFrameName="contentUrlPane">
                                                <ContentCollection>
                                                    <dx:SplitterContentControl runat="server">
                                                    </dx:SplitterContentControl>
                                                </ContentCollection>
                                                <PaneStyle>
                                                    <Paddings Padding="10px" />
                                                </PaneStyle>
                                            </dx:SplitterPane>
                                        </Panes>
                                    </dx:SplitterPane>
                                </Panes>
                                <Styles>
                                    <Pane>
                                        <Paddings Padding="0px" />
                                    </Pane>
                                </Styles>
                            </dx:ASPxSplitter>
                        </div>
                    </dxp:PanelContent>
                </PanelCollection>
            </dxcp:ASPxCallbackPanel>
        </form>
    </body>
</html>