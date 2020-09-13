<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="performanceman_002.aspx.vb"
    Inherits="SmartHR.performanceman_002" ValidateRequest="false" %>

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
    <link rel="icon" href="favicon.ico" type="image/ico" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="styles/index.css" rel="stylesheet" type="text/css" />
    <title>SmartHR (Employee Self Service)</title>
    <script language="javascript" type="text/javascript">
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
  
    </script>
</head>
<body onload="window.parent.reset(); EnableDisableButtons();">
    <%--Open Dialog Window for Objective Review--%>
    <script type="text/javascript">
        function getQuerystring() {
            window.showModalDialog("http://172.17.10.67/SwirePerfEval/EvaluationFrame.aspx?PathID=<%=Session.Contents("PathID")%>&CurrentUser=<%=Session.Contents("CurrentUser")%>&EvalScheme=<%=Session.Contents("EvalScheme")%>", "window1", "dialogHeight: 700px;dialogWidth: 1150px;");
            window.location.href = window.location.href;
        }
       function SubmitForm() {
            window.parent.lpPage.Show();
            cpPage.PerformCallback("Submit");
        }

         function RejectForm() {
            window.parent.lpPage.Show();
            cpPage.PerformCallback("Reject2");

            if(lblCommentNLMan.Get("lblCommentNLMan") == "" || lblRatingNLMan.Get("lblRatingNLMan") == ""){
                cmdSubmit.SetEnabled(false);
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage6").innerHTML = SetMessage6.Get("SetMessage6");
            }

            if(lblRatingNLMan.Get("lblRatingNLMan").toUpperCase() == "DISAGREE"){
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4");
            }
        }

         function RejectForm2() {
            var lblScheme = '<%=Session.Contents("EvalScheme")%>';
            if(lblScheme != "SGP" && lblScheme != "MYE") {
                if(lblRatingEmp.Get("lblRatingEmp").toUpperCase() == "DISAGREE" || lblRatingMan.Get("lblRatingMan").toUpperCase() == "DISAGREE" ||  lblRatingNLMan.Get("lblRatingNLMan").toUpperCase() == "DISAGREE"){
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4");
                }
            }

            window.parent.lpPage.Show();
            cpPage.PerformCallback("Reject");
        }
        function EnableDisableButtons() {
            var lblUser = <%=Session.Contents("LblUser")%>;
            var lblScheme = '<%=Session.Contents("EvalScheme")%>';
            if(lblScheme != "SGP" && lblScheme != "MYE") {
                if(lblUser=="0"){
                    if(GetFirstTimeHF.Get("GetFirstTimeHF").toUpperCase() == "FALSE" && lblCommentEmp.Get("lblCommentEmp") == "" && lblRatingEmp.Get("lblRatingEmp") == ""){
                        cmdSubmit.SetEnabled(false);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage3").innerHTML = SetMessage3.Get("SetMessage3");
                    }
                    else{
                        cmdSubmit.SetEnabled(true);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage3").innerHTML = "";
                    }
                }
                else if(lblUser=="1"){
                    if (lblCommentEmp.Get("lblCommentEmp") != "" && lblRatingEmp.Get("lblRatingEmp") != ""){
                        if(lblCommentMan.Get("lblCommentMan") == "" && lblRatingMan.Get("lblRatingMan") == ""){
                            cmdSubmit.SetEnabled(false);
                            document.getElementById("pnlEvaluations_cpPage_tblErrorMessage5").innerHTML = SetMessage5.Get("SetMessage5");
                        }
                        else{
                            document.getElementById("pnlEvaluations_cpPage_tblErrorMessage5").innerHTML = "";
                             if(lblRatingEmp.Get("lblRatingEmp").toUpperCase() == "DISAGREE" || lblRatingMan.Get("lblRatingMan").toUpperCase() == "DISAGREE"){
                                cmdSubmit.SetEnabled(false);
                                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4")
                             }
                             else{
                                cmdSubmit.SetEnabled(true);
                                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = ""
                             }
                        }
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage3").innerHTML = ""
                    }
                }
                else{
                     if (lblCommentNLMan.Get("lblCommentNLMan") == "" && lblRatingNLMan.Get("lblRatingNLMan") == "") {
                        cmdSubmit.SetEnabled(false);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage6").innerHTML = SetMessage6.Get("SetMessage6");
                    }
                    else{
                        cmdSubmit.SetEnabled(true);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage6").innerHTML = "";
                        if(lblRatingNLMan.Get("lblRatingNLMan").toUpperCase() == "DISAGREE"){
                            cmdSubmit.SetEnabled(false);
                            document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4")
                        }
                        else if(lblRatingNLMan.Get("lblRatingNLMan").toUpperCase() == "AGREE"){
                            document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
                        }
                    }
                }
            }
        }
        function EmployeeMethod(controlVal, controlNum){
            if(controlNum=="0"){
                lblCommentEmp.Set("lblCommentEmp", controlVal);
            }
            else{
                lblRatingEmp.Set("lblRatingEmp", controlVal);
                if(controlVal.toUpperCase()=="DISAGREE"){
                    alert("You have just disagreed with the current performance evaluation!");
                }
            }
            if(lblCommentEmp.Get("lblCommentEmp") == "" || lblRatingEmp.Get("lblRatingEmp") == "")
            {
                //document.getElementById('pnlEvaluations_cmdSubmit').style.disabled = true;
                cmdSubmit.SetEnabled(false);
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage3").innerHTML = SetMessage3.Get("SetMessage3");
            }
            else
            {
                //document.getElementById('pnlEvaluations_cmdSubmit').style.disabled = false;
                cmdSubmit.SetEnabled(true);
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage3").innerHTML = "";
                if(lblRatingEmp.Get("lblRatingEmp").toUpperCase()=="DISAGREE"){
                    //document.getElementById('pnlEvaluations_cmdSubmit').style.disabled = true;
                    cmdSubmit.SetEnabled(false);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4");
                }
                else if(lblCommentEmp.Get("lblCommentEmp") != "" && lblRatingEmp.Get("lblRatingEmp").toUpperCase() == "AGREE"){
                    //document.getElementById('pnlEvaluations_cmdSubmit').style.disabled = false;
                    cmdSubmit.SetEnabled(true);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
                }
            }
            if(lblRatingEmp.Get("lblRatingEmp") == "")
            {
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
            }
        }
        function ManagerMethod(controlVal, controlNum){
            if(controlNum=="0"){
                lblCommentMan.Set("lblCommentMan", controlVal);
            }
            else{
                lblRatingMan.Set("lblRatingMan", controlVal);
                if(controlVal.toUpperCase()=="DISAGREE"){
                    alert("You have just disagreed with the current performance evaluation!");
                }
            }
            if(lblCommentEmp.Get("lblCommentEmp") != "" && lblRatingEmp.Get("lblRatingEmp") != "")
            {
                if(lblCommentMan.Get("lblCommentMan") == "" || lblRatingMan.Get("lblRatingMan") == "")
                {
                    //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = true;
                    cmdSubmit.SetEnabled(false);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage5").innerHTML = SetMessage5.Get("SetMessage5");
                }
                else
                {
                    //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = false;
                    cmdSubmit.SetEnabled(true);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage5").innerHTML = "";
                    if(lblRatingMan.Get("lblRatingMan").toUpperCase()=="DISAGREE"){
                        //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = true;
                        cmdSubmit.SetEnabled(false);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4");
                    }
                    else if(lblCommentMan.Get("lblCommentMan") != "" && lblRatingMan.Get("lblRatingMan").toUpperCase() == "AGREE"){
                        //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = false;
                        cmdSubmit.SetEnabled(true);
                        document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
                    }
                }
                if(lblRatingMan.Get("lblRatingMan") == "")
                {
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
                }
            }
        }
        function NLManagerMethod(controlVal, controlNum){
            if(controlNum=="0"){
                lblCommentNLMan.Set("lblCommentNLMan", controlVal);
            }
            else{
                lblRatingNLMan.Set("lblRatingNLMan", controlVal);
                if(controlVal.toUpperCase()=="DISAGREE"){
                    alert("You have just disagreed with the current performance evaluation!");
                }
            }

            if(lblCommentNLMan.Get("lblCommentNLMan") == "" || lblRatingNLMan.Get("lblRatingNLMan") == "")
            {
                //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = true;
                cmdSubmit.SetEnabled(false);
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage6").innerHTML = SetMessage6.Get("SetMessage6");
            }
            else
            {
                //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = false;
                cmdSubmit.SetEnabled(true);
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage6").innerHTML = "";
                if(lblRatingNLMan.Get("lblRatingNLMan").toUpperCase()=="DISAGREE"){
                    //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = true;
                    cmdSubmit.SetEnabled(false);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = SetMessage4.Get("SetMessage4");
                }
                else if(lblCommentNLMan.Get("lblCommentNLMan") != "" && lblRatingNLMan.Get("lblRatingNLMan").toUpperCase() == "AGREE"){
                    //document.getElementById("pnlEvaluations_cmdSubmit").style.disabled = false;
                    cmdSubmit.SetEnabled(true);
                    document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
                }
            }
            if(lblRatingNLMan.Get("lblRatingNLMan") == "")
            {
                document.getElementById("pnlEvaluations_cpPage_tblErrorMessage4").innerHTML = "";
            }
        }
    </script>
    <%--End Open Dialog Window for Objective Review--%>
    <form id="_performance_002" runat="server">
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
                    <dx:ASPxRoundPanel ID="rpanel1" runat="server" ClientInstanceName="rpanel1a" Width="100%"
                        ShowHeader="False">
                        <PanelCollection>
                            <dx:PanelContent ID="pc1" runat="server">
                                <table>
                                    <tr id="remRow" runat="server">
                                        <td align="left" style="color: #990000;">
                                            Reminders: If you find yourself in disagreement with any of the review scores and
                                            comments, please contact HR. Make sure to just SAVE your changes first, and do not
                                            submit.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <%--Create Objective Review Section Records inside Database--%>
                                    <tr id="linkRow" runat="server">
                                        <td align="left">
                                            Complete the Smart Goal Planning Section first by clicking <b><a id="A1" runat="server"
                                                onclick="javascript:getQuerystring();" onmouseout="this.style.cursor='default'"
                                                onmouseover="this.style.cursor='hand'" style="text-decoration: underline;" target="_blank">
                                                HERE.</a> </b>&nbsp;
                                        </td>
                                    </tr>
                                    <%--End Create Objective Review Section Records inside Database--%>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                    <br />
                    <%--<dx:ASPxRoundPanel ID="rpanel2" runat="server" ClientInstanceName="rpanel2a" Width="100%"
                        ShowHeader="False">
                        <PanelCollection>
                            <dxp:PanelContent ID="PanelContent2" runat="server">
                                <table>
                                    <tr>
                                        <td align="left" style="font-weight: bold;">
                                            Previous Year Rating
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="font-weight: bold;" width="250px">
                                            Review Type
                                        </td>
                                        <td align="center" style="font-weight: bold;" width="150px">
                                            Score
                                        </td>
                                        <td align="center" style="font-weight: bold;" width="150px">
                                            Evaluation Date
                                        </td>
                                    </tr>
                                    <tr id="trScheme1" runat="server">
                                        <td align="center" id="trScheme1a" runat="server">
                                        </td>
                                        <td align="center" id="trScheme1b" runat="server">
                                        </td>
                                        <td align="center" id="trScheme1c" runat="server">
                                        </td>
                                    </tr>
                                    <tr id="trScheme2" runat="server">
                                        <td align="center" id="trScheme2a" runat="server">
                                        </td>
                                        <td align="center" id="trScheme2b" runat="server">
                                        </td>
                                        <td align="center" id="trScheme2c" runat="server">
                                        </td>
                                    </tr>
                                </table>
                            </dxp:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>--%>
                    <br />
                    <dx:ASPxGridView ID="dgView" runat="server" ClientInstanceName="dgView" KeyFieldName="CompositeKey"
                        EnableCallbackCompression="true" Width="100%" AutoGenerateColumns="False">
                        <ClientSideEvents CustomButtonClick="function(s, e) { e.processOnServer = false; hPanel.Set(&#39;Index&#39;, e.visibleIndex); pcRemarks.Show(); }">
                        </ClientSideEvents>
                        <Columns>
                            <dx:GridViewCommandColumn ButtonType="Image" Name="cancel" VisibleIndex="0" Width="5%">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton ID="Cancel" Image-Url="images/select.png" Text="View / Edit Sticky Notes">
                                        <Image Url="images/select.png">
                                        </Image>
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="CompositeKey" VisibleIndex="1" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Name" Caption="Question" VisibleIndex="2" Width="45%" />
                            <dx:GridViewDataTextColumn FieldName="RangeType" VisibleIndex="3" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="4" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="ObtainBy" VisibleIndex="5" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="6" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="RatingPercentage" VisibleIndex="7" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Score" VisibleIndex="8" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="9" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="10" Visible="false" />
                            <dx:GridViewDataCheckColumn FieldName="Required" VisibleIndex="11" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Desc" VisibleIndex="12" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="StickyNotes" VisibleIndex="13" Visible="false" />
                            <dx:GridViewDataTextColumn FieldName="Answers" Name="Answers" Caption="Response"
                                VisibleIndex="14" Width="50%">
                                <DataItemTemplate>
                                    <dx:ASPxComboBox ID="cmbAnswers" runat="server" EnableIncrementalFiltering="true"
                                        DropDownStyle="DropDownList" TextField="ElementName" ValueField="FromPerc" Width="100%"
                                        Visible="false" />
                                    <dx:ASPxMemo ID="txtAnswers" runat="server" Rows="5" Width="100%" Visible="false" />
                                    <dx:ASPxDateEdit ID="dteAnswers" runat="server" EditFormat="Custom" Width="100%"
                                        Visible="false" />
                                    <dx:ASPxSpinEdit ID="spAnswers" runat="server" NumberType="Float" DecimalPlaces="2"
                                        Visible="false" />
                                    <dx:ASPxCheckBox ID="chkAnswers" runat="server" Visible="false" />
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Answers_010" Caption="Response" VisibleIndex="15" />
                            <dx:GridViewDataTextColumn FieldName="Answers_011" Caption="Response" VisibleIndex="16" />
                            <dx:GridViewDataTextColumn FieldName="Answers_012" Caption="Response" VisibleIndex="17" />
                        </Columns>
                        <ClientSideEvents CustomButtonClick="function(s, e) { e.processOnServer = false; hPanel.Set('Index', e.visibleIndex); pcRemarks.Show(); }" />
                        <SettingsBehavior AllowDragDrop="false" AllowSort="false" />
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
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ClientInstanceName="rpanel1a"
                        Width="100%" ShowHeader="False" Visible="false">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <table width="100%">
                                    <%--Display the Summary of Scores
                                    <tr runat="server" id="trScore">
                                        <td>
                                            <table width="100%">
                                                <tr class="btn_normal_nohand">
                                                    <td align="left" colspan="2" style="font-size: 14px; font-weight: bold">
                                                        Summary of Scores
                                                    </td>
                                                </tr>
                                                <tr class="gridCell">
                                                    <td align="left" style="font-weight: bold; font-size: 12px">
                                                        1. Objective Review Score
                                                    </td>
                                                    <td align="right" style="font-weight: normal; font-size: 12px">
                                                        <asp:Label ID="lblScore1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="gridCell">
                                                    <td align="left" style="font-weight: bold; font-size: 12px">
                                                        2. Competency Rating
                                                    </td>
                                                    <td align="right" style="font-weight: normal; font-size: 12px">
                                                        <asp:Label ID="lblScore2" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <%--<tr class="gridCell">
                                                    <td align="left" style="font-weight: bold; font-size: 12px">
                                                        3. HOD Discretionary Score
                                                    </td>
                                                    <td align="right" style="font-weight: normal; font-size: 12px">
                                                        <asp:Label ID="lblScore3" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="gridCell">
                                                    <td align="left" style="font-weight: bold; font-size: 12px">
                                                        3. Final Score
                                                    </td>
                                                    <td align="right" style="font-weight: bold; font-size: 12px;">
                                                        <asp:Label ID="lblScore" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    End Display the Summary of Scores--%>
                                    <tr>
                                        <td>
                                            <input id="currUser" runat="server" type="hidden"></input>
                                            </input> </input> </input> </input> </input> </input> </input> </input> </input>
                                            </input> </input> </input>
                                            <input id="validAD" runat="server" type="hidden"></input>
                                            </input> </input> </input> </input> </input> </input> </input> </input> </input>
                                            </input> </input> </input>
                                            <input id="fromSave" runat="server" type="hidden"></input>
                                            </input> </input> </input> </input> </input> </input> </input> </input> </input>
                                            </input> </input> </input>
                                            <input id="commentA" runat="server" type="hidden"></input>
                                            </input> </input> </input> </input> </input> </input> </input> </input> </input>
                                            </input> </input> </input>
                                            <input id="btnSendBack" runat="server" type="hidden"></input>
                                            </input> </input> </input> </input> </input> </input> </input> </input> </input>
                                            </input> </input> </input>
                                        </td>
                                    </tr>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                    <center>
                        <div class="centered" style="width: 100%">
                            <table style="width: 100%" runat="server" id="tableSub">
                                <tr align="center">
                                    <td colspan="2">
                                        <dx:ASPxCallbackPanel ID="cpPage" runat="server" ClientInstanceName="cpPage" HideContentOnCallback="false"
                                            ShowLoadingPanel="false">
                                            <ClientSideEvents EndCallback="function(s, e) { if (s.cpCalculateScore) { window.parent.frames[0].lblScore.SetText(s.cpScore); } if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } if (s.cpRedirectURL.length != 0) { window.parent.postUrl(s.cpRedirectURL, false); } if (s.cpExecPrint) { window.open(&#39;reportsview.aspx?params=&#39; + hPanel.Get(&#39;params&#39;).toString(), &#39;open&#39;); } else { if (s.cpSavedText.length != 0) { window.parent.ShowPopup(s.cpSavedText); } } EnableDisableButtons(); }">
                                            </ClientSideEvents>
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent2" runat="server">
                                                    <dx:ASPxHiddenField ID="items_001" runat="server" ClientInstanceName="items_001" />
                                                    <dx:ASPxHiddenField ID="lblCommentEmp" runat="server" ClientInstanceName="lblCommentEmp" />
                                                    <dx:ASPxHiddenField ID="lblCommentMan" runat="server" ClientInstanceName="lblCommentMan" />
                                                    <dx:ASPxHiddenField ID="lblCommentNLMan" runat="server" ClientInstanceName="lblCommentNLMan" />
                                                    <dx:ASPxHiddenField ID="lblOrigRatingEmp" runat="server" ClientInstanceName="lblOrigRatingEmp" />
                                                    <dx:ASPxHiddenField ID="lblOrigRatingMan" runat="server" ClientInstanceName="lblOrigRatingMan" />
                                                    <dx:ASPxHiddenField ID="lblOrigRatingNLMan" runat="server" ClientInstanceName="lblOrigRatingNLMan" />
                                                    <dx:ASPxHiddenField ID="lblRatingEmp" runat="server" ClientInstanceName="lblRatingEmp" />
                                                    <dx:ASPxHiddenField ID="lblRatingMan" runat="server" ClientInstanceName="lblRatingMan" />
                                                    <dx:ASPxHiddenField ID="lblRatingNLMan" runat="server" ClientInstanceName="lblRatingNLMan" />
                                                    <dx:ASPxHiddenField ID="SetMessage3" runat="server" ClientInstanceName="SetMessage3" />
                                                    <dx:ASPxHiddenField ID="SetMessage4" runat="server" ClientInstanceName="SetMessage4" />
                                                    <dx:ASPxHiddenField ID="SetMessage5" runat="server" ClientInstanceName="SetMessage5" />
                                                    <dx:ASPxHiddenField ID="SetMessage6" runat="server" ClientInstanceName="SetMessage6" />
                                                    <dx:ASPxHiddenField ID="GetFirstTimeHF" runat="server" ClientInstanceName="GetFirstTimeHF" />
                                                    <dx:ASPxHiddenField ID="IsFirstLoading" runat="server" ClientInstanceName="IsFirstLoading" />
                                                    <table id="tblErrorMessage1" visible="false" runat="server">
                                                        <tr>
                                                            <%-- <td style="text-align: right; width: 16px">
                                                                <asp:Image ID="Image10" ImageUrl="images/error.png" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="Label10" runat="server" Text="Unable to submit unsaved records. Please click on Save before Submit."
                                                                    ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tblErrorMessage2" visible="false" runat="server">
                                                        <tr>
                                                            <%--<td style="text-align: right; width: 16px">
                                                                <asp:Image ID="imgError1" ImageUrl="images/error.png" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="lblError1" runat="server" Text="Records not submitted. Missing Scores for Competency Rating Section Items."
                                                                    ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tblErrorMessage7" visible="false" runat="server">
                                                        <tr>
                                                            <%--<td style="text-align: right; width: 16px">
                                                                <asp:Image ID="imgError1" ImageUrl="images/error.png" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="Label1" runat="server" Text="Records not submitted. Missing Scores for Values Section Items."
                                                                    ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <%-- <td style="text-align: right; width: 16px">
                                                                <asp:Image ID="tblErrorMessage3Image" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="tblErrorMessage3" runat="server" ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <%--<td style="text-align: right; width: 16px">
                                                                <asp:Image ID="Image7" ImageUrl="images/error.png" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="tblErrorMessage4" runat="server" ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <%--<td style="text-align: right; width: 16px">
                                                                <img id="tblErrorMessage5Image" alt />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="tblErrorMessage5" runat="server" ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <%--<td style="text-align: right; width: 16px">
                                                                <asp:Image ID="Image2" ImageUrl="images/error.png" runat="server" />
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>--%>
                                                            <td style="vertical-align: middle">
                                                                <asp:Label ID="tblErrorMessage6" runat="server" ForeColor="#990000" Font-Bold="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
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
                                                                            <dx:ASPxButton ID="cmdSubmit" runat="server" Text="Submit" Width="80px" AutoPostBack="false"
                                                                                ClientInstanceName="cmdSubmit">
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
                                                                                ClientInstanceName="cmdAppraise">
                                                                                <ClientSideEvents Click="function(s, e) { RejectForm(); }"></ClientSideEvents>
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxButton ID="cmdAppraise2" runat="server" Text="Send Back to Employee" Width="170px"
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
                                            <ClientSideEvents EndCallback="function(s, e) { if (s.cpCalculateScore) { window.parent.frames[0].lblScore.SetText(s.cpScore); } if (window.parent.lpPage.GetVisible()) { window.parent.lpPage.Hide(); } if (s.cpRedirectURL.length != 0) { window.parent.postUrl(s.cpRedirectURL, false); } if (s.cpExecPrint) { window.open('reportsview.aspx?params=' + hPanel.Get('params').toString(), 'open'); } else { if (s.cpSavedText.length != 0) { window.parent.ShowPopup(s.cpSavedText); } } EnableDisableButtons(); }" />
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
<%--</dx:panelcontent> </dx:aspxroundpanel> </dx:panelcontent> --%>