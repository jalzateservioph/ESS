<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="twsreports.aspx.vb" Inherits="SmartHR.twsreports" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v11.1.Web, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register TagPrefix="dxm" Namespace="DevExpress.Web.ASPxMenu" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxp" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxcb" Namespace="DevExpress.Web.ASPxCallback" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxrp" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxuc" Namespace="DevExpress.Web.ASPxUploadControl" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxe" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxxr" Namespace="DevExpress.XtraReports.Web" Assembly="DevExpress.XtraReports.v11.1.Web, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dxwgv" Namespace="DevExpress.Web.ASPxGridView" Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
</head>
    <body onload="window.parent.reset();">
    <form id="twsreports" runat="server">
        <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                        window.parent.postUrl(e.result, false);
                    }
                }" />
        </dxcb:ASPxCallback>
        <asp:ScriptManager ID="sm2" runat="server" AsyncPostBackTimeout="420"/>
        
        <div class="padding">
            <dx:ASPxPageControl ID="tabTWSReports" runat="server" Width="100%" ActiveTabIndex="0">
                <tabpages>
                    <dx:TabPage Text="Reports" runat="server" TabStyle-Width="100px">
                        <ContentCollection>
                            <dx:ContentControl runat="server">
                                <div class="info_container" >
                                    <table cellpadding="10px" cellspacing="10px" align="center">
                                        <tr align="center">
                                            <td>
                                                <dxrp:ASPxRoundPanel ID="RPReprocessData" runat="server" Width="100%">
                                                    <PanelCollection>
                                                        <dxp:PanelContent ID="PCReprocessData" runat="server">
                                                            <table cellpadding="10px" cellspacing="10px" align="center">
                                                                <tr align="center">
                                                                    <td align="right" width="120px">
                                                                        <dxe:ASPxLabel ID="lblSchema" runat="server" Text="Scheme Code" />
                                                                    </td>
                                                                    <td align="center" width="150px">
                                                                        <dxe:ASPxComboBox ID="cboSchema" runat="server" AutoPostBack="True" TextField="SchemeCode" ValueField="SchemeCode" ValueType="System.String">
                                                                        </dxe:ASPxComboBox>
                                                                    </td>
                                                                    <td align="left" width="120px">
                                                                        <dx:ASPxButton ID="BtnTWSReprocess" runat="server" Text="Reprocess Data" Enabled="True">
                                                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Reprocess'); }" />
                                                                        </dx:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                    <HeaderTemplate>
                                                        <table style="height: 20px; width: 100%">
                                                            <tr valign="middle">
                                                                <td style="width: 20px">
                                                                    <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/left_006.png" />
                                                                </td>
                                                                <td>
                                                                    <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Reprocess Data" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                </dxrp:ASPxRoundPanel>
                                            </td>
                                        </tr>
                                        <tr></tr>
                                        <tr align="center">
                                            <td>
                                                <dxrp:ASPxRoundPanel ID="RPSurveyReports" runat="server" Width="100%">
                                                    <PanelCollection>
                                                        <dxp:PanelContent ID="PCSurveyReports" runat="server">
                                                            <table cellpadding="10px" cellspacing="10px" align="center">
                                                                <tr align="center">
                                                                    <td>
                                                                        <dxe:ASPxButton runat="server" Text="Corporate Results" ID="btnCorporate" Width="150px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Enabled="True">
                                                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>
                                                                        <dxe:ASPxButton runat="server" Text="Divisional Results" ID="btnDivisional" Width="150px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Enabled="True" ClientSideEvents-Click="<%# GetClickUrl(Nothing)%>">
                                                                            <%--<ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />--%>
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>
                                                                        <dxe:ASPxButton runat="server" Text="Departmental Results" ID="btnDepartment" Width="150px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Enabled="True">
                                                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>
                                                                        <dxe:ASPxButton runat="server" Text="Sectional Results" ID="btnSection" Width="150px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Enabled="True">
                                                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>
                                                                        <dxe:ASPxButton runat="server" Text="Respondents" ID="btnRespondents" Width="150px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                            <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                    <HeaderTemplate>
                                                        <table style="height: 20px; width: 100%">
                                                            <tr valign="middle">
                                                                <td style="width: 20px">
                                                                    <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/left_006.png" />
                                                                </td>
                                                                <td>
                                                                    <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Workplace Survey Reports" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                </dxrp:ASPxRoundPanel>
                                            </td>
                                        </tr>
                                        <tr></tr>
                                    </table>
                                </div>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Leadership Result" runat="server" TabStyle-Width="100px">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server">
                                <div class="info_container">
                                    <div>
                                        <table cellpadding="5" cellspacing = "5" width="700px" style="width: 996px">
                                            <tr style="width: 100%">
                                                <td style="width: 123px; height: 40px" align="left" valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <dxe:ASPxLabel ID="lblScheme" runat="server" Text="Scheme Code" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <dxe:ASPxComboBox ID="cboSchemeCode" runat="server" AutoPostBack="True" TextField="SchemeCode" ValueField="SchemeCode" ValueType="System.String">
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <dxe:ASPxLabel ID="lblSuperior" runat="server" Text="Superior Name" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <dxe:ASPxComboBox ID="cboSuperiorList" runat="server" AutoPostBack="True" TextField="SuperiorName" ValueField="SuperiorName" ValueType="System.String">
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxButton ID="btnGenerate" runat="server" Text="Generate W/O Comments" Enabled="False">
                                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Generate'); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxButton ID="btnGenerateCom" runat="server" Text="Generate W/ Comments" Enabled="False">
                                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GenerateCom'); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 873px; height: 40px" align="center" valign="top">
                                                    <table align="center" width="100%" border = ".5px" style="border-color :lightblue">
                                                        <tr style="height: 10%">
                                                            <td align="center" style="width: 100%">
                                                                <dxxr:ReportToolbar ID="rptSuperior" runat="server" ShowDefaultButtons="False" ReportViewer="<%# rpvSuperior %>">
                                                                    <Items>
                                                                        <dxxr:ReportToolbarButton ItemKind='Search' ToolTip='Display the search window' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintReport' ToolTip='Print the report' />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintPage' ToolTip='Print the current page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='FirstPage' ToolTip='First Page' />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='PreviousPage' ToolTip='Previous Page' />
                                                                        <dxxr:ReportToolbarLabel Text='Page' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='PageNumber' Width='65px'>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                        <dxxr:ReportToolbarLabel Text='of' />
                                                                        <dxxr:ReportToolbarTextBox IsReadOnly='True' ItemKind='PageCount' />
                                                                        <dxxr:ReportToolbarButton ItemKind='NextPage' ToolTip='Next Page' />
                                                                        <dxxr:ReportToolbarButton ItemKind='LastPage' ToolTip='Last Page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToDisk' ToolTip='Export a report and save it to the disk' />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToWindow' ToolTip='Export a report and show it in a new window' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='SaveFormat' Width='70px'>
                                                                            <Elements>
                                                                                <dxxr:ListElement Text='Pdf' Value='pdf' />
                                                                                <dxxr:ListElement Text='Xls' Value='xls' />
                                                                                <dxxr:ListElement Text='Rtf' Value='rtf' />
                                                                                <dxxr:ListElement Text='Mht' Value='mht' />
                                                                                <dxxr:ListElement Text='Text' Value='txt' />
                                                                                <dxxr:ListElement Text='Csv' Value='csv' />
                                                                                <dxxr:ListElement Text='Image' Value='png' />
                                                                            </Elements>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                    </Items>
                                                                    <Styles>
                                                                        <LabelStyle>
                                                                            <Margins MarginLeft='3px' MarginRight='3px' />
                                                                        </LabelStyle>
                                                                    </Styles>
                                                                </dxxr:ReportToolbar>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 90%">
                                                            <td align="center" style="width: 100%">
                                                                <dx:ReportViewer runat="server" ID="rpvSuperior" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" LoadingPanelText="" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" OnUnload="rpvSuperior_Unload">
                                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                                </LoadingPanelImage>
                                                                <LoadingPanelStyle ForeColor="#303030">
                                                                </LoadingPanelStyle>
                                                                </dx:ReportViewer>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                </div>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Comments per Group" runat="server" TabStyle-Width="100px">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl1" runat="server">
                                <div class="info_container">
                                    <div>
                                        <table cellpadding="5" cellspacing = "5" width="700px" style="width: 996px">
                                            <tr style="width: 100%">
                                                <td style="width: 123px; height: 40px" align="left" valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                Scheme Code
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dxe:ASPxComboBox ID="cboScheme" runat="server" AutoPostBack="True"
                                                                    TextField="SchemeCode"
                                                                    ValueField="SchemeCode" ValueType="System.String">
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Keyword
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dxe:ASPxComboBox ID="cboKeyword" runat="server" AutoPostBack="True"
                                                                    TextField="Keyword"
                                                                    ValueField="Keyword" ValueType="System.String">
                                                                </dxe:ASPxComboBox>   
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxButton ID="btnSubmit" runat="server" Text="Submit" Enabled="False">
                                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GenerateGroup'); }" />
                                                                </dx:ASPxButton>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 873px; height: 40px" align="center" valign="top">
                                                    <table align="center" width="100%" border = ".5px" style="border-color :lightblue">
                                                        <tr style="height: 10%">
                                                            <td align="center" style="width: 100%">
                                                                <dxxr:ReportToolbar ID="rptComments" runat="server" ShowDefaultButtons="False" ReportViewer="<%# rpvComments %>">
                                                                    <Items>
                                                                        <dxxr:ReportToolbarButton ItemKind='Search' ToolTip='Display the search window' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintReport' ToolTip='Print the report' />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintPage' ToolTip='Print the current page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='FirstPage' ToolTip='First Page' />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='PreviousPage' ToolTip='Previous Page' />
                                                                        <dxxr:ReportToolbarLabel Text='Page' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='PageNumber' Width='65px'>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                        <dxxr:ReportToolbarLabel Text='of' />
                                                                        <dxxr:ReportToolbarTextBox IsReadOnly='True' ItemKind='PageCount' />
                                                                        <dxxr:ReportToolbarButton ItemKind='NextPage' ToolTip='Next Page' />
                                                                        <dxxr:ReportToolbarButton ItemKind='LastPage' ToolTip='Last Page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToDisk' ToolTip='Export a report and save it to the disk' />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToWindow' ToolTip='Export a report and show it in a new window' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='SaveFormat' Width='70px'>
                                                                            <Elements>
                                                                                <dxxr:ListElement Text='Pdf' Value='pdf' />
                                                                                <dxxr:ListElement Text='Xls' Value='xls' />
                                                                                <dxxr:ListElement Text='Rtf' Value='rtf' />
                                                                                <dxxr:ListElement Text='Mht' Value='mht' />
                                                                                <dxxr:ListElement Text='Text' Value='txt' />
                                                                                <dxxr:ListElement Text='Csv' Value='csv' />
                                                                                <dxxr:ListElement Text='Image' Value='png' />
                                                                            </Elements>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                    </Items>
                                                                    <Styles>
                                                                        <LabelStyle>
                                                                            <Margins MarginLeft='3px' MarginRight='3px' />
                                                                        </LabelStyle>
                                                                    </Styles>
                                                                </dxxr:ReportToolbar> 
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 90%">
                                                            <td align="center" style="width: 100%">
                                                                <dx:ReportViewer runat="server" ID="rpvComments" 
                                                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                    LoadingPanelText="" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" >
                                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                                </LoadingPanelImage>
                                                                <LoadingPanelStyle ForeColor="#303030">
                                                                </LoadingPanelStyle>
                                                                </dx:ReportViewer>
                                                            </td>
                                                        </tr>
                                                    </table>   
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                </div>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Essay Responses" runat="server" TabStyle-Width="100px">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl3" runat="server">
                                <div class="info_container">
                                    <div>
                                        <table cellpadding="5" cellspacing = "5" width="700px" style="width: 996px">
                                            <tr style="width: 100%">
                                                <td style="width: 123px; height: 40px" align="left" valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                Scheme Code
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dxe:ASPxComboBox ID="cboScheCode" runat="server" AutoPostBack="True" TextField="SchemeCode" ValueField="SchemeCode" ValueType="System.String">
                                                                </dxe:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxButton ID="btnEssay" runat="server" Text="Generate Report" Enabled="False">
                                                                    <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('GenerateEssay'); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 873px; height: 40px" align="center" valign="top">
                                                    <table align="center" width="100%" border = ".5px" style="border-color :lightblue">
                                                        <tr style="height: 10%">
                                                            <td align="center" style="width: 100%">
                                                                <dxxr:ReportToolbar ID="ReportToolbar1" runat="server" ShowDefaultButtons="False" ReportViewer="<%# rpvEssay %>">
                                                                    <Items>
                                                                        <dxxr:ReportToolbarButton ItemKind='Search' ToolTip='Display the search window' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintReport' ToolTip='Print the report' />
                                                                        <dxxr:ReportToolbarButton ItemKind='PrintPage' ToolTip='Print the current page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='FirstPage' ToolTip='First Page' />
                                                                        <dxxr:ReportToolbarButton Enabled='False' ItemKind='PreviousPage' ToolTip='Previous Page' />
                                                                        <dxxr:ReportToolbarLabel Text='Page' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='PageNumber' Width='65px'>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                        <dxxr:ReportToolbarLabel Text='of' />
                                                                        <dxxr:ReportToolbarTextBox IsReadOnly='True' ItemKind='PageCount' />
                                                                        <dxxr:ReportToolbarButton ItemKind='NextPage' ToolTip='Next Page' />
                                                                        <dxxr:ReportToolbarButton ItemKind='LastPage' ToolTip='Last Page' />
                                                                        <dxxr:ReportToolbarSeparator />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToDisk' ToolTip='Export a report and save it to the disk' />
                                                                        <dxxr:ReportToolbarButton ItemKind='SaveToWindow' ToolTip='Export a report and show it in a new window' />
                                                                        <dxxr:ReportToolbarComboBox ItemKind='SaveFormat' Width='70px'>
                                                                            <Elements>
                                                                                <dxxr:ListElement Text='Pdf' Value='pdf' />
                                                                                <dxxr:ListElement Text='Xls' Value='xls' />
                                                                                <dxxr:ListElement Text='Rtf' Value='rtf' />
                                                                                <dxxr:ListElement Text='Mht' Value='mht' />
                                                                                <dxxr:ListElement Text='Text' Value='txt' />
                                                                                <dxxr:ListElement Text='Csv' Value='csv' />
                                                                                <dxxr:ListElement Text='Image' Value='png' />
                                                                            </Elements>
                                                                        </dxxr:ReportToolbarComboBox>
                                                                    </Items>
                                                                    <Styles>
                                                                        <LabelStyle>
                                                                            <Margins MarginLeft='3px' MarginRight='3px' />
                                                                        </LabelStyle>
                                                                    </Styles>
                                                                </dxxr:ReportToolbar>            
                                                                 
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 90%">
                                                            <td align="center" style="width: 100%">
                                                                <dx:ReportViewer runat="server" ID="rpvEssay" 
                                                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                    LoadingPanelText="" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" >
                                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                                </LoadingPanelImage>
                                                                <LoadingPanelStyle ForeColor="#303030">
                                                                </LoadingPanelStyle>
                                                                </dx:ReportViewer>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                </div>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Maintenance" runat="server" TabStyle-Width="100px">
                        <ContentCollection>
                            <dx:ContentControl ID="cclKeyMaintenance" runat="server">
                                <div class="info_container" align="center">
                                    <table align="center">
                                        <tr>
                                            <td>
                                                <br />
                                                <dxrp:ASPxRoundPanel ID="pnlKeywords" runat="server" Width="100%">
                                                    <PanelCollection>
                                                        <dxp:PanelContent runat="server">
                                                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                                                <Columns>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                                        <EditButton Visible="True">
                                                                            <Image Url="images/edit.png" />
                                                                            <Image Url="images/edit.png"></Image>
                                                                        </EditButton>
                                                                        <CancelButton Visible="True">
                                                                            <Image Url="images/cancel.png" />
                                                                            <Image Url="images/cancel.png"></Image>
                                                                        </CancelButton>
                                                                        <UpdateButton Visible="True">
                                                                            <Image Url="images/update.png" />
                                                                            <Image Url="images/update.png"></Image>
                                                                        </UpdateButton>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Keyword" Caption="Keyword" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                                                                        <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataTextColumn>
                                                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" SortIndex="0" SortOrder="Ascending" VisibleIndex="4">
                                                                    <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataDateColumn>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                                            <DeleteButton Text="Delete Record"></DeleteButton>
                                                                        <CustomButtons>
                                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" 
                                                                                Image-Url="images/delete.png" Text="Delete Record" >
                                                                            <Image Url="images/delete.png"></Image>
                                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                                        </CustomButtons>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                </Columns>
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                                <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                                                <SettingsEditing NewItemRowPosition="Bottom" />
                                                                <SettingsPager AlwaysShowPager="True" />
                                                                <Styles>
                                                                    <AlternatingRow Enabled="true" />
                                                                    <CommandColumn Spacing="8px" />
                                                                    <CommandColumnItem Cursor="pointer" />
                                                                    <Header HorizontalAlign="Center" />
                                                                    <Header HorizontalAlign="Center"></Header>

                                                                    <AlternatingRow Enabled="True"></AlternatingRow>

                                                                    <CommandColumn Spacing="8px"></CommandColumn>

                                                                    <CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                                                </Styles>
                                                                <Templates>
                                                                    <DetailRow>
                                                                        <table style="padding: 0px; width: 100%">
                                                                            <tr>
                                                                                <td style="font-size: 10pt; font-weight: bold; text-align: right; width: 75px">Claim Items</td>
                                                                                <td style="width: 10px"></td>
                                                                                <td><hr /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3" style="height: 5px" />
                                                                            </tr>
                                                                        </table>
                                                                        <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
                                                                            <Columns>
                                                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                                                    <EditButton Visible="True">
                                                                                        <Image Url="images/edit.png" />
                                                                                    </EditButton>
                                                                                    <CancelButton Visible="True">
                                                                                        <Image Url="images/cancel.png" />
                                                                                    </CancelButton>
                                                                                    <UpdateButton Visible="True">
                                                                                        <Image Url="images/update.png" />
                                                                                    </UpdateButton>
                                                                                </dxwgv:GridViewCommandColumn>
                                                                                <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                                                                <dxwgv:GridViewDataTextColumn FieldName="Keyword" Caption="Keyword" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" >
                                                                                    <EditFormSettings Visible="false" />
                                                                                </dxwgv:GridViewDataTextColumn>
                                                                                <dxwgv:GridViewDataTextColumn FieldName="Items" Caption="Items" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />
                                                                                <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" SortIndex="0" SortOrder="Ascending" VisibleIndex="4">
                                                                                    <EditFormSettings Visible="false" />
                                                                                </dxwgv:GridViewDataTextColumn>
                                                                                <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
                                                                                    <EditFormSettings Visible="false" />
                                                                                </dxwgv:GridViewDataDateColumn>
                                                                                   
                                                                                <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="255" Width="16px">
                                                                                    <CustomButtons>
                                                                                        <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
                                                                                    </CustomButtons>
                                                                                </dxwgv:GridViewCommandColumn>
                                                                            </Columns>
                                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                                                
                                                                            <Settings ShowHeaderFilterButton="true" ShowFilterBar="Hidden" ShowStatusBar="Visible" ShowFooter="true" ShowGroupPanel="true" />
                                                                            <SettingsBehavior AutoExpandAllGroups="true"  />
                                                                            <SettingsCookies StoreColumnsVisiblePosition="false" />
                                                                            <SettingsDetail IsDetailGrid="true" />
                                                                            <SettingsEditing NewItemRowPosition="Bottom" />
                                                                            <SettingsPager AlwaysShowPager="True" />
                                                                            <Styles>
                                                                                <AlternatingRow Enabled="true" />
                                                                                <CommandColumn Spacing="8px" />
                                                                                <CommandColumnItem Cursor="pointer" />
                                                                                <Header HorizontalAlign="Center" />
                                                                            </Styles>
                                                                            <Templates>
                                                                                <EditForm>
                                                                                    <div style="padding: 5px; width: 100%">
                                                                                        <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_004" ReplacementType="EditFormEditors" runat="server" />
                                                                                    </div>
                                                                                    <br />
                                                                                    <div style="text-align:right; padding: 5px">
                                                                                        <span style="cursor: pointer; padding-right: 10px"><dxe:ASPxImage ID="cmdUpdate" runat="server" ImageUrl="images/update.png" ToolTip="Update Record"><ClientSideEvents Click="function(s, e) { dgView_004.UpdateEdit();}" /></dxe:ASPxImage></span>
                                                                                        <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                                    </div>
                                                                                </EditForm>
                                                                                <StatusBar>
                                                                                    <table style="padding: 2px; width: 100%">
                                                                                        <tr>
                                                                                            <td></td>
                                                                                            <td style="width: 80px">
                                                                                                <dxe:ASPxButton ID="cmdCreate_004" runat="server" ClientInstanceName="cmdCreate_004" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                                                    <ClientSideEvents Click="function(s, e) { dgView_004.AddNewRow(); }" />
                                                                                                </dxe:ASPxButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </StatusBar>
                                                                            </Templates>
                                                                        </dxwgv:ASPxGridView>
                                                                    </DetailRow>
                                                                    <EditForm>
                                                                        <div style="padding: 5px; width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                        <div style="text-align:right; padding: 5px">
                                                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                        </div>
                                                                    </EditForm>
                                                                    <StatusBar>
                                                                        <table style="padding: 2px; width: 100%">
                                                                            <tr>
                                                                                <td></td>
                                                                                <td style="width: 80px">
                                                                                    <dxe:ASPxButton ID="cmdCreate_001" runat="server" ClientInstanceName="cmdCreate_001" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                                        <ClientSideEvents Click="function(s, e) { dgView_001.AddNewRow(); }" />
                                                                                    </dxe:ASPxButton>
                                                                                </td>
                                                                                <td style="width: 10px" />
                                                                            </tr>
                                                                        </table>
                                                                    </StatusBar>
                                                                </Templates>
                                                            </dxwgv:ASPxGridView>
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                    <HeaderTemplate>
                                                        <table style="height: 16px; width: 100%">
                                                            <tr valign="middle">
                                                                <td style="width: 20px">
                                                                    <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                                                </td>
                                                                <td>
                                                                    <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Keywords" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                </dxrp:ASPxRoundPanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <dxrp:ASPxRoundPanel ID="EssayResponses" runat="server" Width="100%">
                                                    <PanelCollection>
                                                        <dxp:PanelContent ID="PanelContent1" runat="server">
                                                            <dxwgv:ASPxGridView ID="dgView_EssRes" runat="server" ClientInstanceName="dgView_EssRes" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                                                <Columns>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                                        <EditButton Visible="True">
                                                                            <Image Url="images/edit.png" />
                                                                            <Image Url="images/edit.png"></Image>
                                                                        </EditButton>
                                                                        <CancelButton Visible="True">
                                                                            <Image Url="images/cancel.png" />
                                                                            <Image Url="images/cancel.png"></Image>
                                                                        </CancelButton>
                                                                        <UpdateButton Visible="True">
                                                                            <Image Url="images/update.png" />
                                                                            <Image Url="images/update.png"></Image>
                                                                        </UpdateButton>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="KPACode" Caption="Code" VisibleIndex="2">
                                                                        <PropertiesComboBox DataSourceID="ds_KPACode_Ess" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="KPACode" ValueField="KPACode" />
                                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="Items" Caption="Items" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" SortIndex="0" SortOrder="Ascending" VisibleIndex="4">
                                                                        <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataTextColumn>
                                                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedOn" Caption="Captured Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
                                                                    <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataDateColumn>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                                            <DeleteButton Text="Delete Record"></DeleteButton>
                                                                        <CustomButtons>
                                                                            <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton1" 
                                                                                Image-Url="images/delete.png" Text="Delete Record" >
                                                                            <Image Url="images/delete.png"></Image>
                                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                                        </CustomButtons>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                </Columns>
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                                <SettingsEditing NewItemRowPosition="Bottom" />
                                                                <SettingsPager AlwaysShowPager="True" />
                                                                <Styles>
                                                                    <AlternatingRow Enabled="true" />
                                                                    <CommandColumn Spacing="8px" />
                                                                    <CommandColumnItem Cursor="pointer" />
                                                                    <Header HorizontalAlign="Center" />
                                                                    <Header HorizontalAlign="Center"></Header>

                                                                    <AlternatingRow Enabled="True"></AlternatingRow>

                                                                    <CommandColumn Spacing="8px"></CommandColumn>

                                                                    <CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                                                </Styles>
                                                                <Templates>
                                                                    <EditForm>
                                                                        <div style="padding: 5px; width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                        <div style="text-align:right; padding: 5px">
                                                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                        </div>
                                                                    </EditForm>
                                                                    <StatusBar>
                                                                        <table style="padding: 2px; width: 100%">
                                                                            <tr>
                                                                                <td></td>
                                                                                <td style="width: 80px">
                                                                                    <dxe:ASPxButton ID="cmdCreate_Ess" runat="server" ClientInstanceName="cmdCreate_Ess" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                                        <ClientSideEvents Click="function(s, e) { dgView_EssRes.AddNewRow(); }" />
                                                                                    </dxe:ASPxButton>
                                                                                </td>
                                                                                <td style="width: 10px" />
                                                                            </tr>
                                                                        </table>
                                                                    </StatusBar>
                                                                </Templates>
                                                            </dxwgv:ASPxGridView>
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                    <HeaderTemplate>
                                                        <table style="height: 16px; width: 100%">
                                                            <tr valign="middle">
                                                                <td style="width: 20px">
                                                                    <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                                                </td>
                                                                <td>
                                                                    <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Essay Responses" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                </dxrp:ASPxRoundPanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <dxrp:ASPxRoundPanel ID="LeadershipCategories" runat="server" Width="100%">
                                                    <PanelCollection>
                                                        <dxp:PanelContent ID="PanelContent2" runat="server">
                                                            <dxwgv:ASPxGridView ID="dgView_LdrCtg" runat="server" ClientInstanceName="dgView_LdrCtg" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                            <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                                                <Columns>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                                        <EditButton Visible="True">
                                                                            <Image Url="images/edit.png" />
                                                                            <Image Url="images/edit.png"></Image>
                                                                        </EditButton>
                                                                        <CancelButton Visible="True">
                                                                            <Image Url="images/cancel.png" />
                                                                            <Image Url="images/cancel.png"></Image>
                                                                        </CancelButton>
                                                                        <UpdateButton Visible="True">
                                                                            <Image Url="images/update.png" />
                                                                            <Image Url="images/update.png"></Image>
                                                                        </UpdateButton>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="CategoryName" Caption="Category Name" SortOrder="Ascending" VisibleIndex="1">
                                                                        <PropertiesComboBox DataSourceID="ds_LdrCode_Ldr" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="CategoryName" ValueField="CategoryName" />
                                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="KPACode" Caption="Code" VisibleIndex="2">
                                                                        <PropertiesComboBox DataSourceID="ds_KPACode_Ldr" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="KPACode" ValueField="KPACode" />
                                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Remarks" Caption="Remarks" VisibleIndex="3">
                                                                        <PropertiesComboBox DataSourceID="ds_Remarks_Ldr" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Remarks" ValueField="Remarks" />
                                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" SortIndex="0" SortOrder="Ascending" VisibleIndex="4">
                                                                        <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataTextColumn>
                                                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedDate" Caption="Captured On" SortIndex="0" SortOrder="Ascending" Visible="False">
                                                                    <EditFormSettings Visible="false" />
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                    </dxwgv:GridViewDataDateColumn>
                                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
                                                                            <DeleteButton Text="Delete Record"></DeleteButton>
                                                                        <CustomButtons>
                                                                            <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton2" 
                                                                                Image-Url="images/delete.png" Text="Delete Record" >
                                                                            <Image Url="images/delete.png"></Image>
                                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                                        </CustomButtons>
                                                                    </dxwgv:GridViewCommandColumn>
                                                                </Columns>
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                                <SettingsEditing NewItemRowPosition="Bottom" />
                                                                <SettingsPager AlwaysShowPager="True" />
                                                                <Styles>
                                                                    <AlternatingRow Enabled="true" />
                                                                    <CommandColumn Spacing="8px" />
                                                                    <CommandColumnItem Cursor="pointer" />
                                                                    <Header HorizontalAlign="Center" />
                                                                    <Header HorizontalAlign="Center"></Header>

                                                                    <AlternatingRow Enabled="True"></AlternatingRow>

                                                                    <CommandColumn Spacing="8px"></CommandColumn>

                                                                    <CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                                                </Styles>
                                                                <Templates>
                                                                    <EditForm>
                                                                        <div style="padding: 5px; width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                        <div style="text-align:right; padding: 5px">
                                                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                                        </div>
                                                                    </EditForm>
                                                                    <StatusBar>
                                                                        <table style="padding: 2px; width: 100%">
                                                                            <tr>
                                                                                <td></td>
                                                                                <td style="width: 80px">
                                                                                    <dxe:ASPxButton ID="cmdCreate_LDR1" runat="server" ClientInstanceName="cmdCreate_LDR1" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                                        <ClientSideEvents Click="function(s, e) { dgView_LdrCtg.AddNewRow(); }" />
                                                                                    </dxe:ASPxButton>
                                                                                </td>
                                                                                <td style="width: 10px" />
                                                                            </tr>
                                                                        </table>
                                                                    </StatusBar>
                                                                </Templates>
                                                            </dxwgv:ASPxGridView>
                                                        </dxp:PanelContent>
                                                    </PanelCollection>
                                                    <HeaderTemplate>
                                                        <table style="height: 16px; width: 100%">
                                                            <tr valign="middle">
                                                                <td style="width: 20px">
                                                                    <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                                                </td>
                                                                <td>
                                                                    <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Leadership Categories" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                </dxrp:ASPxRoundPanel>
                                            </td>
                                        </tr>
                                    </table>
                                </div>                                      
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                </tabpages>
            </dx:ASPxPageControl>
        </div>
        <asp:SqlDataSource ID="ds_Superior" runat="server" />
        <asp:SqlDataSource ID="ds_Keywords" runat="server" />
        <asp:SqlDataSource ID="ds_LdrCode_Ldr" runat="server" />
        <asp:SqlDataSource ID="ds_KPACode_Ess" runat="server" />
        <asp:SqlDataSource ID="ds_KPACode_Ldr" runat="server" />
        <asp:SqlDataSource ID="ds_Remarks_Ldr" runat="server" />
    </form>
</body>
</html>