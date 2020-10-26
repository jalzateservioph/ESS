<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="personal.aspx.vb" Inherits="SmartHR.personal" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1.Export" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="styles/index.css" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
</head>
<body onload="window.parent.reset();">

    <form id="_personal" runat="server">

        <dxpc:ASPxPopupControl ID="YesNoPopup" runat="server" ClientInstanceName="YesNoPopup" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/info.png" HeaderText="Submit Confirmation">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <div style="width: 250px; text-align: center">
                        Do you want to submit changes?
                    </div>
                    <br />
                    <div class="centered" style="width: 80px">
                        <table class="center">
                            <tr>
                                <td>
                                    <dxe:ASPxButton ID="YesNoPopup_Yes" runat="server" ClientInstanceName="YesNoPopup_Yes" Text="Yes" Height="25px" Width="80px" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { YesNoPopup.Hide(); window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                    </dxe:ASPxButton>
                                </td>
                                <td>
                                    <dxe:ASPxButton ID="YesNoPopup_No" runat="server" ClientInstanceName="YesNoPopup_No" Text="No" Height="25px" Width="80px" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { YesNoPopup.Hide(); }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
            <ClientSideEvents PopUp="function(s, e) { YesNoPopup.AdjustSize(); YesNoPopup_Yes.SetFocus(); }" />
        </dxpc:ASPxPopupControl>

        <dxpc:ASPxPopupControl ID="SuccessPrompt" runat="server" ClientInstanceName="SuccessPrompt" AllowDragging="true" CloseAction="CloseButton" EnableAnimation="false" Modal="true"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderImage-Url="images/info.png" HeaderText="Submit Confirmation">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <div style="width: 250px; text-align: center">
                        <p id="SuccessPrompt_Message" runat="server"></p>
                    </div>
                    <br />
                    <div class="centered" style="width: 80px">
                        <table class="center">
                            <tr>
                                <td>
                                    <dxe:ASPxButton ID="SuccessPrompt_OK" runat="server" ClientInstanceName="SuccessPrompt_OK" Text="OK" Height="25px" Width="80px" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { SuccessPrompt.Hide(); }" />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
            <ClientSideEvents PopUp="function(s, e) { YesNoPopup.AdjustSize(); YesNoPopup_Yes.SetFocus(); }" />
        </dxpc:ASPxPopupControl>

        <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
            <ClientSideEvents CallbackComplete="function(s, e) { if (e.result.toLowerCase().indexOf('.aspx') != -1) { window.parent.postUrl(e.result, false); } }" />
        </dxcb:ASPxCallback>
        <div class="padding">
            <dxtc:ASPxPageControl ID="tabPersonal" runat="server" Width="100%" ActiveTabIndex="0">
                <TabPages>
                    <dxtc:TabPage Text="Personal">
                        <TabImage Url="images/personal_001.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl1" runat="server">
                                <asp:Table ID="Table1" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell Width="25px" />
                                        <asp:TableCell Width="150px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="150px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel1" runat="server" Text="Personnel Information" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblEmployeeNum" runat="server" Text="Employee No" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtEmployeeNum" runat="server" Width="125px" ClientInstanceName="txtEmployeeNum" Enabled="false" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblIDNum" runat="server" Text="ID Number" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtIDNum" runat="server" Width="125px" ClientInstanceName="txtIDNum" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblTitle" runat="server" Text="Title" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbTitle" runat="server" ClientInstanceName="cmbTitle" DataSourceID="dsTitle" TextField="Title" ValueField="Title" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSuffix" runat="server" Text="Suffix" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSuffix" runat="server" Width="125px" ClientInstanceName="txtSuffix" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSurname" runat="server" Text="Surname" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSurname" runat="server" Width="100%" ClientInstanceName="txtSurname" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblFirstName" runat="server" Text="First Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtFirstName" runat="server" Width="100%" ClientInstanceName="txtFirstName" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblMiddleName" runat="server" Text="Middle Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtMiddleName" runat="server" Width="100%" ClientInstanceName="txtMiddleName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblMaidenName" runat="server" Text="Mother's Maiden Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtMaidenName" runat="server" Width="100%" ClientInstanceName="txtMaidenName" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPreferredName" runat="server" Text="Nickname" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPreferredName" runat="server" Width="100%" ClientInstanceName="txtPreferredName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel2" runat="server" Text="Other Information" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSex" runat="server" Text="Gender" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbSex" runat="server" ClientInstanceName="cmbSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblMaritalStatus" runat="server" Text="Marital Status" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbMaritalStatus" runat="server" ClientInstanceName="cmbMaritalStatus" DataSourceID="dsMaritalStatus" TextField="MaritalStatus" ValueField="MaritalStatus" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblNationality" runat="server" Text="Nationality" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbNationality" runat="server" ClientInstanceName="cmbNationality" DataSourceID="dsNationality" TextField="Nationality" ValueField="Nationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblReligion" runat="server" Text="Religion" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbReligion" runat="server" ClientInstanceName="cmbReligion" DataSourceID="dsReligion" TextField="Religion" ValueField="Religion" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblLanguage" runat="server" Text="Language" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbLanguage" runat="server" ClientInstanceName="cmbLanguage" DataSourceID="dsLanguage" TextField="Language" ValueField="Language" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblBloodType" runat="server" Text="Blood Type" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbBloodType" runat="server" ClientInstanceName="cmbBloodType" DataSourceID="dsBloodType" TextField="BloodType" ValueField="BloodType" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblMarriageDate" runat="server" Text="Date of Marriage" />


                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">

                                            <dxe:ASPxDateEdit ID="dteMarriageDate" runat="server" ClientInstanceName="dteMarriageDate" />





                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblExemptionClaim" runat="server" Text="Is Wife claiming exemption" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxCheckBox ID="chkExemptionClaim" runat="server" Text="" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblTaxCode" runat="server" Text="Tax Code" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbTaxCode" runat="server" ClientInstanceName="cmbTaxCode" DataSourceID="dsTaxCode" TextField="TaxCode" ValueField="TaxCode" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblShuttlePreference" runat="server" Text="Preferred Shuttle Area" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbShuttlePreference" runat="server" ClientInstanceName="cmbShuttlePreference" DataSourceID="dsShuttle" TextField="FieldValue" ValueField="FieldValue" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell RowSpan="3" />
                                        <asp:TableCell HorizontalAlign="Right" RowSpan="3" VerticalAlign="Top">
                                            <dxe:ASPxLabel ID="lblInterestsHobbies" runat="server" Text="Interests/Hobbies" />




                                        </asp:TableCell>
                                        <asp:TableCell RowSpan="3" />
                                        <asp:TableCell HorizontalAlign="Left" RowSpan="3" VerticalAlign="Top">
                                            <dxe:ASPxMemo ID="txtInterestsHobbies" runat="server" Width="100%" Height="100%" ClientInstanceName="txtInterestsHobbies"></dxe:ASPxMemo>




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblEthnicGroup" runat="server" Text="Ethnic Group" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbEthnicGroup" runat="server" ClientInstanceName="cmbEthnicGroup" DataSourceID="dsEthnicGroup" TextField="EthnicGroup" ValueField="EthnicGroup" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <%-- Remove cells to accomotdate rowspan
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                        </asp:TableCell>--%>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblDisability" runat="server" Text="Disability" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbDisability" runat="server" ClientInstanceName="cmbDisability" DataSourceID="dsDisability" TextField="Disability" ValueField="Disability" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <%-- Remove cells to accomotdate rowspan
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                        </asp:TableCell>--%>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblDisabilityNotes" runat="server" Text="Disability Notes" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtDisabilityNotes" runat="server" Width="100%" ClientInstanceName="txtDisabilityNotes" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel3" runat="server" Text="Details of Birth" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblBirthDate" runat="server" Text="Date of Birth" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxDateEdit ID="dteBirthDate" runat="server" ClientInstanceName="dteBirthDate" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAge" runat="server" Text="Age" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAge" runat="server" Width="125px" ClientInstanceName="txtAge" ReadOnly="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblCityOfBirth" runat="server" Text="Municipality/City" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtCityOfBirth" runat="server" Width="100%" ClientInstanceName="txtCityOfBirth" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPlaceOfBirth" runat="server" Text="State\Province" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPlaceOfBirth" runat="server" Width="100%" ClientInstanceName="txtPlaceOfBirth" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblCountryOfBirth" runat="server" Text="Country of Birth" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbCountryOfBirth" runat="server" ClientInstanceName="cmbCountryOfBirth" DataSourceID="dsCountryOfBirth" TextField="CountryName" ValueField="CountryName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblZodiacSign" runat="server" Text="Zodiac Sign" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <%--<dxe:ASPxTextBox ID="ASPxComboBox1" runat="server" Width="125px" ClientInstanceName="txtZodiacSign" Enabled="false"/>--%>
                                            <dxe:ASPxComboBox ID="txtZodiacSign" runat="server" Width="125px" ClientInstanceName="txtZodiacSign" TextField="Zodiac Sign" ValueField="Zodiac Sign" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                <Items>


                                                    <dxe:ListEditItem Text="" Value="" />


                                                    <dxe:ListEditItem Text="Aquarius" Value="Aquarius" Selected="True" />


                                                    <dxe:ListEditItem Text="Pisces" Value="Pisces" />


                                                    <dxe:ListEditItem Text="Aries" Value="Aries" />


                                                    <dxe:ListEditItem Text="Taurus" Value="Taurus" />


                                                    <dxe:ListEditItem Text="Gemini" Value="Gemini" />


                                                    <dxe:ListEditItem Text="Cancer" Value="Cancer" />


                                                    <dxe:ListEditItem Text="Leo" Value="Leo" />


                                                    <dxe:ListEditItem Text="Virgo" Value="Virgo" />


                                                    <dxe:ListEditItem Text="Libra" Value="Libra" />


                                                    <dxe:ListEditItem Text="Scorpio" Value="Scorpio" />


                                                    <dxe:ListEditItem Text="Sagittarius" Value="Sagittarius" />


                                                    <dxe:ListEditItem Text="Capricorn" Value="Capricorn" />


                                                </Items>


                                            </dxe:ASPxComboBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAnimalSign" runat="server" Text="Animal Sign" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <%--<dxe:ASPxTextBox ID="txtAnimalSign" runat="server" Width="125px" ClientInstanceName="txtAnimalSign" Enabled="false" />--%>
                                            <dxe:ASPxComboBox ID="txtAnimalSign" runat="server" Width="125px" ClientInstanceName="txtAnimalSign" TextField="Animal Sign" ValueField="Animal Sign" DropDownStyle="DropDownList" EnableIncrementalFiltering="true">
                                                <Items>


                                                    <dxe:ListEditItem Text="" Value="" />


                                                    <dxe:ListEditItem Text="Rat" Value="Rat" />


                                                    <dxe:ListEditItem Text="Ox" Value="Ox" />


                                                    <dxe:ListEditItem Text="Tiger" Value="Tiger" />


                                                    <dxe:ListEditItem Text="Rabbit" Value="Rabbit" />


                                                    <dxe:ListEditItem Text="Dragon" Value="Dragon" />


                                                    <dxe:ListEditItem Text="Snake" Value="Snake" />


                                                    <dxe:ListEditItem Text="Horse" Value="Horse" />


                                                    <dxe:ListEditItem Text="Sheep" Value="Sheep" />


                                                    <dxe:ListEditItem Text="Monkey" Value="Monkey" />


                                                    <dxe:ListEditItem Text="Rooster" Value="Rooster" />


                                                    <dxe:ListEditItem Text="Dog" Value="Dog" />


                                                    <dxe:ListEditItem Text="Pig" Value="Pig" />


                                                </Items>


                                            </dxe:ASPxComboBox>
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel4" runat="server" Text="Government Mandated No." Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSSS" runat="server" Text="SSS Membership No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSSS" runat="server" Width="125px" ClientInstanceName="txtSSS" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPHIC" runat="server" Text="Phil-Health No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPHIC" runat="server" Width="125px" ClientInstanceName="txtPHIC" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblTIN" runat="server" Text="TIN No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtTIN" runat="server" Width="125px" ClientInstanceName="txtTIN" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblHDMF" runat="server" Text="Pag-Ibig No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtHDMF" runat="server" Width="125px" ClientInstanceName="txtHDMF" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <dxwgv:ASPxGridViewExporter ID="dgExports_004" runat="server" GridViewID="dgView_004" />
                                <asp:PlaceHolder ID="phSpace_004" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>
                                <dxrp:ASPxRoundPanel ID="pnlAttributes" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="PanelContent4" runat="server">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataDateColumn FieldName="DateCreated" Caption="Date Recorded" VisibleIndex="1" />
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="AttributeName" Caption="Attribute" VisibleIndex="2">
                                                        <PropertiesComboBox DataSourceID="dsAttribute" TextField="AttributeName" ValueField="AttributeName" />
                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="AttributeValue" Caption="Value" VisibleIndex="3"></dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="5" Width="16px">
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_004" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_004" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_004" ReplacementType="EditFormCancelButton" runat="server" />
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
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                    <HeaderTemplate>
                                        <table style="height: 16px; width: 100%">
                                            <tr valign="middle">
                                                <td style="width: 20px">
                                                    <dxe:ASPxImage ID="imgPanel_004" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_004" runat="server" Text="Attributes" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <dxwgv:ASPxGridViewExporter ID="dgExports_001" runat="server" GridViewID="dgView_001" />
                                <asp:PlaceHolder ID="phSpace_001" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>
                                <dxrp:ASPxRoundPanel ID="pnlHLanguage" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="PanelContent1" runat="server">
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
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_001" Image-Url="images/delete.png" Text="Delete Record">
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                                    <dxe:ASPxImage ID="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_001" runat="server" Text="Other Languages" />
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
                            <dxw:ContentControl ID="ContentControl2" runat="server">
                                <asp:Table ID="Table3" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell Width="25px" />
                                        <asp:TableCell Width="150px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="150px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="ASPxLabel5" runat="server" Text="Present Address (Long)" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="ASPxLabel6" runat="server" Text="Present Address (Short)" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress1" runat="server" Text="Complex Unit No" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress1" runat="server" Width="125px" ClientInstanceName="txtSARSAddress1" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress1" runat="server" Text="Street" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress1" runat="server" Width="235px" ClientInstanceName="txtAddress1" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress2" runat="server" Text="Complex Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress2" runat="server" Width="235px" ClientInstanceName="txtSARSAddress2" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress2" runat="server" Text="Suburb" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress2" runat="server" Width="235px" ClientInstanceName="txtAddress2" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress3" runat="server" Text="House Number" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress3" runat="server" Width="235px" ClientInstanceName="txtSARSAddress3" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress3" runat="server" Text="City" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress3" runat="server" Width="235px" ClientInstanceName="txtAddress3" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress4" runat="server" Text="Street Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress4" runat="server" Width="235px" ClientInstanceName="txtSARSAddress4" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress5" runat="server" Text="State/Province" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress5" runat="server" Width="235px" ClientInstanceName="txtAddress5" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress5" runat="server" Text="Subdivision" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress5" runat="server" Width="235px" ClientInstanceName="txtSARSAddress5" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress4" runat="server" Text="Zip Code" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress4" runat="server" Width="125px" ClientInstanceName="txtAddress4" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPresentBaranggay" runat="server" Text="Barangay" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPresentBaranggay" runat="server" Width="235px" ClientInstanceName="txtPresentBaranggay" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblAddress6" runat="server" Text="Tel No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtAddress6" runat="server" Width="125px" ClientInstanceName="txtAddress6" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPresentRegion" runat="server" Text="Region" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbPresentRegion" runat="server" ClientInstanceName="cmbPresentRegion" DataSourceID="dsRegion" TextField="Region" ValueField="Region" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" Width="235px" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress6" runat="server" Text="Municipality/City" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress6" runat="server" Width="235px" ClientInstanceName="txtSARSAddress6" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPresentProvince" runat="server" Text="Province" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPresentProvince" runat="server" Width="235px" ClientInstanceName="txtPresentProvince" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSARSAddress7" runat="server" Text="Postal Code" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSARSAddress7" runat="server" Width="125px" ClientInstanceName="txtSARSAddress7" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPresentTelNo" runat="server" Text="Tel No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPresentTelNo" runat="server" Width="125px" ClientInstanceName="txtPresentTelNo" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel7" runat="server" Text="Permanent Address" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxCheckBox ID="chkSameAsPresent" runat="server" ClientInstanceName="chkSameAsPresent">




                                                <ClientSideEvents CheckedChanged="
                                                    function(e) {
                                                        if ($('#' + e.name + '_S').val() == 'C') {
                                                            // HOUSE NO.
                                                            $('#tabPersonal_txtPermanentHouseNumber_I').val($('#tabPersonal_txtSARSAddress3_I').val())
                                                            //$('#tabPersonal_txtSARSAddress3_I').attr('readonly', 'readonly')

                                                            // STREET NAME
                                                            $('#tabPersonal_txtPermanentStreetName_I').val($('#tabPersonal_txtSARSAddress4_I').val())
                                                            //$('#tabPersonal_txtSARSAddress4_I').attr('readonly', 'readonly')

                                                            // SUBDIVISION
                                                            $('#tabPersonal_txtPermanentSubdivision_I').val($('#tabPersonal_txtSARSAddress5_I').val())
                                                            //$('#tabPersonal_txtSARSAddress5_I').attr('readonly', 'readonly')

                                                            // BARANGGAY
                                                            $('#tabPersonal_txtPermanentBaranggay_I').val($('#tabPersonal_txtPresentBaranggay_I').val())
                                                            //$('#tabPersonal_txtPresentBaranggay_I').attr('readonly', 'readonly')

                                                            // REGION
                                                            $('#tabPersonal_cmbPermanentRegion_I').val($('#tabPersonal_cmbPresentRegion_I').val())
                                                            //$('#tabPersonal_txtSARSAddress3_I').attr('readonly', 'readonly')

                                                            // MUNICIPALITY/CITY
                                                            $('#tabPersonal_txtPermanentCity_I').val($('#tabPersonal_txtSARSAddress6_I').val())
                                                            //$('#tabPersonal_txtSARSAddress6_I').attr('readonly', 'readonly')

                                                            // PROVINCE
                                                            $('#tabPersonal_txtPermanentProvince_I').val($('#tabPersonal_txtPresentProvince_I').val())
                                                            //$('#tabPersonal_txtPresentProvince_I').attr('readonly', 'readonly')

                                                            // POSTAL CODE
                                                            $('#tabPersonal_txtPermanentPostalCode_I').val($('#tabPersonal_txtSARSAddress7_I').val())
                                                            //$('#tabPersonal_txtSARSAddress7_I').attr('readonly', 'readonly')

                                                            // TELEPHONE NUMBER
                                                            $('#tabPersonal_txtPermanentTelNo_I').val($('#tabPersonal_txtPresentTelNo_I').val())
                                                            //$('#tabPersonal_txtPermanentTelNo_I').attr('readonly', 'readonly')
                                                        }
                                                        else {
                                                            // HOUSE NO.
                                                            $('#tabPersonal_txtPermanentHouseNumber_I').val('')

                                                            // STREET NAME
                                                            $('#tabPersonal_txtPermanentStreetName_I').val('')

                                                            // SUBDIVISION
                                                            $('#tabPersonal_txtPermanentSubdivision_I').val('')

                                                            // BARANGGAY
                                                            $('#tabPersonal_txtPermanentBaranggay_I').val('')

                                                            // REGION
                                                            $('#tabPersonal_cmbPermanentRegion_I').val('')

                                                            // MUNICIPALITY/CITY
                                                            $('#tabPersonal_txtPermanentCity_I').val('')

                                                            // PROVINCE
                                                            $('#tabPersonal_txtPermanentProvince_I').val('')

                                                            // POSTAL CODE
                                                            $('#tabPersonal_txtPermanentPostalCode_I').val('')

                                                            // TELEPHONE NUMBER
                                                            $('#tabPersonal_txtPermanentTelNo_I').val('')
                                                        }
                                                    }
                                                " />




                                            </dxe:ASPxCheckBox>




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxLabel ID="ASPxLabel11" runat="server" Text="Same as present address" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <%--<asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentComplexUnitNo" runat="server" Text="Complex Unit No" />
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentComplexUnitNo" runat="server" Width="125px" ClientInstanceName="txtPermanentComplexUnitNo" />
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentComplexName" runat="server" Text="Complex Name" />
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentComplexName" runat="server" Width="235px" ClientInstanceName="txtPermanentComplexName" />
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>--%>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentHouseNumber" runat="server" Text="House Number" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentHouseNumber" runat="server" Width="235px" ClientInstanceName="txtPermanentHouseNumber" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentStreetName" runat="server" Text="Street Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentStreetName" runat="server" Width="235px" ClientInstanceName="txtPermanentStreetName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentSubdivision" runat="server" Text="Subdivision" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentSubdivision" runat="server" Width="235px" ClientInstanceName="txtPermanentSubdivision" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentBaranggay" runat="server" Text="Barangay" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentBaranggay" runat="server" Width="235px" ClientInstanceName="txtPermanentBarangay" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentRegion" runat="server" Text="Region" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbPermanentRegion" runat="server" ClientInstanceName="cmbPermanentRegion" DataSourceID="dsRegion" TextField="Region" ValueField="Region" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" Width="235px" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentCity" runat="server" Text="Municipality/City" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentCity" runat="server" Width="235px" ClientInstanceName="txtPermanentCity" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentProvince" runat="server" Text="Province" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentProvince" runat="server" Width="235px" ClientInstanceName="txtPermanentProvince" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentPostalCode" runat="server" Text="Postal Code" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentPostalCode" runat="server" Width="125px" ClientInstanceName="txtPermanentPostalCode" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPermanentTelNo" runat="server" Text="Tel No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPermanentTelNo" runat="server" Width="125px" ClientInstanceName="txtPermanentTelNo" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                            <dxe:ASPxLabel ID="ASPxLabel8" runat="server" Text="Contact Information" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="5"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblHomeTel" runat="server" Text="Home Tel. No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtHomeTel" runat="server" Width="235px" ClientInstanceName="txtHomeTel" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblEmailAddress" runat="server" Text="Company E-mail Address" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtEmailAddress" runat="server" Width="235px" ClientInstanceName="txtEmailAddress" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblCellTel" runat="server" Text="Mobile No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtCellTel" runat="server" Width="235px" ClientInstanceName="txtCellTel" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblOfficeNo" runat="server" Text="Work No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtOfficeNo" runat="server" Width="235px" ClientInstanceName="txtOfficeNo" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblFacsimile" runat="server" Text="Fax No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtFacsimile" runat="server" Width="235px" ClientInstanceName="txtFacsimile" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblExtensionNo" runat="server" Text="Local No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtExtensionNo" runat="server" Width="235px" ClientInstanceName="txtExtensionNo" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblEmailAddress1" runat="server" Text="Personal E-mail Address " />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtEmailAddress1" runat="server" Width="235px" ClientInstanceName="txtEmailAddress1" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="ASPxLabel9" runat="server" Text="Postal Address" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="ASPxLabel10" runat="server" Text="Coordinates" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPostalAddress1" runat="server" Text="P.O. Box" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPOBox" runat="server" Width="235px" ClientInstanceName="txtPOBox" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblLatitude" runat="server" Text="Latitude" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtLatitude" runat="server" Width="125px" ClientInstanceName="txtLatitude" NullText="e.g. -25.132737" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPostalAddress2" runat="server" Text="Area" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPOArea" runat="server" Width="235px" ClientInstanceName="txtPOArea" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblLongitude" runat="server" Text="Longitude" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtLongitude" runat="server" Width="125px" ClientInstanceName="txtLongitude" NullText="e.g. -25.132737" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblPostalAddress3" runat="server" Text="Zip Code" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtPOCode" runat="server" Width="125px" ClientInstanceName="txtPOCode" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="1px">
                                        <asp:TableCell ColumnSpan="7" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Family Background">
                        <TabImage Url="images/personal_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl3" runat="server">
                                <dxwgv:ASPxGridViewExporter ID="dgExports_002" runat="server" GridViewID="dgView_002" />
                                <dxwgv:ASPxGridViewExporter ID="dgExports_003" runat="server" GridViewID="dgView_003" />
                                <asp:Table ID="Table4" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell Width="100px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="100px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="100px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="250px" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="ASPxLabel23" runat="server" Text="Spouse Information" Font-Size="Medium" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell ColumnSpan="9"><hr /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseSurname" runat="server" Text="Surname" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseSurname" runat="server" Width="100%" ClientInstanceName="txtSpouseSurname" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseName" runat="server" Text="First Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseName" runat="server" Width="100%" ClientInstanceName="txtSpouseName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseMiddleName" runat="server" Text="Middle Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseMiddleName" runat="server" Width="100%" ClientInstanceName="txtSpouseMiddleName" />




                                        </asp:TableCell>


                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxLabel ID="lblHouseholdCount" runat="server" Text="Household Members" />

                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtHouseholdCount" runat="server" Width="250px" ClientInstanceName="txtHouseholdCount" ReadOnly="false" Enabled="True" />

                                        </asp:TableCell>


                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseBirthDate" runat="server" Text="Birthday" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxDateEdit ID="dteSpouseBirthDate" runat="server" Width="150px" ClientInstanceName="dteSpouseBirthDate">

                                                <ClientSideEvents ValueChanged="function(s,e){  txtGuardianAge.SetText(getAge(dteGuardianBirthDate.GetDate())); }" />

                                            </dxe:ASPxDateEdit>




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseAge" runat="server" Text="Age" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseAge" runat="server" Width="150px" ClientInstanceName="txtSpouseAge" ReadOnly="true" Font-Bold="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseSex" runat="server" Text="Gender" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbSpouseSex" runat="server" Width="150px" ClientInstanceName="cmbSpouseSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseTel" runat="server" Text="Contact No." />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseTel" runat="server" Width="100%" ClientInstanceName="txtSpouseTel" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseAddress" runat="server" Text="Address" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseAddress" runat="server" Width="100%" ClientInstanceName="txtSpouseAddress" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseNationality" runat="server" Text="Nationality" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbSpouseNationality" runat="server" ClientInstanceName="cmbSpouseNationality" DataSourceID="dsNationality" TextField="Nationality" ValueField="Nationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" Width="100%" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseOccupation" runat="server" Text="Occupation" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseOccupation" runat="server" Width="100%" ClientInstanceName="txtSpouseOccupation" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseEmployer" runat="server" Text="Employer" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseEmployer" runat="server" Width="100%" ClientInstanceName="txtSpouseEmployer" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblSpouseEmployerAddress" runat="server" Text="Employer Address" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtSpouseEmployerAddress" runat="server" Width="100%" ClientInstanceName="txtSpouseEmployerAddress" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                                <dxrp:ASPxRoundPanel ID="pnlNextofKin" runat="server" Width="100%" Visible="false" ClientVisible="false">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="PanelContent2" runat="server" Visible="false">
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
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_002" Image-Url="images/delete.png" Text="Delete Record">
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_002" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_002" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                                    <dxe:ASPxImage ID="imgPanel_002" runat="server" ImageUrl="images/personal_005.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_002" runat="server" Text="Next of Kin" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                                <asp:PlaceHolder ID="phSpace_003" runat="server" Visible="true">
                                    <br />
                                </asp:PlaceHolder>
                                <dxrp:ASPxRoundPanel ID="pnlDependants" runat="server" Width="100%">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="PanelContent3" runat="server">
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
                                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="DependName" Caption="First Name" SortIndex="1" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="DepMidName" Caption="Middle Name" SortIndex="2" SortOrder="Ascending" VisibleIndex="2" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Surname" Caption="Last Name" VisibleIndex="3" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="IDNum" Caption="ID Number" VisibleIndex="4" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataDateColumn FieldName="DoB" Caption="Date of Birth" VisibleIndex="5" />
                                                    <dxwgv:GridViewDataTextColumn FieldName="Age" Caption="Age" ReadOnly="True" ShowInCustomizationForm="False" VisibleIndex="6">
                                                        <EditFormSettings Visible="False" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Sex" Caption="Relationship" VisibleIndex="7">
                                                        <PropertiesComboBox DataSourceID="dsRelationship" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Sex" ValueField="Sex" />
                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                    <dxwgv:GridViewDataTextColumn FieldName="ContactNumber" Caption="Contact Number" VisibleIndex="8" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataComboBoxColumn FieldName="Nationality" Caption="Nationality" VisibleIndex="9" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                        <PropertiesComboBox DataSourceID="dsNationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Nationality" ValueField="Nationality" />
                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                    <dxwgv:GridViewDataComboBoxColumn Caption="Civil Status" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="DepCivilStat">
                                                        <PropertiesComboBox DataSourceID="dsMaritalStatus" TextField="MaritalStatus" IncrementalFilteringMode="StartsWith" />
                                                    </dxwgv:GridViewDataComboBoxColumn>
                                                    <dxwgv:GridViewDataCheckColumn FieldName="OnMedicalAid" Caption="On Medical Aid?" VisibleIndex="11" />
                                                    <dxwgv:GridViewDataCheckColumn Caption="Deceased?" FieldName="DepDeceased" ShowInCustomizationForm="True" VisibleIndex="12">
                                                        <PropertiesCheckEdit DisplayTextChecked="Y" DisplayTextUnchecked="N"></PropertiesCheckEdit>
                                                    </dxwgv:GridViewDataCheckColumn>
                                                    <dxwgv:GridViewDataDateColumn FieldName="MedicalAidStartDt" Caption="Medical Aid Start" VisibleIndex="13" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataDateColumn FieldName="MedicalAidEndDt" Caption="Medical Aid End" VisibleIndex="14" Visible="false">
                                                        <EditFormSettings Visible="true" />
                                                    </dxwgv:GridViewDataDateColumn>
                                                    <dxwgv:GridViewDataTextColumn Caption="Occupation" FieldName="DepOccupation" ShowInCustomizationForm="True" VisibleIndex="15" PropertiesTextEdit-MaxLength="150">
                                                        <PropertiesTextEdit MaxLength="150"></PropertiesTextEdit>
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn Caption="School/Company" FieldName="DepEmployer" ShowInCustomizationForm="True" VisibleIndex="16" PropertiesTextEdit-MaxLength="150">
                                                        <PropertiesTextEdit MaxLength="150"></PropertiesTextEdit>
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewDataTextColumn Caption="Address" FieldName="DepAddress" ShowInCustomizationForm="True" VisibleIndex="17">
                                                        <PropertiesTextEdit MaxLength="250">
                                                        </PropertiesTextEdit>
                                                    </dxwgv:GridViewDataTextColumn>
                                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="18" Width="16px">
                                                        <DeleteButton Text="Delete Record"></DeleteButton>
                                                        <CustomButtons>
                                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete_003" Image-Url="images/delete.png" Text="Delete Record">
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
                                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_003" ReplacementType="EditFormEditors" runat="server" />
                                                        </div>
                                                        <div style="text-align: right; padding: 5px">
                                                            <span style="cursor: pointer; padding-right: 10px">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_003" ReplacementType="EditFormUpdateButton" runat="server" />
                                                            </span>
                                                            <span style="cursor: pointer">
                                                                <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_003" ReplacementType="EditFormCancelButton" runat="server" />
                                                            </span>
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
                                                    <dxe:ASPxImage ID="imgPanel_003" runat="server" ImageUrl="images/personal_006.png" />
                                                </td>
                                                <td>
                                                    <dxe:ASPxLabel ID="lblPanel_003" runat="server" Text="Dependents" />
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Contact Person In Case of Emergency">
                        <TabImage Url="images/personal_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl4" runat="server">
                                <br />
                                <asp:Table ID="Table2" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell Width="125px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="225px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="125px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="225px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="125px" />
                                        <asp:TableCell Width="10px" />
                                        <asp:TableCell Width="225px" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianLastName" runat="server" Text="Last Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianLastName" runat="server" Width="225px" ClientInstanceName="txtGuardianLastName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianFirstName" runat="server" Text="First Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianFirstName" runat="server" Width="225px" ClientInstanceName="txtGuardianFirstName" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianMiddleName" runat="server" Text="Middle Name" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianMiddleName" runat="server" Width="225px" ClientInstanceName="txtGuardianMiddleName" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianBirthDate" runat="server" Text="Birthday" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <%-- amanriza --%>
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxDateEdit ID="dteGuardianBirthDate" runat="server" Width="150px" ClientInstanceName="dteGuardianBirthDate">

                                                <ClientSideEvents ValueChanged="function(s,e){  txtGuardianAge.SetText(getAge(dteGuardianBirthDate.GetDate())); }" />

                                            </dxe:ASPxDateEdit>
                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianAge" runat="server" Text="Age" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianAge" runat="server" Width="150px" ClientInstanceName="txtGuardianAge" Enabled="false" Font-Bold="true" ReadOnly="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianSex" runat="server" Text="Gender" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbGuardianSex" runat="server" Width="150px" ClientInstanceName="cmbGuardianSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianRelationship" runat="server" Text="Relationship" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxComboBox ID="cmbGuardianRelationship" runat="server" Width="225px" ClientInstanceName="cmbGuardianRelationship" DataSourceID="dsRelatives" TextField="Relatives" ValueField="Relatives" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianAddress" runat="server" Text="Address" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianAddress" runat="server" Width="225px" ClientInstanceName="txtGuardianAddress" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianContactNo" runat="server" Text="Contact Number" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianContactNo" runat="server" Width="225px" ClientInstanceName="txtGuardianContactNo" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="3px">
                                        <asp:TableCell ColumnSpan="11" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianOccupation" runat="server" Text="Occupation" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianOccupation" runat="server" Width="225px" ClientInstanceName="txtGuardianOccupation" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Right">
                                            <dxe:ASPxLabel ID="lblGuardianEmployer" runat="server" Text="Employer" />




                                        </asp:TableCell>
                                        <asp:TableCell />
                                        <asp:TableCell HorizontalAlign="Left">
                                            <dxe:ASPxTextBox ID="txtGuardianEmployer" runat="server" Width="225px" ClientInstanceName="txtGuardianEmployer" />




                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Relatives Working in TMP">
                        <TabImage Url="images/personal_003.png" />
                        <ContentCollection>
                            <dxw:ContentControl ID="ContentControl5" runat="server">
                                <dxwgv:ASPxGridView ID="dgView_Relatives" runat="server" ClientInstanceName="dgView_Relatives" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                    <Columns>
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" CancelButton-Text="Cancel Changes" VisibleIndex="0" Width="16px">
                                            <EditButton Visible="True">
                                                <Image Url="images/edit.png"></Image>
                                            </EditButton>
                                            <CancelButton Visible="True">
                                                <Image Url="images/cancel.png"></Image>
                                            </CancelButton>
                                            <UpdateButton Visible="True">
                                                <Image Url="images/update.png"></Image>
                                            </UpdateButton>
                                        </dxwgv:GridViewCommandColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                        <dxwgv:GridViewDataTextColumn FieldName="Surname" Caption="Last Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1"></dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="FirstName" Caption="First Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2"></dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="MiddleName" Caption="Middle Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="3"></dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Relation" Caption="Relationship" SortOrder="Ascending" VisibleIndex="4">
                                            <PropertiesComboBox DataSourceID="dsRelatives" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="Relatives" ValueField="Relatives" />
                                        </dxwgv:GridViewDataComboBoxColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="PlaceOfWork" Caption="Place of Work" SortIndex="0" SortOrder="Ascending" VisibleIndex="5"></dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewDataTextColumn FieldName="PlantBranch" Caption="Plant/Branch" SortIndex="0" SortOrder="Ascending" VisibleIndex="3"></dxwgv:GridViewDataTextColumn>
                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
                                            <DeleteButton Text="Delete Record"></DeleteButton>
                                            <CustomButtons>
                                                <dxwgv:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton2" Text="Delete Record">
                                                    <Image Url="images/delete.png"></Image>
                                                </dxwgv:GridViewCommandColumnCustomButton>
                                            </CustomButtons>
                                        </dxwgv:GridViewCommandColumn>
                                    </Columns>
                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                    <SettingsPager AlwaysShowPager="True" />
                                    <Styles>
                                        <AlternatingRow Enabled="True"></AlternatingRow>
                                        <CommandColumn Spacing="8px"></CommandColumn>
                                        <CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                        <Header HorizontalAlign="Center"></Header>
                                    </Styles>
                                    <Templates>
                                        <EditForm>
                                            <div style="padding: 5px; width: 100%">
                                                <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                            </div>
                                            <div style="text-align: right; padding: 5px">
                                                <span style="cursor: pointer; padding-right: 10px">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" />
                                                </span>
                                                <span style="cursor: pointer">
                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" />
                                                </span>
                                            </div>
                                        </EditForm>
                                        <StatusBar>
                                            <table style="padding: 2px; width: 100%">
                                                <tr>
                                                    <td></td>
                                                    <td style="width: 80px">
                                                        <dxe:ASPxButton ID="cmdCreate_Relatives" runat="server" ClientInstanceName="cmdCreate_Relatives" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                                            <ClientSideEvents Click="function(s, e) { dgView_Relatives.AddNewRow(); }" />
                                                        </dxe:ASPxButton>
                                                    </td>
                                                    <td style="width: 10px" />
                                                </tr>
                                            </table>
                                        </StatusBar>
                                    </Templates>
                                </dxwgv:ASPxGridView>
                            </dxw:ContentControl>
                        </ContentCollection>
                    </dxtc:TabPage>
                </TabPages>
                <%--<ClientSideEvents ActiveTabChanged="function(s, e) { switch(e.tab.index) { case 0: dgView_001.Refresh(); dgView_004.Refresh(); break; case 2: dgView_002.Refresh(); dgView_003.Refresh(); break; case 4: dgView_Relatives.Refresh(); break; }; }" />--%>
                <ClientSideEvents ActiveTabChanged="function(s, e) {
                    switch(e.tab.index) 
                    { 
                    case 4: cmdSubmit.SetEnabled(false); break;  
                    default: cmdSubmit.SetEnabled(true);
                    };

                    }" />
            </dxtc:ASPxPageControl>
            <dxhf:ASPxHiddenField ID="items_saved" runat="server" ClientInstanceName="items_saved" />
            <br />
            <div class="centered" style="width: 80px">
                <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { YesNoPopup.Show(); } }" />
                </dxe:ASPxButton>
            </div>
        </div>
        <asp:SqlDataSource ID="dsCountryOfBirth" runat="server" />
        <asp:SqlDataSource ID="dsBloodType" runat="server" />
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
        <asp:SqlDataSource ID="dsRelatives" runat="server" />
        <asp:SqlDataSource ID="dsTaxCode" runat="server" />
        <asp:SqlDataSource ID="dsRegion" runat="server" />
        <asp:SqlDataSource ID="dsProvince" runat="server" />
        <asp:SqlDataSource ID="dsCity" runat="server" />
        <asp:SqlDataSource ID="dsBaranggay" runat="server" />
        <asp:SqlDataSource ID="dsShuttle" runat="server" />
        <asp:SqlDataSource ID="dsAttribute" runat="server" />
    </form>

    <script src="scripts/jquery-1.4.2.js" type="text/javascript">
 
  

    </script>
    <script type="text/javascript"> 
        function getAge(DOB) {
            var today = new Date();
            var birthDate = new Date(DOB);
            var age = today.getFullYear() - birthDate.getFullYear();
            var m = today.getMonth() - birthDate.getMonth();

            if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                age = age - 1;
            }

            return age;
        }
    </script>
</body>
</html>