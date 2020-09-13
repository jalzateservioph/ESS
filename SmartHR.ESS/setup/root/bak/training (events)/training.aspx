<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="training.aspx.vb" Inherits="SmartHR.training" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="training" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabTraining" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Bookings">
                            <TabImage Url="images/tasks_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <asp:Table ID="tblApplication" runat="server" Width="100%">
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right" Width="125px">
                                                <dxe:ASPxLabel ID="lblEventID" runat="server" Text="Course" />
                                            </asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell>
                                                <dxe:ASPxComboBox ID="cmbEventID" runat="server" ClientInstanceName="cmbEventID" DataSourceID="dsEventLU" TextField="CourseName" ValueField="CourseName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { cmbEventDate.PerformCallback(s.GetValue().toString()); }" />
                                                </dxe:ASPxComboBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right" Width="125px">
                                                <dxe:ASPxLabel ID="lblEventDates" runat="server" Text="Available Events" />
                                            </asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell>
                                                <dxe:ASPxComboBox ID="cmbEventDate" runat="server" ClientInstanceName="cmbEventDate" DataSourceID="dsEventDateLU" TextField="EventDate" ValueField="Value" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3">
                                                <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="Value" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                                                            <HeaderTemplate>
                                                                <dxe:ASPxCheckBox ID="chkView_001" runat="server" ClientInstanceName="chkView_001" ToolTip="Select / Unselect all rows on the page">
                                                                    <ClientSideEvents CheckedChanged="function(s, e) { dgView_001.SelectAllRowsOnPage(s.GetChecked()); }" />
                                                                </dxe:ASPxCheckBox>
                                                            </HeaderTemplate>
                                                            <HeaderStyle Paddings-PaddingTop="1" Paddings-PaddingBottom="1" HorizontalAlign="Center" />
                                                        </dxwgv:GridViewCommandColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="3" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="4" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="6" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="7" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="8" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="9" />
                                                    </Columns>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                                    <SettingsPager AlwaysShowPager="true" PageSize="25" />
                                                    <Styles>
                                                        <AlternatingRow Enabled="true" />
                                                        <CommandColumn Spacing="8px" />
                                                        <CommandColumnItem Cursor="pointer" />
                                                        <Header HorizontalAlign="Center" />
                                                    </Styles>
                                                </dxwgv:ASPxGridView>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3">
                                                <div class="centered" style="width: 80px">
                                                    <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                                    </dxe:ASPxButton>
                                                </div>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Events (History)">
                            <TabImage Url="images/tasks_002.png" />
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
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Caption="Event ID" VisibleIndex="1" />
                                            <dxwgv:GridViewDataDateColumn FieldName="CourseName" Caption="Course" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="RefNum" Caption=" Reference" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="5" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateCreated" Caption="Created On" SortIndex="0" SortOrder="Descending" VisibleIndex="6" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="cancel" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="Cancel" Image-Url="images/stop.png" Text="Cancel Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
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
                        <dxtc:TabPage Text="Training (Plan)">
                            <TabImage Url="images/tasks_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                    <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                            <dxwgv:GridViewDataDateColumn FieldName="PlanNameNumber" Caption="Name" VisibleIndex="1" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Mentor" Caption="Mentor" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="EffectiveFrom" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="EffectiveTo" Caption="End Date" VisibleIndex="4" />
                                            <dxwgv:GridViewDataDateColumn FieldName="DateAgreed" Caption="Created On" VisibleIndex="5" />
                                        </Columns>
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
                                        <SettingsPager AlwaysShowPager="true" />
                                        <Styles>
                                            <AlternatingRow Enabled="true" />
                                            <CommandColumn Spacing="8px" />
                                            <CommandColumnItem Cursor="pointer" />
                                            <Header HorizontalAlign="Center" />
                                        </Styles>
                                        <Templates>
                                            <DetailRow>
                                                <dxwgv:ASPxGridViewExporter ID="dgExports_006" runat="server" GridViewID="dgView_006" />
                                                <dxwgv:ASPxGridView ID="dgView_006" runat="server" ClientInstanceName="dgView_006" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CourseName" Caption="Course" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CourseProgram" Caption="Program" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="EventNumber" Caption="Event #" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="DateAgreed" Caption="Created On" VisibleIndex="4" />
                                                    </Columns>
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
                                                                        <dxm:ASPxMenu ID="mnuExport_006" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                            <Items>
                                                                                <dxm:MenuItem Name="mnuExport_006" Text="Export to">
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
                                            </DetailRow>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 105px">
                                                            <dxm:ASPxMenu ID="mnuExport_005" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                <Items>
                                                                    <dxm:MenuItem Name="mnuExport_005" Text="Export to">
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
                        <dxtc:TabPage Text="Training">
                            <TabImage Url="images/tasks_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <asp:Table ID="tblTraining" runat="server" Width="100%">
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right" Width="75px">
                                                <dxe:ASPxLabel ID="lblTraining_001" runat="server" Text="To be done" />
                                            </asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell><hr /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3">
                                                <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                                <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="End Date" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    </Columns>
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
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3">
                                                <br />
                                                <br />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right">
                                                <dxe:ASPxLabel ID="lblTraining_002" runat="server" Text="Completed" />
                                            </asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell><hr /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="3">
                                                <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                                <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="End Date" VisibleIndex="4" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    </Columns>
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
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_005.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_003.Refresh();
                                                                    dgView_004.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsEventLU" runat="server" />
            <asp:SqlDataSource ID="dsEventDateLU" runat="server" />
        </form>
    </body>
</html>