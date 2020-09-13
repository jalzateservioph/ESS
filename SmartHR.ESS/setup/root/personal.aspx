<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="personal.aspx.vb" Inherits="SmartHR.personal" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
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
        <form id="_personal" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabPersonal" runat="server" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Particulars">
                            <TabImage Url="images/personal_001.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblEmployeeNum" runat="server" Text="Employee No" /></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left"><dxe:ASPxTextBox ID="txtEmployeeNum" runat="server" Width="125px" ClientInstanceName="txtEmployeeNum" Enabled="false" /></td>
                                            <td style="width: 135px; text-align: right"></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left"></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblPreferredName" runat="server" Text="Preferred Name" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtPreferredName" runat="server" Width="100%" ClientInstanceName="txtPreferredName" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblTitle" runat="server" Text="Title" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbTitle" runat="server" ClientInstanceName="cmbTitle" DataSourceID="dsTitle" TextField="Title" ValueField="Title" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblFirstName" runat="server" Text="First Name" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtFirstName" runat="server" Width="100%" ClientInstanceName="txtFirstName" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSurname" runat="server" Text="Surname" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtSurname" runat="server" Width="100%" ClientInstanceName="txtSurname" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblIDNum" runat="server" Text="ID Number" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtIDNum" runat="server" Width="100%" ClientInstanceName="txtIDNum" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSex" runat="server" Text="Gender" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbSex" runat="server" ClientInstanceName="cmbSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblNationality" runat="server" Text="Nationality" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbNationality" runat="server" ClientInstanceName="cmbNationality" DataSourceID="dsNationality" TextField="Nationality" ValueField="Nationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblBirthDate" runat="server" Text="Date of Birth" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteBirthDate" runat="server" ClientInstanceName="dteBirthDate" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblLanguage" runat="server" Text="Language" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbLanguage" runat="server" ClientInstanceName="cmbLanguage" DataSourceID="dsLanguage" TextField="Language" ValueField="Language" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblReligion" runat="server" Text="Religion" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbReligion" runat="server" ClientInstanceName="cmbReligion" DataSourceID="dsReligion" TextField="Religion" ValueField="Religion" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblEthnicGroup" runat="server" Text="Ethnic Group" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbEthnicGroup" runat="server" ClientInstanceName="cmbEthnicGroup" DataSourceID="dsEthnicGroup" TextField="EthnicGroup" ValueField="EthnicGroup" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblMaritalStatus" runat="server" Text="Marital Status" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbMaritalStatus" runat="server" ClientInstanceName="cmbMaritalStatus" DataSourceID="dsMaritalStatus" TextField="MaritalStatus" ValueField="MaritalStatus" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDisability" runat="server" Text="Disability" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbDisability" runat="server" ClientInstanceName="cmbDisability" DataSourceID="dsDisability" TextField="Disability" ValueField="Disability" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDisabilityNotes" runat="server" Text="Disability Notes" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtDisabilityNotes" runat="server" Width="100%" ClientInstanceName="txtDisabilityNotes" /></td>
                                            <td />
                                        </tr>
                                    </table>
                                    <asp:PlaceHolder ID="phSpace_001" runat="server" Visible="true"><br /></asp:PlaceHolder>
                                    <dxrp:ASPxRoundPanel ID="pnlHLanguage" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Language" Caption="Language" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsLanguage" TextField="Language" ValueField="Language" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataCheckColumn FieldName="Write" Caption="Write?" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataCheckColumn FieldName="Speak" Caption="Speak?" VisibleIndex="4" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
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
                                                        <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Other Languages" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Address & Telephone">
                            <TabImage Url="images/personal_002.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <asp:Table ID="tblAdress" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell Width="150px" HorizontalAlign="Right"><dxe:ASPxLabel ID="lblAddressLong" runat="server" Text="Street Address (long)" /></asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell Width="260px" HorizontalAlign="Left"><hr /></asp:TableCell>
                                            <asp:TableCell Width="150px" HorizontalAlign="right"><dxe:ASPxLabel ID="lblAddressShort" runat="server" Text="Street Address (short)" /></asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell Width="260px" HorizontalAlign="Left"><hr /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress1" runat="server" Text="Complex Unit No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress1" runat="server" Width="125px" ClientInstanceName="txtSARSAddress1" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblAddress1" runat="server" Text="Street" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtAddress1" runat="server" Width="235px" ClientInstanceName="txtAddress1" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress2" runat="server" Text="Complex Name" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress2" runat="server" Width="235px" ClientInstanceName="txtSARSAddress2" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblAddress2" runat="server" Text="Suburb" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtAddress2" runat="server" Width="235px" ClientInstanceName="txtAddress2" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress3" runat="server" Text="Street No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress3" runat="server" Width="125px" ClientInstanceName="txtSARSAddress3" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblAddress3" runat="server" Text="City" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtAddress3" runat="server" Width="235px" ClientInstanceName="txtAddress3" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress4" runat="server" Text="Street Name" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress4" runat="server" Width="235px" ClientInstanceName="txtSARSAddress4" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblAddress4" runat="server" Text="Zip Code" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtAddress4" runat="server" Width="125px" ClientInstanceName="txtAddress4" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress5" runat="server" Text="Suburb" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress5" runat="server" Width="235px" ClientInstanceName="txtSARSAddress5" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress6" runat="server" Text="City" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress6" runat="server" Width="235px" ClientInstanceName="txtSARSAddress6" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress7" runat="server" Text="Zip Code" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress7" runat="server" Width="125px" ClientInstanceName="txtSARSAddress7" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="6"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblPostalAddress" runat="server" Text="Postal Address" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblCoordinates" runat="server" Text="Coordinates" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblPostalAddress1" runat="server" Text="P.O. Box" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOBox" runat="server" Width="235px" ClientInstanceName="txtPOBox" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblLatitude" runat="server" Text="Latitude" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtLatitude" runat="server" Width="235px" ClientInstanceName="txtLatitude" NullText="e.g. -25.132737" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblPostalAddress2" runat="server" Text="Area" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOArea" runat="server" Width="235px" ClientInstanceName="txtPOArea" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblLongitude" runat="server" Text="Longitude" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtLongitude" runat="server" Width="235px" ClientInstanceName="txtLongitude" NullText="e.g. -25.132737" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblPostalAddress3" runat="server" Text="Zip Code" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOCode" runat="server" Width="125px" ClientInstanceName="txtPOCode" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="6"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblContact" runat="server" Text="Contact Information" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><hr /></asp:TableCell>
                                            <asp:TableCell />
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblOfficeNo" runat="server" Text="Work No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtOfficeNo" runat="server" Width="235px" ClientInstanceName="txtOfficeNo" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblExtensionNo" runat="server" Text="Work Ext No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtExtensionNo" runat="server" Width="235px" ClientInstanceName="txtExtensionNo" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblCellTel" runat="server" Text="Mobile No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtCellTel" runat="server" Width="235px" ClientInstanceName="txtCellTel" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblHomeTel" runat="server" Text="Home No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtHomeTel" runat="server" Width="235px" ClientInstanceName="txtHomeTel" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblFacsimile" runat="server" Text="Facsimile No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtFacsimile" runat="server" Width="235px" ClientInstanceName="txtFacsimile" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblEmailAddress" runat="server" Text="Email Address" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtEmailAddress" runat="server" Width="235px" ClientInstanceName="txtEmailAddress" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblEmailAddress1" runat="server" Text="Email Address (Alternative)" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtEmailAddress1" runat="server" Width="235px" ClientInstanceName="txtEmailAddress1" /></asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Family Details">
                            <TabImage Url="images/personal_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                    <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblSpouseName" runat="server" Text="Spouse name" /></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left"><dxe:ASPxTextBox ID="txtSpouseName" runat="server" Width="100%" ClientInstanceName="txtSpouseName" /></td>
                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblSpouseTel" runat="server" Text="Spouse number" /></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 250px; text-align: left"><dxe:ASPxTextBox ID="txtSpouseTel" runat="server" Width="100%" ClientInstanceName="txtSpouseTel" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="7"><br /></td>
                                        </tr>
                                    </table>
                                    <dxrp:ASPxRoundPanel ID="pnlNextofKin" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="NoK" Caption="Next of Kin" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="NoKRelationship" Caption="Relationship" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsNoKRelationship" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="NoKRelationship" ValueField="NoKRelationship" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="NoKPhoneHome" Caption="Phone Home" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="NoKPhoneWork" Caption="Phone Work" VisibleIndex="4" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
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
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
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
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                        <HeaderTemplate>
                                            <table style="height: 16px; width: 100%">
                                                <tr valign="middle">
                                                    <td style="width: 20px">
                                                        <dxe:ASPxImage id="imgPanel_002" runat="server" ImageUrl="images/personal_005.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel_002" runat="server" Text="Next of Kin" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                    </dxrp:ASPxRoundPanel>
                                    <asp:PlaceHolder ID="phSpace_003" runat="server" Visible="true"><br /></asp:PlaceHolder>
                                    <dxrp:ASPxRoundPanel ID="pnlDependants" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dxp:PanelContent runat="server">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DependName" Caption="Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Surname" Caption="Surname" VisibleIndex="3" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="IDNum" Caption="ID Number" VisibleIndex="4" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataDateColumn FieldName="DoB" Caption="Date of Birth" VisibleIndex="5" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Sex" Caption="Relationship" VisibleIndex="6">
                                                            <PropertiesComboBox DataSourceID="dsRelationship" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Sex" ValueField="Sex" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="ContactNumber" Caption="Contact Number" VisibleIndex="7" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Nationality" Caption="Nationality" VisibleIndex="8" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                            <PropertiesComboBox DataSourceID="dsNationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Nationality" ValueField="Nationality" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataCheckColumn FieldName="OnMedicalAid" Caption="On Medical Aid?" VisibleIndex="9" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="MedicalAidStartDt" Caption="Medical aid Start" VisibleIndex="10" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataDateColumn>
                                                        <dxwgv:GridViewDataDateColumn FieldName="MedicalAidEndDt" Caption="Medical aid End" VisibleIndex="11" Visible="false">
                                                            <EditFormSettings Visible="true" />
                                                        </dxwgv:GridViewDataDateColumn>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="12" Width="16px">
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
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                        <HeaderTemplate>
                                            <table style="height: 16px; width: 100%">
                                                <tr valign="middle">
                                                    <td style="width: 20px">
                                                        <dxe:ASPxImage id="imgPanel_003" runat="server" ImageUrl="images/personal_006.png" />
                                                    </td>
                                                    <td>
                                                        <dxe:ASPxLabel id="lblPanel_003" runat="server" Text="Dependants" />
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
                                                                case 0:
                                                                    dgView_001.Refresh();
                                                                    break;
                                                                case 2:
                                                                    dgView_002.Refresh();
                                                                    dgView_003.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
                <dxhf:ASPxHiddenField ID="items_saved" runat="server" ClientInstanceName="items_saved" />
                <br />
                <div class="centered" style="width: 80px">
                    <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } }" />
                    </dxe:ASPxButton>
                </div>
            </div>
            <asp:SqlDataSource ID="dsDisability" runat="server" />
            <asp:SqlDataSource ID="dsEthnicGroup" runat="server" />
            <asp:SqlDataSource ID="dsLanguage" runat="server" />
            <asp:SqlDataSource ID="dsMaritalStatus" runat="server" />
            <asp:SqlDataSource ID="dsNationality" runat="server" />
            <asp:SqlDataSource ID="dsNoKRelationship" runat="server" />
            <asp:SqlDataSource ID="dsRelationship" runat="server" />
            <asp:SqlDataSource ID="dsReligion" runat="server" />
            <asp:SqlDataSource ID="dsTitle" runat="server" />
            <asp:SqlDataSource ID="dsSex" runat="server" />
        </form>
    </body>
</html>