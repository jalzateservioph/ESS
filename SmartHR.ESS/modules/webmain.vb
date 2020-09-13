Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxHiddenField
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.Data
Imports DevExpress.XtraCharts
Imports DevExpress.XtraCharts.Web
Imports DevExpress.XtraReports.UI
Imports System.IO
'Imports Microsoft.Reporting.WinForms
Imports Microsoft.Reporting.WebForms

Module webmain

#Region " *** Logical Procedures (Private) *** "

    Private Sub ProcessReport(ByRef dSet As DataSet, ByVal TableName As String, ByRef ctlControls As XRControlCollection)

        Dim xrTag As String

        Dim xrProperty As String

        Dim xrFormat As String

        Dim xrValue(1) As String

        For Each xrControl As XRControl In ctlControls

            xrTag = xrControl.Tag.ToString()

            If (xrTag.Length > 0) Then

                While (xrTag.Length > 0)

                    xrProperty = GetXML(xrTag)

                    xrValue(0) = GetXML(xrTag, KeyName:=xrProperty)

                    xrFormat = GetXML(xrValue(0), "[", "fmt", CloseKey:="]")

                    If (xrFormat.Length > 0) Then xrValue(0) = xrValue(0).Replace("[fmt=" & xrFormat & "]", "")

                    xrValue(1) = ""

                    If (dSet.Tables(TableName).Columns.Contains(xrValue(0))) Then

                        xrControl.DataBindings.Add(xrProperty, dSet, xrValue(0), ReplaceFormat(xrFormat))

                    Else

                        If (Not xrValue(0) = xrValue(1)) Then

                            If ((xrValue(0) = "FilterString") And (xrValue(1).IndexOf("[") > -1 Or xrValue(1).IndexOf("]") > -1)) Then

                                xrValue(1) = xrValue(1).Replace(" = ?", " is null")

                                If (xrValue(1).Length > 5) Then

                                    If (xrValue(1).Substring(xrValue(1).Length - 4, 4).ToLower() = " or ") Then xrValue(1) = xrValue(1).Substring(0, xrValue(1).Length - 4)

                                    If (xrValue(1).Substring(xrValue(1).Length - 5, 5).ToLower() = " and ") Then xrValue(1) = xrValue(1).Substring(0, xrValue(1).Length - 5)

                                End If

                                xrValue(1) = "* Filtered: " & xrValue(1).Replace("[", "{").Replace("]", "}")

                            End If

                            CallByName(xrControl, xrProperty, CallType.Let, xrValue(1))

                        End If

                    End If

                    If (xrFormat.Length > 0) Then xrFormat = "[fmt=" & xrFormat & "]"

                    xrTag = xrTag.Replace("<" & xrProperty & "=" & xrValue(0) & xrFormat & ">", "")

                End While

            ElseIf (xrControl.HasChildren) Then

                ProcessReport(dSet, TableName, xrControl.Controls)

            End If

        Next

    End Sub

#End Region

#Region " *** Logic Procedures (Public) *** "

    Public Sub GenerateGrid(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs, ByRef HeaderData As HtmlTable, ByVal dteFrom As Date, ByVal dteUntil As Date, ByRef Saved() As String)

        Dim Index() As Byte = {2, 0}

        Dim dteTemp As Date = dteFrom
        Dim dteTempU As Date = New Date(dteUntil.Year, dteUntil.Month, dteUntil.Day)

        Dim HeaderRow As New HtmlTableRow

        If (e.Item.ItemIndex = 0) Then

            Dim Header As New HtmlTable
            Dim HeaderSubRow() As HtmlTableRow = {New HtmlTableRow, New HtmlTableRow}

            HeaderRow.Cells.Add(New HtmlTableCell)

            HeaderRow.Attributes.Add("class", "dgHeader")

            HeaderRow.Cells(0).InnerText = "Employee"
            HeaderRow.Cells(0).RowSpan = 3
            HeaderRow.Cells(0).Style.Add("border", "solid 1px #A3C0E8")
            HeaderRow.Cells(0).Style.Add("text-align", "center")
            HeaderRow.Cells(0).Style.Add("vertical-align", "middle")

            If (Not IsString(Saved(3))) Then

                HeaderRow.Cells.Add(New HtmlTableCell)

                HeaderRow.Cells(1).InnerText = "Type"
                HeaderRow.Cells(1).RowSpan = 3
                HeaderRow.Cells(1).Style.Add("border", "solid 1px #A3C0E8")
                HeaderRow.Cells(1).Style.Add("border-left", "0px")
                HeaderRow.Cells(1).Style.Add("text-align", "center")
                HeaderRow.Cells(1).Style.Add("vertical-align", "middle")

            Else

                Index(0) = 1

            End If

            Dim MonthName As String

            Dim MonthIndex As Byte

            MonthName = dteTemp.ToString("MMM, yyyy")

            MonthIndex = 0

            While (dteTemp <= dteTempU)

                If ((Not MonthName = dteTemp.ToString("MMM, yyyy")) Or ((dteTemp = dteTempU) And (MonthName = dteTemp.ToString("MMM, yyyy")))) Then

                    HeaderRow.Cells.Add(New HtmlTableCell)

                    HeaderRow.Cells(Index(0)).ColSpan = Convert.ToInt32(MonthIndex + 1)

                    HeaderRow.Cells(Index(0)).InnerText = MonthName

                    HeaderRow.Cells(Index(0)).Style.Add("border", "solid 1px #A3C0E8")

                    HeaderRow.Cells(Index(0)).Style.Add("border-left", "0px")

                    HeaderRow.Cells(Index(0)).Style.Add("text-align", "center")

                    MonthName = dteTemp.ToString("MMM, yyyy")

                    MonthIndex = 0

                    Index(0) += 1

                End If

                HeaderSubRow(0).Cells.Add(New HtmlTableCell)

                HeaderSubRow(0).Cells(Index(1)).InnerText = dteTemp.ToString("ddd")

                HeaderSubRow(0).Cells(Index(1)).Style.Add("border-right", "solid 1px #A3C0E8")

                HeaderSubRow(0).Cells(Index(1)).Style.Add("text-align", "center")

                HeaderSubRow(0).Cells(Index(1)).Style.Add("width", "35px")

                HeaderSubRow(1).Cells.Add(New HtmlTableCell)

                HeaderSubRow(1).Cells(Index(1)).InnerText = dteTemp.ToString("dd")

                HeaderSubRow(1).Cells(Index(1)).Style.Add("border", "solid 1px #A3C0E8")

                HeaderSubRow(1).Cells(Index(1)).Style.Add("border-left", "0px")

                HeaderSubRow(1).Cells(Index(1)).Style.Add("border-top", "0px")

                HeaderSubRow(1).Cells(Index(1)).Style.Add("text-align", "center")

                HeaderSubRow(1).Cells(Index(1)).Style.Add("width", "35px")

                MonthIndex += 1

                Index(1) += 1

                dteTemp = dteTemp.AddDays(1)

            End While

            HeaderSubRow(0).Style.Add("background-image", "none")

            HeaderSubRow(0).Style.Add("padding", "2px 0px 2px 0px")

            HeaderSubRow(0).Style.Add("text-align", "center")

            HeaderSubRow(1).Style.Add("background-image", "none")

            HeaderSubRow(1).Style.Add("padding", "2px 0px 2px 0px")

            HeaderSubRow(1).Style.Add("text-align", "center")

            HeaderData.Rows.Add(HeaderRow)

            HeaderData.Rows.Add(HeaderSubRow(0))

            HeaderData.Rows.Add(HeaderSubRow(1))

        End If

        If (Not Saved(2) = "Status" AndAlso IsString(Saved(4)) AndAlso Saved(0) = e.Item.DataItem.Item("Employee") AndAlso Saved(1) = e.Item.DataItem.Item("Type") AndAlso Saved(2) = e.Item.DataItem.Item("Status")) Then

            HeaderRow = HeaderData.Rows(HeaderData.Rows.Count - 1)

        Else

            HeaderRow = New HtmlTableRow

            If (e.Item.ItemType = ListItemType.Item) Then

                HeaderRow.Style.Add("background-color", "#ffffff")

            ElseIf (e.Item.ItemType = ListItemType.AlternatingItem) Then

                HeaderRow.Style.Add("background-color", "#f7faff")

            End If

            HeaderRow.Style.Add("height", "22px")

        End If

        If (Not Saved(0) = e.Item.DataItem.Item("Employee") OrElse e.Item.ItemIndex = (TryCast(sender.DataSource, System.Data.DataTable).Rows.Count - 1)) Then Saved(0) = e.Item.DataItem.Item("Employee")

        If (Not Saved(1) = e.Item.DataItem.Item("Type") OrElse e.Item.ItemIndex = (TryCast(sender.DataSource, System.Data.DataTable).Rows.Count - 1)) Then Saved(1) = e.Item.DataItem.Item("Type")

        If (Not Saved(2) = e.Item.DataItem.Item("Status") OrElse e.Item.ItemIndex = (TryCast(sender.DataSource, System.Data.DataTable).Rows.Count - 1)) Then Saved(2) = e.Item.DataItem.Item("Status")

        If (HeaderRow.Cells.Count = 0) Then

            HeaderRow.Cells.Add(New HtmlTableCell)

            HeaderRow.Cells.Add(New HtmlTableCell)

        End If

        If (Not HeaderRow.Cells(0).InnerText = e.Item.DataItem.Item("Employee")) Then HeaderRow.Cells(0).InnerText = e.Item.DataItem.Item("Employee")

        If (HeaderRow.Cells(0).Style.Count = 0) Then

            HeaderRow.Cells(0).Style.Add("border", "solid 1px #A3C0E8")
            HeaderRow.Cells(0).Style.Add("border-top", "0px")
            HeaderRow.Cells(0).Style.Add("padding-left", "5px")

            HeaderRow.Cells(0).Style.Add("border-bottom", "0px")

            HeaderRow.Cells(0).Style.Add("border-bottom", "solid 1px #A3C0E8")

        End If

        If (Not IsString(Saved(3)) AndAlso Not HeaderRow.Cells(1).InnerText = e.Item.DataItem.Item("Type")) Then HeaderRow.Cells(1).InnerText = e.Item.DataItem.Item("Type")

        If (HeaderRow.Cells(1).Style.Count = 0) Then

            HeaderRow.Cells(1).Style.Add("border", "solid 1px #A3C0E8")
            HeaderRow.Cells(1).Style.Add("border-left", "0px")
            HeaderRow.Cells(1).Style.Add("border-top", "0px")
            HeaderRow.Cells(1).Style.Add("padding-left", "5px")

            HeaderRow.Cells(1).Style.Add("border-bottom", "0px")

            HeaderRow.Cells(1).Style.Add("border-bottom", "solid 1px #A3C0E8")

        End If

        Index(0) = If(Not IsString(Saved(3)), 2, 1)

        Dim dteEmpFrom As Date
        Dim dteEmpUntil As Date

        Dim SetBackground As Boolean

        Dim bCreated As Boolean

        dteTemp = dteFrom

        dteTempU = New Date(dteUntil.Year, dteUntil.Month, dteUntil.Day)

        While (dteTemp <= dteTempU)

            SetBackground = False

            If ((HeaderRow.Cells.Count - 1) < Index(0)) Then

                HeaderRow.Cells.Add(New HtmlTableCell)

                bCreated = True

            Else

                bCreated = False

            End If

            If (Not HeaderRow.Cells(Index(0)).InnerHtml = "&nbsp;") Then HeaderRow.Cells(Index(0)).InnerHtml = "&nbsp;"

            If (bCreated) Then

                HeaderRow.Cells(Index(0)).Style.Add("border", "solid 1px #A3C0E8")

                HeaderRow.Cells(Index(0)).Style.Add("border-left", "0px")

                HeaderRow.Cells(Index(0)).Style.Add("border-top", "0px")

            End If

            If (IsDate(e.Item.DataItem.Item("From")) AndAlso IsDate(e.Item.DataItem.Item("Until"))) Then

                dteEmpFrom = Convert.ToDateTime(e.Item.DataItem.Item("From"))

                dteEmpFrom = New Date(dteEmpFrom.Year, dteEmpFrom.Month, dteEmpFrom.Day)

                dteEmpUntil = Convert.ToDateTime(e.Item.DataItem.Item("Until"))

                dteEmpUntil = New Date(dteEmpUntil.Year, dteEmpUntil.Month, dteEmpUntil.Day)

                If (dteTemp >= dteEmpFrom AndAlso dteTemp <= dteEmpUntil) Then

                    If (e.Item.DataItem.Item("Duration") = 0.25 AndAlso Not HeaderRow.Cells(Index(0)).InnerHtml = "&frac14;") Then HeaderRow.Cells(Index(0)).InnerHtml = "&frac14;"

                    If (e.Item.DataItem.Item("Duration") = 0.5 AndAlso Not HeaderRow.Cells(Index(0)).InnerHtml = "&frac12;") Then HeaderRow.Cells(Index(0)).InnerHtml = "&frac12;"

                    If (e.Item.DataItem.Item("Duration") = 0.75 AndAlso Not HeaderRow.Cells(Index(0)).InnerHtml = "&frac34;") Then HeaderRow.Cells(Index(0)).InnerHtml = "&frac34;"

                    Select Case e.Item.DataItem.Item("Status").ToString().ToLower()

                        Case "new"
                            If (bCreated) Then

                                HeaderRow.Cells(Index(0)).Style.Add("background-color", "#1e90ff")

                            Else

                                HeaderRow.Cells(Index(0)).Style.Item("background-color") = "#1e90ff"

                            End If

                        Case "hod accepted"
                            If (bCreated) Then

                                HeaderRow.Cells(Index(0)).Style.Add("background-color", "#5f9ea0")

                            Else

                                HeaderRow.Cells(Index(0)).Style.Item("background-color") = "#5f9ea0"

                            End If

                        Case "hr granted"
                            If (bCreated) Then

                                HeaderRow.Cells(Index(0)).Style.Add("background-color", "#32cd32")

                            Else

                                HeaderRow.Cells(Index(0)).Style.Item("background-color") = "#32cd32"

                            End If

                        Case "hr declined", "hod declined"
                            If (bCreated) Then

                                HeaderRow.Cells(Index(0)).Style.Add("background-color", "#dc143c")

                            Else

                                HeaderRow.Cells(Index(0)).Style.Item("background-color") = "#dc143c"

                            End If

                        Case "cancelled"
                            If (bCreated) Then

                                HeaderRow.Cells(Index(0)).Style.Add("background-color", "#cd853f")

                            Else

                                HeaderRow.Cells(Index(0)).Style.Item("background-color") = "#cd853f"

                            End If

                    End Select

                    'Public Holidy
                    'Case "" '696969

                    'Weekend Day

                Else

                    SetBackground = True

                End If

            Else

                SetBackground = True

            End If

            If (bCreated) Then

                If (SetBackground) Then

                    If (e.Item.ItemType = ListItemType.Item) Then

                        HeaderRow.Cells(Index(0)).Style.Add("background-color", "#ffffff")

                    ElseIf (e.Item.ItemType = ListItemType.AlternatingItem) Then

                        HeaderRow.Cells(Index(0)).Style.Add("background-color", "#f7faff")

                    End If

                End If

                HeaderRow.Cells(Index(0)).Style.Add("text-align", "center")

            End If

            Index(0) += 1

            dteTemp = dteTemp.AddDays(1)

        End While

        If (bCreated) Then HeaderData.Rows.Add(HeaderRow)

        If (e.Item.ItemIndex = (TryCast(sender.DataSource, System.Data.DataTable).Rows.Count - 1)) Then CType(e.Item.FindControl("phControls_Rows"), PlaceHolder).Controls.Add(HeaderData)

    End Sub

    Public Sub GridFormat(ByRef dgView As ASPxGridView, ByVal Template As String)

        Try

            If (Not IsNull(dgView)) Then

                For iLoop As Integer = 0 To (dgView.Columns.Count - 1)

                    If (TypeOf dgView.Columns(iLoop) Is GridViewDataDateColumn) Then

                        With CType(dgView.Columns(iLoop), GridViewDataDateColumn).PropertiesDateEdit

                            If (Not .EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                                .DisplayFormatString = GetArrayItem(Template, "eGeneral.DateFormat")

                                .EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom

                                .EditFormatString = .DisplayFormatString

                            End If

                        End With

                    End If

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

    End Sub

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="cmbDropdown"></param>
    ''' <param name="Text"></param>
    Public Sub LoadExpCmb(ByRef cmbDropdown As ASPxComboBox, ByVal Text As String)

        If (cmbDropdown.Items.Count = 0) Then cmbDropdown.DataBind()

        If (IsNull(cmbDropdown.Items.FindByText(Text))) Then cmbDropdown.Items.Insert(0, New DevExpress.Web.ASPxEditors.ListEditItem(Text))

        Dim liEmpty As DevExpress.Web.ASPxEditors.ListEditItem = cmbDropdown.Items.FindByText(String.Empty)

        While (Not IsNull(liEmpty))

            cmbDropdown.Items.Remove(liEmpty)

            liEmpty = cmbDropdown.Items.FindByText(String.Empty)

        End While

    End Sub

    Public Sub LoadExpDS(ByRef dsSource As SqlDataSource, ByVal SQL As String)

        If (Not IsNull(dsSource)) Then

            dsSource.ConnectionString = SQLString
            dsSource.SelectCommand = SQL

        End If

    End Sub

    Public Sub LoadExpGrid(ByRef Session As HttpSessionState, ByRef dgView As ASPxGridView, ByVal Template As String, ByVal SQL As String, Optional ByVal CacheKey As String = "")

        Dim ColumnName As String = String.Empty

        Dim SQLCalculated As String = String.Empty

        Dim SQLColumns As String = String.Empty

        Dim SQLNullable As String = String.Empty

        Dim SQLRequired As String = String.Empty

        Dim SQLBuild As String = String.Empty

        Dim SelectKey As String = String.Empty

        Dim Tablename As String = String.Empty

        Dim Join As String = String.Empty

        Dim PrimaryKey As String = String.Empty

        Dim InsertKey As String = String.Empty

        Dim Columns As String = String.Empty

        Dim WhereKey As String = String.Empty

        Dim ColumnOrder As String = String.Empty

        Dim OrderType As String = String.Empty

        Dim SQLSelect As String = String.Empty

        Dim SQLDelete As String = String.Empty

        Dim SQLInsert As String = String.Empty

        Dim SQLUpdate As String = String.Empty

        Dim dRequired As DataTable = Nothing

        Dim dColumns As DataTable = Nothing

        Dim NewPrimaryKey As String = String.Empty

        Dim KeyColumns() As String = Nothing

        Dim ColumnsInsert As String = String.Empty

        Dim ColumnsAs() As String = Nothing

        Dim SecurityElements As String = String.Empty

        Try

            If (Not IsNull(dgView)) Then

                SQLBuild = SQL

                SelectKey = GetXML(SQLBuild, KeyName:="Select")

                Tablename = GetXML(SQLBuild, KeyName:="Tablename")

                Join = GetXML(SQLBuild, KeyName:="Join")

                PrimaryKey = GetXML(SQLBuild, KeyName:="PrimaryKey")

                InsertKey = GetXML(SQLBuild, KeyName:="InsertKey")

                Columns = GetXML(SQLBuild, KeyName:="Columns")

                WhereKey = GetXML(SQLBuild, KeyName:="Where")

                ColumnOrder = GetXML(SQLBuild, KeyName:="ColumnOrder")

                OrderType = GetXML(SQLBuild, KeyName:="OrderType")

                SQLSelect = GetXML(SQLBuild, KeyName:="CustomSelectQuery", OpenKey:="<<", CloseKey:=">>")

                If SQLSelect.Length = 0 Then
                    SQLSelect = GetXML(SQLBuild, KeyName:="CustomSelectQuery")
                End If

                If SQLSelect.Length = 0 Then

                    SQLSelect = "select " & IIf(SelectKey.Length > 0, SelectKey & " ", String.Empty) & PrimaryKey & " as [CompositeKey], " & Columns & " from"

                    If (Join.Length = 0) Then

                        SQLSelect &= " [" & Tablename & "]"

                    Else

                        SQLSelect &= " " & Join.Replace("{%Tablename%}", Tablename)

                    End If

                End If

                SQLDelete = "delete from [" & Tablename & "] where (" & PrimaryKey & " = [%CompositeKey%])"

                SQLInsert = "insert into [" & Tablename & "]([%Columns%]) values([%Values%])"

                SQLUpdate = "update [" & Tablename & "] set [%Columns%] where (" & PrimaryKey & " = [%CompositeKey%])"

                If (dgView.SettingsText.Title.Length = 0) Then

                    dRequired = GetSQLDT("select distinct [name] from [syscolumns] where (not (columnproperty([id], [name], 'IsIdentity') = 1)) and (not (columnproperty([id], [name], 'IsRowGuidCol') = 1)) and ((([id] = object_id('[" & Tablename & "]')) and ([isnullable] = 0) and ([cdefault] = 0) and ([iscomputed] = 0)) or ([id] = object_id('[" & Tablename & "]') and [name] in(select B.COLUMN_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS A, INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE B WHERE CONSTRAINT_TYPE = 'primary key' AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME AND A.TABLE_NAME = '" & Tablename & "')))", "Data." & Tablename & ".Structure")

                    If (IsData(dRequired)) Then

                        For iLoop As Integer = 0 To (dRequired.Rows.Count - 1)

                            SQLRequired &= "[" & dRequired.Rows(iLoop).Item("name").ToString() & "]"

                        Next

                    End If

                    dColumns = GetSQLDT("select [name], [isnullable], [cdefault], [iscomputed] from [syscolumns] where ([id] = object_id('[" & Tablename & "]'))", "Data." & Tablename & ".Nullable")

                    If (IsData(dColumns)) Then

                        For iLoop As Integer = 0 To (dColumns.Rows.Count - 1)

                            ColumnName = dColumns.Rows(iLoop).Item("name").ToString()

                            If (Not Convert.ToBoolean(dColumns.Rows(iLoop).Item("iscomputed"))) Then

                                SQLColumns &= "[" & ColumnName & "]"

                            Else

                                SQLCalculated &= "[" & ColumnName & "]"

                            End If

                            If ((Not Convert.ToBoolean(dColumns.Rows(iLoop).Item("isnullable"))) And (Not SQLRequired.Contains("[" & ColumnName & "]"))) Then

                                'If (Not Convert.ToBoolean(dColumns.Rows(iLoop).Item("cdefault")) AndAlso Not Convert.ToBoolean(dColumns.Rows(iLoop).Item("iscomputed"))) Then SQLNullable &= "[" & ColumnName & "]"

                                SQLNullable &= "[" & ColumnName & "]"

                            End If

                        Next

                    End If

                    dgView.SettingsText.Title = "<Columns=" & SQLColumns & "><Calc=" & SQLCalculated & "><NotNull=" & SQLNullable & "><Required=" & SQLRequired & ">"

                Else

                    SQLColumns = GetXML(dgView.SettingsText.Title, KeyName:="Columns")

                    SQLCalculated = GetXML(dgView.SettingsText.Title, KeyName:="Calc")

                    SQLNullable = GetXML(dgView.SettingsText.Title, KeyName:="NotNull")

                    SQLRequired = GetXML(dgView.SettingsText.Title, KeyName:="Required")

                End If

                If Not SQLBuild.Contains("CustomSelectQuery") Then

                    If (WhereKey.Length > 0) Then SQLSelect &= " where " & WhereKey

                    If (ColumnOrder.Length > 0) Then SQLSelect &= " order by " & ColumnOrder

                    If (OrderType.Length > 0) Then SQLSelect &= " " & OrderType

                End If

                NewPrimaryKey = PrimaryKey.Replace(" + '", String.Empty).Replace("' + ", String.Empty)

                KeyColumns = NewPrimaryKey.Split(" ")

                If (Columns.ToLower().Contains(" as ")) Then

                    ColumnsAs = Columns.Split(",")

                    For iLoop As Integer = 0 To (ColumnsAs.GetLength(0) - 1)

                        If (Not SQLColumns.Contains(ColumnsAs(iLoop).Trim())) Then Columns = Columns.Replace(ColumnsAs(iLoop) & ",", String.Empty)

                    Next

                    Columns = Regex.Replace(Columns, EscapeRegex("'') as "), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                End If

                For iLoop As Integer = 0 To (KeyColumns.GetLength(0) - 1)

                    If (KeyColumns(iLoop).Contains("convert(nvarchar(19), ")) Then KeyColumns(iLoop) = KeyColumns(iLoop).Replace("convert(nvarchar(19), ", String.Empty).Replace(", 120)", String.Empty)

                    If (Not Columns.Contains(KeyColumns(iLoop))) AndAlso (SQLRequired.Contains(KeyColumns(iLoop))) Then ColumnsInsert &= KeyColumns(iLoop) & ", "

                Next

                If (ColumnsInsert.Length > 0) Then Columns = ColumnsInsert & Columns

                If (SQLCalculated.Length > 0) Then

                    Dim cColumns() As String = SQLCalculated.Replace("][", ",").Replace("[", String.Empty).Replace("]", String.Empty).Split(",")

                    For iLoop As Integer = 0 To (cColumns.GetLength(0) - 1)

                        If (Columns.Contains("[" & cColumns(iLoop) & "]")) Then Columns = Columns.Replace(", [" & cColumns(iLoop) & "]", String.Empty).Replace("[" & cColumns(iLoop) & "], ", String.Empty).Replace("[" & cColumns(iLoop) & "]", String.Empty)

                    Next

                End If

                SQLInsert = SQLInsert.Replace("[%Columns%]", Columns.Trim())

                SQLInsert = SQLInsert.Replace("[%Values%]", IIf(InsertKey.Length > 0, InsertKey & ", ", String.Empty) & "[%Values%]")

                dgView.DataSource = GetSQLDT(SQLSelect.Replace("&lt;", "<").Replace("&gt;", ">"), CacheKey)

                If (IsNull(dgView.SettingsText.Title)) Then dgView.SettingsText.Title = String.Empty

                dgView.SettingsText.Title &= "<DeleteCommand=" & SQLDelete & ">"

                If (Not InsertKey = "insert into [" & Tablename & "]([%Columns%]) values([%Values%])") Then dgView.SettingsText.Title &= "<InsertCommand=" & SQLInsert & ">"

                dgView.SettingsText.Title &= "<UpdateCommand=" & SQLUpdate & ">"

                SecurityElements = GetSecurity(Session, Template)

                GridFormat(dgView, GetXML(SecurityElements, KeyName:="TemplateCode"))

                dgView.DataBind()

                If (Not Convert.ToBoolean(GetXML(SecurityElements, KeyName:="fView").ToLower() = "true")) AndAlso (Not IsNull(dgView.Columns("select"))) Then dgView.Columns("select").Visible = False

                If (Not Convert.ToBoolean(GetXML(SecurityElements, KeyName:="fAdd").ToLower() = "true")) Then dgView.Settings.ShowStatusBar = GridViewStatusBarMode.Hidden

                If (Not Convert.ToBoolean(GetXML(SecurityElements, KeyName:="fEdit").ToLower() = "true")) AndAlso (Not IsNull(dgView.Columns("edit"))) Then dgView.Columns("edit").Visible = False

                If (Not Convert.ToBoolean(GetXML(SecurityElements, KeyName:="fDelete").ToLower() = "true")) AndAlso (Not IsNull(dgView.Columns("delete"))) Then dgView.Columns("delete").Visible = False

                If (Not Convert.ToBoolean(GetXML(SecurityElements, KeyName:="fPrint").ToLower() = "true")) AndAlso (Not IsNull(dgView.Columns("print"))) Then dgView.Columns("print").Visible = False

                dgView.SettingsEditing.EditFormColumnCount = 3

                dgView.SettingsEditing.Mode = GridViewEditingMode.EditForm

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(ColumnsAs)) Then ColumnsAs = Nothing

            If (Not IsNull(KeyColumns)) Then KeyColumns = Nothing

            If (Not IsNull(dColumns)) Then

                dColumns.Dispose()

                dColumns = Nothing

            End If

            If (Not IsNull(dRequired)) Then

                dRequired.Dispose()

                dRequired = Nothing

            End If

        End Try

    End Sub

    Public Sub SetComboValue(ByRef cmbDropdown As ASPxComboBox, ByVal Value As String)

        If (cmbDropdown.Items.Count > 0) Then

            If (Not IsNull(cmbDropdown.Items.FindByText(Value))) Then

                cmbDropdown.Value = Value

            ElseIf (Not IsNull(cmbDropdown.Items.FindByText("<select>"))) Then

                cmbDropdown.Value = "<select>"

            End If

        End If

    End Sub

    Public Sub SetExpControl(ByRef dgView As ASPxGridView, ByVal sCtlID As String, ByVal sProcName As String, ByVal objValue As Object)

        CallByName(FindGridControl(dgView, sCtlID), sProcName, CallType.Set, objValue)

    End Sub

#End Region

#Region " *** Logic Functions (Private) *** "

    Private Function FindGridControl(ByRef dgView As ASPxGridView, ByVal CtlID As String, Optional ByVal bAddEditKey As Boolean = True) As Object

        Dim sGridID(1) As String

        If (dgView.ID.Contains("_")) Then

            sGridID(0) = dgView.ID.Substring(0, dgView.ID.IndexOf("_"))
            sGridID(1) = dgView.ID.Replace(sGridID(0), String.Empty)

        Else

            sGridID(0) = dgView.ID
            sGridID(1) = String.Empty

        End If

        Dim pageControl As DevExpress.Web.ASPxTabControl.ASPxPageControl = TryCast(CType(dgView.Parent.FindControl(sGridID(0) & sGridID(1)), ASPxGridView).FindEditFormTemplateControl("pageControl" & sGridID(1)), ASPxPageControl)

        If (Not IsNull(pageControl)) Then

            Return pageControl.FindControl(CtlID.ToLower() & IIf(bAddEditKey, "Editor" & sGridID(1), String.Empty))

        Else

            Return dgView.FindEditFormTemplateControl(CtlID.ToLower() & IIf(bAddEditKey, "Editor" & sGridID(1), String.Empty))

        End If

    End Function

    Private Function ReplaceFormat(ByVal Format As String) As String

        Dim ReturnText As String = Format

        ReturnText = Regex.Replace(ReturnText, EscapeRegex("(%DateFormat)%)"), GetArrayItem(Nothing, "eGeneral.DateFormat"), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        Return ReturnText

    End Function

#End Region

#Region " *** Logic Functions (Public) *** "

    Private Function CRReplaceLogon(ByRef cReport As ReportDocument, ByVal cReportConnect As ConnectionInfo) As Boolean

        Dim Value As Boolean = False

        Dim cLogonInfo As TableLogOnInfo = Nothing

        Try

            If (Not cReport.IsSubreport) Then

                For Each cReportChild As ReportDocument In cReport.Subreports

                    If (Not Value) Then

                        Value = CRReplaceLogon(cReportChild, cReportConnect)

                    Else

                        CRReplaceLogon(cReportChild, cReportConnect)

                    End If

                Next

            End If

            For Each cTable As Table In cReport.Database.Tables

                If (Not Value AndAlso IsString(cTable.Name) AndAlso Regex.IsMatch(cTable.Name, "ReportsResultSet", RegexOptions.IgnoreCase Or RegexOptions.Singleline)) Then Value = True

                cLogonInfo = cTable.LogOnInfo

                If (Not IsNull(cLogonInfo)) Then

                    cLogonInfo.ConnectionInfo = cReportConnect

                    cTable.ApplyLogOnInfo(cLogonInfo)

                    cLogonInfo = Nothing

                End If

            Next

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(cLogonInfo)) Then cLogonInfo = Nothing

        End Try

        Return Value

    End Function

    Public Function CreateReport(ByVal SessionID As String, ByVal Group As String, ByVal Path As String, ByVal Title As String, ByVal Secured As Boolean, ByVal OpenPwd As String, ByVal ParamArray pParams() As Object) As String
        CreateReport(SessionID, Group, Path, Title, Secured, OpenPwd, Nothing, pParams)
    End Function

    Public Function CreateReport(ByVal SessionID As String, ByVal Group As String, ByVal Path As String, ByVal Title As String, ByVal Secured As Boolean, ByVal OpenPwd As String, ByVal rParams() As Object, ByVal ParamArray pParams() As Object) As String

        Dim ReturnText As String = ""

        Dim dtReport As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim XRPath As String = String.Empty

        Dim SQL As String = String.Empty

        Dim dtData As DataSet = Nothing

        Dim xrReport As XtraReport = Nothing

        Dim xrBandTag As String = String.Empty

        Dim xrGroupField As GroupField = Nothing

        Dim xrProtectBands As String = "[BottomMargin][PageFooter][PageHeader][ReportHeader]"

        Dim xrFilename As String = String.Empty

        Dim cReport As ReportDocument = Nothing

        Dim cReportConnect As ConnectionInfo = Nothing

        Dim cLogonInfo As TableLogOnInfo = Nothing

        Dim crValues As ParameterValues = Nothing

        Dim crValue As ParameterDiscreteValue = Nothing

        Dim xParams As Integer = 0

        Dim dAccessTo As DataTable = Nothing

        Dim bUpdate As Boolean = False

        Dim ReportID As Integer = 0

        Dim ReportData() As Object = Nothing

        Dim Value() As String = Nothing

        Dim reportViewer As ReportViewer = Nothing

        Dim fileBytes As Byte() = Nothing

        Dim fileStream As FileStream = Nothing

        Try

            If (Not IsNumeric(Title)) Then

                dtReport = GetSQLDT("select [ID], [Title], [Path], [SQL] from [ess.ReportsLU]", "Data.ReportLU")

            Else

                dtReport = GetSQLDT("select [ID], [ModuleID], (select top 1 [TemplateElement] from [ess.ModuleLU] where ([ID] = [ess.Users.ReportsLU].[ModuleID])) as [TemplateElement], [Template], [Name], [ReportUri], [SQL], [CreatedBy], [CreatedOn] from [ess.Users.ReportsLU]", "Data.Users.ReportLU")

            End If

            If (IsData(dtReport)) Then

                If (Not IsNumeric(Title)) Then

                    dtRows = dtReport.Select("[Title] = '" & Title & "'")

                Else

                    dtRows = dtReport.Select("[ID] = " & Title)

                    If (Not IsNull(dtRows) AndAlso dtRows.Length > 0) Then ReportData = dtRows(0).ItemArray()

                End If

                If (Not IsNull(dtRows)) Then

                    If (dtRows.Length > 0) Then

                        If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                            XRPath = ReplaceParams(True, dtRows(0).Item(If(Not IsNumeric(Title), "Path", "ReportUri")).ToString(), pParams)

                            If (Not IsNull(dtRows(0).Item("SQL"))) Then SQL = ReplaceParams(False, dtRows(0).Item("SQL"), pParams)

                        Else

                            XRPath = dtRows(0).Item(If(Not IsNumeric(Title), "Path", "ReportUri")).ToString()

                            If (Not IsNull(dtRows(0).Item("SQL"))) Then SQL = dtRows(0).Item("SQL")

                        End If

                        If (IsString(XRPath)) Then

                            XRPath = Regex.Replace(XRPath, "^~/", ServerPath & "\", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                            XRPath = Regex.Replace(XRPath, "^reports/", ServerPath & "\reports\", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                            XRPath = Regex.Replace(XRPath, "/", "\", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                        End If

                        If (IsString(SQL)) Then dtData = GetSQLDS(SQL, Title)

                        If (IsData(dtData) AndAlso XRPath.ToLower().EndsWith(".repx")) Then

                            xrReport = XtraReport.FromFile(XRPath, True)

                            If (Not IsNull(xrReport)) Then

                                xrReport.DataMember = Title

                                xrReport.DataSource = dtData

                                xrReport.ExportOptions.Pdf.Compressed = True

                                xrReport.ExportOptions.Pdf.ImageQuality = DevExpress.XtraPrinting.PdfJpegImageQuality.Highest

                                With xrReport.ExportOptions.Pdf.DocumentOptions

                                    .Application = "SmartHR: Employee Self Service"
                                    .Author = "Absalom Systems (Pty) Ltd."
                                    .Subject = "Generated on " & Now.ToLongDateString()
                                    .Title = Title.ToUpper()

                                End With

                                If (Secured) Then

                                    With xrReport.ExportOptions.Pdf.PasswordSecurityOptions

                                        'If (IsString(OpenPwd)) Then .OpenPassword = OpenPwd

                                        .PermissionsOptions.ChangingPermissions = DevExpress.XtraPrinting.ChangingPermissions.None
                                        .PermissionsOptions.EnableCoping = False
                                        .PermissionsOptions.EnableScreenReaders = True
                                        .PermissionsPassword = EncPwd
                                        .PermissionsOptions.PrintingPermissions = DevExpress.XtraPrinting.PrintingPermissions.LowResolution

                                    End With

                                End If

                                For Each xrBand As Band In xrReport.Bands

                                    xrBandTag = GetXML(xrBand.Tag, KeyName:="GroupFields")

                                    If (xrBandTag.Length > 0) Then

                                        Dim BandMappings() As String = xrBandTag.Split(";")

                                        If (BandMappings.GetUpperBound(0) > -1) Then

                                            Dim iLoopBands As Integer

                                            For iLoopBands = 0 To BandMappings.GetUpperBound(0)

                                                xrGroupField = New GroupField(BandMappings(iLoopBands))

                                                TryCast(xrBand, GroupHeaderBand).GroupFields.Add(xrGroupField)

                                            Next

                                        End If

                                    End If

                                    If (xrProtectBands.IndexOf("[" & xrBand.Name & "]") = -1 AndAlso xrReport.DataSource.Tables(Title).DefaultView.Count = 0) Then

                                        xrBand.Visible = False

                                    Else

                                        If (xrBand.HasChildren) Then ProcessReport(dtData, Title, xrBand.Controls)

                                    End If

                                Next

                                xrReport.CreateDocument()

                                If (dtData.Tables(Title).Columns.Contains("ID")) Then

                                    xrFilename = dtData.Tables(Title).Rows(0).Item("ID").ToString()

                                Else

                                    xrFilename = Title

                                End If

                                If (Not Directory.Exists(ServerPath & "\reports\cache\")) Then Directory.CreateDirectory(ServerPath & "\reports\cache\")

                                xrReport.ExportToPdf(ServerPath & "\reports\cache\" & xrFilename.ToLower() & ".pdf")

                                ReturnText = ServerPath & "\reports\cache\" & xrFilename.ToLower() & ".pdf"

                            End If

                        ElseIf (XRPath.ToLower().EndsWith(".rpt")) Then

                            cReport = New ReportDocument()

                            cReport.Load(XRPath)

                            cReportConnect = New ConnectionInfo()

                            With cReportConnect

                                .ServerName = SQLServer.Server

                                .DatabaseName = SQLServer.Database

                                .UserID = SQLServer.Username

                                .Password = SQLServer.Password

                            End With

                            bUpdate = CRReplaceLogon(cReport, cReportConnect)

                            If (Not IsNull(pParams) AndAlso pParams.Length > 0) Then

                                xParams = (pParams.Length - 1)

                                If (TypeOf pParams(xParams) Is Array) Then

                                    Dim Index As Integer = 0

                                    With cReport.DataDefinition

                                        For i As Integer = 0 To (.ParameterFields.Count - 1)

                                            crValues = New ParameterValues()

                                            crValue = New ParameterDiscreteValue()

                                            If (Not IsString(.ParameterFields(i).ReportName)) Then

                                                If (Index < pParams(xParams).Length) Then

                                                    If (Not IsNull(pParams(xParams)(Index))) Then

                                                        crValue.Value = pParams(xParams)(Index)

                                                        crValues.Add(crValue)

                                                        .ParameterFields(i).ApplyCurrentValues(crValues)

                                                    End If

                                                    Index += 1

                                                End If

                                            End If

                                            If (Not IsNull(crValue)) Then crValue = Nothing

                                            If (Not IsNull(crValues)) Then

                                                crValues.Clear()

                                                crValues = Nothing

                                            End If

                                        Next

                                    End With

                                End If

                                If (IsString(cReport.RecordSelectionFormula)) Then cReport.RecordSelectionFormula = ReplaceParams(False, Regex.Replace(cReport.RecordSelectionFormula, "(""\{)(.*?)(\}"")", "{$2}", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline), pParams)

                            Else

                                If (IsString(cReport.RecordSelectionFormula)) Then cReport.RecordSelectionFormula = Regex.Replace(cReport.RecordSelectionFormula, "(""\{)(.*?)(\}"")", "{$2}", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                            End If

                            If (bUpdate AndAlso Not IsNull(ReportData) AndAlso ReportData.Length > 0 AndAlso IsString(Group) AndAlso IsString(SessionID)) Then

                                ReportID = New Random().Next(1, 10000)

                                ExecSQL("delete from [ReportsResultSet] where ([ReportID] = " & ReportID.ToString() & ")")

                                If (IsString(ReportData(2))) Then

                                    dAccessTo = GetUserGroupAcc(Group, SessionID, SQLWhere:="[a].[TemplateCode] = (select top 1 [Code] from [UserGroupTemplateRights] where ([Code] = [a].[TemplateCode] and [DataElement] = '" & ReportData(2) & "' and [fPrint] = 1))")

                                Else

                                    dAccessTo = GetUserGroupAcc(Group, SessionID)

                                End If

                                If (IsData(dAccessTo)) Then

                                    For i As Integer = 0 To (dAccessTo.Rows.Count - 1)

                                        Value = dAccessTo.Rows(i).Item("Value").ToString().Split(" ")

                                        ExecSQL("insert into [ReportsResultSet]([CompanyNum], [EmployeeNum], [ReportID]) values('" & Value(0) & "', '" & Value(1) & "', " & ReportID & ")")

                                    Next

                                    If (IsString(cReport.RecordSelectionFormula)) Then cReport.RecordSelectionFormula = "(" & cReport.RecordSelectionFormula.Trim() & ") and "

                                    cReport.RecordSelectionFormula &= "{ReportsResultSet.ReportID} = " & ReportID.ToString()

                                End If

                            End If

                            xrFilename = Guid.NewGuid().ToString() & ".pdf"

                            If (Not Directory.Exists(ServerPath & "\reports\cache\")) Then Directory.CreateDirectory(ServerPath & "\reports\cache\")

                            cReport.ExportToDisk(ExportFormatType.PortableDocFormat, ServerPath & "\reports\cache\" & xrFilename.ToLower())

                            ReturnText = ServerPath & "\reports\cache\" & xrFilename.ToLower()

                        ElseIf (XRPath.ToLower().EndsWith(".rdl")) Then

                            reportViewer = New ReportViewer()

                            With reportViewer

                                .ProcessingMode = ProcessingMode.Local

                                .LocalReport.ReportPath = XRPath

                                .LocalReport.DataSources.Clear()

                                If (Not (IsNothing(rParams))) Then

                                    Dim params(1) As ReportParameter

                                    Array.Resize(params, rParams.Length)

                                    For i As Byte = 0 To (rParams.Length - 1)

                                        Dim paramPair As String() = rParams(i).ToString().Split("|")

                                        Dim param1 As ReportParameter = New ReportParameter()
                                        param1.Name = paramPair(0)
                                        param1.Values.Add(paramPair(1))

                                        params(i) = param1

                                    Next

                                    .LocalReport.SetParameters(params)

                                End If

                                If Not IsNull(dtData) AndAlso dtData.Tables.Count > 0 Then

                                    .LocalReport.DataSources.Add(New ReportDataSource("dsData", dtData.Tables(0)))

                                End If

                                If Title = "External Budget Monitoring" AndAlso pParams(3) = "2" Or
                                    Title = "TWS" Then

                                    xrFilename = Guid.NewGuid().ToString() & ".xls"

                                    fileBytes = .LocalReport.Render("Excel")

                                Else

                                    xrFilename = Guid.NewGuid().ToString() & ".pdf"

                                    fileBytes = .LocalReport.Render("PDF")

                                End If

                                If (Not Directory.Exists(ServerPath & "\reports\cache\")) Then Directory.CreateDirectory(ServerPath & "\reports\cache\")

                                ReturnText = ServerPath & "\reports\cache\" & xrFilename.ToLower()

                                fileStream = New FileStream(ReturnText, FileMode.Create, FileAccess.ReadWrite)

                                fileStream.Write(fileBytes, 0, fileBytes.Length)

                                fileStream.Flush()

                            End With

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

            ReturnText = ex.ToString()

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dAccessTo)) Then

                dAccessTo.Dispose()

                dAccessTo = Nothing

            End If

            If (Not IsNull(xrReport)) Then

                xrReport.Dispose()

                xrReport = Nothing

            End If

            If (Not IsNull(dtData)) Then

                dtData.Dispose()

                dtData = Nothing

            End If

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtReport)) Then

                dtReport.Dispose()

                dtReport = Nothing

            End If

            If (Not IsNull(crValue)) Then crValue = Nothing

            If (Not IsNull(crValues)) Then

                crValues.Clear()

                crValues = Nothing

            End If

            If (Not IsNull(cLogonInfo)) Then cLogonInfo = Nothing

            If (Not IsNull(cReportConnect)) Then cReportConnect = Nothing

            If (Not IsNull(cReport)) Then

                cReport.Close()

                cReport.Dispose()

                cReport = Nothing

            End If

            If Not IsNull(reportViewer) Then

                reportViewer.Dispose()

                reportViewer = Nothing

            End If

            fileBytes = Nothing

            If Not IsNull(fileStream) Then

                fileStream.Close()

                fileStream.Dispose()

                fileStream = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetBalance(ByVal Template As String, ByVal IgnoreBalance As Boolean, ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal LeaveType As String, ByVal LeaveScheme As String, ByVal BalanceDate As Date, ByVal bCheckALL As Boolean, Optional ByVal bReduceDays As Integer = 0) As String

        Dim ReturnText As String = String.Empty

        Dim dtBalances As DataTable = Nothing

        Dim DecimalPlaces As Integer = 2

        Try

            Dim objSetting As Object = GetSQLField("select [SettingValue] from [GlobalSettings] where ([SettingName] = 'Leave Balance Display - Number of Decimals')", "SettingValue")

            If (Not IsNull(objSetting) AndAlso IsNumeric(objSetting)) Then DecimalPlaces = Convert.ToInt32(objSetting)

            If (IsDate(BalanceDate)) Then

                Dim Balances As String = String.Empty

                BalanceDate = BalanceDate.AddDays(bReduceDays)

                If (Not IgnoreBalance) Then

                    Balances = calculate_balance(Template, CompanyNum, EmployeeNum, LeaveType, LeaveScheme, BalanceDate.AddDays(1).ToString(GetDateFormat()))

                Else

                    dtBalances = GetSQLDT("select [TotalAccrual], [TotTaken], [Balance], [AccumBalance], [TotalBalance], [TotalFuture], [TotalPeriods], [GrandTotalTaken], [AtRisk], [AtRiskLooseOn], [TotalLost], [CycleStartDate], [CycleEndDate], [UnitOfMeasure], [CurrentPeriod] from [LeaveBalance] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] = '" & LeaveType & "')")

                    If (IsData(dtBalances)) Then

                        Dim totalbalance As Single    ' Total balance
                        Dim totalaccrual As Single    ' Total amount accrued within the current cycle
                        Dim totaltaken As Single      ' Total taken within the current cycle
                        Dim grandtottaken As Single   ' Grand total taken, not just within current cycle
                        Dim cycle_leavesd As Date     ' The Leave Start date within that cycle, different from Leave Start date (sd). Is equal to sd if no cycles are used
                        Dim cycle_leaveed As Object = Nothing   ' The Leave End Date within that cycle
                        Dim actualbalance As Single   ' Actual To Date balance
                        Dim totalaccum As Single      ' Total amount accumulated (if leave is allowed to be accumulated)
                        Dim totalfuture As Single     ' Total approved future leave
                        Dim nextlostdate As Date = New Date(1960, 1, 1)     ' When leave is at risk (becoming lost), this date is the date by which the leave actually becomes lost. Eg. if on 1/1/2002 leave is marked as risk, then 6 months after it becomes lost, this date reflects the 6/1/2002
                        Dim atrisk As Single          ' Number of leave to be lost on the above day
                        Dim total_lost As Single      ' Total Lost leave

                        Dim period As Byte            ' Current period of a leave cycle
                        Dim unitofmeassure As String = String.Empty ' Unit of Meassure eg days, weeks etc.
                        Dim capitmethod As String = String.Empty    ' Capitalization calculation method

                        With dtBalances.Rows(0)

                            If (Not IsNull(.Item("TotalAccrual"))) Then totalaccrual = .Item("TotalAccrual")

                            If (Not IsNull(.Item("TotTaken"))) Then totaltaken = .Item("TotTaken")

                            If (Not IsNull(.Item("Balance"))) Then actualbalance = .Item("Balance")

                            If (Not IsNull(.Item("AccumBalance"))) Then totalaccum = .Item("AccumBalance")

                            If (Not IsNull(.Item("TotalBalance"))) Then totalbalance = .Item("TotalBalance")

                            If (Not IsNull(.Item("TotalFuture"))) Then totalfuture = .Item("TotalFuture")

                            If (Not IsNull(.Item("TotalPeriods"))) Then period = .Item("TotalPeriods")

                            If (Not IsNull(.Item("GrandTotalTaken"))) Then grandtottaken = .Item("GrandTotalTaken")

                            If (Not IsNull(.Item("AtRisk"))) Then atrisk = .Item("AtRisk")

                            If (Not IsNull(.Item("AtRiskLooseOn"))) Then nextlostdate = .Item("AtRiskLooseOn")

                            If (Not IsNull(.Item("TotalLost"))) Then total_lost = .Item("TotalLost")

                            If (Not IsNull(.Item("CycleStartDate"))) Then cycle_leavesd = .Item("CycleStartDate")

                            If (Not IsNull(.Item("CycleEndDate"))) Then cycle_leaveed = .Item("CycleEndDate")

                            If (Not IsNull(.Item("UnitOfMeasure"))) Then unitofmeassure = .Item("UnitOfMeasure").ToString()

                            If (Not IsNull(.Item("CurrentPeriod"))) Then period = .Item("CurrentPeriod")

                            Balances = "<TotalAccrual=" & totalaccrual.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<TotalTaken=" & totaltaken.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<Balance=" & actualbalance.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<AccumBalance=" & totalaccum.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<TotalBalance=" & totalbalance.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<TotalFuture=" & totalfuture.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<Preriod=" & period.ToString() & ">"
                            Balances &= "<GrandTotalTaken=" & grandtottaken.ToString("0." & AppendText("0", DecimalPlaces)) & ">"
                            Balances &= "<AtRisk=" & atrisk.ToString("0." & AppendText("0", DecimalPlaces)) & ">"

                            If (nextlostdate = New Date(1960, 1, 1)) Then

                                Balances &= "<NextLostDate=>"

                            ElseIf (IsDate(nextlostdate)) Then

                                If (atrisk > 0) Then

                                    Balances &= "<NextLostDate=" & nextlostdate.ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

                                Else

                                    Balances &= "<NextLostDate=>"

                                End If

                            End If

                            Balances &= "<TotalLost=" & total_lost.ToString("0." & AppendText("0", DecimalPlaces)) & ">"

                            If (IsDate(cycle_leavesd)) Then

                                Balances &= "<CycleStart=" & cycle_leavesd.ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

                            Else

                                Balances &= "<CycleStart=>"

                            End If

                            If (IsDate(cycle_leaveed)) Then

                                Balances &= "<CycleEnd=" & cycle_leaveed.ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & ">"

                            Else

                                Balances &= "<CycleEnd=>"

                            End If

                            Balances &= "<LeaveType=" & LeaveType & ">"
                            Balances &= "<UnitOfMeassure=" & unitofmeassure & ">"
                            Balances &= "<CyclePeriod=" & period.ToString() & ">"

                            Balances &= "<Count=0>"

                            If (IsDate(cycle_leavesd) AndAlso IsDate(cycle_leaveed)) Then

                                Dim cycle_end As Date = Convert.ToDateTime(cycle_leaveed)

                                Dim iCount() As Object = GetSQLFields("select count([CompanyNum]) as [AppCount] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] = '" & LeaveType & "' and [LeaveStatus] = 'HR Granted' and (([StartDate] >= '" & cycle_leavesd.ToString("yyyy-MM-dd HH:mm:ss") & "' and [StartDate] <= '" & cycle_end.ToString("yyyy-MM-dd HH:mm:ss") & "' and [StartDate] <= '" & Date.Today.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([EndDate] >= '" & cycle_leavesd.ToString("yyyy-MM-dd HH:mm:ss") & "' and [EndDate] <= '" & cycle_end.ToString("yyyy-MM-dd HH:mm:ss") & "')))")

                                If (Not IsNull(iCount) AndAlso iCount.Length = 1) Then SetXML(Balances, "Count", iCount(0).ToString())

                            End If

                        End With

                    Else

                        ReturnText = "<Error=No balance records found.>"

                    End If

                End If

                If (GetXML(Balances, KeyName:="Error").Length = 0) Then

                    Dim dBalance As Single = System.Convert.ToSingle(GetXML(Balances, KeyName:="Balance"))
                    Dim dAccumBalance As Single = System.Convert.ToSingle(GetXML(Balances, KeyName:="AccumBalance"))
                    Dim dTotalBalance As Single = System.Convert.ToSingle(GetXML(Balances, KeyName:="TotalBalance"))

                    If ((dTotalBalance <= 0) And (dBalance > 0) And (dAccumBalance = 0)) Then dTotalBalance = dBalance

                    If (bCheckALL) Then

                        Dim sPending As Single = GetSQLField("select sum([Duration]) as [Duration] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] = '" & LeaveType & "' and [LeaveStatus] in('New', 'HOD Accepted'))", "Duration")

                        If (sPending > 0) Then

                            Dim dteStart As Date = GetSQLField("select top 1 [StartDate] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] = '" & LeaveType & "' and [StartDate] > '" & BalanceDate.ToString("yyyy-MM-dd") & "') order by [StartDate] desc", "StartDate")

                            If (IsDate(dteStart)) Then

                                Balances = calculate_balance(Template, CompanyNum, EmployeeNum, LeaveType, LeaveScheme, dteStart.AddDays(1).ToString(GetDateFormat()))

                                If (GetXML(Balances, KeyName:="Error").Length = 0) Then

                                    dBalance = System.Convert.ToSingle(GetXML(Balances, KeyName:="Balance"))
                                    dAccumBalance = System.Convert.ToSingle(GetXML(Balances, KeyName:="AccumBalance"))
                                    dTotalBalance = System.Convert.ToSingle(GetXML(Balances, KeyName:="TotalBalance"))

                                End If

                                'Else

                                '    dTotalBalance -= sPending

                            End If

                        End If

                    End If

                    SetXML(Balances, "Balance", dBalance.ToString("0." & AppendText("0", DecimalPlaces)))
                    SetXML(Balances, "AccumBalance", dAccumBalance.ToString("0." & AppendText("0", DecimalPlaces)))
                    SetXML(Balances, "TotalBalance", dTotalBalance.ToString("0." & AppendText("0", DecimalPlaces)))

                Else

                    Balances = "<Error=" & Balances & ">"

                End If

                ReturnText = Balances

            Else

                ReturnText = "<Error=Calculation date not specified.>"

            End If

        Catch ex As Exception

            ReturnText = "<Error=Calculation failed.>"

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtBalances)) Then

                dtBalances.Dispose()

                dtBalances = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetDeleteExpSQL(ByRef dgView As ASPxGridView, ByVal e As ASPxDataDeletingEventArgs, ByRef SQLAudit As String, Optional ByVal DeleteKeyText As String = "") As String

        Dim ReturnText As String = String.Empty

        Dim SQLDelete As String = String.Empty

        Try

            If (IsString(SQLAudit)) Then SQLAudit = "<Type=Delete>" & SQLAudit

            If (Not IsNull(dgView)) Then

                SQLDelete = GetXML(dgView.SettingsText.Title, KeyName:="DeleteCommand")

                SQLDelete = SQLDelete.Replace("[%CompositeKey%]", "'" & e.Keys("CompositeKey").ToString() & "'")

                If (IsString(DeleteKeyText)) Then SQLDelete = SQLDelete.Replace(DeleteKeyText, String.Empty)

                ReturnText = SQLDelete

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return ReturnText

    End Function

    Public Function GetFileData(ByRef pg As Page, ByRef docUpload As Object, ByVal ServerPath As String, Optional ByVal CheckDuplicate As Boolean = True) As String

        Dim ReturnText As String = String.Empty

        Try

            Dim UploadPath As String = pg.Server.MapPath(ServerPath)

            Dim FileStripped As String = String.Empty
            Dim FilePath As String = String.Empty
            Dim UNCPath As String = String.Empty

            With docUpload

                If (Not IsNull(.PostedFile)) Then

                    If ((.PostedFile.FileName.Length > 0) And (.PostedFile.ContentLength > 0)) Then

                        FileStripped = Path.GetFileName(.PostedFile.FileName).Replace("'", String.Empty)

                        Dim bFound As Boolean
                        Dim iIndex As Integer
                        Dim Filename(1) As String

                        Filename(0) = " - Copy"
                        Filename(1) = " - Copy (%iIndex%)"

                        FilePath = Path.Combine(UploadPath, FileStripped)

                        If (CheckDuplicate) Then

                            Dim tmpFilename As String

                            iIndex = 0

                            bFound = File.Exists(FilePath)

                            While (bFound)

                                tmpFilename = Path.GetDirectoryName(FilePath) & "\" & Path.GetFileNameWithoutExtension(FilePath) & Filename(IIf(iIndex > 1, 1, iIndex)).Replace("%iIndex%", iIndex.ToString()) & Path.GetExtension(FilePath).ToLower()

                                iIndex += 1

                                bFound = File.Exists(tmpFilename)

                                If (Not bFound) Then FilePath = tmpFilename

                            End While

                        End If

                        ReturnText = "<MapPath=" & pg.Server.MapPath(ServerPath) & ">"

                        ReturnText &= "<FilePath=" & FilePath & ">"

                        ReturnText &= "<VirtualPath=" & "~/" & ServerPath & "/" & Path.GetFileName(FilePath) & ">"

                        UNCPath = pg.Request.ApplicationPath.Replace("~/", "\").Replace("/", "\")

                        If (UNCPath.Substring(UNCPath.Length - 1, 1) <> "\") Then UNCPath &= "\"

                        ReturnText &= "<UNCPath=\\" & pg.Server.MachineName & UNCPath & ServerPath.Replace("/", "\") & "\" & Path.GetFileName(FilePath) & ">"

                    End If

                End If

            End With

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

        Return ReturnText

    End Function

    Public Function GetExpControl(ByRef dgView As ASPxGridView, ByVal CtlID As String, ByVal sProcName As String, Optional ByVal bAddEditKey As Boolean = True) As Object

        Return CallByName(FindGridControl(dgView, CtlID, bAddEditKey), sProcName, CallType.Get)

    End Function

    'TODO: v6.0.74 ENSURE THAT WE ONLY UPDATE THE CHANGED RECORD IN CACHE
    Public Function GetInsertExpSQL(ByRef dgView As ASPxGridView, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs, ByRef SQLAudit As String) As String

        Dim ReturnText As String = String.Empty

        Dim Columns As String = String.Empty

        Dim NotNull() As String = {String.Empty, String.Empty}

        Dim Required As String = String.Empty

        Dim SQLInsert As String = String.Empty

        Dim dKey As DictionaryEntry = Nothing

        Dim ColumnValue As Object = Nothing

        Dim ColumnNames As String = String.Empty

        Dim ColumnValues As String = String.Empty

        Try

            If (IsString(SQLAudit)) Then SQLAudit = "<Type=Insert>" & SQLAudit

            If (Not IsNull(dgView)) Then

                Columns = GetXML(dgView.SettingsText.Title, KeyName:="Columns")

                NotNull(0) = GetXML(dgView.SettingsText.Title, KeyName:="NotNull")

                NotNull(1) = NotNull(0)

                Required = GetXML(dgView.SettingsText.Title, KeyName:="Required")

                SQLInsert = GetXML(dgView.SettingsText.Title, KeyName:="InsertCommand")

                For Each dKey In e.NewValues

                    If (Columns.Contains("[" & dKey.Key & "]")) Then

                        ColumnValue = e.NewValues(dKey.Key)

                        If (Not IsNull(ColumnValue)) Then

                            If (IsString(SQLAudit)) Then SQLAudit &= "<" & dKey.Key & "=" & ColumnValue.ToString() & ">"

                            If (Regex.IsMatch(NotNull(1), Regex.Escape("[" & dKey.Key.ToString() & "]"), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then NotNull(1) = Regex.Replace(NotNull(1), Regex.Escape("[" & dKey.Key.ToString() & "]"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                            Select Case ColumnValue.GetType().ToString()

                                Case "System.Boolean"
                                    ColumnValues &= Math.Abs(CInt(Convert.ToBoolean(ColumnValue))).ToString()

                                Case "System.Byte"
                                    ColumnValues &= ColumnValue.ToString()

                                Case "System.DateTime"
                                    ColumnValues &= "'" & Convert.ToDateTime(ColumnValue).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                                Case "System.Int16", "System.Int32", "System.Single", "System.Double"
                                    If (Not IsNumeric(ColumnValue)) Then

                                        If ((Not NotNull(0).Contains("[" & dKey.Key & "]")) Or (NotNull(0).Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then SQLInsert = SQLInsert.Replace("[" & dKey.Key & "], ", String.Empty).Replace("[" & dKey.Key & "])", ")")

                                    Else

                                        ColumnValues &= ColumnValue

                                    End If

                                Case "System.Guid"
                                    If (ColumnValue = Guid.Empty) Then

                                        If ((Not NotNull(0).Contains("[" & dKey.Key & "]")) Or (NotNull(0).Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then SQLInsert = SQLInsert.Replace("[" & dKey.Key & "], ", String.Empty).Replace("[" & dKey.Key & "])", ")")

                                    Else

                                        ColumnValues &= "'" & ColumnValue.ToString() & "'"

                                    End If

                                Case "System.String"
                                    ColumnValue = GetDataText(ColumnValue.ToString())

                                    If (ColumnValue.ToString().Length = 0) Then

                                        If ((Not NotNull(0).Contains("[" & dKey.Key & "]")) Or (NotNull(0).Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then SQLInsert = SQLInsert.Replace("[" & dKey.Key & "], ", String.Empty).Replace("[" & dKey.Key & "])", ")")

                                    Else

                                        ColumnValues &= "'" & GetDataText(ColumnValue.ToString()) & "'"

                                    End If

                            End Select

                            If (SQLInsert.Contains("[" & dKey.Key & "]")) Then

                                ColumnValues &= ", "

                                ColumnNames &= "[" & dKey.Key & "], "

                                SQLInsert = SQLInsert.Replace("[" & dKey.Key & "]", "[Column.Replace]")

                            End If

                        ElseIf ((Not NotNull(0).Contains("[" & dKey.Key & "]")) Or (NotNull(0).Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then

                            SQLInsert = SQLInsert.Replace("[" & dKey.Key & "], ", String.Empty).Replace("[" & dKey.Key & "])", ")")

                        End If

                    Else

                        SQLInsert = SQLInsert.Replace("[" & dKey.Key & "], ", String.Empty).Replace("[" & dKey.Key & "])", ")")

                    End If

                Next

                If (ColumnNames.Length > 0) Then

                    If (ColumnNames.Substring(ColumnNames.Length - 2, 2) = ", ") Then ColumnNames = ColumnNames.Substring(0, ColumnNames.Length - 2)

                End If

                If (ColumnValues.Length > 0) Then

                    If (ColumnValues.Substring(ColumnValues.Length - 2, 2) = ", ") Then ColumnValues = ColumnValues.Substring(0, ColumnValues.Length - 2)

                End If

                If (SQLInsert.Contains("[Column.Replace]")) Then

                    SQLInsert = SQLInsert.Replace("[Column.Replace], ", String.Empty).Replace("[Column.Replace])", ")")

                    SQLInsert = SQLInsert.Replace(") values(", ColumnNames & ") values(")

                End If

                SQLInsert = SQLInsert.Replace("[%Values%]", ColumnValues)

                ReturnText = SQLInsert.Replace("], )", "])")

                If (NotNull(1).Length > 0) Then

                    NotNull(1) = Regex.Replace(NotNull(1), "(^" & Regex.Escape("[") & ")*", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    NotNull(1) = Regex.Replace(NotNull(1), "(" & Regex.Escape("]") & "$)*", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    Dim cols() As String = Regex.Split(NotNull(1), Regex.Escape("]["), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    If (cols.GetLength(0) > 0) Then

                        For i As Integer = 0 To (cols.GetLength(0) - 1)

                            If (Not Regex.IsMatch(Required, Regex.Escape("[" & cols(i) & "]"), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                ReturnText = Regex.Replace(ReturnText, Regex.Escape("[" & cols(i) & "])"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                ReturnText = Regex.Replace(ReturnText, Regex.Escape("[" & cols(i) & "], "), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                            End If

                        Next

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(ColumnValue)) Then ColumnValue = Nothing

            If (Not IsNull(dKey)) Then dKey = Nothing

        End Try

        Return ReturnText

    End Function

    'TODO: v6.0.74 ENSURE THAT WE ONLY UPDATE THE CHANGED RECORD IN CACHE
    Public Function GetUpdateExpSQL(ByRef dgView As ASPxGridView, ByVal e As ASPxDataUpdatingEventArgs, ByRef SQLAudit As String) As String

        Dim ReturnText As String = String.Empty

        Dim Columns As String = String.Empty

        Dim NotNull As String = String.Empty

        Dim Required As String = String.Empty

        Dim SQLUpdate As String = String.Empty

        Dim dKey As DictionaryEntry = Nothing

        Dim ColumnValue As Object = Nothing

        Dim ColumnNames As String = String.Empty

        Dim ColumnValues As String = String.Empty

        Try

            If (IsString(SQLAudit)) Then SQLAudit = "<Type=Update>" & SQLAudit

            If (Not IsNull(dgView)) Then

                Columns = GetXML(dgView.SettingsText.Title, KeyName:="Columns")

                NotNull = GetXML(dgView.SettingsText.Title, KeyName:="NotNull")

                Required = GetXML(dgView.SettingsText.Title, KeyName:="Required")

                SQLUpdate = GetXML(dgView.SettingsText.Title, KeyName:="UpdateCommand")

                SQLUpdate = SQLUpdate.Replace("[%CompositeKey%]", "'" & dgView.GetRow(dgView.EditingRowVisibleIndex).Item("CompositeKey").ToString() & "'")

                For Each dKey In e.NewValues

                    If (Columns.Contains("[" & dKey.Key & "]")) Then

                        ColumnValue = e.NewValues(dKey.Key)

                        If (Not IsNull(ColumnValue)) Then

                            If (IsString(SQLAudit)) Then SQLAudit &= "<" & dKey.Key & "=" & ColumnValue.ToString() & ">"

                            ColumnValues &= "[" & dKey.Key & "] = "

                            Select Case ColumnValue.GetType().ToString()

                                Case "System.Boolean"
                                    ColumnValues &= Math.Abs(CInt(Convert.ToBoolean(ColumnValue))).ToString()

                                Case "System.Byte"
                                    ColumnValues &= ColumnValue.ToString()

                                Case "System.DateTime"
                                    ColumnValues &= "'" & Convert.ToDateTime(ColumnValue).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                                Case "System.Int16", "System.Int32", "System.Single", "System.Double"
                                    If (Not IsNumeric(ColumnValue)) Then

                                        If ((Not NotNull.Contains("[" & dKey.Key & "]")) Or (NotNull.Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then ColumnValues = ColumnValues.Replace("[" & dKey.Key & "] = ", String.Empty)

                                    Else

                                        ColumnValues &= ColumnValue

                                    End If

                                Case "System.Guid"
                                    If (ColumnValue = Guid.Empty) Then

                                        If ((Not NotNull.Contains("[" & dKey.Key & "]")) Or (NotNull.Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then ColumnValues = ColumnValues.Replace("[" & dKey.Key & "] = ", String.Empty)

                                    Else

                                        ColumnValues &= "'" & ColumnValue.ToString() & "'"

                                    End If

                                Case "System.String"
                                    ColumnValue = GetDataText(ColumnValue.ToString())

                                    If (ColumnValue.ToString().Length = 0) Then

                                        If ((Not NotNull.Contains("[" & dKey.Key & "]")) Or (NotNull.Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then ColumnValues = ColumnValues.Replace("[" & dKey.Key & "] = ", String.Empty)

                                    Else

                                        ColumnValues &= "'" & ColumnValue.ToString() & "'"

                                    End If

                            End Select

                            If (ColumnValues.Contains("[" & dKey.Key & "] = ")) Then ColumnValues &= ", "

                        ElseIf ((Not NotNull.Contains("[" & dKey.Key & "]")) Or (NotNull.Contains("[" & dKey.Key & "]") And Not Required.Contains("[" & dKey.Key & "]"))) Then

                            If ((Not dKey.Key = "DocPath") AndAlso (Not dKey.Key = "ESSPath")) Then ColumnValues &= "[" & dKey.Key & "] = null, "

                        End If

                    End If

                Next

                If (ColumnValues.Length > 0) Then

                    If (ColumnValues.Substring(ColumnValues.Length - 2, 2) = ", ") Then ColumnValues = ColumnValues.Substring(0, ColumnValues.Length - 2)

                End If

                ReturnText = SQLUpdate.Replace("[%Columns%]", ColumnValues)

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(ColumnValue)) Then ColumnValue = Nothing

            If (Not IsNull(dKey)) Then dKey = Nothing

        End Try

        Return ReturnText

    End Function


    Public Function LoadExpChart(ByRef Session As HttpSessionState, ByRef wcChart As WebChartControl, ByRef hParams As ASPxHiddenField, ByVal ChartID As Byte, ByVal Appearance As String, Optional ByVal CacheKey As String = "") As String

        Dim ReturnText As String = String.Empty

        Dim dtChart As DataTable = Nothing

        Dim chType As Byte

        Dim dtSeries As DataTable = Nothing

        Dim dtSeriesData As DataTable = Nothing

        Dim chTitle As ChartTitle = Nothing

        Dim chSeries As Series = Nothing

        Dim chPoint As SeriesPoint = Nothing

        Dim iParamCnt As Integer = -1

        Dim Params() As Object = Nothing

        Dim ItemKey As String = String.Empty

        Dim SQL As String = String.Empty

        Try

            dtChart = GetSQLDT("select [TypeID], [Title] from [Charts.ChartLU] where ([ID] = " & ChartID.ToString() & ")", CacheKey)

            If (IsData(dtChart)) Then

                chType = dtChart.Rows(0).Item("TypeID")

                wcChart.Titles.Clear()

                wcChart.Series.Clear()

                chTitle = New ChartTitle()

                If (hParams.Contains("ParamCnt")) Then

                    iParamCnt = hParams.Get("ParamCnt")

                    ReDim Params(iParamCnt)

                    For iLoop As Integer = 0 To iParamCnt

                        ItemKey = "Param_" & iLoop.ToString()

                        Params(iLoop) = hParams.Get(ItemKey)

                        If (hParams.Contains(ItemKey & "_Text")) Then Params(iLoop) = hParams.Get(ItemKey & "_Text")

                        If (IsDate(Params(iLoop)) AndAlso hParams.Contains(ItemKey & "_DisplayFormat")) Then

                            Params(iLoop) = Convert.ToDateTime(Params(iLoop)).ToString(hParams.Get(ItemKey & "_DisplayFormat"))

                        End If

                    Next

                End If

                chTitle.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12, Drawing.FontStyle.Bold)

                chTitle.TextColor = Drawing.ColorTranslator.FromHtml("#e95d0f")

                chTitle.Text = ReplaceValue(Session, ReplaceParams(False, dtChart.Rows(0).Item("Title").ToString(), Params).ToUpper(), True)

                ReturnText = chTitle.Text

                If (hParams.Contains("ParamCnt")) Then

                    For iLoop As Integer = 0 To iParamCnt

                        ItemKey = "Param_" & iLoop.ToString()

                        Params(iLoop) = hParams.Get(ItemKey)

                        If (IsDate(Params(iLoop)) AndAlso hParams.Contains(ItemKey & "_ValueFormat")) Then

                            Params(iLoop) = Convert.ToDateTime(Params(iLoop)).ToString(hParams.Get(ItemKey & "_ValueFormat"))

                        End If

                    Next

                End If

                wcChart.Titles.Add(chTitle)

                wcChart.AppearanceName = Appearance

                dtSeries = GetSQLDT("select [Name], [SQL] from [Charts.DataLU] where ([ChartID] = " & ChartID.ToString() & ") order by [ID]", CacheKey)

                If (IsData(dtSeries)) Then

                    Dim bUseDateTime As Boolean

                    For iLoop As Integer = 0 To (dtSeries.Rows.Count - 1)

                        bUseDateTime = Nothing

                        With dtSeries.Rows(iLoop)

                            chSeries = New Series(.Item("Name"), chType)

                            Select Case chType

                                Case 3
                                    TryCast(chSeries.PointOptions, PiePointOptions).PercentOptions.ValueAsPercent = True
                                    TryCast(chSeries.PointOptions, PiePointOptions).ValueNumericOptions.Format = DevExpress.XtraCharts.NumericFormat.Percent
                                    TryCast(chSeries.PointOptions, PiePointOptions).ValueNumericOptions.Precision = 2

                                    chSeries.LegendPointOptions.PointView = PointView.Argument

                            End Select

                            SQL = .Item("SQL").ToString()

                            dtSeriesData = GetSQLDT(ReplaceValue(Session, ReplaceParams(False, SQL, Params)))

                            If (IsData(dtSeriesData)) Then

                                For iLoopSeries As Integer = 0 To (dtSeriesData.Rows.Count - 1)

                                    chPoint = New SeriesPoint()

                                    chPoint.IsEmpty = False

                                    If (dtSeriesData.Columns.Contains("Series") AndAlso dtSeriesData.Columns.Contains("Data")) Then

                                        chPoint.Argument = dtSeriesData.Rows(iLoopSeries).Item("Series").ToString()

                                        Dim objValue As Object = dtSeriesData.Rows(iLoopSeries).Item("Data")

                                        If (IsDate(objValue)) Then

                                            chPoint.DateTimeValues = objValue

                                        Else

                                            chPoint.Values = objValue

                                        End If

                                    Else

                                        If (dtSeriesData.Columns.Contains("Series")) Then

                                            chPoint.Argument = dtSeriesData.Rows(iLoopSeries).Item("Series").ToString()

                                        Else

                                            Dim iSeries As Byte = 1

                                            While (dtSeriesData.Columns.Contains("Series_" & iSeries.ToString("000")))

                                                iSeries += 1

                                            End While

                                            iSeries -= 1

                                            If (iSeries > 0) Then

                                                Dim TextLabel As String = String.Empty

                                                For iLoopLabels As Integer = 0 To (iSeries - 1)

                                                    TextLabel &= dtSeriesData.Rows(iLoopSeries).Item("Series_" & (iLoopLabels + 1).ToString("000")).ToString()

                                                    If (iLoopLabels < (iSeries - 1)) Then TextLabel &= ": "

                                                Next

                                                chPoint.Argument = TextLabel

                                            End If

                                        End If

                                        Dim objDates() As Date = Nothing

                                        Dim objValues() As Double = Nothing

                                        Dim iIndex As Byte = 1

                                        While (dtSeriesData.Columns.Contains("Data_" & iIndex.ToString("000")))

                                            iIndex += 1

                                        End While

                                        iIndex -= 1

                                        If (iIndex > 0) Then

                                            Dim objValue As Object = Nothing

                                            ReDim objDates(iIndex - 1)

                                            ReDim objValues(iIndex - 1)

                                            For iLoopData As Integer = 0 To (iIndex - 1)

                                                objValue = dtSeriesData.Rows(iLoopSeries).Item("Data_" & (iLoopData + 1).ToString("000"))

                                                If (IsDate(objValue)) Then

                                                    objDates(iLoopData) = Convert.ToDateTime(objValue)

                                                Else

                                                    objValues(iLoopData) = Convert.ToDouble(objValue)

                                                End If

                                            Next

                                            If (IsDate(objDates(0))) Then

                                                bUseDateTime = True

                                                chPoint.DateTimeValues = objDates

                                            Else

                                                chPoint.Values = objValues

                                            End If

                                        End If

                                    End If

                                    If (dtSeriesData.Columns.Contains("LabelText")) Then

                                        chPoint.Tag = dtSeriesData.Rows(iLoopSeries).Item("LabelText")

                                    End If

                                    If (bUseDateTime) Then

                                        If (Not chSeries.ValueScaleType = ScaleType.DateTime) Then chSeries.ValueScaleType = ScaleType.DateTime

                                    End If

                                    chSeries.Points.Add(chPoint)

                                Next

                                If (chType = 24) Then

                                    With TryCast(chSeries.Label, RangeBarSeriesLabel)

                                        .Position = RangeBarLabelPosition.Inside

                                        .Indent = 5

                                    End With

                                End If

                                wcChart.Series.Add(chSeries)

                            End If

                        End With

                    Next

                End If

                Select Case chType

                    Case 24
                        With TryCast(wcChart.Diagram, GanttDiagram)

                            .AxisY.DateTimeOptions.Format = DateTimeFormat.Custom

                            .AxisY.DateTimeOptions.FormatString = "dd"

                            .AxisY.DateTimeMeasureUnit = DateTimeMeasurementUnit.Day

                        End With

                End Select

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(Params)) Then Params = Nothing

            'If (Not IsNull(chPoint)) Then

            '    chPoint.Dispose()

            '    chPoint = Nothing

            'End If

            'If (Not IsNull(chSeries)) Then

            '    chSeries.Dispose()

            '    chSeries = Nothing

            'End If

            'If (Not IsNull(chTitle)) Then

            '    chTitle.Dispose()

            '    chTitle = Nothing

            'End If

            If (Not IsNull(dtSeriesData)) Then

                dtSeriesData.Dispose()

                dtSeriesData = Nothing

            End If


            If (Not IsNull(dtSeries)) Then

                dtSeries.Dispose()

                dtSeries = Nothing

            End If

            If (Not IsNull(dtChart)) Then

                dtChart.Dispose()

                dtChart = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function SaveAudit(ByVal UDetails As Users, ByVal Username As String, ByVal SQLAudit As String) As Boolean

        Dim ReturnBool As Boolean

        If (Not IsNull(UDetails) AndAlso IsString(SQLAudit)) Then

            With UDetails

                If (IsString(.AuditTemplate)) Then

                    Dim dtAudit As DataTable = Nothing

                    Dim arFields As ArrayList = Nothing
                    Dim arWhere As ArrayList = Nothing

                    Dim ColType As String = "Log"
                    Dim SQLType As String = String.Empty

                    Dim Type As String = GetXML(SQLAudit, KeyName:="Type")

                    Dim Tablename As String = GetXML(SQLAudit, KeyName:="Tablename")

                    SQLAudit = SQLAudit.Replace("<Type=" & Type & ">", String.Empty).Replace("<Tablename=" & Tablename & ">", String.Empty)

                    ColType &= Type & "s"

                    SQLType = Type.Substring(0, 1)

                    Try

                        dtAudit = GetSQLDT("select [" & ColType & "] as [YesNo] from [AuditLogTemplateTables] where ([TableName] = '" & Tablename & "') and ([TemplateCode] = '" & .AuditTemplate & "')")

                        If (IsData(dtAudit) AndAlso dtAudit.Rows(0).Item("YesNo")) Then

                            arFields = New ArrayList()

                            arWhere = New ArrayList()

                            Randomize()

                            Dim UniqueID As String = Now.ToString("MMddHHmmss") & Int((1000000000 * Rnd())).ToString(0).Trim()

                            If (UniqueID.Length >= 20) Then UniqueID = UniqueID.Substring(0, 19)

                            UniqueID &= "*"

                            Dim Field As String = String.Empty
                            Dim Value As String = String.Empty

                            While (SQLAudit.Length > 0)

                                Field = GetXML(SQLAudit)

                                If (IsString(Field)) Then

                                    Value = GetXML(SQLAudit, KeyName:=Field)

                                    If (Field.IndexOf(";") >= 0) Then

                                        arFields.Add("<Field=" & Field.Substring(0, Field.IndexOf(";")) & "><Value=" & Value & ">")

                                    Else

                                        arWhere.Add("<Field=" & Field & "><Value=" & Value & ">")

                                    End If

                                    SQLAudit = SQLAudit.Replace("<" & Field & "=" & Value & ">", String.Empty)

                                Else

                                    SQLAudit = String.Empty

                                End If

                            End While

                            If (arFields.Count > 0 OrElse arWhere.Count > 0) Then

                                ReturnBool = ExecSQL("insert into [AuditLogTables]([UniqueID], [Username], [DateAffected], [QryType], [TableAffected]) values('" & UniqueID & "', '" & Username & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & SQLType & "', '" & Tablename & "')")

                                If (ReturnBool) Then

                                    If (arFields.Count > 0 AndAlso (Type = "Update" OrElse Type = "Insert")) Then

                                        For i As Integer = 0 To (arFields.Count - 1)

                                            Field = GetNullText(GetXML(arFields(i), KeyName:="Field"))

                                            Value = GetNullText(GetXML(arFields(i), KeyName:="Value"))

                                            If (Field = "null") Then Field = "'null'"

                                            If (Value = "null") Then Value = "'null'"

                                            ReturnBool = ExecSQL("insert into [AuditLogFields]([UniqueID], [FieldName], [FieldValue]) values('" & UniqueID & "', '" & Field & "', " & Value & ")")

                                            If (Not ReturnBool) Then Exit For

                                        Next

                                    End If

                                    If (ReturnBool AndAlso arWhere.Count > 0 AndAlso (Type = "Update" OrElse Type = "Delete")) Then

                                        For i As Integer = 0 To (arWhere.Count - 1)

                                            Field = GetNullText(GetXML(arWhere(i), KeyName:="Field"))

                                            Value = GetNullText(GetXML(arWhere(i), KeyName:="Value"))

                                            If (Field = "null") Then Field = "'null'"

                                            If (Value = "null") Then Value = "'null'"

                                            ReturnBool = ExecSQL("insert into [AuditLogWhere]([UniqueID], [ClauseSequence], [WhereFieldName], [WhereOperator], [WhereValue]) values('" & UniqueID & "', " & (i + 1).ToString() & ", " & Field & ", '=', " & Value & ")")

                                            If (Not ReturnBool) Then Exit For

                                        Next

                                    End If

                                End If

                            End If

                        End If

                    Catch ex As Exception

                        WriteEventLog(ex)

                    Finally

                        If (Not IsNull(arFields)) Then

                            arFields.Clear()

                            arFields = Nothing

                        End If

                        If (Not IsNull(arWhere)) Then

                            arWhere.Clear()

                            arWhere = Nothing

                        End If

                        If (Not IsNull(dtAudit)) Then

                            dtAudit.Dispose()

                            dtAudit = Nothing

                        End If

                    End Try

                End If

            End With

        End If

        Return ReturnBool

    End Function

    Public Function ValidateExpGrid(ByRef dgView As ASPxGridView, ByVal e As ASPxDataValidationEventArgs) As String

        Dim ReturnText As String = "Information incomplete, see marked fields."

        Dim Required As String = String.Empty

        Dim objValue As Object = Nothing

        Try

            If (Not IsNull(dgView)) Then

                Required = GetXML(dgView.SettingsText.Title, KeyName:="Required")

                For Each dColumn As GridViewColumn In dgView.Columns

                    Dim dataCol As GridViewDataColumn = TryCast(dColumn, GridViewDataColumn)

                    If (Not IsNull(dataCol)) Then

                        If (Required.Contains("[" & dataCol.FieldName & "]")) Then

                            objValue = e.NewValues(dataCol.FieldName)

                            'Removed Condition for String values. As objValue object can have other data types. unless converted to string.
                            'If (IsNull(objValue) OrElse objValue = String.Empty) Then e.Errors(dataCol) = "This field cannot be empty."
                            If (IsNull(objValue) OrElse (TypeOf objValue Is String AndAlso objValue.ToString().Trim() = "")) Then

                                e.Errors(dataCol) = "This field cannot be empty."

                            End If

                        End If

                    End If

                Next dColumn

                If (e.Errors.Count = 0) Then ReturnText = String.Empty

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(objValue)) Then objValue = Nothing

        End Try

        Return ReturnText

    End Function

#End Region

End Module
