<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="trainingagreementman.aspx.vb" Inherits="SmartHR.trainingagreementman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
</head>
<body onload="window.parent.reset();">
    <form id="_trainingagreementman" runat="server">
        <asp:scriptmanager id="sm" runat="server" enablepartialrendering="true" scriptmode="release" enablepagemethods="true"></asp:scriptmanager>
        <dxlp:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
        <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
            <ClientSideEvents CallbackComplete="function(s, e) {
                        var response = e.result.split('\ ');
                        window.parent.reset();
                        if (response[1] != undefined) {
                            if (response[1].toLowerCase().indexOf('.aspx') != -1) {
                                window.parent.postUrl(response[1] + '\ ' + response[2], false);
                            }
                            else {
                                window.parent.ShowPopup(response[1]);
                            }
                        }
                    }" />
        </dxcb:ASPxCallback>
        <dxpc:ASPxPopupControl ID="pcHistory" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcHistory" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
            <ContentCollection>
                <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                    <table cellpadding="0" style="text-align: left; width: 350px">
                        <tr>
                            <td style="text-align: center">
                                <dxe:ASPxMemo ID="txtRemarks_History" runat="server" ClientInstanceName="txtRemarks_History" Width="325px" Height="125px" ReadOnly="true" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                <div class="centered" style="width: 80px">
                                    <dxe:ASPxButton ID="cmdHistory" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                        <ClientSideEvents Click="function(s, e) { pcHistory.Hide(); }" />
                                    </dxe:ASPxButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
        </dxpc:ASPxPopupControl>
        <div class="padding">
            <div style="text-align: left">
                <dxrp:ASPxRoundPanel ID="pnlTrainingAgreement" runat="server" ClientInstanceName="pnlTrainingAgreement" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxrp:ASPxRoundPanel ID="pnlTrainingAgreement_001" runat="server" ClientInstanceName="pnlTrainingAgreement_001" Width="100%">
                                <PanelCollection>
                                    <dxp:PanelContent ID="PanelContent2" runat="server">
                                        <table style="color: #000000; font: 9pt Tahoma; width: 100%">
                                            <tr>
                                                <td width="5%"></td>
                                                <td width="30%" style="text-align: left">ID Number</td>
                                                <td width="30%" style="text-align: center"></td>
                                                <td width="30%" style="text-align: left">Date prepared</td>
                                                <td width="5%"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="text-align: center;">
                                                    <dxe:ASPxTextBox ID="txtEmployeeNum_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td></td>
                                                <td style="display: none;">
                                                    <dxe:ASPxTextBox ID="txtTAFID_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtDatePrep_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="3px"></td>
                                            </tr>
                                            <tr>
                                                <td width="5%"></td>
                                                <td width="30%" style="text-align: left">Name</td>
                                                <td width="30%" style="text-align: left">Mobile No.</td>
                                                <td width="30%" style="text-align: left">Local No.</td>
                                                <td width="5%"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="text-align: center;">
                                                    <dxe:ASPxTextBox ID="txtName_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtMobile_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                    </dxe:ASPxTextBox>
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtLocal_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="3px"></td>
                                            </tr>
                                            <tr>
                                                <td width="5%"></td>
                                                <td width="30%" style="text-align: left">Division</td>
                                                <td width="30%" style="text-align: left">Department</td>
                                                <td width="30%" style="text-align: left">Section</td>
                                                <td width="5%"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="text-align: center;">
                                                    <dxe:ASPxTextBox ID="txtDivision_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtDepartment_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtSection_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="3px"></td>
                                            </tr>
                                            <tr>
                                                <td width="5%"></td>
                                                <td width="30%" style="text-align: left">Level</td>
                                                <td width="30%" style="text-align: left">External Position Title</td>
                                                <td width="30%" style="text-align: left">RTA No.(HRD-Training use only)<span style="color: red">*</span></td>
                                                <td width="5%"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="text-align: center;">
                                                    <dxe:ASPxTextBox ID="txtLevel_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtExternalPos_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                    </dxe:ASPxTextBox>
                                                </td>
                                                <td style="text-align: center">
                                                    <dxe:ASPxTextBox ID="txtRTA_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="true">
                                                        <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                        </ValidationSettings>--%>
                                                    </dxe:ASPxTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </dxp:PanelContent>
                                </PanelCollection>
                                <HeaderTemplate>
                                    <table style="height: 16px; width: 100%">
                                        <tr valign="middle">
                                            <td style="width: 20px">
                                                <dxe:ASPxImage ID="ASPxImage2" runat="server" ImageUrl="images/training_001.png" />
                                            </td>
                                            <td>
                                                <dxe:ASPxLabel ID="lblPanel" runat="server" Text="Team Member's Profile" />
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                            </dxrp:ASPxRoundPanel>
                            <br />
                            <dxrp:ASPxRoundPanel ID="pnlTrainingAgreement1_001" runat="server" ClientInstanceName="pnlTrainingAgreement1_001" Width="100%">
                                <PanelCollection>
                                    <dxp:PanelContent runat="server">
                                        <dxrp:ASPxRoundPanel ID="pnlAgreement1_001" runat="server" ClientInstanceName="pnlAgreement1_001" Width="100%">
                                            <PanelCollection>
                                                <dxp:PanelContent runat="server">
                                                    <table style="color: #000000; font: 9pt Tahoma; width: 100%;">
                                                        <tr>
                                                            <td width="5%"></td>
                                                            <td width="30%" style="text-align: left">Program Title</td>
                                                            <td width="30%" style="text-align: left">Provider</td>
                                                            <td width="30%" style="text-align: left">Duration</td>
                                                            <td width="5%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td style="text-align: center">
                                                                <dxe:ASPxTextBox ID="txtProgramTitle_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                            <td style="text-align: center">
                                                                <dxe:ASPxTextBox ID="txtProvider_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                            <td style="text-align: center">
                                                                <dxe:ASPxTextBox ID="txtDuration_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="3px"></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="5%"></td>
                                                            <td width="30%" style="text-align: left">Type</td>
                                                            <td width="30%" style="text-align: left">Program Type</td>
                                                            <td width="30%" style="text-align: left">Investment</td>
                                                            <td width="5%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td style="text-align: center;">
                                                                <dxe:ASPxTextBox ID="txtType_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                            <td style="text-align: center;">
                                                                <dxe:ASPxTextBox ID="txtProgramType_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                            <td style="text-align: center">
                                                                <dxe:ASPxTextBox ID="txtInvestment_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dxp:PanelContent>
                                            </PanelCollection>
                                            <HeaderTemplate>
                                                <table style="height: 16px; width: 100%">
                                                    <tr valign="middle">
                                                        <td style="width: 20px">
                                                            <dxe:ASPxImage runat="server" ImageUrl="images/training_001.png" />
                                                        </td>
                                                        <td>
                                                            <dxe:ASPxLabel runat="server" Text="Training And Development Program" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                        </dxrp:ASPxRoundPanel>
                                        <br />
                                        <dxrp:ASPxRoundPanel ID="pnlTrainingAgreement2_001" runat="server" ClientInstanceName="pnlTrainingAgreement2_001" Width="100%">
                                            <PanelCollection>
                                                <dxp:PanelContent runat="server">
                                                    <table style="color: #000000; font: 9pt Tahoma; width: 100%;">
                                                        <tr>
                                                            <td width="5%"></td>
                                                            <td width="30%" style="text-align: left">Duration</td>
                                                            <td width="30%" style="text-align: left">Existing/Start<span style="color: red">*</span></td>
                                                            <td width="30%" style="text-align: left">Expiry</td>
                                                            <td width="5%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td style="text-align: center">
                                                                <dxe:ASPxTextBox ID="txtSEDDuration_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                            </td>
                                                            <td style="text-align: center">
                                                                <asp:UpdatePanel runat="server" ID="updExistingStart_007" RenderMode="Inline" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <dxe:ASPxDateEdit ID="dteSEDExistingStart_007" AutoPostBack="true" runat="server" Width="95%" EditFormat="Date">
                                                                            <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>--%>
                                                                        </dxe:ASPxDateEdit>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                            <td style="text-align: center">
                                                                <asp:UpdatePanel runat="server" ID="updExpiry_007" RenderMode="Inline" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <dxe:ASPxTextBox ID="txtSEDExpiry_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dxp:PanelContent>
                                            </PanelCollection>
                                            <HeaderTemplate>
                                                <table style="height: 16px; width: 100%">
                                                    <tr valign="middle">
                                                        <td style="width: 20px">
                                                            <dxe:ASPxImage ID="ASPxImage4" runat="server" ImageUrl="images/training_001.png" />
                                                        </td>
                                                        <td>
                                                            <dxe:ASPxLabel ID="ASPxLabel1" runat="server" Text="Service Agreement Details (HRD-Training use only)" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                        </dxrp:ASPxRoundPanel>
                                    </dxp:PanelContent>
                                </PanelCollection>
                                <HeaderTemplate>
                                    <table style="height: 16px; width: 100%">
                                        <tr valign="middle">
                                            <td style="width: 20px">
                                                <dxe:ASPxImage runat="server" ImageUrl="images/training_001.png" />
                                            </td>
                                            <td>
                                                <dxe:ASPxLabel ID="lblPanel" runat="server" Text="Program Details" />
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                            </dxrp:ASPxRoundPanel>
                            <br />
                            <dxrp:ASPxRoundPanel ID="pnlTrainingAgreement_002" runat="server" ClientInstanceName="pnlTrainingAgreement_002" Width="100%">
                                <PanelCollection>
                                    <dxp:PanelContent runat="server">
                                        <table style="color: #000000; font: 9pt Tahoma; width: 100%;">
                                            <colgroup>
                                                <col width="160px" />
                                                <col width="10px" />
                                                <col />
                                                <col width="40%" />
                                            </colgroup>
                                            <tr>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblCategoryBC_010" runat="server" Text="Category" />
                                                    <span style="color: red">*</span>
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updCategoryBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxComboBox runat="server" ID="cmbCategoryBC_010" Width="96.2%" DataSourceID="dsCategoryBC_010" TextField="CategoryName" ValueField="CategoryName" AutoPostBack="true">
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxComboBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblBudgetCodeBC_010" runat="server" Text="Budget Code" />
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updBudgetCodeBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxTextBox ID="txtBudgetCodeBC_010" runat="server" Width="96.2%" >
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxTextBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblBeginningBalanceBC_010" runat="server" Text="Beginning Balance" />
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updBeginningBalanceBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxTextBox ID="txtBeginningBalanceBC_010" runat="server" Width="96.2%" >
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxTextBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblTrainingCostBC_010" runat="server" Text="Less Training Cost" />
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updTrainingCostBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxTextBox ID="txtTrainingCostBC_010" runat="server" Width="96.2%" >
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxTextBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblBudgetBalanceBC_010" runat="server" Text="Budget Balance" />
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updBudgetBalanceBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxTextBox ID="txtBudgetBalanceBC_010" runat="server" Width="96.2%" >
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxTextBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr style="display:none">
                                                <td>
                                                    <dxe:ASPxLabel ID="lblNewSequenceBC_010" runat="server" Text="Sequence Num" />
                                                </td>
                                                <td></td>
                                                <td>
                                                    <asp:UpdatePanel ID="updNewSequenceBC_010" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <dxe:ASPxTextBox ID="txtNewSequenceBC_010" runat="server" Width="96.2%" >
                                                                <%--<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>--%>
                                                            </dxe:ASPxTextBox>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </dxp:PanelContent>
                                </PanelCollection>
                                <HeaderTemplate>
                                    <table style="height: 16px; width: 100%">
                                        <tr valign="middle">
                                            <td style="width: 20px">
                                                <dxe:ASPxImage ID="ASPxImage1" runat="server" ImageUrl="images/training_001.png" />
                                            </td>
                                            <td>
                                                <dxe:ASPxLabel ID="lblPanel" runat="server" Text="Budget Utilization (HRD-Training use only)" />
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                            </dxrp:ASPxRoundPanel>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td style="text-align: left">Comments (optional):</td>
                                </tr>
                                <tr>
                                    <td style="text-align: left">
                                        <dxe:ASPxMemo ID="txtRemarks" runat="server" Height="75px" Width="100%" ClientInstanceName="txtRemarks" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Table ID="tblButtons" runat="server" Width="100%">
                                            <asp:TableRow>
                                                <asp:TableCell HorizontalAlign="Right">
                                                    <dxe:ASPxButton ID="cmdApprove" runat="server" Text="Approve" Width="80px" AutoPostBack="false">

                                                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Approve ' + txtRemarks.GetText()); console.log('Not Sad') }" />

                                                    </dxe:ASPxButton>

                                                </asp:TableCell>
                                                <asp:TableCell Width="10px" />
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <dxe:ASPxButton ID="cmdReject" runat="server" Text="Reject" Width="80px" AutoPostBack="false">

                                                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Reject ' + txtRemarks.GetText()); console.log('Sad') }" />

                                                    </dxe:ASPxButton>

                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage ID="ASPxImage3" runat="server" ImageUrl="images/training_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel ID="lblPanel" runat="server" Text="Training Agreement: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
        </div>
        <asp:SqlDataSource ID="dsCategoryBC_010" runat="server" />
    </form>
</body>
</html>
