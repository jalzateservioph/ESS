<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="employee.aspx.vb" Inherits="SmartHR.employee" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dxt" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
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
        <script language="javascript" type="text/javascript">
            function Validate() {
                return ASPxClientEdit.ValidateGroup();
            }
        </script>
    </head>
    <body onload="window.parent.reset();">
        <form id="_employee" runat="server">
            <dxt:ASPxTimer ID="tmrThread" runat="server" ClientInstanceName="tmrThread" Enabled="false" Interval="2500">
                <ClientSideEvents Tick="function(s, e) { cpPage.PerformCallback('Progress'); }" />
            </dxt:ASPxTimer>
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    var response = e.result.split('\ ');
                    switch(response[0]) {
                        case 'Back': case 'Next': {
                                tabEmployee.SetActiveTab(tabEmployee.GetTab(parseInt(response[1])));
                            };
                            break;
                        case 'Save': case 'Submit': {
                                if (response[1] == 'success') {
                                    window.parent.postUrl(s.cpURL, false);
                                }
                                else {
                                    window.parent.ShowPopup(response[1]);
                                }
                            };
                            break;
                    };
                    window.parent.reset();
                }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxtc:ASPxPageControl ID="tabEmployee" runat="server" ClientInstanceName="tabEmployee" Width="100%">
                    <TabPages>
                        <dxtc:TabPage Text="Personal">
                            <TabImage Url="images/left_003.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px; width: 100%">
                                        <tr>
                                            <td style="width: 135px; text-align: right"><dxe:ASPxLabel ID="lblEmployeeNum" runat="server" Text="Employee No" /></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left">
                                                <dxe:ASPxTextBox ID="txtEmployeeNum" runat="server" Width="125px" ClientInstanceName="txtEmployeeNum" TabIndex="0" />
                                            </td>
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
                                            <td style="text-align: left">
                                                <dxe:ASPxTextBox ID="txtPreferredName" runat="server" Width="100%" ClientInstanceName="txtPreferredName" TabIndex="1">
                                                    <ClientSideEvents LostFocus="function(s, e) { if (txtFirstName.GetText().length == 0) { txtFirstName.SetText(s.GetText()); } }" />
                                                </dxe:ASPxTextBox>
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblTitle" runat="server" Text="Title" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbTitle" runat="server" ClientInstanceName="cmbTitle" DataSourceID="dsTitle" TextField="Title" ValueField="Title" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TabIndex="7" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblFirstName" runat="server" Text="First Name" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtFirstName" runat="server" Width="100%" ClientInstanceName="txtFirstName" TabIndex="2" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblOtherName" runat="server" Text="Middle Name" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxTextBox ID="txtOtherNames" runat="server" Width="100%" ClientInstanceName="txtOtherNames" TabIndex="8" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSurname" runat="server" Text="Surname" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxTextBox ID="txtSurname" runat="server" Width="100%" ClientInstanceName="txtSurname" TabIndex="3" />
                                            </td>
                                            <td colspan="3" />
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblIDNum" runat="server" Text="ID Number" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxTextBox ID="txtIDNum" runat="server" Width="100%" ClientInstanceName="txtIDNum" TabIndex="4" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSex" runat="server" Text="Gender" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbSex" runat="server" ClientInstanceName="cmbSex" DataSourceID="dsSex" TextField="Sex" ValueField="Sex" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TabIndex="9" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblNationality" runat="server" Text="Nationality" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbNationality" runat="server" ClientInstanceName="cmbNationality" DataSourceID="dsNationality" TextField="Nationality" ValueField="Nationality" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TabIndex="5" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblBirthDate" runat="server" Text="Date of Birth" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxDateEdit ID="dteBirthDate" runat="server" ClientInstanceName="dteBirthDate" TabIndex="10" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblEthnicGroup" runat="server" Text="Ethnic Group" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbEthnicGroup" runat="server" ClientInstanceName="cmbEthnicGroup" DataSourceID="dsEthnicGroup" TextField="EthnicGroup" ValueField="EthnicGroup" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TabIndex="6" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblMaritalStatus" runat="server" Text="Marital Status" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbMaritalStatus" runat="server" ClientInstanceName="cmbMaritalStatus" DataSourceID="dsMaritalStatus" TextField="MaritalStatus" ValueField="MaritalStatus" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" TabIndex="11" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6"><br /></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><strong>Address & Telephone</strong></td>
                                            <td />
                                            <td colspan="4"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6"><br /></td>
                                        </tr>
                                    </table>
                                    <asp:Table ID="tblAdress" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell Width="150px" HorizontalAlign="Right"><dxe:ASPxLabel ID="lblAddressLong" runat="server" Text="Street Address (long)" /></asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell Width="260px" HorizontalAlign="Left"><hr /></asp:TableCell>
                                            <asp:TableCell Width="150px" HorizontalAlign="right"><dxe:ASPxLabel ID="lblPostalAddress" runat="server" Text="Postal Address" /></asp:TableCell>
                                            <asp:TableCell Width="10px" />
                                            <asp:TableCell Width="260px" HorizontalAlign="Left"><hr /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress1" runat="server" Text="Complex Unit No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress1" runat="server" Width="125px" ClientInstanceName="txtSARSAddress1" TabIndex="12" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblPostalAddress1" runat="server" Text="P.O. Box" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOBox" runat="server" Width="235px" ClientInstanceName="txtPOBox" TabIndex="19" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress2" runat="server" Text="Complex Name" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtSARSAddress2" runat="server" Width="235px" ClientInstanceName="txtSARSAddress2" TabIndex="13" /></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblPostalAddress2" runat="server" Text="Area" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOArea" runat="server" Width="235px" ClientInstanceName="txtPOArea" TabIndex="20" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress3" runat="server" Text="Street No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtSARSAddress3" runat="server" Width="125px" ClientInstanceName="txtSARSAddress3" TabIndex="14" />
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblPostalAddress3" runat="server" Text="Zip Code" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtPOCode" runat="server" Width="125px" ClientInstanceName="txtPOCode" TabIndex="21" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress4" runat="server" Text="Street Name" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtSARSAddress4" runat="server" Width="235px" ClientInstanceName="txtSARSAddress4" TabIndex="15" />
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress5" runat="server" Text="Suburb" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtSARSAddress5" runat="server" Width="235px" ClientInstanceName="txtSARSAddress5" TabIndex="16" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress6" runat="server" Text="City" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtSARSAddress6" runat="server" Width="235px" ClientInstanceName="txtSARSAddress6" TabIndex="17" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblSARSAddress7" runat="server" Text="Zip Code" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtSARSAddress7" runat="server" Width="125px" ClientInstanceName="txtSARSAddress7" TabIndex="18" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="6"><br /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><strong>Contact Information</strong></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="Left"><hr /></asp:TableCell>
                                            <asp:TableCell />
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblCellTel" runat="server" Text="Mobile No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtCellTel" runat="server" Width="235px" ClientInstanceName="txtCellTel" TabIndex="22">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RegularExpression ErrorText="Invalid mobile number, e.g. 27601234567 (only numeric values - excluding leading zeros)." ValidationExpression="[^0*]([0-9]*)" />
                                                    </ValidationSettings>
                                                </dxe:ASPxTextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblHomeTel" runat="server" Text="Home No" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtHomeTel" runat="server" Width="235px" ClientInstanceName="txtHomeTel" TabIndex="24" /></asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="3px">
                                            <asp:TableCell ColumnSpan="6" />
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell HorizontalAlign="Right"><dxe:ASPxLabel ID="lblEmailAddress" runat="server" Text="Email Address" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left">
                                                <dxe:ASPxTextBox ID="txtEmailAddress" runat="server" Width="235px" ClientInstanceName="txtEmailAddress" TabIndex="23">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                                        <RegularExpression ErrorText="Invalid e-mail address, example: email@server.com." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                    </ValidationSettings>
                                                </dxe:ASPxTextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right"><dxe:ASPxLabel ID="lblEmailAddress1" runat="server" Text="Email Address (Alternative)" /></asp:TableCell>
                                            <asp:TableCell />
                                            <asp:TableCell HorizontalAlign="Left"><dxe:ASPxTextBox ID="txtEmailAddress1" runat="server" Width="235px" ClientInstanceName="txtEmailAddress1" TabIndex="25" /></asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="width: 95px">
                                                <img id="btnNext_001" src="images/next.png" onclick="if (Validate()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Next'); }" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Organizational">
                            <TabImage Url="images/left_004.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <table style="padding: 0px 0px 0px 0px">
                                        <tr style="height: 1px">
                                            <td style="width: 135px; text-align: right"></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 260px; text-align: left"></td>
                                            <td style="width: 135px; text-align: right"></td>
                                            <td style="width: 10px"></td>
                                            <td style="width: 250px; text-align: left"></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblJobTitle" runat="server" Text="Job title" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbJobTitle" runat="server" ClientInstanceName="cmbJobTitle" DataSourceID="dsJobTitle" TextField="JobTitle" ValueField="JobTitle" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblJobGrade" runat="server" Text="Job grade" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbJobGrade" runat="server" ClientInstanceName="cmbJobGrade" DataSourceID="dsJobGrade" TextField="JobGrade" ValueField="JobGrade" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblCostCentre" runat="server" Text="Cost centre" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbCostCentre" runat="server" ClientInstanceName="cmbCostCentre" DataSourceID="dsCostCentre" TextField="CostCentre" ValueField="CostCentre" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDeptName" runat="server" Text="Department" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbDeptName" runat="server" ClientInstanceName="cmbDeptName" DataSourceID="dsDeptName" TextField="DeptName" ValueField="DeptName" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblSkill_Level" runat="server" Text="Occupational category" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbSkill_Level" runat="server" ClientInstanceName="cmbSkill_Level" DataSourceID="dsSkill_Level" TextField="OccupCategory" ValueField="OccupCategory" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblAppointype" runat="server" Text="Appointment type" /></td>
                                            <td />
                                            <td style="text-align: left">
                                                <dxe:ASPxComboBox ID="cmbAppointype" runat="server" ClientInstanceName="cmbAppointype" DataSourceID="dsAppointype" TextField="AppointmentType" ValueField="AppointmentType" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" />
                                            </td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblPosition" runat="server" Text="Position" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbPosition" runat="server" ClientInstanceName="cmbPosition" DataSourceID="dsPosition" TextField="Position" ValueField="Position" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblLocation" runat="server" Text="Location" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxComboBox ID="cmbLocation" runat="server" ClientInstanceName="cmbLocation" DataSourceID="dsLocation" TextField="Location" ValueField="Location" DropDownStyle="DropDownList" EnableIncrementalFiltering="true" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 3px" />
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblDateJoinedGroup" runat="server" Text="Date joined group" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteDateJoinedGroup" runat="server" ClientInstanceName="dteDateJoinedGroup" /></td>
                                            <td style="text-align: right"><dxe:ASPxLabel ID="lblAppointdate" runat="server" Text="Appointment date" /></td>
                                            <td />
                                            <td style="text-align: left"><dxe:ASPxDateEdit ID="dteAppointdate" runat="server" ClientInstanceName="dteAppointdate" /></td>
                                            <td />
                                        </tr>
                                        <tr>
                                            <td colspan="6"><br /></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><strong>Reports To</strong></td>
                                            <td />
                                            <td colspan="4"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6"><br /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" />
                                            <td colspan="4">
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
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ReportToCompNum" Caption="Company" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsReportToCompNum" TextField="CompanyName" ValueField="CompanyNum">
                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView_002.GetEditor(3).PerformCallback(s.GetValue().toString()); }" />
                                                            </PropertiesComboBox>
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ReportToEmpNum" Caption="Employee" VisibleIndex="3">
                                                            <PropertiesComboBox DataSourceID="dsReportToEmpNum" TextField="Name" ValueField="EmployeeNum" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="ReportsToType" Caption="Reports To Type" VisibleIndex="4">
                                                            <PropertiesComboBox DataSourceID="dsReportsToType" TextField="ReportsToType" ValueField="ReportsToType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="Employee" Visible="false" VisibleIndex="5" />
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="6" Width="16px">
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
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td />
                                            <td style="text-align: left; width: 105px">
                                                <img id="btnBack_002" src="images/back.png" onclick="if (Validate()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Back'); }" style="cursor: pointer" />
                                            </td>
                                            <td style="width: 95px">
                                                <img id="btnNext_002" src="images/next.png" onclick="if (Validate()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Next'); }" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                        <dxtc:TabPage Text="Documents">
                            <TabImage Url="images/left_010.png" />
                            <ContentCollection>
                                <dxw:ContentControl runat="server">
                                    <br />
                                    <dxp:ASPxPanel ID="pnlSubmit" runat="server" ClientInstanceName="pnlSubmit" Width="100%">
                                        <ClientSideEvents Init="function(s, e) { s.SetVisible(window.parent.hPanel.Contains('CreateEmployee')); }" />
                                        <PanelCollection>
                                            <dxp:PanelContent>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td style="text-align: right; vertical-align: top">Identity Document:</td>
                                                        <td style="width: 10px" />
                                                        <td style="text-align: left">
                                                            <dxuc:ASPxUploadControl ID="upDoc_001" runat="server" ClientInstanceName="upDoc_001" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                <ClientSideEvents FileUploadComplete="function(s, e) { if (upDoc_002.GetText().length == 0) { if (upDoc_003.GetText().length == 0) { if (upDoc_004.GetText().length == 0) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } else { upDoc_004.Upload(); } } else { upDoc_003.Upload(); } } else { upDoc_002.Upload(); } }" />
                                                                <ValidationSettings MaxFileSize="4096000" />
                                                            </dxuc:ASPxUploadControl>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right; vertical-align: top">Contract:</td>
                                                        <td style="width: 10px" />
                                                        <td style="text-align: left">
                                                            <dxuc:ASPxUploadControl ID="upDoc_002" runat="server" ClientInstanceName="upDoc_002" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                <ClientSideEvents FileUploadComplete="function(s, e) { if (upDoc_003.GetText().length == 0) { if (upDoc_004.GetText().length == 0) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } else { upDoc_004.Upload(); } } else { upDoc_003.Upload(); } }" />
                                                                <ValidationSettings MaxFileSize="4096000" />
                                                            </dxuc:ASPxUploadControl>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right; vertical-align: top">Highest Qualification:</td>
                                                        <td style="width: 10px" />
                                                        <td style="text-align: left">
                                                            <dxuc:ASPxUploadControl ID="upDoc_003" runat="server" ClientInstanceName="upDoc_003" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                <ClientSideEvents FileUploadComplete="function(s, e) { if (upDoc_004.GetText().length == 0) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } else { upDoc_004.Upload(); } }" />
                                                                <ValidationSettings MaxFileSize="4096000" />
                                                            </dxuc:ASPxUploadControl>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right; vertical-align: top">Curriculum Vitae:</td>
                                                        <td style="width: 10px" />
                                                        <td style="text-align: left">
                                                            <dxuc:ASPxUploadControl ID="upDoc_004" runat="server" ClientInstanceName="upDoc_004" Width="100%" ShowProgressPanel="true" OnFileUploadComplete="upDocument_FileUploadComplete">
                                                                <ClientSideEvents FileUploadComplete="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); }" />
                                                                <ValidationSettings MaxFileSize="4096000" />
                                                            </dxuc:ASPxUploadControl>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td />
                                                        <td style="text-align: left; width: 105px">
                                                            <img id="btnBack_003" src="images/back.png" onclick="if (Validate()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Back'); }" style="cursor: pointer" />
                                                        </td>
                                                        <td style="width: 95px">
                                                            <img id="btnSubmit_003" src="images/submit.png" onclick="if (Validate()) { if (upDoc_001.GetText().length == 0) { if (upDoc_002.GetText().length == 0) { if (upDoc_003.GetText().length == 0) { if (upDoc_004.GetText().length == 0) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit'); } else { upDoc_004.Upload(); } } else { upDoc_003.Upload(); } } else { upDoc_002.Upload(); } } else { upDoc_001.Upload(); } }" style="cursor: pointer" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxp:ASPxPanel>
                                    <dxp:ASPxPanel ID="pnlApprove" runat="server" ClientInstanceName="pnlApprove" Width="100%">
                                        <ClientSideEvents Init="function(s, e) { s.SetVisible(!window.parent.hPanel.Contains('CreateEmployee')); }" />
                                        <PanelCollection>
                                            <dxp:PanelContent>
                                                <br />
                                                <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="0" Visible="false" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="Category" Caption="Category" VisibleIndex="1">
                                                            <PropertiesComboBox DataSourceID="dsCategory" TextField="Text" ValueField="Value" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="DocDescription" Caption="Description" VisibleIndex="2" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="DocPath" VisibleIndex="3" Visible="false" />
                                                        <dxwgv:GridViewDataCheckColumn FieldName="ESSLinked" VisibleIndex="4" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="ESSPath" VisibleIndex="5" Visible="false" />
                                                        <dxwgv:GridViewDataDateColumn FieldName="DateLinked" VisibleIndex="6">
                                                            <EditFormSettings Visible="False" />
                                                        </dxwgv:GridViewDataDateColumn>
                                                        <dxwgv:GridViewDataTextColumn Caption="#" VisibleIndex="7" Width="16px">
                                                            <CellStyle Paddings-PaddingTop="5px" />
                                                            <DataItemTemplate>
                                                                <dxe:ASPxImage ID="cmdSelect" runat="server" Cursor="pointer" ToolTip="<%# GetTooltip(Container) %>" ImageUrl="<%# GetImgUrl(Container) %>" ClientSideEvents-Click="<%# GetClickUrl(Container) %>" />
                                                            </DataItemTemplate>
                                                            <EditFormSettings Visible="False" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                    </Columns>
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                                    <SettingsEditing NewItemRowPosition="Bottom" />
                                                    <SettingsPager AlwaysShowPager="True" />
                                                    <Styles>
                                                        <AlternatingRow Enabled="true" />
                                                        <CommandColumn Spacing="8px" />
                                                        <CommandColumnItem Cursor="pointer" />
                                                        <Header HorizontalAlign="Center" />
                                                    </Styles>
                                                </dxwgv:ASPxGridView>
                                                <br />
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td />
                                                        <td style="text-align: left; width: 105px">
                                                            <img id="btnBack_003a" src="images/back.png" onclick="if (Validate()) { window.parent.lpPage.Show(); cpPage.PerformCallback('Back'); }" style="cursor: pointer" />
                                                        </td>
                                                        <td style="width: 95px">
                                                            <dxe:ASPxButton ID="cmdApprove" runat="server" Text="Approve" Width="80px" AutoPostBack="false">
                                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit Approve'); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                        <td style="width: 95px">
                                                            <dxe:ASPxButton ID="cmdReject" runat="server" Text="Reject" Width="80px" AutoPostBack="false">
                                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit Reject'); }" />
                                                            </dxe:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dxp:PanelContent>
                                        </PanelCollection>
                                    </dxp:ASPxPanel>
                                </dxw:ContentControl>
                            </ContentCollection>
                        </dxtc:TabPage>
                    </TabPages>
                    <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                            switch(e.tab.index)
                                                            {
                                                                case 0:
                                                                    if (txtEmployeeNum.GetEnabled()) {
                                                                        txtEmployeeNum.Focus();
                                                                    }
                                                                    else {
                                                                        txtPreferredName.Focus();
                                                                    }
                                                                    break;
                                                                case 1:
                                                                    dgView_002.Refresh();
                                                                    cmbJobTitle.Focus();
                                                                    break;
                                                                case 2:
                                                                    dgView.Refresh();
                                                                    break;
                                                            };
                                                        }" />
                </dxtc:ASPxPageControl>
            </div>
            <asp:SqlDataSource ID="dsCategory" runat="server" />
            <asp:SqlDataSource ID="dsDisability" runat="server" />
            <asp:SqlDataSource ID="dsEthnicGroup" runat="server" />
            <asp:SqlDataSource ID="dsMaritalStatus" runat="server" />
            <asp:SqlDataSource ID="dsNationality" runat="server" />
            <asp:SqlDataSource ID="dsNoKRelationship" runat="server" />
            <asp:SqlDataSource ID="dsRelationship" runat="server" />
            <asp:SqlDataSource ID="dsReligion" runat="server" />
            <asp:SqlDataSource ID="dsTitle" runat="server" />
            <asp:SqlDataSource ID="dsSex" runat="server" />
            <asp:SqlDataSource ID="dsAppointype" runat="server" />
            <asp:SqlDataSource ID="dsCostCentre" runat="server" />
            <asp:SqlDataSource ID="dsDeptName" runat="server" />
            <asp:SqlDataSource ID="dsJobGrade" runat="server" />
            <asp:SqlDataSource ID="dsJobTitle" runat="server" />
            <asp:SqlDataSource ID="dsLocation" runat="server" />
            <asp:SqlDataSource ID="dsPosition" runat="server" />
            <asp:SqlDataSource ID="dsReportToCompNum" runat="server" />
            <asp:SqlDataSource ID="dsReportToEmpNum" runat="server" />
            <asp:SqlDataSource ID="dsReportsToType" runat="server" />
            <asp:SqlDataSource ID="dsSkill_Level" runat="server" />
        </form>
    </body>
</html>