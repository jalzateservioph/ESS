<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="accidents.aspx.vb" Inherits="SmartHR.accidents" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
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
        <form id="_accidents" runat="server">
            <dxwgv:ASPxGridViewExporter ID="dgExports" runat="server" GridViewID="dgView" />
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlAccidents" runat="server" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                    <dxwgv:GridViewDataDateColumn FieldName="AccidentDate" Caption="Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                    <dxwgv:GridViewDataDateColumn FieldName="AccidentTime" Caption="Time" VisibleIndex="3" Visible="false">
                                        <EditFormSettings Visible="true" />
                                        <PropertiesDateEdit DisplayFormatString="hh:mm:ss" EditFormatString="hh:mm:ss" EditFormat="Custom">
                                            <ClientSideEvents DropDown="function(s, e) { s.HideDropDown(); }" /> 
                                            <DropDownButton Visible="False"></DropDownButton>
                                        </PropertiesDateEdit>
                                    </dxwgv:GridViewDataDateColumn>
                                    <dxwgv:GridViewDataDateColumn FieldName="DateReported" Caption="Reported On" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ReportedTo" Caption="Reported To" VisibleIndex="5" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="AccidentType" Caption="Type" VisibleIndex="6">
                                        <PropertiesComboBox DataSourceID="dsAccidentType" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="AccidentType" ValueField="AccidentType" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Category" Caption="Category" VisibleIndex="7" Visible="false">
                                        <EditFormSettings Visible="True" />
                                        <PropertiesComboBox DataSourceID="dsCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Category" ValueField="Category" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Witness" Caption="Witness" VisibleIndex="8" Visible="false">
                                        <EditFormSettings Visible="True" />
                                        <PropertiesComboBox DataSourceID="dsWitness" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Witness" ValueField="Witness" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Doctor" Caption="Practitioner" VisibleIndex="9" Visible="false">
                                        <EditFormSettings Visible="True" />
                                        <PropertiesComboBox DataSourceID="dsDoctor" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Doctor" ValueField="Doctor" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="ManHours" Caption="Man Hours Lost" VisibleIndex="10" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="WC_Number" Caption="Reference" VisibleIndex="11" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="WC_Amount_Paid" Caption="Amount Paid" VisibleIndex="12" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataTextColumn FieldName="WC_Amount_Received" Caption="Amount Received" VisibleIndex="13" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewDataCheckColumn FieldName="Certificate_1" Caption="Certificate 1?" VisibleIndex="14" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewDataCheckColumn FieldName="Certificate_2" Caption="Certificate 2?" VisibleIndex="15" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewDataCheckColumn FieldName="Certificate_3" Caption="Certificate 3?" VisibleIndex="16" Visible="false">
                                        <EditFormSettings Visible="true" />
                                    </dxwgv:GridViewDataCheckColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="17" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete" Image-Url="images/delete.png" Text="Delete Record" />
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
                                            <dxtc:ASPxPageControl ID="pageControl" runat="server" Width="100%">
                                                <TabPages>
                                                    <dxtc:TabPage Text="General">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="width: 100%">
                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors" runat="server" />
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Report">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="text-align: center; width: 100%">
                                                                    <dxe:ASPxMemo ID="descriptionEditor" runat="server" ClientInstanceName="descriptionEditor" Rows="5" Text='<%# Eval("Description") %>' Width="100%" />
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Action">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="text-align: center; width: 100%">
                                                                    <dxe:ASPxMemo ID="actiontakenEditor" runat="server" ClientInstanceName="actiontakenEditor" Rows="5" Text='<%# Eval("ActionTaken") %>' Width="100%" />
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                    <dxtc:TabPage Text="Treatment">
                                                        <ContentCollection>
                                                            <dxw:ContentControl runat="server">
                                                                <div style="text-align: center; width: 100%">
                                                                    <dxe:ASPxMemo ID="treatmentEditor" runat="server" ClientInstanceName="treatmentEditor" Rows="5" Text='<%# Eval("Treatment") %>' Width="100%" />
                                                                </div>
                                                            </dxw:ContentControl>
                                                        </ContentCollection>
                                                    </dxtc:TabPage>
                                                </TabPages>
                                                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                        switch(e.tab.index)
                                                                                        {
                                                                                            case 1:
                                                                                                descriptionEditor.SetFocus();
                                                                                                break;
                                                                                            case 2:
                                                                                                actiontakenEditor.SetFocus();
                                                                                                break;
                                                                                            case 3:
                                                                                                treatmentEditor.SetFocus();
                                                                                                break;
                                                                                        };
                                                                                    }" />
                                            </dxtc:ASPxPageControl>
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <table style="padding: 2px; width: 100%">
                                            <tr>
                                                <td></td>
                                                <td style="width: 80px">
                                                    <dxe:ASPxButton ID="cmdCreate" runat="server" ClientInstanceName="cmdCreate" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                        <ClientSideEvents Click="function(s, e) { dgView.AddNewRow(); }" />
                                                    </dxe:ASPxButton>
                                                </td>
                                                <td style="width: 10px" />
                                                <td style="width: 105px">
                                                    <dxm:ASPxMenu ID="mnuExport" runat="server" HorizontalAlign="Left" OnItemClick="mnuExport_ItemClick">
                                                        <Items>
                                                            <dxm:MenuItem Name="mnuExport" Text="Export to">
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
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/accidents_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Accidents" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsAccidentType" runat="server" />
            <asp:SqlDataSource ID="dsCategory" runat="server" />
            <asp:SqlDataSource ID="dsDoctor" runat="server" />
            <asp:SqlDataSource ID="dsWitness" runat="server" />
        </form>
    </body>
</html>