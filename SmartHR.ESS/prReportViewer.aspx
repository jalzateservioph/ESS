<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="prReportViewer.aspx.vb" Inherits="SmartHR.prReportViewer" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        td {
            clear:both; 
        }
        .parent {
            height:100%;
            width: 100%;
        }
        .child {
            overflow:auto;
            width: 100%;
            
            right: 0;
            top: 0;
        }
    </style>
    
</head>
<body style="height:100%;" onload="window.parent.reset();">
    <form id="form1" runat="server">  
    <div class="parent">
        <div id="div" runat="server" style="height:10%;">
            <table cellpadding="5px" cellspacing="5px" align="center">
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Report Type:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblReportType" runat="server" Text="Performance Rating" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Rating Type:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblRatingType" runat="server" Text="Mid Year Periodic Appraisal" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Year:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblyear" runat="server" Text="2008" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Hire Date:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblHireDate" runat="server" Text="12/16/2006" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="As Of:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblAsOf" runat="server" Text="12/16/2006" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Filter Description:" Font-Bold="True"></dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="lblFilter" runat="server" Text="sample" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                    <td>

                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblusersname" runat="server" Text="sample" Font-Underline="True"></dx:ASPxLabel>
                    </td>
                </tr>
            </table>
        </div>
             
        <div class="child" id="division" runat="server">
            <table >
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Export To: "></dx:ASPxLabel>
                        </td>
                        <td>
                            <br />
                        </td>
                        <td>
                            <asp:DropDownList ID="cbExport" runat="server">
                                <asp:ListItem>Portable Document Format (.pdf)</asp:ListItem>
                                <asp:ListItem>Rich Text Format (.rtf)</asp:ListItem>
                                
                                <asp:ListItem>Comma-Separated Values (.csv)</asp:ListItem>
                                <asp:ListItem>Microsoft Excel 97 to 2003 (.xls)</asp:ListItem>
                                <asp:ListItem>Microsoft Excel 2007 to 2010 (.xlsx)</asp:ListItem>
                                
                            </asp:DropDownList>
                        </td>
                        <td>
                            <br />
                        </td>
                        <td>
                            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export" Width="158px" AutoPostBack="False">
                                <ClientSideEvents Click="function(s, e) { Callback.PerformCallback(); LoadingPanel.Show(); }" />
                               
                               
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <br />
                        </td>
                       <td>
                            <dx:ASPxButton ID="btnBack" runat="server" Text="Back" style="margin-bottom:10px; margin-top:10px;" Height="19px" Width="158px"></dx:ASPxButton>
                            
                       </td>
                        <td>
                            <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="Callback">
                                <ClientSideEvents CallbackComplete="function(s, e) { LoadingPanel.Hide(); }" />
                            </dx:ASPxCallback>
                        </td>   
                    </tr>

            </table>
            <CR:CrystalReportViewer ID="rViewer" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" HasCrystalLogo="False" HasDrilldownTabs="False" HasDrillUpButton="False" HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" Height="800px" PrintMode="ActiveX" ToolPanelView="None" Width="100%" EnableDrillDown="False" EnableTheming="False" EnableToolTips="False" BorderWidth="10px" PageZoomFactor="50" BestFitPage="False" HasSearchButton="False" HasExportButton="False" />
        </div>
    </div>
    <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True"></dx:ASPxLoadingPanel>
    </form>
</body>
</html>
