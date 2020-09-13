<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TWSDepartmental.aspx.vb" Inherits="SmartHR.TWSDepartmental" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPivotGrid" Assembly="DevExpress.Web.ASPxPivotGrid.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPivotGrid.Export" Assembly="DevExpress.Web.ASPxPivotGrid.v11.1.Export, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="scripts/jquery-1.4.2-vsdoc.js"></script>
    <script src="scripts/jquery-1.4.2.js" type="text/javascript"></script>
    <title></title>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            window.parent.lpPage.Hide();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <table>
            <tr>
                <td rowspan="2" align="center">
                    <dx:ASPxLabel id="lblTMP" runat="server" Text="TMP" Font-Size="80px" ForeColor="Red" Font-Bold="True" Font-Names="Times New Roman"/> &nbsp;
                </td>
                <td align="center">
                    <dx:ASPxLabel id="lblBanner" runat="server" Text="Workplace Survey" Font-Size="30px" ForeColor="Blue" Font-Bold="True" Font-Names="Times New Roman"/>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <dx:ASPxLabel id="lblResult" runat="server" Text="SECTIONAL RESULTS" Font-Size="30px" ForeColor="Black" Font-Bold="True" Font-Names="Times New Roman"/>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <dx:ASPxButton runat="server" Text="Export" ID="btnExport" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"></dx:ASPxButton>    
                </td>
                <td>
                    <dx:ASPxButton runat="server" Text="Back" ID="btnBack" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxPivotGrid ID="pgvCorporate" runat="server" ClientIDMode="AutoID">
            <Fields>
                <dx:PivotGridField ID="fieldDepartment" Area="FilterArea" AreaIndex="0" FieldName="Department"/>
                <dx:PivotGridField ID="fieldSection" Area="ColumnArea" AreaIndex="0" FieldName="Section"/>
                <dx:PivotGridField ID="fieldAspect" Area="RowArea" FieldName="Aspect" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0"/>
                <dx:PivotGridField ID="fieldKPAName" Area="RowArea" FieldName="KPAName" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="1" Caption="Items"/>
                <dx:PivotGridField ID="fieldCurrent" Area="DataArea" FieldName="CurrentYear" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" Caption="Current"/>
                <dx:PivotGridField ID="fieldPrevious" Area="DataArea" FieldName="PreviousYear" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="1" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" Caption="Previous"/>
                <dx:PivotGridField ID="fieldDifference" Area="DataArea" AreaIndex="2" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" Caption="Diff +/-" UnboundExpression="[fieldCurrent] - [fieldPrevious]" UnboundFieldName = "Difference" UnboundType="Decimal"/>
            </Fields>
            <OptionsLoadingPanel>
                <Image Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif">
                </Image>
            </OptionsLoadingPanel>
            <OptionsData DataFieldUnboundExpressionMode="UseSummaryValues" />
            <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
                <CustomizationFieldsBackground Url="~/App_Themes/BlackGlass/PivotGrid/pgCustomizationFormBackground.gif">
                </CustomizationFieldsBackground>
                <LoadingPanel Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif">
                </LoadingPanel>
            </Images>
            <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" 
                CssPostfix="BlackGlass">
                <HeaderStyle>
                <HoverStyle>
                    <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBackHot.gif" 
                        Repeat="RepeatX" />
                </HoverStyle>
                <Paddings PaddingBottom="4px" PaddingLeft="5px" PaddingRight="5px" 
                    PaddingTop="4px" />
                <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBack.gif" 
                    Repeat="RepeatX" />
                </HeaderStyle>
                <FilterAreaStyle>
                    <Paddings PaddingBottom="3px" PaddingTop="3px" />
                    <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterAreaBack.gif" 
                        Repeat="RepeatX" />
                </FilterAreaStyle>
                <FieldValueStyle>
                    <Paddings PaddingBottom="3px" PaddingTop="3px" />
                </FieldValueStyle>
                <FilterButtonPanelStyle>
                    <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterPanelBack.gif" 
                        Repeat="RepeatX" />
                </FilterButtonPanelStyle>
                <MenuStyle GutterWidth="0px" />
                <CustomizationFieldsHeaderStyle ForeColor="#5A5A5A">
                </CustomizationFieldsHeaderStyle>
            </Styles>
        </dx:ASPxPivotGrid>    
    </div>
        <dx:ASPxPivotGridExporter ID="pgeCorporate" runat="server" ASPxPivotGridID="pgvCorporate" />
    </form>
</body>
</html>
