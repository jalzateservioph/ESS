<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TWSDivisional.aspx.vb" Inherits="SmartHR.TWSDivisional" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v11.1, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v11.1.Export, Version=11.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid.Export" TagPrefix="dx" %>

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
                    <td>
                        <table>
                            <tr>
                                <td rowspan="2" align="center">
                                    <dx:ASPxLabel ID="lblTMP" runat="server" Text="TMP" Font-Size="80px" ForeColor="Red" Font-Bold="True" Font-Names="Times New Roman" />
                                    &nbsp;
                                </td>
                                <td align="center">
                                    <dx:ASPxLabel ID="lblBanner" runat="server" Text="Workplace Survey" Font-Size="30px" ForeColor="Blue" Font-Bold="True" Font-Names="Times New Roman" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <dx:ASPxLabel ID="lblResult" runat="server" Text="DEPARTMENTAL RESULTS" Font-Size="30px" ForeColor="Black" Font-Bold="True" Font-Names="Times New Roman" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table width="300px">
                            <tr>
                                <td align="right">
                                    <dx:ASPxButton runat="server" Text="Export TWS" ID="btnExportTWS" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="100"></dx:ASPxButton>
                                </td>
                                <td align="left">
                                    <dx:ASPxButton runat="server" Text="Export LDR" ID="btnExportLDR" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="100"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <dx:ASPxButton runat="server" Text="Back" ID="btnBack" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="100">
                                        <ClientSideEvents Click="function(s, e) { window.parent.lpPage.Show(); }" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <dx:ASPxPivotGrid ID="LDRCorporate" runat="server" ClientIDMode="AutoID">
                <Fields>
                    <dx:PivotGridField ID="yDivision" Area="FilterArea" AreaIndex="0" FieldName="Division" />
                    <dx:PivotGridField ID="yDepartment" Area="ColumnArea" AreaIndex="0" FieldName="Department" />
                    <dx:PivotGridField ID="yAspect" Area="RowArea" AreaIndex="0" FieldName="Aspect" Options-AllowFilter="True" Options-AllowSort="True" />
                    <dx:PivotGridField ID="yKPAName" Area="RowArea" AreaIndex="1" FieldName="KPAName" Options-AllowFilter="True" Options-AllowSort="True" SortMode="Custom" />
                    <dx:PivotGridField ID="yCurrent" Area="DataArea" AreaIndex="0" FieldName="CurrentYear" Options-AllowFilter="False" Options-AllowSort="False" Caption="Current" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                    <dx:PivotGridField ID="yPrevious" Area="DataArea" AreaIndex="1" FieldName="PreviousYear" Options-AllowFilter="False" Options-AllowSort="False" Caption="Previous" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                    <dx:PivotGridField ID="yDifference" Area="DataArea" AreaIndex="2" Caption="Diff +/-" UnboundFieldName="Difference" UnboundType="Decimal" UnboundExpression="[yCurrent] - [yPrevious]" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                </Fields>
                <OptionsLoadingPanel>
                    <Image Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif"></Image>
                </OptionsLoadingPanel>
                <OptionsData DataFieldUnboundExpressionMode="UseSummaryValues" />
                <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
                    <CustomizationFieldsBackground Url="~/App_Themes/BlackGlass/PivotGrid/pgCustomizationFormBackground.gif"></CustomizationFieldsBackground>
                    <LoadingPanel Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif"></LoadingPanel>
                </Images>
                <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass">
                    <HeaderStyle>
                        <HoverStyle>
                            <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBackHot.gif" Repeat="RepeatX" />
                        </HoverStyle>
                        <Paddings PaddingBottom="4px" PaddingLeft="5px" PaddingRight="5px" PaddingTop="4px" />
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBack.gif" Repeat="RepeatX" />
                    </HeaderStyle>
                    <FilterAreaStyle>
                        <Paddings PaddingBottom="3px" PaddingTop="3px" />
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterAreaBack.gif" Repeat="RepeatX" />
                    </FilterAreaStyle>
                    <FieldValueStyle>
                        <Paddings PaddingBottom="3px" PaddingTop="3px" />
                    </FieldValueStyle>
                    <FilterButtonPanelStyle>
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterPanelBack.gif" Repeat="RepeatX" />
                    </FilterButtonPanelStyle>
                    <MenuStyle GutterWidth="0px" />
                    <CustomizationFieldsHeaderStyle ForeColor="#5A5A5A"></CustomizationFieldsHeaderStyle>
                </Styles>
            </dx:ASPxPivotGrid>
            <br />
            <dx:ASPxPivotGrid ID="TWSCorporate" runat="server" ClientIDMode="AutoID">
                <Fields>
                    <dx:PivotGridField ID="xDivision" Area="FilterArea" AreaIndex="0" FieldName="Division" />
                    <dx:PivotGridField ID="xDepartment" Area="ColumnArea" AreaIndex="0" FieldName="Department" />
                    <dx:PivotGridField ID="xAspect" Area="RowArea" AreaIndex="0" FieldName="Aspect" Options-AllowFilter="True" Options-AllowSort="True" />
                    <dx:PivotGridField ID="xKPAName" Area="RowArea" AreaIndex="1" FieldName="KPAName" Options-AllowFilter="True" Options-AllowSort="True" />
                    <dx:PivotGridField ID="xCurrent" Area="DataArea" AreaIndex="0" FieldName="CurrentYear" Options-AllowFilter="False" Options-AllowSort="False" Caption="Current" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                    <dx:PivotGridField ID="xPrevious" Area="DataArea" AreaIndex="1" FieldName="PreviousYear" Options-AllowFilter="False" Options-AllowSort="False" Caption="Previous" SummaryType="Average" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                    <dx:PivotGridField ID="xDifference" Area="DataArea" AreaIndex="2" Caption="Diff +/-" UnboundFieldName="Difference" UnboundType="Decimal" UnboundExpression="[xCurrent] - [xPrevious]" CellFormat-FormatString="n2" CellFormat-FormatType="Custom" />
                </Fields>
                <OptionsLoadingPanel>
                    <Image Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif"></Image>
                </OptionsLoadingPanel>
                <OptionsData DataFieldUnboundExpressionMode="UseSummaryValues" />
                <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
                    <CustomizationFieldsBackground Url="~/App_Themes/BlackGlass/PivotGrid/pgCustomizationFormBackground.gif"></CustomizationFieldsBackground>
                    <LoadingPanel Url="~/App_Themes/BlackGlass/PivotGrid/Loading.gif"></LoadingPanel>
                </Images>
                <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass">
                    <HeaderStyle>
                        <HoverStyle>
                            <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBackHot.gif" Repeat="RepeatX" />
                        </HoverStyle>
                        <Paddings PaddingBottom="4px" PaddingLeft="5px" PaddingRight="5px" PaddingTop="4px" />
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgHeaderBack.gif" Repeat="RepeatX" />
                    </HeaderStyle>
                    <FilterAreaStyle>
                        <Paddings PaddingBottom="3px" PaddingTop="3px" />
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterAreaBack.gif" Repeat="RepeatX" />
                    </FilterAreaStyle>
                    <FieldValueStyle>
                        <Paddings PaddingBottom="3px" PaddingTop="3px" />
                    </FieldValueStyle>
                    <FilterButtonPanelStyle>
                        <BackgroundImage ImageUrl="~/App_Themes/BlackGlass/PivotGrid/pgFilterPanelBack.gif" Repeat="RepeatX" />
                    </FilterButtonPanelStyle>
                    <MenuStyle GutterWidth="0px" />
                    <CustomizationFieldsHeaderStyle ForeColor="#5A5A5A"></CustomizationFieldsHeaderStyle>
                </Styles>
            </dx:ASPxPivotGrid>
        </div>
        <dx:ASPxPivotGridExporter ID="TWSCorporateExporter" runat="server" ASPxPivotGridID="TWSCorporate" />
        <dx:ASPxPivotGridExporter ID="LDRCorporateExporter" runat="server" ASPxPivotGridID="LDRCorporate" />
    </form>
</body>
</html>
