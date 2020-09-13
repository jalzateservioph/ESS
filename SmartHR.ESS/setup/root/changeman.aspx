<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="changeman.aspx.vb" Inherits="SmartHR.changeman" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dxuc" %>
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
        <form id="_changeman" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                        if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                            window.parent.postUrl(e.result, false);
                        }
                    }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlChanges" runat="server" ClientInstanceName="pnlChanges" Width="100%">
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <dxwgv:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="false" VisibleIndex="0" />
                                    <dxwgv:GridViewDataTextColumn FieldName="PolicyID" Visible="false" VisibleIndex="1" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Assembly" Visible="false" VisibleIndex="2" />
                                    <dxwgv:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="3" />
                                    <dxwgv:GridViewDataTextColumn FieldName="DataType" Visible="false" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Key" Visible="false" VisibleIndex="5" />
                                    <dxwgv:GridViewDataTextColumn FieldName="Label" Caption="Item Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="6" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ValueF" Caption="Value (from)" VisibleIndex="7" />
                                    <dxwgv:GridViewDataTextColumn FieldName="ValueT" Caption="Value (to)" VisibleIndex="8">
                                        <DataItemTemplate>
                                            <asp:PlaceHolder ID="phControls" runat="server" Visible="true" />
                                        </DataItemTemplate>
                                    </dxwgv:GridViewDataTextColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="9" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete" Image-Url="images/delete.png" Text="Delete Record" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                    <Row HorizontalAlign="Left" />
                                    <PagerBottomPanel HorizontalAlign="Left" />
                                </Styles>
                            </dxwgv:ASPxGridView>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td colspan="3" style="text-align: left"><dxe:ASPxLabel ID="lblRemarks" runat="server" Text="Remarks (add comments for the applicant):" Font-Bold="true" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: left"><dxe:ASPxMemo ID="txtRemarks" runat="server" Height="75px" Width="100%" ClientInstanceName="txtRemarks" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: center">
                                        <div class="centered" style="width: 80px">
                                            <dxe:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit ' + txtRemarks.GetText()); }" />
                                            </dxe:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/changes_001.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Change Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <dxhf:ASPxHiddenField ID="items_saved" runat="server" ClientInstanceName="items_saved" />
        </form>
    </body>
</html>