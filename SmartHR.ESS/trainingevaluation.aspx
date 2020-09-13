<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="trainingevaluation.aspx.vb" Inherits="SmartHR.trainingevaluation" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="scripts/jquery-1.4.2-vsdoc.js"></script>
    <script src="scripts/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .rtable {
            border: 1px solid #AECAF0;
            border-collapse: collapse;
        }
    </style>
    <title>SmartHR (Employee Self Service)</title>
</head>
<body onload="window.parent.reset();">
    <form id="_trainingevaluation" runat="server">
        <asp:ScriptManager ID="sm" runat="server" EnablePartialRendering="true" ScriptMode="release" EnablePageMethods="true"></asp:ScriptManager>

        <div id="pnlExternal" runat="server" visible="false">
            <dxrp:ASPxRoundPanel ID="pnlExternal_001" runat="server" ClientInstanceName="pnlExternal_001" Width="100%">
                <PanelCollection>
                    <dxp:PanelContent runat="server">
                        <table width="100%">
                            <tr>
                                <td>
                                    <dxe:ASPxButton ID="btnExpandCollapse_001" runat="server" Text="Hide Information" AllowFocus="False" AutoPostBack="False" Width="100px">
                                        <Paddings Padding="1px" />
                                        <FocusRectPaddings Padding="0" />
                                        <ClientSideEvents Click="function(s, e) { var isVisible = pnlInstruction_001.GetVisible();s.SetText(isVisible ? 'Show Information' : 'Hide Information'); pnlInstruction_001.SetVisible(!isVisible);}" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dxrp:ASPxRoundPanel ID="pnlInstruction_001" runat="server" ClientInstanceName="pnlInstruction_001" Width="100%"
                                        ShowHeader="False">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <table style="color: #000000; font: 10pt Tahoma; width: 100%">
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Participant</td>
                                                        <td width="30%" style="text-align: left"></td>
                                                        <td width="30%" style="text-align: left">ID No.</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtParticipant_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td></td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtID_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="3px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Program</td>
                                                        <td width="30%" style="text-align: left">Training Provider</td>
                                                        <td width="30%" style="text-align: left">Training Date</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtTrainingProgram_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtProvider_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtTrainingDate_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="3px">a</td>
                                                    </tr>
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Name of Speaker<span style="color: red">*</span></td>
                                                        <td width="30%" style="text-align: left">No. of Participants<span style="color: red">*</span></td>
                                                        <td width="30%" style="text-align: left">Venue</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtSpeaker_001" runat="server" Width="101%" HorizontalAlign="Left" Enabled="true">
                                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtNoOfParticipants_001" runat="server" Width="101%" HorizontalAlign="Left" Enabled="true">
                                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                </ValidationSettings>
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtVenue_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
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
                                                            <dxe:ASPxTextBox ID="txtDivision_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtDepartment_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtSection_001" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table width="100%" style="color: #000000; font: 10pt Tahoma;">
                                                    <tr id="tr1">
                                                        <td width="10%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="10%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" align="center">PLEASE EVALUATE THE SEMINAR BY CHECKING (&#x2713;) THE APPROPRIATE BOX.</td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxrp:ASPxRoundPanel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 40px;">
                                <td class="rtable" width="40%" style="text-align: center;">Measures</td>
                                <td class="rtable" width="15%" style="text-align: center;">Poor</td>
                                <td class="rtable" width="15%" style="text-align: center;">Fair</td>
                                <td class="rtable" width="15%" style="text-align: center;">Good</td>
                                <td class="rtable" width="15%" style="text-align: center;">Excellent</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 20px">
                                <td colspan="5" style="text-align: left; padding-left: .5%">I. TOPIC</td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">1.1 Content<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtContent1_001" GroupName="Content_001" ClientInstanceName="rbtContent1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtContent2_001" GroupName="Content_001" ClientInstanceName="rbtContent2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtContent3_001" GroupName="Content_001" ClientInstanceName="rbtContent3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtContent4_001" GroupName="Content_001" ClientInstanceName="rbtContent4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">1.2 Relevance<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtRelevance1_001" GroupName="Relevance_001" ClientInstanceName="rbtRelevance1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtRelevance2_001" GroupName="Relevance_001" ClientInstanceName="rbtRelevance2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtRelevance3_001" GroupName="Relevance_001" ClientInstanceName="rbtRelevance3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtRelevance4_001" GroupName="Relevance_001" ClientInstanceName="rbtRelevance4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">1.3 Compliance with Presented Course Outline<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtCompliance1_001" GroupName="Compliance_001" ClientInstanceName="rbtCompliance1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e,); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtCompliance2_001" GroupName="Compliance_001" ClientInstanceName="rbtCompliance2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtCompliance3_001" GroupName="Compliance_001" ClientInstanceName="rbtCompliance3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e,); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtCompliance4_001" GroupName="Compliance_001" ClientInstanceName="rbtCompliance4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 20px">
                                <td colspan="5" style="text-align: left; padding-left: .5%">II. METHODOLOGY</td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">2.1 Activities<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtActivities1_001" GroupName="Activities_001" ClientInstanceName="rbtActivities1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtActivities2_001" GroupName="Activities_001" ClientInstanceName="rbtActivities2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtActivities3_001" GroupName="Activities_001" ClientInstanceName="rbtActivities3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtActivities4_001" GroupName="Activities_001" ClientInstanceName="rbtActivities4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">2.2 Pace / Timing<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPaceTiming1_001" GroupName="PaceTiming_001" ClientInstanceName="rbtPaceTiming1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPaceTiming2_001" GroupName="PaceTiming_001" ClientInstanceName="rbtPaceTiming2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPaceTiming3_001" GroupName="PaceTiming_001" ClientInstanceName="rbtPaceTiming3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPaceTiming4_001" GroupName="PaceTiming_001" ClientInstanceName="rbtPaceTiming4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">2.3 Clarity of Presentation<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtClarity1_001" GroupName="Clarity_001" ClientInstanceName="rbtClarity1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtClarity2_001" GroupName="Clarity_001" ClientInstanceName="rbtClarity2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtClarity3_001" GroupName="Clarity_001" ClientInstanceName="rbtClarity3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtClarity4_001" GroupName="Clarity_001" ClientInstanceName="rbtClarity4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">2.4 Organization of Presentation<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtOrganization1_001" GroupName="Organization_001" ClientInstanceName="rbtOrganization1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtOrganization2_001" GroupName="Organization_001" ClientInstanceName="rbtOrganization2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtOrganization3_001" GroupName="Organization_001" ClientInstanceName="rbtOrganization3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtOrganization4_001" GroupName="Organization_001" ClientInstanceName="rbtOrganization4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">2.5 Interaction to Participants<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtInteraction1_001" GroupName="Interaction_001" ClientInstanceName="rbtInteraction1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtInteraction2_001" GroupName="Interaction_001" ClientInstanceName="rbtInteraction2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtInteraction3_001" GroupName="Interaction_001" ClientInstanceName="rbtInteraction3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtInteraction4_001" GroupName="Interaction_001" ClientInstanceName="rbtInteraction4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 20px">
                                <td colspan="5" style="text-align: left; padding-left: .5%">III. TRAINER</td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">3.1 Knowledge<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtKnowledge1_001" GroupName="Knowledge_001" ClientInstanceName="rbtKnowledge1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtKnowledge2_001" GroupName="Knowledge_001" ClientInstanceName="rbtKnowledge2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtKnowledge3_001" GroupName="Knowledge_001" ClientInstanceName="rbtKnowledge3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtKnowledge4_001" GroupName="Knowledge_001" ClientInstanceName="rbtKnowledge4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">3.2 Voice Clarity<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVoiceClarity1_001" GroupName="VoiceClarity_001" ClientInstanceName="rbtVoiceClarity1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVoiceClarity2_001" GroupName="VoiceClarity_001" ClientInstanceName="rbtVoiceClarity2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVoiceClarity3_001" GroupName="VoiceClarity_001" ClientInstanceName="rbtVoiceClarity3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVoiceClarity4_001" GroupName="VoiceClarity_001" ClientInstanceName="rbtVoiceClarity4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">3.3 Preparedness<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPreparedness1_001" GroupName="Preparedness_001" ClientInstanceName="rbtPreparedness1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPreparedness2_001" GroupName="Preparedness_001" ClientInstanceName="rbtPreparedness2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPreparedness3_001" GroupName="Preparedness_001" ClientInstanceName="rbtPreparedness3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPreparedness4_001" GroupName="Preparedness_001" ClientInstanceName="rbtPreparedness4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">3.4 Appearance<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAppearance1_001" GroupName="Appearance_001" ClientInstanceName="rbtAppearance1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAppearance2_001" GroupName="Appearance_001" ClientInstanceName="rbtAppearance2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAppearance3_001" GroupName="Appearance_001" ClientInstanceName="rbtAppearance3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAppearance4_001" GroupName="Appearance_001" ClientInstanceName="rbtAppearance4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">3.5 Presentation Skills<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPresentation1_001" GroupName="Presentation_001" ClientInstanceName="rbtPresentation1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPresentation2_001" GroupName="Presentation_001" ClientInstanceName="rbtPresentation2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPresentation3_001" GroupName="Presentation_001" ClientInstanceName="rbtPresentation3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtPresentation4_001" GroupName="Presentation_001" ClientInstanceName="rbtPresentation4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 20px">
                                <td colspan="5" style="text-align: left; padding-left: .5%">IV. TRAINING MATERIALS</td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">4.1 Audio-Visual Aids<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAudioVisual1_001" GroupName="AudioVisual_001" ClientInstanceName="rbtAudioVisual1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAudioVisual2_001" GroupName="AudioVisual_001" ClientInstanceName="rbtAudioVisual2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAudioVisual3_001" GroupName="AudioVisual_001" ClientInstanceName="rbtAudioVisual3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtAudioVisual4_001" GroupName="AudioVisual_001" ClientInstanceName="rbtAudioVisual4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">4.2 Handouts / Training Kit<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtHandouts1_001" GroupName="Handouts_001" ClientInstanceName="rbtHandouts1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtHandouts2_001" GroupName="Handouts_001" ClientInstanceName="rbtHandouts2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtHandouts3_001" GroupName="Handouts_001" ClientInstanceName="rbtHandouts3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtHandouts4_001" GroupName="Handouts_001" ClientInstanceName="rbtHandouts4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 20px">
                                <td colspan="5" style="text-align: left; padding-left: .5%">V. LOGISTICS</td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">5.1 Food<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtFood1_001" GroupName="Food_001" ClientInstanceName="rbtFood1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtFood2_001" GroupName="Food_001" ClientInstanceName="rbtFood2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtFood3_001" GroupName="Food_001" ClientInstanceName="rbtFood3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtFood4_001" GroupName="Food_001" ClientInstanceName="rbtFood4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">5.2 Location<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLocation1_001" GroupName="Location_001" ClientInstanceName="rbtLocation1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLocation2_001" GroupName="Location_001" ClientInstanceName="rbtLocation2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLocation3_001" GroupName="Location_001" ClientInstanceName="rbtLocation3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLocation4_001" GroupName="Location_001" ClientInstanceName="rbtLocation4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">5.3 Venue Layout<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVenue1_001" GroupName="Venue_001" ClientInstanceName="rbtVenue1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVenue2_001" GroupName="Venue_001" ClientInstanceName="rbtVenue2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVenue3_001" GroupName="Venue_001" ClientInstanceName="rbtVenue3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtVenue4_001" GroupName="Venue_001" ClientInstanceName="rbtVenue4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">5.4 Lighting<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLighting1_001" GroupName="Lighting_001" ClientInstanceName="rbtLighting1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLighting2_001" GroupName="Lighting_001" ClientInstanceName="rbtLighting2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLighting3_001" GroupName="Lighting_001" ClientInstanceName="rbtLighting3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtLighting4_001" GroupName="Lighting_001" ClientInstanceName="rbtLighting4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">5.5 Temperature<span style="color: red">*</span></td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtTemperature1_001" GroupName="Temperature_001" ClientInstanceName="rbtTemperature1_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtTemperature2_001" GroupName="Temperature_001" ClientInstanceName="rbtTemperature2_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtTemperature3_001" GroupName="Temperature_001" ClientInstanceName="rbtTemperature3_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxRadioButton runat="server" ID="rbtTemperature4_001" GroupName="Temperature_001" ClientInstanceName="rbtTemperature4_001">
                                        <ClientSideEvents CheckedChanged="function(s, e) { updateProgressBarOnCheckedChanged(s, e); }" />
                                    </dxe:ASPxRadioButton>
                                </td>
                            </tr>
                            <tr style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 40px;">
                                <td class="rtable" align="right">TALLY:&nbsp</td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxLabel ID="lblTally1_001" Text="0" runat="server"></dxe:ASPxLabel>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxLabel ID="lblTally2_001" Text="0" runat="server"></dxe:ASPxLabel>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxLabel ID="lblTally3_001" Text="0" runat="server"></dxe:ASPxLabel>
                                </td>
                                <td class="rtable" align="center">
                                    <dxe:ASPxLabel ID="lblTally4_001" Text="0" runat="server"></dxe:ASPxLabel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 40px;">
                                <td>Please answer the following:</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">1. On a scale of 1 - 10 (10 as highest), rate your learning from the training (please justify):<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt1_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">2. Will you recommend this for future TMP participants? (please justify):<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt2_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">3. Have the objectives of the course been met? (please justify):<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt3_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">4. In what way has the seminar helped you?<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt4_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">5. Cite new ideas / project obtained from the seminar (if any):<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt5_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">6. Comments / Suggestions to Training Provider:<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt6_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; height: 20px">
                                <td style="text-align: left; padding-left: .5%">7. Comments / Suggestions to HRD Training:<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 35px">
                                <td class="rtable" style="padding-left: 1.5%">
                                    <dxe:ASPxMemo ID="memoExt7_001" Width="100%" runat="server" Rows="4">
                                        <ClientSideEvents TextChanged="function(s, e) {updateProgressBarOnCheckedChanged(s, e); }" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr>
                                <td align="center">
                                    <dxe:ASPxButton ID="btnSubmit_001" Width="150px" Height="35px" runat="server" Text="Submit">
                                        <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dxp:PanelContent>
                </PanelCollection>
                <HeaderTemplate>
                    <table style="height: 16px; width: 100%">
                        <tr valign="middle">
                            <td style="width: 20px">
                                <dxe:ASPxImage ID="imgPanel_001" runat="server" ImageUrl="images/performance_007.png" />
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="lblPanel_001" runat="server" Text="Training Evaluation Form: (External)" />
                            </td>
                            <td></td>
                            <td style="width: 50%">
                                <dxe:ASPxProgressBar ID="progIndicator_001" EnableTheming="false" ClientInstanceName="progIndicator_001" Width="100%" runat="server" />
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>
            </dxrp:ASPxRoundPanel>
        </div>

        <div id="pnlInHouse" runat="server" visible="false">
            <dxrp:ASPxRoundPanel ID="pnlInhouse_002" runat="server" ClientInstanceName="pnlInhouse_002" Width="100%">
                <PanelCollection>
                    <dxp:PanelContent runat="server">
                        <table width="100%">
                            <tr>
                                <td>
                                    <dxe:ASPxButton ID="btnExpandCollapse_002" runat="server" Text="Hide Information" AllowFocus="False" AutoPostBack="False" Width="100px">
                                        <Paddings Padding="1px" />
                                        <FocusRectPaddings Padding="0" />
                                        <ClientSideEvents Click="function(s, e) { var isVisible = rpanel_002.GetVisible();s.SetText(isVisible ? 'Show Information' : 'Hide Information'); rpanel_002.SetVisible(!isVisible);}" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dxrp:ASPxRoundPanel ID="rpanel_002" runat="server" ClientInstanceName="rpanel_002" Width="100%"
                                        ShowHeader="False">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <table style="color: #000000; font: 10pt Tahoma; width: 100%">
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Participant</td>
                                                        <td width="30%" style="text-align: left">ID No.</td>
                                                        <td width="30%" style="text-align: left">Training Date</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtParticipant_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtIDNum_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtTrainingDate_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="3px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Program</td>
                                                        <td width="30%" style="text-align: left">Training Provider</td>
                                                        <td width="30%" style="text-align: left">Trainer/Facilitator</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtTrainingProgram_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtProvider_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtTrainer_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
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
                                                            <dxe:ASPxTextBox ID="txtDivision_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtDepartment_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false">
                                                            </dxe:ASPxTextBox>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtSection_002" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table width="100%" style="color: #000000; font: 10pt Tahoma;">
                                                    <tr id="trInstructions">
                                                        <td width="10%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="10%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" align="center">Thank you for attending this Training Program!<br />
                                                            To Help us improve our programs and activities, please respond to the following:</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td colspan="5">
                                                            <br />
                                                            <table width="100%" style="border-style: dashed;" class="rtable">
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>1 - Highly<br />
                                                                        Dissatisfied</td>
                                                                    <td>2 - Dissatisfied</td>
                                                                    <td>3 - Needs<br />
                                                                        Improvement</td>
                                                                    <td>4 - Satisfied</td>
                                                                    <td>5 - Highly Satisfied</td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxrp:ASPxRoundPanel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 45px;">
                                <td class="rtable" width="15%" style="text-align: center;">Item</td>
                                <td class="rtable" width="25%" style="text-align: center;">Response</td>
                                <td class="rtable" width="25%" style="text-align: center;">Strengths</td>
                                <td class="rtable" width="25%" style="text-align: center;">Areas for Improvement</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 25px">
                                <td colspan="4" style="text-align: left">1. TRAINER FACILITATION</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">1.1 Content Delivery<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtContentDelivery_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentDelivery1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentDelivery2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">1.2 Content Mastery<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtContentMastery_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentMastery1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentMastery2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">1.3 Class Interaction<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtClassInteraction_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoClassInteraction1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoClassInteraction2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">1.4 Time Management<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtTimeManagement_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoTimeManagement1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoTimeManagement2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">1.5 Professionalism<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtProfessionalism_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoProfessionalism1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoProfessionalism2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 25px">
                                <td colspan="4" style="text-align: left">2. METHODOLOGY</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">2.1 Activities/Workshops<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtActivitiesWorkshop_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoActivitiesWorkshop1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoActivitiesWorkshop2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">2.2 Pace/Timing<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtPaceTiming_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoPaceTiming1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoPaceTiming2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">2.3 Content Flow<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtContentFlow_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentFlow1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContentFlow2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 25px">
                                <td colspan="4" style="text-align: left">3. TOPIC</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">3.1 Content<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtContent_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContent1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoContent2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">3.2 Relevance to Job Function<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtRelevance_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoRelevance1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoRelevance2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 25px">
                                <td colspan="4" style="text-align: left">4. TRAINING ADMINISTRATOR</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.1 Training Communication / Information Dissemination<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtTraining_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoTraining1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoTraining2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.2 Training Materials<span style="color: red">*</span><br />
                                    (Handouts, Videos, Supplies)</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtMaterials_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoMaterials1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoMaterials2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.3 Equipment<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtEquipment_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoEquipment1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoEquipment2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.4 Venue / Room Layout<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtVenue_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoVenue1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoVenue2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.5 Food and Beverage<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtFood_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoFood1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoFood2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">4.6 Admin Support and Logistics<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtAdminSupport_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoAdminSupport1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoAdminSupport2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 11pt Tahoma; font-weight: bold; height: 25px">
                                <td colspan="4" style="text-align: left">5. PROGRAM RATING</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">5.1 Overall Rating of the Program<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rbtOverall_002" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%">
                                        <Paddings PaddingLeft="10%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoOverall1_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoOverall2_002" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="font-weight: bold">Overall Comments/Suggestions<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoCommentsSuggestion_002" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                        <ClientSideEvents TextChanged="function(s, e) { updateProgressBarOnSelectedIndexChanged(s, e); }" />
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr>
                                <td align="center">
                                    <dxe:ASPxButton ID="btnSubmit_002" Width="150px" Height="35px" runat="server" Text="Submit">
                                        <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dxp:PanelContent>
                </PanelCollection>
                <HeaderTemplate>
                    <table style="height: 16px; width: 100%">
                        <tr valign="middle">
                            <td style="width: 20px">
                                <dxe:ASPxImage ID="imgPanel_002" runat="server" ImageUrl="images/performance_007.png" />
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="lblPanel_002" runat="server" Text="Training Evaluation Form: (In-House)" />
                            </td>
                            <td></td>
                            <td style="width: 50%">
                                <dxe:ASPxProgressBar ID="progIndicator_002" EnableTheming="false" ClientInstanceName="progIndicator_002" Width="100%" runat="server" />
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>
            </dxrp:ASPxRoundPanel>
        </div>

        <div id="pnlOverseas" runat="server" visible="false">
            <dxrp:ASPxRoundPanel ID="pnlOverseas_003" runat="server" ClientInstanceName="pnlOverseas_003" Width="100%">
                <PanelCollection>
                    <dxp:PanelContent runat="server">
                        <table width="100%">
                            <tr>
                                <td>
                                    <dxrp:ASPxRoundPanel ID="rpanel_003" runat="server" ClientInstanceName="rpanel_003" Width="100%"
                                        ShowHeader="False">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <table style="color: #000000; font: 10pt Tahoma; width: 100%">
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Participant</td>
                                                        <td width="30%" style="text-align: left"></td>
                                                        <td width="30%" style="text-align: left">ID No.</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtParticipant_003" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td></td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtIDNum_003" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="3px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="5%"></td>
                                                        <td width="30%" style="text-align: left">Training Program</td>
                                                        <td width="30%" style="text-align: left"></td>
                                                        <td width="30%" style="text-align: left">Training Date</td>
                                                        <td width="5%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="text-align: center;">
                                                            <dxe:ASPxTextBox ID="txtTrainingProgram_003" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                        <td></td>
                                                        <td style="text-align: center">
                                                            <dxe:ASPxTextBox ID="txtTrainingDate_003" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table width="100%" style="color: #000000; font: 10pt Tahoma;">
                                                    <tr id="tr2">
                                                        <td width="10%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="16%"></td>
                                                        <td width="10%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" align="center">Thank you for attending this Training Program!<br />
                                                            To Help us improve our programs and activities, please respond to the following:</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td colspan="5">
                                                            <br />
                                                            <table width="100%" style="border-style: dashed;" class="rtable">
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td>1 - Highly<br />
                                                                        Dissatisfied</td>
                                                                    <td>2 - Dissatisfied</td>
                                                                    <td>3 - Needs<br />
                                                                        Improvement</td>
                                                                    <td>4 - Satisfied</td>
                                                                    <td>5 - Highly Satisfied</td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxrp:ASPxRoundPanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dxe:ASPxButton ID="btnExpandCollapse_003" runat="server" Text="Hide Information" AllowFocus="False" AutoPostBack="False" Width="100px">
                                        <Paddings Padding="1px" />
                                        <FocusRectPaddings Padding="0" />
                                        <ClientSideEvents Click="function(s, e) { var isVisible = rpanel_003.GetVisible();s.SetText(isVisible ? 'Show Information' : 'Hide Information'); rpanel_003.SetVisible(!isVisible);}" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 12pt Tahoma; font-weight: bold; height: 45px;">
                                <td colspan="5" style="text-align: left">1. EXPOSURE</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="25%" style="text-align: center;">Evaluation/Response<span style="color: red">*</span></td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Explanation for Rating<span style="color: red">*</span></td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Strengths</td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Areas for Improvement</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">How would you rate your overall experience? Why? Please explain.</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblExposure1_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoExposure1_003" runat="server" Rows="5" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoExposure2_003" runat="server" Rows="5" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoExposure3_003" runat="server" Rows="5" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="15%" style="text-align: center;">Evaluation/Response<span style="color: red">*</span></td>
                                <td class="rtable" width="20%" style="text-align: center;" colspan="3">Comments/Suggestions</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Assignment / Training Objectives vs. Actual Experience</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblExperience_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoExperience_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Level of Exposure</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblExposureLevel_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoExposureLevel_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr class="rtable dgHeader" style="color: #000000; font: 12pt Tahoma; font-weight: bold; height: 45px;">
                                <td colspan="5" style="text-align: left">2. GROUP DYNAMICS</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="25%" style="text-align: center;">Superior<span style="color: red">*</span></td>
                                <td class="rtable" width="25%" style="text-align: center;">Subordinates<span style="color: red">*</span></td>
                                <td class="rtable" width="25%" style="text-align: center;">Colleagues<span style="color: red">*</span></td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">How would you describe your work dynamics with the following stakeholders below?:</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoSuperior_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoSubordinates_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoColleagues_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="15%" style="text-align: center;">Evaluation/Response<span style="color: red">*</span></td>
                                <td class="rtable" width="20%" style="text-align: center;" colspan="3">Comments/Suggestions</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Teamwork - Assigned Group</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblAssignedGroup_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoAssignedGroup_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Teamwork - Inter-group</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblInterGroup_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoInterGroup_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 12pt Tahoma; font-weight: bold; height: 45px;">
                                <td colspan="5" style="text-align: left">3. HOUSING</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="25%" style="text-align: center;">Evaluation/Response<span style="color: red">*</span></td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Explanation for Rating<span style="color: red">*</span></td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Strengths</td>
                                <td class="rtable" width="17.5%" style="text-align: center;">Areas for Improvement</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">How would you rate your overall experience with your apartment? Why? Please explain.</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblHousing_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoHousing1_003" runat="server" Rows="5" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoHousing2_003" runat="server" Rows="5" Width="100%"></dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxMemo ID="memoHousing3_003" runat="server" Rows="5" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="15%" style="text-align: center;">Evaluation/Response<span style="color: red">*</span></td>
                                <td class="rtable" width="20%" style="text-align: center;" colspan="3">Comments/Suggestions</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Comfort</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblComfort_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoComfort_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Accessibility of Location</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblAccessibility_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoAccessibility_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Customer Service</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblCustomerService_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoCustomerService_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Security</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblSecurity_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoSecurity_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Amenities (e.g. Pool, Gym, other services, etc.)</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblAmenities_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoAmenities_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Community Ambience</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblAmbience_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoAmbience" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Will you recommend your apartment for future other use?</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblRecommend_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="25%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="Yes" Value="1" />
                                            <dxe:ListEditItem Text="No" Value="0" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoRecommend_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr>
                                <td width="25%"></td>
                                <td width="25%"></td>
                                <td width="17.5%"></td>
                                <td width="17.5%"></td>
                                <td width="17.5%"></td>
                            </tr>
                            <tr style="color: #000000; font: 12pt Tahoma; font-weight: bold; height: 45px;">
                                <td colspan="5" style="text-align: left">4. OTHER ITEMS</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="25%" style="text-align: center;"></td>
                                <td class="rtable" width="15%" style="text-align: center;">Evaluation/Response</td>
                                <td class="rtable" width="20%" style="text-align: center;" colspan="3">Comments/Suggestions</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">TMP-HR Level of Support and Coordination</td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblLevelOfSupport_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="14%" PaddingRight="8%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoLevelOfSupport_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Condition of Position Car<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblCarCondition_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoCarCondition_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Assigned Driver<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblDriver_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoDriver_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Mobile Phone Plan<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblPhonePlan_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoPhonePlan_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Education Support<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblEducationSupport_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoEducationSupport_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">School of Accompanied Child<span style="color: red">*</span></td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblSchool_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="15%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoSchool_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="padding-left: 1%">Hospital Care:
                                    <dxe:ASPxTextBox runat="server" ID="txtHospital_003" Width="95%">
                                        
                                    </dxe:ASPxTextBox>
                                    (Please specify name of hospital)
                                </td>
                                <td class="rtable" style="text-align: center;">
                                    <dxe:ASPxRadioButtonList ID="rblHospital_003" runat="server" Width="100%" RepeatDirection="Horizontal" TextAlign="Left">
                                        <Paddings PaddingLeft="14%" PaddingRight="8%"></Paddings>
                                        <Items>
                                            <dxe:ListEditItem Text="1" Value="1" />
                                            <dxe:ListEditItem Text="2" Value="2" />
                                            <dxe:ListEditItem Text="3" Value="3" />
                                            <dxe:ListEditItem Text="4" Value="4" />
                                            <dxe:ListEditItem Text="5" Value="5" />
                                        </Items>
                                        <Border BorderStyle="None" />
                                    </dxe:ASPxRadioButtonList>
                                </td>
                                <td class="rtable" style="text-align: center;" colspan="3">
                                    <dxe:ASPxMemo ID="memoHospital_003" runat="server" Rows="4" Width="100%"></dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr style="height: 60px">
                                <td class="rtable" colspan="5">
                                    <table width="100%">
                                        <tr>
                                            <td width="13%" style="padding-left: .8%" align="left">Number of visits to the hospital:</td>
                                            <td width="5%">
                                                <dxe:ASPxTextBox runat="server" ID="txtVisits_003" Width="100%" HorizontalAlign="Center">

                                                </dxe:ASPxTextBox>
                                            </td>
                                            <td width="10%" align="right">Reasons of visit:</td>
                                            <td width="75%" align="left">
                                                <dxe:ASPxMemo ID="memoVisits_003" runat="server" Rows="3" Width="40%"></dxe:ASPxMemo>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr style="color: #000000; font: 12pt Tahoma; font-weight: bold; height: 45px;">
                                <td colspan="5" style="text-align: left">5. OTHER COMMENTS / SUGGESTIONS</td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="50%" style="text-align: left; padding-left: 2%;">To Host Division:</td>
                                <td class="rtable" width="50%" style="text-align: left; padding-left: 2%;">To Host HR:</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="text-align: center; padding-left: 2%">
                                    <dxe:ASPxMemo ID="memoHostDivision_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center; padding-left: 2%">
                                    <dxe:ASPxMemo ID="memoHostHR_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                            <tr class="rtable dgHeader" style="color: #000000; font: 10pt Tahoma; font-weight: bold; height: 20px">
                                <td class="rtable" width="50%" style="text-align: left; padding-left: 2%;">To Home Division:</td>
                                <td class="rtable" width="50%" style="text-align: left; padding-left: 2%;">To Home HR:</td>
                            </tr>
                            <tr style="height: 40px">
                                <td class="rtable" style="text-align: center; padding-left: 2%">
                                    <dxe:ASPxMemo ID="memoHomeDivision_003" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                                <td class="rtable" style="text-align: center; padding-left: 2%">
                                    <dxe:ASPxMemo ID="memoHomeHR" runat="server" Rows="4" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                        </ValidationSettings>
                                    </dxe:ASPxMemo>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="color: #000000; font: 10pt Tahoma; width: 100%" cellpadding="0">
                            <tr>
                                <td align="center">
                                    <dxe:ASPxButton ID="btnSubmit_003" Width="150px" Height="35px" runat="server" Text="Submit">
                                        <ClientSideEvents Click="function(s, e) {
                                             if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dxp:PanelContent>
                </PanelCollection>
                <HeaderTemplate>
                    <table style="height: 16px; width: 100%">
                        <tr valign="middle">
                            <td style="width: 20px">
                                <dxe:ASPxImage ID="imgPanel_002" runat="server" ImageUrl="images/performance_007.png" />
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="lblPanel_002" runat="server" Text="Training Evaluation Form: (In-House)" />
                            </td>
                            <td></td>
                            <td style="width: 50%">
                                <%--<dxe:ASPxProgressBar ID="progIndicator_003" EnableTheming="false" ClientInstanceName="progIndicator_003" Width="100%" runat="server" />--%>
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>
            </dxrp:ASPxRoundPanel>
        </div>

        <asp:HiddenField ID="hfPathID" runat="server" />
        <asp:HiddenField ID="hfProgBar" runat="server" />
        <asp:HiddenField ID="hfExternalTally1" runat="server" />
        <asp:HiddenField ID="hfExternalTally2" runat="server" />
        <asp:HiddenField ID="hfExternalTally3" runat="server" />
        <asp:HiddenField ID="hfExternalTally4" runat="server" />

        <script src="scripts/trainingevaluation.js" type="text/javascript"></script>
    </form>
</body>
</html>
