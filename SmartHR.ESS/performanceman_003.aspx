<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_003.aspx.vb" Inherits="SmartHR.performanceman_003" %>

<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dxlp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v11.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>performanceman_003</title>
        <link href="styles/devstyles.css" rel="stylesheet" type="text/css" />
    </head>
    <body onload="window.parent.reset();">
        <form id="_performanceman_003" runat="server">
            <dxlp:ASPxLoadingPanel ID="lpPage" runat="server" ClientInstanceName="lpPage" Modal="true" />
            <div class="padding">
                <dxcp:ASPxCallbackPanel ID="cpPage" runat="server" ClientInstanceName="cpPage" HideContentOnCallback="false" ShowLoadingPanel="false">
                    <ClientSideEvents EndCallback="function(s, e) { lpPage.Hide(); }" />
                    <PanelCollection>
                        <dxp:PanelContent runat="server">
                            <div style="text-align: left">
                                <dxpc:ASPxPopupControl ID="pcError" runat="server" CloseAction="CloseButton" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false" ClientInstanceName="pcError">
                                    <ContentCollection>
                                        <dxpc:PopupControlContentControl runat="server">
                                            <table cellpadding="0" style="text-align: center; width: 250px">
                                                <tr>
                                                    <td style="text-align: center"><dxe:ASPxLabel ID="lblError_Error" runat="server" ClientInstanceName="lblError_Error" /></td>
                                                </tr>
                                                <tr>
                                                    <td><br /></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        <dxe:ASPxButton ID="cmdOK_Error" runat="server" Text="OK" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcError.Hide(); }" />
                                                        </dxe:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </dxpc:PopupControlContentControl>
                                    </ContentCollection>
                                    <HeaderTemplate>
                                        <table style="height: 20px; width: 100%">
                                            <tr>
                                                <td style="padding-top: 4px; width: 16px"><dxe:ASPxImage id="imgPopup" runat="server" ImageUrl="~/images/information.png" /></td>
                                                <td style="padding-top: 4px"><dxe:ASPxLabel id="lblPopup" runat="server" Text="Information" Font-Bold="true" /></td>
                                                <td style="cursor: pointer; padding-top: 4px; width: 18px">
                                                    <dxe:ASPxImage id="imgClose" runat="server" ImageUrl="~/App_Themes/Aqua/Web/pcCloseButton.png">
                                                        <ClientSideEvents Click="function(s, e) { pcError.Hide(); }" />
                                                    </dxe:ASPxImage>
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                </dxpc:ASPxPopupControl>
                                <div style="text-align: left">
                                    <table style="padding: 0px 0px 0px 0px; width: 100%">
                                        <tr>
                                            <td style="text-align: right; width: 135px"><dxe:ASPxLabel ID="lblKA" runat="server" Text="Key Areas" Font-Bold="true" /></td>
                                            <td><hr /></td>
                                        </tr>
                                    </table>
                                    <dxwgv:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView_001" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <Columns>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" VisibleIndex="0" Width="16px">
                                                <EditButton Visible="True">
                                                    <Image Url="~/images/edit.png" />
                                                </EditButton>
                                                <CancelButton Visible="True">
                                                    <Image Url="~/images/cancel.png" />
                                                </CancelButton>
                                                <UpdateButton Visible="True">
                                                    <Image Url="~/images/update.png" />
                                                </UpdateButton>
                                            </dxwgv:GridViewCommandColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="False" VisibleIndex="1" />
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="ClassCode" Caption="Class Code" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="dsClassCode" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="ClassName" ValueField="ClassCode" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="KPACode" Caption="Code" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="dsKPACode" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="KPAName" ValueField="KPACode" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataTextColumn FieldName="KPAName" Caption="Name" VisibleIndex="4" />
                                            <dxwgv:GridViewDataMemoColumn FieldName="Remarks" Caption="Description" VisibleIndex="5" Visible="false" />
                                            <dxwgv:GridViewDataTextColumn FieldName="Target" Caption="Target" VisibleIndex="6">
                                                <PropertiesTextEdit MaxLength="100" />
                                            </dxwgv:GridViewDataTextColumn>
                                            <dxwgv:GridViewDataComboBoxColumn FieldName="RangeType" Caption="Range Type" VisibleIndex="7">
                                                <PropertiesComboBox DataSourceID="dsRangeType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Description" ValueField="RangeType" />
                                            </dxwgv:GridViewDataComboBoxColumn>
                                            <dxwgv:GridViewDataSpinEditColumn FieldName="Weight" Caption="Weight" VisibleIndex="8">
                                                <PropertiesSpinEdit NumberFormat="Percent" NumberType="Float" />
                                            </dxwgv:GridViewDataSpinEditColumn>
                                            <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" VisibleIndex="9" Width="16px">
                                                <DeleteButton Visible="True">
                                                    <Image Url="~/images/delete.png" />
                                                </DeleteButton>
                                            </dxwgv:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsBehavior ConfirmDelete="True" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" />
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
                                            <DetailRow>
                                                <table style="padding: 0px 0px 0px 0px; width: 100%">
                                                    <tr>
                                                        <td style="text-align: right; width: 175px"><dxe:ASPxLabel ID="lblCSE" runat="server" Text="Critical Success Elements" Font-Bold="true" /></td>
                                                        <td style="width: 10px"></td>
                                                        <td><hr /></td>
                                                    </tr>
                                                </table>
                                                <dxwgv:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView_002" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False" OnCancelRowEditing="dgView_001_CancelRowEditing" OnCustomJSProperties="dgView_001_CustomJSProperties" OnRowDeleting="dgView_001_RowDeleting" OnRowInserting="dgView_001_RowInserting" OnRowUpdating="dgView_001_RowUpdating" OnRowValidating="dgView_001_RowValidating">
                                                    <Columns>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="edit" VisibleIndex="0" Width="16px">
                                                            <EditButton Visible="True">
                                                                <Image Url="~/images/edit.png" />
                                                            </EditButton>
                                                            <CancelButton Visible="True">
                                                                <Image Url="~/images/cancel.png" />
                                                            </CancelButton>
                                                            <UpdateButton Visible="True">
                                                                <Image Url="~/images/update.png" />
                                                            </UpdateButton>
                                                        </dxwgv:GridViewCommandColumn>
                                                        <dxwgv:GridViewDataTextColumn FieldName="CompositeKey" Visible="False" VisibleIndex="1" />
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="CSEName" Caption="Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                                                            <PropertiesComboBox DataSourceID="dsCSEName" DropDownStyle="DropDown" EnableIncrementalFiltering="True" TextField="CSEName" ValueField="CSEName" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="Remarks" Caption="Description" VisibleIndex="3" Visible="false" />
                                                        <dxwgv:GridViewDataTextColumn FieldName="Target" Caption="Target" VisibleIndex="4">
                                                            <PropertiesTextEdit MaxLength="100" />
                                                        </dxwgv:GridViewDataTextColumn>
                                                        <dxwgv:GridViewDataComboBoxColumn FieldName="RangeType" Caption="Range Type" VisibleIndex="5">
                                                            <PropertiesComboBox DataSourceID="dsRangeType" DropDownStyle="DropDownList" EnableIncrementalFiltering="True" TextField="Description" ValueField="RangeType" />
                                                        </dxwgv:GridViewDataComboBoxColumn>
                                                        <dxwgv:GridViewDataSpinEditColumn FieldName="Weight" Caption="Weight" VisibleIndex="6">
                                                            <PropertiesSpinEdit NumberFormat="Percent" NumberType="Float" />
                                                        </dxwgv:GridViewDataSpinEditColumn>
                                                        <dxwgv:GridViewCommandColumn ButtonType="Image" Name="delete" VisibleIndex="7" Width="16px">
                                                            <DeleteButton Visible="True">
                                                                <Image Url="~/images/delete.png" />
                                                            </DeleteButton>
                                                        </dxwgv:GridViewCommandColumn>
                                                    </Columns>
                                                    <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } if (s.cpRefreshDelete) { s.Refresh(); } }" />
                                                    <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                                    <SettingsBehavior ConfirmDelete="True" />
                                                    <SettingsDetail IsDetailGrid="true" />
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
                                                                <div style="width: 100%">
                                                                    <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_002" ReplacementType="EditFormEditors" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div style="text-align:right; padding: 5px">
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_002" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                                <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_002" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                            </div>
                                                        </EditForm>
                                                        <StatusBar>
                                                            <img id="btnAdd_002" src="images/create.png" title="New" onclick="dgView_002.AddNewRow();" style="cursor: pointer" />
                                                        </StatusBar>
                                                    </Templates>
                                                </dxwgv:ASPxGridView>
                                            </DetailRow>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <div style="width: 100%">
                                                        <dxwgv:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                    </div>
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dxwgv:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                                <img id="btnAdd_001" src="images/create.png" title="New" onclick="dgView_001.AddNewRow();" style="cursor: pointer" />
                                            </StatusBar>
                                        </Templates>
                                    </dxwgv:ASPxGridView>
                                </div>
                                <br />
                                <div style="text-align: right; width: 100%">
                                    <dxe:ASPxButton ID="cmdReturn" runat="server" Text="Return to Evaluation">
                                        <ClientSideEvents Click="function(s, e) { lpPage.Show(); }" />
                                    </dxe:ASPxButton>
                                </div>
                            </div>
                        </dxp:PanelContent>
                    </PanelCollection>
                </dxcp:ASPxCallbackPanel>
            </div>
            <asp:SqlDataSource ID="dsClassCode" runat="server" />
            <asp:SqlDataSource ID="dsKPACode" runat="server" />
            <asp:SqlDataSource ID="dsCSEName" runat="server" />
            <asp:SqlDataSource ID="dsRangeType" runat="server" />
		</form>
    </body>
</html>