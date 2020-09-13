Imports DevExpress.Web.ASPxUploadControl
Imports System.IO

Public Class picture
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim objManage As Object = Session("Managed")

        If (IsNull(objManage)) Then objManage = Session("LoggedOn")

        If (Not IsPostBack) Then

            With objManage

                Dim objPicture As Object = Nothing

                objPicture = GetSQLField("select [EmployeePicture] from [Personnel] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')", "EmployeePicture")

                If (Not IsNull(objPicture)) Then

                    objPicture = GetThumbnail(objPicture, 120, 160)

                    If (Not IsNull(objPicture)) Then

                        imgPicture.ContentBytes = objPicture

                    Else

                        imgPicture.ContentBytes = Nothing

                    End If

                End If

            End With

        ElseIf (Not IsNull(Session("UploadedFile"))) Then
            'retained for Thumbnail size used in Page.
            imgPicture.ContentBytes = GetThumbnail(Session("UploadedFile").UploadedFiles(0).FileBytes, 120, 160)

            Dim drivePath As String = System.Configuration.ConfigurationManager.AppSettings.Get("SavePathDrive")
            Dim folderPath As String = System.Configuration.ConfigurationManager.AppSettings.Get("SavePathFolder")
            Dim empNum As String = Session("LoggedOn").EmployeeNum.ToString.Trim()
            Dim dateLinked As String = DateTime.UtcNow.ToString("MM/dd/yyyy HH:mm:ss")

            Dim FilePath As String = String.Format("{0}:\{1}\{2}\{3} {4}.jpg",
                                                    drivePath,
                                                    folderPath.Replace("/", "\"),
                                                    empNum,
                                                    empNum,
                                                    dateLinked.Replace(":", String.Empty).Replace("/", String.Empty))

            If (File.Exists(FilePath)) Then File.Delete(FilePath)

            If (Not Directory.Exists(FilePath.Replace(Path.GetFileName(FilePath), String.Empty))) Then Directory.CreateDirectory(FilePath.Replace(Path.GetFileName(FilePath), String.Empty))

            File.WriteAllBytes(FilePath, Session("UploadedFile").UploadedFiles(0).FileBytes)

            FilePath = String.Format("\\{0}\{1}\{2}\{3}",
                                    Server.MachineName,
                                    folderPath.Replace("/", "\"),
                                    empNum,
                                    Path.GetFileName(FilePath))

            Dim dbConnect As SqlClient.SqlConnection = Nothing

            Dim dbCommand As SqlClient.SqlCommand = Nothing

            Dim dbParam As SqlClient.SqlParameter = Nothing

            Dim dbCommand2 As SqlClient.SqlCommand = Nothing

            Try

                dbConnect = New SqlClient.SqlConnection(SQLString)

                dbCommand = New SqlClient.SqlCommand("update [Personnel] set [PictureFile] = '" & FilePath & "', [EmployeePicture] = @Param0 where ([CompanyNum] = '" & objManage.CompanyNum & "' and [EmployeeNum] = '" & objManage.EmployeeNum & "')", dbConnect)
                dbParam = New SqlClient.SqlParameter("@Param0", SqlDbType.VarBinary, imgPicture.ContentBytes.Length, ParameterDirection.Input, False, 0, 0, Nothing, DataRowVersion.Current, imgPicture.ContentBytes)

                '7/2/2018 Inserts new PersonnelDocLink Record of Image for retrieval in Link Docs(Paths are set to Centralized Folder)
                dbCommand2 = New SqlClient.SqlCommand("INSERT INTO [PersonnelDocLink] ([CompanyNum], [EmployeeNum], [Category], [DocDescription], [DocPath], [ESSLinked], [ESSPath], [UserLinked], [DateLinked]) " &
                                                      "VALUES ('" & objManage.CompanyNum & "','" & objManage.EmployeeNum & "','" & "Pictures','" & DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm") & "','" & FilePath & "'," & "1,'" & Replace(Replace(FilePath, String.Format("\\{0}", Server.MachineName), "~"), "\", "/") & "','" & Session("LoggedOn").UserID & "','" & DateTime.Parse(dateLinked).ToString("yyyy-MM-dd HH:mm:ss") & "')",
                                                            dbConnect)

                dbCommand.Parameters.Add(dbParam)

                dbConnect.Open()

                dbCommand.ExecuteNonQuery()
                dbCommand2.ExecuteNonQuery()

            Catch ex As Exception

                If (Not IsNull(dbParam)) Then dbParam = Nothing

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

        End If

    End Sub

    Protected Sub upDocument_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs)

        Session.Remove("UploadedFile")

        If (sender.UploadedFiles.Length > 0) Then Session("UploadedFile") = sender

    End Sub

#End Region

End Class