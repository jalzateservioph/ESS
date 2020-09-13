<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DivisionalResults.aspx.cs" Inherits="ESSReports.Pages.DivisionalResults" %>

<%@ Register Assembly="DevExpress.XtraReports.v12.1.Web, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v12.1.Export, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid.Export" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td rowspan="2" style="font-size: 80px;color: red;font-weight: bolder" align="center">
                    TMP &nbsp;
                </td>
                 <td style="font-size: 30px;color: blue;font-weight: bold" align="center">
                    2014 Workplace Survey
                </td>
            </tr>
            <tr>
                <td align="left" style="font-size: 30px;color: black; font-weight: bold">
                    DIVISION RESULTS
                </td>
            </tr>
        </table>
        <dx:ASPxPivotGrid ID="pgdDivisional" runat="server" ClientIDMode="AutoID" EnableTheming="True" Theme="BlackGlass" OnCustomCellValue="pgdDivisional_CustomCellValue" OnCustomSummary="pgdDivisional_CustomSummary">
            <Fields>
                <dx:PivotGridField ID="fieldDivision" FieldName="Division" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0"/>
                <dx:PivotGridField ID="fieldDepartment" Area="ColumnArea" FieldName="Department" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0"/>
                <dx:PivotGridField ID="fieldAspect" Area="RowArea" FieldName="Aspect" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0"/>
                <dx:PivotGridField ID="fieldKPAName" Area="RowArea" FieldName="KPAName" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="1"/>
                <dx:PivotGridField ID="fieldRating2012" Area="DataArea" FieldName="Rating2012" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="0" SummaryType="Custom" TotalsVisibility="CustomTotals"/>
                <dx:PivotGridField ID="fieldRating2014" Area="DataArea" FieldName="Rating2014" Options-AllowFilter="True" Options-AllowSort="True" AreaIndex="1" SummaryType="Custom" TotalsVisibility="CustomTotals"/>
            </Fields>
        </dx:ASPxPivotGrid>
    </div>
        <dx:ASPxPivotGridExporter ID="pgeExporter" runat="server" ASPxPivotGridID="pgdDivisional">
        </dx:ASPxPivotGridExporter>
        <dx:ASPxButton ID="btnExport" runat="server" OnClick="btnExport_Click" Text="Export">
        </dx:ASPxButton>
    </form>
</body>
</html>
