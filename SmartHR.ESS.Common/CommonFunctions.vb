Imports System.Globalization
Imports System.IO
Imports System.Text

Public Module CommonFunctions
    Public Const CultureInfoName As String = "en-US"

    Public Function IsEmpty(ByVal obj As Object) As Boolean
        Return obj Is Nothing OrElse Convert.IsDBNull(obj) OrElse obj.ToString().Trim() = ""
    End Function

    Public Function IsInteger(ByVal obj As Object) As Boolean
        Try
            Dim val As Integer = Integer.Parse(obj.ToString())
            Return True
        Catch __unusedException1__ As Exception
            Return False
        End Try
    End Function

    Public Function IsDecimal(ByVal obj As Object) As Boolean
        Try
            Dim val As Decimal = Decimal.Parse(obj.ToString())
            Return True
        Catch __unusedException1__ As Exception
            Return False
        End Try
    End Function

    Public Function IsDate(ByVal obj As Object) As Boolean
        Try
            Dim val As DateTime = DateTime.Parse(obj.ToString(), New CultureInfo(CultureInfoName))
            Return True
        Catch __unusedException1__ As Exception
            Return False
        End Try
    End Function

    Public Function IsGuid(ByVal obj As Object) As Boolean
        Try
            Dim val As Guid = Guid.Parse(obj.ToString())
            Return True
        Catch __unusedException1__ As Exception
            Return False
        End Try
    End Function

    Public Function [CStr](ByVal obj As Object) As String
        Return If((obj Is Nothing OrElse Convert.IsDBNull(obj)), "", obj.ToString().Trim())
    End Function

    Public Function [CInt](ByVal obj As Object, Optional ByVal defaultValue As Integer = 0) As Integer
        Try
            Return If((obj Is Nothing OrElse Convert.IsDBNull(obj)), defaultValue, Integer.Parse(obj.ToString()))
        Catch __unusedException1__ As Exception
            Return defaultValue
        End Try
    End Function

    Public Function [CDec](ByVal obj As Object, Optional ByVal decimalPlaces As Integer = -1, Optional ByVal defaultValue As Decimal = 0) As Decimal
        Try
            Dim d As Decimal = If((obj Is Nothing OrElse Convert.IsDBNull(obj)), defaultValue, Decimal.Parse(obj.ToString()))
            If decimalPlaces > -1 Then d = Math.Round(d, decimalPlaces)
            Return d
        Catch __unusedException1__ As Exception
            Return defaultValue
        End Try
    End Function

    Public Function [CDbl](ByVal obj As Object, Optional ByVal decimalPlaces As Integer = -1, Optional ByVal defaultValue As Double = 0) As Double
        Try
            Dim d As Double = If((obj Is Nothing OrElse Convert.IsDBNull(obj)), defaultValue, Double.Parse(obj.ToString()))
            If decimalPlaces > -1 Then d = Math.Round(d, decimalPlaces)
            Return d
        Catch __unusedException1__ As Exception
            Return defaultValue
        End Try
    End Function

    Public Function [CBool](ByVal obj As Object) As Boolean
        Try
            Return If(obj Is Nothing OrElse Convert.IsDBNull(obj), False, Boolean.Parse(If(obj.ToString() = "1", "true", If(obj.ToString() = "0", "false", obj.ToString()))))
        Catch __unusedException1__ As Exception
            Return False
        End Try
    End Function

    Public Function [CDate](ByVal obj As Object, Optional ByVal defaultValue As DateTime = Nothing) As DateTime
        Try
            Return If(obj Is Nothing OrElse Convert.IsDBNull(obj), defaultValue, DateTime.Parse(obj.ToString(), New CultureInfo(CultureInfoName)))
        Catch __unusedException1__ As Exception
            Return defaultValue
        End Try
    End Function

    Public Function CUniversalDate(ByVal obj As Object, Optional ByVal defaultValue As DateTime = Nothing) As DateTime
        Try
            Return If(obj Is Nothing OrElse Convert.IsDBNull(obj), defaultValue, DateTime.Parse(obj.ToString(), New CultureInfo(CultureInfoName)).ToUniversalTime())
        Catch __unusedException1__ As Exception
            Return defaultValue
        End Try
    End Function

    Public Function CGuid(ByVal obj As Object) As Guid
        Try
            Return If((obj Is Nothing OrElse Convert.IsDBNull(obj)), New Guid(), Guid.Parse(obj.ToString()))
        Catch __unusedException1__ As Exception
            Return New Guid()
        End Try
    End Function

    Public Function FormatDec(ByVal obj As Object, Optional ByVal numberOfDecimalPlaces As Integer = 2) As String
        Dim d As Decimal = [CDec](obj)

        If d <> 0 Then
            Dim decPlace As String = "#"

            If numberOfDecimalPlaces <= 0 Then
                decPlace = ""
            ElseIf numberOfDecimalPlaces = 1 Then
                decPlace = "0"
            Else
                decPlace = decPlace.PadRight(numberOfDecimalPlaces, "0"c)
            End If

            decPlace = "." & decPlace
            Return String.Format("{0:#,###,###,##0" & decPlace & "}", d)
        Else
            Return ((CInt(d)).ToString() & ".") & (New String("0"c, numberOfDecimalPlaces))
        End If
    End Function

    Public Function IsInList(ByVal valueToSearch As String, ParamArray listOfValues As String()) As Boolean
        For Each val As String In listOfValues

            If val = valueToSearch Then
                Return True
            End If
        Next

        Return False
    End Function

    Public Function GetWeekOfYear(ByVal _date As Object) As Integer
        Return GetWeekOfYear([CDate](_date))
    End Function

    Public Function GetWeekOfYear(ByVal _date As DateTime) As Integer
        Dim dfi As DateTimeFormatInfo = DateTimeFormatInfo.CurrentInfo
        Dim cal As System.Globalization.Calendar = dfi.Calendar
        Return cal.GetWeekOfYear(_date, dfi.CalendarWeekRule, dfi.FirstDayOfWeek)
    End Function

    Public Function ConvertDataTableToXml(ByVal dataTable As DataTable) As String
        Using ds As DataSet = New DataSet()
            dataTable.TableName = "TBL_DATA"
            ds.Tables.Add(dataTable.Copy())
            Return ConvertDataSetToXml(ds)
        End Using
    End Function

    Public Function ConvertDataSetToXml(ByVal dataSet As DataSet) As String
        dataSet.DataSetName = "DS_DATA"

        For Each dt As DataTable In dataSet.Tables

            For Each col As DataColumn In dt.Columns
                col.ColumnName = col.ColumnName.ToLower()
                col.ColumnMapping = MappingType.Attribute

                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
            Next
        Next

        Return dataSet.GetXml()
    End Function

    Public Function ConvertXmlToDataTable(ByVal xml As String) As DataTable
        If xml.Trim() <> "" Then

            Using ds As DataSet = ConvertXmlToDataSet(xml)
                Return ds.Tables(0).Copy()
            End Using
        End If

        Return Nothing
    End Function

    Public Function ConvertXmlToDataSet(ByVal xml As String) As DataSet
        If xml.Trim() <> "" Then
            Dim sr As StringReader = New StringReader(xml)

            Using ds As DataSet = New DataSet()
                ds.ReadXml(sr)
                Return ds.Copy()
            End Using
        End If

        Return Nothing
    End Function

    Public Function ConvertXmlToCommaDelimitedStr(ByVal xml As String, Optional ByVal useDefaultSort As Boolean = True) As String
        Return ConvertDataTableToCommaDelimitedStr(ConvertXmlToDataTable(xml), useDefaultSort)
    End Function

    Public Function ConvertXmlToPipeDelimitedStr(ByVal xml As String, Optional ByVal useDefaultSort As Boolean = True) As String
        Return ConvertDataTableToPipeDelimitedStr(ConvertXmlToDataTable(xml), useDefaultSort)
    End Function

    Public Function ConvertDataTableToCommaDelimitedStr(ByVal dataTable As DataTable, Optional ByVal useDefaultSort As Boolean = True) As String
        Return ConvertDataTableToCharDelimitedStr(dataTable, ",", useDefaultSort)
    End Function

    Public Function ConvertDataTableToPipeDelimitedStr(ByVal dataTable As DataTable, Optional ByVal useDefaultSort As Boolean = True) As String
        Return ConvertDataTableToCharDelimitedStr(dataTable, "|", useDefaultSort)
    End Function

    Public Function ConvertDataTableToCharDelimitedStr(ByVal dataTable As DataTable, ByVal delimiter As String, ByVal useDefaultSort As Boolean) As String
        If dataTable IsNot Nothing AndAlso dataTable.Rows.Count > 0 AndAlso dataTable.Columns.Count > 0 Then
            If useDefaultSort Then dataTable.DefaultView.Sort = dataTable.Columns(0).ColumnName & " ASC"

            Using dtData As DataTable = dataTable.DefaultView.ToTable(False, dataTable.Columns(0).ColumnName)
                Dim lst As List(Of String) = New List(Of String)()

                For Each dr As DataRow In dtData.Rows
                    lst.Add([CStr](dr(0)))
                Next

                Return String.Join(delimiter, lst.ToArray())
            End Using
        End If

        Return ""
    End Function

    Public Function ConvertCommaDelimitedStrToXml(ByVal delimitedString As String, Optional ByVal columnName As String = "Id") As String
        Return ConvertCharDelimitedStrToXml(delimitedString, columnName, ","c)
    End Function

    Public Function ConvertPipeDelimitedStrToXml(ByVal delimitedString As String, Optional ByVal columnName As String = "Id") As String
        Return ConvertCharDelimitedStrToXml(delimitedString, columnName, "|"c)
    End Function

    Public Function ConvertCharDelimitedStrToXml(ByVal delimitedString As String, ByVal columnName As String, ByVal delimiter As Char) As String
        If Not IsEmpty(delimitedString) Then

            Using dt As DataTable = New DataTable()
                dt.Columns.Add(columnName)

                For Each str As String In delimitedString.Split(delimiter)
                    Dim dr As DataRow = dt.NewRow()
                    dr(columnName) = str
                    dt.Rows.Add(dr)
                Next

                Return ConvertDataTableToXml(dt)
            End Using
        End If

        Return ""
    End Function

    Public Function ConvertCommaDelimitedListToDataTable(ByVal listOfDelimitedStrings As IEnumerable(Of String), ParamArray columnNames As String()) As DataTable
        Return ConvertCharDelimitedListToDataTable(listOfDelimitedStrings, ","c, columnNames)
    End Function

    Public Function ConvertPipeDelimitedListToDataTable(ByVal listOfDelimitedStrings As IEnumerable(Of String), ParamArray columnNames As String()) As DataTable
        Return ConvertCharDelimitedListToDataTable(listOfDelimitedStrings, "|"c, columnNames)
    End Function

    Public Function ConvertCharDelimitedListToDataTable(ByVal listOfDelimitedStrings As IEnumerable(Of String), ByVal delimiter As Char, ParamArray columnNames As String()) As DataTable
        If listOfDelimitedStrings.Count() > 0 Then

            Using dt As DataTable = New DataTable()

                For Each columnName As String In columnNames
                    dt.Columns.Add(columnName)
                Next

                Dim dr As DataRow = Nothing

                For Each delimitedString As String In listOfDelimitedStrings
                    Dim str As String() = delimitedString.Split(delimiter)
                    dr = dt.NewRow()

                    For i As Integer = 0 To dt.Columns.Count - 1

                        If i < str.Length Then
                            dr(dt.Columns(i).ColumnName) = If(String.IsNullOrEmpty(str(i)), Nothing, str(i))
                        End If
                    Next

                    dt.Rows.Add(dr)
                Next

                Return dt
            End Using
        End If

        Return Nothing
    End Function

    Public Function ConvertToTitleCase(ByVal text As String) As String
        Return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(text)
    End Function

    Public Sub AppendData(ByVal sourceDataTable As DataTable, ByRef targetDataTable As DataTable)
        If sourceDataTable Is Nothing Then Return
        If targetDataTable Is Nothing Then targetDataTable = sourceDataTable.Clone()

        For Each col As DataColumn In sourceDataTable.Columns

            If Not targetDataTable.Columns.Contains(col.ColumnName) Then

                If col.DataType = GetType(Guid) Then
                    targetDataTable.Columns.Add(col.ColumnName, GetType(String), col.Expression)
                Else
                    targetDataTable.Columns.Add(col.ColumnName, col.DataType, col.Expression)
                End If
            End If
        Next

        For Each row As DataRow In sourceDataTable.Rows
            Dim dr As DataRow = targetDataTable.NewRow()

            For Each col As DataColumn In sourceDataTable.Columns
                dr(col.ColumnName) = row(col.ColumnName)
            Next

            targetDataTable.Rows.Add(dr)
        Next
    End Sub

    Public Sub AppendText(ByVal path As String, ByVal contents As String)
        If File.Exists(path) Then

            Using sw As StreamWriter = File.AppendText(path)
                sw.WriteLine(contents)
                sw.Flush()
            End Using
        Else
            File.AppendAllText(path, contents)
        End If
    End Sub

    Public Async Function AppendTextAsync(ByVal path As String, ByVal contents As String) As Task
        If File.Exists(path) Then

            Using sw As StreamWriter = File.AppendText(path)
                Await sw.WriteLineAsync(contents)
                Await sw.FlushAsync()
            End Using
        Else
            File.AppendAllText(path, contents)
        End If
    End Function

    Public Function CalculateAge(ByVal birthday As DateTime) As Integer
        Dim today As DateTime = DateTime.Today
        Dim age As Integer = today.Year - birthday.Year

        If birthday < today Then
            Dim diffMonth As Integer = today.Month - birthday.Month
            Dim diffDay As Integer = today.Day - birthday.Day

            If diffMonth < 0 OrElse diffDay < 0 Then
                age -= 1
            End If
        End If

        Return age
    End Function

    Public Function CalculateLengthOfService(ByVal fromDate As DateTime, Optional ByVal decimalPlaces As Integer = 2) As Decimal
        Dim today As DateTime = DateTime.Today
        Dim lengthOfService As Decimal = CDec((today.Year - fromDate.Year))

        If fromDate < today Then
            Dim diffMonth As Integer = today.Month - fromDate.Month
            Dim diffDay As Integer = today.Day - fromDate.Day

            If diffMonth < 0 OrElse diffDay < 0 OrElse diffMonth > 0 OrElse diffDay > 0 Then
                Dim fromDate2 As DateTime? = Nothing

                If diffMonth < 0 OrElse diffDay < 0 Then
                    If lengthOfService > 0 Then lengthOfService -= 1
                    fromDate2 = DateTime.Parse(fromDate.ToString("MM/dd/") & (today.Year - 1), New CultureInfo(CultureInfoName))
                ElseIf diffMonth > 0 OrElse diffDay > 0 Then
                    fromDate2 = DateTime.Parse(fromDate.ToString("MM/dd/") & today.Year, New CultureInfo(CultureInfoName))
                End If

                If fromDate2 IsNot Nothing Then
                    Dim excessYear As Decimal = CDec(((today - fromDate2.Value).TotalDays / 365.0R))
                    If decimalPlaces < 0 Then decimalPlaces = 0
                    excessYear = Decimal.Parse(excessYear.ToString().Substring(0, 2 + decimalPlaces))
                    lengthOfService += excessYear
                End If
            End If
        End If

        Return lengthOfService
    End Function

    Public Sub WriteEventLog(ByVal ex As Exception, Optional ByVal entryType As EventLogEntryType = EventLogEntryType.Error)

        WriteEventLog("SmartHR.ESS", "Application", GetErrorMessage(ex), entryType)

    End Sub

    Public Sub WriteEventLog(ByVal message As String, Optional ByVal entryType As EventLogEntryType = EventLogEntryType.Error)

        WriteEventLog("SmartHR.ESS", "Application", message, entryType)

    End Sub

    Public Sub WriteEventLog(ByVal eventLogSource As String, ByVal eventLogType As String, ByVal eventLogMessage As String, Optional ByVal eventLogEntryType As EventLogEntryType = EventLogEntryType.Error)

        Try

            Dim eventLogFolder As String =
                "\SmartHR.ESS\Event Logs\" +
                eventLogType + "\" +
                eventLogEntryType.ToString() + "\"

            If Not Directory.Exists(eventLogFolder) Then

                Directory.CreateDirectory(eventLogFolder)

            End If

            Dim eventLogFile As String =
                eventLogFolder +
                eventLogSource +
                String.Format(" {0:yyyy-MM-dd}.txt", DateTime.Today)

            Using sw As StreamWriter = File.AppendText(eventLogFile)

                sw.WriteLine(String.Format("[{0:HH:mm}]:", DateTime.Now))
                sw.WriteLine(eventLogMessage)
                sw.WriteLine("====================================================")
                sw.WriteLine()

                sw.Flush()

                sw.Close()

            End Using

        Catch

            ' do nothing...

        End Try

    End Sub

    Public Function GetErrorMessage(ByVal exception As Exception) As String

        Dim message As StringBuilder = New StringBuilder("")

        If exception IsNot Nothing Then

            message.AppendLine(exception.Message)

            If exception.InnerException IsNot Nothing Then

                message.AppendLine(GetErrorMessage(exception.InnerException))

            End If

        End If

        Return message.ToString()

    End Function

    Public Function AddSpacesToWordGroups(ByVal value As String) As String

        Dim a = value.ToString()

        Dim name = ""

        For index As Int32 = 0 To a.Length - 1 Step 1

            If Char.IsUpper(a(index)) Then
                name &= " "
            End If

            name &= a(index)

        Next

        Return name.Trim()

    End Function

End Module
