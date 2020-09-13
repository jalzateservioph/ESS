<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ir.aspx.vb" Inherits="SmartHR.ir" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
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
        <form id="_ir" runat="server">
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabIR" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Discipline">
                            <TabImage Url="images/ir_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="IncidentDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataDateColumn FieldName="IncidentTime" Caption="Time" VisibleIndex="3" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesDateEdit DisplayFormatString="hh:mm:ss" EditFormatString="hh:mm:ss" EditFormat="Custom">
                                                    <ClientSideEvents DropDown="function(s, e) { s.HideDropDown(); }" /> 
                                                    <DropDownButton Visible="False"></DropDownButton>
                                                </PropertiesDateEdit>
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Manager" Caption="Reported To" VisibleIndex="4" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="OffenceCategory" Caption="Offence" VisibleIndex="5">
                                                <PropertiesComboBox DataSourceID="dsOffenceCategory" TextField="OffenceCatagory" ValueField="OffenceCatagory" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="HearingDate" Caption="Hearing Date" VisibleIndex="6" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="HearingTime" Caption="Hearing Time" VisibleIndex="7" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesDateEdit DisplayFormatString="hh:mm:ss" EditFormatString="hh:mm:ss" EditFormat="Custom">
                                                    <ClientSideEvents DropDown="function(s, e) { s.HideDropDown(); }" />
                                                    <DropDownButton Visible="False"></DropDownButton>
                                                </PropertiesDateEdit>
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Category" Caption="Category" VisibleIndex="8" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsIncCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Category" ValueField="Category" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="SubCategory" Caption="Sub Category" VisibleIndex="9" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsIncSubCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="SubCategory" ValueField="SubCategory" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="DisciplinaryAction" Caption="Disciplinary Action" VisibleIndex="10">
                                                <PropertiesComboBox DataSourceID="dsDisciplinaryAction" TextField="DisciplinaryAction" ValueField="DisciplinaryAction" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Period" Caption="Period" VisibleIndex="11" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsPeriod" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Period" ValueField="Period" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Cost" Caption="Cost" VisibleIndex="12" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="EndDate" Caption="End Date" VisibleIndex="13" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="FollowUpDate" Caption="Follow Up Date" VisibleIndex="14" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataDateColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="Resolved" Caption="Resolved?" VisibleIndex="15" />
                                            <dxwgv:GridViewDataMemoColumn FieldName="DisciplineReport" VisibleIndex="16" Visible="false" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="17" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                    <dxtc:ASPxPageControl ID="pageControl_001" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Report">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="disciplinereportEditor_001" runat="server" ClientInstanceName="disciplinereportEditor_001" Rows="5" Text='<%# Eval("DisciplineReport") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        disciplinereportEditor_001.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
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
                        <dxtc:TabPage Text="Counselling Conduct">
                            <TabImage Url="images/ir_004.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                    <dxwgv:ASPxGridView ID="dgView_004" runat="server" ClientInstanceName="dgView_004" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="fDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Manager" Caption="Manager" VisibleIndex="3" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Warning_Issued" Caption="Warning" VisibleIndex="4">
                                                <PropertiesComboBox DataSourceID="dsWarningIssued" TextField="DisciplinaryAction" ValueField="DisciplinaryAction" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataDateColumn FieldName="Follow_Up_Date" Caption="Follow Up" VisibleIndex="5" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="Spoken_Before" Caption="Previous Incident?" VisibleIndex="6" />
                                            <dxwgv:GridViewDataDateColumn FieldName="Spoken_Date" Caption="Date" VisibleIndex="7" />
                                            <dxwgv:GridViewDataCheckColumn FieldName="Disciplinary_Hearing" Caption="Disciplinary?" VisibleIndex="8" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="9">
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="10" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_004" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpURL.length != 0) { window.parent.postUrl(s.cpURL, false); } else { if (s.cpCancelEdit) { s.CancelEdit(); } } }" />
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
                                                    <dxtc:ASPxPageControl ID="pageControl_004" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_004" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Incident Report">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="incidentEditor_004" runat="server" ClientInstanceName="incidentEditor_004" Rows="5" Text='<%# Eval("Incident") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                            <dxtc:TabPage Text="Detail of Events">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="did_whatEditor_004" runat="server" ClientInstanceName="did_whatEditor_004" Rows="5" Text='<%# Eval("Did_What") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                            <dxtc:TabPage Text="Details of Allegation">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="why_wrongEditor_004" runat="server" ClientInstanceName="why_wrongEditor_004" Rows="5" Text='<%# Eval("Why_Wrong") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                            <dxtc:TabPage Text="Expected Behaviour">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="when_had_to_behave_properlyEditor_004" runat="server" ClientInstanceName="when_had_to_behave_properlyEditor_004" Rows="5" Text='<%# Eval("When_Had_To_Behave_Properly") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        incidentEditor_004.SetFocus();
                                                                                                        break;
                                                                                                    case 2:
                                                                                                        did_whatEditor_004.SetFocus();
                                                                                                        break;
                                                                                                    case 3:
                                                                                                        why_wrongEditor_004.SetFocus();
                                                                                                        break;
                                                                                                    case 4:
                                                                                                        when_had_to_behave_properlyEditor_004.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_004" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_004" ReplacementType="EditFormCancelButton" runat="server" /></span> 
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
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_004" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { dgView_004.PerformCallback('Submit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Grievance">
                            <TabImage Url="images/ir_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
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
                                            <dxwgv:GridViewDataDateColumn FieldName="GrievanceDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Manager" Caption="Reported To" VisibleIndex="3" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="Category" Caption="Category" VisibleIndex="4">
                                                <PropertiesComboBox DataSourceID="dsCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Category" ValueField="Category" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="SubCategory" Caption="Sub Category" VisibleIndex="5" Visible="false">
                                                <EditFormSettings Visible="true" />
                                                <PropertiesComboBox DataSourceID="dsSubCategory" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="SubCategory" ValueField="SubCategory" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="Cost" Caption="Cost" VisibleIndex="6" Visible="false">
                                                <EditFormSettings Visible="true" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataCheckColumn FieldName="GrievanceSolved" Caption="Solved?" VisibleIndex="7" />
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="8" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record" />
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
                                                    <dxtc:ASPxPageControl ID="pageControl_002" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Report">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="grievancedetailsEditor_002" runat="server" ClientInstanceName="grievancedetailsEditor_002" Rows="5" Text='<%# Eval("GrievanceDetails") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 1:
                                                                                                        grievancedetailsEditor_002.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_002" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_002" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <table style="padding: 2px; width: 100%">
                                                    <tr>
                                                        <td></td>
                                                        <td style="width: 80px">
                                                            <dxe:ASPxButton ID="cmdCreate_002" runat="server" ClientInstanceName="cmdCreate_002" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                                <ClientSideEvents Click="function(s, e) { dgView_002.AddNewRow(); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 10px" />
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
                        <dxtc:TabPage Text="Work Performance">
                            <TabImage Url="images/ir_003.png" />
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
                                            <dxwgv:GridViewDataDateColumn FieldName="fDate" Caption="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="2" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Manager" Caption="Manager" VisibleIndex="3" />
                                            <dxwgv:GridViewDataDateColumn FieldName="Follow_Up_Date" Caption="Follow Up" VisibleIndex="4" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Venue" Caption="Venue" VisibleIndex="5" />
                                            <dxwgv:GridViewDataMemoColumn FieldName="Reason_For_Counselling" Caption="Reason" VisibleIndex="6" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="7">
                                                <EditFormSettings Visible="False" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="8" Width="16px">
                                                <CustomButtons>
                                                    <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record" />
                                                </CustomButtons>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpURL.length != 0) { window.parent.postUrl(s.cpURL, false); } else { if (s.cpCancelEdit) { s.CancelEdit(); } } }" />
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
                                                    <dxtc:ASPxPageControl ID="pageControl_003" runat="server" Width="100%">
                                                        <TabPages>
                                                            <dxtc:TabPage Text="General">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="width: 100%">
                                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Follow up">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="padding: 10px; width: 100%">
                                                                            <table style="padding: 0px; width: 100%">
                                                                                <tr>
                                                                                    <td style="text-align: right">Assistance?</td>
                                                                                    <td style="width: 10px" />
                                                                                    <td style="text-align: left">
                                                                                        <dxe:ASPxCheckBox ID="follow_up_assistanceEditor_003" runat="server" ClientInstanceName="follow_up_assistanceEditor_003" Checked='<%# Eval("Follow_Up_Assistance") %>' />
                                                                                    </td>
                                                                                    <td style="text-align: right">Internal Training?</td>
                                                                                    <td style="width: 10px" />
                                                                                    <td style="text-align: left">
                                                                                        <dxe:ASPxCheckBox ID="follow_up_internal_trainingEditor_003" runat="server" ClientInstanceName="follow_up_internal_trainingEditor_003" Checked='<%# Eval("Follow_Up_Internal_Training") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 3px">
                                                                                    <td colspan="6" />
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="text-align: right">External Training?</td>
                                                                                    <td style="width: 10px" />
                                                                                    <td style="text-align: left">
                                                                                        <dxe:ASPxCheckBox ID="follow_up_external_trainingEditor_003" runat="server" ClientInstanceName="follow_up_external_trainingEditor_003" Checked='<%# Eval("Follow_Up_External_Training") %>' />
                                                                                    </td>
                                                                                    <td style="text-align: right">Follow up Supervisor?</td>
                                                                                    <td style="width: 10px" />
                                                                                    <td style="text-align: left">
                                                                                        <dxe:ASPxCheckBox ID="follow_up_supervisorEditor_003" runat="server" ClientInstanceName="follow_up_supervisorEditor_003" Checked='<%# Eval("Follow_Up_Supervisor") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 3px">
                                                                                    <td colspan="6" />
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="text-align: right">Formal Discipline?</td>
                                                                                    <td style="width: 10px" />
                                                                                    <td colspan="3" style="text-align: left">
                                                                                        <dxe:ASPxCheckBox ID="follow_up_formal_disciplineEditor_003" runat="server" ClientInstanceName="follow_up_formal_disciplineEditor_003" Checked='<%# Eval("Follow_Up_Formal_Discipline") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>
                                                            <dxtc:TabPage Text="Agreed Actions (Manager)">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="manager_suggestionsEditor_003" runat="server" ClientInstanceName="manager_suggestionsEditor_003" Rows="5" Text='<%# Eval("Manager_Suggestions") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                            <dxtc:TabPage Text="Agreed Actions (Employee)">
                                                                <ContentCollection>
                                                                    <dxw:ContentControl runat="server">
                                                                        <div style="text-align: center; width: 100%">
                                                                            <dxe:ASPxMemo ID="employee_suggestionsEditor_003" runat="server" ClientInstanceName="employee_suggestionsEditor_003" Rows="5" Text='<%# Eval("Employee_Suggestions") %>' Width="100%" />
                                                                        </div>
                                                                    </dxw:ContentControl>
                                                                </ContentCollection>
                                                            </dxtc:TabPage>                                                                   
                                                        </TabPages>
                                                        <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                                                                switch(e.tab.index)
                                                                                                {
                                                                                                    case 2:
                                                                                                        manager_suggestionsEditor_003.SetFocus();
                                                                                                        break;
                                                                                                    case 3:
                                                                                                        employee_suggestionsEditor_003.SetFocus();
                                                                                                        break;
                                                                                                };
                                                                                            }" />
                                                    </dxtc:ASPxPageControl>
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
                                    <br />
                                    <div class="centered" style="width: 80px">
                                        <dxe:ASPxButton ID="cmdSubmit_003" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) { dgView_003.PerformCallback('Submit'); }" />
                                        </dxe:ASPxButton>
                                    </div>
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
                                                                    dgView_004.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_002.Refresh();
                                                                    break;
                                                                case 3:
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsCategory" runat="server" />
            <asp:SqlDataSource ID="dsDisciplinaryAction" runat="server" />
            <asp:SqlDataSource ID="dsIncCategory" runat="server" />
            <asp:SqlDataSource ID="dsIncSubCategory" runat="server" />
            <asp:SqlDataSource ID="dsOffenceCategory" runat="server" />
            <asp:SqlDataSource ID="dsPeriod" runat="server" />
            <asp:SqlDataSource ID="dsSubCategory" runat="server" />
            <asp:SqlDataSource ID="dsWarningIssued" runat="server" />
        </form>
    </body>
</html>