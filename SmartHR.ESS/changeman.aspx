<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="changeman.aspx.vb" Inherits="SmartHR.changeman" ValidateRequest="false" %>
<%@ Register Assembly="DevExpress.Web.v11.1"              Namespace="DevExpress.Web.ASPxPanel"         TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1"              Namespace="DevExpress.Web.ASPxCallback"      TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1"              Namespace="DevExpress.Web.ASPxRoundPanel"    TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1"              Namespace="DevExpress.Web.ASPxHiddenField"   TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1"              Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1"  Namespace="DevExpress.Web.ASPxEditors"       TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1" Namespace="DevExpress.Web.ASPxGridView"      TagPrefix="dx" %>
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
            <dx:ASPxCallback ID="cpPage" runat="server" ClientInstanceName="cpPage">
                <ClientSideEvents CallbackComplete="function(s, e) { if (e.result.toLowerCase().indexOf('.aspx') != -1) { window.parent.postUrl(e.result, false); } }" />
            </dx:ASPxCallback>
            <div class="padding">
                <dx:ASPxRoundPanel ID="pnlChanges" runat="server" ClientInstanceName="pnlChanges" Width="100%">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxButton AutoPostBack="true" runat="server" ID="cmdDelete" ClientInstanceName="cmdDelete" ClientVisible="false"></dx:ASPxButton>
                            <br />
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Items for Approval" Font-Size="Medium" />
                            <dx:ASPxGridView ID="dgView_001" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="CompositeKey"     Visible="false" VisibleIndex="0" />
                                    <dx:GridViewDataTextColumn FieldName="PolicyID"         Visible="false" VisibleIndex="1" />
                                    <dx:GridViewDataTextColumn FieldName="Assembly"         Visible="false" VisibleIndex="2" />
                                    <dx:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="3" />
                                    <dx:GridViewDataTextColumn FieldName="DataType"         Visible="false" VisibleIndex="4" />
                                    <dx:GridViewDataTextColumn FieldName="Key"              Visible="false" VisibleIndex="5" />
                                    <dx:GridViewDataTextColumn FieldName="Label"  Caption="Item Name"    VisibleIndex="6" Width="25%" SortIndex="0" SortOrder="Ascending" />
                                    <dx:GridViewDataTextColumn FieldName="ValueF" Caption="Value (from)" VisibleIndex="7" Width="25%" />
                                    <dx:GridViewDataTextColumn FieldName="ValueT" Caption="Value (to)"   VisibleIndex="8" >
                                        <DataItemTemplate>
                                            <asp:PlaceHolder ID="phControls" runat="server" Visible="true" />
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Reject Application" VisibleIndex="9" Width="16px">
                                        <DeleteButton Text="Reject Application"></DeleteButton>
                                        <CustomButtons>
                                            <dx:GridViewCommandColumnCustomButton ID="delete" Image-Url="images/delete.png" Text="Delete Record" ><Image Url="images/delete.png"></Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } cmdDelete.DoClick(); }" />
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
                            </dx:ASPxGridView>
                            <br />
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Items to be Rejected" Font-Size="Medium" />
                            <dx:ASPxGridView ID="dgView_002" runat="server" ClientInstanceName="dgView" Width="100%" KeyFieldName="CompositeKey" EnableCallbackCompression="true" AutoGenerateColumns="False">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="CompositeKey"     Visible="false" VisibleIndex="0" />
                                    <dx:GridViewDataTextColumn FieldName="PolicyID"         Visible="false" VisibleIndex="1" />
                                    <dx:GridViewDataTextColumn FieldName="Assembly"         Visible="false" VisibleIndex="2" />
                                    <dx:GridViewDataTextColumn FieldName="AssemblyTypeName" Visible="false" VisibleIndex="3" />
                                    <dx:GridViewDataTextColumn FieldName="DataType"         Visible="false" VisibleIndex="4" />
                                    <dx:GridViewDataTextColumn FieldName="Key"              Visible="false" VisibleIndex="5" />
                                    <dx:GridViewDataTextColumn FieldName="Label"  Caption="Item Name"    VisibleIndex="6" Width="25%" SortIndex="0" SortOrder="Ascending" />
                                    <dx:GridViewDataTextColumn FieldName="ValueF" Caption="Value (from)" VisibleIndex="7" Width="25%" />
                                    <dx:GridViewDataTextColumn FieldName="ValueT" Caption="Value (to)"   VisibleIndex="8" >
                                        <DataItemTemplate>
                                            <asp:PlaceHolder ID="phControls" runat="server" Visible="true" />
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewCommandColumn ButtonType="Image" Name="delete" DeleteButton-Text="Accept Application" VisibleIndex="9" Width="16px">
                                        <DeleteButton Text="Accept Application"></DeleteButton>
                                        <CustomButtons>
                                            <dx:GridViewCommandColumnCustomButton ID="GridViewCommandColumnCustomButton1" Image-Url="images/accept.png" Text="Approve Record" ><Image Url="images/accept.png"></Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                </Columns>
                                <ClientSideEvents CustomButtonClick="function(s, e) { window.parent.ExecDeleteCallback(s, e); }" EndCallback="function(s, e) { if (s.cpCancelEdit) { s.CancelEdit(); } cmdDelete.DoClick(); }" />
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
                            </dx:ASPxGridView>
                            <br />
                            <table style="padding: 0px; width: 100%">
                                <tr>
                                    <td colspan="3" style="text-align: left"><dx:ASPxLabel ID="lblComments" runat="server" Text="Comments from Previous Actioners" Font-Bold="true" ClientInstanceName="lblComments" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: left"><dx:ASPxMemo ID="txtComments" runat="server" Height="50px" Width="100%" ClientInstanceName="txtComments" ReadOnly="true" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: left"><dx:ASPxLabel ID="lblRemarks" runat="server" Text="Remarks (add comments for the applicant):" Font-Bold="true" ClientInstanceName="lblRemarks" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: left"><dx:ASPxMemo ID="txtRemarks" runat="server" Height="50px" Width="100%" ClientInstanceName="txtRemarks" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br /></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
	                                    <asp:Table ID="tblButtons" runat="server" Width="100%">
		                                    <asp:TableRow>
			                                    <asp:TableCell HorizontalAlign="Right">
				                                    <dx:ASPxButton ID="cmdSubmit" runat="server" Text="Approve" Width="100px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { var xRemarks = txtRemarks.GetText(); var yRemarks = lblRemarks.GetText(); if (xRemarks == '' && yRemarks.indexOf('*') !== -1) { alert('Kindly write a comment on why some items were rejected.'); } else { window.parent.lpPage.Show(); cpPage.PerformCallback('Approve ' + xRemarks); } }" />                                
                                                    </dx:ASPxButton>
                                                </asp:TableCell>
			                                    <asp:TableCell Width="10px" />
			                                    <asp:TableCell HorizontalAlign="Center">
				                                    <dx:ASPxButton ID="cmdReturn" runat="server" Text="Return" Width="100px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { var xRemarks = txtRemarks.GetText(); if (xRemarks == '') { alert('Kindly write a comment on why the requested application is returned.'); } else { window.parent.lpPage.Show(); cpPage.PerformCallback('Return ' + xRemarks); } }" />
                                                    </dx:ASPxButton>
                                                </asp:TableCell>
			                                    <asp:TableCell Width="10px" />
			                                    <asp:TableCell HorizontalAlign="Left">
				                                    <dx:ASPxButton ID="cmdReject" runat="server" Text="Reject" Width="100px" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) { var xRemarks = txtRemarks.GetText(); if (xRemarks == '') { alert('Kindly write a comment on why the requested application is rejected.'); } else { window.parent.lpPage.Show(); cpPage.PerformCallback('Reject ' + xRemarks); } }" />                                    
                                                    </dx:ASPxButton>
                                                </asp:TableCell>
		                                    </asp:TableRow>
	                                    </asp:Table>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                    <HeaderTemplate>
                        <table style="height: 16px; width: 100%">
                            <tr valign="middle">
                                <td style="width: 20px">
                                    <dx:ASPxImage id="imgPanel" runat="server" ImageUrl="images/changes_001.png" />
                                </td>
                                <td>
                                    <dx:ASPxLabel id="lblPanel" runat="server" Text="Change Acceptance: (" />
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                </dx:ASPxRoundPanel>
            </div>
            <dx:ASPxHiddenField ID="items_saved" runat="server" ClientInstanceName="items_saved" />
        </form>
    </body>
</html>