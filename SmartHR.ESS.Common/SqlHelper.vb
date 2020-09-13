Imports System.Data.SqlClient
Imports System.Configuration

Public NotInheritable Class SqlHelper
    Implements IDisposable

    Private SqlCmd As SqlCommand
    Private SqlCmdTimeout As Integer = 30
    Private SqlParams As List(Of SqlParameter)
    Private DbConnection As SqlConnection
    Private SqlTrxn As SqlTransaction
    Private CmdType As CommandType
    Private CmdText As String
    Const newIdQuery As String =
        "declare @tbl table (id uniqueidentifier default newsequentialid(), col varchar(1)) " &
        "insert into @tbl (col) select '' select id from @tbl"

    Public Sub New(ByVal timeout As Integer)
        SqlCmdTimeout = timeout
    End Sub

    Public Sub Dispose() Implements System.IDisposable.Dispose
        If SqlCmd IsNot Nothing Then
            SqlCmd.Dispose()
            SqlCmd = Nothing
        End If
    End Sub

    Public Shared Function CreateSqlConnection(Optional ByVal connectionStringName As String = "") As SqlConnection
        Dim connStr As String = If(connectionStringName = "", ConfigurationHelper.SqlConnectionString, ConfigurationManager.ConnectionStrings(connectionStringName).ConnectionString)
        Dim sqlConn As SqlConnection = New SqlConnection(connStr)
        sqlConn.Open()
        Return sqlConn
    End Function

    Public Property SqlException As SqlException

    Public Sub SetStoredProcedure(ByVal storedProcedureName As String, ByVal _dbConnection As SqlConnection)
        CmdType = CommandType.StoredProcedure
        CmdText = storedProcedureName
        DbConnection = _dbConnection
        SqlTrxn = Nothing

        If SqlParams IsNot Nothing Then
            SqlParams.Clear()
            SqlParams = Nothing
        End If

        SqlParams = New List(Of SqlParameter)()
    End Sub

    Public Sub SetStoredProcedure(ByVal storedProcedureName As String, ByVal _sqlTrxn As SqlTransaction)
        CmdType = CommandType.StoredProcedure
        CmdText = storedProcedureName
        SqlTrxn = _sqlTrxn

        If SqlParams IsNot Nothing Then
            SqlParams.Clear()
            SqlParams = Nothing
        End If

        SqlParams = New List(Of SqlParameter)()
    End Sub

    Public Sub SetParameter(ByVal parameterName As String, ByVal parameterValue As Object)
        If SqlParams.Count > 0 Then
            Dim existingParam As SqlParameter = Nothing

            For Each param As SqlParameter In SqlParams

                If param.ParameterName = parameterName Then
                    existingParam = param
                    Exit For
                End If
            Next

            If existingParam IsNot Nothing Then SqlParams.Remove(existingParam)
        End If

        If TypeOf parameterValue Is DateTime Then
            SqlParams.Add(New SqlParameter(parameterName, (CDate(parameterValue)).ToUniversalTime().ToString()))
        Else
            SqlParams.Add(New SqlParameter(parameterName, parameterValue))
        End If
    End Sub

    Public Sub SetSqlStatement(ByVal sqlStatement As String, ByVal _dbConnection As SqlConnection)
        CmdType = CommandType.Text
        CmdText = sqlStatement
        DbConnection = _dbConnection
        SqlTrxn = Nothing

        If SqlParams IsNot Nothing Then
            SqlParams.Clear()
            SqlParams = Nothing
        End If

        SqlParams = New List(Of SqlParameter)()
    End Sub

    Public Sub SetSqlStatement(ByVal sqlStatement As String, ByVal _sqlTrxn As SqlTransaction)
        CmdType = CommandType.Text
        CmdText = sqlStatement
        SqlTrxn = _sqlTrxn

        If SqlParams IsNot Nothing Then
            SqlParams.Clear()
            SqlParams = Nothing
        End If

        SqlParams = New List(Of SqlParameter)()
    End Sub

    Private Sub CreateCommand()
        If SqlCmd IsNot Nothing Then
            SqlCmd.Parameters.Clear()
            SqlCmd.Dispose()
        End If

        SqlCmd = New SqlCommand()
        SqlCmd.CommandText = CmdText
        SqlCmd.CommandType = CmdType
        SqlCmd.CommandTimeout = SqlCmdTimeout

        If SqlTrxn IsNot Nothing Then
            SqlCmd.Connection = SqlTrxn.Connection
            SqlCmd.Transaction = SqlTrxn
        Else
            SqlCmd.Connection = DbConnection
        End If

        If SqlParams IsNot Nothing AndAlso SqlParams.Count > 0 Then
            SqlCmd.Parameters.AddRange(SqlParams.ToArray())
        End If
    End Sub

    Public Function ExecuteNonQuery() As Integer
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then SqlCmd.Connection.Open()
            Return SqlCmd.ExecuteNonQuery()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return 0
    End Function

    Public Function ExecuteScalar() As Object
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then SqlCmd.Connection.Open()
            Return SqlCmd.ExecuteScalar()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return Nothing
    End Function

    Public Function ExecuteReader() As SqlDataReader
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then SqlCmd.Connection.Open()
            Return SqlCmd.ExecuteReader()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return Nothing
    End Function

    Public Function ExecuteDataSet() As DataSet
        Dim dataAdapter As SqlDataAdapter = New SqlDataAdapter()
        Dim returnData As DataSet = New DataSet()

        Try
            CreateCommand()
            dataAdapter.SelectCommand = SqlCmd
            dataAdapter.Fill(returnData)
            Return returnData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If dataAdapter IsNot Nothing Then
                dataAdapter.Dispose()
                dataAdapter = Nothing
            End If

            If returnData IsNot Nothing Then
                returnData.Dispose()
                returnData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Function ExecuteDataTable() As DataTable
        Dim dataAdapter As SqlDataAdapter = New SqlDataAdapter()
        Dim returnData As DataTable = New DataTable()

        Try
            CreateCommand()
            dataAdapter.SelectCommand = SqlCmd
            dataAdapter.Fill(returnData)
            Return returnData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If dataAdapter IsNot Nothing Then
                dataAdapter.Dispose()
                dataAdapter = Nothing
            End If

            If returnData IsNot Nothing Then
                returnData.Dispose()
                returnData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Function MassExecute(ByVal storedProcedureName As String, ByVal data As DataTable, ByVal dbConnection As SqlConnection) As Integer
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetStoredProcedure(storedProcedureName, dbConnection)
                        SetParameter("@Records", CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += ExecuteNonQuery()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Function MassExecute(ByVal storedProcedureName As String, ByVal data As DataTable, ByVal sqlTrxn As SqlTransaction) As Integer
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetStoredProcedure(storedProcedureName, sqlTrxn)
                        SetParameter("@Records", CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += ExecuteNonQuery()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Function MassExecute(ByVal parameterName As String, ByVal data As DataTable) As Integer
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetParameter(parameterName, CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += ExecuteNonQuery()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Function MassRetrieve(ByVal parameterName As String, ByVal data As DataTable) As DataTable
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200
        Dim retData As DataTable = New DataTable()

        Try

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetParameter(parameterName, CommonFunctions.ConvertDataTableToXml(tmpData))
                        CommonFunctions.AppendData(ExecuteDataTable(), retData)
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using

            Return retData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If retData IsNot Nothing Then
                retData.Dispose()
                retData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Function GetServerDateTime(ByVal dbConnection As SqlConnection) As DateTime
        SetSqlStatement("select getdate()", dbConnection)
        Return CDate(ExecuteScalar())
    End Function

    Public Function GetServerDateTime(ByVal sqlTrxn As SqlTransaction) As DateTime
        SetSqlStatement("select getdate()", sqlTrxn)
        Return CDate(ExecuteScalar())
    End Function

    Public Function GetNewGuid(ByVal dbConnection As SqlConnection) As Guid
        SetSqlStatement(newIdQuery, dbConnection)
        Return Guid.Parse(ExecuteScalar().ToString())
    End Function

    Public Function GetNewGuid(ByVal sqlTrxn As SqlTransaction) As Guid
        SetSqlStatement(newIdQuery, sqlTrxn)
        Return Guid.Parse(ExecuteScalar().ToString())
    End Function

    Public Async Function ExecuteNonQueryAsync() As Task(Of Integer)
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then Await SqlCmd.Connection.OpenAsync()
            Return Await SqlCmd.ExecuteNonQueryAsync()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return 0
    End Function

    Public Async Function ExecuteScalarAsync() As Task(Of Object)
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then Await SqlCmd.Connection.OpenAsync()
            Return Await SqlCmd.ExecuteScalarAsync()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return Nothing
    End Function

    Public Async Function ExecuteReaderAsync() As Task(Of SqlDataReader)
        Try
            CreateCommand()
            If SqlCmd.Connection.State <> ConnectionState.Open Then SqlCmd.Connection.Open()
            Return Await SqlCmd.ExecuteReaderAsync()
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        End Try

        Return Nothing
    End Function

    Public Async Function ExecuteDataSetAsync() As Task(Of DataSet)
        Dim dataReader As SqlDataReader = Nothing
        Dim returnData As DataSet = New DataSet()

        Try
            CreateCommand()
            dataReader = Await SqlCmd.ExecuteReaderAsync()
            Dim nextTbl As Boolean = True

            While nextTbl
                Dim dt As DataTable = New DataTable()

                Try
                    dt.Load(dataReader)

                    If dt.Columns.Count > 0 Then
                        returnData.Tables.Add(dt)
                    Else
                        nextTbl = False
                    End If

                Catch ex As Exception
                    Throw ex
                Finally

                    If dt IsNot Nothing Then
                        dt.Dispose()
                        dt = Nothing
                    End If
                End Try
            End While

            Return returnData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If dataReader IsNot Nothing Then
                dataReader.Close()
                dataReader.Dispose()
                dataReader = Nothing
            End If

            If returnData IsNot Nothing Then
                returnData.Dispose()
                returnData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Async Function ExecuteDataTableAsync() As Task(Of DataTable)
        Dim dataReader As SqlDataReader = Nothing
        Dim returnData As DataTable = New DataTable()

        Try
            CreateCommand()
            dataReader = Await SqlCmd.ExecuteReaderAsync()
            returnData.Load(dataReader)
            Return returnData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If dataReader IsNot Nothing Then
                dataReader.Close()
                dataReader.Dispose()
                dataReader = Nothing
            End If

            If returnData IsNot Nothing Then
                returnData.Dispose()
                returnData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Async Function MassExecuteAsync(ByVal storedProcedureName As String, ByVal data As DataTable, ByVal dbConnection As SqlConnection) As Task(Of Integer)
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetStoredProcedure(storedProcedureName, dbConnection)
                        SetParameter("@Records", CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += Await ExecuteNonQueryAsync()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Async Function MassExecuteAsync(ByVal storedProcedureName As String, ByVal data As DataTable, ByVal sqlTrxn As SqlTransaction) As Task(Of Integer)
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetStoredProcedure(storedProcedureName, sqlTrxn)
                        SetParameter("@Records", CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += Await ExecuteNonQueryAsync()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Async Function MassExecuteAsync(ByVal parameterName As String, ByVal data As DataTable) As Task(Of Integer)
        Dim rowsAffected As Integer = 0
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200

        If data IsNot Nothing AndAlso data.Rows.Count > 0 Then

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetParameter(parameterName, CommonFunctions.ConvertDataTableToXml(tmpData))
                        rowsAffected += Await ExecuteNonQueryAsync()
                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using
        End If

        Return rowsAffected
    End Function

    Public Async Function MassRetrieveAsync(ByVal parameterName As String, ByVal data As DataTable) As Task(Of DataTable)
        Dim tmpCtr As Integer = 0
        Dim recPerBatch As Integer = 200
        Dim retData As DataTable = New DataTable()

        Try

            Using tmpData As DataTable = data.Clone()

                For ctr As Integer = 0 To data.Rows.Count - 1
                    tmpCtr += 1
                    tmpData.ImportRow(data.Rows(ctr))

                    If tmpCtr = recPerBatch OrElse ctr = data.Rows.Count - 1 Then
                        SetParameter(parameterName, CommonFunctions.ConvertDataTableToXml(tmpData))
                        Dim dt As DataTable = Nothing

                        Try
                            dt = Await ExecuteDataTableAsync()
                            CommonFunctions.AppendData(dt, retData)
                        Catch ex As Exception
                            Throw ex
                        Finally

                            If dt IsNot Nothing Then
                                dt.Dispose()
                                dt = Nothing
                            End If
                        End Try

                        tmpCtr = 0
                        tmpData.Clear()
                    End If
                Next
            End Using

            Return retData
        Catch ex As Exception
            ThrowExceptionWithQuery(ex)
        Finally

            If retData IsNot Nothing Then
                retData.Dispose()
                retData = Nothing
            End If
        End Try

        Return Nothing
    End Function

    Public Async Function GetServerDateTimeAsync(ByVal dbConnection As SqlConnection) As Task(Of DateTime)
        SetSqlStatement("select getdate()", dbConnection)
        Dim obj As Object = Await ExecuteScalarAsync()
        Return CDate(obj)
    End Function

    Public Async Function GetServerDateTimeAsync(ByVal sqlTrxn As SqlTransaction) As Task(Of DateTime)
        SetSqlStatement("select getdate()", sqlTrxn)
        Dim obj As Object = Await ExecuteScalarAsync()
        Return CDate(obj)
    End Function

    Public Async Function GetNewGuidAsync(ByVal dbConnection As SqlConnection) As Task(Of Guid)
        SetSqlStatement(newIdQuery, dbConnection)
        Dim obj As Object = Await ExecuteScalarAsync()
        Return Guid.Parse(obj.ToString())
    End Function

    Public Async Function GetNewGuidAsync(ByVal sqlTrxn As SqlTransaction) As Task(Of Guid)
        SetSqlStatement(newIdQuery, sqlTrxn)
        Dim obj As Object = Await ExecuteScalarAsync()
        Return Guid.Parse(obj.ToString())
    End Function

    Public Function GetColumnsByTableName(ByVal tableName As String, ByVal dbConnection As SqlConnection) As DataTable
        Dim sql As String = "SELECT ColName = COL.NAME " & "FROM SYS.TABLES TBL " & "INNER JOIN SYS.COLUMNS COL " & "ON COL.OBJECT_ID = TBL.OBJECT_ID " & "WHERE TBL.NAME = '" & tableName & "'"
        SetSqlStatement(sql, dbConnection)
        Return ExecuteDataTable()
    End Function

    Private Sub ThrowExceptionWithQuery(ByVal ex As Exception)
        If TypeOf ex Is SqlException Then SqlException = TryCast(ex, SqlException)
        Throw New Exception(ex.Message & Environment.NewLine & ConstructSql())
    End Sub

    Private Function ConstructSql() As String
        If CmdType = CommandType.StoredProcedure Then
            Return ConstructExecSp()
        Else
            Return ConstructQuery()
        End If
    End Function

    Private Function ConstructExecSp() As String
        Dim query As String = "exec " & CmdText & " "

        If SqlCmd.Parameters.Count > 0 Then
            query += ConstructSqlParamStr(SqlCmd.Parameters(0))

            For i As Integer = 0 To SqlCmd.Parameters.Count - 1
                Dim param As SqlParameter = SqlCmd.Parameters(i)
                If param.Value IsNot Nothing Then query += "," & ConstructSqlParamStr(param)
            Next
        End If

        Return query
    End Function

    Private Function ConstructSqlParamStr(ByVal param As SqlParameter) As String
        Dim paramStr As String

        Select Case param.SqlDbType
            Case SqlDbType.Bit
                paramStr = param.ParameterName & "=" & (If(CBool(param.Value), 1, 0))
            Case SqlDbType.BigInt, SqlDbType.Binary, SqlDbType.TinyInt, SqlDbType.Decimal, SqlDbType.Float, SqlDbType.Int, SqlDbType.Money, SqlDbType.Real, SqlDbType.SmallInt, SqlDbType.SmallMoney
                paramStr = param.ParameterName & "=" & param.Value.ToString()
            Case Else
                paramStr = param.ParameterName & "=N'" & param.Value.ToString() & "'"
        End Select

        Return paramStr
    End Function

    Private Function ConstructQuery() As String
        Dim query As String = SqlCmd.CommandText

        For Each param As SqlParameter In SqlCmd.Parameters

            Select Case param.SqlDbType
                Case SqlDbType.Bit
                    query = query.Replace(param.ParameterName, String.Format("{0}", If(CBool(param.Value), 1, 0)))
                Case Else
                    query = query.Replace(param.ParameterName, String.Format("{0}", param.Value))
            End Select
        Next

        Return query
    End Function
End Class