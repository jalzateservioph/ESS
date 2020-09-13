<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="prFileImporter.aspx.vb" Inherits="SmartHR.prFileImporter" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTabControl" tagprefix="dx" %>

<%@ Register TagPrefix="dxp" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxClasses" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxUploadControl" tagprefix="dx" %>
<%@ Register TagPrefix="dxe" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register TagPrefix="dxrp" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 568px;
        }
        .auto-style3 {
            width: 75px;
        }
        .auto-style2 {
            width: 175px;
        }
        </style>
</head>
<body onload="window.parent.reset();">
    <form id="form1" runat="server">
    <div>
    <dx:ASPxPanel ID="ASPxPanel1" runat="server">
            <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
    <dx:ASPxPageControl ID="tabMenu" runat="server" ActiveTabIndex="0" Width="100%" AutoPostBack="True">
        <TabPages>
            <dx:TabPage Name="tbFileImporter" Text="Import Attendance and Performance" >
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        
                        <dx:ASPxRoundPanel ID="basePanel" runat="server" HeaderText="Select Excel files to be uploaded." Height="100%" Width="100%">
                            <HeaderStyle Font-Bold="True" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxPanel ID="Layer1" runat="server" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table>
                                                    <tr>
                                                        <td style="margin-left: 40px">
                                                            <dx:ASPxUploadControl ID="ucPerformanceAbility" runat="server" Font-Bold="True" Width="318px">
                                                                <ValidationSettings AllowedFileExtensions=".xls, .xlsx" ShowErrors="False">
                                                                </ValidationSettings>
                                                            </dx:ASPxUploadControl>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <dx:ASPxButton ID="btnUploadPA" runat="server" Font-Bold="True" Text="Upload" Width="100%" Height="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                        <td>

                                                        </td>
                                                        <td>
                                                            <dx:ASPxButton ID="btnDownloadTemplate" runat="server" Font-Bold="True" Height="100%" Text="Download Template" Width="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5">
                                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Note: Rate type must be Attendance, Midyear or Yearend Only." ForeColor="#990000"></dx:ASPxLabel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                    <dx:ASPxPanel ID="layer2" runat="server" Height="55px" Visible="False" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table>
                                                    <tr>
                                                        <td class="auto-style3">
                                                            <asp:Label ID="lblFileNamePA" runat="server" ForeColor="#1C5500" Text="FileName:" Visible="False" Width="100%"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style3">
                                                            <asp:Label ID="lblSelect" runat="server" Text="Select Sheet:    "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxComboBox ID="cbSheetPA" runat="server" AutoPostBack="True">
                                                            </dx:ASPxComboBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;</td>
                                                        <td></td>
                                                        <td>
                                                            <dx:ASPxButton ID="btnBack" runat="server" Font-Bold="True" Text="Back" Width="100px">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                    <dx:ASPxPanel ID="layer3" runat="server" Visible="False" Width="100%">
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                <table style="width: 127px">
                                                    <tr>
                                                        <td class="auto-style2">
                                                            <dx:ASPxButton ID="btnSavePA" runat="server" Font-Bold="True" Text="Update" Width="100%">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <dx:ASPxGridView ID="gridPA" runat="server" Width="100%">
                                                    <SettingsPager PageSize="7">
                                                    </SettingsPager>
                                                </dx:ASPxGridView>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>     
             
                       <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="#990000" Width="100%" Visible="False"></asp:Label>   
                        
                    <div class="info_container" >
                        <table cellpadding="10px" cellspacing="10px" align="center">
                        <tr>
                            <td>
                                <dxrp:ASPxRoundPanel ID="AbilityRating" runat="server" Width="750px">
                                    <PanelCollection>
                                        <dxp:PanelContent ID="PanelContent1" runat="server">
                                        <dx:ASPxGridView ID="dgView_Ability" runat="server" ClientInstanceName="dgView_Ability" Width="100%" KeyFieldName="ID" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }"></ClientSideEvents>
                                        <Columns>
                                        <dx:GridViewCommandColumn ButtonType="Image" Name="edit" CancelButton-Text="Cancel Changes" EditButton-Text="Edit Record" UpdateButton-Text="Update Record" VisibleIndex="0" Width="16px">
                                        <EditButton Visible="True">
                                        <Image Url="images/edit.png" />
                                        <Image Url="images/edit.png"></Image>
                                        </EditButton>
                                        <CancelButton Visible="True">
                                        <Image Url="images/cancel.png" />
                                        <Image Url="images/cancel.png"></Image>
                                        </CancelButton>
                                        <UpdateButton Visible="True">
                                        <Image Url="images/update.png" />
                                        <Image Url="images/update.png"></Image>
                                        </UpdateButton>
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="ID" Visible="false" VisibleIndex="1" />
                                        <dx:GridViewDataTextColumn FieldName="Period_From" Caption="Period From" VisibleIndex="2" />
                                        <dx:GridViewDataTextColumn FieldName="Period_To" Caption="Period To" VisibleIndex="3" />
                                        <dx:GridViewDataTextColumn FieldName="Man_No" Caption="Employee Code" VisibleIndex="4" />
                                        <dx:GridViewDataTextColumn FieldName="Rate_Code" Caption="Rating" VisibleIndex="5" />
                                        <dx:GridViewDataTextColumn FieldName="Rate_Type" Caption="Rating Type" VisibleIndex="6" />
                                        <dx:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Delete Record" VisibleIndex="7" Width="16px"><DeleteButton Text="Delete Record"></DeleteButton>
                                        <CustomButtons>
                                        <dx:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton1" Image-Url="images/delete.png" Text="Delete Record" ><Image Url="images/delete.png"></Image>
                                        </dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                        </dx:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } }" />
                                        <Settings ShowHeaderFilterButton="true" ShowFilterBar="Visible" ShowStatusBar="Visible" />
                                        <SettingsEditing NewItemRowPosition="Bottom" />
                                        <SettingsPager AlwaysShowPager="True" />
                                        <Styles>
                                        <AlternatingRow Enabled="true" />
                                        <CommandColumn Spacing="8px" />
                                        <CommandColumnItem Cursor="pointer" />
                                        <Header HorizontalAlign="Center"></Header>
                                        <AlternatingRow Enabled="True"></AlternatingRow>
                                        <CommandColumn Spacing="8px"></CommandColumn>
                                        <CommandColumnItem Cursor="pointer"></CommandColumnItem>
                                        </Styles>
                                        <Templates>
                                            <EditForm>
                                                <div style="padding: 5px; width: 100%">
                                                    <dx:ASPxGridViewTemplateReplacement ID="Editors_001" ReplacementType="EditFormEditors" runat="server" />
                                                </div>
                                                <div style="text-align:right; padding: 5px">
                                                    <span style="cursor: pointer; padding-right: 10px"><dx:ASPxGridViewTemplateReplacement ID="UpdateButton_001" ReplacementType="EditFormUpdateButton" runat="server" /></span>
                                                    <span style="cursor: pointer"><dx:ASPxGridViewTemplateReplacement ID="CancelButton_001" ReplacementType="EditFormCancelButton" runat="server" /></span> 
                                                </div>
                                            </EditForm>
                                            <StatusBar>
                                            <table style="padding: 2px; width: 100%">
                                            <tr>
                                            <td></td>
                                            <td style="width: 80px">
                                            <dxe:ASPxButton ID="cmdCreate_Ess" runat="server" ClientInstanceName="cmdCreate_Ess" AutoPostBack="false" ForeColor="Black" Height="25px" Text="Create" Width="80px">
                                            <ClientSideEvents Click="function(s, e) { dgView_Ability.AddNewRow(); }" />
                                            </dxe:ASPxButton>
                                            </td>
                                            <td style="width: 10px" />
                                            </tr>
                                            </table>
                                            </StatusBar>
                                        </Templates>
                                        </dx:ASPxGridView>
                                        </dxp:PanelContent>
                                    </PanelCollection>
                                <HeaderTemplate>
                                    <table style="height: 16px; width: 100%">
                                        <tr valign="middle">
                                            <td style="width: 20px">
                                                <dxe:ASPxImage id="imgPanel_001" runat="server" ImageUrl="images/personal_004.png" />
                                            </td>
                                            <td>
                                                <dxe:ASPxLabel id="lblPanel_001" runat="server" Text="Ratings" />
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                </dxrp:ASPxRoundPanel>
                            </td>
                        </tr>
                        </table>
                    </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Import Promotion History">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Import Infractions">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="tbReports" Text="Performance and Promotions Report">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
            </dx:PanelContent>
</PanelCollection>
        </dx:ASPxPanel>
    </div>
        
        <dx:ASPxPopupControl ID="popup" runat="server" Modal="True" ShowFooter="false" ShowSizeGrip="True"  HeaderText="Information" RenderMode="Lightweight" Width="450px">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
                    <table style="width:100%;">
                        <tr>
                            <td align="center">
                                <dx:ASPxLabel ID="popuplabel" runat="server" Text="popuplabel"></dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="OK"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <asp:SqlDataSource ID="ds_Ability" runat="server" />
    </form>
</body>
</html>
