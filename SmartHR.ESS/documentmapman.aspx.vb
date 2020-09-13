Imports System.IO

Partial Public Class documentmapman
    Inherits System.Web.UI.Page

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        With GetUserDetails(Session, "Document Mapping")

            LoadExpGrid(Session, dgView, "Document Mapping", "<Tablename=ess.Documents><PrimaryKey=[ID]><Columns=[DateLinked], [Category], [Description], [Accepted], [VirtualPath], [DeclinedReason]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [Acknowledged] = 0)>", "Data.Documents." & Session.SessionID)

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim RecordID As String = e.Parameter.Split("[")(1).Replace("]", String.Empty)

        ExecSQL("update [ess.Documents] set [DeclinedReason] = " & IIf(txtDeclineReason.Text.Length = 0, "null", "'" & GetDataText(txtDeclineReason.Text) & "'") & " where ([ID] = " & dgView.GetRowValues(Convert.ToInt32(RecordID) - 1, "CompositeKey") & ")")

    End Sub

    Private Sub cmdRemind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdRemind.Click

        Session("docUnread") = False

        Response.Redirect("tasks.aspx", True)

    End Sub

    Private Sub cmdSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click

        Dim bSaved As Boolean

        For iLoop As Integer = 0 To (dgView.VisibleRowCount - 1)

            bSaved = ExecSQL("update [ess.Documents] set [Acknowledged] = 1, [Accepted] = " & IIf(CType(dgView.FindRowCellTemplateControl(iLoop, CType(dgView.Columns("Accepted"), DevExpress.Web.ASPxGridView.GridViewDataColumn), "chkAccepted"), DevExpress.Web.ASPxEditors.ASPxCheckBox).Checked, "1", "0") & ", [DateRead] = (getdate()) where ([ID] = " & dgView.GetRowValues(iLoop, "CompositeKey") & ")")

            If (Not bSaved) Then Exit For

        Next

        If (bSaved) Then

            ClearFromCache("Data.Documents." & Session.SessionID)

            Session("docUnread") = False

            Response.Redirect("tasks.aspx", True)

        End If

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound

        Dim objValue As Object
        Dim ItemKey As String

        For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

            ItemKey = "Key_" & sender.GetRowValues(iLoop, "CompositeKey")

            If (Not items_001.Contains(ItemKey)) Then

                objValue = sender.GetRowValues(iLoop, "Accepted")

                If (IsNull(objValue)) Then objValue = False

                items_001.Add(ItemKey, objValue)

            End If

        Next

    End Sub

    Private Sub dgView_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles dgView.HtmlRowCreated

        If (e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.Data) Then

            Dim objValue As Object = Nothing

            Dim chkAccepted As DevExpress.Web.ASPxEditors.ASPxCheckBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Accepted"), DevExpress.Web.ASPxGridView.GridViewDataColumn), "chkAccepted"), DevExpress.Web.ASPxEditors.ASPxCheckBox)

            If (Not IsNull(chkAccepted)) Then

                chkAccepted.ClientInstanceName = "chkAccepted_" & e.KeyValue

                objValue = chkAccepted.Checked

                If (items_001.Contains("Key_" & e.KeyValue)) Then

                    objValue = items_001.Get("Key_" & e.KeyValue)

                Else

                    items_001.Add("Key_" & e.KeyValue, objValue)

                End If

                If (Not IsNull(objValue)) Then chkAccepted.Checked = objValue

                chkAccepted.ClientSideEvents.CheckedChanged = "function(s, e) { items_001.Set('Key_" & e.KeyValue & "', chkAccepted_" & e.KeyValue & ".GetChecked()); }"

            End If

        End If

    End Sub

    Protected Function GetClickReason(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Return "function(s, e) { pcReason.SetFooterText('Update record [" & Container.VisibleIndex + 1 & "]'); txtDeclineReason.SetText('" & dgView.GetRowValues(Container.VisibleIndex, "DeclinedReason") & "'); pcReason.Show(); }"

    End Function

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { dgView.SelectRowOnPage(" & Container.VisibleIndex & ", true); window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            If (Container.Grid.GetRowValues(Container.VisibleIndex, "VirtualPath").ToString().Length > 0) Then

                ReturnText = "the file could not be located"

            Else

                ReturnText = "no file attached"

            End If

        End If

        Return ReturnText

    End Function

#End Region

End Class