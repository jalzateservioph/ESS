Public Enum ESSActionedBy
    NoActionYet = 0
    InProgress = 1
    Returned = 2
    Completed = 3
    Rejected = 4
End Enum

Public Class EssApprovalHelper

    Public Shared Function GetActionedByName(ByVal status As Int32) As String

        Dim a = DirectCast(status, ESSActionedBy).ToString()

        Return CommonFunctions.AddSpacesToWordGroups(a)

    End Function

    Public Shared Function GetActionedByName(ByVal status As ESSActionedBy) As String

        Dim a = status.ToString()

        Return CommonFunctions.AddSpacesToWordGroups(a)

    End Function

    Public Shared Function CreateCaseQuery(ByVal columnName As String) As String

        Dim returnValue = "CASE"

        For Each enumItem As ESSActionedBy In [Enum].GetValues(GetType(ESSActionedBy))

            If DirectCast(enumItem, Int32) > 0 Then

                returnValue &= " WHEN " & columnName & "=" & DirectCast(enumItem, Int32) & " THEN '" & GetActionedByName(enumItem) & "'"

            End If

        Next

        returnValue &= " ELSE '" & GetActionedByName(DirectCast(0, ESSActionedBy)) & "'"

        Return returnValue & "END"

    End Function

End Class