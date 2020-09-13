<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="tasks.aspx.vb" Inherits="SmartHR.tasks" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
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
        <form id="_tasks" runat="server">
            <dxpc:ASPxPopupControl ID="pcDetails" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcDetails" HeaderText="Details" HeaderStyle-Font-Bold="true">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <table cellpadding="0" style="min-width: 350px; text-align: left">
                            <tr>
                                <td style="text-align: center">
                                    <dxe:ASPxLabel ID="lblHtml" runat="server" ClientInstanceName="lblHtml" />
                                </td>
                            </tr>
                            <tr>
                                <td><br /></td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdOK" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { pcDetails.Hide(); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabTasks" runat="server" Width="100%">
                    <ClientSideEvents Init="function(s, e) { if (window.parent.hPanel.Contains('CreateEmployee')) { window.parent.hPanel.Remove('CreateEmployee'); } }" />
                    <TabPages>
                        <dxtc:TabPage Text="Results">
                            <TabImage Url="images/performance_008.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                    <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False" >
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
                                            <dxwgv:GridViewDataTextColumn FieldName="Count" Caption="# of Tasks" VisibleIndex="10">
                                                <CellStyle HorizontalAlign="Center" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Created" Caption="Days Since Task Created" VisibleIndex="11">
                                                <CellStyle HorizontalAlign="Center" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Actioned" Caption="Days Since Task Actioned" VisibleIndex="12">
                                                <CellStyle HorizontalAlign="Center" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="AveDays" Caption="Avg Days Since Actioned" VisibleIndex="13">
                                                <CellStyle HorizontalAlign="Center" />
                                            </dxwgv:GridViewDataTextColumn>
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
                        <dxtc:TabPage Text="Inbox">
                            <TabImage Url="images/tasks_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <div style="text-align: right">
                                        <dxe:ASPxHyperLink ID="hlRoute" runat="server" Text="route maintenance..." Cursor="pointer" Font-Underline="false" NavigateUrl="routing.aspx" />
                                    </div>
                                    <br />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="CompositeKey" Caption="Task #" SortIndex="0" SortOrder="Descending" VisibleIndex="1" Width="64px">
                                                <PropertiesSpinEdit DisplayFormatString="g" NumberFormat="Custom" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Originator" Caption="Employee" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="XMLTag" Caption="Summary" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="ActionDate" Caption="Last Activity" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PrevActioner" Caption="Previous Location" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="OriginatorCompanyNum" VisibleIndex="6" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="OriginatorEmployeeNum" VisibleIndex="7" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="AppStatus" VisibleIndex="8" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Summary" VisibleIndex="9" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="details" SelectButton-Text="View Details" VisibleIndex="10" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="details_001" Image-Url="images/info.png" Text="View Details" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.lpPage.Show(); s.PerformCallback('details\ ' + e.visibleIndex.toString()); }" EndCallback="function(s, e) { if (s.cpShowDetails) { window.parent.lpPage.Hide(); lblHtml.SetValue(s.cpHtmlText); pcDetails.AdjustSize(); pcDetails.Show(); } else { if (s.cpURL.length != 0 && s.cpToolURL.length != 0) { window.parent.postUrl(s.cpURL + '\ ' + s.cpToolURL, false); } } }" SelectionChanged="function(s, e) { if (e.isSelected) { window.parent.lpPage.Show(); s.PerformCallback(e.visibleIndex); } }" />
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
                        <dxtc:TabPage Text="Alternative">
                            <TabImage Url="images/tasks_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="CompositeKey" Caption="Task #" SortIndex="0" SortOrder="Descending" VisibleIndex="1" Width="64px">
                                                <PropertiesSpinEdit DisplayFormatString="g" NumberFormat="Custom" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Originator" Caption="Employee" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="XMLTag" Caption="Summary" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="ActionDate" Caption="Last Activity" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Actioner" Caption="Current Location" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PrevActioner" Caption="Previous Location" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="OriginatorCompanyNum" VisibleIndex="7" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="OriginatorEmployeeNum" VisibleIndex="8" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="AppStatus" VisibleIndex="9" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Summary" VisibleIndex="10" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="details" SelectButton-Text="View Details" VisibleIndex="11" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="details_002" Image-Url="images/info.png" Text="View Details" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.lpPage.Show(); s.PerformCallback('details\ ' + e.visibleIndex.toString()); }" EndCallback="function(s, e) { if (s.cpShowDetails) { window.parent.lpPage.Hide(); lblHtml.SetValue(s.cpHtmlText); pcDetails.AdjustSize(); pcDetails.Show(); } else { if (s.cpURL.length != 0 && s.cpToolURL.length != 0) { window.parent.postUrl(s.cpURL + '\ ' + s.cpToolURL, false); } } }" SelectionChanged="function(s, e) { if (e.isSelected) { window.parent.lpPage.Show(); s.PerformCallback(e.visibleIndex); } }" />
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
                        <dxtc:TabPage Text="Pending">
                            <TabImage Url="images/tasks_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px" Visible="false">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="CompositeKey" Caption="Task #" SortIndex="0" SortOrder="Descending" VisibleIndex="1" Width="64px">
                                                <PropertiesSpinEdit DisplayFormatString="g" NumberFormat="Custom" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="XMLTag" Caption="Summary" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="ActionDate" Caption="Last Activity" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Actioner" Caption="Current Location" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PrevActioner" Caption="Previous Location" VisibleIndex="5" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Summary" VisibleIndex="6" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="details" SelectButton-Text="View Details" VisibleIndex="7" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="details_003" Image-Url="images/info.png" Text="View Details" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.lpPage.Show(); s.PerformCallback('details\ ' + e.visibleIndex.toString()); }" EndCallback="function(s, e) { if (s.cpShowDetails) { window.parent.lpPage.Hide(); lblHtml.SetValue(s.cpHtmlText); pcDetails.AdjustSize(); pcDetails.Show(); } }" />
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Completed">
                            <TabImage Url="images/tasks_004.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="select" SelectButton-Text="Open Record" VisibleIndex="0" Width="16px" Visible="false">
                                                <SelectButton Visible="true">
                                                    <Image Url="images/select.png" />
                                                </SelectButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="CompositeKey" Caption="Task #" SortIndex="0" SortOrder="Descending" VisibleIndex="1" Width="64px">
                                                <PropertiesSpinEdit DisplayFormatString="g" NumberFormat="Custom" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="XMLTag" Caption="Summary" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="ActionDate" Caption="Last Activity" VisibleIndex="3" />
                                            <dxwgv:GridViewDataTextColumn FieldName="PrevActioner" Caption="Previous Location" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Summary" VisibleIndex="5" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="details" SelectButton-Text="View Details" VisibleIndex="6" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="details_004" Image-Url="images/info.png" Text="View Details" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.lpPage.Show(); s.PerformCallback('details\ ' + e.visibleIndex.toString()); }" EndCallback="function(s, e) { if (s.cpShowDetails) { window.parent.lpPage.Hide(); lblHtml.SetValue(s.cpHtmlText); pcDetails.AdjustSize(); pcDetails.Show(); } }" />
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
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    dgView_005.Refresh();
                                                                    break;
                                                                case 1:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                                case 4:
                                                                    dgView_004.Refresh();
                                                                    break;
                                                            };
                                                        }" EndCallback="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); }" Init="function(s, e) { s.GetTab(0).SetVisible(s.cpVisibleResults); }" />
                </dxtc:ASPxPageControl>
            </div>
        </form>
    </body>
</html>