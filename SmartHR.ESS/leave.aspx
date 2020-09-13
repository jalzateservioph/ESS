<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="leave.aspx.vb" Inherits="SmartHR.leave" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_leave" runat="server">
            <dxpc:ASPxPopupControl ID="pcBalances" runat="server" ClientInstanceName="pcBalances" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Balance Summary">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div class="centered" style="width: 500px">
                            <div style="font-weight: bold; text-align: left">
                                <dxe:ASPxLabel ID="lblDate" runat="server" ClientInstanceName="lblDate" EncodeHtml="false" />
                            </div>
                            <br />
                            <asp:Table ID="tblBalances_001" runat="server">
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>Leave Type</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Unit of Meassure</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Cycle Start</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Cycle End</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Period # (in this cycle)</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblLeaveType" runat="server" ClientInstanceName="lblLeaveType" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblUnitType" runat="server" ClientInstanceName="lblUnitType" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblCycleStart" runat="server" ClientInstanceName="lblCycleStart" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblCycleEnd" runat="server" ClientInstanceName="lblCycleEnd" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblCyclePeriod" runat="server" ClientInstanceName="lblCyclePeriod" EncodeHtml="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <br />
                            <div style="font-weight: bold; text-align: left">
                                <dxe:ASPxLabel ID="lblTotalBalance" runat="server" ClientInstanceName="lblTotalBalance" EncodeHtml="false" />
                            </div>
                            <br />
                            <div style="font-weight: bold; text-align: left">Summary (this cycle):</div>
                            <br />
                            <asp:Table ID="tblBalances_002" runat="server">
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>Remaining</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Taken</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Accrued</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblRemaining" runat="server" ClientInstanceName="lblRemaining" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblTaken" runat="server" ClientInstanceName="lblTaken" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblAccrued" runat="server" ClientInstanceName="lblAccrued" EncodeHtml="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <br />
                            <div style="font-weight: bold; text-align: left">Summary (total):</div>
                            <br />
                            <asp:Table ID="tblBalances_003" runat="server">
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>Accumulated</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>No. Risk</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Lose At</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Total Taken</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Future Taken</asp:TableCell>
                                    <asp:TableCell Width="10px" />
                                    <asp:TableCell>Total Lost</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Center">
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblAccumulated" runat="server" ClientInstanceName="lblAccumulated" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblNoRisk" runat="server" ClientInstanceName="lblNoRisk" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblLoseAt" runat="server" ClientInstanceName="lblLoseAt" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblTotalTaken" runat="server" ClientInstanceName="lblTotalTaken" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblFuture" runat="server" ClientInstanceName="lblFuture" EncodeHtml="false" />
                                    </asp:TableCell>
                                    <asp:TableCell />
                                    <asp:TableCell>
                                        <dxe:ASPxLabel ID="lblTotalLost" runat="server" ClientInstanceName="lblTotalLost" EncodeHtml="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dxe:ASPxButton ID="cmdBalances" runat="server" ClientInstanceName="cmdBalances" Text="OK" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcBalances.Hide(); }" />
                            </dxe:ASPxButton>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { cmdBalances.Focus(); }" />
                <HeaderStyle Font-Bold="true" />
            </dxpc:ASPxPopupControl>
            <dxpc:ASPxPopupControl ID="pcRemarks" runat="server" CloseAction="CloseButton" Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcRemarks" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <div class="centered" style="width: 350px">
                            <asp:Table ID="tblRemarks" runat="server" Width="350px">
                                <asp:TableRow>
                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                                        <dxe:ASPxMemo ID="txtRemarks" runat="server" ClientInstanceName="txtRemarks" Width="325px" Height="125px" ReadOnly="true" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                        <br />
                        <div class="centered" style="width: 80px">
                            <dxe:ASPxButton ID="cmdRemarks" runat="server" ClientInstanceName="cmdRemarks" Text="OK" Width="80px" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) { pcRemarks.Hide(); }" />
                            </dxe:ASPxButton>
                        </div>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents PopUp="function(s, e) { cmdRemarks.Focus(); }" />
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabLeave" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Results">
                            <TabImage Url="images/performance_008.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False" >
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="0" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="1" SortOrder="Ascending" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="2" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="3" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="4" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="5" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" Visible="False" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="7" Visible="False" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" Visible="False" VisibleIndex="8" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CellTel" Visible="False" VisibleIndex="9" />
                                            <dxwgv:GridViewBandColumn Name="Type1">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="LastTaken" Caption="Days Since Taken" VisibleIndex="10">
                                                        <CellStyle HorizontalAlign="Center" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Remaining" Caption="Remaining (this cycle)" VisibleIndex="11">
                                                        <CellStyle HorizontalAlign="Center" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Balance" Caption="Total Balance" VisibleIndex="12">
                                                        <CellStyle HorizontalAlign="Center" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                </Columns>
                                                <HeaderTemplate>
                                                    <dxe:ASPxComboBox ID="cmbType1" runat="server" ClientInstanceName="cmbType1" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsTypes" TextField="Type" ValueField="Type">
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_004.PerformCallback('1\ ' + s.GetValue()); }" />
                                                    </dxe:ASPxComboBox>
                                                </HeaderTemplate>
                                            </dxwgv:GridViewBandColumn>
                                            <dxwgv:GridViewBandColumn Name="Type2">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Taken" Caption="Taken (this cycle)" VisibleIndex="13">
                                                        <CellStyle HorizontalAlign="Center" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Applications" Caption="Applications (this cycle)" VisibleIndex="14">
                                                        <CellStyle HorizontalAlign="Center" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                </Columns>
                                                <HeaderTemplate>
                                                    <dxe:ASPxComboBox ID="cmbType2" runat="server" ClientInstanceName="cmbType2" Width="100%" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsTypes" TextField="Type" ValueField="Type">
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_004.PerformCallback('2\ ' + s.GetValue()); }" />
                                                    </dxe:ASPxComboBox>
                                                </HeaderTemplate>
                                            </dxwgv:GridViewBandColumn>
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsBehavior AutoExpandAllGroups="true" />
                                        <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                        <Styles>
                                            <AlternatingRow Enabled="True" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_004" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_004" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Application">
                            <TabImage Url="images/leave_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxcp:ASPxCallbackPanel ID="cpPage" runat="server" ClientInstanceName="cpPage" HideContentOnCallback="false" ShowLoadingPanel="false">
                                        <ClientSideEvents EndCallback="function(s, e) {
                                                                            lblDurationType.SetText(s.cpDurationType);
                                                                            window.parent.reset();
                                                                            if (s.cpShowPopup) {
                                                                                window.parent.ShowPopup(s.cpResultText);
                                                                            }
                                                                            if (s.cpURL.length != 0) { window.parent.postUrl(s.cpURL, false); }
                                                                        }" />
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
                                                <asp:Table ID="tblApplication" runat="server" Width="100%">
                                                    <asp:TableRow Font-Bold="true" HorizontalAlign="Center">
                                                        <asp:TableCell>Select your Start Date</asp:TableCell>
                                                        <asp:TableCell />
                                                        <asp:TableCell>Select your End date</asp:TableCell>
                                                    </asp:TableRow>
                                                    <asp:TableRow Height="5px">
                                                        <asp:TableCell ColumnSpan="3" />
                                                    </asp:TableRow>
                                                    <asp:TableRow HorizontalAlign="Center">
                                                        <asp:TableCell>
                                                            <dxe:ASPxCalendar ID="calFrom" runat="server" ClientInstanceName="calFrom">
                                                                <ClientSideEvents SelectionChanged="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Select'); }" VisibleMonthChanged="function(s, e) { if (s.GetVisibleDate() > calUntil.GetVisibleDate()) { calUntil.SetVisibleDate(s.GetVisibleDate()); } }" />
                                                            </dxe:ASPxCalendar>
                                                        </asp:TableCell>
                                                        <asp:TableCell>
                                                            <asp:Table ID="tblColorKeys" runat="server" Font-Bold="true" ForeColor="#ffffff" Width="150px">
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#1e90ff">New</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#5f9ea0">Pending</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#32cd32">Approved</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#dc143c">Declined</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#996600">Cancelled</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#696969">Public Holiday</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow ID="trBlocked" runat="server" HorizontalAlign="Center" Height="30px">
                                                                    <asp:TableCell BackColor="#a9a9a9">Blocked</asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell>
                                                        <asp:TableCell>
                                                            <dxe:ASPxCalendar ID="calUntil" runat="server" ClientInstanceName="calUntil">
                                                                <ClientSideEvents SelectionChanged="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Select'); }" VisibleMonthChanged="function(s, e) { if (s.GetVisibleDate() < calFrom.GetVisibleDate()) { calFrom.SetVisibleDate(s.GetVisibleDate()); } }" />
                                                            </dxe:ASPxCalendar>
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                    <asp:TableRow Height="5px">
                                                        <asp:TableCell ColumnSpan="3" />
                                                    </asp:TableRow>
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="3">
                                                            <asp:Table ID="tblApplicationType" runat="server" Width="100%">
                                                                <asp:TableRow>
                                                                    <asp:TableCell Font-Bold="true" HorizontalAlign="Right">Select your Leave Type</asp:TableCell>
                                                                    <asp:TableCell Width="10px" />
                                                                    <asp:TableCell HorizontalAlign="Left">
                                                                        <dxe:ASPxComboBox ID="cmbLeaveType" runat="server" ClientInstanceName="cmbLeaveType" Width="275px" EnableIncrementalFiltering="true" DropDownStyle="DropDownList" DataSourceID="dsLeaveType" TextField="LeaveType" ValueField="LeaveType">
                                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Select'); }" />
                                                                        </dxe:ASPxComboBox>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow Height="5px">
                                                                    <asp:TableCell ColumnSpan="3" />
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell Font-Bold="true" HorizontalAlign="Right">Duration</asp:TableCell>
                                                                    <asp:TableCell Width="10px" />
                                                                    <asp:TableCell HorizontalAlign="Left">
                                                                        <asp:Table ID="tblDuration" runat="server" CellPadding="0" CellSpacing="0">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell HorizontalAlign="Right">
                                                                                    <dxe:ASPxSpinEdit ID="spnDuration" runat="server" ClientInstanceName="spnDuration" Width="75px" Number="0" MinValue="0" MaxValue="365" NumberType="Float" DecimalPlaces="2" Increment="0.5">
                                                                                        <ClientSideEvents NumberChanged="function(s, e) { if (s.GetValue() == 0.25 || s.GetValue() == 0.5 || s.GetValue() == 0.75) { pnlTime.SetVisible(true); } else { pnlTime.SetVisible(false); } }" />
                                                                                    </dxe:ASPxSpinEdit>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell Width="10px" />
                                                                                <asp:TableCell HorizontalAlign="Left">
                                                                                    <dxe:ASPxLabel ID="lblDurationType" runat="server" ClientInstanceName="lblDurationType" />
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow Height="3px">
                                                                    <asp:TableCell ColumnSpan="3" />
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell ColumnSpan="2" />
                                                                    <asp:TableCell>
                                                                        <dxp:ASPxPanel ID="pnlTime" runat="server" ClientInstanceName="pnlTime">
                                                                            <PanelCollection>
                                                                                <dxp:PanelContent>
                                                                                    <asp:Table ID="tlbTime" runat="server" CellPadding="0" CellSpacing="0">
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell HorizontalAlign="Right">
                                                                                                <dxe:ASPxComboBox ID="cmbTime" runat="server" ClientInstanceName="cmbTime" DropDownStyle="DropDownList" Width="75px" SelectedIndex="1">
                                                                                                    <Items>
                                                                                                        <dxe:ListEditItem Text="AM" Value="0" />
                                                                                                        <dxe:ListEditItem Text="PM" Value="1" />
                                                                                                    </Items>
                                                                                                </dxe:ASPxComboBox>
                                                                                            </asp:TableCell>
                                                                                            <asp:TableCell Width="10px" />
                                                                                            <asp:TableCell HorizontalAlign="Left">
                                                                                                <dxe:ASPxLabel ID="lblTime" runat="server" ClientInstanceName="lblTime" Text="(select AM or PM)" />
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                    </asp:Table>
                                                                                </dxp:PanelContent>
                                                                            </PanelCollection>
                                                                            <ClientSideEvents Init="function(s, e) { if (spnDuration.GetValue() == 0.5) { s.SetVisible(true); } else { s.SetVisible(false); } }" />
                                                                        </dxp:ASPxPanel>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow Height="10px">
                                                                    <asp:TableCell ColumnSpan="3" />
                                                                </asp:TableRow>
                                                                <asp:TableRow ID="trDocument_001" runat="server">
                                                                    <asp:TableCell Font-Bold="true" HorizontalAlign="Right">* Attach a document</asp:TableCell>
                                                                    <asp:TableCell Width="10px" />
                                                                    <asp:TableCell HorizontalAlign="Left">
                                                                        <dxuc:ASPxUploadControl ID="upDocument" runat="server" ClientInstanceName="upDocument" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                            <ClientSideEvents FileUploadComplete="function(s, e) { cpPage.PerformCallback('Submit'); }" />
                                                                            <ValidationSettings MaxFileSize="4096000" />
                                                                        </dxuc:ASPxUploadControl>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow ID="trDocument_002" runat="server">
                                                                    <asp:TableCell ColumnSpan="2" />
                                                                    <asp:TableCell>
		                                                                <span>*</span>
		                                                                <dxe:ASPxLabel ID="lblDocument" runat="server" Text="Maximum file size 4MB" />
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                    <asp:TableRow Height="5px">
                                                        <asp:TableCell ColumnSpan="3" />
                                                    </asp:TableRow>
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="3">Comments (optional):</asp:TableCell>
                                                    </asp:TableRow>
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="3">
                                                            <dxe:ASPxMemo runat="server" ID="txtNotes" Rows="5" Width="100%" />
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                    <asp:TableRow Height="5px">
                                                        <asp:TableCell ColumnSpan="3" />
                                                    </asp:TableRow>
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="3">
                                                            <div class="centered" style="width: 80px">
                                                                <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false" />
                                                            </div>
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                </asp:Table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxcp:ASPxCallbackPanel>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Balances">
                            <TabImage Url="images/leave_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="width: 100%">
                                        <table style="padding: 0px; width: 100%">
                                            <tr>
                                                <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblBalances" runat="server" Text="View balances as at" /></td>
                                                <td style="width: 10px"></td>
                                                <td style="width: 250px; text-align: left">
                                                    <dxe:ASPxDateEdit ID="dtBalances" runat="server" ClientInstanceName="dtBalances">
                                                        <ClientSideEvents DateChanged="function(s, e) { dgView_001.Refresh(); }" />
                                                    </dxe:ASPxDateEdit>
                                                </td>
                                                <td />
                                            </tr>
                                        </table>
                                    </div>
                                    <div><br /></div>
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="LeaveType" Caption="Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="UnitType" Caption="Unit Type" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="CalcDate" Caption="As At" VisibleIndex="4" Visible="false" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="TotalBalance" Caption="Total Balance" VisibleIndex="8" HeaderStyle-Font-Bold="true" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Balance" Caption="Remaining (this cycle)" VisibleIndex="10" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="AccumBalance" Caption="Accumulated Balance" VisibleIndex="5" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="TotalAccrual" Caption="Current Year Entitlement" VisibleIndex="6" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="TotalTaken" Caption="Total Taken (this year)" VisibleIndex="7" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="TotalFuture" Caption="Future Taken" VisibleIndex="9" />
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="AtRisk" Caption="No. Risk" VisibleIndex="11" />
                                            <dxwgv:GridViewDataDateColumn FieldName="NextLostDate" Caption="Lose At" VisibleIndex="12" />
                                        </Columns>
                                        <ClientSideEvents EndCallback="function(s, e) {
                                                                            if (s.cpIsSelected) {
                                                                                s.cpIsSelected = false;
                                                                                window.parent.reset();
                                                                                lblDate.SetText('Balance Summary as at \'' + s.cpDate + '\':');
                                                                                lblLeaveType.SetText(s.cpLeaveType);
                                                                                lblUnitType.SetText(s.cpUnitOfMeassure);
                                                                                lblCycleStart.SetText(s.cpCycleStart);
                                                                                lblCycleEnd.SetText(s.cpCycleEnd);
                                                                                lblCyclePeriod.SetText(s.cpCyclePeriod);
                                                                                lblTotalBalance.SetText('* You can apply for ' + s.cpTotalBalance + ' ' + s.cpUnitOfMeassure + ' (within this cycle)');
                                                                                lblRemaining.SetText(s.cpRemaining);
                                                                                lblTaken.SetText(s.cpTaken);
                                                                                lblAccrued.SetText(s.cpAccrued);
                                                                                lblAccumulated.SetText(s.cpAccumulated);
                                                                                lblNoRisk.SetText(s.cpNoRisk);
                                                                                lblLoseAt.SetText(s.cpLoseAt);
                                                                                lblTotalTaken.SetText(s.cpTotalTaken);
                                                                                lblFuture.SetText(s.cpFuture);
                                                                                lblTotalLost.SetText(s.cpTotalLost);
                                                                                pcBalances.Show();
                                                                            }
                                                                        }" SelectionChanged="function(s, e) { if (e.isSelected) { window.parent.lpPage.Show(); dgView_001.PerformCallback(e.visibleIndex); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="True" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_001" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_001" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="History">
                            <TabImage Url="images/leave_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="LeaveType" Caption="Unit Type" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="End Date" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Duration" Caption="Duration" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="LeaveStatus" Caption="Status" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CapturedByUsername" Caption="Captured By" VisibleIndex="7" />
                                            <dxwgv:GridViewDataDateColumn FieldName="CaptureDate" Caption="Captured On" VisibleIndex="8" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Remarks" Visible="false" VisibleIndex="9" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PathID" Visible="false" VisibleIndex="10" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="cancel" VisibleIndex="11" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Cancel" Image-Url="images/stop.png" Text="Cancel Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents EndCallback="function(s, e) {
                                                                            if (s.cpIsSelected) {
                                                                                s.cpIsSelected = false;
                                                                                window.parent.reset();
                                                                                txtRemarks.SetText(s.cpRemarks);
                                                                                pcRemarks.Show();
                                                                            }
                                                                            if (s.cpURL.length != 0) { window.parent.postUrl(s.cpURL, false); }
                                                                        }" CustomButtonClick="function(s, e) { e.processOnServer = true; if (e.buttonID == 'Cancel') { if (!confirm('Confirm Cancel?')) { e.processOnServer = false; } else { e.processOnServer = true; } } }" SelectionChanged="function(s, e) { if (e.isSelected) { window.parent.lpPage.Show(); dgView_002.PerformCallback(e.visibleIndex); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsPager AlwaysShowPager="true" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_002" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_002" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Blocked">
                            <TabImage Url="images/leave_005.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="BlockFrom" Caption="From" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="BlockUntil" Caption="Until" VisibleIndex="3" />
                                            <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" VisibleIndex="5" Visible="false" />
                                            <dxwgv:GridViewDataDateColumn FieldName="CapturedOn" VisibleIndex="6" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
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
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_003" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_003" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_003" runat="server" ClientInstanceName="cmdCreate_003" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_003.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_003" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_003" Text="Export to">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExp_CSV" Text="Comma-Seperated Values (CSV)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLS" Text="Microsoft Excel 97 to 2003 (XLS)" />
                                                                            <dxm:MenuItem Name="mnuExp_XLSX" Text="Microsoft Excel 2007 to 2010 (XLSX)" />
                                                                            <dxm:MenuItem Name="mnuExp_RTF" Text="Rich Text Format (RTF)" />
                                                                            <dxm:MenuItem Name="mnuExp_PDF" Text="Portable Document Format (PDF)" />
                                                                        </Items>
                                                                        <SubMenuStyle Cursor="pointer" />
                                                                    </dxm:MenuItem>
                                                                </Items>
                                                            </dxm:ASPxMenu>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_004.Refresh();
                                                                    break;
                                                                case 1:
                                                                    break;
                                                                case 2:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 4:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" EndCallback="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); s.GetTab(4).SetVisible(s.cpVisible); }" Init="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); s.GetTab(4).SetVisible(s.cpVisible); }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsLeaveType" runat="server" />
            <asp:SqlDataSource ID="dsTypes" runat="server" />
        </form>
    </body>
</html>