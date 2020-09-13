Public Class getfile
    Inherits System.Web.UI.Page

    Private DecryptedURL As String = String.Empty

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (Not IsNull(Request.QueryString("params"))) Then

                DecryptedURL = CryptoDecrypt(Request.QueryString("params"), EncPwd, SaltPwd, 5, EncVectorPwd, 256)

                Dim iCount As Byte = 0

                While (Not GetXML(DecryptedURL, KeyName:="param" & iCount.ToString()) = String.Empty)

                    iCount += 1

                End While

                If ((iCount - 1) >= 0) Then

                    Dim Tablename As String = GetXML(DecryptedURL, KeyName:="Tablename")

                    Dim FieldType As String = GetXML(DecryptedURL, KeyName:="FieldType")

                    Dim FieldData As String = GetXML(DecryptedURL, KeyName:="FieldData")

                    iCount -= 1

                    Dim pKey As String = String.Empty

                    Dim pWhere() As String = {String.Empty, String.Empty}

                    Dim pValue As String = String.Empty

                    Dim pValues As String = String.Empty

                    For iLoop As Byte = 0 To iCount

                        pKey = GetXML(DecryptedURL, KeyName:="param" & iLoop.ToString())

                        pValue = GetXML(pKey, "[", "Value", CloseKey:="]")

                        If (IsDate(pValue)) Then

                            pWhere(1) = "convert(nvarchar(19), [" & GetXML(pKey, "[", "Name", CloseKey:="]") & "], 120)"

                            pValue = "'" & Convert.ToDateTime(pValue).ToString("yyyy-MM-dd HH:mm:ss") & "'"

                        Else

                            pWhere(1) = "[" & GetXML(pKey, "[", "Name", CloseKey:="]") & "]"

                            pValue = "'" & GetDataText(pValue) & "'"

                        End If

                        pWhere(0) &= pWhere(1)

                        pValues &= pValue

                        If (iLoop < iCount) Then

                            pWhere(0) &= " + ' ' + "

                            pValues &= " + ' ' + "

                        End If

                    Next

                    If (Tablename.Length > 0 AndAlso FieldType.Length > 0 AndAlso FieldData.Length > 0) Then

                        Dim objFileData() As Object = GetSQLFields("select [" & FieldType & "], [" & FieldData & "] from [" & Tablename & "] where (" & pWhere(0) & " = " & pValues & ")")

                        If (Not IsNull(objFileData)) Then

                            Response.ContentType = GetFileContentType(objFileData(0))

                            Response.BinaryWrite(objFileData(1))

                            Response.End()

                        End If

                    End If

                End If

            End If

        End If

    End Sub

#End Region

End Class