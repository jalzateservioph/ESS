Partial Public Class changeman
    Inherits System.Web.UI.Page
    Private ASM As System.Reflection.Assembly
    Private PathID As String
    Private Template As String
    Private UDetails As Users = Nothing
    Private OriginatorDetails As Object = Nothing
    Private StatusCheck As Object
#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UDetails = GetUserDetails(Session, Template, True)

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        OriginatorDetails = GetSQLFields("SELECT A.OriginatorCompanyNum, A.OriginatorEmployeeNum FROM [ess.Path] A WHERE A.ID = '" & PathID & "'")

        StatusCheck = GetSQLFields("SELECT TOP(1) (CASE WHEN A.[Actioner] = A.[Originator] THEN 'RETURN' ELSE 'PROCEED' END) AS [Status], (SELECT COUNT(*) FROM [ess.Reject] WHERE [PathID] = A.[ID] AND [ActionedBy] = 4) AS [Count], (CASE WHEN C.[Key] = 'DEPENDANTS' THEN 'DEPENDANTS' ELSE 'NORMAL' END) AS [Type] FROM [ess.Path] AS A LEFT JOIN [ess.Change] AS B ON A.ID = B.PathID LEFT JOIN [ess.Policy] AS C ON C.ID = B.PolicyID WHERE A.ID = '" & PathID & "'")

        Template = GetSQLField("SELECT TOP(1) [Template] FROM [ess.Change] WHERE ([PathID] = " & PathID & ")", "Template")

        If (Not IsPostBack) Then
            UDetails = GetUserDetails(Session, Template, True)

            With UDetails

                CType(pnlChanges.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Change Acceptance: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name
                Dim lbl As String = CType(pnlChanges.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Change Acceptance: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        UDetails = GetUserDetails(Session, Template, True)

        With UDetails

            Try
                'Adjusted retrieved query for items in the changeman.vb and Created an insert query for 'Change: Complete' email type. 
                'removed filter 'and SIGN([c].[Level]) = 1' in query.
                LoadExpGrid(Session, dgView_001, Template, "<Tablename=ess.Change><Join=(([{%Tablename%}] as [c] left outer join [AssemblyLU] as [d] on [c].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [c].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + cast([c].[PolicyID] as nvarchar(3))", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + [c].[ValueF] + ' ' + [c].[ValueT]") & "><Columns=[c].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN 'Dependents' + ' (' + [c].[AdditionalFilter] + ') : ' + [c].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [c].[ValueF], [c].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([c].[PathID] = " & PathID & " )>")
                'amanriza - end
                LoadExpGrid(Session, dgView_002, Template, "<Tablename=ess.Reject><Join=(([{%Tablename%}] as [r] left outer join [AssemblyLU] as [d] on [r].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [r].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [r].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + cast([r].[PolicyID] as nvarchar(3))", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + [r].[ValueF] + ' ' + [r].[ValueT]") & "><Columns=[r].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN 'Dependents' + ' (' + [r].[AdditionalFilter] + ') : ' + [r].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [r].[ValueF], [r].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([r].[PathID] = " & PathID & " and [r].[ActionedBy] = 4")
                'LoadExpGrid(Session, dgView_002, Template, "<Tablename=ess.Reject><Join=(([{%Tablename%}] as [r] left outer join [AssemblyLU] as [d] on [r].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [r].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [r].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + cast([r].[PolicyID] as nvarchar(3))", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + [r].[ValueF] + ' ' + [r].[ValueT]") & "><Columns=[r].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN 'Dependents' + ' (' + [r].[AdditionalFilter] + ') : ' + [r].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [r].[ValueF], [r].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([r].[PathID] = " & PathID & " and [r].[ActionedBy] = '" & Session("LoggedOn").UserID & "')>")

                'Dim xDataTable As DataTable = Nothing

                Dim xRemarks As String = String.Empty

                Try

                    Dim xDataTable = GetSQLDT("SELECT 'Added By ' + ISNULL(LTRIM(RTRIM(B.Surname)),'') + ', ' + ISNULL(LTRIM(RTRIM(B.FirstName)),'') + ' ' + ISNULL(LTRIM(RTRIM(B.MiddleName)),'') + ' : ' + CONVERT(NVARCHAR(36),A.Remarks) AS [Remarks] FROM [ess.WFRemarks] AS A LEFT JOIN [Personnel] AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum WHERE A.PathID = " & PathID & " ORDER BY A.CaptureDate ASC", "Change.Remarks." & Session.SessionID)

                    For Each xRow As DataRow In xDataTable.Rows

                        xRemarks &= xRow("Remarks") & vbNewLine

                    Next xRow

                    txtComments.Text = xRemarks

                Catch ex As Exception

                End Try

            Catch ex As Exception

            End Try
        End With

        cmdSubmit.Visible = IIf(StatusCheck(0).ToString() <> "RETURN", True, False)

        cmdReject.Visible = IIf(StatusCheck(0).ToString() <> "RETURN", True, False)

        lblRemarks.ForeColor = IIf(StatusCheck(1).ToString() > "0", Drawing.Color.Red, Drawing.Color.Black)

        lblRemarks.Text = IIf(StatusCheck(1).ToString() > "0", "*Remarks (add comments for the applicant):", "Remarks (add comments for the applicant):")

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        If Values(0) <> "DELETE" Then

            PathID = String.Empty

            If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

            Dim bSaved As Boolean = True

            Dim PathData As String = GetPathData(PathID)

            Dim PolicyKey As String

            Dim SQL() As String = {"update ", "update ", "update [ess.Change] set [ValueT] = <%Value%> where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [NotifyDate], 120) + ' ' + cast([PolicyID] as nvarchar(3)) = '[%CompositeKey%]')"}

            Dim Columns() As String = {String.Empty, String.Empty}


            With UDetails

                Select Case Template 'unnecesary

                    Case "Personal Tab"
                        SQL(0) &= "[Personnel]"

                        SQL(1) &= "[Personnel1]"

                    Case "Organisational Tab"
                        SQL(0) &= "[Personnel]"

                        SQL(1) &= "[Personnel1]"

                End Select

                SQL(0) &= " set [%Columns%] where ([CompanyNum] = '" & OriginatorDetails(0) & "' and [EmployeeNum] = '" & OriginatorDetails(1) & "')"

                SQL(1) &= " set [%Columns%] where ([CompanyNum] = '" & OriginatorDetails(0) & "' and [EmployeeNum] = '" & OriginatorDetails(1) & "')"

                Dim iCount As Integer = (dgView_001.VisibleRowCount - 1)

                Dim CompKey As String

                Dim ItemKey As String

                Dim bType As Byte

                Dim SQLUpdateChange As String = String.Empty

                For iLoop As Integer = 0 To iCount

                    Dim PolicyID As String = dgView_001.GetRowValues(iLoop, "PolicyID").ToString()

                    CompKey = dgView_001.GetRowValues(iLoop, "CompositeKey")

                    ItemKey = dgView_001.GetRowValues(iLoop, "Key")

                    PolicyKey = dgView_001.ID & "_" & PolicyID

                    'bType = 0

                    'If (Template = "Organisational Tab" AndAlso (ItemKey = "Position" Or ItemKey = "Location")) Then bType = 1 'not practical

                    If (FindPolicyTableName(PolicyID) = "Personnel1") Then
                        bType = 1
                    Else
                        bType = 0
                    End If

                    Columns(bType) &= "[" & ItemKey & "] = "

                    Select Case dgView_001.GetRowValues(iLoop, "DataType")

                        Case 0
                            Columns(bType) &= IIf(items_saved.Get(PolicyKey), "1", "0")

                            SQLUpdateChange = SQL(2).Replace("<%Value%>", IIf(items_saved.Get(PolicyKey), "1", "0"))

                        Case 1
                            Columns(bType) &= GetNullText(items_saved.Get(PolicyKey))

                            SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(items_saved.Get(PolicyKey)))

                        Case 2
                            Columns(bType) &= GetNullText(items_saved.Get(PolicyKey))

                            SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(items_saved.Get(PolicyKey)))

                        Case 3
                            Columns(bType) &= GetNullText(items_saved.Get(PolicyKey))

                            SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(items_saved.Get(PolicyKey)))

                        Case 4
                            Columns(bType) &= GetNullText(DateTime.Parse(items_saved.Get(PolicyKey)).ToString("yyyy-MM-dd"))
                            'SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(items_saved.Get(PolicyKey)))
                            SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(DateTime.Parse(items_saved.Get(PolicyKey)).ToString("yyyy-MM-dd")))


                        Case 5
                            Columns(bType) &= GetNullText(items_saved.Get(PolicyKey))

                            SQLUpdateChange = SQL(2).Replace("<%Value%>", GetNullText(items_saved.Get(PolicyKey)))

                        Case 6
                            'TODO: v6.0.74 ENSURE THAT WE CREATE A PARAMETER WHEN UPDATING THE RELEVANT CONTENT

                    End Select

                    SQLUpdateChange = SQLUpdateChange.Replace("[%CompositeKey%]", CompKey).Replace(" = null ", " = '' ")
                    bSaved = ExecSQL(SQLUpdateChange)

                    If (Not bSaved) Then Exit For

                    Columns(bType) &= ", "

                Next

                Select Case Template

                    Case "Personal Tab"
                        Columns(0) = Columns(0).Replace("[MaritalStatus]", "[MaritialStatus]")

                    Case "Organisational Tab"
                        'Columns(1) = Columns(1).Replace("", "")

                End Select

                If (Columns(0).EndsWith(", ")) Then Columns(0) = Columns(0).Substring(0, Columns(0).Length - 2)

                If (Columns(1).EndsWith(", ")) Then Columns(1) = Columns(1).Substring(0, Columns(1).Length - 2)

                'If (Columns(0).Length > 0) Then

                '    SQL(0) = SQL(0).Replace("[%Columns%]", Columns(0))

                '    'RNaanep 05032016
                '    If ((GetXML(PathData, KeyName:="ActionType")) = "HR Manager") And (Values(0).ToUpper() = "APPROVE") Then
                '        bSaved = ExecSQL(SQL(0))
                '    End If

                'End If

                'If (Columns(1).Length > 0) Then

                '    SQL(1) = SQL(1).Replace("[%Columns%]", Columns(1))

                '    'RNaanep 05032016
                '    If ((GetXML(PathData, KeyName:="ActionType")) = "HR Manager") And (Values(0).ToUpper() = "APPROVE") Then
                '        bSaved = ExecSQL(SQL(1))
                '    End If

                'End If

                If (bSaved Or Columns(0).ToString().Contains("Dependants")) Then

                    If (Values(0).ToUpper() = "APPROVE") Then

                        'ExecSQL("EXECUTE [ess.Approve] '" & UDetails.CompanyNum & "','" & UDetails.EmployeeNum & "','" & PathID & "',1,'" & GetXML(PathData, KeyName:="ActionType") & "'")
                        ExecSQL("EXECUTE [ess.Approve] '" & OriginatorDetails(0) & "','" & OriginatorDetails(1) & "','" & PathID & "',1,'" & GetXML(PathData, KeyName:="ActionType") & "'")

                        Dim objUserData() As Object = GetSQLFields("SELECT A.EMailAddress FROM [Personnel] AS A INNER JOIN [ess.Path] AS B ON A.EmployeeNum = B.OriginatorEmployeeNum WHERE B.ID = '" & PathID & "'")

                        Dim objCheck() As Object = GetSQLFields("SELECT SUM(CASE WHEN SIGN(Level) = 0 THEN 1 ELSE 0 END) AS [JustApproved], SUM(CASE WHEN SIGN(Level) = 1 THEN 1 ELSE 0 END) AS [ForApproval] FROM [ess.Change] WHERE PathID = '" & PathID & "'")

                        Dim JustApproved As Integer
                        Dim ForApproval As Integer

                        If TypeOf objCheck(0) Is Integer And TypeOf objCheck(0) Is Integer Then
                            JustApproved = DirectCast(objCheck(0), Integer)
                            ForApproval = DirectCast(objCheck(1), Integer)
                        Else
                            JustApproved = 0
                            ForApproval = 0
                        End If

                        Dim EmailPathData() As Object = GetPathLU(PathID)

                        If JustApproved > 0 Then
                            SendEmailThread(New Object() {ServerPath, GetEmailID(IIf(ForApproval > 0, "Change: Auto-Approve", "Change: Completed")), "<SendTo=" & objUserData(0).ToString() & "><CC=><BCC=>", String.Empty, False, EmailPathData, PathID})
                        End If

                        If ForApproval > 0 Then
                            'bSaved = ExecSQL("exec [ess.WFProc] '" & OriginatorDetails(0) & "', '" & OriginatorDetails(1) & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                            bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & OriginatorDetails(0) & "', '" & OriginatorDetails(1) & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        End If

                        If (bSaved Or Columns(0).ToString().Contains("Dependants")) Then

                            ''added to adjust previous actioner.
                            If ((GetXML(PathData, KeyName:="ActionType")) = "HR Manager" And (JustApproved > 0)) Then
                                'bSaved = ExecSQL("exec [ess.WFProc] '" & OriginatorDetails(0) & "', '" & OriginatorDetails(1) & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                                bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & OriginatorDetails(0) & "', '" & OriginatorDetails(1) & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                                '    ExecSQL("update [ess.Reject] set ActionedBy = 2 where PathID = '" & PathID & "'")
                            End If
                            ''amanriza - 05/02/2019
                            ''Added a condition if the item is approved
                            'If (HasRows("SELECT * FROM [ess.Reject] WHERE PathID = " & PathID & " ")) Then
                            '    If ((GetXML(PathData, KeyName:="ActionType")) = "HR Manager" And (JustApproved > 0)) Then
                            '        bSaved = ExecSQL("UPDATE [ess.Reject] set ActionedBy = " & DirectCast(ESSActionedBy.Completed, Int32) & " WHERE PathID = " & PathID & "")
                            '    Else
                            '        bSaved = ExecSQL("UPDATE [ess.Reject] set ActionedBy = " & DirectCast(ESSActionedBy.InProgress, Int32) & " WHERE PathID = " & PathID & "")
                            '    End If

                            'Else
                            '        bSaved = ExecSQL(String.Format("INSERT INTO [ess.Reject] SELECT *, " & DirectCast(ESSActionedBy.InProgress, Int32) & " FROM [ess.Change] WHERE PathID = " & PathID & " "))
                            'End If
                            ''amanriza - end

                            If (Values(1).Length > 0) Then

                                Dim actioner As String = Session("LoggedOn").EmployeeNum

                                'If (Session("SelectedEmp") = Session("LoggedOn").EmployeeNum) Then
                                '    actioner = Session("LoggedOn").EmployeeNum
                                'Else
                                '    actioner = Session("LoggedOn").EmployeeNum & "(" & Session("SelectedEmp") & ")"
                                'End If

                                bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & actioner & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")
                            End If

                            If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

                            e.Result = "tasks.aspx tools/index.aspx"

                        End If

                    ElseIf (Values(0).ToUpper() = "REJECT") Then

                        If (Values(1).Length > 0) Then

                            Dim actioner As String = Session("LoggedOn").EmployeeNum

                            'If (Session("SelectedEmp") = Session("LoggedOn").EmployeeNum) Then
                            '    actioner = Session("LoggedOn").EmployeeNum
                            'Else
                            '    actioner = Session("LoggedOn").EmployeeNum & "(" & Session("SelectedEmp") & ")"
                            'End If

                            Dim value = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & actioner & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

                        End If

                        'bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")
                        bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & OriginatorDetails(0) & "', '" & OriginatorDetails(1) & "', " & PathID & ", 'Change', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & IIf(Values(0).ToUpper() = "APPROVE", "Approve", "Reject") & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        If (bSaved) Then

                            'Added a condition if the item is rejected
                            If (HasRows("SELECT * FROM [ess.Reject] WHERE PathID = " & PathID & " ")) Then
                                bSaved = ExecSQL("UPDATE [ess.Reject] set ActionedBy = '" & DirectCast(ESSActionedBy.Rejected, Int32) & "' WHERE PathID = " & PathID & "")
                                'bSaved = ExecSQL("UPDATE [ess.Reject] set ActionedBy = '" & OriginatorDetails(1) & "' WHERE PathID = " & PathID & "")
                            Else
                                bSaved = ExecSQL(String.Format("INSERT INTO [ess.Reject]" & "SELECT *,'" & DirectCast(ESSActionedBy.Rejected, Int32) & "' FROM [ess.Change] WHERE PathID = " & PathID & " "))
                                'bSaved = ExecSQL(String.Format("INSERT INTO [ess.Reject]" & "SELECT *,'" & OriginatorDetails(1) & "' FROM [ess.Change] WHERE PathID = " & PathID & " "))

                            End If

                            If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

                        End If

                    ElseIf (Values(0).ToUpper() = "RETURN") And (Values(1).Length > 0) Then

                        bSaved = ExecSQL("EXEC [ess.Return] '" & PathID & "'")

                        If (bSaved) Then

                            Dim objUserData() As Object = GetSQLFields("SELECT [UserEmail] FROM [ess.Path] WHERE [ID] = '" & PathID & "'")

                            Dim EmailPathData() As Object = GetPathLU(PathID)

                            'Added a condition if the item is returned
                            If (Not HasRows("SELECT * FROM [ess.Reject] WHERE PathID = " & PathID & " ")) Then

                                bSaved = ExecSQL("INSERT INTO [ess.Reject]" &
                                                              "SELECT *, " & DirectCast(ESSActionedBy.Returned, Int32) & " FROM [ess.Change] WHERE PathID = " & PathID & " ")
                            End If

                            If (Values(1).Length > 0) Then

                                Dim actioner As String = Session("LoggedOn").EmployeeNum

                                'If (Session("SelectedEmp") = Session("LoggedOn").EmployeeNum) Then
                                '    actioner = Session("LoggedOn").EmployeeNum
                                'Else
                                '    actioner = Session("LoggedOn").EmployeeNum & "(" & Session("SelectedEmp") & ")"
                                'End If

                                bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & actioner & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")
                            End If

                            SendEmailThread(New Object() {ServerPath, GetEmailID(IIf(StatusCheck(0).ToString() = "RETURN", "Change: Submitted Revision", "Change: Returned for Revision")), "<SendTo=" & objUserData(0).ToString() & "><CC=><BCC=>", String.Empty, False, EmailPathData, PathID})

                            If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

                        End If

                    End If

                End If

            End With

        End If

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_001.DataBound, dgView_002.DataBound

        Dim objValue As Object
        Dim ItemKey As String

        For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

            ItemKey = sender.ID & "_" & sender.GetRowValues(iLoop, "PolicyID").ToString()

            If (Not items_saved.Contains(ItemKey)) Then

                objValue = Nothing

                Select Case sender.GetRowValues(iLoop, "AssemblyTypeName").ToString()

                    Case "DevExpress.Web.ASPxEditors.ASPxCheckBox"
                        objValue = Convert.ToBoolean(sender.GetRowValues(iLoop, "ValueT"))

                    Case "DevExpress.Web.ASPxEditors.ASPxComboBox"
                        objValue = sender.GetRowValues(iLoop, "ValueT").ToString()

                    Case "DevExpress.Web.ASPxEditors.ASPxDateEdit"
                        Dim dteValue As DateTime

                        If (DateTime.TryParse(sender.GetRowValues(iLoop, "ValueT"), dteValue)) Then objValue = dteValue

                    Case "DevExpress.Web.ASPxEditors.ASPxSpinEdit"
                        objValue = sender.GetRowValues(iLoop, "ValueT")

                    Case "DevExpress.Web.ASPxEditors.ASPxTextBox"
                        objValue = sender.GetRowValues(iLoop, "ValueT").ToString()

                End Select

                items_saved.Add(ItemKey, objValue)

            End If

        Next

    End Sub

    Private Sub dgView_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles dgView_001.HtmlRowCreated, dgView_002.HtmlRowCreated

        If (e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.Data) Then

            Dim objValue As Object = Nothing
            Dim ItemKey As String

            ItemKey = sender.ID & "_" & sender.GetRowValues(e.VisibleIndex, "PolicyID").ToString()

            Dim objControl As Object = Nothing
            Dim setValue As String

            Dim phControl As PlaceHolder = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Value"), DevExpress.Web.ASPxGridView.GridViewDataColumn), "phControls"), PlaceHolder)

            If (Not IsNull(phControl)) Then

                If (IsNull(app)) Then app = AppDomain.CreateDomain("DevExpress")

                ASM = app.Load(Reflection.AssemblyName.GetAssemblyName(Server.MapPath("~\bin\") & sender.GetRowValues(e.VisibleIndex, "Assembly").ToString()))

                objControl = Activator.CreateInstance(ASM.GetType(sender.GetRowValues(e.VisibleIndex, "AssemblyTypeName").ToString()))

                If (Not IsNull(objControl)) Then

                    If (items_saved.Contains(ItemKey)) Then objValue = items_saved.Get(ItemKey)

                    objControl.ID = ItemKey

                    objControl.ClientInstanceName = objControl.ID

                    setValue = "function(s, e) { " & items_saved.ClientInstanceName & ".Set('" & ItemKey & "', s.<%Parameter%>()); }"

                    phControl.Controls.Add(objControl)

                    Select Case sender.GetRowValues(e.VisibleIndex, "AssemblyTypeName").ToString()

                        Case "DevExpress.Web.ASPxEditors.ASPxCheckBox"
                            If (Not IsNull(objValue)) Then

                                objControl.Checked = objValue

                            Else

                                objControl.Checked = Convert.ToBoolean(Convert.ToByte(sender.GetRowValues(e.VisibleIndex, "ValueT"))) 'added Convert.ToByte

                                objValue = objControl.Checked

                            End If

                            objControl.ClientSideEvents.CheckedChanged = setValue.Replace("<%Parameter%>", "GetChecked")

                        Case "DevExpress.Web.ASPxEditors.ASPxComboBox"
                            objControl.EnableIncrementalFiltering = True

                            objControl.DropDownStyle = DevExpress.Web.ASPxEditors.DropDownStyle.DropDownList

                            objControl.Width = Unit.Pixel(250)

                            Dim Table As String = sender.GetRowValues(e.VisibleIndex, "LookupTable").ToString()
                            Dim Text As String = sender.GetRowValues(e.VisibleIndex, "LookupText").ToString()
                            Dim Value As String = sender.GetRowValues(e.VisibleIndex, "LookupValue").ToString()
                            Dim Filter As String = sender.GetRowValues(e.VisibleIndex, "LookupFilter").ToString()

                            objControl.DataSource = GetSQLDT("select " & Value & ", " & Text & " from " & Table & IIf(Filter.Length = 0, String.Empty, " where (" & Filter & ")") & " union select '', '' order by " & Text)

                            objControl.TextField = Text.Replace("[", String.Empty).Replace("]", String.Empty)

                            objControl.ValueField = Value.Replace("[", String.Empty).Replace("]", String.Empty)

                            If (Not IsNull(objValue)) Then

                                objControl.Value = objValue

                            ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "ValueT"))) Then

                                objControl.Value = sender.GetRowValues(e.VisibleIndex, "ValueT").ToString()

                                objValue = objControl.Value

                            End If

                            objControl.DataBind()

                            LoadExpCmb(objControl, "<select>")

                            objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                        Case "DevExpress.Web.ASPxEditors.ASPxDateEdit"
                            If (Not IsNull(objValue)) Then

                                objControl.Date = objValue

                            Else

                                Dim dteValue As DateTime

                                If (DateTime.TryParse(sender.GetRowValues(e.VisibleIndex, "ValueT"), dteValue)) Then

                                    objControl.Date = dteValue

                                    objValue = objControl.Date

                                End If

                            End If

                            objControl.ClientSideEvents.DateChanged = setValue.Replace("<%Parameter%>", "GetValue")

                            objControl.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom

                            objControl.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

                        Case "DevExpress.Web.ASPxEditors.ASPxSpinEdit"
                            If (Not IsNull(objValue)) Then

                                objControl.Value = objValue

                            ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "ValueT"))) Then

                                objControl.Value = sender.GetRowValues(e.VisibleIndex, "ValueT")

                                objValue = objControl.Value

                            End If

                            objControl.Width = Unit.Pixel(75)

                            objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                        Case "DevExpress.Web.ASPxEditors.ASPxTextBox"
                            If (Not IsNull(objValue)) Then

                                objControl.Value = objValue

                            Else

                                objControl.Text = sender.GetRowValues(e.VisibleIndex, "ValueT").ToString()

                                objValue = objControl.Text

                            End If

                            objControl.Width = Unit.Pixel(250)

                            objControl.ClientSideEvents.ValueChanged = setValue.Replace("<%Parameter%>", "GetValue")

                    End Select

                    If (Not items_saved.Contains(ItemKey)) Then items_saved.Add(ItemKey, objValue)

                End If

            End If

        End If

    End Sub

    Private Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting

        Dim changeWhereClause = "WHERE (" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [NotifyDate], 120) + ' ' + CAST([PolicyID] AS NVARCHAR(3))", "[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [NotifyDate], 120) + ' ' + [ValueF] + ' ' + [ValueT]") & " = '" & e.Keys("CompositeKey") & "')"

        Dim value = ExecSQL("INSERT INTO [ess.Reject] select *, 4 from [ess.Change] " & changeWhereClause)

        value = ExecSQL("DELETE FROM [ess.Change] " & changeWhereClause)

        'value = ExecSQL("UPDATE [ess.Reject] SET ActionedBy = '" & Session("LoggedOn").UserID & "' where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [NotifyDate], 120) + ' ' + cast([PolicyID] as nvarchar(3)) = '" & e.Keys("CompositeKey") & "')")

        LoadExpGrid(Session, dgView_001, Template, "<Tablename=ess.Change><Join=(([{%Tablename%}] as [c] left outer join [AssemblyLU] as [d] on [c].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [c].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + cast([c].[PolicyID] as nvarchar(3))", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + [c].[ValueF] + ' ' + [c].[ValueT]") & "><Columns=[c].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN [p].[Label] + ' (' + [c].[AdditionalFilter] + ') : ' + [c].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [c].[ValueF], [c].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([c].[PathID] = " & PathID & " and SIGN([c].[Level]) = 1)>")

        LoadExpGrid(Session, dgView_002, Template, "<Tablename=ess.Reject><Join=(([{%Tablename%}] as [r] left outer join [AssemblyLU] as [d] on [r].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [r].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [r].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + cast([r].[PolicyID] as nvarchar(3))", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + [r].[ValueF] + ' ' + [r].[ValueT]") & "><Columns=[r].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN [p].[Label] + ' (' + [r].[AdditionalFilter] + ') : ' + [r].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [r].[ValueF], [r].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([r].[PathID] = " & PathID & " and [r].[ActionedBy] = 4")

        e.Cancel = True

    End Sub

    Private Sub dgView_002_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_002.RowDeleting

        ExecSQL("DELETE FROM [ess.Reject] WHERE (" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [NotifyDate], 120) + ' ' + CAST([PolicyID] AS NVARCHAR(3))", "[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [NotifyDate], 120) + ' ' + [ValueF] + ' ' + [ValueT]") & " = '" & e.Keys("CompositeKey") & "')")

        LoadExpGrid(Session, dgView_001, Template, "<Tablename=ess.Change><Join=(([{%Tablename%}] as [c] left outer join [AssemblyLU] as [d] on [c].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [c].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + cast([c].[PolicyID] as nvarchar(3))", "[c].[CompanyNum] + ' ' + [c].[EmployeeNum] + ' ' + convert(nvarchar(19), [c].[NotifyDate], 120) + ' ' + [c].[ValueF] + ' ' + [c].[ValueT]") & "><Columns=[c].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN [p].[Label] + ' (' + [c].[AdditionalFilter] + ') : ' + [c].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [c].[ValueF], [c].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([c].[PathID] = " & PathID & " and SIGN([c].[Level]) = 1)>")

        LoadExpGrid(Session, dgView_002, Template, "<Tablename=ess.Reject><Join=(([{%Tablename%}] as [r] left outer join [AssemblyLU] as [d] on [r].[AssemblyID] = [d].[ID]) left outer join [ess.Policy] as [p] on [r].[PolicyID] = [p].[ID]) left outer join [ess.PolicyMapping] as [m] on [r].[PolicyID] = [m].[PolicyID]><PrimaryKey=" & IIf(StatusCheck(2).ToString() <> "DEPENDANTS", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + cast([r].[PolicyID] as nvarchar(3))", "[r].[CompanyNum] + ' ' + [r].[EmployeeNum] + ' ' + convert(nvarchar(19), [r].[NotifyDate], 120) + ' ' + [r].[ValueF] + ' ' + [r].[ValueT]") & "><Columns=[r].[PolicyID], [d].[Assembly], [d].[TypeName] as [AssemblyTypeName], [p].[Key], (CASE WHEN [p].[Label] = 'DEPENDANTS' THEN [p].[Label] + ' (' + [r].[AdditionalFilter] + ') : ' + [r].[AdditionalName] ELSE [m].[ItemName] END) AS [Label], (select [DataType] from [DataTypeLU] where ([ID] = [p].[DataTypeID])) as [DataType], [r].[ValueF], [r].[ValueT], [p].[LookupTable], [p].[LookupText], [p].[LookupValue], [p].[LookupFilter]><Where=([r].[PathID] = " & PathID & " and [r].[ActionedBy] = 4")

        e.Cancel = True

    End Sub

#End Region

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click

        lblRemarks.ForeColor = IIf(StatusCheck(1).ToString() > "0", Drawing.Color.Red, Drawing.Color.Black)

        lblRemarks.Text = IIf(StatusCheck(1).ToString() > "0", "*Remarks (add comments for the applicant):", "Remarks (add comments for the applicant):")

    End Sub

End Class