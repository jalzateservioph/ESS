<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="prReports.aspx.vb" Inherits="SmartHR.prReports" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTabControl" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxClasses" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTreeView" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxNavBar" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx1" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
    <style type="text/css">
     
        .auto-style27 {
            width: 102px;
        }
       
        .auto-style28 {
            height: 18px;
        }
        .filterPreview{
            float: left;
            width: 40%;
            overflow:auto;
        }
        .parameterlist{
            float: left;
            height:100%;
            width:60%;
            left:0;
        }
        .outside {
            clear:both;
            float:none;
            width:100%;
        }
        
        .auto-style33 {
            width: 100px;
        }
        </style>
        <script>
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Do you want to delete this data?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
        </script>
</head>
<body onload="window.parent.reset();">
    <form id="form1" runat="server">
    <div style="height:100%;">
        <dx:ASPxPageControl ID="tabMenu" runat="server"  ActiveTabIndex="3" Width="100%" AutoPostBack="True">
            <TabPages>
                <dx:TabPage Name="tbFileImporter" Text="Import Attendance and Performance">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
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
                            <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="Callback">
                                <ClientSideEvents CallbackComplete="function(s, e) { LoadingPanel.Hide(); }" />
                            </dx:ASPxCallback>
                          <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="100%" HeaderText="Report Filter Options" Font-Bold="True">
            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
                      <div style="width:100%;height:100%;">
                          <div class="parameterlist" >
                                <div style="float:left; width:50%; " >
                                    <table id="Table1" runat="server" style="width:100%;" >
                                        <tr>
                                            <td class="auto-style33" nowrap>
                                                Report Type
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cbReportType" runat="server" AutoPostBack="True" Height="20px" Width="100%">
                                                <asp:ListItem>Performance Rating</asp:ListItem>
                                                <asp:ListItem>Candidates for Promotion</asp:ListItem>
                                             </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style33" nowrap>
                                                Year
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <dx:ASPxComboBox ID="cbYear" runat="server" Width="100%"></dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style33" nowrap>
                                                As Of
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <dx:ASPxDateEdit ID="dateAsOf" runat="server" Width="100%" DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style33" nowrap>
                                                Hire Date
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <dx:ASPxDateEdit ID="dateHired" runat="server" Width="100%" DisplayFormatString="MM/dd/yyyy" EditFormat="Custom" EditFormatString="MM/dd/yyyy"></dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr id="performancetag" >
                                            <td class="auto-style33" nowrap>
                                                <dx:ASPxLabel ID="lblRatingtype" runat="server" Text="Rating Type" Width="100%"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td >
                                                <dx:ASPxComboBox ID="cbRating" runat="server" SelectedIndex="0" Width="100%">
                                                     <Items>
                                                        <dx:ListEditItem Selected="True" Text="Mid Year List Appraisal" Value="Mid Year List Appraisal" />
                                                        <dx:ListEditItem Text="Year End List Appraisal" Value="Year End List Appraisal" />
                                                     </Items>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr id="promotionstag" >
                                            <td colspan="3" nowrap>
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Inclusive Period for Suspension" Font-Bold="True" Width="100%"></dx:ASPxLabel>
                                            </td>
                                        </tr>
                                        <tr id="promotionstag1">
                                            <td class="auto-style33" nowrap>
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="From" Width="100%"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <dx:ASPxDateEdit ID="datesuspendFrom" runat="server" Width="100%">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr id="promotionstag2" nowrap>
                                            <td class="auto-style33">
                                                 <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="To" Width="100%"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td >
                                                 <dx:ASPxDateEdit ID="dateSuspendTo" runat="server" Width="100%"></dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style33" nowrap >
                                                <dx:ASPxLabel ID="lblfilter" runat="server" Text="Filter" Width="100%"></dx:ASPxLabel>                                            
                                            </td>                                       
                                            <td>
                                                :
                                            </td>
                                            <td  >                                            
                                                <asp:DropDownList ID="cbFilter" runat="server" AutoPostBack="True" Height="20px" Width="100%">                                            
                                                </asp:DropDownList>                                           
                                            </td>                                       
                                        </tr>    
                                    </table>
                                </div>
                                <div style="float:left; width:50%;">
                                    <table style="width:100%;">
                                    <tr>
                                        <td colspan="2" class="auto-style28">
                                            <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text=" Filter Criteria Builder"  Font-Bold="True"></dx:ASPxLabel>
                                                                                    
                                        </td>
                                                                                
                                    </tr>    
                                    <tr>
                                                                                    
                                        <td class="auto-style27" nowrap>
                                                                                         
                                            <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="Filter Description :" Width="100%" ></dx:ASPxLabel>
                                                                                    
                                        </td>
                                                                                    
                                        <td >
                                                                                        
                                            <dx:ASPxTextBox ID="txtFilterDesc" runat="server" Width="100%">
                                            
                                                                                        
                                            </dx:ASPxTextBox>
                                                                                    
                                        </td>
                                                                                
                                    </tr>
                                                                                
                                    <tr>
                                                                                    
                                        <td class="auto-style27"> 
                                                                                        
                                            <dx:ASPxLabel ID="ASPxLabel20" runat="server" Text="Criteria :" ></dx:ASPxLabel>
                                                                                    
                                        </td>
                                                                                    
                                        <td>
                                                                                        
                                            <asp:DropDownList ID="cbCriteria" runat="server" AutoPostBack="True" Height="20px" Width="100%">
                                                                                            
                                                <asp:ListItem></asp:ListItem>
                                                                                            
                                                <asp:ListItem>Attendance Rating</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Category</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Civil Status</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Cost Centre</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Department</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Division</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Employment Type</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Group</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Institution</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Job Title</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Job Type</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Nationality</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Pay Grade</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Pay Level</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Pay Mode</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Plant</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Section</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Sex</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Subsection</asp:ListItem>
                                                                                            
                                                <asp:ListItem>Surname</asp:ListItem>
                                                                                        
                                            </asp:DropDownList>
                                                                                    
                                        </td>
                                                                                
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxCheckBox ID="checkuncheck" runat="server" Text="Select All" Width="100%"  AutoPostBack="true" Enabled="False"></dx:ASPxCheckBox>
                                        </td>

                                    </tr>                                   
                                          
                                </table>
                                    <dx:ASPxListBox ID="lbCriteriaItems" runat="server" SelectionMode="CheckColumn" Width="100%" Height="200px"></dx:ASPxListBox>
                                    <dx:ASPxButton ID="btnOk" runat="server" Text="Ok" Width="100%" Font-Bold="True"></dx:ASPxButton>
                                                
                                </div> 
                                <div class="outside">      
                                    <table style="width:100%;">    
                                        <tr>    
                                            <td>

                                            </td>
                                        </tr>
                                        <tr>     
                                            <td style="width:25%;">
                                                <dx:ASPxButton ID="btnClearFilters" runat="server" Text="Clear Filters" Font-Bold="True" Height="40px" width="100%" ></dx:ASPxButton>                           
                                            </td>                                            
                                            <td style="width:25%;">
                                                <dx:ASPxButton ID="btnSaveGo" runat="server" Text="Save Filters &amp; Go" Font-Bold="True" Height="40px" width="100%" >
                                                     <ClientSideEvents Click="function(s, e) { Callback.PerformCallback(); LoadingPanel.Show(); }" />
                                                </dx:ASPxButton>                           
                                            </td>                                            
                                            <td style="width:25%;">                                                                            
                                                <dx:ASPxButton ID="btnGo" runat="server" Text="Go" Font-Bold="True" Height="40px" width="100%" AutoPostBack="False"  >
                                                    
                                                     <ClientSideEvents Click="function(s, e) { Callback.PerformCallback(); LoadingPanel.Show(); }" />
                                                    
                                                </dx:ASPxButton>                           
                                            </td>   
                                            <td style="width:25%;">                                                                            
                                                <dx:ASPxButton ID="btnDelete" runat="server" Text="Delete Filter" Font-Bold="True" Height="40px" width="100%"   OnClick="btnDelete_Click">
                                                    <ClientSideEvents Click="function(s, e) {Confirm() }" />
                                                </dx:ASPxButton>                           
                                            </td>                                                                                                                                                 
                                        </tr>                        
                                        
                                    </table>                        
                                </div>            
                      </div>
                            
                          <div class="filterPreview">
                                            
                                <div style="float:left; width:48%; padding:2px;"> 
                                                
                                    <dx:ASPxNavBar ID="nbFirst" runat="server" AutoCollapse="False"  AllowExpanding="true" Width="100%">
                                        <Groups>
                                            <dx:NavBarGroup Text="Attendance Rating">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Category">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Civil Status">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Cost Centre">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Department">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Division">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Employment Type">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup>
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Institution">
                                            </dx:NavBarGroup>
                                            <dx:NavBarGroup Text="Job Title">
                                            </dx:NavBarGroup>
                                        </Groups>
                                    </dx:ASPxNavBar>
                                                            
                                </div>            
                                <div style="float:left; width:48%; padding:2px;">

                                    <dx:ASPxNavBar ID="nbSecond" runat="server" AutoCollapse="False" AllowExpanding="true" Width="100%">
                                        <Groups>
                                            <dx:NavBarGroup Text="Job Type">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Nationality">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Pay Grade">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Pay Level">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Pay Mode">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Plant">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Section">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Sex">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Subsection">
                                                                        
                                            </dx:NavBarGroup>
                                                                        
                                            <dx:NavBarGroup Text="Surname">
                                                                        
                                            </dx:NavBarGroup>
                                                                    
                                        </Groups>
                                                                
                                    </dx:ASPxNavBar>
                                                            
                                </div>   
                                           
                      </div>
                      </div>
                      
                            
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage> 
            </TabPages>
        </dx:ASPxPageControl>
    </div>
        <dx:ASPxPopupControl ID="popup" runat="server" Modal="True" ShowFooter="True" ShowSizeGrip="True" FooterText="" HeaderText="Information" RenderMode="Lightweight">
            <FooterTemplate>
                <center>
                     <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Close" Width="50%" Height="36px" />
                </center>
            </FooterTemplate>
            <ContentCollection>
                <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
                    <dx:ASPxLabel ID="popuplabel" runat="server" Text="ASPxLabel">
                    </dx:ASPxLabel>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>  
        
        <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True">
        </dx:ASPxLoadingPanel>
        
    </form>
</body>
</html>
