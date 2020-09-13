<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="transfer.aspx.vb" Inherits="SmartHR.transfer" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <link rel="icon" href="favicon.ico" type="image/ico" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="styles/index.css" rel="stylesheet" type="text/css" />
        <title>SmartHR (Employee Self Service)</title>
    </head>
    <body onload="window.parent.reset();">
        <form id="_transfer" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <br />
            <div class="padding">
                <table style="padding: 0px; width: 100%">
                    <tr>
                        <td style="text-align: right">Transfer Date</td>
                        <td />
                        <td style="text-align: left">
                            <dxe:ASPxDateEdit ID="dteTransfer" runat="server" ClientInstanceName="dteTransfer">
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                </ValidationSettings>
                            </dxe:ASPxDateEdit>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 5px" />
                    </tr>
                    <tr>
                        <td style="text-align: right">Reason for Transfer</td>
                        <td />
                        <td style="text-align: left">
                            <dxe:ASPxComboBox ID="cmbReason" runat="server" ClientInstanceName="cmbReason" DataSourceID="dsTransfer" DropDownStyle="DropDown" TextField="TransferReason" ValueField="TransferReason" EnableIncrementalFiltering="true" Width="325px">
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                                    <RequiredField IsRequired="true" ErrorText="This field cannot be empty." />
                                </ValidationSettings>
                            </dxe:ASPxComboBox>
                        </td>
                    </tr>
                </table>
                <br />
                <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="Value" AutoGenerateColumns="False">
                    <Columns>
                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" Width="16px" VisibleIndex="0">
                            <HeaderTemplate>
                                <input type="checkbox" onclick="dgView.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Select / Unselect all rows on the page" />
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" >
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                        </dxwgv:GridViewCommandColumn>
                        <dxwgv:GridViewDataTextColumn FieldName="Value" Visible="False" VisibleIndex="1" />
                        <dxwgv:GridViewDataTextColumn FieldName="Text" Caption="Full Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2" />
                        <dxwgv:GridViewDataTextColumn FieldName="EMailAddress" Caption="E-mail" VisibleIndex="4" Visible="False" />
                        <dxwgv:GridViewDataTextColumn FieldName="CellTel" Caption="Phone" VisibleIndex="5" Visible="False" />
                        <dxwgv:GridViewDataTextColumn FieldName="JobTitle" Caption="Job Title" VisibleIndex="3" />
                        <dxwgv:GridViewDataTextColumn FieldName="JobGrade" Caption="Job Grade" VisibleIndex="4" />
                        <dxwgv:GridViewDataTextColumn FieldName="CostCentre" Caption="Cost Centre" VisibleIndex="5" />
                        <dxwgv:GridViewDataTextColumn FieldName="DeptName" Caption="Department" VisibleIndex="6" />
                        <dxwgv:GridViewDataTextColumn FieldName="Appointype" Caption="Appointment Type" VisibleIndex="7" />
                        <dxwgv:GridViewDataTextColumn FieldName="CellTel" Visible="False" VisibleIndex="8" />
                    </Columns>
                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                    <SettingsPager AlwaysShowPager="True" PageSize="25" />
                    <Styles>
                        <AlternatingRow Enabled="True" />
                        <CommandColumn Spacing="8px" />
                        <CommandColumnItem Cursor="pointer" />
                        <Header HorizontalAlign="Center" />
                    </Styles>
                </dxwgv:ASPxGridView>
                <br />
                <div class="centered" style="width: 80px">
                    <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                        <ClientSideEvents Click="function(s, e) { if (ASPxClientEdit.ValidateGroup()) { window.parent.hPanel.Set('PostUri', 'transfer.aspx'); window.parent.pcCompany.Show(); } }" />
                    </dxe:ASPxButton>
                </div>
            </div>
            <asp:SqlDataSource ID="dsTransfer" runat="server" />
        </form>
    </body>
</html>