<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="training.aspx.vb" Inherits="SmartHR.training" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="scripts/jquery-1.4.2-vsdoc.js"></script>
    <script src="scripts/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <script src="scripts/main.js" type="text/javascript"></script>
    <title>SmartHR (Employee Self Service)</title>
    <style type="text/css">
        .auto-style3 {
            width: 2%;
        }

        .dxrpTE {
            width: 100%;
        }

        /*input:read-only { 
            color:#A6A6A6 
            !important; 
        }*/
    </style>
</head>
<body onload="window.parent.reset();">
    <form id="_training" runat="server">
        <dxpc:ASPxPopupControl ID="pcDetails" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcDetails" HeaderText="Training Schedules" HeaderStyle-Font-Bold="true">
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
        <asp:scriptmanager id="sm" runat="server" enablepartialrendering="true" scriptmode="release" enablepagemethods="true"></asp:scriptmanager>
        <div class="padding">
            <dxtc:ASPxPageControl ID="tabTraining" runat="server" Width="100%" ActiveTabIndex="6">
                <TabPages>
                    <dxtc:TabPage Text="Training Curriculum">
                        <TabImage Url="images/training_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <a id="expandAll" href="#">Expand All</a>
                                &nbsp;
                                    <a id="collapseAll" href="#">Collapse All</a>
                                <br />
                                <br />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_006" runat="server" GridViewID="dgView_006" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_007" runat="server" GridViewID="dgView_007" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_008" runat="server" GridViewID="dgView_008" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_009" runat="server" GridViewID="dgView_009" />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_003" runat="server" ClientInstanceName="pnlTraining_003" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_006" runat="server" ClientInstanceName="dgView_006" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="DateRegistered" Caption="Date Registered" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" Caption="Remarks" VisibleIndex="7" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Evaluated" Caption="Evaluated?" VisibleIndex="8" />
                                                </Columns>
                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                <SettingsPager AlwaysShowPager="True" />
                                                <Styles>
                                                    <AlternatingRow Enabled="true" />
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_003" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_003" runat="server" Text="Training Curriculum" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_004" runat="server" ClientInstanceName="pnlTraining_004" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_007" runat="server" ClientInstanceName="dgView_007" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="DateRegistered" Caption="Date Registered" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" Caption="Remarks" VisibleIndex="7" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Evaluated" Caption="Evaluated?" VisibleIndex="8" />
                                                </Columns>
                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                <SettingsPager AlwaysShowPager="True" />
                                                <Styles>
                                                    <AlternatingRow Enabled="true" />
                                                    <Header HorizontalAlign="Center" />
                                                </Styles>
                                                <Templates>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_007" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_007" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="Local Trainings" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_005" runat="server" ClientInstanceName="pnlTraining_005" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_008" runat="server" ClientInstanceName="dgView_008" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgView_008_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_008_StartRowEditing"
                                                OnRowValidating="dgView_008_RowValidating"
                                                OnRowInserting="dgView_008_RowInserting"
                                                OnRowUpdating="dgView_008_RowUpdating"
                                                OnRowDeleting="dgView_008_RowDeleting">
                                                <Columns>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" UpdateButton-Text="Submit Record" VisibleIndex="0" Width="16px" Visible="true">
                                                        <EditButton Visible="True">
                                                            <Image Url="images/select.png" />
                                                        </EditButton>
                                                        <CancelButton Visible="True">
                                                            <Image Url="images/cancel.png" />
                                                        </CancelButton>
                                                        <UpdateButton Visible="True">
                                                            <Image Url="images/submit.png" />
                                                        </UpdateButton>
                                                    </dxwgv:GridViewCommandColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="DateRegistered" Caption="Date Registered" SortIndex="0" SortOrder="Descending" VisibleIndex="2">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="3">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" Caption="Remarks" VisibleIndex="7">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Evaluated" Caption="Evaluated?" VisibleIndex="8">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="PathID" Caption="PathID" VisibleIndex="9" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Type" Caption="Type" VisibleIndex="10" Visible="false" />
                                                </Columns>
                                                <ClientSideEvents EndCallback="
                                                    function(s, e) { 
                                                        if (s.cpCancelEdit) { 
                                                            s.Refresh(); 
                                                            dgView_008.Refresh(); 
                                                        } 
                                                    }" />
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
                                                            <dxtc:ASPxPageControl ID="pageControl_008" runat="server" Width="100%">
                                                                <TabPages>
                                                                    <dxtc:TabPage Text="Contract Details" Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <table style="width: 100%">
                                                                                    <colgroup>
                                                                                        <col width="230px" />
                                                                                        <col width="10px" />
                                                                                        <col />
                                                                                        <col width="35%" />
                                                                                    </colgroup>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblProgramTitle_008" runat="server" Text="Program Title" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtProgramTitle_008" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblType_008" runat="server" Text="Type" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <%--<dxe:ASPxComboBox ID="cbCourse" runat="server" DataSourceID="dsCourseLU_Overseas" TextField="CourseName" ValueField="CourseName" ValueType="System.String" Width="100%">
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008_009_cbCourse_SelectedIndexChanged(s, e, 'dgView_009'); }" />
                                                                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                                </ValidationSettings>
                                                                                            </dxe:ASPxComboBox>--%>
                                                                                            <dxe:ASPxComboBox ID="cmbType_008" runat="server" DataSourceID="dsTAFType" TextField="Type" ValueField="Type" ValueType="System.String" Width="100%" >
                                                                                                <%--<ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008.PerformCallback(s.GetValue()); }" />--%>
                                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008.PerformCallback('<ID=cmbType_008><Value=' + s.GetValue() + '>'); }" />
                                                                                                <Items>
                                                                                                    <dxe:ListEditItem Text="Functional Training Program" Value="Functional Training Program" />
                                                                                                    <dxe:ListEditItem Text="Specialized Development Programs" Value="Specialized Development Program" />
                                                                                                </Items>
                                                                                            </dxe:ASPxComboBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblProgramType_008" runat="server" Text="Program Type" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxComboBox ID="cmbProgramType_008" runat="server" DataSourceID="dsTCProgType" TextField="ProgramType" ValueField="ProgramType" ValueType="System.String" Width="100%">
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008.PerformCallback('<ID=cmbProgramType_008><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxComboBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblInvestment_008" runat="server" Text="Investment (Training Fee + Per Diem)" />
                                                                                            <%--<span style="color: red" runat="server" id="lblInvestment_008_required" clientidmode="Static">*</span>--%>
                                                                                            <dxe:ASPxLabel id="lblInvestment_008_required" runat="server" ClientIDMode="Static" ForeColor="Red" Text="*" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtInvestment_008" runat="server" MaxLength="255" Width="100%">
                                                                                                <ClientSideEvents LostFocus="function(s, e) { dgView_008.PerformCallback('<ID=txtInvestment_008><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxTextBox>
                                                                                            <asp:HiddenField ID="hfInvestment_008" runat="server" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblCostUSD_008" runat="server" Text="Training Cost (USD)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtCostUSD_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblProvider_008" runat="server" Text="Provider" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtProvider_008" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblVenue_008" runat="server" Text="Venue" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtVenue_008" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblDateFrom_008" runat="server" Text="Date From" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteDateFrom_008" runat="server" Width="100%" EditFormat="DateTime">
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblDateTo_008" runat="server" Text="Date To" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteDateTo_008" runat="server" Width="100%" EditFormat="DateTime">
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExistingStart_008" runat="server" Text="Existing/Start" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteExistingStart_008" runat="server" Width="100%" EditFormat="Date">
                                                                                                <ClientSideEvents DateChanged="function(s, e) { dgView_008.PerformCallback('<ID=dteExistingStart_008><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblDuration_008" runat="server" Text="Duration (years)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtDuration_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExpiry_008" runat="server" Text="Expiry" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtExpiry_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExpiryEndDate_008" runat="server" Text="No. of days between last day of Training and Contract expiration" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtExpiryEndDate_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExpirySystemDate_008" runat="server" Text="No. of days between date today and Contract expiration" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtExpirySystemDate_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblContractCompletion_008" runat="server" Text="Contract Completion (%)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtContractCompletion_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblContractStatus_008" runat="server" Text="Contract Status" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtContractStatus_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblTrainingStatus_008" runat="server" Text="Training Status" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxComboBox ID="cmbTrainingStatus_008" runat="server" Width="100%" >
                                                                                                <Items>
                                                                                                    <dxe:ListEditItem Value="Approved" Text="Approved" Selected="true" />
                                                                                                </Items>
                                                                                            </dxe:ASPxComboBox>
                                                                                            <asp:HiddenField ID="hfTrainingStatus_008" runat="server" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <br />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-weight: bold;" colspan="4">
                                                                                            <dxe:ASPxLabel Font-Size="14px" ID="lblResignationInfor_008" runat="server" Text="Resignation Information" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblSeparationDate_008" runat="server" Text="Separation Date" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteSeparationDate_008" runat="server" Width="100%" EditFormat="Date" >
                                                                                                <ClientSideEvents DateChanged="function(s, e) { dgView_008.PerformCallback('<ID=dteSeparationDate_008><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExpirySeparationDate_008" runat="server" Text="No. of days between Separation and Contract expiration" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtExpirySeparationDate_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblMonthsUnserved_008" runat="server" Text="Months Unserved" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtMonthsUnserved_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblUnservedContract_008" runat="server" Text="Unserved Contract Completion (%)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtUnservedContract_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblPenalty_008" runat="server" Text="Penalty" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtPenalty_008" runat="server" MaxLength="255" Width="100%" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <br />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr style="display: none">
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblPathID_008" runat="server" Text="PathID" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtPathID_008" runat="server" MaxLength="255" Width="100%" >
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr style="display: none">
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblTAFID_008" runat="server" Text="TAF ID" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtTAFID_008" runat="server" MaxLength="255" Width="100%" >
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr style="display: none">
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblRemainingBudget_008" runat="server" Text="Remaining Budget" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtRemainingBudget_008" runat="server" MaxLength="255" Width="100%" >
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Training Budget Details"  Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <div style="width: 100%">
                                                                                    <table style="padding: 0px; width: 100%">
                                                                                        <colgroup>
                                                                                            <col width="230px" />
                                                                                            <col width="10px" />
                                                                                            <col />
                                                                                            <col width="35%" />
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblDateReceived_008" runat="server" Text="Date Received" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxDateEdit ID="dteDateReceived_008" runat="server" Width="100%" EditFormat="Date">
                                                                                                </dxe:ASPxDateEdit>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblBudgetCategory_008" runat="server" Text="External Training Budget Category" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxComboBox ID="cmbBudgetCategory_008" runat="server" Width="100%">
                                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008.PerformCallback('<ID=cmbBudgetCategory_008><Value=' + s.GetValue() + '>'); }" />
                                                                                                </dxe:ASPxComboBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblBudgetCode_008" runat="server" Text="Budget Code" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtBudgetCode_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblRFPNum_008" runat="server" Text="RFP No." />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtRFPNum_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblSAPDocNum_008" runat="server" Text="SAP Doc No." />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>f
                                                                                                <dxe:ASPxTextBox ID="txtSAPDocNum_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblDivision_008" runat="server" Text="Division" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtDivision_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblDepartment_008" runat="server" Text="Department" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtDepartment_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblSection_008" runat="server" Text="Section" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtSection_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblLevel_008" runat="server" Text="Level" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtLevel_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblDesignation_008" runat="server" Text="Designation" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtDesignation_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblSubCategory_008" runat="server" Text="Sub Category" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtSubCategory_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblLateRegistration_008" runat="server" Text="Late Registration" />
                                                                                                <span style="color: red">*</span>
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxComboBox ID="cmbLateRegistration_008" runat="server" Width="100%">
                                                                                                    <Items>
                                                                                                        <dxe:ListEditItem Text="Yes" Value="Yes" />
                                                                                                        <dxe:ListEditItem Text="No" Value="No" />
                                                                                                    </Items>
                                                                                                </dxe:ASPxComboBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Post Training Info."  Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <div style="width: 100%">
                                                                                    <table style="padding: 0px; width: 100%">
                                                                                        <colgroup>
                                                                                            <col width="230px" />
                                                                                            <col width="10px" />
                                                                                            <col />
                                                                                            <col width="50%" />
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblCertificate_008" runat="server" Text="Copy of Certificate" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxComboBox ID="cmbCertificate_008" runat="server" Width="100%">
                                                                                                    <Items>
                                                                                                        <dxe:ListEditItem Text="Yes" Value="Yes" />
                                                                                                        <dxe:ListEditItem Text="No" Value="No" />
                                                                                                    </Items>
                                                                                                </dxe:ASPxComboBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblTrainingMaterial_008" runat="server" Text="Copy of Training Material" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxComboBox ID="cmbTrainingMaterial_008" runat="server" Width="100%">
                                                                                                    <Items>
                                                                                                        <dxe:ListEditItem Text="Yes" Value="Yes" />
                                                                                                        <dxe:ListEditItem Text="No" Value="No" />
                                                                                                    </Items>
                                                                                                </dxe:ASPxComboBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblPlannedEcho_008" runat="server" Text="Echo Session (Planned)" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtPlannedEcho_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblActualEcho_008" runat="server" Text="Echo Session (Actual)" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtActualEcho_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblPlannedPaxEcho_008" runat="server" Text="# of Pax Echo Session (Planned)" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtPlannedPaxEcho_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblActualPaxEcho_008" runat="server" Text="# of Pax Echo Session (Actual)" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtActualPaxEcho_008" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                </TabPages>
                                                            </dxtc:ASPxPageControl>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 80px">
                                                                    <dxe:ASPxButton OnLoad="cmdCreate_008_Load" ID="cmdCreate_008" runat="server" ClientInstanceName="cmdCreate_008" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_008.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_008" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_008" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_005" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_005" runat="server" Text="External Trainings" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_006" runat="server" ClientInstanceName="pnlTraining_006" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_009" runat="server" ClientInstanceName="dgView_009" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="true"
                                                OnHtmlEditFormCreated="dgView_009_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_009_StartRowEditing"
                                                OnRowValidating="dgView_009_RowValidating"
                                                OnRowInserting="dgView_009_RowInserting"
                                                OnRowUpdating="dgView_009_RowUpdating"
                                                OnRowDeleting="dgView_009_RowDeleting">
                                                <Columns>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" UpdateButton-Text="Submit Record" VisibleIndex="0" Width="16px" Visible="True">
                                                        <EditButton Visible="True">
                                                            <Image Url="images/edit.png" />
                                                        </EditButton>
                                                        <CancelButton Visible="True">
                                                            <Image Url="images/cancel.png" />
                                                        </CancelButton>
                                                        <UpdateButton Visible="True">
                                                            <Image Url="images/submit.png" />
                                                        </UpdateButton>
                                                    </dxwgv:GridViewCommandColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="DateRegistered" Caption="Date Registered" SortIndex="0" SortOrder="Descending" VisibleIndex="2">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="3">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Remarks" Caption="Remarks" VisibleIndex="7">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="Evaluated" Caption="Evaluated?" VisibleIndex="8">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="PathID" Caption="PathID" VisibleIndex="9" Visible="false" />
                                                </Columns>
                                                <ClientSideEvents EndCallback="
                                                    function(s, e) { 
                                                        if (s.cpCancelEdit) { 
                                                            s.Refresh();
                                                            dgView_009.Refresh(); 
                                                        } 
                                                    }" />
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
                                                            <dxtc:ASPxPageControl ID="pageControl_009" runat="server" Width="100%">
                                                                <TabPages>
                                                                    <dxtc:TabPage Text="ICT Assignment Information" Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <table style="width: 100%">
                                                                                    <colgroup>
                                                                                        <col width="230px" />
                                                                                        <col width="10px" />
                                                                                        <col />
                                                                                        <col width="50%" />
                                                                                    </colgroup>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblCourse_009" runat="server" Text="Course Name" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxComboBox ID="cmbCourse_009" runat="server" Width="100%" >
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_009.PerformCallback('<ID=cmbCourse_009><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxComboBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblProvider_009" runat="server" Text="Provider Name" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtProvider_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblVenue_009" runat="server" Text="Venue Name" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtVenue_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblType_009" runat="server" Text="ICT Type" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxComboBox ID="cmbType_009" runat="server" Width="100%" >
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_009.PerformCallback('<ID=cmbType_009><Value=' + s.GetValue() + '>'); }" />
                                                                                                <Items>
                                                                                                    <dxe:ListEditItem Text="Local" Value="Local" />
                                                                                                    <dxe:ListEditItem Text="Foreign" Value="Foreign" />
                                                                                                </Items>
                                                                                            </dxe:ASPxComboBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblCategory_009" runat="server" Text="ICT Category" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxComboBox ID="cmbCategory_009" runat="server" Width="100%" >
                                                                                                <Items>
                                                                                                    <dxe:ListEditItem Text="A - Associated Professional - 100% Host" Value="A - Associated Professional - 100% Host" />
                                                                                                    <dxe:ListEditItem Text="B - Business Transferee - 100% Host" Value="B - Business Transferee - 100% Host" />
                                                                                                    <dxe:ListEditItem Text="C - Cooperation Transferee - 50% Host & 50% Home" Value="C - Cooperation Transferee - 50% Host & 50% Home" />
                                                                                                    <dxe:ListEditItem Text="D - Development Transferee - 100% Home" Value="D - Development Transferee - 100% Home" />
                                                                                                </Items>
                                                                                            </dxe:ASPxComboBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblSOA_009" runat="server" Text="Start of Assignment" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteSOA_009" runat="server" Width="100%" EditFormat="Date" >
                                                                                                <ClientSideEvents DateChanged="function(s, e) { dgView_009.PerformCallback('<ID=dteSOA_009><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblExtension_009" runat="server" Text="Extension (Months)" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtExtension_009" runat="server" MaxLength="2" Width="100%">
                                                                                                <ClientSideEvents TextChanged="function(s, e) { dgView_009.PerformCallback('<ID=txtExtension_009><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblPlannedEOA_009" runat="server" Text="End of Assignment (Planned)" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dtePlannedEOA_009" runat="server" Width="100%" EditFormat="Date" >
                                                                                                <ClientSideEvents DateChanged="function(s, e) { dgView_009.PerformCallback('<ID=dtePlannedEOA_009><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblActualEOA_009" runat="server" Text="End of Assignment (Actual)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxDateEdit ID="dteActualEOA_009" runat="server" Width="100%" EditFormat="Date" >
                                                                                                <ClientSideEvents DateChanged="function(s, e) { dgView_009.PerformCallback('<ID=dteActualEOA_009><Value=' + s.GetValue() + '>'); }" />
                                                                                            </dxe:ASPxDateEdit>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblPlannedDuration_009" runat="server" Text="Duration of ICT Assignment (Planned)" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtPlannedDuration_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblActualDuration_009" runat="server" Text="Duration of ICT Assignment (Actual)" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtActualDuration_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblActive_009" runat="server" Text="Active" />
                                                                                            <span style="color: red">*</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtActive_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblLocation_009" runat="server" Text="Location" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtLocation_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHomeCompany_009" runat="server" Text="Home Company" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHomeCompany_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHomeDivision_009" runat="server" Text="Home Division" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHomeDivision_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHomeDepartment_009" runat="server" Text="Home Department" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHomeDepartment_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHomeSection_009" runat="server" Text="Home Section" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHomeSection_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHostCompany_009" runat="server" Text="Host Company" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHostCompany_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHostDivision_009" runat="server" Text="Host Division" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHostDivision_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHostDepartment_009" runat="server" Text="Host Department" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHostDepartment_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dxe:ASPxLabel ID="lblHostSection_009" runat="server" Text="Host Section" />
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <dxe:ASPxTextBox ID="txtHostSection_009" runat="server" MaxLength="255" Width="100%">
                                                                                            </dxe:ASPxTextBox>
                                                                                        </td>
                                                                                        <td></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Repatriation Info."  Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <div style="width: 100%">
                                                                                    <table style="padding: 0px; width: 100%">
                                                                                        <colgroup>
                                                                                            <col width="230px" />
                                                                                            <col width="10px" />
                                                                                            <col />
                                                                                            <col width="50%" />
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblFirstWD_009" runat="server" Text="First Work. Day at Home Company" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxDateEdit ID="dteFirstWD_009" runat="server" Width="100%" EditFormat="Date">
                                                                                                </dxe:ASPxDateEdit>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblLastWD_009" runat="server" Text="Last Work. Day at Host Company" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxDateEdit ID="dteLastWD_009" runat="server" Width="100%" EditFormat="Date">
                                                                                                </dxe:ASPxDateEdit>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="ICT Contact Info."  Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <div style="width: 100%">
                                                                                    <table style="padding: 0px; width: 100%">
                                                                                        <colgroup>
                                                                                            <col width="230px" />
                                                                                            <col width="10px" />
                                                                                            <col />
                                                                                            <col width="50%" />
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHomeContactHC_009" runat="server" Text="Contact Number at Home Company" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHomeContactHC_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHomeContactRes_009" runat="server" Text="Contact Number at Residence" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHomeContactRes_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHomeAddress_009" runat="server" Text="Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHomeAddress_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHomePEmail_009" runat="server" Text="Work Email Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHomePEmail_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHomeAEmail_009" runat="server" Text="Alternate/Personal Email Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHomeAEmail_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHostContactHC_009" runat="server" Text="Contact Number at Host Company" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHostContactHC_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHostContactRes_009" runat="server" Text="Contact Number at Residence" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHostContactRes_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHostAddress_009" runat="server" Text="Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHostAddress_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHostPEmail_009" runat="server" Text="Work Email Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHostPEmail_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblHostAEmail_009" runat="server" Text="Alternate/Personal Email Address" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtHostAEmail_009" runat="server" MaxLength="255" Width="100%" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                    <dxtc:TabPage Text="Service Contract Info."  Visible="true">
                                                                        <ContentCollection>
                                                                            <dxw:ContentControl runat="server">
                                                                                <div style="width: 100%">
                                                                                    <table style="width: 100%">
                                                                                        <colgroup>
                                                                                            <col width="230px" />
                                                                                            <col width="10px" />
                                                                                            <col />
                                                                                            <col width="50%" />
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblStartOSC_009" runat="server" Text="Start of Service Contract" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxDateEdit ID="dteStartOSC_009" runat="server" Width="100%" EditFormat="Date">
                                                                                                </dxe:ASPxDateEdit>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblEndOSC_009" runat="server" Text="End of Service Contract" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxDateEdit ID="dteEndOSC_009" runat="server" Width="100%" EditFormat="Date">
                                                                                                </dxe:ASPxDateEdit>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblLenghtOSC_009" runat="server" Text="Length of Service Contract" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtLengthOSC_009" runat="server" MaxLength="255" Width="100%">
                                                                                                </dxe:ASPxTextBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <dxe:ASPxLabel ID="lblStatusOSC_009" runat="server" Text="Status of Service Contract" />
                                                                                            </td>
                                                                                            <td></td>
                                                                                            <td>
                                                                                                <dxe:ASPxTextBox ID="txtStatusOSC_009" runat="server" MaxLength="255" Width="100%">
                                                                                                </dxe:ASPxTextBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </dxw:ContentControl>
                                                                        </ContentCollection>
                                                                    </dxtc:TabPage>
                                                                </TabPages>
                                                            </dxtc:ASPxPageControl>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 80px">
                                                                    <dxe:ASPxButton OnLoad="cmdCreate_009_Load" ID="cmdCreate_009" runat="server" ClientInstanceName="cmdCreate_009" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_009.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_009" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_009" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_006" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_006" runat="server" Text="Overseas Training" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Planned" Visible="false">
                        <TabImage Url="images/training_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_001" runat="server" ClientInstanceName="pnlTraining_001" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                </Columns>
                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                <SettingsPager AlwaysShowPager="True" />
                                                <Styles>
                                                    <AlternatingRow Enabled="true" />
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_001" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_001" runat="server" Text="Planned Training" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_002" runat="server" ClientInstanceName="pnlTraining_002" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                <Columns>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                                </Columns>
                                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                <SettingsPager AlwaysShowPager="True" />
                                                <Styles>
                                                    <AlternatingRow Enabled="true" />
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_002" runat="server" ImageUrl="images/training_003.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_002" runat="server" Text="Training Requests" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Completed" Visible="false">
                        <TabImage Url="images/training_005.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                <dxwgv:ASPxGridView ID="dgView_003" runat="server" ClientInstanceName="dgView_003" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                    <Columns>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                        <dxwgv:GridViewDataDateColumn FieldName="StartDate" Caption="Start Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" />
                                        <dxwgv:GridViewDataDateColumn FieldName="CompletionDate" Caption="Completion Date" VisibleIndex="2" />
                                        <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" VisibleIndex="3" />
                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="4" />
                                        <dxwgv:GridViewDataTextColumn FieldName="VenueName" Caption="Venue" VisibleIndex="5" />
                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingStatus" Caption="Status" VisibleIndex="6" />
                                    </Columns>
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                    <SettingsPager AlwaysShowPager="True" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
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
                    <dxtc:TabPage Text="Skills and Knowledge Acquired">
                        <TabImage Url="images/training_007.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                    OnHtmlEditFormCreated="dgView_004_HtmlEditFormCreated"
                                    
                                    >
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
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Skill_Name" Caption="Skill" VisibleIndex="2">
                                            <PropertiesComboBox DataSourceID="dsSkillName" TextField="SkillName" ValueField="SkillName" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataDateColumn FieldName="Start_Date" Caption="Start Date" VisibleIndex="3" />
                                        <dxwgv:GridViewDataDateColumn FieldName="End_Date" Caption="End Date" VisibleIndex="4" />
                                        <dxwgv:GridViewDataDateColumn FieldName="Comments" Caption="Comments" Visible="false" />
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Reference_Person" Caption="Reference" VisibleIndex="5" >
                                            <PropertiesComboBox DataSourceID="dsCourseName" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="CourseName" ValueField="CourseName" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ContactType" Caption="Reference Type" VisibleIndex="6">
                                            <PropertiesComboBox DataSourceID="dsContactType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="ContactType" ValueField="ContactType" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <%--<dxwgv:GridViewDataTextColumn FieldName="Reference_Person" Caption="Reference" VisibleIndex="6" />--%>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="CourseCategory" Caption="Category" VisibleIndex="7">
                                            <PropertiesComboBox DataSourceID="dsCourseCategory" TextField="CourseCategory" ValueField="CourseCategory">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { if (s.GetValue() != undefined) {  dgView_004.PerformCallback('<ID=CourseCategory><Value=' + s.GetValue().toString() + '>'); } }" />
                                            </PropertiesComboBox>
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="CourseSubCategory" Caption="Sub Category" VisibleIndex="8">
                                            <PropertiesComboBox DataSourceID="dsCourseSubCategory" TextField="CourseSubCategory" ValueField="CourseSubCategory">
                                            </PropertiesComboBox>
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="NQFLevel" Caption="NQF Level" VisibleIndex="9">
                                            <PropertiesComboBox DataSourceID="dsNQFLevel" TextField="NQFLevel" ValueField="NQFLevel" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="MainField" Caption="Field" Visible="false" VisibleIndex="10">
                                            <EditFormSettings Visible="True" />
                                            <PropertiesComboBox DataSourceID="dsMainField" TextField="MainField" ValueField="MainField">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { if (s.GetValue() != undefined) { dgView_004.PerformCallback('<ID=MainField><Value=' + s.GetValue().toString() + '>'); } }" />
                                            </PropertiesComboBox>
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="SubField" Caption="Sub Field" Visible="False" VisibleIndex="11">
                                            <EditFormSettings Visible="True" />
                                            <PropertiesComboBox DataSourceID="dsSubField" TextField="SubField" ValueField="SubField" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
                                            <DeleteButton Text="Delete Record"></DeleteButton>
                                            <CustomButtons>
                                                <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record">
                                                    <Image Url="images/delete.png"></Image>
                                                </dxwgv:GridViewCommandColumnCustomButton>
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
                                                <dxtc:ASPxPageControl runat="server" ID="pageControl_004" Width="100%">
                                                    <TabPages>
                                                        <dxtc:TabPage Text="General">
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
                                                                    <table style="width: 100%">
                                                                        <colgroup>
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                               <col />
                                                                        </colgroup>
                                                                        <tr>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblSkill_004" runat="server" Text="Skill" />
                                                                                <span style="color: red">*</span>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbSkill_004" runat="server" DataSourceId="dsSkillName" TextField="SkillName" ValueField="SkillName" ValueType="System.String" Width="100%"/>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblStartDate_004" runat="server" Text="Start Date" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxDateEdit ID="dteStartDate_004" runat="server" Width="100%" EditFormat="Date" DisplayFormatString="MMMM dd, yyyy"/>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblEndDate_004" runat="server" Text="End Date" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxDateEdit ID="dteEndDate_004" runat="server" Width="100%" EditFormat="Date" DisplayFormatString="MMMM dd, yyyy"/>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblReference_004" runat="server" Text="Reference" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbReference_004" runat="server" DataSourceId="dsCourseName" TextField="CourseName" ValueField="CourseName" ValueType="System.String" Width="100%"/>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblReferenceType_004" runat="server" Text="Reference Type" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbReferenceType_004" runat="server" DataSourceId="dsContactType" TextField="ContactType" ValueField="ContactType" ValueType="System.String" Width="100%"/>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblCategory_004" runat="server" Text="Category" />
                                                                                <span style="color: red">*</span>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbCategory_004" runat="server" DataSourceId="dsCourseCategory" TextField="CourseCategory" ValueField="CourseCategory" ValueType="System.String" Width="100%">
                                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                    </ValidationSettings>
                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { if (s.GetValue() != undefined) {  dgView_004.PerformCallback('<ID=CourseCategory><Value=' + s.GetValue().toString() + '>'); } }" />    
                                                                                </dxe:ASPxComboBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblSubCategory_004" runat="server" Text="Sub Category" />
                                                                                <span style="color: red">*</span>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbSubcategory_004" runat="server" DataSourceId="dsCourseSubCategory" TextField="CourseSubCategory" ValueField="CourseSubCategory" ValueType="System.String" Width="100%">
                                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                                    </ValidationSettings>    
                                                                                </dxe:ASPxComboBox>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblNQFLevel_004" runat="server" Text="NQF Level" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbNQFLevel_004" runat="server" DataSourceId="dsNQFLevel" TextField="NQFLevel" ValueField="NQFLevel" ValueType="System.String" Width="100%"/>
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblField_004" runat="server" Text="Field" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbField_004" runat="server" DataSourceId="dsMainField" TextField="MainField" ValueField="MainField" ValueType="System.String" Width="100%">
                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { if (s.GetValue() != undefined) { dgView_004.PerformCallback('<ID=MainField><Value=' + s.GetValue().toString() + '>'); } }" />
                                                                                </dxe:ASPxComboBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <dxe:ASPxLabel ID="lblSubfield_004" runat="server" Text="Sub Field" />
                                                                            </td>
                                                                            <td>
                                                                                <dxe:ASPxComboBox ID="cmbSubfield_004" runat="server" DataSourceId="dsSubField" TextField="SubField" ValueField="SubField" ValueType="System.String" Width="100%"/>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                        <dxtc:TabPage Text="Comments">
                                                            <ContentCollection>
                                                                <dxw:ContentControl runat="server">
                                                                    <div style="text-align: center; width: 100%">
                                                                        <dxe:ASPxMemo runat="server" ID="commentsEditor_004" ClientInstanceName="commentsEditor_004" Rows="5" Text='<%# Eval("Comments") %>' Width="100%" />
                                                                    </div>
                                                                </dxw:ContentControl>
                                                            </ContentCollection>
                                                        </dxtc:TabPage>
                                                    </TabPages>
                                                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        commentsEditor_004.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                </dxtc:ASPxPageControl>
                                            </div>
                                            <div style="text-align: right; padding: 5px">
                                                <span style="cursor: pointer">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                </span>
                                                <span style="cursor: pointer">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                </span>
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
                                                    <td style="width: 10px" />
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
                    <dxtc:TabPage Text="Courses">
                        <TabImage Url="images/training_009.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <span>* Courses that are shaded gray are not recommended for the employee's respective job title</span>
                                <br />
                                <br />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_005" runat="server" GridViewID="dgView_005" />
                                <dxwgv:ASPxGridView ID="dgView_005" runat="server" ClientInstanceName="dgView_005" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnHtmlRowPrepared="dgView_005_HtmlRowPrepared">
                                    <Columns>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                        <dxwgv:GridViewDataTextColumn FieldName="CourseName" Caption="Course" SortIndex="2" SortOrder="Ascending" VisibleIndex="1" />
                                        <dxwgv:GridViewDataTextColumn FieldName="ProviderName" Caption="Provider" VisibleIndex="2" />
                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingType" Caption="Training Type" SortIndex="1" SortOrder="Ascending" VisibleIndex="3" />
                                        <dxwgv:GridViewDataTextColumn FieldName="DeliveryMethod" Caption="Delivery Method" VisibleIndex="4" />
                                        <%--<dxwgv:GridViewDataCheckColumn FieldName="InternalCourse" Caption="Internal?" VisibleIndex="4" />--%>
                                        <dxwgv:GridViewDataTextColumn FieldName="Duration" Caption="Duration" VisibleIndex="5" />
                                        <dxwgv:GridViewDataTextColumn FieldName="DurationType" Caption="Type" VisibleIndex="6" />
                                        <dxwgv:GridViewDataTextColumn FieldName="TrainingSched" Caption="Training Schedule" VisibleIndex="7" />
                                        <dxwgv:GridViewDataTextColumn FieldName="DirectCost" Caption="Cost" VisibleIndex="8" />
                                        <dxwgv:GridViewDataTextColumn FieldName="RemSlots" Caption="Rem. Slots" VisibleIndex="9" />
                                        <dxwgv:GridViewDataTextColumn FieldName="JobTitles" Visible="false" VisibleIndex="10" />
                                        <dxwgv:GridViewDataTextColumn FieldName="SequenceNum" Visible="false" SortIndex="3" SortOrder="Ascending" VisibleIndex="11" />
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="details" SelectButton-Text="View Other Schedules" VisibleIndex="12" Width="16px">
                                            <SelectButton Text="View Details"></SelectButton>
                                            <CustomButtons>
                                                <dxwgv:GridViewCommandColumnCustomButton ID="details_005" Image-Url="images/info.png" Text="View Other Schedules" >
                                                    <Image Url="images/info.png"></Image>
                                                </dxwgv:GridViewCommandColumnCustomButton>
                                            </CustomButtons>
                                        </dxwgv:GridViewCommandColumn>
                                    </Columns>
                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.lpPage.Show(); s.PerformCallback('details\ ' + e.visibleIndex.toString()); }" EndCallback="function(s, e) { if (s.cpShowDetails) { window.parent.lpPage.Hide(); lblHtml.SetValue(s.cpHtmlText); pcDetails.AdjustSize(); pcDetails.Show(); } else { if (s.cpURL.length != 0 && s.cpToolURL.length != 0) { window.parent.postUrl(s.cpURL + '\ ' + s.cpToolURL, false); } } }" />
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                    <SettingsPager AlwaysShowPager="True" PageSize="25" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
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
                    <dxtc:TabPage Text="Evaluation">
                        <TabImage Url="images/training_009.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <table style="color: #000000; font: 9pt Tahoma; width: 100%">
                                    <tr>
                                        <td colspan="3">
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 30.00%">Training Type:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left" width="67.5%">
                                            <asp:UpdatePanel ID="updTrainType_011" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <dxe:ASPxComboBox ID="cmbTrainType_011" runat="server" ClientInstanceName="cmbTrainType_011" AutoPostBack="true" EnableIncrementalFiltering="False" OnSelectedIndexChanged="cmbTrainType_011_SelectedIndexChanged" Width="75%">
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                        </ValidationSettings>
                                                    </dxe:ASPxComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 30.00%">Training Course:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left" width="67.5%">
                                            <asp:UpdatePanel ID="updCourse_011" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <dxe:ASPxComboBox ID="cmbCourse_011" runat="server" ClientInstanceName="cmbCourse_011" AutoPostBack="true" EnableIncrementalFiltering="True" OnSelectedIndexChanged="cmbCourse_011_SelectedIndexChanged" Width="75%">
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                        </ValidationSettings>
                                                    </dxe:ASPxComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 30.00%">Provider:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left" width="67.5%">
                                            <asp:UpdatePanel ID="updProvider_011" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <dxe:ASPxComboBox ID="cmbProvider_011" runat="server" ClientInstanceName="cmbProvider_011" AutoPostBack="true" EnableIncrementalFiltering="False" OnSelectedIndexChanged="cmbProvider_011_SelectedIndexChanged" Width="75%">
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                        </ValidationSettings>
                                                    </dxe:ASPxComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 30.00%">Schedule Dates:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left" width="67.5%">
                                            <asp:UpdatePanel ID="updSchedDate_011" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <dxe:ASPxComboBox ID="cmbSchedDate_011" runat="server" ClientInstanceName="cmbSchedDate_011" EnableIncrementalFiltering="False" Width="75%">
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                            <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                        </ValidationSettings>
                                                    </dxe:ASPxComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                            <dxe:ASPxButton ID="cmdEvaluate_011" runat="server" Text="Evaluate" Visible="true" OnClick="cmdEvaluate_011_Click">
                                                <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                            </dxe:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Application">
                        <TabImage Url="images/training_011.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <table style="color: #000000; font: 9pt Tahoma; width: 100%">
                                    <tr>
                                        <td colspan="3">
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 30.00%">Training Course:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left" width="67.5%">
                                            <dxe:ASPxComboBox ID="cmbCourse_006" runat="server" AutoPostBack="true" ClientInstanceName="cmbCourse_006" DataSourceID="dsCourseLU" TextField="CourseName" ValueField="CourseName" EnableIncrementalFiltering="True" Width="75%">
                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                </ValidationSettings>
                                            </dxe:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Provider:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left">
                                            <dxe:ASPxComboBox ID="cmbProvider_006" runat="server" AutoPostBack="true" ClientInstanceName="cmbProvider_006" DataSourceID="dsProviders" TextField="ProviderName" ValueField="ProviderName" EnableIncrementalFiltering="True" Width="75%">
                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                </ValidationSettings>
                                            </dxe:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Schedule Dates:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left">
                                            <table style="margin-left: -2px">
                                                <tr>
                                                    <td width="60%">
                                                        <dxe:ASPxComboBox ID="cmbSched_006" runat="server" AutoPostBack="true" ClientInstanceName="cmbSched_006" DataSourceID="dsSchedules" TextField="ScheduleDate" ValueField="ScheduleDate" EnableIncrementalFiltering="True" Width="75%">
                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                            </ValidationSettings>
                                                        </dxe:ASPxComboBox>
                                                    </td>
                                                    <td width="2.5%" />
                                                    <td style="text-align: right" width="10%">
                                                        <dxe:ASPxLabel ID="lblSlotsLeft" runat="server" Text="Slots left: " Font-Bold="True" />
                                                    </td>
                                                    <td width="1%" />
                                                    <td style="text-align: left">
                                                        <dxe:ASPxTextBox ID="txtSlotsLeft" runat="server" Width="50px" HorizontalAlign="Center" Text="0" Enabled="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Course Prerequisites:</td>
                                        <td class="auto-style3">&nbsp;</td>
                                        <td style="text-align: left">
                                            <dxe:ASPxMemo ID="memoPrereq" ClientInstanceName="memoPrereq" runat="server" Height="70px" Width="300px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                            <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Visible="true">
                                                <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                            </dxe:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Training Agreement Form">
                        <TabImage Url="images/training_011.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server" ID="tafContent">
                                <a id="expandAgreement" href="#">Expand All</a>
                                &nbsp;
                                    <a id="collapseAgreement" href="#">Collapse All</a>
                                <br />
                                <br />
                                <%--<dxwgv:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="dgView_006" />
                                <dxwgv:ASPxGridViewExporter ID="ASPxGridViewExporter2" runat="server" GridViewID="dgView_007" />
                                <dxwgv:ASPxGridViewExporter ID="ASPxGridViewExporter3" runat="server" GridViewID="dgView_008" />
                                <dxwgv:ASPxGridViewExporter ID="ASPxGridViewExporter4" runat="server" GridViewID="dgView_009" />--%>
                                <dxrp:ASPxRoundPanel ID="pnlAgreement_001" runat="server" ClientInstanceName="pnlAgreement_001" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <table style="color: #000000; font: 9pt Tahoma; width: 100%" >
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
                                                    <td height="3px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%"></td>
                                                    <td width="30%" style="text-align: left">Name</td>
                                                    <td width="30%" style="text-align: left">Mobile No.<span style="color: red">*</span></td>
                                                    <td width="30%" style="text-align: left">Local No.</td>
                                                    <td width="5%"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="text-align: center;">
                                                        <dxe:ASPxTextBox ID="txtName_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                    </td>
                                                    <td style="text-align: center">
                                                        <dxe:ASPxTextBox ID="txtMobile_007" runat="server" Width="100%" HorizontalAlign="Left" Enabled="true">
                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                            </ValidationSettings>
                                                        </dxe:ASPxTextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <dxe:ASPxTextBox ID="txtLocal_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="3px">
                                                    </td>
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
                                                    <td height="3px">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%"></td>
                                                    <td width="30%" style="text-align: left">Level</td>
                                                    <td width="30%" style="text-align: left">External Position Title<span style="color: red">*</span></td>
                                                    <td width="30%" style="text-align: left">RTA No.(HRD-Training use only)</td>
                                                    <td width="5%"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="text-align: center;">
                                                        <dxe:ASPxTextBox ID="txtLevel_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                    </td>
                                                    <td style="text-align: center">
                                                        <dxe:ASPxTextBox ID="txtExternalPos_007" runat="server" Width="100%" HorizontalAlign="Left" Enabled="true" >
                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                            </ValidationSettings>
                                                        </dxe:ASPxTextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <dxe:ASPxTextBox ID="txtRTA_007" runat="server" Width="95%" HorizontalAlign="Left" Enabled="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="5">
                                                        <dxe:ASPxButton ID="btnSave_007" runat="server" Text="Save" Visible="true">
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
                                                    <dxe:ASPxImage ID="imgPanel_010" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_011" runat="server" Text="Team Member's Profile" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlAgreement_002" runat="server" ClientInstanceName="pnlAgreement_002" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_014" runat="server" ClientInstanceName="dgView_014" Width="100%" KeyFieldName="ProgramDetailsID" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgView_014_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_014_StartRowEditing"
                                                OnRowValidating="dgView_014_RowValidating"
                                                OnRowInserting="dgView_014_RowInserting"
                                                OnRowUpdating="dgView_014_RowUpdating"
                                                OnRowDeleting="dgView_014_RowDeleting">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProgramDetailsID" VisibleIndex="1" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProgramTitle" Caption="Program Title" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Type" Caption="Type" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ProgramType" Caption="Program Type" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Investment" Caption="Investment" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Provider" VisibleIndex="6" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Venue" Caption="Venue" VisibleIndex="7" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="DateFrom" VisibleIndex="8" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="DateTo" VisibleIndex="9" Visible="false" />
                                                    <%--<dxwgv:GridViewDataTextColumn FieldName="Objectives" VisibleIndex="10" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Objectives1" VisibleIndex="10" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Objectives2" VisibleIndex="11" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Objectives3" VisibleIndex="12" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Justification" VisibleIndex="11" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Justification1" VisibleIndex="13" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Justification2" VisibleIndex="14" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Justification3" VisibleIndex="15" Visible="false" />--%>
                                                    <dxwgv:GridViewDataTextColumn FieldName="TAFID" VisibleIndex="10" Visible="false" />
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="11" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton  ID="delete_014" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dxwgv:GridViewCommandColumn>
                                                </Columns>
                                                <ClientSideEvents
                                                    CustomButtonClick="
                                                        function(s, e) { 
                                                            window.parent.ExecDeleteCallback(s, e); 
                                                        }"
                                                    EndCallback="
                                                        function(s, e) { 
                                                            if (s.cpCancelEdit) { 
                                                                s.Refresh();
                                                                dgView_014.Refresh();
                                                            } 
                                                        }" />
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
                                                            <table style="width: 100%">
                                                                <colgroup>
                                                                    <col width="230px" />
                                                                    <col width="10px" />
                                                                    <col />
                                                                    <col width="35%" />
                                                                </colgroup>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblProgramTitle_014" runat="server" Text="Program Title" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtProgramTitle_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblType_014" runat="server" Text="Type" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <%--<dxe:ASPxComboBox ID="cbCourse" runat="server" DataSourceID="dsCourseLU_Overseas" TextField="CourseName" ValueField="CourseName" ValueType="System.String" Width="100%">
                                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_008_009_cbCourse_SelectedIndexChanged(s, e, 'dgView_009'); }" />
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>--%>
                                                                        <dxe:ASPxComboBox ID="cmbType_014" runat="server" DataSourceID="dsTAFType" TextField="Type" ValueField="Type" ValueType="System.String" Width="100%" >
                                                                            <%--<ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_014.PerformCallback(s.GetValue()); }" />--%>
                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_014.PerformCallback('<ID=cmbType_014><Value=' + s.GetValue() + '>'); }" />
                                                                            <Items>
                                                                                <dxe:ListEditItem Text="Functional Training Program" Value="Functional Training Program" />
                                                                                <dxe:ListEditItem Text="Specialized Development Programs" Value="Specialized Development Program" />
                                                                            </Items>
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblProgramType_014" runat="server" Text="Program Type" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxComboBox ID="cmbProgramType_014" runat="server" DataSourceID="dsTAFProgType" TextField="ProgramType" ValueField="ProgramType" ValueType="System.String" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblInvestment_014" runat="server" Text="Investment (Training Fee + Per Diem)" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtInvestment_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ClientSideEvents LostFocus="function(s, e) { dgView_014.PerformCallback('<ID=txtInvestment_014><Value=' + s.GetValue() + '>'); }" />
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblProvider_014" runat="server" Text="Provider" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtProvider_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblVenue_014" runat="server" Text="Venue" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtVenue_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblDateFrom_014" runat="server" Text="Date From" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxDateEdit ID="dteDateFrom_014" runat="server" Width="100%" EditFormat="DateTime">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxDateEdit>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblDateTo_014" runat="server" Text="Date To" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxDateEdit ID="dteDateTo_014" runat="server" Width="100%" EditFormat="DateTime">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxDateEdit>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <%--<tr>
                                                                    <td valign="top">
                                                                        <dxe:ASPxLabel ID="lblObjectives_014" runat="server" Text="Program Objectives" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxMemo ID="memoObjectives_014" runat="server" Rows="5" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxMemo>
                                                                        <dxe:ASPxTextBox ID="txtObjectives1_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtObjectives2_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtObjectives3_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <dxe:ASPxLabel ID="lblJustification_014" runat="server" Text="Program Justification" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxMemo ID="memoJustification_014" runat="server" Rows="5" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxMemo>
                                                                        <dxe:ASPxTextBox ID="txtJustification1_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtJustification2_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtJustification3_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>--%>
                                                                <tr style="display: none">
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblProgramDetailsID_014" runat="server" Text="Program Details ID" />
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtProgramDetailsID_014" runat="server" MaxLength="255" Width="100%" >
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblTAFID_014" runat="server" Text="TAF ID" />
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtTAFID_014" runat="server" MaxLength="255" Width="100%" >
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <%--<td style="width: 80px">
                                                                    <dxe:ASPxButton ID="cmdCreate_014" runat="server" ClientInstanceName="cmdCreate_014" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_014.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>--%>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <td style="width: 80px">
                                                                        <dxe:ASPxButton ID="cmdCreate_014" runat="server" ClientInstanceName="cmdCreate_014" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                            <ClientSideEvents Click="function(s, e) { 
                                                                                if (dgView_014.GetVisibleRowsOnPage() >= 1) {
                                                                                    window.parent.ShowPopup('information You can only create 1 Program Detail!');
                                                                                }
                                                                                else {
                                                                                    dgView_014.AddNewRow(); 
                                                                                }
                                                                            }" />
                                                                        </dxe:ASPxButton>
                                                                    </td>
                                                                    <%--<dxm:ASPxMenu ID="mnuExport_014" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_014" Text="Export to">
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
                                                                    </dxm:ASPxMenu>--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </StatusBar>
                                                </Templates>
                                            </dxwgv:ASPxGridView>
                                            <br />
                                            <dxrp:ASPxRoundPanel ID="pnlAgreement1_002" runat="server" ClientInstanceName="pnlAgreement1_002" Width="100%">
                                                <PanelCollection>
                                                    <dxp:PanelContent runat="server">
                                                        <asp:UpdatePanel ID="updTrainingAgreement_016" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <table style="color: #000000; font: 9pt Tahoma; width: 100%">
                                                                <tr>
                                                                    <td style="width: 9%" valign="top">
                                                                        <dxe:ASPxLabel ID="lblObjectives_014" runat="server" Text="Program Objectives" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <%--<dxe:ASPxMemo ID="memoObjectives_014" runat="server" Rows="5" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxMemo>--%>
                                                                        <dxe:ASPxTextBox ID="txtObjectives1_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtObjectives2_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtObjectives3_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </dxp:PanelContent>
                                                </PanelCollection>
                                                <HeaderTemplate>
                                                    <table style="height: 16px; width: 100%">
                                                        <tr valign="middle">
                                                            <td style="width: 20px">
                                                                <dxe:ASPxImage ID="imgPanel_022" runat="server" ImageUrl="images/training_001.png" />
                                                            </td>
                                                            <td>
                                                                <dxe:ASPxLabel ID="lblPanel_023" runat="server" Text="Program Objectives" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                            </dxrp:ASPxRoundPanel>
                                            <br />
                                            <dxrp:ASPxRoundPanel ID="pnlAgreement2_002" runat="server" ClientInstanceName="pnlAgreement2_002" Width="100%">
                                                <PanelCollection>
                                                    <dxp:PanelContent runat="server">
                                                        <asp:UpdatePanel ID="updTrainingAgreement_017" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <table style="color: #000000; font: 9pt Tahoma; width: 100%">
                                                                <tr>
                                                                    <td style="width: 9%" valign="top">
                                                                        <dxe:ASPxLabel ID="lblJustification_014" runat="server" Text="Program Justification" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <%--<dxe:ASPxMemo ID="memoJustification_014" runat="server" Rows="5" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxMemo>--%>
                                                                        <dxe:ASPxTextBox ID="txtJustification1_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtJustification2_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                        <dxe:ASPxTextBox ID="txtJustification3_014" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </dxp:PanelContent>
                                                </PanelCollection>
                                                <HeaderTemplate>
                                                    <table style="height: 16px; width: 100%">
                                                        <tr valign="middle">
                                                            <td style="width: 20px">
                                                                <dxe:ASPxImage ID="imgPanel_024" runat="server" ImageUrl="images/training_001.png" />
                                                            </td>
                                                            <td>
                                                                <dxe:ASPxLabel ID="lblPanel_025" runat="server" Text="Program Justification" />
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
                                                    <dxe:ASPxImage ID="imgPanel_012" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_013" runat="server" Text="Program Details" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlAgreement_004" runat="server" ClientInstanceName="pnlAgreement_004" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <asp:UpdatePanel ID="updTrainingAgreement_014" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <table style="color: #000000; font: 9pt Tahoma; width: 100%" >
                                                        <tr>
                                                            <td width="5%"></td>
                                                            <td colspan="3" width="90%">
Upon submission of this Training Agreement Form (TAF): <br />
&nbsp;&nbsp;&nbsp;&nbsp;* l agree to adhere to TMP's Training Agreement guidelines and its corresponding Penalty Clause; <br />
&nbsp;&nbsp;&nbsp;&nbsp;* I acknowledge that I have a copy of the Training Agreement Form which will serve as a binding agreement between me and TMP; <br />
&nbsp;&nbsp;&nbsp;&nbsp;* I agree to use the knowledge and skills acquired from the training and development program, find ways to improve my work, and cascade what I learned to my fellow Team Members; <br />
&nbsp;&nbsp;&nbsp;&nbsp;* I agree to serve my service agreement starting from the end of my last service agreement, if any, plus this current training service agreement; <br />
&nbsp;&nbsp;&nbsp;&nbsp;* I agree to notify HRD-Training of any change in the RTA liquidation that will result to a change in the original service agreement period; <br />
&nbsp;&nbsp;&nbsp;&nbsp;* I authorize TMP to deduct from my salary or other remuneration, including separation pay, the amount that should be reimbursed to TMP if any of the cases mentioned under the Penalty Clause apply.
                                                            </td>
                                                            <td width="5%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td style="text-align: left;">
                                                                <dxe:ASPxCheckBox ID="cbxTrainingAgreement_014" Text="Training Agreement" AutoPostBack="true" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5" style="display: none">
                                                                <dxe:ASPxButton ID="btnMainSubmit_014" runat="server" Text="Submit">
                                                                    <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                                                </dxe:ASPxButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="5">
                                                                <dxe:ASPxButton ID="btnSubmitAgreement_014" runat="server" Text="Submit" Visible="true" Enabled="false">
                                                                    <ClientSideEvents Click="function(s, e) { if (!ASPxClientEdit.ValidateGroup()) { e.processOnServer = false; } }" />
                                                                </dxe:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_016" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_017" runat="server" Text="Training Agreement" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="TAF History">
                        <TabImage Url="images/training_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridView ID="dgView_015" runat="server" ClientInstanceName="dgView_015" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="false">
                                    <Columns>
                                        <dxwgv:GridViewDataSpinEditColumn FieldName="CompositeKey" Caption="Task #" SortIndex="0" SortOrder="Descending" VisibleIndex="0" Width="64px">
                                            <PropertiesSpinEdit DisplayFormatString="g" NumberFormat="Custom" />
                                        </dxwgv:GridViewDataSpinEditColumn>
                                        <dxwgv:GridViewDataTextColumn CellStyle-HorizontalAlign="Center" FieldName="Type" Caption="Type" VisibleIndex="1" Width="20%" />
                                        <dxwgv:GridViewDataTextColumn FieldName="ProgramType" Caption="Program Type" VisibleIndex="2" Width="20%" />
                                        <dxwgv:GridViewDataTextColumn FieldName="ProgramTitle" Caption="Course Name" VisibleIndex="3" Width="20%" />
                                        <dxwgv:GridViewDataDateColumn CellStyle-HorizontalAlign="Center" FieldName="TAFDuration" Caption="Duration" VisibleIndex="4" Width="12%" />
                                        <dxwgv:GridViewDataDateColumn CellStyle-HorizontalAlign="Center" FieldName="DatePrepared" Caption="Date Submitted/Approved" VisibleIndex="5" Width ="12%" />
                                        <dxwgv:GridViewDataTextColumn CellStyle-HorizontalAlign="Center" FieldName="Status" Caption="Status" VisibleIndex="6" />
                                        <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                            <DataItemTemplate>
                                                <dxe:ASPxImage ID="cmdSelect_015" runat="server" Cursor="pointer" ToolTip="Print Preview" ImageUrl="images/tools/print.png" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="Summary" VisibleIndex="8" Visible="false" />
                                    </Columns>
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                    <SettingsPager AlwaysShowPager="true" />
                                    <Styles>
                                        <AlternatingRow Enabled="true" />
                                        <CommandColumn Spacing="8px" />
                                        <CommandColumnItem Cursor="pointer" />
                                        <Header HorizontalAlign="Center" />
                                    </Styles>
                                </dxwgv:ASPxGridView>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="TAF Maintenance">
                        <TabImage Url="images/training_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_012" runat="server" GridViewID="dgView_012" />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_012" runat="server" ClientInstanceName="pnlTraining_012" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_012" runat="server" ClientInstanceName="dgView_012" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgView_012_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_012_StartRowEditing"
                                                OnRowValidating="dgView_012_RowValidating"
                                                OnRowInserting="dgView_012_RowInserting"
                                                OnRowUpdating="dgView_012_RowUpdating"
                                                OnRowDeleting="dgView_012_RowDeleting">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Min" Caption="Min." SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Max" Caption="Max." VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ServiceAgreement" Caption="Service Agreement" VisibleIndex="4" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Months" Caption="Months" VisibleIndex="5" Visible="false" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Years" Caption="Years" VisibleIndex="6" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" VisibleIndex="7" >
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedOn" Caption="Captured On" VisibleIndex="8">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <%--<dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton  ID="delete_012" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dxwgv:GridViewCommandColumn>--%>
                                                </Columns>
                                                <ClientSideEvents
                                                    CustomButtonClick="
                                                        function(s, e) { 
                                                            window.parent.ExecDeleteCallback(s, e); 
                                                        }"
                                                    EndCallback="
                                                        function(s, e) { 
                                                            if (s.cpCancelEdit) { 
                                                                s.Refresh();
                                                                dgView_012.Refresh();
                                                            } 
                                                        }" />
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
                                                            <table style="width: 100%">
                                                                <colgroup>
                                                                    <col width="150px" />
                                                                    <col width="10px" />
                                                                    <col />
                                                                    <col width="35%" />
                                                                </colgroup>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblMin" runat="server" Text="Min. Training Investment" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtMin" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblMax" runat="server" Text="Max. Training Investment" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtMax" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblID" runat="server" Text="ID" />
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtID" runat="server" MaxLength="255" Width="100%" >
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblYears" runat="server" Text="Year/s" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtYears" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblMonths" runat="server" Text="Month/s" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtMonths" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <%--<tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblCapturedBy" runat="server" Text="Captured By" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtCapturedBy" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblCapturedOn" runat="server" Text="Captured On" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtCapturedOn" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>--%>
                                                            </table>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 80px">
                                                                    <dxe:ASPxButton ID="cmdCreate_012" runat="server" ClientInstanceName="cmdCreate_012" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_012.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_012" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_012" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_018" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_019" runat="server" Text="Functional Training Program" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_013" runat="server" GridViewID="dgView_013" />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_013" runat="server" ClientInstanceName="pnlTraining_013" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_013" runat="server" ClientInstanceName="dgView_013" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgView_013_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_013_StartRowEditing"
                                                OnRowValidating="dgView_013_RowValidating"
                                                OnRowInserting="dgView_013_RowInserting"
                                                OnRowUpdating="dgView_013_RowUpdating"
                                                OnRowDeleting="dgView_013_RowDeleting">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Program" Caption="Program" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="ServiceAgreement" Caption="Service Agreement" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" VisibleIndex="4" >
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedOn" Caption="Captured On" VisibleIndex="5">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton  ID="delete_013" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dxwgv:GridViewCommandColumn>
                                                </Columns>
                                                <ClientSideEvents
                                                    CustomButtonClick="
                                                        function(s, e) { 
                                                            window.parent.ExecDeleteCallback(s, e); 
                                                        }"
                                                    EndCallback="
                                                        function(s, e) { 
                                                            if (s.cpCancelEdit) { 
                                                                s.Refresh();
                                                                dgView_013.Refresh();
                                                            } 
                                                        }" />
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
                                                            <table style="width: 100%">
                                                                <colgroup>
                                                                    <col width="150px" />
                                                                    <col width="10px" />
                                                                    <col />
                                                                    <col width="35%" />
                                                                </colgroup>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblProgram_013" runat="server" Text="Program" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtProgram_013" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblServiceAgreement_013" runat="server" Text="Service Agreement (Year/s)" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtServiceAgreement_013" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblID_013" runat="server" Text="ID" />
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtID_013" runat="server" MaxLength="255" Width="100%" >
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 80px">
                                                                    <dxe:ASPxButton ID="cmdCreate_013" runat="server" ClientInstanceName="cmdCreate_013" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_013.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_013" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_013" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_020" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_021" runat="server" Text="Specialized Development Program" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="External">
                        <TabImage Url="images/training_002.png" />
                        <ContentCollection>
                            <dxw:ContentControl runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_010" runat="server" GridViewID="dgView_010" />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_007" runat="server" ClientInstanceName="pnlTraining_007" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgView_010" runat="server" ClientInstanceName="dgView_010" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgView_010_HtmlEditFormCreated"
                                                OnStartRowEditing="dgView_010_StartRowEditing"
                                                OnRowValidating="dgView_010_RowValidating"
                                                OnRowInserting="dgView_010_RowInserting"
                                                OnRowUpdating="dgView_010_RowUpdating"
                                                OnRowDeleting="dgView_010_RowDeleting"
                                                OnCommandButtonInitialize="dgView_010_CommandButtonInitialize"
                                                >
                                                <Columns>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                        <EditButton Visible="True">
                                                            <Image Url="images/select.png" />
                                                        </EditButton>
                                                        <CancelButton Visible="True">
                                                            <Image Url="images/cancel.png" />
                                                        </CancelButton>
                                                        <UpdateButton Visible="True">
                                                            <Image Url="images/update.png" />
                                                        </UpdateButton>
                                                    </dxwgv:GridViewCommandColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CategoryName" Caption="Category" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Year" Caption="Year" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Month" Caption="Month" VisibleIndex="4" Visible="false" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="MonthText" Caption="Month" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Budget" Caption="Budget" VisibleIndex="6" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="RemainingBudget" Caption="Remaining Budget" VisibleIndex="7" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" VisibleIndex="8">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedOn" Caption="Captured On" VisibleIndex="9">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_005" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dxwgv:GridViewCommandColumn>
                                                </Columns>
                                                <ClientSideEvents
                                                    CustomButtonClick="
                                                        function(s, e) { 
                                                            window.parent.ExecDeleteCallback(s, e); 
                                                        }"
                                                    EndCallback="
                                                        function(s, e) { 
                                                            if (s.cpCancelEdit) { 
                                                                s.Refresh();
                                                            } 
                                                        }" />
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
                                                            <table style="width: 100%">
                                                                <colgroup>
                                                                    <col width="70px" />
                                                                    <col width="10px" />
                                                                    <col />
                                                                    <col width="35%" />
                                                                </colgroup>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblCatergory" runat="server" Text="Category" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtCatergory" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblYear" runat="server" Text="Year" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxComboBox ID="cbYear" runat="server" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblMonth" runat="server" Text="Month" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxComboBox ID="cbMonth" runat="server" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblBudget" runat="server" Text="Budget" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtBudget" runat="server" MaxLength="255" Width="100%">
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 80px">
                                                                    <dxe:ASPxButton ID="cmdCreate_010" runat="server" ClientInstanceName="cmdCreate_010" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgView_010.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 105px">
                                                                    <dxm:ASPxMenu ID="mnuExport_010" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_010" Text="Export to">
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_007" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_007" runat="server" Text="External Training Budget Category" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTrainingBudgetCode_007" runat="server" ClientInstanceName="pnlTrainingBudgetCode_007" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <dxwgv:ASPxGridView ID="dgViewBC_010" runat="server" ClientInstanceName="dgViewBC_010" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False"
                                                OnHtmlEditFormCreated="dgViewBC_010_HtmlEditFormCreated"
                                                OnStartRowEditing="dgViewBC_010_StartRowEditing"
                                                OnRowValidating="dgViewBC_010_RowValidating"
                                                OnRowInserting="dgViewBC_010_RowInserting"
                                                OnRowDeleting="dgViewBC_010_RowDeleting">
                                                <%--OnRowUpdating="dgViewBC_010_RowUpdating"--%>
                                                <Columns>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                                        <EditButton Visible="True">
                                                            <Image Url="images/select.png" />
                                                        </EditButton>
                                                        <CancelButton Visible="True">
                                                            <Image Url="images/cancel.png" />
                                                        </CancelButton>
                                                        <UpdateButton Visible="True">
                                                            <Image Url="images/update.png" />
                                                        </UpdateButton>
                                                    </dxwgv:GridViewCommandColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="BudgetCode" Caption="Budget Code" SortIndex="1" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CategoryName" Caption="Category" SortIndex="0" SortOrder="Ascending" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Year" Caption="Year" VisibleIndex="4" Visible="false" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Text" Caption="Text" VisibleIndex="5" Visible="false" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="SequenceNum" Caption="SequenceNum" VisibleIndex="6" Visible="false" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" Caption="Captured By" VisibleIndex="7">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedOn" Caption="Captured On" VisibleIndex="8">
                                                        <EditFormSettings Visible="false" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="deleteBC_010" Image-Url="images/delete.png" Text="Delete Record">
                                                                <Image Url="images/delete.png"></Image>
                                                            </dxwgv:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dxwgv:GridViewCommandColumn>
                                                </Columns>
                                                <ClientSideEvents
                                                    CustomButtonClick="
                                                        function(s, e) { 
                                                            window.parent.ExecDeleteCallback(s, e); 
                                                        }"
                                                    EndCallback="
                                                        function(s, e) { 
                                                            if (s.cpCancelEdit) { 
                                                                s.Refresh();
                                                            } 
                                                        }" />
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
                                                            <table style="width: 100%">
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
                                                                        <dxe:ASPxComboBox runat="server" ID="cmbCategoryBC_010" Width="100%" DataSourceID="dsCategoryBC_010" TextField="CategoryName" ValueField="CategoryName" >
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxComboBox>
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
                                                                        <dxe:ASPxTextBox ID="txtBudgetCodeBC_010" runat="server" Width="100%" >
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblYearBC_010" runat="server" Text="Budget Code Year" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtYearBC_010" runat="server" Width="100%" ClientInstanceName="txtYearBC_010" >
                                                                            <ClientSideEvents TextChanged="function (s, e) { dgViewBC_010.PerformCallback('<ID=BudgetCode><Value=' + s.GetValue().toString() + txtTextBC_010.GetValue() + txtSequenceNumBC_010.GetValue() + '>') }" />
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblTextBC_010" runat="server" Text="Budget Code Text" />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtTextBC_010" runat="server" Width="100%" ClientInstanceName="txtTextBC_010">
                                                                            <ClientSideEvents TextChanged="function (s, e) { dgViewBC_010.PerformCallback('<ID=BudgetCode><Value=' + txtYearBC_010.GetValue() + s.GetValue().toString() + txtSequenceNumBC_010.GetValue() + '>') }" />
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dxe:ASPxLabel ID="lblBudgetBC_010" runat="server" Text="Budget Code Sequence No." />
                                                                        <span style="color: red">*</span>
                                                                    </td>
                                                                    <td></td>
                                                                    <td>
                                                                        <dxe:ASPxTextBox ID="txtSequenceNumBC_010" runat="server" MaxLength="255" Width="100%" ClientInstanceName="txtSequenceNumBC_010">
                                                                            <ClientSideEvents TextChanged="function (s, e) { dgViewBC_010.PerformCallback('<ID=BudgetCode><Value=' + txtYearBC_010.GetValue() + txtTextBC_010.GetValue() + s.GetValue().toString() + '>') }" />
                                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                            </ValidationSettings>
                                                                        </dxe:ASPxTextBox>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px" onclick="ASPxClientEdit.ValidateGroup();">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
                                                        </div>
                                                    </EditForm>
                                                    <StatusBar>
                                                        <table style="padding: 2px; width: 100%">
                                                            <tr>
                                                                <td></td>
                                                                <td style="width: 105px">
                                                                    <%--<dxm:ASPxMenu ID="mnuExport_010" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                                        <Items>
                                                                            <dxm:MenuItem Name="mnuExport_010" Text="Export to">
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
                                                                    </dxm:ASPxMenu>--%>
                                                                </td>
                                                                <td style="width: 10px" />
                                                                <td style="width: 85px">
                                                                    <dxe:ASPxButton ID="cmdCreateBC_010" runat="server" ClientInstanceName="cmdCreateBC_010" UseSubmitBehavior="false" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                        <ClientSideEvents Click="function(s, e) { dgViewBC_010.AddNewRow(); }" />
                                                                    </dxe:ASPxButton>
                                                                </td>
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
                                                    <dxe:ASPxImage runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel runat="server" Text="External Budget Code Monitoring" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlTraining_008" runat="server" ClientInstanceName="pnlTraining_008" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent runat="server">
                                            <table style="color: #000000; font: 9pt Tahoma; width: 100%" >
                                                <tr>
                                                    <td colspan="3">
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; width: 30.00%">Year:</td>
                                                    <td class="auto-style3">&nbsp;</td>
                                                    <td style="text-align: left" width="67.5%">
                                                        <dxe:ASPxComboBox ID="cmbYear_007" runat="server" ClientInstanceName="cmbYear_007" EnableIncrementalFiltering="True" Width="30%">
                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                            </ValidationSettings>
                                                        </dxe:ASPxComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; width: 30.00%">As of month (From):</td>
                                                    <td class="auto-style3">&nbsp;</td>
                                                    <td style="text-align: left" width="67.5%">
                                                        <asp:UpdatePanel ID="updMonthFrom_007" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <dxe:ASPxComboBox ID="cmbMonthFrom_007" AutoPostBack="true" runat="server" ClientInstanceName="cmbMonthFrom_007" EnableIncrementalFiltering="True" Width="30%">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxComboBox>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; width: 30.00%">To:</td>
                                                    <td class="auto-style3">&nbsp;</td>
                                                    <td style="text-align: left" width="67.5%">
                                                        <asp:UpdatePanel ID="updMonthTo_007" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <dxe:ASPxComboBox ID="cmbMonthTo_007" runat="server" ClientInstanceName="cmbMonthTo_007" EnableIncrementalFiltering="True" Width="30%">
                                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                                        <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                                                    </ValidationSettings>
                                                                </dxe:ASPxComboBox>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; width: 30.00%">Generate as:</td>
                                                    <td class="auto-style3">&nbsp;</td>
                                                    <td style="text-align: left" width="67.5%">
                                                        <dxe:ASPxRadioButtonList ID="rblGenerate_007" runat="server" Width="20%" RepeatDirection="Horizontal" TextAlign="Left" Paddings-PaddingLeft="10%" >
                                                            <Paddings PaddingLeft="10%"></Paddings>
                                                            <Items>
                                                                <dxe:ListEditItem Text="PDF" Value="1" Selected="true" />
                                                                <dxe:ListEditItem Text="Excel" Value="2" />
                                                            </Items>
                                                            <Border BorderStyle="None" />
                                                        </dxe:ASPxRadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; width: 30.00%"></td>
                                                    <td class="auto-style3">&nbsp;</td>
                                                    <td>
                                                        <dxe:ASPxButton ID="cmdGenerate_007" runat="server" AutoPostBack="true" Text="Generate" Visible="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_008" runat="server" ImageUrl="images/training_001.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_008" runat="server" Text="External Budget Monitoring Report" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                </TabPages>
                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0: // Training Curriculum
                                                                    dgView_006.Refresh();
                                                                    dgView_007.Refresh();
                                                                    dgView_008.Refresh();
                                                                    dgView_009.Refresh();
                                                                    break;
                                                                case 1: // Planned
                                                                    dgView_001.Refresh();
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 2: // Completed
                                                                    dgView_003.Refresh();
                                                                    break;
                                                                case 3: // Skills
                                                                    dgView_004.Refresh();
                                                                    break;
                                                                case 4: // Courses
                                                                    dgView_005.Refresh();
                                                                    break;
                                                                case 5: // Evaluation
                                                                    // do nothing...
                                                                    break;
                                                                case 6: // Application
                                                                    // do nothing...
                                                                    break;
                                                                case 7: // TAF
                                                                    dgView_014.Refresh();
                                                                    break;
                                                                case 8: // History
                                                                    dgView_015.Refresh();
                                                                    break;
                                                                case 9: // TAF Maintenance
                                                                    dgView_012.Refresh();
                                                                    dgView_013.Refresh();
                                                                    break;
                                                                case 10: // External
                                                                    dgView_010.Refresh();
                                                                    dgViewBC_010.Refresh();
                                                                    break;
                                                            };
                                                        }" />
            </dxtc:ASPxPageControl>
        </div>
        <asp:SqlDataSource ID="dsContactType" runat="server" />
        <asp:SqlDataSource ID="dsCourseCategory" runat="server" />
        <asp:SqlDataSource ID="dsCourseName" runat="server" />
        <asp:SqlDataSource ID="dsCourseLU" runat="server" />
        <asp:SqlDataSource ID="dsCourseLU_External" runat="server" />
        <asp:SqlDataSource ID="dsCourseLU_Overseas" runat="server" />
        <asp:SqlDataSource ID="dsCourseSubCategory" runat="server" />
        <asp:SqlDataSource ID="dsMainField" runat="server" />
        <asp:SqlDataSource ID="dsNQFLevel" runat="server" />
        <asp:SqlDataSource ID="dsProviders" runat="server" />
        <asp:SqlDataSource ID="dsProviders_External" runat="server" />
        <asp:SqlDataSource ID="dsProviders_Overseas" runat="server" />
        <asp:SqlDataSource ID="dsSchedules" runat="server" />
        <asp:SqlDataSource ID="dsSkillName" runat="server" />
        <asp:SqlDataSource ID="dsSubField" runat="server" />
        <asp:SqlDataSource ID="dsTAFType" runat="server" />
        <asp:SqlDataSource ID="dsTAFProgType" runat="server" />
        <asp:SqlDataSource ID="dsTCProgType" runat="server" />
        <asp:SqlDataSource ID="dsCategoryBC_010" runat="server" />
        <asp:HiddenField ID="hfPrereqInc" runat="server" />

        <script src="scripts/training.js" type="text/javascript"></script>
    </form>
</body>
</html>
