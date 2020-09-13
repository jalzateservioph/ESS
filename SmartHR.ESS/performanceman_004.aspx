<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_004.aspx.vb"
    Inherits="SmartHR.performanceman_004" ValidateRequest="false" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="scripts/jquery-1.4.2-vsdoc.js"></script>
    <script src="scripts/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
    <script language="javascript" type="text/javascript">
        var CurrentItem = 0;
        function copy(f, s, c) {
            if (s.GetItemCount() == 0) {
                var item;
                s.BeginUpdate();
                for (var x = 0; x < c; x++) {
                    item = f.GetItem(x);
                    s.AddItem(item.text, item.value);
                }
                s.EndUpdate();
                s.ShowDropDown();
            }
        }

        $(document).ready(function () {
            AlterColumnWidth();
        });
        function AlterColumnWidth() {
            document.getElementById("pnlEvaluations_dgView_col0").style.width = "5%";
            document.getElementById("pnlEvaluations_dgView_col2").style.width = "45%";
            document.getElementById("pnlEvaluations_dgView_col12").style.width = "10%";
            document.getElementById("pnlEvaluations_dgView_col13").style.width = "20%";
            document.getElementById("pnlEvaluations_dgView_col14").style.width = "20%";

            document.getElementById("pnlEvaluations_dgView_DXDataRow0").style.width = "5%";
            document.getElementById("pnlEvaluations_dgView_tccell0_2").style.width = "45%";
            document.getElementById("pnlEvaluations_dgView_tccell0_12").style.width = "10%";
            document.getElementById("pnlEvaluations_dgView_tccell0_13").style.width = "20%";
            document.getElementById("pnlEvaluations_dgView_tccell0_14").style.width = "20%";
        }
    </script>
</head>
<body onload="window.parent.reset(); prgIndicator.GetProgressBar().GetIndicatorDiv().style.background = '#FCF141';">
    <%--Open Dialog Window for Objective Review--%>
    <script type="text/javascript">

       function SubmitForm() {
           if(confirm("Are you sure you want to submit?"))
           {
                window.parent.lpPage.Show();
                var now = new Date();
                var now = (now.getMonth() + 1) + '/' + now.getDate() + '/' +  now.getFullYear() + ' ' + now.getMonth() + ':' + now.getMinutes() + ':' + now.getSeconds();
                // alert(now);
                cpPage.PerformCallback("Submit;" + now );
                alert('Thank you for participating in the TMP Workplace Survey. Your responses have been successfully uploaded. Rest assured all responses shall be handled with utmost confidentiality.');
            }
            else
            {
                alert('Cancelled');
            }
        }

         
    </script>
    <%--End Open Dialog Window for Objective Review--%>
    <form id="_performance_004" runat="server">
    <dx:ASPxHiddenField ID="hPanel" runat="server" ClientInstanceName="hPanel" />
    <dx:ASPxPopupControl ID="pcRemarks" runat="server" CloseAction="CloseButton" Modal="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" EnableAnimation="false"
        ClientInstanceName="pcRemarks" HeaderText="Note" HeaderStyle-Font-Bold="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div class="centered" style="width: 350px">
                    <asp:Table ID="tblRemarks" runat="server" Width="350px">
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                                <dx:ASPxMemo ID="txtRemarks" runat="server" ClientInstanceName="txtRemarks" Width="325px"
                                    Height="125px" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="3">
                                        <br />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Right">
                                <dx:ASPxButton ID="cmdOK" runat="server" ClientInstanceName="cmdOK" Text="OK" Width="80px"
                                    AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { items_001.Set('row_' + hPanel.Get('Index').toString(), txtRemarks.GetText()); pcRemarks.Hide(); if(!hPanel.Get('DisableAutoSave')) { window.parent.lpPage.Show(); cpPage.PerformCallback('SaveItem\ ' + hPanel.Get('Index').toString() + '\ NOTES\ ' + txtRemarks.GetText()); } }" />
                                </dx:ASPxButton>
                            </asp:TableCell>
                            <asp:TableCell Width="10px">
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <dx:ASPxButton ID="cmdCancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                    <ClientSideEvents Click="function(s, e) { pcRemarks.Hide(); }" />
                                </dx:ASPxButton>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents PopUp="function(s, e) { txtRemarks.SetText(items_001.Get('row_' + hPanel.Get('Index').toString())); txtRemarks.Focus(); }" />
    </dx:ASPxPopupControl>
    &nbsp;<div class="padding">
        <dx:ASPxRoundPanel ID="pnlEvaluations" runat="server" ClientInstanceName="pnlEvaluations"
            Width="100%">
            <PanelCollection>
                
                <dx:PanelContent runat="server">
                    <table width="100%">
                        <tr>
                            <td>
                                <dx:ASPxButton ID="btnExpandCollapse" runat="server" Text="Hide instruction" AllowFocus="False" AutoPostBack="False" Width="100px">
                                <Paddings Padding="1px" />
                                <FocusRectPaddings Padding="0" />
                                <ClientSideEvents Click="function(s, e) { var isVisible = rpanel1a.GetVisible();s.SetText(isVisible ? 'Show instruction' : 'Hide instruction'); rpanel1a.SetVisible(!isVisible);}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                
                                <dx:ASPxRoundPanel ID="rpanel1" runat="server" ClientInstanceName="rpanel1a" Width="100%"
                                    ShowHeader="False">
                                    <PanelCollection>
                                        <dx:PanelContent ID="pc1" runat="server">
                                        <table width="100%">
                                            <tr id="trInstructions">
                                                <td width="50%">
                                                    <dx:ASPxLabel ID="lblInstruction" runat="server" Text="Instruction"></dx:ASPxLabel>
                                                </td>
                                                <td width="50%">
                                                    <asp:Label ID="lblPosition" runat="server" Text="Position:"></asp:Label><br />
                                                    <asp:Label ID="lblDepartment" runat="server" Text="Department:"></asp:Label><br />
                                                    <asp:Label ID="lblSection" runat="server" Text="Section:"></asp:Label><br />
                                                    <asp:Label ID="lblDivision" runat="server" Text="Division: "></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                            </td>
                        </tr>
                    </table>
                    
                    <dx:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" KeyFieldName="CompositeKey"
                        EnableCallbackCompression="true" Width="100%" AutoGenerateColumns="False" Settings-UseFixedTableLayout="False" Settings-VerticalScrollableHeight="300" Settings-VerticalScrollBarStyle="Standard" Settings-ShowVerticalScrollBar="True">
                        <ClientSideEvents CustomButtonClick="function(s, e) { e.processOnServer = false; hPanel.Set(&#39;Index&#39;, e.visibleIndex); pcRemarks.Show(); }">
                        </ClientSideEvents>
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="№" FieldName="Count" Width="5%" ReadOnly="True" UnboundType="String" 
                                VisibleIndex="0">
                                <Settings AllowAutoFilter="False" AllowAutoFilterTextInputTimer="False" 
                                    AllowDragDrop="False" AllowGroup="False" AllowHeaderFilter="False" 
                                    AllowSort="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Name" CellStyle-Font-Size="Large" Caption="Question" VisibleIndex="2" Width="40%" >
                                <DataItemTemplate>                                    
                                    <dx:ASPxLabel ID="lblQuestion" Font-Size="Medium" runat="server"  Width="100%" ClientVisible='True' Visible="true" />                                   
                                </DataItemTemplate>

<CellStyle Font-Size="Large"></CellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="RangeType" VisibleIndex="3" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="4" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="ObtainBy" VisibleIndex="5" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="6" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="RatingPercentage" VisibleIndex="7" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Score" VisibleIndex="8" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="9" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="10" Visible="false" />
                            <dx:GridViewDataCheckColumn FieldName="Required" VisibleIndex="11" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Prev" Name="Prev" Caption="Previous </br> Response" Width="10%" VisibleIndex="12" Visible="true" CellStyle-HorizontalAlign="Center" CellStyle-VerticalAlign="Middle">                             
                             <DataItemTemplate>                                    
                                    <dx:ASPxLabel ID="lblPrev" runat="server"  Width="100%" ClientVisible='True' Visible="true" />                                   
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Answers" Name="Answers" Caption="Response"
                                VisibleIndex="13" Width="20%">
                                <DataItemTemplate>
                                        <dx:ASPxPanel ID="pnlAnswers" ClientEnabled="true" runat="server" ClientVisible="false" />
                                        <dx:ASPxComboBox ID="cmbAnswers" runat="server" EnableIncrementalFiltering="true"
                                            DropDownStyle="DropDownList" TextField="ElementName" ValueField="FromPerc" Width="100%"
                                            Visible="false" ClientVisible="false">
                                            <ClientSideEvents Init="function(s, e) { for (i = 0; i < s.GetItemCount(); i++) { var item2 = s.listBox.GetItemElement(i); item2.title = s.GetItem(i).text; } }" />
                                        </dx:ASPxComboBox>
                                        <dx:ASPxMemo ID="txtAnswers" runat="server" ClientEnabled="true" Rows="5" Width="100%" ClientVisible="false" />
                                        <dx:ASPxDateEdit ID="dteAnswers" runat="server" EditFormat="Custom" Width="100%"
                                            Visible="false" />
                                        <dx:ASPxSpinEdit ID="spAnswers" runat="server" NumberType="Float" DecimalPlaces="2"
                                            Visible="false" />
                                        <dx:ASPxCheckBox ID="chkAnswers" runat="server" Visible="false" />
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                             <dx:GridViewDataTextColumn FieldName="StickyNotes" Width="20%" Caption="Comment" VisibleIndex="14" Visible="true" >
                                <DataItemTemplate>                                    
                                    <dx:ASPxMemo ID="memoStickyNotes" Visible="false" runat="server" Rows="5" Width="100%" />                                   
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Answers_010" Caption="Response" VisibleIndex="15" />
                            <dx:GridViewDataTextColumn FieldName="Answers_011" Caption="Response" VisibleIndex="16" />
                            <dx:GridViewDataTextColumn FieldName="Answers_012" Caption="Response" VisibleIndex="17" />
                            <dx:GridViewDataTextColumn FieldName="Desc" VisibleIndex="18" Visible="false" />
                        </Columns>
                        <ClientSideEvents CustomButtonClick="function(s, e) { e.processOnServer = false; hPanel.Set('Index', e.visibleIndex); pcRemarks.Show(); }" />
                        <SettingsBehavior AllowDragDrop="false" AllowSort="false" />

<Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="300"></Settings>

                        <SettingsCookies StoreColumnsVisiblePosition="false" />
                        <SettingsPager AlwaysShowPager="false" Mode="ShowAllRecords" />
                        <SettingsBehavior AllowDragDrop="False" AllowSort="False"></SettingsBehavior>
                        <SettingsPager Mode="ShowAllRecords">
                        </SettingsPager>
                        <SettingsCookies StoreColumnsVisiblePosition="False"></SettingsCookies>
                        <Styles>
                            <CommandColumn Spacing="8px" />
                            <CommandColumnItem Cursor="pointer" />
                            <Header CssClass="upper" Font-Bold="true" Font-Names="Arial Rounded MT Bold" Font-Size="10pt"
                                HorizontalAlign="Center" />
                            <Header HorizontalAlign="Center" CssClass="upper" Font-Bold="True" Font-Names="Arial Rounded MT Bold"
                                Font-Size="10pt">
                            </Header>
                            <CommandColumn Spacing="8px">
                            </CommandColumn>
                            <CommandColumnItem Cursor="pointer">
                            </CommandColumnItem>
                        </Styles>
                    </dx:ASPxGridView>
                    <br />
                    <center>
                        <div class="centered" style="width: 100%">
                            <table style="width: 100%" runat="server" id="tableSub">
                                <tr align="center">
                                    <td colspan="2">
                                        <dx:ASPxHiddenField ID="items_001" runat="server" ClientInstanceName="items_001" />
                                        <dx:ASPxCallbackPanel ID="cpPage" runat="server"  ClientInstanceName="cpPage" HideContentOnCallback="false" ShowLoadingPanel="false" LoadingPanelStyle-Wrap="True" LoadingPanelText="test test"><%-- enter submission confirmation --%>
                                            <ClientSideEvents EndCallback="function(s, e){ if(s.cpDidAutoSave){window.parent.frames[0].lblAutoSaveProgress.SetText('Progress Saved');}prgIndicator.SetPosition(s.cpProgVal);  if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } if (s.cpRedirectURL.length != 0) { window.parent.postUrl(s.cpRedirectURL, false); } if (s.cpExecPrint) { window.open('reportsview.aspx?params=' + hPanel.Get('params').toString(), 'open'); } else { if (s.cpSavedText.length != 0 && !s.cpDidAutoSave) { window.parent.ShowPopup(s.cpSavedText); } } if(s.cpProgVal == 100){cmdSubmit.SetEnabled(true);}else{cmdSubmit.SetEnabled(false);}}" />
                                            
<LoadingPanelStyle Wrap="True"></LoadingPanelStyle>
                                            
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent2" runat="server">
                                                    
                                                    <table>
                                                        <tr>
                                                            <td align="right" style="width: 49%">
                                                                <table id="tblSave" runat="server">
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxButton ID="cmdSave" runat="server" Text="Save" Width="80px" Visible="false">
                                                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback('Save'); }" />
                                                                                <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); cpPage.PerformCallback(&#39;Save&#39;); }">
                                                                                </ClientSideEvents>
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxButton ID="cmdSubmit"  runat="server" Text="Submit" Width="80px" AutoPostBack="false"
                                                                                ClientInstanceName="cmdSubmit" >
                                                                                <ClientSideEvents Click="function(s, e) { SubmitForm(); }"></ClientSideEvents>
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td align="left" style="width: 49%">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxButton ID="cmdAppraise" runat="server" Text="Reject" Width="80px" AutoPostBack="false"
                                                                                ClientInstanceName="cmdAppraise" ClientVisible="false">
                                                                                <ClientSideEvents Click="function(s, e) { RejectForm(); }"></ClientSideEvents>
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxButton ID="cmdAppraise2" ClientVisible="false" runat="server" Text="Send Back to Employee" Width="170px"
                                                                                AutoPostBack="false" ClientInstanceName="cmdAppraise2">
                                                                                <ClientSideEvents Click="function(s, e) { RejectForm2(); }"></ClientSideEvents>
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                            <%-- <ClientSideEvents EndCallback="function(s, e) { if (s.cpCalculateScore) { window.parent.frames[0].lblScore.SetText(s.cpScore); } if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } if (s.cpRedirectURL.length != 0) { window.parent.postUrl(s.cpRedirectURL, false); } if (s.cpExecPrint) { window.open('reportsview.aspx?params=' + hPanel.Get('params').toString(), 'open'); } else { if (s.cpSavedText.length != 0) { window.parent.ShowPopup(s.cpSavedText); } } EnableDisableButtons(); }" />--%>
                                        </dx:ASPxCallbackPanel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </center>
                </dx:PanelContent>
            </PanelCollection>
            <HeaderTemplate>
                <table style="height: 16px; width: 100%">
                    <tr valign="middle">
                        <td style="width: 20px">
                            <dx:ASPxImage ID="imgPanel" runat="server" ImageUrl="images/performance_007.png" />
                        </td>
                        <td>
                            <dx:ASPxLabel ID="lblPanel" runat="server" Text="Evaluation: (" />
                        </td>
                            
                        <td>
                        </td>
                        <td style="width:50%">
                            <dx:ASPxProgressBar ID="progIndicator"  EnableTheming="false" ClientInstanceName="prgIndicator" Width="100%" runat="server" />
                         </td>
                    </tr>
                </table>
            </HeaderTemplate>
        </dx:ASPxRoundPanel>
        <asp:Label runat="server" ID="lblItem"></asp:Label>
        <input type="text" id="lblComment" style="display: none;" />
        <input type="text" id="lblMess1" style="display: none;" />

    </div>
    </form>
</body>
</html>
</dx:panelcontent> </dx:aspxroundpanel> </dx:panelcontent> 