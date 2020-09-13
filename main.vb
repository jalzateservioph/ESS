Imports Microsoft.Win32
Imports System.Data
Imports System.DirectoryServices
Imports System.Drawing
Imports System.Drawing.Image
Imports System.IO
Imports System.Net
Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Security.Cryptography
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Threading
Imports System.Web.HttpRuntime
Imports System.Web.HttpUtility
Imports System.Web.SessionState
Imports System.Data.SqlClient

Module main

#Region " *** Declarations (Private) *** "

    Private Declare Function GetLocaleInfo Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String, ByVal cchData As Integer) As Integer

    Private Const LOCALE_SYSTEM_DEFAULT As Integer = &H400
    Private Const LOCALE_SSHORTDATE As Integer = &H1F

    Private Const CLIENTID_ALLOWED_CHARS As String = "ABCDEFGHJKLMNOPQRSTUVWXYZ0123456789"
    Private Const PIN_ALLOWED_CHARS As String = "0123456789"
    Private Const PWD_ALLOWED_CHARS As String = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789"

    Private m_Policy As Hashtable
    Private m_PolicyItems As Hashtable
    Private m_ServerPath As String
    Private m_SQLStruct As SQLStruct
    Private m_SQLString As String
    Private m_Version As VerStruct

#End Region

#Region " *** Declarations (Public) *** "

    Public Const SUCCESS As String = "success"
    Public Const CREATE_CLIENTID As String = "error failed to create client id"
    Public Const CREATE_PIN As String = "error failed to create pin code"
    Public Const CREATE_PWD As String = "error failed to create your password"
    Public Const INVALID_LOGON As String = "error invalid username/password supplied"
    Public Const INVALID_EMAIL As String = "error invalid username/email supplied"
    Public Const PASSWORDS_MATCH As String = "error your passwords do not match"
    Public Const ACCOUNT_TERMINATED As String = "error access terminated, contact your hr department"
    Public Const MULTIPLE_ACCOUNTS As String = "error multiple accounts detected, please contact your hr department"
    Public Const WORKFLOW_LOOKUP_NOT_FOUND As String = "error the workflow lookup is not configured"
    Public Const WORKFLOW_APP_NOT_FOUND As String = "error the workflow application is not configured"
    Public Const WORKFLOW_LOCKED_BY As String = "error the workflow is currently locked by '<%PARAM[0]%>'"
    Public Const WORKFLOW_PROCS_NOT_FOUND As String = "error the workflow does not contain any processes"
    Public Const REPORTS_TO_ROLES_NOT_FOUND As String = "error you have no reports to roles assigned to you profile"
    Public Const REPORTS_TO_ROLE_NOT_FOUND As String = "error you do not have a valid '<%PARAM[0]%>' reports to role assigned to your profile"
    Public Const REPORTS_TO_EMAIL_INVALID As String = "error your reports to '<%PARAM[0]%>' role does not have a valid email address assigned (e.g. support@company.com)"
    Public Const DBERROR As String = "error Database error occurred: "

    Public Const DevExpressType As String = "DevExpress.Web.ASPxEditors.v11.1.dll"
    Public Const EncPwd As String = "680224"
    Public Const EncVectorPwd As String = "<!#%([$@@$])%#!>"
    Public Const SaltPwd As String = "$@LT#Saved*Pwd!"

    Public Const NumericFormat As String = "0.00"

    Public Structure SQLStruct

        Dim Server As String
        Dim Database As String
        Dim Username As String
        Dim Password As String

    End Structure

    Public Structure Users

        Dim UserID As String
        Dim CompanyNum As String
        Dim EmployeeNum As String
        Dim AuditTemplate As String
        Dim Surname As String
        Dim Name As String
        Dim Email As String
        Dim Template As String
        Dim Department As String
        Dim CompanyName As String
        Dim Division As String
        Dim SubDivision As String
        Dim SubSubDivision As String
        Dim Mobile As String
        Dim LeaveScheme As String
        Dim ShiftType As String
        Dim IndividualJobTitle As String

    End Structure

    Public Structure VerStruct

        Dim Application As String
        Dim Database As String
        Dim LisenceKey As String
        Dim EncryptedPwd As Boolean

    End Structure

    Public app As AppDomain = Nothing

#End Region

#Region " *** Properties (Public) *** "

    Public Property ServerPath() As String

        Get

            Return m_ServerPath

        End Get

        Set(ByVal value As String)

            m_ServerPath = value

        End Set

    End Property

    Public Property SQLServer() As SQLStruct

        Get

            Return m_SQLStruct

        End Get

        Set(ByVal value As SQLStruct)

            With value

                m_SQLString = "Data Source=" & .Server & ";Initial Catalog=" & .Database & ";User ID=" & .Username & ";Password=" & .Password

            End With

            m_SQLStruct = value

        End Set

    End Property

    Public Property SQLString() As String

        Get

            Return m_SQLString

        End Get

        Set(ByVal value As String)

            m_SQLString = value

        End Set

    End Property

    Public Property Version() As VerStruct

        Get

            Return m_Version

        End Get

        Set(ByVal value As VerStruct)

            m_Version = value

        End Set

    End Property

#End Region

#Region " *** Data Procedures (Public) *** "

    Public Sub ClearCache()

        ' *** General ***
        ClearFromCache("Company")

        ClearFromCache("Data.EmailLU")

        ClearFromCache("Data.Menu")

        ClearFromCache("Data.Menu.Home")

        ClearFromCache("Data.Policy")

        ClearFromCache("Data.PolicyItems")

        ClearFromCache("Data.Properties")

        ClearFromCache("Data.ReportLU")

        ClearFromCache("Data.Users.ReportLU")

        ClearFromCache("Data.WebServer")

        ' *** Workflow ***
        ClearFromCache("Data.Workflow.Departments.Setup")

        ClearFromCache("Data.Workflow.EmailLU.Setup")

        ClearFromCache("Data.Workflow.Processes.Setup")

        ClearFromCache("Data.Workflow.Processes.Accessible.Setup")

        ClearFromCache("Data.Workflow.Processes.ActionLU.Setup")

        ClearFromCache("Data.Workflow.Setup")

        ClearFromCache("Data.Workflow.SMSLU.Setup")

        ClearFromCache("Data.Workflow.Types.Setup")

    End Sub

    Public Sub ClearSessionCache(ByVal SessionID As String)

        ' *** Accidents ***
        ClearFromCache("Data.Accidents." & SessionID)

        ' *** Assets ***
        ClearFromCache("Data.Assets.Register." & SessionID)

        ClearFromCache("Data.Assets.Status." & SessionID)

        ' *** Basic Conditions ***
        ClearFromCache("Data.Conditions." & SessionID)

        ClearFromCache("Data.Conditions.History." & SessionID)

        ' *** BulkEmail ***
        ClearFromCache("Data.Filter.BulkEmail." & SessionID)

        ' *** BulkSMS ***
        ClearFromCache("Data.Filter.BulkSMS." & SessionID)

        ' *** Claims ***
        ClearFromCache("Data.Claims.History." & SessionID)

        ClearFromCache("Data.Claims.History.Items." & SessionID)

        ClearFromCache("Data.Claims.Register." & SessionID)

        ClearFromCache("Data.Claims.Register.Items." & SessionID)

        ClearFromCache("Data.Claims.Types." & SessionID)

        ClearFromCache("Data.Claims.Types.Items." & SessionID)

        ClearFromCache("Data.Claims.Setup." & SessionID)

        ClearFromCache("Data.Claims.Setup.Types." & SessionID)

        ' *** Company ***
        ClearFromCache("Company")

        ' *** Contacts ***
        ClearFromCache("Data.Contacts")

        ' *** Curriculum Vitae ***
        ClearFromCache("Data.CV.Experience." & SessionID)

        ClearFromCache("Data.CV.Qualification." & SessionID)

        ClearFromCache("Data.CV.Qualification.Subjects." & SessionID)

        ClearFromCache("Data.CV.Membership." & SessionID)

        ' *** Document Mapping ***
        ClearFromCache("Data.Documents." & SessionID)

        ' *** Evaluations ***
        ClearFromCache("Data.Evaluations.EvalForm." & SessionID)

        ClearFromCache("Data.Evaluations.Groups." & SessionID)

        ClearFromCache("Data.Evaluations.History." & SessionID)

        ClearFromCache("Data.Evaluations.PathData." & SessionID)

        ClearFromCache("Data.Evaluations.Scheme." & SessionID)

        ClearFromCache("Data.Evaluations.Scheme.Columns." & SessionID)

        ClearFromCache("Data.Evaluations.Setup." & SessionID)

        ClearFromCache("Data.Evaluations.Setup.CSE." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Self." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others.Items." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360.Items." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Schemes." & SessionID)

        ' *** Financial (Pay) ***
        ClearFromCache("Data.Pay." & SessionID)

        ClearFromCache("Data.Pay.LTIP." & SessionID)

        ClearFromCache("Data.Pay.Medical." & SessionID)

        ClearFromCache("Data.Pay.Pension." & SessionID)

        ' *** General ***
        ClearFromCache("Data.Filter." & SessionID)

        ClearFromCache("Data.Filter.BulkEmail." & SessionID)

        ClearFromCache("Data.Filter.BulkSMS." & SessionID)

        ClearFromCache("Data.TemplateRights." & SessionID)

        ClearFromCache("Data.UserGroups." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo." & SessionID)

        ClearFromCache("Data.UserGroups.AccessTo.Filter." & SessionID)

        ClearFromCache(SessionID & ".Progress")

        ' *** Industrial Relations ***
        ClearFromCache("Data.IR.Conduct." & SessionID)

        ClearFromCache("Data.IR.Discipline." & SessionID)

        ClearFromCache("Data.IR.Grievance." & SessionID)

        ClearFromCache("Data.IR.Performance." & SessionID)

        ' *** Learning Needs ***
        ClearFromCache("Data.Learning." & SessionID)

        ' *** Leave ***
        ClearFromCache("Data.Leave.Adjustments." & SessionID)

        ClearFromCache("Data.Leave.Block." & SessionID)

        ClearFromCache("Data.Leave.Block.Dates." & SessionID)

        ClearFromCache("Data.Leave.Block.Rules." & SessionID)

        ClearFromCache("Data.Leave.ColorKeys." & SessionID)

        ClearFromCache("Data.Leave.Balances." & SessionID)

        ClearFromCache("Data.Leave.History." & SessionID)

        ClearFromCache("Data.Leave.PubHolidays." & SessionID)

        ClearFromCache("Data.Leave.ReportsTo." & SessionID)

        For iLoop As Integer = 0 To 99

            ClearFromCache("Data.Leave.Balances[" & iLoop.ToString() & "]." & SessionID)

        Next

        ' *** Linked Documents ***
        ClearFromCache("Data.LinkedDocs." & SessionID)

        ' *** Loans ***
        ClearFromCache("Data.Loans.Applications." & SessionID)

        ClearFromCache("Data.Loans.Status." & SessionID)

        ' *** OH&S ***
        ClearFromCache("Data.OHS.Consultations." & SessionID)

        ClearFromCache("Data.OHS.Consultations.Body." & SessionID)

        ClearFromCache("Data.OHS.Incidents." & SessionID)

        ClearFromCache("Data.OHS.Incidents.Body." & SessionID)

        ClearFromCache("Data.OHS.Incidents.Notes." & SessionID)

        ClearFromCache("Data.OHS.Surveillance." & SessionID)

        ClearFromCache("Data.OHS.Surveillance.Tests." & SessionID)

        ' *** Organizational ***
        ClearFromCache("Data.Organizational.CostCentre." & SessionID)

        ClearFromCache("Data.Organizational.ReportsTo." & SessionID)

        ClearFromCache("Data.Organizational.ReportsTo.TORoles." & SessionID)

        ClearFromCache("Data.Organizational.Contracts." & SessionID)

        ' *** Personal ***
        ClearFromCache("Data.Personal." & SessionID)

        ClearFromCache("Data.Personal.Creation." & SessionID)

        ClearFromCache("Data.Personal.OtherLanguage." & SessionID)

        ClearFromCache("Data.Personal.NextOfKin." & SessionID)

        ClearFromCache("Data.Personal.Dependants." & SessionID)

        ' *** Reports ***
        ClearFromCache("Data.Users.Reports." & SessionID)

        ' *** Routing (Rules) ***
        ClearFromCache("Data.Routing." & SessionID)

        ' *** Tasks ***
        ClearFromCache("Data.Tasks.Inbox." & SessionID)

        ClearFromCache("Data.Tasks.Alternative." & SessionID)

        ClearFromCache("Data.Tasks.Pending." & SessionID)

        ClearFromCache("Data.Tasks.Completed." & SessionID)

        ' *** Timesheets ***
        ClearFromCache("Data.Timesheets.Register." & SessionID)

        ClearFromCache("Data.Timesheets.Register.Items." & SessionID)

        ClearFromCache("Data.Timesheets.Register.Items.Child." & SessionID)

        ClearFromCache("Data.Timesheets.History." & SessionID)

        ClearFromCache("Data.Timesheets.History.Items." & SessionID)

        ClearFromCache("Data.Timesheets.History.Items.Child." & SessionID)

        ClearFromCache("Data.Timesheets.Types." & SessionID)

        ClearFromCache("Data.Timesheets.Types.Items." & SessionID)

        ClearFromCache("Data.Timesheets.Setup." & SessionID)

        ClearFromCache("Data.Timesheets.Setup.Types." & SessionID)

        ' *** Training ***
        ClearFromCache("Data.Training.TrainingCurriculum." & SessionID)

        ClearFromCache("Data.Training.Local." & SessionID)

        ClearFromCache("Data.Training.External." & SessionID)

        ClearFromCache("Data.Training.Overseas." & SessionID)

        ClearFromCache("Data.Training.Events.Plan." & SessionID)

        ClearFromCache("Data.Training.Completed." & SessionID)

        ClearFromCache("Data.Training.Plan." & SessionID)

        ClearFromCache("Data.Training.Plan.Courses." & SessionID)

        ClearFromCache("Data.Training.Planned." & SessionID)

        'ClearFromCache("Data.Training.Planned.Requests." & SessionID)

        ClearFromCache("Data.Training.Skills." & SessionID)

        ClearFromCache("Data.Training.External.Budget." & SessionID)

        'ClearFromCache("Data.Training.CourseLU." & SessionID)

        ClearFromCache("Data.Training.TAF.ProgramDetails." & SessionID)

        ClearFromCache("Data.Training.TAF.History." & SessionID)

        ClearFromCache("Data.Training.TAFMaintenance.Functional." & SessionID)

        ClearFromCache("Data.Training.TAFMaintenance.Specialized." & SessionID)

        ClearFromCache("Data.Training.External.Budget." & SessionID)

        ClearFromCache("Data.Training.External.Monitoring." & SessionID)

        ' *** Workflow ***
        ClearFromCache("Data.Workflow.Processes." & SessionID)

        ' *** TWS ***


        ClearFromCache("Data.TWS.Keyword." & SessionID)
        ClearFromCache("Data.TWS.EssayItems." & SessionID)
        ClearFromCache("Data.TWS.Keyword.Items." & SessionID)
    End Sub

    Public Sub ClearFromCache(ByVal CacheKey As String)

        Try

            If (Not IsNull(Cache(CacheKey))) Then Cache.Remove(CacheKey)

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

    End Sub

    Public Sub InsertCache(ByRef objValue As Object, ByVal CacheKey As String, ByVal CacheDuration As String)

        Try

            If (IsNull(Cache(CacheKey))) Then

                Dim cDuration As Double = Convert.ToDouble(GetXML(CacheDuration, KeyName:="Duration"))

                Select Case GetXML(CacheDuration, KeyName:="TimeSpan").ToLower()

                    Case "seconds"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddSeconds(cDuration), TimeSpan.Zero)

                    Case "minutes"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddMinutes(cDuration), TimeSpan.Zero)

                    Case "hours"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddHours(cDuration), TimeSpan.Zero)

                    Case "days"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddDays(cDuration), TimeSpan.Zero)

                    Case "months"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddMonths(cDuration), TimeSpan.Zero)

                    Case "years"
                        Cache.Insert(CacheKey, objValue, Nothing, DateTime.Now.AddYears(cDuration), TimeSpan.Zero)

                End Select

            Else

                Cache(CacheKey) = objValue

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

    End Sub

    Public Sub UpdateCache(ByRef objValue As Object, ByVal CacheKey As String, ByVal CacheDuration As String)

        Try

            If (Not IsNull(Cache(CacheKey))) Then

                Cache(CacheKey) = objValue

            Else

                InsertCache(objValue, CacheKey, CacheDuration)

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

    End Sub

#End Region

#Region " *** Data Functions (Public) *** "

    Public Sub ExecQuery(ByRef pQuery As String)

        Using sqlCon As New SqlConnection(SQLString)
            Try
                Dim sqlCmd As SqlCommand = New SqlCommand
                With sqlCmd
                    .Connection = sqlCon
                    .Connection.Open()
                    .CommandText = pQuery
                    .CommandTimeout = 0
                    .CommandType = CommandType.Text
                    .ExecuteNonQuery()
                End With

            Catch ex As Exception

                WriteEventLog(ex)

            End Try
        End Using

    End Sub

    Public Function ExecSQL(ByRef SQL As String) As Boolean

        Return ExecSQL(SQL, Nothing)

    End Function

    Public Function ExecSQL(ByRef SQL As String, ByRef ReturnID As Object) As Boolean

        Dim result As Boolean

        Dim dbConnect As SqlClient.SqlConnection = Nothing

        Dim dbCommand As SqlClient.SqlCommand = Nothing

        Dim dbTrans As SqlClient.SqlTransaction = Nothing

        Dim PathID As String = String.Empty

        Dim SQLExec As String = SQL

        Try

            dbConnect = New SqlClient.SqlConnection(m_SQLString)

            dbCommand = New SqlClient.SqlCommand(SQL, dbConnect)

            dbCommand.CommandType = CommandType.Text

            dbCommand.CommandTimeout = 900

            dbConnect.Open()

            dbTrans = dbConnect.BeginTransaction()

            dbCommand.Transaction = dbTrans

            If (IsNull(ReturnID)) Then

                If (Not SQL.ToLower().StartsWith("exec ")) Then

                    dbCommand.ExecuteNonQuery()

                Else

                    If (Not SQL.ToLower().StartsWith("exec [ess.perfsubmit] ") AndAlso Not SQL.ToLower().StartsWith("exec [ess.wfproc] ")) Then

                        dbCommand.ExecuteNonQuery()

                    Else

                        SQL = dbCommand.ExecuteScalar()

                        If (SQLExec.ToLower().StartsWith("exec [ess.perfsubmit] ")) Then

                            SQLExec = Regex.Replace(SQLExec, EscapeRegex("exec [ess.perfsubmit] "), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                            SQLExec = SQLExec.Replace("', '", " ").Replace("','", " ").Replace(" '", String.Empty)

                            SQLExec = SQLExec.Split(" ")(0) & " " & SQLExec.Split(" ")(1) & " " & SQLExec.Split(" ")(3)

                            ExecNotify(SQLExec)

                        Else

                            PathID = GetXML(SQL, KeyName:="PathID")

                            If (IsNumeric(PathID)) Then

                                If (Not IsNull(dbTrans)) Then

                                    dbTrans.Commit()

                                    dbTrans.Dispose()

                                    dbTrans = Nothing

                                End If

                                ProcessRoutingRules(PathID)

                                ExecNotify(PathID)

                            End If

                        End If

                    End If

                End If

            Else

                dbCommand.CommandText &= ";select scope_identity()"

                ReturnID = dbCommand.ExecuteScalar()

            End If

            result = True

        Catch ex As Exception

            WriteEventLog(ex)

            WriteEventLog(SQL)

            ReturnID = 0

            SQL = ex.Message

            'If (Not m_ExecProc) Then 'CatchError(ex)

        Finally

            If (Not IsNull(dbTrans)) Then

                If (result) Then

                    dbTrans.Commit()

                Else

                    dbTrans.Rollback()

                End If

                dbTrans.Dispose()

                dbTrans = Nothing

            End If

            If (Not IsNull(dbCommand)) Then

                dbCommand.Dispose()

                dbCommand = Nothing

            End If

            If (Not IsNull(dbConnect)) Then

                If (Not dbConnect.State = ConnectionState.Closed) Then dbConnect.Close()

                dbConnect.Dispose()

                dbConnect = Nothing

            End If

        End Try

        Return result

    End Function

    Public Function ExecSQL(ByRef dbConnect As SqlClient.SqlConnection, ByRef SQL As String) As Boolean

        Return ExecSQL(dbConnect, SQL, Nothing)

    End Function

    Public Function ExecSQL(ByRef dbConnect As SqlClient.SqlConnection, ByRef SQL As String, ByRef ReturnID As Object) As Boolean

        Dim result As Boolean

        Dim dbCommand As SqlClient.SqlCommand = Nothing

        Dim dbTrans As SqlClient.SqlTransaction = Nothing

        Dim PathID As String = String.Empty

        Dim SQLExec As String = SQL

        Try

            dbCommand = New SqlClient.SqlCommand(SQL, dbConnect)

            dbCommand.CommandType = CommandType.Text

            dbCommand.CommandTimeout = 900

            dbTrans = dbConnect.BeginTransaction()

            dbCommand.Transaction = dbTrans

            If (IsNull(ReturnID)) Then

                If (Not SQL.ToLower().StartsWith("exec ")) Then

                    dbCommand.ExecuteNonQuery()

                Else

                    If (Not SQL.ToLower().StartsWith("exec [ess.perfsubmit] ") AndAlso Not SQL.ToLower().StartsWith("exec [ess.wfproc] ")) Then

                        dbCommand.ExecuteNonQuery()

                    Else

                        SQL = dbCommand.ExecuteScalar()

                        If (SQLExec.ToLower().StartsWith("exec [ess.perfsubmit] ")) Then

                            SQLExec = Regex.Replace(SQLExec, EscapeRegex("exec [ess.perfsubmit] "), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                            SQLExec = SQLExec.Replace("', '", " ").Replace("','", " ").Replace(" '", String.Empty)

                            SQLExec = SQLExec.Split(" ")(0) & " " & SQLExec.Split(" ")(1) & " " & SQLExec.Split(" ")(3)

                            ExecNotify(SQLExec)

                        Else

                            PathID = GetXML(SQL, KeyName:="PathID")

                            If (IsNumeric(PathID)) Then ExecNotify(PathID)

                        End If

                    End If

                End If

            Else

                dbCommand.CommandText &= ";select scope_identity()"

                ReturnID = dbCommand.ExecuteScalar()

            End If

            result = True

        Catch ex As Exception

            ReturnID = 0

            SQL = ex.Message

            'If (Not m_ExecProc) Then 'CatchError(ex)

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dbTrans)) Then

                If (result) Then

                    dbTrans.Commit()

                Else

                    dbTrans.Rollback()

                End If

                dbTrans.Dispose()

                dbTrans = Nothing

            End If

            If (Not IsNull(dbCommand)) Then

                dbCommand.Dispose()

                dbCommand = Nothing

            End If

        End Try

        Return result

    End Function

    Public Function GetBitData(ByVal value As Boolean) As String

        If (value) Then

            Return "1"

        Else

            Return "0"

        End If

    End Function

    Public Function GetCacheObject(ByVal Key As String) As Object

        Dim Value As Object = Nothing

        Try

            If (Not IsNull(Cache(Key))) Then Value = Cache(Key)

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return Value

    End Function

    Public Function GetDataText(ByVal text As String, Optional ByVal ReplaceWildCard As Boolean = False) As String

        Dim Result As String = String.Empty

        If (IsString(text)) Then Result = text.Replace("'", "''")

        If (ReplaceWildCard) Then Result = Result.Replace("*", "%")

        Return Result

    End Function

    Public Function GetNullDate(ByVal value As Object) As String

        If (IsDate(value)) Then

            Return "'" & Convert.ToDateTime(value).ToString("yyyy-MM-dd HH:mm:ss") & "'"

        Else

            Return "null"

        End If

    End Function

    Public Function GetNullText(ByVal text As String) As String

        Return (GetNullText(TryCast(text, Object)))

    End Function

    Public Function GetNullText(ByVal value As Object) As String

        If (IsNull(value)) Then

            Return "null"

        Else

            If (TypeOf value Is String) Then

                If (Not IsString(value)) Then

                    Return "null"

                Else

                    Return ("'" & GetDataText(value.ToString()) & "'")

                End If

            Else

                If (IsNumeric(value)) Then

                    If (TypeOf value Is Byte AndAlso value.Equals(0)) Then

                        Return "null"

                    Else

                        Return value.ToString()

                    End If

                Else

                    If ((TypeOf value Is Date OrElse TypeOf value Is DateTime) AndAlso Not IsDate(value)) Then

                        Return "null"

                    ElseIf (TypeOf value Is Date OrElse TypeOf value Is DateTime) Then

                        Return value.ToString()

                    ElseIf (TypeOf value Is Guid AndAlso Not value.Equals(Guid.Empty)) Then

                        Return "'" & value.ToString() & "'"

                    Else

                        Return "null"

                    End If

                End If

            End If

        End If

    End Function

    Public Function GetNullValue(ByVal value As Object) As Object

        If (IsNull(value)) Then

            Return DBNull.Value

        Else

            If (TypeOf value Is String) Then

                If (Not IsString(value)) Then

                    Return DBNull.Value

                ElseIf (value.Equals("null")) Then

                    Return DBNull.Value

                Else

                    Return value

                End If

            Else

                If (IsNumeric(value)) Then

                    If (TypeOf value Is Byte AndAlso value.Equals(0)) Then

                        Return DBNull.Value

                    Else

                        Return value

                    End If

                Else

                    If ((TypeOf value Is Date OrElse TypeOf value Is DateTime) AndAlso Not IsDate(value)) Then

                        Return DBNull.Value

                    ElseIf (TypeOf value Is Date OrElse TypeOf value Is DateTime) Then

                        Return value

                    Else

                        Return DBNull.Value

                    End If

                End If

            End If

        End If

    End Function

    Public Function GetSQLField(ByVal SQL As String, ByVal ItemName As String, Optional ByVal CacheKey As String = "", Optional ByVal Where As String = "") As Object

        Dim ReturnObject As Object = Nothing

        Dim dtTable As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Try

            dtTable = GetSQLDT(SQL, CacheKey)

            If (IsData(dtTable)) Then

                If (dtTable.Columns.Contains(ItemName)) Then

                    If (Where.Length > 0) Then

                        dtRows = dtTable.Select(Where)

                    Else

                        dtRows = New DataRow() {dtTable.Rows(0)}

                    End If

                    If (Not IsNull(dtRows)) Then

                        If (dtRows.GetLength(0) > 0) Then

                            ReturnObject = dtRows(0).Item(ItemName)

                            If (IsDBNull(ReturnObject)) Then ReturnObject = Nothing

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtTable)) Then

                dtTable.Dispose()

                dtTable = Nothing

            End If

        End Try

        Return ReturnObject

    End Function

    Public Function GetSQLFields(ByVal SQL As String, Optional ByVal CacheKey As String = "", Optional ByVal Where As String = "") As Object()

        Dim ReturnObject() As Object = Nothing

        Dim dtTable As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Try

            dtTable = GetSQLDT(SQL, CacheKey)

            If (IsData(dtTable)) Then

                If (Where.Length > 0) Then

                    dtRows = dtTable.Select(Where)

                Else

                    dtRows = New DataRow() {dtTable.Rows(0)}

                End If

                If (Not IsNull(dtRows)) Then

                    If (dtRows.GetLength(0) > 0) Then

                        ReDim ReturnObject(dtTable.Columns.Count - 1)

                        For iLoop As Integer = 0 To (dtTable.Columns.Count - 1)

                            ReturnObject(iLoop) = dtRows(0).Item(iLoop)

                            If (IsDBNull(ReturnObject(iLoop))) Then ReturnObject(iLoop) = Nothing

                        Next

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtTable)) Then

                dtTable.Dispose()

                dtTable = Nothing

            End If

        End Try

        Return ReturnObject

    End Function

    Public Function GetSQLRowValues(ByVal SQL As String, ByVal sField As String, ByVal prefix As String, ByVal suffix As String, ByVal split As String, Optional ByVal PathID As String = "") As String

        Dim objReturn As String = String.Empty

        Dim dtData As DataTable = Nothing

        Try

            dtData = GetSQLDT(SQL)

            If (IsData(dtData)) Then

                Dim iCount As Integer = (dtData.Rows.Count - 1)

                For iLoop As Integer = 0 To iCount

                    If (Not Regex.IsMatch(dtData.Rows(iLoop).Item(sField), "^" & EscapeRegex(prefix), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then objReturn &= prefix

                    objReturn &= dtData.Rows(iLoop).Item(sField)

                    If (Not Regex.IsMatch(dtData.Rows(iLoop).Item(sField), EscapeRegex(suffix) & "$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then objReturn &= suffix

                    If (iLoop < iCount) Then objReturn &= split

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtData)) Then

                dtData.Dispose()

                dtData = Nothing

            End If

        End Try

        If (IsString(objReturn) AndAlso IsString(PathID)) Then objReturn = Regex.Replace(objReturn, EscapeRegex("<%PathID%>"), PathID, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        Return objReturn

    End Function

    Public Function GetSQLDS(ByVal SQL As String) As DataSet

        Return GetSQLDS(SQL, String.Empty, String.Empty, False)

    End Function

    Public Function GetSQLDS(ByVal SQL As String, ByVal TableName As String) As DataSet

        Return GetSQLDS(SQL, TableName, String.Empty, False)

    End Function

    Public Function GetSQLDS(ByVal SQL As String, ByVal TableName As String, ByVal CacheKey As String) As DataSet

        Return GetSQLDS(SQL, TableName, CacheKey, False)

    End Function

    Public Function GetSQLDS(ByVal SQL As String, ByVal TableName As String, ByVal CacheKey As String, ByVal ClearCache As Boolean) As DataSet

        Dim bUpdateCache As Boolean

        Dim dgAdap As SqlClient.SqlDataAdapter = Nothing

        Dim dtSet As DataSet = Nothing

        Dim CacheDuration As String = String.Empty

        Try

            If (Not IsString(TableName)) Then TableName = "Table1"

            CacheDuration = GetXML(CacheKey, KeyName:="CacheDuration")

            If (CacheDuration.Length > 0) Then CacheKey = CacheKey.Replace("<CacheDuration=" & CacheDuration & ">", String.Empty)

            dtSet = Cache(CacheKey)

            If (ClearCache OrElse IsNull(dtSet)) Then

                dtSet = New DataSet()

                dgAdap = New SqlClient.SqlDataAdapter(SQL, m_SQLString)

                If (Not IsNull(dgAdap)) Then dgAdap.Fill(dtSet, TableName)

                If (CacheKey.Length > 0) Then bUpdateCache = True

            End If

            If (Not IsNull(dtSet)) Then

                If (bUpdateCache AndAlso CacheKey.Length > 0) Then

                    If (IsNumeric(CacheDuration)) Then

                        Cache.Insert(CacheKey, dtSet, Nothing, DateTime.Now.AddHours(Convert.ToDouble(CacheDuration)), TimeSpan.Zero)

                    Else

                        If (Not CacheKey.EndsWith(".Structure") AndAlso Not CacheKey.EndsWith(".Nullable")) Then

                            Cache.Insert(CacheKey, dtSet, Nothing, DateTime.Now.AddDays(1), TimeSpan.Zero)

                        Else

                            Cache.Insert(CacheKey, dtSet, Nothing, DateTime.Now.AddDays(7), TimeSpan.Zero)

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dgAdap)) Then

                dgAdap.Dispose()

                dgAdap = Nothing

            End If

        End Try

        Return dtSet

    End Function

    Public Function GetSQLDT(ByVal SQL As String) As DataTable

        Return GetSQLDT(SQL, String.Empty, False)

    End Function

    Public Function GetSQLDT(ByVal SQL As String, ByVal CacheKey As String) As DataTable

        Return GetSQLDT(SQL, CacheKey, False)

    End Function

    Public Function GetSQLDT(ByVal SQL As String, ByVal CacheKey As String, ByVal ClearCache As Boolean) As DataTable

        Dim bUpdateCache As Boolean

        Dim dgAdap As SqlClient.SqlDataAdapter = Nothing

        Dim dtTable As DataTable = Nothing

        Dim CacheDuration As String = String.Empty

        Try

            CacheDuration = GetXML(CacheKey, KeyName:="CacheDuration")

            If (CacheDuration.Length > 0) Then CacheKey = CacheKey.Replace("<CacheDuration=" & CacheDuration & ">", String.Empty)

            dtTable = Cache(CacheKey)

            If (ClearCache OrElse IsNull(dtTable)) Then

                dtTable = New DataTable()

                dgAdap = New SqlClient.SqlDataAdapter(SQL, m_SQLString)

                If (Not IsNull(dgAdap)) Then dgAdap.Fill(dtTable)

                If (CacheKey.Length > 0) Then bUpdateCache = True

            End If

            If (Not IsNull(dtTable)) Then

                If (bUpdateCache AndAlso CacheKey.Length > 0) Then

                    If (IsNumeric(CacheDuration)) Then

                        Cache.Insert(CacheKey, dtTable, Nothing, DateTime.Now.AddHours(Convert.ToDouble(CacheDuration)), TimeSpan.Zero)

                    Else

                        If (Not CacheKey.EndsWith(".Structure") AndAlso Not CacheKey.EndsWith(".Nullable")) Then

                            Cache.Insert(CacheKey, dtTable, Nothing, DateTime.Now.AddDays(1), TimeSpan.Zero)

                        Else

                            Cache.Insert(CacheKey, dtTable, Nothing, DateTime.Now.AddDays(7), TimeSpan.Zero)

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dgAdap)) Then

                dgAdap.Dispose()

                dgAdap = Nothing

            End If

        End Try

        Return dtTable

    End Function

    Public Function IsData(ByRef dSet As DataSet) As Boolean

        Dim result As Boolean

        If (Not IsNull(dSet) AndAlso dSet.Tables.Count > 0) Then

            result = True

            For i As Integer = 0 To (dSet.Tables.Count - 1)

                If (dSet.Tables(i).Rows.Count = 0) Then

                    result = False

                    Exit For

                End If

            Next

        End If

        Return result

    End Function

    Public Function IsData(ByRef dTable As DataTable, Optional ByVal CheckRows As Boolean = True) As Boolean

        Dim result As Boolean

        If (CheckRows) Then

            If (Not IsNull(dTable)) Then result = Convert.ToBoolean(dTable.Rows.Count > 0)

        Else

            If (Not IsNull(dTable)) Then result = True

        End If

        Return result

    End Function

#End Region

#Region " *** Email Functions (Private) *** "

    Private Function GetProcessedHtml(ByVal root As String, ByRef eMessage As MailMessage, ByVal Body As String, ByRef iAttachments() As Attachment, ByVal PathID As String, Optional ByVal htmlFile As String = "emails.htm") As String

        Dim ReturnText As String = Body

        Dim mCollection As MatchCollection = Nothing

        Dim FileAttach As FileInfo = Nothing

        Dim EmailBody As String = String.Empty

        Try

            If (Not IsNull(eMessage) AndAlso File.Exists(root & "\" & htmlFile)) Then

                EmailBody = Regex.Replace(File.ReadAllText(root & "\" & htmlFile), "\<%body%\>", Body, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                If (String.IsNullOrEmpty(EmailBody) AndAlso Not String.IsNullOrEmpty(Body)) Then EmailBody = Body

                'RNaanep 2016-04-05 Start = Email Image Attachment
                EmailBody = EmailBody.Replace("ESS-TMP-LIVE/ESS-TMP-LIVE", "/ESS-TMP-LIVE")
                'RNaanep 2016-04-05 End

                ReturnText = EmailBody

                mCollection = Regex.Matches(EmailBody, "\<img.*?src=.*?/\>", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                If (Not IsNull(mCollection)) Then

                    Dim nodeValue As String = String.Empty
                    Dim FilePath As String = String.Empty
                    Dim ContentID As String = String.Empty

                    ReDim iAttachments(mCollection.Count - 1)

                    Dim iIndex As Integer = 0

                    For Each mItem As Match In mCollection

                        nodeValue = Regex.Replace(Regex.Match(mItem.Value, "src=[""'].*?[""']", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase).Value, "src=", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase).Replace("""", String.Empty).Replace("'", String.Empty)

                        FilePath = root & "\" & nodeValue.Replace("/", "\")

                        If (File.Exists(FilePath)) Then

                            FileAttach = New FileInfo(FilePath)

                            ContentID = FileAttach.Name.Replace(FileAttach.Extension, String.Empty)

                            If (Not Regex.IsMatch(ReturnText, "src=cid\:" & ContentID, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                iAttachments(iIndex) = New Attachment(FilePath)

                                If (Not IsNull(iAttachments(iIndex))) Then

                                    With iAttachments(iIndex)

                                        .ContentDisposition.Inline = True

                                        .ContentDisposition.DispositionType = DispositionTypeNames.Inline

                                        .ContentId = ContentID

                                        .ContentType.MediaType = GetFileContentType(FileAttach.Extension)

                                        .ContentType.Name = FilePath

                                    End With

                                    eMessage.Attachments.Add(iAttachments(iIndex))

                                    ReturnText = Regex.Replace(ReturnText, nodeValue, "cid:" & ContentID, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                End If

                            End If

                        End If

                        iIndex += 1

                    Next

                End If

            Else

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(FileAttach)) Then FileAttach = Nothing

            If (Not IsNull(mCollection)) Then mCollection = Nothing

        End Try

        Return GetTableHtml(ReturnText, PathID).Replace("<%WebServer%>", GetSQLField("select top 1 [WebServer] from [Various]", "WebServer", "Data.WebServer"))

    End Function

    Private Function GetProcessedText(ByVal root As String, ByRef eMessage As MailMessage, ByVal Body As String, ByVal PathID As String, Optional ByVal txtFile As String = "emails.txt") As String

        Dim ReturnText As String = Body

        Dim EmailBody As String = String.Empty

        Try

            If (Not IsNull(eMessage) AndAlso File.Exists(root & "\" & txtFile)) Then

                EmailBody = Regex.Replace(File.ReadAllText(root & "\" & txtFile), "\<%body%\>", Body, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                If (String.IsNullOrEmpty(EmailBody) AndAlso Not String.IsNullOrEmpty(Body)) Then EmailBody = Body

                ReturnText = EmailBody

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

        Return GetTableText(ReturnText, PathID).Replace("<%WebServer%>", GetSQLField("select top 1 [WebServer] from [Various]", "WebServer", "Data.WebServer"))

    End Function

    Private Function GetTableHtml(ByVal Body As String, ByVal PathID As String) As String

        Dim ReturnText As String = Body

        Dim SQLTable As String = String.Empty

        Dim hTable As String = String.Empty

        Dim dtSQL As DataTable = Nothing

        Dim dtQRY As DataTable = Nothing

        Dim objValue As Object = Nothing

        Dim xCtr As Integer = Nothing

        Try
            ReturnText = Replace(ReturnText, "]%>", "]")

            xCtr = (Len(ReturnText) - Len(Replace(ReturnText, "{TABLE", ""))) / Len("{TABLE")

            While (xCtr > 0)

                SQLTable = GetXML(ReturnText, "{", "TABLE" & xCtr, ":", "}")

                If SQLTable.Contains("SELECT[") Then
                    Dim xStr As Integer = SQLTable.IndexOf("[")
                    Dim xEnd As Integer = SQLTable.IndexOf("]") - (xStr + 1)
                    dtQRY = GetSQLDT("SELECT TOP(1) Query FROM [TableLU] WHERE ID = '" & SQLTable.Substring(xStr + 1, xEnd) & "'")
                    Dim xQry = dtQRY.Rows(0)("Query").ToString()
                    SQLTable = xQry.Replace("--", "")
                End If

                While (SQLTable.Length > 0)

                    dtSQL = GetSQLDT(SQLTable.Replace("<%PathID%>", PathID))

                    If (IsData(dtSQL)) Then

                        hTable = "<table style=""margin: 0px; padding: 0px; width: 100%""><tr style=""font-weight: bold"">"

                        For iLoop As Integer = 0 To (dtSQL.Columns.Count - 1)

                            hTable &= "<td>" & dtSQL.Columns(iLoop).ColumnName & "</td>"

                        Next

                        hTable &= "</tr>"

                        For iLoop As Integer = 0 To (dtSQL.Rows.Count - 1)

                            hTable &= "<tr>"

                            For iLoopCols As Integer = 0 To (dtSQL.Columns.Count - 1)

                                objValue = dtSQL.Rows(iLoop).Item(iLoopCols)

                                If (Not IsNull(objValue)) Then

                                    hTable &= "<td>"

                                    If (IsDate(objValue)) Then

                                        hTable &= Convert.ToDateTime(objValue).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat"))

                                    Else

                                        hTable &= objValue.ToString()

                                    End If

                                    hTable &= "</td>"

                                Else

                                    hTable &= "<td>&nbsp;</td>"

                                End If

                            Next

                            hTable &= "</tr>"

                        Next

                        hTable &= "</table>"

                    End If

                    ReturnText = Regex.Replace(ReturnText, EscapeRegex("{TABLE" & xCtr & ":" & SQLTable & "}"), hTable, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    SQLTable = GetXML(ReturnText, "{", "TABLE" & xCtr, ":", "}")

                End While

                xCtr -= 1

            End While

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtSQL)) Then

                dtSQL.Dispose()

                dtSQL = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Private Function GetTableText(ByVal Body As String, ByVal PathID As String) As String

        Dim ReturnText As String = Body

        Dim dtSQL As DataTable = Nothing

        Dim SQLTable As String = String.Empty

        Dim hTable As String = String.Empty

        Dim objValue As Object = Nothing

        Try

            SQLTable = GetXML(ReturnText, "{", "TABLE", ":", "}")

            While (SQLTable.Length > 0)

                dtSQL = GetSQLDT(SQLTable.Replace("<%PathID%>", PathID))

                If (IsData(dtSQL)) Then

                    For iLoop As Integer = 0 To (dtSQL.Columns.Count - 1)

                        hTable &= dtSQL.Columns(iLoop).ColumnName & Chr(9) & Chr(9)

                    Next

                    hTable &= vbCrLf & vbCrLf

                    For iLoop As Integer = 0 To (dtSQL.Rows.Count - 1)

                        For iLoopCols As Integer = 0 To (dtSQL.Columns.Count - 1)

                            objValue = dtSQL.Rows(iLoop).Item(iLoopCols)

                            If (Not IsNull(objValue)) Then

                                If (IsDate(objValue)) Then

                                    hTable &= Convert.ToDateTime(objValue).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat"))

                                Else

                                    hTable &= objValue.ToString()

                                End If

                                hTable &= Chr(9) & Chr(9)

                            Else

                                hTable &= String.Empty & Chr(9) & Chr(9)

                            End If

                        Next

                        hTable &= vbCrLf

                    Next

                End If

                ReturnText = Regex.Replace(ReturnText, EscapeRegex("{TABLE:" & SQLTable & "}"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                SQLTable = GetXML(ReturnText, "{", "TABLE", ":", "}")

            End While

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtSQL)) Then

                dtSQL.Dispose()

                dtSQL = Nothing

            End If

        End Try

        Return ReturnText

    End Function

#End Region

#Region " *** Email Procedures (Public) *** "

    Public Sub DeleteReport(ByVal xrPath As String)

        Dim wThread As Thread = Nothing

        Try

            wThread = New Thread(AddressOf DeleteReportThread)

            wThread.Start(New Object() {ServerPath & "\" & xrPath.Replace("/", "\")})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

    Public Sub DeleteReportThreadTimer(ByVal state As Object)

        Try

            If (File.Exists(state(0))) Then File.Delete(state(0))

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

    End Sub

    Public Sub SendBulkEmail(ByVal root As String, ByVal SessionID As String, ByRef arSendTo() As String, ByRef arSubject() As String, ByRef arBody() As String)

        Dim wThread As Thread = Nothing

        Try

            Cache.Insert(SessionID & ".Progress", 0, Nothing, DateTime.Now.AddHours(1), TimeSpan.Zero)

            wThread = New Thread(AddressOf SendBulkEmailThread)

            wThread.Start(New Object() {arSendTo, arSubject, arBody, SessionID, root})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

    Public Sub SendEmail(ByVal root As String, ByVal id As Byte, ByVal SendTo As String, ByVal Attachment As String, ByVal delAttachments As Boolean, ByVal PathID As String, ByVal ParamArray Param() As Object)

        Dim wThread As Thread = Nothing

        Try

            If (root.EndsWith("\")) Then root = root.Substring(0, root.Length - 1)

            wThread = New Thread(AddressOf SendEmailThread)

            wThread.Start(New Object() {root, id, SendTo, Attachment, delAttachments, Param, PathID})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

#End Region

#Region " *** Email Functions (Public) *** "

    Public Function SendBulkEmailThread(ByVal state As Object) As Object

        Dim SendTo() As String = state(0)

        Dim Subject() As String = state(1)

        Dim Body() As String = state(2)

        Dim eServer As SmtpClient = Nothing

        Dim Username As String = String.Empty

        Dim Password As String = String.Empty

        Dim eMessage As MailMessage = Nothing

        Dim objEmailLU() As Object = GetSQLFields("select top 1 [Server], [Port], [Username], [Password], [Name], [Address] from [EmailLU]")

        Dim plainText As AlternateView = Nothing

        Dim htmlText As AlternateView = Nothing

        Dim iAttachments() As Attachment = Nothing

        Dim iCount As Integer = (SendTo.GetLength(0) - 1)

        If (Not IsNull(objEmailLU)) Then

            If (Not IsNull(objEmailLU(0)) AndAlso Not IsNull(objEmailLU(1))) Then

                If (objEmailLU(0).Length > 0) Then

                    Try

                        eServer = New SmtpClient(objEmailLU(0), objEmailLU(1))

                        Username = objEmailLU(2)

                        Password = CryptoDecrypt(objEmailLU(3), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                        If (Not IsNull(Username) AndAlso Not IsNull(Password)) Then

                            If (Username.Length > 0 AndAlso Password.Length > 0) Then eServer.Credentials = New NetworkCredential(Username, Password)

                        End If

                        For iLoop As Integer = 0 To iCount

                            Try

                                eMessage = New MailMessage()

                                eMessage.From = New MailAddress(objEmailLU(5), objEmailLU(4))

                                eMessage.To.Add(New MailAddress(SendTo(iLoop)))

                                eMessage.Subject = Subject(iLoop)

                                plainText = AlternateView.CreateAlternateViewFromString(GetProcessedText(state(4), eMessage, Body(iLoop).ToString(), "bulkemails.txt"), Nothing, "text/plain")

                                htmlText = AlternateView.CreateAlternateViewFromString(GetProcessedHtml(state(4), eMessage, Body(iLoop).ToString(), iAttachments, "bulkemails.htm"), Nothing, "text/html")

                                eMessage.AlternateViews.Add(htmlText)

                                eMessage.AlternateViews.Add(plainText)

                                eServer.Send(eMessage)

                                ExecSQL("insert into [EmailResults]([ID], [Date], [Server], [Port], [Username], [Password], [From], [To], [Subject], [Message], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & objEmailLU(0) & "', " & objEmailLU(1).ToString() & ", " & GetNullText(Username) & ", " & GetNullText(objEmailLU(3)) & ", '" & objEmailLU(5) & "', '" & SendTo(iLoop) & "', '" & GetDataText(Subject(iLoop)) & "', '" & GetDataText(Body(iLoop)) & "', 'Submitted')")

                            Catch ex As Exception

                                WriteEventLog(ex)

                                ExecSQL("insert into [EmailResults]([ID], [Date], [Server], [Port], [Username], [Password], [From], [To], [Subject], [Message], [Status], [ErrorText]) values('" & Guid.NewGuid().ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & objEmailLU(0) & "', " & objEmailLU(1).ToString() & ", " & GetNullText(Username) & ", " & GetNullText(objEmailLU(3)) & ", '" & objEmailLU(5) & "', '" & SendTo(iLoop) & "', '" & GetDataText(Subject(iLoop)) & "', '" & GetDataText(Body(iLoop)) & "', 'Undeliverable', '" & GetDataText(ex.ToString()) & "')")

                            Finally

                                If (Not IsNull(eMessage)) Then eMessage = Nothing

                            End Try

                            Cache.Insert(state(3).ToString() & ".Progress", Convert.ToInt32(((iLoop + 1) / (iCount + 1)) * 100), Nothing, DateTime.Now.AddHours(1), TimeSpan.Zero)

                        Next

                    Catch ex As Exception

                        WriteEventLog(ex)

                    Finally

                        If (Not IsNull(eServer)) Then eServer = Nothing

                    End Try

                End If

            End If

        End If

        Return Nothing

    End Function

    Public Function SendEmailThread(ByVal state As Object) As Object

        Dim dEmailLU As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim eServer As SmtpClient = Nothing

        Dim Username As String = String.Empty

        Dim Password As String = String.Empty

        Dim eMessage As MailMessage = Nothing

        Dim iLoop As Integer = 0

        Dim SentFrom As String = String.Empty

        Dim SendTo() As String = {String.Empty, String.Empty, String.Empty}

        Dim SendToAddy() As String = Nothing

        Dim iAttach() As Attachment = Nothing

        Dim iAttachments() As Attachment = Nothing

        Dim iAttachment As Attachment = Nothing

        Dim AttachFiles() As String = Nothing

        Dim htmlBody As String = String.Empty

        Dim plainText As AlternateView = Nothing

        Dim htmlText As AlternateView = Nothing

        Dim iCount As Integer

        Dim Attachments As String = String.Empty

        Dim AttachName As String = String.Empty

        Dim AttachPath As String = String.Empty

        Dim PathID As String = state(6)

        Dim dtAttachments As DataTable = Nothing

        Try

            dEmailLU = GetSQLDT("select [ID], [Type], [Server], [Port], [Name], [Address], [Username], [Password], [Subject], [Body], [BodyText] from [EmailLU]", "Data.EmailLU")

            If (IsData(dEmailLU)) Then

                dtRows = dEmailLU.Select("[ID] = " & state(1).ToString())

                If (Not IsNull(dtRows)) Then

                    With dtRows(0)

                        eServer = New SmtpClient(.Item("Server").ToString(), .Item("Port"))

                        Username = .Item("Username").ToString()

                        Password = CryptoDecrypt(.Item("Password").ToString(), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                        If (Not IsNull(Username) AndAlso Not IsNull(Password)) Then

                            If (Username.Length > 0 AndAlso Password.Length > 0) Then eServer.Credentials = New NetworkCredential(Username, Password)

                        End If

                        eServer.EnableSsl = ConfigurationManager.AppSettings("EmailEnableSsl") = "1"

                        eMessage = New MailMessage()

                        If (state(2).ToString().Contains("<")) Then

                            SentFrom = GetXML(state(2), KeyName:="From")

                            SendTo(0) = GetXML(state(2), KeyName:="SendTo")
                            SendTo(1) = GetXML(state(2), KeyName:="CC")
                            SendTo(2) = GetXML(state(2), KeyName:="BCC")

                            If (SentFrom.Length > 0) Then

                                eMessage.From = New MailAddress(GetXML(SentFrom, "[", "Address", CloseKey:="]"), GetXML(SentFrom, "[", "Name", CloseKey:="]"))

                                If (Regex.IsMatch(SentFrom, "\[Username=.*?\]", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase) AndAlso Regex.IsMatch(SentFrom, "\[Password=.*?\]", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                                    Username = GetXML(SentFrom, "[", "Username", CloseKey:="]")

                                    Password = GetXML(SentFrom, "[", "Password", CloseKey:="]")

                                    If (Username.Length > 0 AndAlso Password.Length > 0) Then

                                        If (Not IsNull(eServer.Credentials)) Then eServer.Credentials = Nothing

                                        eServer.Credentials = New NetworkCredential(Username, Password)

                                    End If

                                End If

                            Else

                                eMessage.From = New MailAddress(.Item("Address").ToString(), .Item("Name").ToString())

                            End If

                        Else

                            eMessage.From = New MailAddress(.Item("Address").ToString(), .Item("Name").ToString())

                            SendTo(0) = state(2)

                        End If

                        SendToAddy = SendTo(0).Split(";")

                        For iLoop = 0 To (SendToAddy.GetLength(0) - 1)

                            eMessage.To.Add(SendToAddy(iLoop))

                        Next

                        If (SendTo(1).Length > 0) Then

                            SendToAddy = SendTo(1).Split(";")

                            For iLoop = 0 To (SendToAddy.GetLength(0) - 1)

                                eMessage.CC.Add(SendToAddy(iLoop))

                            Next

                        End If

                        If (SendTo(2).Length > 0) Then

                            SendToAddy = SendTo(2).Split(";")

                            For iLoop = 0 To (SendToAddy.GetLength(0) - 1)

                                eMessage.Bcc.Add(SendToAddy(iLoop))

                            Next

                        End If

                        eMessage.Subject = ReplaceParams(True, .Item("Subject").ToString(), state(5))

                        htmlBody = GetProcessedHtml(state(0), eMessage, ReplaceParams(True, .Item("Body").ToString(), state(5)), iAttachments, state(6))

                        plainText = AlternateView.CreateAlternateViewFromString(GetProcessedText(state(0), eMessage, ReplaceParams(True, .Item("BodyText").ToString(), state(5)), state(6)), Nothing, "text/plain")

                        htmlText = AlternateView.CreateAlternateViewFromString(htmlBody, Nothing, "text/html")

                        eMessage.AlternateViews.Add(htmlText)

                        eMessage.AlternateViews.Add(plainText)

                        If (Attachments.EndsWith(";")) Then Attachments = Attachments.Substring(0, Attachments.Length - 1)

                        If (state(3).Length > 0) Then

                            If (Attachments.Length > 0) Then Attachments &= ";"

                            Attachments &= state(3)

                        End If

                        If (Attachments.EndsWith(";")) Then Attachments = Attachments.Substring(0, Attachments.Length - 1)

                        Attachments = Regex.Replace(Attachments, "%root%", state(0), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                        AttachFiles = Attachments.Split(";")

                        iCount = (AttachFiles.GetLength(0) - 1)

                        If (iCount > -1) Then

                            ReDim iAttach(iCount)

                            For iLoop = 0 To iCount

                                AttachName = GetXML(AttachFiles(iLoop), KeyName:="Name")

                                AttachPath = GetXML(AttachFiles(iLoop), KeyName:="Path")

                                If (AttachPath.Length = 0) Then AttachPath = AttachFiles(iLoop)

                                If (File.Exists(AttachPath)) Then

                                    iAttach(iLoop) = New Attachment(AttachPath)

                                    If (Not IsNull(iAttach)) Then

                                        If (AttachName.Length > 0) Then iAttach(iLoop).Name = AttachName

                                        eMessage.Attachments.Add(iAttach(iLoop))

                                    End If

                                End If

                            Next

                        End If

                        If (IsNumeric(PathID)) Then

                            dtAttachments = GetSQLDT("select [ESSPath] from [PersonnelDocLink] where ([PathID] = " & PathID & ")")

                            If (IsData(dtAttachments)) Then

                                For i As Integer = 0 To (dtAttachments.Rows.Count - 1)

                                    AttachPath = Path.Combine(ServerPath, dtAttachments.Rows(i).Item("ESSPath").ToString().Replace("~/", String.Empty).Replace("/", "\"))

                                    AttachName = Path.GetFileName(AttachPath)

                                    iAttachment = New Attachment(AttachPath)

                                    iAttachment.Name = AttachName

                                    eMessage.Attachments.Add(iAttachment)

                                Next

                            End If

                        End If

                        eServer.Send(eMessage)

                        For iLoopSent As Integer = 0 To (SendToAddy.GetLength(0) - 1)

                            ExecSQL("insert into [EmailResults]([ID], [Date], [Server], [Port], [Username], [Password], [From], [To], [Subject], [Message], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & eServer.Host & "', " & eServer.Port.ToString() & ", " & GetNullText(Username) & ", " & GetNullText(Password) & ", '" & eMessage.From.Address & "', '" & SendToAddy(iLoopSent) & "', '" & GetDataText(eMessage.Subject) & "', '" & GetDataText(htmlBody) & "', 'Submitted')")

                        Next

                        If (Convert.ToBoolean(state(4)) AndAlso iCount > -1) Then

                            For iLoop = 0 To iCount

                                AttachName = GetXML(AttachFiles(iLoop), KeyName:="Name")

                                AttachPath = GetXML(AttachFiles(iLoop), KeyName:="Path")

                                If (AttachPath.Length = 0) Then AttachPath = AttachFiles(iLoop)

                                If (File.Exists(AttachPath)) Then

                                    If (Not IsNull(iAttach(iLoop))) Then

                                        iAttach(iLoop).Dispose()

                                        iAttach(iLoop) = Nothing

                                    End If

                                    File.Delete(AttachPath)

                                End If

                            Next

                        End If

                    End With

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            ExecSQL("insert into [EmailResults]([ID], [Date], [Server], [Port], [Username], [Password], [From], [To], [Subject], [Message], [Status], [ErrorText]) values('" & Guid.NewGuid().ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', '" & eServer.Host & "', " & eServer.Port.ToString() & ", " & GetNullText(Username) & ", " & GetNullText(Password) & ", '" & eMessage.From.Address & "', '" & eMessage.To(0).Address & "', '" & GetDataText(eMessage.Subject) & "', '" & GetDataText(htmlBody) & "', 'Undeliverable', '" & GetDataText(ex.ToString()) & "')")

        Finally

            If (Not IsNull(iAttach)) Then

                If (iCount > -1) Then

                    For iLoop = 0 To iCount

                        If (Not IsNull(iAttach(iLoop))) Then

                            iAttach(iLoop).Dispose()

                            iAttach(iLoop) = Nothing

                        End If

                    Next

                End If

            End If

            If (Not IsNull(iAttachments)) Then

                For iLoopAttach As Integer = 0 To (iAttachments.GetLength(0) - 1)

                    If (Not IsNull(iAttachments(iLoopAttach))) Then

                        iAttachments(iLoopAttach).Dispose()

                        iAttachments(iLoopAttach) = Nothing

                    End If

                Next

                iAttachments = Nothing

            End If

            If (Not IsNull(iAttachment)) Then

                iAttachment.Dispose()

                iAttachment = Nothing

            End If

            If (Not IsNull(dtAttachments)) Then

                dtAttachments.Dispose()

                dtAttachments = Nothing

            End If

            If (Not IsNull(plainText)) Then

                plainText.Dispose()

                plainText = Nothing

            End If

            If (Not IsNull(htmlText)) Then

                htmlText.Dispose()

                htmlText = Nothing

            End If

            If (Not IsNull(AttachFiles)) Then AttachFiles = Nothing

            If (Not IsNull(SendToAddy)) Then SendToAddy = Nothing

            If (Not IsNull(SendTo)) Then SendTo = Nothing

            If (Not IsNull(eMessage)) Then

                eMessage.Dispose()

                eMessage = Nothing

            End If

            If (Not IsNull(eServer)) Then eServer = Nothing

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dEmailLU)) Then

                dEmailLU.Dispose()

                dEmailLU = Nothing

            End If

        End Try

        Return Nothing

    End Function

#End Region

#Region " *** Encryption Functions (Public) *** "

    Public Function CryptoDecrypt(ByVal cipher As String, ByVal password As String, ByVal salt As String, ByVal iterations As Integer, ByVal vector As String, ByVal keysize As Integer) As String

        Dim result As String = String.Empty

        Dim vBytes() As Byte = Nothing

        Dim sBytes() As Byte = Nothing

        Dim cBytes() As Byte = Nothing

        Dim pBytes() As Byte = Nothing

        Dim symmetricKey As RijndaelManaged = Nothing

        Dim decryptor As ICryptoTransform = Nothing

        Dim memStream As MemoryStream = Nothing

        Dim crStream As CryptoStream = Nothing

        Dim plainBytes() As Byte = Nothing

        Try

            If (Not IsNull(cipher) AndAlso cipher.Length > 0) Then

                vBytes = Encoding.ASCII.GetBytes(vector)

                sBytes = Encoding.ASCII.GetBytes(salt)

                cBytes = Convert.FromBase64String(cipher)

                pBytes = (New Rfc2898DeriveBytes(password, sBytes, iterations)).GetBytes(Convert.ToInt32(keysize / 8))

                symmetricKey = New RijndaelManaged()

                symmetricKey.Mode = CipherMode.CBC

                decryptor = symmetricKey.CreateDecryptor(pBytes, vBytes)

                memStream = New MemoryStream(cBytes)

                crStream = New CryptoStream(memStream, decryptor, CryptoStreamMode.Read)

                ReDim plainBytes(cBytes.Length)

                result = Encoding.UTF8.GetString(plainBytes, 0, crStream.Read(plainBytes, 0, plainBytes.Length))

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(plainBytes)) Then plainBytes = Nothing

            If (Not IsNull(crStream)) Then

                crStream.Close()

                crStream.Dispose()

                crStream = Nothing

            End If

            If (Not IsNull(memStream)) Then

                memStream.Close()

                memStream.Dispose()

                memStream = Nothing

            End If

            If (Not IsNull(decryptor)) Then

                decryptor.Dispose()

                decryptor = Nothing

            End If

            If (Not IsNull(symmetricKey)) Then

                symmetricKey.Clear()

                symmetricKey = Nothing

            End If

            If (Not IsNull(pBytes)) Then pBytes = Nothing

            If (Not IsNull(cBytes)) Then cBytes = Nothing

            If (Not IsNull(sBytes)) Then sBytes = Nothing

            If (Not IsNull(vBytes)) Then vBytes = Nothing

        End Try

        Return result

    End Function

    Public Function CryptoEncrypt(ByVal plaintext As String, ByVal password As String, ByVal salt As String, ByVal iterations As Integer, ByVal vector As String, ByVal keysize As Integer) As String

        Dim result As String = String.Empty

        Dim vBytes() As Byte = Nothing

        Dim sBytes() As Byte = Nothing

        Dim tBytes() As Byte = Nothing

        Dim pBytes() As Byte = Nothing

        Dim symmetricKey As RijndaelManaged = Nothing

        Dim encryptor As ICryptoTransform = Nothing

        Dim memStream As MemoryStream = Nothing

        Dim crStream As CryptoStream = Nothing

        Try

            If (Not IsNull(plaintext) AndAlso plaintext.Length > 0) Then

                vBytes = Encoding.ASCII.GetBytes(vector)

                sBytes = Encoding.ASCII.GetBytes(salt)

                tBytes = Encoding.UTF8.GetBytes(plaintext)

                pBytes = (New Rfc2898DeriveBytes(password, sBytes, iterations)).GetBytes(Convert.ToInt32(keysize / 8))

                symmetricKey = New RijndaelManaged()

                symmetricKey.Mode = CipherMode.CBC

                encryptor = symmetricKey.CreateEncryptor(pBytes, vBytes)

                memStream = New MemoryStream()

                crStream = New CryptoStream(memStream, encryptor, CryptoStreamMode.Write)

                crStream.Write(tBytes, 0, tBytes.Length)

                crStream.FlushFinalBlock()

                result = Convert.ToBase64String(memStream.ToArray())

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(crStream)) Then

                crStream.Close()

                crStream.Dispose()

                crStream = Nothing

            End If

            If (Not IsNull(memStream)) Then

                memStream.Close()

                memStream.Dispose()

                memStream = Nothing

            End If

            If (Not IsNull(encryptor)) Then

                encryptor.Dispose()

                encryptor = Nothing

            End If

            If (Not IsNull(symmetricKey)) Then

                symmetricKey.Clear()

                symmetricKey = Nothing

            End If

            If (Not IsNull(pBytes)) Then pBytes = Nothing

            If (Not IsNull(tBytes)) Then tBytes = Nothing

            If (Not IsNull(sBytes)) Then sBytes = Nothing

            If (Not IsNull(vBytes)) Then vBytes = Nothing

        End Try

        Return result

    End Function

#End Region

#Region " *** File Functions (Public) *** "

    Public Function GetFileContentType(ByVal Extension As String) As String

        Dim ReturnText As String = "application/unknown"

        Dim regKey As RegistryKey = Nothing

        Try

            If (Not Regex.IsMatch(Extension, "^" & EscapeRegex("."))) Then Extension = "." & Extension

            regKey = Registry.ClassesRoot.OpenSubKey(Extension)

            ReturnText = regKey.GetValue("Content Type", ReturnText).ToString()

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(regKey)) Then

                regKey.Close()

                regKey = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetThumbnail(ByVal FileBytes() As Byte, ByVal MaxHeight As Integer, ByVal MaxWidth As Integer) As Byte()

        Dim Value() As Byte = Nothing

        Dim msImage() As MemoryStream = {Nothing, Nothing}

        Dim bmpImage() As Bitmap = {Nothing, Nothing}

        Dim gfx As Graphics = Nothing

        Dim imgHeight As Integer = 0

        Dim imgWidth As Integer = 0

        Dim imgRatio As Double = 0

        Try

            If (Not IsNull(FileBytes) AndAlso FileBytes.Length > 0) Then

                msImage(0) = New MemoryStream(FileBytes)

                bmpImage(0) = New Bitmap(msImage(0))

                imgHeight = bmpImage(0).Height

                imgWidth = bmpImage(0).Width

                If (imgWidth > imgHeight) Then

                    If (imgWidth > MaxWidth) Then

                        imgRatio = (MaxWidth / imgWidth)

                    Else

                        imgRatio = 1

                    End If

                ElseIf (imgHeight > imgWidth) Then

                    If (imgHeight > MaxHeight) Then

                        imgRatio = (MaxHeight / imgHeight)

                    Else

                        imgRatio = 1

                    End If

                Else

                    If (imgWidth > MaxWidth) Then

                        imgRatio = (MaxWidth / imgWidth)

                    ElseIf (imgHeight > MaxHeight) Then

                        imgRatio = (MaxHeight / imgHeight)

                    Else

                        imgRatio = 1

                    End If

                End If

                imgHeight = System.Convert.ToInt32(imgHeight * imgRatio)

                imgWidth = System.Convert.ToInt32(imgWidth * imgRatio)

                bmpImage(1) = New Bitmap(imgWidth, imgHeight)

                gfx = Graphics.FromImage(bmpImage(1))

                gfx.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic

                gfx.FillRectangle(Brushes.White, 0, 0, imgWidth, imgHeight)

                gfx.DrawImage(bmpImage(0), 0, 0, imgWidth, imgHeight)

                msImage(1) = New MemoryStream()

                bmpImage(1).Save(msImage(1), Imaging.ImageFormat.Jpeg)

                Value = msImage(1).GetBuffer()

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(gfx)) Then

                gfx.Dispose()

                gfx = Nothing

            End If

            If (Not IsNull(bmpImage) AndAlso bmpImage.Length > 0) Then

                For i As Integer = 0 To (bmpImage.Length - 1)

                    If (Not IsNull(bmpImage(i))) Then

                        bmpImage(i).Dispose()

                        bmpImage(i) = Nothing

                    End If

                Next

            End If

            If (Not IsNull(msImage) AndAlso msImage.Length > 0) Then

                For i As Integer = 0 To (msImage.Length - 1)

                    If (Not IsNull(msImage(i))) Then

                        msImage(i).Dispose()

                        msImage(i) = Nothing

                    End If

                Next

            End If

        End Try

        Return Value

    End Function

    Public Function ReadCSV(ByVal FileBytes() As Byte) As String()

        Dim Content As String = Encoding.ASCII.GetString(FileBytes)

        Dim CSVRows() As String = Regex.Split(Content, Chr(13) & Chr(10))

        If (CSVRows.GetLength(0) > 0) Then

            If (CSVRows(CSVRows.GetLength(0) - 1) = String.Empty) Then Array.Resize(CSVRows, CSVRows.GetLength(0) - 1)

        End If

        Return CSVRows

    End Function

    Public Function ReadCSV(ByVal path As String) As String()

        Dim fileSt As StreamReader = File.OpenText(path)

        Dim Content As String = fileSt.ReadToEnd()

        fileSt.Close()

        Dim CSVRows() As String = Regex.Split(Content, Chr(13) & Chr(10))

        If (CSVRows.GetLength(0) > 0) Then

            If (CSVRows(CSVRows.GetLength(0) - 1) = String.Empty) Then Array.Resize(CSVRows, CSVRows.GetLength(0) - 1)

        End If

        Return CSVRows

    End Function

    Public Function ReadCSVRow(ByVal Line As String) As String()

        Dim CSVColumns() As String = Regex.Split(Line, ",(?=(?:[^""]*""[^""]*"")*(?![^""]*""))")

        If (CSVColumns.GetLength(0) > 0) Then

            For iLoop As Integer = 0 To (CSVColumns.GetLength(0) - 1)

                CSVColumns(iLoop) = Regex.Replace(Regex.Replace(CSVColumns(iLoop), """$", String.Empty), "^""", String.Empty).Replace("""""", """")

            Next

        End If

        Return CSVColumns

    End Function

#End Region

#Region " *** General Procedures (Public) *** "

    Public Sub ParseGuid(ByRef result As Guid, ByVal s As String)

        result = Guid.Empty

        If (IsGuid(s)) Then result = New Guid(s)

    End Sub

#End Region

#Region " *** General Functions (Public) *** "

    Public Function AppendText(ByVal append As String, ByVal length As Integer) As String

        If (IsString(append) AndAlso length > 0) Then

            Return (New String(Convert.ToChar(append), length))

        Else

            Return String.Empty


        End If

    End Function

    Public Function CreatePin(ByVal Length As Integer) As String

        Dim ReturnText As String = CREATE_PIN

        Dim encoder As ASCIIEncoding = Nothing

        Dim allowedBytes() As Byte = Nothing

        Dim randomBytes() As Byte = Nothing

        Dim outputBytes() As Byte = Nothing

        Try

            encoder = New ASCIIEncoding()

            allowedBytes = encoder.GetBytes(PIN_ALLOWED_CHARS)

            ReDim randomBytes(Length)

            RNGCryptoServiceProvider.Create().GetBytes(randomBytes)

            Dim intChars As Integer = (allowedBytes.GetLength(0))

            ReDim outputBytes(Length - 1)

            For iLoop As Integer = 0 To (Length - 1)

                outputBytes(iLoop) = allowedBytes(randomBytes(iLoop) Mod intChars)

            Next

            Return encoder.GetString(outputBytes).ToString()

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(outputBytes)) Then outputBytes = Nothing

            If (Not IsNull(randomBytes)) Then randomBytes = Nothing

            If (Not IsNull(allowedBytes)) Then allowedBytes = Nothing

            If (Not IsNull(encoder)) Then encoder = Nothing

        End Try

        Return ReturnText

    End Function

    Public Function CheckPassword(ByVal Password As String, Optional ByVal MinLength As Byte = 6) As Boolean

        Dim ReturnBool As Boolean

        If (Not String.IsNullOrEmpty(Password)) Then

            If (Password.Length >= MinLength) Then

                Dim Score As Byte = 0

                If (Regex.IsMatch(Password, "[A-Z]")) Then Score += 1

                If (Regex.IsMatch(Password, "[a-z]")) Then Score += 1

                If (Regex.IsMatch(Password, "\d")) Then Score += 1

                If (Regex.IsMatch(Password, "[" & EscapeRegex("!@#$%^&*(){}[]|\~`<>") & "]")) Then Score += 1

                If (Score > 2) Then ReturnBool = True

            End If

        End If

        Return ReturnBool

    End Function

    Public Function CreateClientID(Optional ByVal Length As Integer = 9) As String

        Dim ReturnText As String = CREATE_CLIENTID

        Dim encoder As ASCIIEncoding = Nothing

        Dim allowedBytes() As Byte = Nothing

        Dim randomBytes() As Byte = Nothing

        Dim outputBytes() As Byte = Nothing

        Try

            encoder = New ASCIIEncoding()

            allowedBytes = encoder.GetBytes(CLIENTID_ALLOWED_CHARS)

            ReDim randomBytes(Length)

            RNGCryptoServiceProvider.Create().GetBytes(randomBytes)

            Dim intChars As Integer = (allowedBytes.GetLength(0))

            ReDim outputBytes(Length - 1)

            For iLoop As Integer = 0 To (Length - 1)

                outputBytes(iLoop) = allowedBytes(randomBytes(iLoop) Mod intChars)

            Next

            Return encoder.GetString(outputBytes).ToString()

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(outputBytes)) Then outputBytes = Nothing

            If (Not IsNull(randomBytes)) Then randomBytes = Nothing

            If (Not IsNull(allowedBytes)) Then allowedBytes = Nothing

            If (Not IsNull(encoder)) Then encoder = Nothing

        End Try

        Return ReturnText

    End Function

    Public Function CreatePwd(ByVal Length As Integer) As String

        Dim ReturnText As String = CREATE_PWD

        Dim encoder As ASCIIEncoding = Nothing

        Dim allowedBytes() As Byte = Nothing

        Dim randomBytes() As Byte = Nothing

        Dim outputBytes() As Byte = Nothing

        Try

            encoder = New ASCIIEncoding()

            allowedBytes = encoder.GetBytes(PWD_ALLOWED_CHARS)

            ReDim randomBytes(Length)

            RNGCryptoServiceProvider.Create().GetBytes(randomBytes)

            Dim intChars As Integer = (allowedBytes.GetLength(0))

            ReDim outputBytes(Length - 1)

            For iLoop As Integer = 0 To (Length - 1)

                outputBytes(iLoop) = allowedBytes(randomBytes(iLoop) Mod intChars)

            Next

            Return encoder.GetString(outputBytes).ToString()

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(outputBytes)) Then outputBytes = Nothing

            If (Not IsNull(randomBytes)) Then randomBytes = Nothing

            If (Not IsNull(allowedBytes)) Then allowedBytes = Nothing

            If (Not IsNull(encoder)) Then encoder = Nothing

        End Try

        Return ReturnText

    End Function

    Public Function EscapeRegex(ByVal text As String) As String

        Return (Regex.Escape(text))

    End Function

    Public Function GetXML(ByVal XML As String, Optional ByVal OpenKey As String = "<", Optional ByVal KeyName As String = "", Optional ByVal SplitKey As String = "=", Optional ByVal CloseKey As String = ">") As String

        Dim result As String = String.Empty

        Dim Keys() As String = {OpenKey, SplitKey, CloseKey}

        Dim Value() As String = Nothing

        OpenKey = EscapeRegex(OpenKey)

        KeyName = EscapeRegex(KeyName)

        SplitKey = EscapeRegex(SplitKey)

        CloseKey = EscapeRegex(CloseKey)

        If (IsString(XML) AndAlso IsString(KeyName)) Then

            If (Regex.IsMatch(XML, OpenKey & KeyName & SplitKey & ".*?" & CloseKey, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                result = Regex.Match(XML, OpenKey & KeyName & SplitKey & ".*?" & CloseKey, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase).Value

                result = Regex.Replace(result, OpenKey & KeyName & SplitKey, String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                result = result.Substring(0, result.Length - Keys(2).Length)

            End If

        ElseIf (IsString(XML)) Then

            If (Regex.IsMatch(XML, OpenKey & ".*?" & SplitKey & ".*?" & CloseKey, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then

                result = Regex.Match(XML, OpenKey & ".*?" & SplitKey & ".*?" & CloseKey, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase).Value

                result = result.Substring(Keys(1).Length, result.Length - Keys(1).Length)

                Value = Regex.Split(result, SplitKey, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                If (Value.GetLength(0) > 0) Then result = Value(0)

            End If

        End If

        Return result

    End Function

    Public Function InsertText(ByVal text As String, ByVal insert As String, ByVal length As Integer) As String

        Dim result As String = text

        If (IsString(text) AndAlso IsString(insert) AndAlso length > 0 AndAlso (length - text.Length) > 0) Then result = result.Insert(0, New String(Convert.ToChar(insert), (length - text.Length)))

        Return (New String(Convert.ToChar(insert), length - text.Length) & text)

    End Function

    Public Function IsDate(ByVal value As Object) As Boolean

        If (Microsoft.VisualBasic.IsDate(value)) Then

            Return (Not DateTime.Parse(value.ToString()).ToString("dd/MM/yyyy") = "01/01/0001")

        Else

            Return False

        End If

    End Function

    Public Function IsGuid(ByVal value As Object) As Boolean

        Dim result As Boolean

        If (Not IsNull(value)) Then

            If (TypeOf value Is Guid) Then

                If (Not value.Equals(Guid.Empty)) Then result = True

            Else

                result = IsGuid(value.ToString())

            End If

        End If

        Return result

    End Function

    Public Function IsGuid(ByVal value As Guid) As Boolean

        Return (Not IsNull(value) And Not value = Guid.Empty)

    End Function

    Public Function IsGuid(ByVal value As String) As Boolean

        If (IsString(value)) Then

            Return (Regex.IsMatch(value, "^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})$", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase))

        Else

            Return False

        End If

    End Function

    Public Function IsNull(ByVal value As Object) As Boolean

        Return (value Is Nothing OrElse IsDBNull(value))

    End Function

    Public Function IsString(ByVal value As Object) As Boolean

        If (Not IsNull(value)) Then

            Return (Not String.IsNullOrEmpty(value.ToString()))

        Else

            Return False

        End If

    End Function

    Public Function ReplaceJavaText(ByVal Text As String) As String

        Dim ReturnText As String = String.Empty

        If (Not IsNull(Text)) Then

            ReturnText = Text

            ReturnText = ReturnText.Replace("'", "\'")

            ReturnText = ReturnText.Replace(Chr(13) & Chr(10), "\n")

        End If

        Return ReturnText

    End Function

    Public Function ReplaceParams(ByVal ReplaceDate As Boolean, ByVal Text As String, ByVal ParamArray Param() As Object) As String

        Dim ReturnText As String = Text

        Dim mCollection As MatchCollection = Nothing

        Try

            If (Not IsNull(Param)) Then

                If (Param.GetLength(0) > 0) Then

                    If (TypeOf Param(0) Is Array AndAlso Param.GetLength(0) = 1) Then

                        For iLoop As Integer = 0 To (Param(0).GetLength(0) - 1)

                            If (Not IsNull(Param(0)(iLoop))) Then

                                'ReturnText = Regex.Replace(ReturnText, """\<%PARAM\[" & iLoop.ToString() & "\]%\>""", "<%PARAM[" & iLoop.ToString() & "]%>", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                If (ReplaceDate AndAlso IsDate(Param(0)(iLoop))) Then

                                    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Convert.ToDateTime(Param(0)(iLoop)).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat")), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", Convert.ToDateTime(Param(0)(iLoop)).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat")), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                Else

                                    'If (IsNumeric(Param(0)(iLoop))) Then

                                    '    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Convert.ToDouble(Param(0)(iLoop)).ToString(NumericFormat), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    'Else

                                    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Param(0)(iLoop).ToString(), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    If (TypeOf (Param(0)(iLoop)) Is String) Then

                                        ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", """" & Param(0)(iLoop).ToString() & """", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    Else

                                        ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", Param(0)(iLoop).ToString(), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    End If

                                End If

                            End If

                        Next

                    Else

                        For iLoop As Integer = 0 To (Param.GetLength(0) - 1)

                            If (Not IsNull(Param(iLoop))) Then

                                'ReturnText = Regex.Replace(ReturnText, """\<%PARAM\[" & iLoop.ToString() & "\]%\>""", "<%PARAM[" & iLoop.ToString() & "]%>", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                If (ReplaceDate AndAlso IsDate(Param(iLoop))) Then

                                    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Convert.ToDateTime(Param(iLoop)).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat")), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", Convert.ToDateTime(Param(iLoop)).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat")), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    'If (IsNumeric(Param(iLoop))) Then

                                    '    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Convert.ToDouble(Param(iLoop)).ToString(NumericFormat), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                Else

                                    ReturnText = Regex.Replace(ReturnText, "\<%PARAM\[" & iLoop.ToString() & "\]%\>", Param(iLoop).ToString(), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    If (TypeOf (Param(0)(iLoop)) Is String) Then

                                        ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", """" & Param(iLoop).ToString() & """", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    Else

                                        ReturnText = Regex.Replace(ReturnText, "\{PARAM\[" & iLoop.ToString() & "\]\}", Param(iLoop).ToString(), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                                    End If

                                End If

                                'End If

                            End If

                        Next

                    End If

                End If

            End If

            mCollection = Regex.Matches(ReturnText, "GetXML\(.*?\)", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

            If (Not IsNull(mCollection)) Then

                Dim KeyID As String = String.Empty

                For Each mItem As Match In mCollection

                    KeyID = Regex.Replace(Regex.Replace(mItem.Value, "^GetXML\(", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase), "\)$", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    If (IsString(KeyID)) Then

                        Dim Params() As String = KeyID.Split("?")

                        ReturnText = Regex.Replace(ReturnText, "GetXML\(" & EscapeRegex(KeyID) & "\)", GetXML(Params(0), KeyName:=Params(1)), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    End If

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(mCollection)) Then mCollection = Nothing

        End Try

        Return ReturnText

    End Function

    Public Function ReplaceValue(ByRef Session As HttpSessionState) As String

        Dim ReturnText As String = String.Empty

        ReturnText &= "replace([Value], '<%Selected.Value%>', '" & Session("Selected.Value").ToString() & "')"

        ReturnText = "replace(" & ReturnText & ", '<%GetDate()%>', convert(nvarchar(19), getdate(), 120))"

        Return ReturnText

    End Function

    Public Function ReplaceValue(ByRef Session As HttpSessionState, ByVal Text As String, Optional ByVal ReplaceDate As Boolean = False) As String

        Dim ReturnText As String = Text

        Dim mCollection As MatchCollection = Nothing

        Try

            mCollection = Regex.Matches(ReturnText, "<%.*?%>", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

            If (Not IsNull(mCollection)) Then

                Dim KeyID As String = String.Empty

                For Each mItem As Match In mCollection

                    KeyID = Regex.Replace(Regex.Replace(mItem.Value, "<%", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase), "%>", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    If (Not IsNull(Session(KeyID))) Then

                        If (ReplaceDate AndAlso IsDate(Session(KeyID))) Then

                            ReturnText = Regex.Replace(ReturnText, EscapeRegex(mItem.Value), Convert.ToDateTime(Session(KeyID).ToString()).ToString(GetArrayItem(Nothing, "eGeneral.DateFormat")), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                        Else

                            ReturnText = Regex.Replace(ReturnText, EscapeRegex(mItem.Value), Session(KeyID).ToString(), RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                        End If

                    ElseIf (KeyID = "GetDate()") Then

                        ReturnText = Regex.Replace(ReturnText, EscapeRegex(mItem.Value), "convert(nvarchar(19), getdate(), 120))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                    End If

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(mCollection)) Then mCollection = Nothing

        End Try

        Return ReturnText

    End Function

    Public Function SplitText(ByVal text As String, Optional ByVal length As Integer = 160, Optional ByVal break As Boolean = True) As String

        Dim result As String = text

        If (IsString(text)) Then

            If (break) Then

                If (Regex.IsMatch(text, ".{1," & length.ToString() & "}( |$)", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)) Then result = Regex.Match(text, ".{1," & length.ToString() & "}( |$)", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase).Value

            Else

                If (text.Length < length) Then length = text.Length

                result = text.Substring(0, length)

            End If

        End If

        Return result

    End Function

#End Region

#Region " *** Logic Procedures (Private) *** "

    Private Sub ExecuteNotifyEmail(ByVal state As Object)

        Dim EmailID() As Object = {Nothing, Nothing, Nothing}
        Dim EmailSendTo() As String = {String.Empty, String.Empty, String.Empty}
        Dim EmailCC() As String = {String.Empty, String.Empty, String.Empty}
        Dim EmailBCC() As String = {String.Empty, String.Empty, String.Empty}

        Dim EmailPathData() As Object = Nothing

        Dim dtWFRec As DataTable = Nothing

        Try

            EmailPathData = GetPathLU(state)

            If (Not IsNull(EmailPathData)) Then

                dtWFRec = GetSQLDT("select [EmailID], [EmailCC], [EmailBCC], [EmailOrigID], [EmailOrigCC], [EmailOrigBCC], [EmailActID], [EmailActCC], [EmailActBCC] from [ess.WF] where (cast([StatusID] as nvarchar) + ',' + cast([WFLUID] as nvarchar) + ',' + cast([PAID] as nvarchar) + ',' + cast([PostActID] as nvarchar) = '" & EmailPathData(EmailPathData.GetLength(0) - 1) & "')")

                If (IsData(dtWFRec)) Then

                    With dtWFRec.Rows(0)

                        If (Not IsNull(.Item("EmailID"))) Then

                            EmailID(0) = .Item("EmailID")

                            EmailSendTo(0) = GetSQLField("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [ActionerCompanyNum] + ':' + [ActionerEmployeeNum] from [ess.Path] where ([ID] = " & state & ")))", "EMailAddress")

                            If (Not IsNull(.Item("EmailCC"))) Then EmailCC(0) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                            If (Not IsNull(.Item("EmailBCC"))) Then EmailBCC(0) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailBCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                        End If

                        If (Not IsNull(.Item("EmailOrigID"))) Then

                            EmailID(1) = .Item("EmailOrigID")

                            EmailSendTo(1) = GetSQLField("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")))", "EMailAddress")

                            If (Not IsNull(.Item("EmailOrigCC"))) Then EmailCC(1) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailOrigCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                            If (Not IsNull(.Item("EmailOrigBCC"))) Then EmailBCC(1) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailOrigBCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                        End If

                        If (Not IsNull(.Item("EmailActID"))) Then

                            EmailID(2) = .Item("EmailActID")

                            EmailSendTo(2) = GetSQLField("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [ActionedByCompNum] + ':' + [ActionedByEmpNum] from [ess.Path] where ([ID] = " & state & ")))", "EMailAddress")

                            If (Not IsNull(.Item("EmailActCC"))) Then EmailCC(2) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailActCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                            If (Not IsNull(.Item("EmailActBCC"))) Then EmailBCC(2) = GetSQLRowValues("select [EMailAddress] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("EmailActBCC")) & "))))))", "EMailAddress", String.Empty, String.Empty, ";")

                        End If

                    End With

                    For iLoop As Integer = 0 To 2

                        If (Not IsNull(EmailID(iLoop))) Then

                            If (IsNull(EmailSendTo(iLoop))) Then EmailSendTo(iLoop) = String.Empty

                            If (EmailSendTo(iLoop).Length > 0) Then SendEmailThread(New Object() {ServerPath, EmailID(iLoop), "<SendTo=" & EmailSendTo(iLoop) & "><CC=" & EmailCC(iLoop) & "><BCC=" & EmailBCC(iLoop) & ">", String.Empty, False, EmailPathData, state})

                        End If

                    Next

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(EmailPathData)) Then EmailPathData = Nothing

            If (Not IsNull(dtWFRec)) Then

                dtWFRec.Dispose()

                dtWFRec = Nothing

            End If

        End Try

    End Sub

    Private Sub ExecuteNotifySMS(ByVal state As Object)

        Dim SMSBody() As String = {String.Empty, String.Empty, String.Empty}
        Dim SMSSendTo() As String = {String.Empty, String.Empty, String.Empty}
        Dim SMSCC() As String = {String.Empty, String.Empty, String.Empty}

        Dim SMSPathData() As Object = Nothing

        Dim dtWFRec As DataTable = Nothing

        Try

            SMSPathData = GetPathLU(state)

            If (Not IsNull(SMSPathData)) Then

                dtWFRec = GetSQLDT("select [SMSID], [SMSCC], [SMSOrigID], [SMSOrigCC], [SMSActID], [SMSActCC] from [ess.WF] where (cast([StatusID] as nvarchar) + ',' + cast([WFLUID] as nvarchar) + ',' + cast([PAID] as nvarchar) + ',' + cast([PostActID] as nvarchar) = '" & SMSPathData(SMSPathData.GetLength(0) - 1) & "')")

                If (IsData(dtWFRec)) Then

                    With dtWFRec.Rows(0)

                        If (Not IsNull(.Item("SMSID"))) Then

                            SMSBody(0) = GetSQLField("select [Body] from [MessagingLU] where ([ID] = " & .Item("SMSID") & ")", "Body")

                            SMSSendTo(0) = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [ActionerCompanyNum] + ':' + [ActionerEmployeeNum] from [ess.Path] where ([ID] = " & state & ")))", "CellTel")

                            If (Not IsNull(.Item("SMSCC"))) Then SMSCC(0) = GetSQLRowValues("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("SMSCC")) & "))))))", "CellTel", String.Empty, String.Empty, ";")

                        End If

                        If (Not IsNull(.Item("SMSOrigID"))) Then

                            SMSBody(1) = GetSQLField("select [Body] from [MessagingLU] where ([ID] = " & .Item("SMSOrigID") & ")", "Body")

                            SMSSendTo(1) = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")))", "CellTel")

                            If (Not IsNull(.Item("SMSOrigCC"))) Then SMSCC(1) = GetSQLRowValues("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("SMSOrigCC")) & "))))))", "CellTel", String.Empty, String.Empty, ";")

                        End If

                        If (Not IsNull(.Item("SMSActID"))) Then

                            SMSBody(2) = GetSQLField("select [Body] from [MessagingLU] where ([ID] = " & .Item("SMSActID") & ")", "Body")

                            SMSSendTo(2) = GetSQLField("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = (select [ActionedByCompNum] + ':' + [ActionedByEmpNum] from [ess.Path] where ([ID] = " & state & ")))", "CellTel")

                            If (Not IsNull(.Item("SMSActCC"))) Then SMSCC(2) = GetSQLRowValues("select [CellTel] from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] in(select [ReportToCompNum] + ':' + [ReportToEmpnum] from [ReportsTo] where ([CompanyNum] + ':' + [EmployeeNum] in (select [OriginatorCompanyNum] + ':' + [OriginatorEmployeeNum] from [ess.Path] where ([ID] = " & state & ")) and [ReportsToType] in(select [ReportsToType] from [ess.ActionLU] where ([ID] in(" & GetDecodedID(.Item("SMSActCC")) & "))))))", "CellTel", String.Empty, String.Empty, ";")

                        End If

                    End With

                    For iLoop As Integer = 0 To 2

                        If (IsNull(SMSBody(iLoop))) Then SMSBody(iLoop) = String.Empty

                        If (IsNull(SMSSendTo(iLoop))) Then SMSSendTo(iLoop) = String.Empty

                        If (IsNull(SMSCC(iLoop))) Then SMSCC(iLoop) = String.Empty

                        If (SMSBody(iLoop).Length > 0) Then

                            SMSBody(iLoop) = ReplaceParams(True, SMSBody(iLoop), SMSPathData)

                            If (SMSSendTo(iLoop).Length > 0) Then

                                SendSMSThread(New Object() {SMSSendTo(iLoop), SMSBody(iLoop)})

                                If (SMSCC(iLoop).Length > 0) Then

                                    Dim mSMSCC() As String = SMSCC(iLoop).Split(";")

                                    For iLoopSub As Integer = 0 To (mSMSCC.GetLength(0) - 1)

                                        SendSMSThread(New Object() {mSMSCC(iLoopSub), SMSBody(iLoop)})

                                    Next

                                End If

                            End If

                        End If

                    Next

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(SMSPathData)) Then SMSPathData = Nothing

            If (Not IsNull(dtWFRec)) Then

                dtWFRec.Dispose()

                dtWFRec = Nothing

            End If

        End Try

    End Sub

    Private Sub ProcessRoutingRules(ByVal PathID As String)

        Dim Company As String = String.Empty

        Dim Employee As String = String.Empty

        Dim Username As String = String.Empty

        Dim Email As String = String.Empty

        Dim PreferredName As String = String.Empty

        Dim FirstName As String = String.Empty

        Dim Surname As String = String.Empty

        Dim FullName As String = String.Empty

        Dim dtRouteWF As DataTable = Nothing

        Try

            dtRouteWF = GetSQLDT("select top 1 [r].[ID], [RouteToCompNum], [RouteToEmpNum], [Username], [p].[EMailAddress], [p].[PreferredName], [p].[FirstName], [p].[Surname], (select [XMLTag] from [ess.Path] where ([ID] = " & PathID & ")) as [XMLTag] from ([ess.RoutingRules] as [r] left outer join [Users] as [u] on [r].[RouteToCompNum] = [u].[CompanyNum] and [r].[RouteToEmpNum] = [u].[EmployeeNum]) left outer join [Personnel] as [p] on [u].[CompanyNum] = [p].[CompanyNum] and [u].[EmployeeNum] = [p].[EmployeeNum] where (([OnceOff] = 0) and ([r].[CompanyNum] + ':' + [r].[EmployeeNum] = (select [ActionerCompanyNum] + ':' + [ActionerEmployeeNum] from [ess.Path] where ([ID] = " & PathID & "))) and ([WFLUID] = (select [WFLUID] from [ess.Path] where ([ID] = " & PathID & "))) and (not [WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] in('Performance', 'Registration')))) and (('" & Now.AddDays(-1).ToString("yyyy-MM-dd") & " 23:59:59' < [Until]) and ('" & Now.AddDays(1).ToString("yyyy-MM-dd") & " 00:00:00' > [From]))) order by [u].[DefaultUser] desc")

            If (Not IsData(dtRouteWF)) Then dtRouteWF = GetSQLDT("select top 1 [r].[ID], [RouteToCompNum], [RouteToEmpNum], [Username], [p].[EMailAddress], [p].[PreferredName], [p].[FirstName], [p].[Surname], (select [XMLTag] from [ess.Path] where ([ID] = " & PathID & ")) as [XMLTag] from ([ess.RoutingRules] as [r] left outer join [Users] as [u] on [r].[RouteToCompNum] = [u].[CompanyNum] and [r].[RouteToEmpNum] = [u].[EmployeeNum]) left outer join [Personnel] as [p] on [u].[CompanyNum] = [p].[CompanyNum] and [u].[EmployeeNum] = [p].[EmployeeNum] where (([OnceOff] = 0) and ([r].[CompanyNum] + ':' + [r].[EmployeeNum] = (select [ActionerCompanyNum] + ':' + [ActionerEmployeeNum] from [ess.Path] where ([ID] = " & PathID & "))) and (([WFLUID] is null) or (not [WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] in('Performance', 'Registration'))))) and (('" & Now.AddDays(-1).ToString("yyyy-MM-dd") & " 23:59:59' < [Until]) and ('" & Now.AddDays(1).ToString("yyyy-MM-dd") & " 00:00:00' > [From]))) order by [u].[DefaultUser] desc")

            If (Not IsData(dtRouteWF)) Then dtRouteWF = GetSQLDT("select top 1 [r].[ID], [RouteToCompNum], [RouteToEmpNum], [Username], [p].[EMailAddress], [p].[PreferredName], [p].[FirstName], [p].[Surname], (select [XMLTag] from [ess.Path] where ([ID] = " & PathID & ")) as [XMLTag] from ([ess.RoutingRules] as [r] left outer join [Users] as [u] on [r].[RouteToCompNum] = [u].[CompanyNum] and [r].[RouteToEmpNum] = [u].[EmployeeNum]) left outer join [Personnel] as [p] on [u].[CompanyNum] = [p].[CompanyNum] and [u].[EmployeeNum] = [p].[EmployeeNum] where (([OnceOff] = 0) and ([From] is null) and ([Until] is null) and ([r].[CompanyNum] + ':' + [r].[EmployeeNum] = (select [ActionerCompanyNum] + ':' + [ActionerEmployeeNum] from [ess.Path] where ([ID] = " & PathID & "))) and ([WFLUID] = (select [WFLUID] from [ess.Path] where ([ID] = " & PathID & "))) and (not [WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] in('Performance', 'Registration'))))) order by [u].[DefaultUser] desc")

            If (IsData(dtRouteWF)) Then

                With dtRouteWF.Rows(0)

                    Company = .Item("RouteToCompNum").ToString()

                    Employee = .Item("RouteToEmpNum").ToString()

                    Username = .Item("Username").ToString()

                    Email = .Item("EMailAddress").ToString()

                    PreferredName = .Item("PreferredName").ToString()

                    FirstName = .Item("FirstName").ToString()

                    Surname = .Item("Surname").ToString()

                End With

                FullName = ""

                If (PreferredName.Length = 0) Then

                    FullName &= FirstName & " "

                Else

                    FullName &= PreferredName & " "

                End If

                FullName &= Surname

                Dim bSaved As Boolean

                Dim XMLTag As String = String.Empty

                Dim iLoop As Integer

                Dim iCount As Integer = (dtRouteWF.Rows.Count - 1)

                For iLoop = 0 To iCount

                    XMLTag = dtRouteWF.Rows(iLoop).Item("XMLTag").ToString()

                    SetXML(XMLTag, "Routed", "True")

                    SetXML(XMLTag, "RouteID", dtRouteWF.Rows(iLoop).Item("ID").ToString())

                    bSaved = ExecSQL("insert into [ess.WFAudit]([PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], [UserEmail], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [EmailOrigCC], [EmailOrigBCC], [EmailActCC], [EmailActBCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername], [UserCell], [OriginatorCell], [SMSCC], [SMSOrigCC], [SMSActCC]) select top 1 [PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], '" & Email & "', [WFID], '" & FullName & "', '" & Company & "', '" & Employee & "', '" & Username & "', [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [EmailOrigCC], [EmailOrigBCC], [EmailActCC], [EmailActBCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername], [UserCell], [OriginatorCell], [SMSCC], [SMSOrigCC], [SMSActCC] from [ess.WFAudit] where ([PathID] = " & PathID & ") order by [ID] desc")

                    If (bSaved) Then bSaved = ExecSQL("update [ess.Path] set [UserEmail] = '" & Email & "', [Actioner] = '" & FullName & "', [ActionerCompanyNum] = '" & Company & "', [ActionerEmployeeNum] = '" & Employee & "', [ActionerUsername] = '" & Username & "', [XMLTag] = '" & XMLTag & "' where ([ID] = " & PathID & ")")

                    If (Not bSaved) Then Exit For

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRouteWF)) Then

                dtRouteWF.Dispose()

                dtRouteWF = Nothing

            End If

        End Try

    End Sub

#End Region

#Region " *** Logic Procedures (Public) *** "

    Public Sub ExecNotify(ByVal PathID As String)

        If (String.IsNullOrEmpty(PathID)) Then Exit Sub

        Dim wThread As Thread = Nothing

        Try

            wThread = New Thread(AddressOf ExecNotifyThread)

            wThread.Start(New Object() {PathID})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

    Public Sub Initialize(Optional ByVal ClearCache As Boolean = False)

        Dim dPolicy As DataTable = Nothing

        Dim ItemKey As String = String.Empty

        Try

            If (IsNull(m_Policy)) Then m_Policy = New Hashtable()

            If (ClearCache) Then ClearFromCache("Data.Policy")

            dPolicy = GetSQLDT("select [p].[ID], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], null as [Value] from (([ess.Policy] as [p] left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID]", "Data.Policy")

            If (IsData(dPolicy)) Then

                For iLoop As Integer = 0 To (dPolicy.Rows.Count - 1)

                    With dPolicy.Rows(iLoop)

                        ItemKey = .Item("Category").ToString() & "." & .Item("Key").ToString()

                        If (Not m_Policy.ContainsKey(ItemKey & ".Validation")) Then

                            m_Policy.Add(ItemKey & ".Validation", .Item("Validation"))

                        Else

                            m_Policy(ItemKey & ".Validation") = .Item("Validation")

                        End If

                        If (Not m_Policy.ContainsKey(ItemKey)) Then

                            If (.Item("Category").ToString() = "ePersonal") Or (.Item("Category").ToString() = "eOrganizational") Then

                                m_Policy.Add(ItemKey, .Item("Visible"))

                                m_Policy.Add(ItemKey & ".Editable", .Item("Editable"))
                                m_Policy.Add(ItemKey & ".Required", .Item("Required"))

                            Else

                                Select Case .Item("DataType")

                                    Case 0
                                        m_Policy.Add(ItemKey, .Item("YesNo"))

                                    Case 1
                                        m_Policy.Add(ItemKey, .Item("Int"))

                                    Case 2
                                        m_Policy.Add(ItemKey, .Item("Dec"))

                                    Case 3
                                        m_Policy.Add(ItemKey, .Item("Text").ToString())

                                    Case 4
                                        m_Policy.Add(ItemKey, .Item("Date"))

                                    Case 5
                                        m_Policy.Add(ItemKey, .Item("GUID"))

                                    Case 6
                                        m_Policy.Add(ItemKey, .Item("Object"))

                                End Select

                            End If

                        Else

                            If (.Item("Category").ToString() = "ePersonal") Or (.Item("Category").ToString() = "eOrganizational") Then

                                m_Policy(ItemKey) = .Item("Visible")

                                m_Policy(ItemKey & ".Editable") = .Item("Editable")
                                m_Policy(ItemKey & ".Required") = .Item("Required")

                            Else

                                Select Case .Item("DataType")

                                    Case 0
                                        m_Policy(ItemKey) = .Item("YesNo")

                                    Case 1
                                        m_Policy(ItemKey) = .Item("Int")

                                    Case 2
                                        m_Policy(ItemKey) = .Item("Dec")

                                    Case 3
                                        m_Policy(ItemKey) = .Item("Text").ToString()

                                    Case 4
                                        m_Policy(ItemKey) = .Item("Date")

                                    Case 5
                                        m_Policy(ItemKey) = .Item("GUID")

                                    Case 6
                                        m_Policy(ItemKey) = .Item("Object")

                                End Select

                            End If

                        End If

                    End With

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dPolicy)) Then

                dPolicy.Dispose()

                dPolicy = Nothing

            End If

        End Try

    End Sub

    Public Sub InitializeItems(Optional ByVal ClearCache As Boolean = False)

        Dim dPolicyItems As DataTable = Nothing

        Dim ItemKey As String = String.Empty

        Try

            If (IsNull(m_PolicyItems)) Then m_PolicyItems = New Hashtable()

            If (ClearCache) Then ClearFromCache("Data.PolicyItems")

            dPolicyItems = GetSQLDT("select [pi].[ID], [pi].[Template], [a].[Assembly], [a].[TypeName] as [AssemblyTypeName], [d].[DataType], [d].[TypeName] as [DataTypeName], [g].[Name] as [Category], [Key], isnull([Label], [Key]) as [Label], [p].[Description], [pi].[Visible], [pi].[Editable], [pi].[Required], [pi].[YesNo], [pi].[Int], [pi].[IntMin], [pi].[IntMax], [pi].[Dec], [pi].[DecMin], [pi].[DecMax], [pi].[Date], [pi].[DateMin], [pi].[DateMax], [pi].[Text], [pi].[GUID], [pi].[Object], [pi].[LookupTable], [pi].[LookupText], [pi].[LookupValue], [pi].[LookupFilter], [pi].[Validation], null as [Value] from ((([ess.PolicyItems] as [pi] left outer join [ess.Policy] as [p] on [pi].[PolicyID] = [p].[ID]) left outer join [DataTypeLU] as [d] on [p].[SetupDataTypeID] = [d].[ID]) left outer join [AssemblyLU] as [a] on [p].[SetupAssemblyID] = [a].[ID]) left outer join [ess.PolicyGroups] as [g] on [p].[GroupID] = [g].[ID] ORDER BY [Template], [Category], [Key]", "Data.PolicyItems")

            If (IsData(dPolicyItems)) Then

                For iLoop As Integer = 0 To (dPolicyItems.Rows.Count - 1)

                    With dPolicyItems.Rows(iLoop)

                        ItemKey = .Item("Template").ToString() & "." & .Item("Category").ToString() & "." & .Item("Key").ToString()

                        If (Not m_PolicyItems.ContainsKey(ItemKey & ".Validation")) Then

                            m_PolicyItems.Add(ItemKey & ".Validation", .Item("Validation"))

                        Else

                            m_PolicyItems(ItemKey & ".Validation") = .Item("Validation")

                        End If

                        If (Not m_PolicyItems.ContainsKey(ItemKey)) Then

                            If (.Item("Category").ToString() = "ePersonal") Or (.Item("Category").ToString() = "eOrganizational") Or (.Item("Category").ToString() = "eCurriculumVitae") Then

                                m_PolicyItems.Add(ItemKey, .Item("Visible"))

                                m_PolicyItems.Add(ItemKey & ".Editable", .Item("Editable"))
                                m_PolicyItems.Add(ItemKey & ".Required", .Item("Required"))

                            Else

                                Select Case .Item("DataType")

                                    Case 0
                                        m_PolicyItems.Add(ItemKey, .Item("YesNo"))

                                    Case 1
                                        m_PolicyItems.Add(ItemKey, .Item("Int"))

                                    Case 2
                                        m_PolicyItems.Add(ItemKey, .Item("Dec"))

                                    Case 3
                                        m_PolicyItems.Add(ItemKey, .Item("Text").ToString())

                                    Case 4
                                        m_PolicyItems.Add(ItemKey, .Item("Date"))

                                    Case 5
                                        m_PolicyItems.Add(ItemKey, .Item("GUID"))

                                    Case 6
                                        m_PolicyItems.Add(ItemKey, .Item("Object"))

                                End Select

                            End If

                        Else

                            If (.Item("Category").ToString() = "ePersonal") Or (.Item("Category").ToString() = "eOrganizational") Then

                                m_PolicyItems(ItemKey) = .Item("Visible")

                                m_PolicyItems(ItemKey & ".Editable") = .Item("Editable")
                                m_PolicyItems(ItemKey & ".Required") = .Item("Required")

                            Else

                                Select Case .Item("DataType")

                                    Case 0
                                        m_PolicyItems(ItemKey) = .Item("YesNo")

                                    Case 1
                                        m_PolicyItems(ItemKey) = .Item("Int")

                                    Case 2
                                        m_PolicyItems(ItemKey) = .Item("Dec")

                                    Case 3
                                        m_PolicyItems(ItemKey) = .Item("Text").ToString()

                                    Case 4
                                        m_PolicyItems(ItemKey) = .Item("Date")

                                    Case 5
                                        m_PolicyItems(ItemKey) = .Item("GUID")

                                    Case 6
                                        m_PolicyItems(ItemKey) = .Item("Object")

                                End Select

                            End If

                        End If

                    End With

                Next

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dPolicyItems)) Then

                dPolicyItems.Dispose()

                dPolicyItems = Nothing

            End If

        End Try

    End Sub

    Public Sub SendBulkSMS(ByVal SessionID As String, ByRef arSendTo() As String, ByRef arText() As String)

        Dim wThread As Thread = Nothing

        Try

            Cache.Insert(SessionID & ".Progress", 0, Nothing, DateTime.Now.AddHours(1), TimeSpan.Zero)

            wThread = New Thread(AddressOf SendBulkSMSThread)

            wThread.Start(New Object() {arSendTo, arText, SessionID})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

    Public Sub SendSMS(ByVal mobile As String, ByVal text As String)

        Dim wThread As Thread = Nothing

        Try

            wThread = New Thread(AddressOf SendSMSThread)

            wThread.Start(New Object() {mobile, text})

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

        End Try

    End Sub

    Public Sub SetEmployeeData(ByRef Session As HttpSessionState, ByVal Value As String, Optional ByVal Managed As Boolean = True)

        Dim UserGroup As String = String.Empty

        Dim dtAccessTo As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim UsersData As Users = Nothing

        Dim CompanyNum As String = String.Empty

        Dim EmployeeNum As String = String.Empty

        Try

            If (Not IsNull(Session("LoggedOn"))) Then

                With Session("LoggedOn")

                    UserGroup = GetUserGroup(.UserID, Session.SessionID)

                    If (Not IsNull(UserGroup)) Then

                        dtAccessTo = GetUserGroupAcc(UserGroup, Session.SessionID)

                        If (IsData(dtAccessTo)) Then

                            If (dtAccessTo.Select("[Value] = '" & Value & "'").GetLength(0) = 0) Then

                                dtAccessTo.Dispose()

                                dtAccessTo = GetSQLDT("select [e].[CompanyNum] + ' ' + [e].[EmployeeNum] as [Value], null as [UserID], null as [AuditTemplate], [e].[Surname], [e].[PreferredName], [e].[FirstName], [e].[EMailAddress], null as [TemplateCode], [e].[DeptName], [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], [e].[CellTel], [e].[Leave_Scheme], [e1].[ShiftType] from ([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum] where ([e].[CompanyNum] + ' ' + [e].[EmployeeNum] = '" & Value & "')")

                            End If

                            dtRows = dtAccessTo.Select("[Value] = '" & Value & "'")

                            If (Not IsNull(dtRows)) Then

                                If (dtRows.GetLength(0) > 0) Then

                                    With dtRows(0)

                                        CompanyNum = Value.Split(" ")(0)

                                        EmployeeNum = Value.Split(" ")(1)

                                        If (Not Managed) Then

                                            UsersData = Session("LoggedOn")

                                        Else

                                            UsersData = Session("Managed")

                                        End If

                                        UsersData.UserID = .Item("UserID").ToString()

                                        UsersData.CompanyNum = CompanyNum

                                        UsersData.EmployeeNum = EmployeeNum

                                        UsersData.AuditTemplate = .Item("AuditTemplate").ToString()

                                        UsersData.Surname = .Item("Surname").ToString()

                                        UsersData.Name = .Item("PreferredName").ToString()

                                        If (Not IsString(UsersData.Name)) Then UsersData.Name = .Item("FirstName").ToString()

                                        UsersData.Email = .Item("EMailAddress").ToString()

                                        UsersData.Template = .Item("TemplateCode").ToString()

                                        UsersData.Department = .Item("DeptName").ToString()

                                        UsersData.CompanyName = .Item("CompanyName").ToString()

                                        UsersData.Division = .Item("Division").ToString()

                                        UsersData.SubDivision = .Item("SubDivision").ToString()

                                        UsersData.SubSubDivision = .Item("SubSubDivision").ToString()

                                        UsersData.Mobile = .Item("CellTel").ToString()

                                        UsersData.LeaveScheme = .Item("Leave_Scheme").ToString()

                                        UsersData.ShiftType = .Item("ShiftType").ToString()

                                        UsersData.IndividualJobTitle = .Item("IndividualJobTitle").ToString()

                                        If (Not Managed) Then

                                            Session("LoggedOn") = UsersData

                                        Else

                                            Session("Managed") = UsersData

                                        End If

                                    End With

                                End If

                            End If

                        End If

                    End If

                End With

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(UsersData)) Then UsersData = Nothing

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtAccessTo)) Then

                dtAccessTo.Dispose()

                dtAccessTo = Nothing

            End If

        End Try

    End Sub

    Public Sub SetXML(ByRef XML As String, ByVal KeyName As String, ByVal Value As String)

        Dim XMLValue As String = "<" & KeyName & "=" & Value & ">"

        If (Not IsString(XML)) Then XML = String.Empty

        If ((GetXML(XML, KeyName:=KeyName).Length > 0) Or (XML.IndexOf("<" & KeyName & "=" & ">") > -1)) Then

            XML = XML.Replace("<" & KeyName & "=" & GetXML(XML, KeyName:=KeyName) & ">", XMLValue)

        Else

            XML &= XMLValue

        End If

    End Sub

    'Public Sub ProcessReceivedSMS(ByVal DeliveredOn As Date, ByVal MobileNum As String, ByVal Message As String)

    '    Try

    '        Dim wThread As New Thread(AddressOf ProcessReceivedSMSThread)

    '        wThread.Start(New Object() {DeliveredOn, MobileNum, Message})

    '    Catch ex As Exception

    '    End Try

    'End Sub

    'Private Function CalcDuration(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal deStart As Date, ByVal deUntil As Date, ByVal LeaveType As String) As Single

    '    CalcDuration = 0

    '    Dim AddCalcShifts As Boolean
    '    Dim UseCalendar As Boolean
    '    Dim UseHours As Boolean
    '    'Dim Shifts As String
    '    'Dim ShiftTypes As String

    '    Select Case "day(s)"

    '        Case "hour(s)"

    '            CalcDuration = CalculateLeave(CompanyNum, EmployeeNum, UseCalendar, UseHours, 1, deStart:=deStart, deUntil:=deUntil)

    '            'If (Not UseCalendar) Then MsgBoxASP("No calendar type has been set up for this employee thus resulting in public holidays not taken into account. The duration might therefor be incorrect.")

    '            'If (Not UseHours) Then MsgBoxASP("No working hours have been set up for this employee thus calculating on the standard number of working hours per day.")

    '        Case "day(s)"

    '            Dim ShiftType As String = GetSQLField("select [ShiftType] from [Personnel1] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')", "ShiftType")

    '            Dim Use7DayWeek As Boolean = GetSQLField("select [Use7DayWeek] from [LeaveLU] where ([LeaveType] = '" & GetDataText(LeaveType) & "')", "Use7DayWeek")

    '            CalcDuration = CalculateLeave(CompanyNum, EmployeeNum, UseCalendar, UseHours, , Use7DayWeek, deStart:=deStart, deUntil:=deUntil)

    '            If (Not Use7DayWeek) Then

    '                'Shifts = GetArrayItem(.Template, "eLeave.ShiftTypes")

    '                'ShiftTypes = GetArrayItem(.Template, "eLeave.ShiftLeaveTypes")

    '                'If (Not IsNull(Shifts) AndAlso Not IsNull(ShiftTypes)) Then

    '                '    Shifts = "'" & GetDataText(Shifts.Replace(", ", ",")).Replace(",", "', '") & "'"

    '                '    ShiftTypes = "'" & GetDataText(ShiftTypes.Replace(", ", ",")).Replace(",", "', '") & "'"

    '                '    If (Shifts.ToLower().Contains("'" & ShiftType.ToString().ToLower() & "'") AndAlso ShiftTypes.ToLower().Contains("'" & LeaveType.ToLower() & "'")) Then AddCalcShifts = True

    '                'End If

    '            End If

    '            If (AddCalcShifts) Then CalcDuration = CalcDuration * 1.5

    '            'If (Not UseCalendar) Then MsgBoxASP("No calendar type has been set up for this employee thus resulting in public holidays not taken into account. The duration might therefor be incorrect.")

    '        Case "week(s)"

    '            CalcDuration = Convert.ToSingle(DateDiff(DateInterval.Weekday, deStart, deUntil))

    '        Case "month(s)"

    '            CalcDuration = Math.Round(DateDiff(DateInterval.Day, deStart, deUntil) / 30.4375, 4).ToString()

    '    End Select

    '    Return CalcDuration

    'End Function

    'Private Function CalculateLeave(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByRef UseCalendar As Boolean, ByRef UseHours As Boolean, Optional ByVal bType As Byte = 0, Optional ByVal Use7DayWeek As Boolean = False, Optional ByVal deStart As Date = Nothing, Optional ByVal deUntil As Date = Nothing) As Single

    '    Dim Duration As Single = DateDiff(DateInterval.Day, deStart, deUntil) + 1

    '    Dim dtLoop As Date = deStart

    '    Dim dtPubHolidays As DataTable = Nothing

    '    Dim dtHours As DataTable = Nothing

    '    Dim dtDaysPerWeek As DataTable = Nothing

    '    Dim dtRows() As DataRow = Nothing

    '    Dim PublicDays As Integer = 0

    '    Try

    '        dtPubHolidays = GetSQLDT("select [c].[CalendarType], [PubHolDate] from [PersonnelPubHolCal] as [p] left outer join [PublicHoliday] as [c] on [p].[CalendarType] = [c].[CalendarType] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

    '        If (IsData(dtPubHolidays)) Then

    '            UseCalendar = Convert.ToBoolean(dtPubHolidays.Rows.Count > 0)

    '        Else

    '            UseCalendar = False

    '        End If

    '        dtHours = GetSQLDT("select count([ValidFrom]) as [Total] from [WorkingHours] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [ValidFrom] <= '" & deStart.ToString("yyyy-MM-dd") & "')")

    '        If (IsData(dtHours)) Then

    '            UseHours = Convert.ToBoolean(dtHours.Rows(0).Item("Total") > 0)

    '            dtHours.Dispose()

    '        Else

    '            UseHours = False

    '        End If

    '        dtHours = Nothing

    '        If (UseHours) Then

    '            Duration = 0

    '            Dim CalcPublic As Boolean

    '            While (dtLoop <= deUntil)

    '                dtHours = GetSQLDT("select top 1 [" & dtLoop.ToString("ddd") & "Hrs] as [TotalHrs] from [WorkingHours] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [ValidFrom] <= '" & dtLoop.ToString("yyyy-MM-dd") & "') order by [ValidFrom] desc")

    '                CalcPublic = False

    '                If (UseCalendar OrElse bType = 1) Then

    '                    dtRows = dtPubHolidays.Select("[PubHolDate] = '" & dtLoop.ToString("yyyy-MM-dd HH:mm:ss") & "'")

    '                    If (Not IsNull(dtRows)) Then

    '                        If (dtRows.GetLength(0) = 1) Then CalcPublic = True

    '                    End If

    '                End If

    '                If (IsData(dtHours)) Then

    '                    With dtHours.Rows(0)

    '                        If (Not IsNull(.Item("TotalHrs"))) Then

    '                            If (bType = 0) Then

    '                                If (.Item("TotalHrs") > 0) Then

    '                                    If (CalcPublic) Then PublicDays += 1

    '                                    Duration += 1

    '                                End If

    '                            ElseIf (bType = 1) Then

    '                                If (.Item("TotalHrs") > 0) Then

    '                                    If (CalcPublic) Then PublicDays += .Item("TotalHrs")

    '                                    Duration += .Item("TotalHrs")

    '                                End If

    '                            End If

    '                        End If

    '                    End With

    '                End If

    '                dtLoop = dtLoop.AddDays(1)

    '            End While

    '            Duration = Duration - PublicDays

    '        Else

    '            dtRows = dtPubHolidays.Select("[PubHolDate] >= '" & Convert.ToDateTime(deStart).ToString("yyyy-MM-dd HH:mm:ss") & "' and [PubHolDate] <= '" & Convert.ToDateTime(deUntil).ToString("yyyy-MM-dd HH:mm:ss") & "'")

    '            If (Not IsNull(dtRows)) Then

    '                If (dtRows.GetLength(0) > 0) Then

    '                    Dim dtPubDay As Date

    '                    For iLoop As Integer = 0 To (dtRows.GetLength(0) - 1)

    '                        dtPubDay = Convert.ToDateTime(dtRows(iLoop).Item("PubHolDate"))

    '                        If (Not dtPubDay.DayOfWeek = DayOfWeek.Saturday AndAlso Not dtPubDay.DayOfWeek = DayOfWeek.Sunday) Then PublicDays += 1

    '                    Next

    '                End If

    '            End If

    '            Dim Saturdays As Integer
    '            Dim Sundays As Integer

    '            While (dtLoop <= deUntil)

    '                If (dtLoop.DayOfWeek = DayOfWeek.Saturday) Then Saturdays += 1

    '                If (dtLoop.DayOfWeek = DayOfWeek.Sunday) Then Sundays += 1

    '                dtLoop = dtLoop.AddDays(1)

    '            End While

    '            Duration = Duration - PublicDays - Saturdays - Sundays

    '            If (Use7DayWeek) Then

    '                Duration += (Saturdays + Sundays + PublicDays)

    '            Else

    '                dtDaysPerWeek = GetSQLDT("select [DaysPerWeek] from [Personnel1] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

    '                If (IsData(dtDaysPerWeek)) Then

    '                    If (Not IsNull(dtDaysPerWeek.Rows(0).Item("DaysPerWeek"))) Then

    '                        If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 5.5) Then

    '                            Duration += Saturdays - (Saturdays * 0.5)

    '                            'ElseIf (GetArrayItem(.Template, "eLeave.SaturdayRule")) Then

    '                            '    Duration += Saturdays - (Saturdays * 0.5)

    '                            '    If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 7) Then Duration += Sundays

    '                        Else

    '                            If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 6) Then Duration += Saturdays

    '                            If (dtDaysPerWeek.Rows(0).Item("DaysPerWeek") = 7) Then Duration += Saturdays + Sundays

    '                        End If

    '                        'ElseIf (GetArrayItem(.Template, "eLeave.SaturdayRule")) Then

    '                        '    Duration += Saturdays - (Saturdays * 0.5)

    '                    End If

    '                End If

    '            End If

    '        End If

    '        'Dim sTRights As String = GetXMLTag(hdnbox_security.Value, "TemplateCode")
    '        'Dim sHalfDay As String = GetXMLTag(hdnbox_security.Value, "AMPM")

    '        'If (sHalfDay.Length = 0) Then sHalfDay = "False"

    '        'bHalfDay = Convert.ToBoolean(sHalfDay)

    '        'If (Not lblTStart.Visible) Then

    '        '    If ((bHalfDay) And (Duration = 1)) Then

    '        '        lblAMPM.Visible = True
    '        '        drpAMPM.Visible = True

    '        '    Else

    '        '        lblAMPM.Visible = False
    '        '        drpAMPM.Visible = False

    '        '    End If

    '        'End If

    '    Catch ex As Exception

    '    Finally

    '        If (Not IsNull(dtRows)) Then dtRows = Nothing

    '        If (Not IsNull(dtDaysPerWeek)) Then

    '            dtDaysPerWeek.Dispose()

    '            dtDaysPerWeek = Nothing

    '        End If

    '        If (Not IsNull(dtHours)) Then

    '            dtHours.Dispose()

    '            dtHours = Nothing

    '        End If

    '        If (Not IsNull(dtPubHolidays)) Then

    '            dtPubHolidays.Dispose()

    '            dtPubHolidays = Nothing

    '        End If

    '    End Try

    '    Return Duration

    'End Function

    'Public Sub ProcessReceivedSMSThread(ByVal state As Object)

    '    Dim Keywords() As String = Nothing

    '    Dim dtEmployee As DataTable = Nothing

    '    Dim Type As String = String.Empty

    '    Dim Start As String = String.Empty

    '    Dim Until As String = String.Empty

    '    Dim dteDate() As Date = {Nothing, Nothing}

    '    Try

    '        Keywords = state(2).ToString().Split(" ")

    '        If (Keywords.GetLength(0) >= 3) Then

    '            Type = " "

    '            For i As Integer = 0 To (Keywords.GetLength(0) - 3)

    '                Type &= Keywords(i) & " "

    '            Next

    '            Type = Regex.Replace(Type, EscapeRegEx(" leave "), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

    '            Type = Regex.Replace(Type, "(^" & EscapeRegEx(" ") & ")*", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

    '            Type = Regex.Replace(Type, "(" & EscapeRegEx(" ") & "$)*", String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

    '            Start = Keywords(Keywords.GetLength(0) - 2)

    '            DateTime.TryParse(Start, dteDate(0))

    '            If (Not IsDate(dteDate(0))) Then

    '                dteDate(0) = New Date(Today.Year, Today.Month, Today.Day)

    '            Else

    '                dteDate(0) = Convert.ToDateTime(Start)

    '            End If

    '            Until = Keywords(Keywords.GetLength(0) - 1)

    '            DateTime.TryParse(Until, dteDate(1))

    '            If (Not IsDate(dteDate(1))) Then

    '                dteDate(1) = New Date(Today.Year, Today.Month, Today.Day)

    '            Else

    '                dteDate(1) = Convert.ToDateTime(Until)

    '            End If

    '            Start = dteDate(0).ToString("yyyy-MM-dd HH:mm:ss")

    '            Until = dteDate(1).ToString("yyyy-MM-dd HH:mm:ss")

    '            dtEmployee = GetSQLDT("select [CompanyNum], [EmployeeNum], (select top 1 [Username] from [Users] where ([CompanyNum] = [Personnel].[CompanyNum] and [EmployeeNum] = [Personnel].[EmployeeNum]) order by [DefaultUser] desc) as [Username] from [Personnel] where ([CellTel] = '" & state(1).ToString() & "')")

    '            If (IsData(dtEmployee)) Then

    '                With dtEmployee.Rows(0)

    '                    Dim SQL As String = "insert into [Leave]([CompanyNum], [EmployeeNum], [StartDate], [EndDate], [CaptureDate], [Duration], [UnitOfMeassure], [LeaveType], [MedicalCert], [LeaveStatus], [EmailSent], [CapturedByUsername], [Remarks]) values('" & .Item("CompanyNum").ToString() & "', '" & .Item("EmployeeNum").ToString() & "', '" & Start & "', '" & Until & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & CalcDuration(.Item("CompanyNum").ToString(), .Item("EmployeeNum").ToString(), dteDate(0), dteDate(1), Type).ToString() & ", 'D', '" & Type & "', 0, 'New', 0, '" & .Item("Username").ToString() & "', null)"

    '                    If (ExecSQL(SQL)) Then

    '                        SQL = "exec [ess.WFProc] '" & .Item("CompanyNum").ToString() & "', '" & .Item("EmployeeNum").ToString() & "', '" & .Item("CompanyNum").ToString() & "', '" & .Item("EmployeeNum").ToString() & "', 0, 'Leave', '" & Type & "', 'Start', 'Start', '" & Start & "'"

    '                        If (ExecSQL(SQL)) Then

    '                            'ExecSQL("update [Leave] set [TemplateCode] = '" & .Template & "' where ([CompanyNum] = '" & .Item("CompanyNum").ToString() & "' and [EmployeeNum] = '" & .Item("EmployeeNum").ToString() & "' and [StartDate] = '" & Start & "')")

    '                        End If

    '                    End If

    '                End With

    '            End If

    '        End If

    '    Catch ex As Exception

    '    Finally

    '        If (Not IsNull(Keywords)) Then Keywords = Nothing

    '        If (Not IsNull(dtEmployee)) Then

    '            dtEmployee.Dispose()

    '            dtEmployee = Nothing

    '        End If

    '    End Try

    'End Sub

#End Region

#Region " *** Logic Functions (Private) *** "

    Private Function GetArrayItem(ByVal Key As String) As Object

        Dim ReturnObject As Object = Nothing

        Try

            If (IsNull(m_Policy)) Then Initialize()

            If (Not IsNull(m_Policy) AndAlso m_Policy.Contains(Key)) Then ReturnObject = m_Policy(Key)

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return ReturnObject

    End Function

    Public Function GetDateFormat() As String

        Dim iLength As Integer = GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SSHORTDATE, String.Empty, 0)

        Dim lpLCData As String = New String(Chr(0), iLength - 1)

        GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SSHORTDATE, lpLCData, iLength)

        Return lpLCData

    End Function

    Private Function GetDecodedID(ByVal CharID As String) As String

        Dim DecodedID As String = String.Empty

        If (Not IsNull(CharID)) Then

            If (CharID.Length > 0) Then

                Dim iLoopU As Integer = (CharID.Length - 1)

                For iLoop As Integer = 0 To iLoopU

                    DecodedID &= Asc(CharID.Substring(iLoop, 1)).ToString()

                    If (iLoop < iLoopU) Then DecodedID &= ", "

                Next

            End If

        End If

        Return DecodedID

    End Function
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="PathID"></param>
    ''' <returns></returns>
    Public Function GetPathLU(ByVal PathID As String) As Object()

        Dim WFType() As Object = GetSQLFields("select [WFType], [Tablename] from [ess.WFTypeLU] where ([WFType] = (select [WFType] from [ess.WFLU] where ([ID] = (select [WFLUID] from [ess.Path] where ([ID] = " & PathID & ")))))")

        If (Not IsNull(WFType)) Then

            Dim SQLColumns As String = GetSQLRowValues("select distinct [Index], [Value] from [ParameterLU] where ([Tablename] = '" & WFType(1).ToString() & "' and [Type] = '" & WFType(0).ToString() & "') order by [Index], [Value]", "Value", "[", "]", ", ", PathID)

            If (IsString(WFType(1)) AndAlso SQLColumns.Length > 0) Then

                SQLColumns &= ", cast([p].[StatusID] as nvarchar) + ',' + cast([p].[WFLUID] as nvarchar) + ',' + cast([p].[PAID] as nvarchar) + ',' + cast([p].[WFID] as nvarchar) as [wfRec]"

                SQLColumns = SQLColumns.Replace("[ActType]", "(select [PostActionType] from [ess.PALU] where ([ID] = [p].[PAID])) as [ActType]")

                SQLColumns = Regex.Replace(SQLColumns, ",\s\[\(", ", (", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                Return GetSQLFields("select " & SQLColumns & " from [" & WFType(1).ToString() & "] as [tbl] left outer join [ess.Path] as [p] on [tbl].[PathID] = [p].[ID] where ([tbl].[PathID] = " & PathID & ")")

            Else

                Return Nothing

            End If

        Else

            Return Nothing

        End If

    End Function

    Private Function GetSecurityType(ByVal TemplateElement As String) As Boolean

        Dim ReturnBool As Boolean

        Dim dtMenu As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Try

            dtMenu = GetSQLDT("select [ID], [OrderID], [ItemImage], [Description], [LoadURL], [TemplateElement], [LoggedOnUser], [HomeType], [HomeImage], [HomeDescription], [HomeTooltip] from [ess.Menu] where ([Visible] = 1) order by [OrderID]", "Data.Menu")

            If (IsData(dtMenu)) Then

                dtRows = dtMenu.Select("[TemplateElement] = '" & GetDataText(TemplateElement) & "'")

                If (Not IsNull(dtRows) AndAlso dtRows.Length > 0) Then

                    With dtRows(0)

                        ReturnBool = .Item("LoggedOnUser")

                    End With

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtMenu)) Then

                dtMenu.Dispose()

                dtMenu = Nothing

            End If

        End Try

        Return ReturnBool

    End Function

    Private Function GetWorkflowName(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal Department As String, ByVal WFType As String, ByVal AppType As String) As String

        Dim ReturnText As String = String.Empty

        Try

            If (Not IsNull(Department)) Then

                If (Department.Length > 0) Then

                    Dim WFLUID As Int16 = GetSQLField("select [WFLUID] from [ess.WFLinkedDepts] where ([WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] = '" & WFType & "')) and [DeptName] = '" & Department & "')", "WFLUID")

                    If (Not WFLUID = 0) Then

                        ReturnText = GetSQLField("select [ID], [WFType], [WFName] from [ess.WFLU] order by [ID]", "WFName", "Data.WFLU", "[ID] = " & WFLUID.ToString())

                    Else

                        ReturnText = GetSQLField("select [ID], [WFType], [AppType], [WFName] from [ess.WFAppType] order by [WFType]", "WFName", "Data.WFAppType", "[WFType] = '" & WFType & "' and [AppType] = '" & AppType & "'")

                    End If

                Else

                    ReturnText = GetSQLField("select [WFName] from [ess.WFAppType] where ([WFType] = '" & WFType & "' and [AppType] = '" & AppType & "')", "WFName")

                End If

            Else

                ReturnText = GetSQLField("select [WFName] from [ess.WFAppType] where ([WFType] = '" & WFType & "' and [AppType] = '" & AppType & "')", "WFName")

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return ReturnText

    End Function

#End Region

#Region " *** Logic Functions (Public) *** "

    Public Function DeleteReportThread(ByVal state As Object) As Object

        Dim xrDelete As Timer = Nothing

        Try

            xrDelete = New Timer(New TimerCallback(AddressOf DeleteReportThreadTimer), New Object() {state(0)}, 300000, 0)

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return Nothing

    End Function

    Public Function ExecNotifyThread(ByVal state As Object) As Object

        Dim PathID As String = String.Empty

        Dim dtSendMail As DataTable = Nothing

        Try

            If (IsNumeric(state(0))) Then

                PathID = state(0)

            Else

                state(0) = Regex.Replace(Regex.Replace(state(0), EscapeRegex("'") & "$", String.Empty), "^" & EscapeRegex("'"), String.Empty)

                dtSendMail = GetSQLDT("select [CompanyNum], [EmployeeNum], [Username], [PathID] from [ess.PerfSubmitted] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Username] = '" & GetDataText(state(0)) & "')")

                If (IsData(dtSendMail)) Then

                    For iLoop As Integer = 0 To (dtSendMail.Rows.Count - 1)

                        With dtSendMail.Rows(iLoop)

                            If (IsNumeric(.Item("PathID"))) Then PathID &= .Item("PathID").ToString() & ","

                        End With

                    Next

                    If (PathID.EndsWith(",")) Then PathID = PathID.Substring(0, PathID.Length - 1)

                    ExecSQL("delete from [ess.PerfSubmitted] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Username] = '" & GetDataText(state(0)) & "')")

                End If

            End If

            For Each SendPathID As String In PathID.Split(",")

                ExecuteNotifySMS(SendPathID)

                ExecuteNotifyEmail(SendPathID)

            Next

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtSendMail)) Then

                dtSendMail.Dispose()

                dtSendMail = Nothing

            End If

        End Try

        Return Nothing

    End Function

    Public Function GetArrayItem(ByVal Template As String, ByVal Key As String) As Object

        Dim ReturnObject As Object = Nothing

        Try

            If (String.IsNullOrEmpty(Template)) Then

                ReturnObject = GetArrayItem(Key)

            Else

                If (IsNull(m_PolicyItems)) Then InitializeItems()

                If (Not IsNull(m_PolicyItems) AndAlso m_PolicyItems.Contains(Template & "." & Key)) Then ReturnObject = m_PolicyItems(Template & "." & Key)

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        End Try

        Return ReturnObject

    End Function

    Public Function GetBalanceMaxNeg(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal Department As String, ByVal LeaveType As String, ByRef BalPending As Single, ByVal PathID As String) As Single

        Dim ReturnValue As Single = 0

        Dim WFName As String = String.Empty

        Dim dtMaxNegative As DataTable = Nothing

        Try

            WFName = GetWorkflowName(CompanyNum, EmployeeNum, Department, "Leave", LeaveType)

            dtMaxNegative = GetSQLDT("select [StopBalExc], [MaxNegative] from [ess.WFAppType] where ([AppType] = '" & LeaveType & "' and [WFType] = 'Leave'" & IIf(WFName.Length > 0, " and [WFName] = '" & WFName & "'", String.Empty) & ")")

            If (IsData(dtMaxNegative)) Then

                With dtMaxNegative.Rows(0)

                    If (Not IsNull(.Item("StopBalExc"))) Then

                        If (.Item("StopBalExc")) Then BalPending = GetSQLField("select sum([Duration]) as [Total] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and (not [PathID] = " & PathID & " or [PathID] is null) and [LeaveType] = '" & LeaveType & "' and [LeaveStatus] in('New', 'HOD Accepted'))", "Total")

                    End If

                    If (Not IsNull(.Item("MaxNegative"))) Then ReturnValue = .Item("MaxNegative")

                End With

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtMaxNegative)) Then

                dtMaxNegative.Dispose()

                dtMaxNegative = Nothing

            End If

        End Try

        Return ReturnValue

    End Function

    Public Function GetDisplayText(ByVal Text As String) As String

        Dim ReturnText As String = "'" & Text & "'"

        ReturnText = Regex.Replace(ReturnText, EscapeRegex("<%CompanyNum%>"), "' + [e].[CompanyNum] + '", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)
        ReturnText = Regex.Replace(ReturnText, EscapeRegex("<%EmployeeNum%>"), "' + [e].[EmployeeNum] + '", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)
        ReturnText = Regex.Replace(ReturnText, EscapeRegex("<%Surname%>"), "' + [e].[Surname] + '", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)
        ReturnText = Regex.Replace(ReturnText, EscapeRegex("<%PreferredName%>"), "' + [e].[PreferredName] + '", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)
        ReturnText = Regex.Replace(ReturnText, EscapeRegex("<%FirstName%>"), "' + [e].[FirstName] + '", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        Return ReturnText

    End Function

    Public Function GetEmailID(ByVal Type As String) As Byte

        Dim ReturnByte As Byte = 0

        ReturnByte = GetSQLField("select [ID] from [EmailLU] where ([Type] = '" & GetDataText(Type) & "')", "ID")

        Return ReturnByte

    End Function

    Public Function GetPathData(ByVal PathID As String) As String

        Dim ReturnText As String = String.Empty

        Dim dtPathData As DataTable = Nothing

        Try

            dtPathData = GetSQLDT("select [ActionerCompanyNum], [ActionerEmployeeNum], [OriginatorCompanyNum], [OriginatorEmployeeNum], [IsLastNode] = case when (select '[' + cast([ActionID] as nvarchar(10)) + ' ' + cast([StatusID] as nvarchar(10)) + ']' from [ess.WF] where ([id] = [w].[PostActID])) = '[0:0]' then 1 else 0 end, (select [ReportsToType] from [ess.ActionLU] where [id] = [w].[ActionID]) as [ActionType], [w].[ActionID] as [ActionID], (select [Status] from [ess.StatusLU] where [id] = [w].[StatusID]) as [StatusType], [w].[StatusID] as [StatusID], [p].[XMLTag] as [XMLTag], [Summary] from [ess.Path] as [p] left outer join [ess.WF] as [w] on ([p].[WFID] = [w].[id]) where ([p].[id] = " & PathID & ")")

            If (IsData(dtPathData)) Then

                With dtPathData.Rows(0)

                    ReturnText = "<ActionerCompanyNum=" & .Item("ActionerCompanyNum").ToString() & "><ActionerEmployeeNum=" & .Item("ActionerEmployeeNum").ToString() & "><OriginatorCompanyNum=" & .Item("OriginatorCompanyNum").ToString() & "><OriginatorEmployeeNum=" & .Item("OriginatorEmployeeNum").ToString() & "><IsLastNode=" & .Item("IsLastNode").ToString() & "><ActionType=" & .Item("ActionType").ToString() & "><StatusType=" & .Item("StatusType").ToString() & "><ActionID=" & .Item("ActionID").ToString() & "><StatusID=" & .Item("StatusID").ToString() & "><Summary=" & .Item("Summary").ToString() & ">"

                    If (Not IsNull(.Item("XMLTag"))) Then ReturnText &= .Item("XMLTag").ToString()

                End With

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtPathData)) Then

                dtPathData.Dispose()

                dtPathData = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetRemarks(ByVal Template As String, ByVal PathID As Integer, ByVal Text As String, Optional ByVal CacheKey As String = "") As String

        Dim ReturnText As String = Text

        Dim dtRemarks As DataTable = Nothing

        Try

            dtRemarks = GetSQLDT("select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [e].[CompanyNum] + ' ' + [e].[EmployeeNum] as [Value], [e].[Surname], [e].[PreferredName], [e].[FirstName], [JobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [CaptureDate], [Remarks] from [ess.WFRemarks] as [r] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [r].[CompanyNum] = [e].[CompanyNum] and [r].[EmployeeNum] = [e].[EmployeeNum] where ([r].[PathID] = " & PathID.ToString() & ") order by [r].[CaptureDate], [r].[CompanyNum], [r].[EmployeeNum]", CacheKey)

            If (IsData(dtRemarks)) Then

                ReturnText = String.Empty

                For iLoop As Integer = 0 To (dtRemarks.Rows.Count - 1)

                    With dtRemarks.Rows(iLoop)

                        ReturnText &= "[" & Convert.ToDateTime(.Item("CaptureDate")).ToString(GetArrayItem(Template, "eGeneral.DateFormat")) & " - " & .Item("Text").ToString() & "]:" & vbCrLf & .Item("Remarks").ToString() & vbCrLf & vbCrLf

                    End With

                Next

                If (Not ReturnText = Text) Then ReturnText &= Text

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRemarks)) Then

                dtRemarks.Dispose()

                dtRemarks = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetSecurity(ByRef Session As HttpSessionState, ByVal DataElement As String) As String

        Dim ReturnText As String = String.Empty

        Dim dtPermissions As DataTable = Nothing

        Dim dtRows() As DataRow = Nothing

        Dim Code As String = String.Empty

        Dim UseLoggedOn As Boolean

        Try

            UseLoggedOn = GetSecurityType(DataElement)

            If (Not IsNull(Session("LoggedOn")) AndAlso Not IsNull(Session("Managed"))) Then

                If (UseLoggedOn) Then

                    Code = Session("LoggedOn").Template

                Else

                    Code = Session("Managed").Template

                    If (Code.Length = 0) Then Code = Session("LoggedOn").Template

                End If

            End If

            If (IsString(Code)) Then

                dtPermissions = GetSQLDT("select [Code], [DataElement], [fView], [fAdd], [fEdit], [fDelete], [fPrint] from [UserGroupTemplateRights] order by [Code], [DataElement]", "Data.TemplateRights." & Session.SessionID & "<CacheDuration=1>")

                If (IsData(dtPermissions)) Then

                    dtRows = dtPermissions.Select("[Code] = '" & GetDataText(Code) & "' and [DataElement] = '" & GetDataText(DataElement) & "'")

                    If (Not IsNull(dtRows) AndAlso dtRows.Length > 0) Then

                        ReturnText = "<TemplateCode=" & Code & ">"

                        With dtRows(0)

                            ReturnText &= "<fView=" & .Item("fView").ToString() & "><fAdd=" & .Item("fAdd").ToString() & "><fEdit=" & .Item("fEdit").ToString() & "><fDelete=" & .Item("fDelete").ToString() & "><fPrint=" & .Item("fPrint").ToString() & ">"

                        End With

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtRows)) Then dtRows = Nothing

            If (Not IsNull(dtPermissions)) Then

                dtPermissions.Dispose()

                dtPermissions = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetUserDetails(ByRef Session As HttpSessionState, ByVal ElementItem As String, Optional ByVal Managed As Boolean = False) As Users

        Dim bSecType As Boolean = GetSecurityType(ElementItem)

        If ((Not bSecType) OrElse ((bSecType) AndAlso (Managed))) Then

            Return Session("Managed")

        Else

            Return Session("LoggedOn")

        End If

    End Function

    Public Function GetUserGroup(ByVal Username As String, ByVal SessionID As String) As String

        Dim ReturnText As String = String.Empty

        Dim dtGroups As DataTable = Nothing

        Dim UserGroups As String = String.Empty

        Dim iCount As Integer = -1

        Try

            dtGroups = GetSQLDT("select [Username], [UserGroup] from [UserBelongToGroup] where ([Username] = '" & GetDataText(Username) & "') order by [Username]", "Data.UserGroups." & SessionID)

            If (IsData(dtGroups)) Then

                iCount = (dtGroups.Rows.Count - 1)

                For iLoop As Integer = 0 To iCount

                    With dtGroups.Rows(iLoop)

                        UserGroups &= "'" & GetDataText(.Item("UserGroup").ToString()) & "'"

                    End With

                    If (iLoop < iCount) Then UserGroups &= ", "

                Next

                ReturnText = UserGroups

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtGroups)) Then

                dtGroups.Dispose()

                dtGroups = Nothing

            End If

        End Try

        Return ReturnText

    End Function

    Public Function GetUserGroupAcc(ByVal UserGroup As String, ByVal SessionID As String, Optional ByVal CacheKey As String = "", Optional ByVal SQL As String = "", Optional ByVal SQLWhere As String = "") As DataTable

        Dim SQLData As String = String.Empty

        Dim SQLCache As String = String.Empty

        If (SQL.Length = 0) Then

            If (SQLWhere.Length > 0) Then

                SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], (select top 1 [AuditLogTemplateCode] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [AuditTemplate], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [a].[CompanyNum] + ' ' + [a].[EmployeeNum] as [Value], [a].[EmployeeNum] as [EmployeeNum], [e].[Surname], [e].[PreferredName], [e].[FirstName], [TemplateCode], [JobTitle], [IndividualJobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [e1].[ShiftType], [e1].[Position], [e].[CareerLevel] from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where (" & IIf(SQLWhere.Length > 0, SQLWhere & " and ", String.Empty) & "[UserGroup] in(" & UserGroup & ")<%Terminated%>) order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [a].[CompanyNum], [a].[EmployeeNum], [UserGroup], [TemplateCode]"

                SQLCache = CacheKey

            Else

                If (Not IsNull(Cache("Data.Filter." & SessionID))) Then

                    SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], (select top 1 [AuditLogTemplateCode] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [AuditTemplate], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [a].[CompanyNum] + ' ' + [a].[EmployeeNum] as [Value], [a].[EmployeeNum] as [EmployeeNum], [e].[Surname], [e].[PreferredName], [e].[FirstName], [TemplateCode], [JobTitle], [IndividualJobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [e1].[ShiftType], [e1].[Position], [e].[CareerLevel] from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where (" & Cache("Data.Filter." & SessionID) & " and [UserGroup] in(" & UserGroup & ")<%Terminated%>) order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [a].[CompanyNum], [a].[EmployeeNum], [UserGroup], [TemplateCode]"

                    SQLCache = "Data.UserGroups.AccessTo.Filter." & SessionID

                Else

                    SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], (select top 1 [AuditLogTemplateCode] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [AuditTemplate], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [a].[CompanyNum] + ' ' + [a].[EmployeeNum] as [Value], [a].[EmployeeNum] as [EmployeeNum], [e].[Surname], [e].[PreferredName], [e].[FirstName], [TemplateCode], [JobTitle], [IndividualJobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [e1].[ShiftType], [e1].[Position], [e].[CareerLevel] from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where ([UserGroup] in(" & UserGroup & ")<%Terminated%>) order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [a].[CompanyNum], [a].[EmployeeNum], [UserGroup], [TemplateCode]"

                    SQLCache = "Data.UserGroups.AccessTo." & SessionID

                End If

            End If

        Else

            If (SQLWhere.Length > 0) Then

                SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], (select top 1 [AuditLogTemplateCode] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [AuditTemplate], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [a].[CompanyNum] + ' ' + [a].[EmployeeNum] as [Value], [a].[EmployeeNum] as [EmployeeNum], [e].[Surname], [e].[PreferredName], [e].[FirstName], [TemplateCode], [JobTitle], [IndividualJobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [e1].[ShiftType], [e1].[Position], [e].[CareerLevel]" & SQL & " from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where (" & IIf(SQLWhere.Length > 0, SQLWhere & " and ", String.Empty) & "[UserGroup] in(" & UserGroup & ")<%Terminated%>) order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [a].[CompanyNum], [a].[EmployeeNum], [UserGroup], [TemplateCode]"

                SQLCache = CacheKey

            Else

                SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], (select top 1 [AuditLogTemplateCode] from [Users] where ([CompanyNum] = [a].[CompanyNum] and [EmployeeNum] = [a].[EmployeeNum]) order by [DefaultUser] desc) as [AuditTemplate], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [a].[CompanyNum] + ' ' + [a].[EmployeeNum] as [Value], [a].[EmployeeNum] as [EmployeeNum], [e].[Surname], [e].[PreferredName], [e].[FirstName], [TemplateCode], [JobTitle], [IndividualJobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], [EMailAddress], [CellTel], [Leave_Scheme], [e1].[ShiftType], [e1].[Position], [e].[CareerLevel]" & SQL & " from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where ([UserGroup] in(" & UserGroup & ")<%Terminated%>) order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [a].[CompanyNum], [a].[EmployeeNum], [UserGroup], [TemplateCode]"

                SQLCache = CacheKey

            End If

        End If

        If (GetArrayItem(Nothing, "eGeneral.ShowTerminated")) Then

            SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        Else

            SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " and ((([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and (not [e].[Termination] = 1)) or (([e].[Termination] = 1) and ([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and ([e].[TerminationDate] > '" & Today.ToString("yyyy-MM-dd") & "')))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        End If

        Return GetSQLDT(SQLData, SQLCache)

    End Function

    Public Function GetUserGroupAccText(ByVal UserGroup As String, ByVal SessionID As String, Optional ByVal CacheKey As String = "", Optional ByVal SQLWhere As String = "", Optional ByVal SQLIdentifier As String = "") As String

        Dim SQLData As String = String.Empty

        If (SQLWhere.Length > 0) Then

            SQLData = "select [a].[CompanyNum]" & SQLIdentifier & " from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where (" & IIf(SQLWhere.Length > 0, SQLWhere & " and ", String.Empty) & "[UserGroup] in(" & UserGroup & ")<%Terminated%>)"

        Else

            If (Not IsNull(Cache("Data.Filter." & SessionID))) Then

                SQLData = "select [a].[CompanyNum]" & SQLIdentifier & " from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where (" & Cache("Data.Filter." & SessionID) & " and [UserGroup] in(" & UserGroup & ")<%Terminated%>)"

            Else

                SQLData = "select [a].[CompanyNum]" & SQLIdentifier & " from [UserGroupAccessTo] as [a] left outer join (([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [a].[CompanyNum] = [e].[CompanyNum] and [a].[EmployeeNum] = [e].[EmployeeNum] where ([UserGroup] in(" & UserGroup & ")<%Terminated%>)"

            End If

        End If

        If (GetArrayItem(Nothing, "ePerformance.ShowTerminated")) Then

            SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), String.Empty, RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        Else

            SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " and ((([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and (not [e].[Termination] = 1)) or (([e].[Termination] = 1) and ([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and ([e].[TerminationDate] > '" & Today.ToString("yyyy-MM-dd") & "')))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

        End If

        Return SQLData

    End Function

    Public Function GetWeekends(ByVal CompanyNum As String, ByVal EmployeeNum As String) As Byte()

        Dim Value() As Byte = Nothing

        Dim dHours As DataTable = Nothing

        Try

            Array.Resize(Value, 7)

            dHours = GetSQLDT("select top 1 [MonHrs], [TueHrs], [WedHrs], [ThuHrs], [FriHrs], [SatHrs], [SunHrs] from [WorkingHours] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [ValidFrom] <= '" & DateTime.Now.ToString("yyyy-MM-dd") & "') order by [ValidFrom] desc")

            If (Not IsData(dHours)) Then dHours = GetSQLDT("select [MonHrs], [TueHrs], [WedHrs], [ThuHrs], [FriHrs], [SatHrs], [SunHrs] from [ShiftTypeLU] where ([CompanyNum] = '" & CompanyNum & "' and [ShiftType] in(select [ShiftType] from [Personnel1] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')))")

            If (IsData(dHours)) Then

                Dim dIndex As Date = New Date(2011, 8, 7)

                With dHours.Rows(0)

                    For i As Integer = 0 To 6

                        Value(i) = If(Not IsNull(.Item(dIndex.ToString("ddd") & "Hrs")) AndAlso .Item(dIndex.ToString("ddd") & "Hrs") > 0, 1, 0)

                        If (Value(i) = 0 AndAlso IsNull(.Item(dIndex.ToString("ddd") & "Hrs")) AndAlso i > 0 AndAlso i < 6) Then Value(i) = 1

                        dIndex = dIndex.AddDays(1)

                    Next

                End With

            Else

                Value(0) = 1

                For i As Integer = 1 To 5

                    Value(i) = 0

                Next

                Value(6) = 1

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dHours)) Then

                dHours.Dispose()

                dHours = Nothing

            End If

        End Try

        Return Value

    End Function

    Public Function IsActiveDirectoryUser(ByVal Domain As String, ByVal Username As String, ByVal Password As String) As Boolean

        If (Domain.Length = 0) Then Return False

        Dim Entry As New DirectoryEntry("LDAP://" & Domain, Username, Password)

        Dim Searcher As New DirectorySearcher(Entry)

        Searcher.SearchScope = SearchScope.Subtree

        Try

            Dim Results As SearchResult = Searcher.FindOne()

            Return (Not (IsNull(Results)))

        Catch ex As Exception

            WriteEventLog(ex)

            Return False

        End Try

    End Function

    Public Function IsPublic(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal Start As Date, ByVal Until As Date, ByRef pDays As Date()) As Boolean

        Dim Value As Boolean = False

        Dim pDay As String = String.Empty

        If (Not IsNull(pDays) AndAlso pDays.Length > 0) Then

            For i As Integer = 0 To (pDays.Length - 1)

                pDay = pDays(i).ToString("yyyy-MM-dd")

                If (Start.AddDays(1).ToString("yyyy-MM-dd") = pDay OrElse Until.AddDays(-1).ToString("yyyy-MM-dd") = pDay) Then

                    Value = True

                    Exit For

                End If

            Next

        End If

        Return Value

    End Function

    Public Function IsWeekend(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal Start As Date, ByVal Until As Date, ByRef Weekends As Byte()) As Boolean

        If (IsNull(Weekends)) Then Weekends = GetWeekends(CompanyNum, EmployeeNum)

        Return Convert.ToBoolean(Weekends(Start.DayOfWeek) = 0 OrElse Weekends(Until.DayOfWeek) = 0)

    End Function

    Public Function IsWorkflow(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal Department As String, ByVal Email As String, ByVal WFType As String, ByVal AppType As String, ByRef ErrorText As String, Optional ByVal Name As String = "") As Boolean

        Dim ReturnBool As Boolean

        Dim WFName As String = Nothing

        Dim WFLUID As Byte

        Dim WFAppTypeID As Byte

        Dim WFRecID As Int16

        Dim ProcCount As Int16

        Dim LockedBy As String = Nothing

        Dim dtReportsTo As DataTable = Nothing

        Dim bExitLoop As Boolean

        Try

            If (IsString(Name)) Then

                WFName = Name

            Else

                WFName = GetWorkflowName(CompanyNum, EmployeeNum, Department, WFType, AppType)

            End If

            WFLUID = GetSQLField("select [ID], [WFType], [WFName] from [ess.WFLU] order by [ID]", "ID", "Data.WFLU", "[WFType] = '" & WFType & "'")

            WFAppTypeID = GetSQLField("select [ID], [WFType], [AppType], [WFName] from [ess.WFAppType] order by [WFType]", "ID", "Data.WFAppType", "[WFType] = '" & WFType & "' and [AppType] = '" & AppType & "' and [WFName] = '" & WFName & "'")

            If (WFLUID > 0 AndAlso WFAppTypeID > 0) Then

                WFRecID = GetSQLField("select [ID], [WFLUID], [LockedBy] from [ess.WF] order by [ID]", "ID", "Data.WF", "[WFLUID] = " & WFLUID.ToString())

                If (WFRecID > 0) Then ReturnBool = True

            ElseIf (WFLUID = 0) Then

                ReturnBool = False

                ErrorText = WORKFLOW_LOOKUP_NOT_FOUND

            ElseIf (WFAppTypeID = 0) Then

                ReturnBool = False

                ErrorText = WORKFLOW_APP_NOT_FOUND

            End If

            If ((Not (WFType = "Registration" AndAlso AppType = "Registration")) AndAlso String.IsNullOrEmpty(ErrorText)) Then

                ProcCount = GetSQLField("select [ID], [WFLUID], [LockedBy] from [ess.WF] order by [ID]", "ID", "Data.WF", "[WFLUID] = " & WFLUID.ToString())

                If (ProcCount = 0) Then

                    ReturnBool = False

                    ErrorText = WORKFLOW_PROCS_NOT_FOUND

                Else

                    LockedBy = GetSQLField("select [ID], [WFLUID], [LockedBy] from [ess.WF] order by [ID]", "LockedBy", "Data.WF", "[WFLUID] = " & WFLUID.ToString() & " and not [LockedBy] is null")

                    If (Not IsNull(LockedBy)) Then

                        ReturnBool = False

                        ErrorText = ReplaceParams(False, WORKFLOW_LOCKED_BY, True, LockedBy)

                    Else

                        dtReportsTo = GetSQLDT("select distinct [a].[ReportsToType], [w].[SkipNonExt] from [ess.WF] as [w] left outer join [ess.ActionLU] as [a] on ([w].[ActionID] = [a].[ID]) where ([w].[WFLUID] = " & WFLUID.ToString() & " and not [a].[ReportsToType] in('Start', 'Dummy'))", "Data.ReportsTo." & WFLUID.ToString())

                        If (IsData(dtReportsTo)) Then

                            For iLoop As Integer = 0 To (dtReportsTo.Rows.Count - 1)

                                With dtReportsTo.Rows(iLoop)

                                    Dim objWorkflow As Object() = GetSQLFields("select distinct count([CompanyNum]) as [Total], (select [EMailAddress] from [Personnel] where ([CompanyNum] = min([ReportsTo].[ReportToCompNum]) and [EmployeeNum] = min([ReportsTo].[ReportToEmpNum]))) as [Email] from [ReportsTo] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [ReportsToType] = '" & .Item("ReportsToType").ToString() & "')")

                                    If (Not IsNull(objWorkflow)) Then

                                        If (objWorkflow(0) = 0) Then

                                            If (Not .Item("SkipNonExt")) Then

                                                ReturnBool = False

                                                ErrorText = ReplaceParams(False, REPORTS_TO_ROLE_NOT_FOUND, .Item("ReportsToType").ToString())

                                                bExitLoop = True

                                                Exit For

                                            End If

                                        End If

                                    End If

                                End With

                            Next

                            If (Not bExitLoop) Then ReturnBool = True

                        Else

                            ReturnBool = False

                            ErrorText = REPORTS_TO_ROLES_NOT_FOUND

                        End If

                    End If

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtReportsTo)) Then

                dtReportsTo.Dispose()

                dtReportsTo = Nothing

            End If

        End Try

        Return ReturnBool

    End Function

    Public Function ReplaceKeys(ByVal EmpData As String, ByVal Text As String) As String

        Dim ReturnText As String = Text

        Dim objEmployee() As Object = GetSQLFields("select [Title], [Surname], [FirstName], [PreferredName] from [Personnel] where ([CompanyNum] + ' ' + [EmployeeNum] = '" & EmpData & "')")

        If (Not IsNull(objEmployee)) Then

            If (Not IsNull(objEmployee(0))) Then ReturnText = Regex.Replace(ReturnText, "\{Title\}", objEmployee(0).ToString(), RegexOptions.IgnoreCase)

            If (Not IsNull(objEmployee(1))) Then ReturnText = Regex.Replace(ReturnText, "\{Surname\}", objEmployee(1).ToString(), RegexOptions.IgnoreCase)

            If (IsNull(objEmployee(2)) AndAlso Not IsNull(objEmployee(3))) Then

                objEmployee(2) = objEmployee(3)

            ElseIf (Not IsNull(objEmployee(2)) AndAlso Not IsNull(objEmployee(3))) Then

                objEmployee(2) = objEmployee(3)

            End If

            If (Not IsNull(objEmployee(2))) Then ReturnText = Regex.Replace(ReturnText, "\{Name\}", objEmployee(2).ToString(), RegexOptions.IgnoreCase)

        End If

        objEmployee = Nothing

        Return ReturnText

    End Function

    Public Function SendBulkSMSThread(ByVal state As Object) As Object

        Dim SendTo() As String = state(0)

        Dim Text() As String = state(1)

        Dim myDataBuffer() As Byte = Nothing

        Dim myClient As WebClient = Nothing

        Dim Password As String = CryptoDecrypt(GetArrayItem(Nothing, "eGeneral.SMSCodePwd"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

        Dim useProxy As Boolean = GetArrayItem(Nothing, "eSecurity.UseProxy")

        Dim AppID As String = String.Empty

        Dim SMSCode As String = String.Empty

        Dim SMSURL As String = String.Empty

        Dim CountryCode As String = String.Empty

        Dim wp As WebProxy = Nothing

        Dim MessageID As String = String.Empty

        Dim StatusID As String = String.Empty

        Dim MobileNum As String = String.Empty

        Dim iCount As Integer = (SendTo.GetLength(0) - 1)

        Dim PostURL As String = String.Empty

        Try

            myClient = New WebClient()

            If (useProxy) Then

                Dim pServer As String = GetArrayItem(Nothing, "eSecurity.ProxyAddress")
                Dim pPort As Integer = GetArrayItem(Nothing, "eSecurity.ProxyPort")
                Dim pUserID As String = GetArrayItem(Nothing, "eSecurity.ProxyUsername")

                Dim pPassword As String = CryptoDecrypt(GetArrayItem(Nothing, "eSecurity.ProxyPassword"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                Dim pDomain As String = GetArrayItem(Nothing, "eSecurity.ProxyDomain")

                If (IsString(pUserID) AndAlso IsString(pPassword)) Then

                    Dim uProxy As New WebProxy(pServer, pPort)

                    If (IsString(pDomain)) Then

                        uProxy.Credentials = New NetworkCredential(pUserID, pPassword, pDomain)

                    Else

                        uProxy.Credentials = New NetworkCredential(pUserID, pPassword)

                    End If

                    myClient.Proxy = uProxy

                Else

                    myClient.Proxy = New WebProxy(pServer, pPort)

                End If

            End If

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSAppID"))) Then AppID = GetArrayItem(Nothing, "eGeneral.SMSAppID")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSCode"))) Then SMSCode = GetArrayItem(Nothing, "eGeneral.SMSCode")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSURL"))) Then SMSURL = GetArrayItem(Nothing, "eGeneral.SMSURL")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSCountry"))) Then CountryCode = GetArrayItem(Nothing, "eGeneral.SMSCountry")

            For iLoop As Integer = 0 To iCount

                If (Not IsNull(SendTo(iLoop))) Then

                    SendTo(iLoop) = Regex.Replace(Regex.Replace(SendTo(iLoop), "\D", String.Empty), "^0+", String.Empty)

                    If (Not SendTo(iLoop).Substring(0, CountryCode.Length) = CountryCode) Then SendTo(iLoop) = CountryCode & SendTo(iLoop)

                    If (String.IsNullOrEmpty(SMSCode)) Then

                        PostURL = "http://www.dotgse.co.za/app/send_sms.aspx?username=" & AppID & "&password=" & Password & "&number=" & SendTo(iLoop) & "&message=" & UrlEncode(Text(iLoop))

                    Else

                        PostURL = "http://www.dotgse.co.za/app/send_sms.aspx?master_code=" & AppID & "&code=" & SMSCode & "&password=" & Password & "&number=" & SendTo(iLoop) & "&message=" & UrlEncode(Text(iLoop))

                    End If

                    If (Not String.IsNullOrEmpty(SMSURL)) Then PostURL &= "&delivery=1&delivery_url=" & UrlEncode(SMSURL)

                    myDataBuffer = myClient.DownloadData(PostURL)

                    StatusID = System.Text.ASCIIEncoding.ASCII.GetString(myDataBuffer)

                    If (StatusID.Contains("=")) Then

                        Dim StatusResponse() As String = StatusID.Split("=")

                        StatusID = StatusResponse(0)

                        MessageID = StatusResponse(1)

                    End If

                    If (StatusID = SUCCESS) Then StatusID = "-1"

                    If (Not IsGuid(MessageID)) Then

                        MessageID = Guid.NewGuid().ToString()

                        If (Not String.IsNullOrEmpty(SMSURL)) Then PostURL &= "&custom_id=" & MessageID

                    End If

                    If (IsNumeric(StatusID)) Then ExecSQL("insert into [MessageResults]([ID], [Date], [StatusID], [MobileNum], [Message]) values('" & MessageID.ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & StatusID & ", '" & SendTo(iLoop) & "', '" & GetDataText(Text(iLoop)) & "')")

                    Cache.Insert(state(2).ToString() & ".Progress", Convert.ToInt32(((iLoop + 1) / (iCount + 1)) * 100), Nothing, DateTime.Now.AddHours(1), TimeSpan.Zero)

                End If

            Next

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(wp)) Then wp = Nothing

            If (Not IsNull(myClient)) Then

                myClient.Dispose()

                myClient = Nothing

            End If

            If (Not IsNull(myDataBuffer)) Then myDataBuffer = Nothing

        End Try

        Return Nothing

    End Function

    Public Function SendSMSThread(ByVal state As Object) As Object

        Dim MobileNum As String = state(0)

        Dim myDataBuffer() As Byte = Nothing

        Dim myClient As WebClient = Nothing

        Dim Password As String = CryptoDecrypt(GetArrayItem(Nothing, "eGeneral.SMSCodePwd"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

        Dim useProxy As Boolean = GetArrayItem(Nothing, "eSecurity.UseProxy")

        Dim AppID As String = String.Empty

        Dim SMSCode As String = String.Empty

        Dim SMSURL As String = String.Empty

        Dim CountryCode As String = String.Empty

        Dim wp As WebProxy = Nothing

        Dim MessageID As String = String.Empty

        Dim StatusID As String = String.Empty

        Dim PostURL As String = String.Empty

        Try

            myClient = New WebClient()

            If (useProxy) Then

                Dim pServer As String = GetArrayItem(Nothing, "eSecurity.ProxyAddress")
                Dim pPort As Integer = GetArrayItem(Nothing, "eSecurity.ProxyPort")
                Dim pUserID As String = GetArrayItem(Nothing, "eSecurity.ProxyUsername")

                Dim pPassword As String = CryptoDecrypt(GetArrayItem(Nothing, "eSecurity.ProxyPassword"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                Dim pDomain As String = GetArrayItem(Nothing, "eSecurity.ProxyDomain")

                If (IsString(pUserID) AndAlso IsString(pPassword)) Then

                    Dim uProxy As New WebProxy(pServer, pPort)

                    If (IsString(pDomain)) Then

                        uProxy.Credentials = New NetworkCredential(pUserID, pPassword, pDomain)

                    Else

                        uProxy.Credentials = New NetworkCredential(pUserID, pPassword)

                    End If

                    myClient.Proxy = uProxy

                Else

                    myClient.Proxy = New WebProxy(pServer, pPort)

                End If

            End If

            MobileNum = Regex.Replace(Regex.Replace(MobileNum, "\D", String.Empty), "^0+", String.Empty)

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSAppID"))) Then AppID = GetArrayItem(Nothing, "eGeneral.SMSAppID")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSCode"))) Then SMSCode = GetArrayItem(Nothing, "eGeneral.SMSCode")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSURL"))) Then SMSURL = GetArrayItem(Nothing, "eGeneral.SMSURL")

            If (Not IsNull(GetArrayItem(Nothing, "eGeneral.SMSCountry"))) Then CountryCode = GetArrayItem(Nothing, "eGeneral.SMSCountry")

            If (Not MobileNum.Substring(0, CountryCode.Length) = CountryCode) Then MobileNum = CountryCode & MobileNum

            If (String.IsNullOrEmpty(SMSCode)) Then

                PostURL = "http://www.dotgse.co.za/app/send_sms.aspx?username=" & AppID & "&password=" & Password & "&number=" & MobileNum & "&message=" & UrlEncode(state(1))

            Else

                PostURL = "http://www.dotgse.co.za/app/send_sms.aspx?master_code=" & AppID & "&code=" & SMSCode & "&password=" & Password & "&number=" & MobileNum & "&message=" & UrlEncode(state(1))

            End If

            If (Not String.IsNullOrEmpty(SMSURL)) Then PostURL &= "&delivery=1&delivery_url=" & UrlEncode(SMSURL)

            myDataBuffer = myClient.DownloadData(PostURL)

            StatusID = System.Text.ASCIIEncoding.ASCII.GetString(myDataBuffer)

            If (StatusID.Contains("=")) Then

                Dim StatusResponse() As String = StatusID.Split("=")

                StatusID = StatusResponse(0)

                MessageID = StatusResponse(1)

            End If

            If (StatusID = SUCCESS) Then StatusID = "-1"

            If (Not IsGuid(MessageID)) Then

                MessageID = Guid.NewGuid().ToString()

                If (Not String.IsNullOrEmpty(SMSURL)) Then PostURL &= "&custom_id=" & MessageID

            End If

            If (IsNumeric(StatusID)) Then ExecSQL("insert into [MessageResults]([ID], [Date], [StatusID], [MobileNum], [Message]) values('" & MessageID.ToString() & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & StatusID & ", '" & MobileNum & "', '" & GetDataText(state(1).ToString()) & "')")

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(wp)) Then wp = Nothing

            If (Not IsNull(myClient)) Then

                myClient.Dispose()

                myClient = Nothing

            End If

            If (Not IsNull(myDataBuffer)) Then myDataBuffer = Nothing

        End Try

        Return Nothing

    End Function

#End Region

End Module
