<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="routing.aspx.vb" Inherits="SmartHR.routing" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
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
        <form id="_routing" runat="server">
            <dxcb:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) {
                    if (e.result.toLowerCase().indexOf('.aspx') != -1) {
                        window.parent.postUrl(e.result, false);
                    }
                }" />
            </dxcb:ASPxCallback>
            <div class="padding">
                <dxrp:ASPxRoundPanel ID="pnlRoute" runat="server" Width="100%">
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
                                    <dxwgv:GridViewDataTextColumn FieldName="CompanyNum" VisibleIndex="2" Visible=false />
                                    <dxwgv:GridViewDataTextColumn FieldName="EmployeeNum" VisibleIndex="3" Visible="false" />
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="WFLUID" Caption="Workflow" VisibleIndex="4">
                                        <PropertiesComboBox DataSourceID="dsWFLU" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Text" ValueField="ID" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="RouteToCompNum" Caption="Company (Route to)" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
                                        <PropertiesComboBox DataSourceID="dsRouteToCompNum" TextField="CompanyName" ValueField="CompanyNum">
                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { dgView.GetEditor(6).PerformCallback(s.GetValue().toString()); }" />
                                        </PropertiesComboBox>
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataComboBoxColumn FieldName="RouteToEmpNum" Caption="Employee" VisibleIndex="6">
                                        <PropertiesComboBox DataSourceID="dsRouteToEmpNum" TextField="Name" ValueField="EmployeeNum" />
                                    </dxwgv:GridViewDataComboBoxColumn>
                                    <dxwgv:GridViewDataDateColumn FieldName="From" Caption="From" VisibleIndex="7" />
                                    <dxwgv:GridViewDataDateColumn FieldName="Until" Caption="Until" VisibleIndex="8" />
                                    <dxwgv:GridViewDataCheckColumn FieldName="OnceOff" Caption="Run Once?" VisibleIndex="9" />
                                    <dxwgv:GridViewDataMemoColumn FieldName="Description" Caption="Description" VisibleIndex="10" />
                                    <dxwgv:GridViewDataTextColumn FieldName="CapturedBy" VisibleIndex="11" Visible="false" />
                                    <dxwgv:GridViewDataDateColumn FieldName="CapturedOn" VisibleIndex="12" Visible="false" />
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="submit" VisibleIndex="13" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="submit" Image-Url="images/accept.png" Text="Submit Routes" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                    <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="14" Width="16px">
                                        <CustomButtons>
                                            <dxwgv:GridViewCommandColumnCustomButton ID="delete" Image-Url="images/delete.png" Text="Delete Record" />
                                        </CustomButtons>
                                    </dxwgv:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { if (e.buttonID == 'delete') { window.parent.ExecDeleteCallback(s, e); } else { window.parent.lpPage.Show(); cpPage.PerformCallback('Submit\ ' + e.buttonID + '\ ' + e.visibleIndex.toString()); processOnServer = false; } }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                <SettingsEditing NewItemRowPosition="Bottom" />
                                <SettingsPager AlwaysShowPager="True" />
                                <Styles>
                                    <AlternatingRow Enabled="true" />
                                    <CommandColumn Spacing="8px" />
                                    <CommandColumnItem Cursor="pointer" />
                                    <Header HorizontalAlign="Center" />
                                    <StatusBar HorizontalAlign="Right" />
                                </Styles>
                                <Templates>
                                    <EditForm>
                                        <div style="padding: 5px; width: 100%">
                                            <dxwgv:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors" runat="server" />
                                        </div>
                                        <div style="text-align:right; padding: 5px">
                                            <span style="cursor: pointer; padding-right: 10px"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                            <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                        </div>
                                    </EditForm>
                                    <StatusBar>
                                        <img id="btnCreate" src="images/create.png" title="Create Record" onclick="dgView.AddNewRow();" style="cursor: pointer" />
                                    </StatusBar>
                                </Templates>
                            </dxwgv:ASPxGridView>
                        </dxp:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dxe:ASPxImage id="imgPanel" runat="server" ImageUrl="images/accept.png" />
                                </td>
                                <td>
                                    <dxe:ASPxLabel id="lblPanel" runat="server" Text="Task Routing & Maintenance" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dxrp:ASPxRoundPanel>
            </div>
            <asp:SqlDataSource ID="dsRouteToCompNum" runat="server" />
            <asp:SqlDataSource ID="dsRouteToEmpNum" runat="server" />
            <asp:SqlDataSource ID="dsWFLU" runat="server" />
        </form>
    </body>
</html>