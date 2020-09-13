Imports System.Data.SqlClient

Public Class BaseForm
    Inherits System.Windows.Forms.Form

    Private _sqlConnection As Lazy(Of SqlConnection)
    Private _sqlHelper As Lazy(Of SqlHelper)

    Protected Sub New()
        Try
            _sqlConnection = New Lazy(Of SqlConnection)(Function() SqlHelper.CreateSqlConnection())
            _sqlHelper = New Lazy(Of SqlHelper)(Function() New SqlHelper(ConfigurationHelper.SqlRequestTimeout))
        Catch __unusedException1__ As Exception
        End Try
    End Sub

    Public ReadOnly Property SqlConnection As SqlConnection
        Get
            Return _sqlConnection.Value
        End Get
    End Property

    Public ReadOnly Property SqlHelper As SqlHelper
        Get
            Return _sqlHelper.Value
        End Get
    End Property

    Public Property OrganizationName As String
    Protected Property BusinessUnitId As Guid?
    Protected Property BusinessUnitName As String

    Protected Sub SetSqlConnection(Optional ByVal connectionStringSuffix As String = "")
        _sqlConnection = New Lazy(Of SqlConnection)(Function() SqlHelper.CreateSqlConnection(connectionStringSuffix))
    End Sub

    Protected Sub CloseSqlConnection()
        If _sqlConnection IsNot Nothing AndAlso _sqlConnection.IsValueCreated Then

            If _sqlConnection.Value.State = ConnectionState.Open Then
                _sqlConnection.Value.Close()
            End If

            _sqlConnection.Value.Dispose()
            _sqlConnection = Nothing
        End If
    End Sub
End Class