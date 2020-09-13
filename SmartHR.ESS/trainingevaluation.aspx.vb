Public Class trainingevaluation
    Inherits System.Web.UI.Page

    Private PathID As String
    Private TrainingType As String
    Private ShowPopup As Boolean = False
    Private ResultText As String = String.Empty
    Private EDetails As Users = Nothing
    Private UDetails As Users = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            PathID = String.Empty

            If (Not IsNull(Request.QueryString("ID"))) Then

                PathID = Request.QueryString("ID").ToString()

                hfPathID.Value = PathID

            End If

            ShowTrainingEvaluationSpecificFields()

        End If

        EDetails = GetUserDetails(Session, "Training Tab", True)

        UDetails = GetUserDetails(Session, "Training Tab")

    End Sub

    Protected Sub btnSubmit_001_Click(sender As Object, e As EventArgs) Handles btnSubmit_001.Click

        Dim execString As StringBuilder

        ShowPopup = False

        With EDetails

            If ((Int16.Parse(If(hfExternalTally1.Value = String.Empty, 0, hfExternalTally1.Value)) + Int16.Parse(If(hfExternalTally2.Value = String.Empty, 0, hfExternalTally2.Value)) + Int16.Parse(If(hfExternalTally3.Value = String.Empty, 0, hfExternalTally3.Value)) + Int16.Parse(If(hfExternalTally4.Value = String.Empty, 0, hfExternalTally4.Value))) < 20) Then

                ShowPopup = True

                ResultText = "information Please answer all the required fields!"

            End If

            If (Not ShowPopup) Then

                Dim bSaved As Boolean

                Dim origCompanyNum As String = ""
                Dim origEmployeeNum As String = ""

                Using dtPath As DataTable = GetSQLDT("SELECT OriginatorCompanyNum, OriginatorEmployeeNum FROM [ess.Path] WHERE [ID] = '" & hfPathID.Value & "'")

                    With dtPath.Rows(0)

                        origCompanyNum = .Item("OriginatorCompanyNum").ToString()
                        origEmployeeNum = .Item("OriginatorEmployeeNum").ToString()

                    End With

                    dtPath.Clear()

                End Using

                If origCompanyNum <> "" AndAlso origEmployeeNum <> "" Then

                    Dim PathData As String = GetPathData(hfPathID.Value)

                    execString = New StringBuilder()

                    execString.AppendLine("INSERT INTO [TrainingEvaluationExternal] (")
                    execString.AppendLine("[CompanyNum],")
                    execString.AppendLine("[EmployeeName],")
                    execString.AppendLine("[EmployeeNum],")
                    execString.AppendLine("[CourseName],")
                    execString.AppendLine("[Provider],")
                    execString.AppendLine("[TrainingDate],")
                    execString.AppendLine("[Venue],")
                    execString.AppendLine("[Division],")
                    execString.AppendLine("[Department],")
                    execString.AppendLine("[Section],")
                    execString.AppendLine("[NumberOfParticipants],")
                    execString.AppendLine("[SpeakerName],")
                    execString.AppendLine("[Response_1_1],")
                    execString.AppendLine("[Response_1_2],")
                    execString.AppendLine("[Response_1_3],")
                    execString.AppendLine("[Response_2_1],")
                    execString.AppendLine("[Response_2_2],")
                    execString.AppendLine("[Response_2_3],")
                    execString.AppendLine("[Response_2_4],")
                    execString.AppendLine("[Response_2_5],")
                    execString.AppendLine("[Response_3_1],")
                    execString.AppendLine("[Response_3_2],")
                    execString.AppendLine("[Response_3_3],")
                    execString.AppendLine("[Response_3_4],")
                    execString.AppendLine("[Response_3_5],")
                    execString.AppendLine("[Response_4_1],")
                    execString.AppendLine("[Response_4_2],")
                    execString.AppendLine("[Response_5_1],")
                    execString.AppendLine("[Response_5_2],")
                    execString.AppendLine("[Response_5_3],")
                    execString.AppendLine("[Response_5_4],")
                    execString.AppendLine("[Response_5_5],")
                    execString.AppendLine("[Answer_1],")
                    execString.AppendLine("[Answer_2],")
                    execString.AppendLine("[Answer_3],")
                    execString.AppendLine("[Answer_4],")
                    execString.AppendLine("[Answer_5],")
                    execString.AppendLine("[Answer_6],")
                    execString.AppendLine("[Answer_7],")
                    execString.AppendLine("[DateSubmitted],")
                    execString.AppendLine("[Status],")
                    execString.AppendLine("[PathID]")
                    execString.AppendLine(")")
                    execString.AppendLine("VALUES (")
                    execString.AppendLine("'" & .CompanyNum & "',")
                    execString.AppendLine("'" & txtParticipant_001.Text & "',")
                    execString.AppendLine("'" & .EmployeeNum & "',")
                    execString.AppendLine("'" & txtTrainingProgram_001.Text & "',")
                    execString.AppendLine("'" & txtProvider_001.Text & "',")
                    execString.AppendLine("'" & txtTrainingDate_001.Text.Split("-")(0).Trim() & "',")
                    execString.AppendLine("'" & txtVenue_001.Text & "',")
                    execString.AppendLine("'" & txtDivision_001.Text & "',")
                    execString.AppendLine("'" & txtDepartment_001.Text & "',")
                    execString.AppendLine("'" & txtSection_001.Text & "',")
                    execString.AppendLine("'" & txtNoOfParticipants_001.Text & "',")
                    execString.AppendLine("'" & txtSpeaker_001.Text & "',")
                    execString.AppendLine("'" & If(rbtContent1_001.Checked, 1, If(rbtContent2_001.Checked, 2, If(rbtContent3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtRelevance1_001.Checked, 1, If(rbtRelevance2_001.Checked, 2, If(rbtRelevance3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtCompliance1_001.Checked, 1, If(rbtCompliance2_001.Checked, 2, If(rbtCompliance3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtActivities1_001.Checked, 1, If(rbtActivities2_001.Checked, 2, If(rbtActivities3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtPaceTiming1_001.Checked, 1, If(rbtPaceTiming2_001.Checked, 2, If(rbtPaceTiming3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtClarity1_001.Checked, 1, If(rbtClarity2_001.Checked, 2, If(rbtClarity3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtOrganization1_001.Checked, 1, If(rbtOrganization2_001.Checked, 2, If(rbtOrganization3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtInteraction1_001.Checked, 1, If(rbtInteraction2_001.Checked, 2, If(rbtInteraction3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtKnowledge1_001.Checked, 1, If(rbtKnowledge2_001.Checked, 2, If(rbtKnowledge3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtVoiceClarity1_001.Checked, 1, If(rbtVoiceClarity2_001.Checked, 2, If(rbtVoiceClarity3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtPreparedness1_001.Checked, 1, If(rbtPreparedness2_001.Checked, 2, If(rbtPreparedness3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtAppearance1_001.Checked, 1, If(rbtAppearance2_001.Checked, 2, If(rbtAppearance3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtPresentation1_001.Checked, 1, If(rbtPresentation2_001.Checked, 2, If(rbtPresentation3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtAudioVisual1_001.Checked, 1, If(rbtAudioVisual2_001.Checked, 2, If(rbtAudioVisual3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtHandouts1_001.Checked, 1, If(rbtHandouts2_001.Checked, 2, If(rbtHandouts3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtFood1_001.Checked, 1, If(rbtFood2_001.Checked, 2, If(rbtFood3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtLocation1_001.Checked, 1, If(rbtLocation2_001.Checked, 2, If(rbtLocation3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtVenue1_001.Checked, 1, If(rbtVenue2_001.Checked, 2, If(rbtVenue3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtLighting1_001.Checked, 1, If(rbtLighting2_001.Checked, 2, If(rbtLighting3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & If(rbtTemperature1_001.Checked, 1, If(rbtTemperature2_001.Checked, 2, If(rbtTemperature3_001.Checked, 3, 4))) & "',")
                    execString.AppendLine("'" & memoExt1_001.Text & "',")
                    execString.AppendLine("'" & memoExt2_001.Text & "',")
                    execString.AppendLine("'" & memoExt3_001.Text & "',")
                    execString.AppendLine("'" & memoExt4_001.Text & "',")
                    execString.AppendLine("'" & memoExt5_001.Text & "',")
                    execString.AppendLine("'" & memoExt6_001.Text & "',")
                    execString.AppendLine("'" & memoExt7_001.Text & "',")
                    execString.AppendLine("GetDate(),")
                    execString.AppendLine("'Submitted',")
                    execString.AppendLine("'" & hfPathID.Value & "'")
                    execString.AppendLine(")")

                    bSaved = ExecSQL(execString.ToString())

                    If bSaved Then

                        execString = New StringBuilder()

                        execString.AppendLine("exec [ess.WFProc]")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("" & hfPathID.Value & ",")
                        execString.AppendLine("'Training',")
                        execString.AppendLine("'Evaluation',")
                        execString.AppendLine("'Approve',")
                        execString.AppendLine("'" & GetXML(PathData, KeyName:="ActionType") & "',")
                        execString.AppendLine("'" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        bSaved = ExecSQL(execString.ToString())

                    End If

                Else

                    bSaved = True

                End If

                If (bSaved) Then

                    Response.Redirect("tasks.aspx?Eval=success")

                Else

                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""information Failed to submit the evaluation!"")", True)

                End If

            Else

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

    Protected Sub btnSubmit_002_Click(sender As Object, e As EventArgs) Handles btnSubmit_002.Click

        Dim execString As StringBuilder

        ShowPopup = False

        With EDetails

            'Add Validation Here. Follow the format below
            '       If Condition Then
            '           ShowPopup = True
            '           ResultText = "information *Error Message do not remove information text*"
            '       End If

            If (Not ShowPopup) Then

                Dim bSaved As Boolean

                Dim origCompanyNum As String = ""
                Dim origEmployeeNum As String = ""

                Using dtPath As DataTable = GetSQLDT("SELECT OriginatorCompanyNum, OriginatorEmployeeNum FROM [ess.Path] WHERE [ID] = '" & hfPathID.Value & "'")

                    With dtPath.Rows(0)

                        origCompanyNum = .Item("OriginatorCompanyNum").ToString()
                        origEmployeeNum = .Item("OriginatorEmployeeNum").ToString()

                    End With

                    dtPath.Clear()

                End Using

                If origCompanyNum <> "" AndAlso origEmployeeNum <> "" Then

                    Dim PathData As String = GetPathData(hfPathID.Value)

                    execString = New StringBuilder()

                    execString.AppendLine("INSERT INTO [TrainingEvaluationInHouse] (")
                    execString.AppendLine("[CompanyNum],")
                    execString.AppendLine("[EmployeeName],")
                    execString.AppendLine("[EmployeeNum],")
                    execString.AppendLine("[TrainingDate],")
                    execString.AppendLine("[CourseName],")
                    execString.AppendLine("[Provider],")
                    execString.AppendLine("[Facilitator],")
                    execString.AppendLine("[Division],")
                    execString.AppendLine("[Department],")
                    execString.AppendLine("[Section],")
                    execString.AppendLine("[Response_1_1],")
                    execString.AppendLine("[Strengths_1_1],")
                    execString.AppendLine("[AreasOfImprovement_1_1],")
                    execString.AppendLine("[Response_1_2],")
                    execString.AppendLine("[Strengths_1_2],")
                    execString.AppendLine("[AreasOfImprovement_1_2],")
                    execString.AppendLine("[Response_1_3],")
                    execString.AppendLine("[Strengths_1_3],")
                    execString.AppendLine("[AreasOfImprovement_1_3],")
                    execString.AppendLine("[Response_1_4],")
                    execString.AppendLine("[Strengths_1_4],")
                    execString.AppendLine("[AreasOfImprovement_1_4],")
                    execString.AppendLine("[Response_1_5],")
                    execString.AppendLine("[Strengths_1_5],")
                    execString.AppendLine("[AreasOfImprovement_1_5],")
                    execString.AppendLine("[Response_2_1],")
                    execString.AppendLine("[Strengths_2_1],")
                    execString.AppendLine("[AreasOfImprovement_2_1],")
                    execString.AppendLine("[Response_2_2],")
                    execString.AppendLine("[Strengths_2_2],")
                    execString.AppendLine("[AreasOfImprovement_2_2],")
                    execString.AppendLine("[Response_2_3],")
                    execString.AppendLine("[Strengths_2_3],")
                    execString.AppendLine("[AreasOfImprovement_2_3],")
                    execString.AppendLine("[Response_3_1],")
                    execString.AppendLine("[Strengths_3_1],")
                    execString.AppendLine("[AreasOfImprovement_3_1],")
                    execString.AppendLine("[Response_3_2],")
                    execString.AppendLine("[Strengths_3_2],")
                    execString.AppendLine("[AreasOfImprovement_3_2],")
                    execString.AppendLine("[Response_4_1],")
                    execString.AppendLine("[Strengths_4_1],")
                    execString.AppendLine("[AreasOfImprovement_4_1],")
                    execString.AppendLine("[Response_4_2],")
                    execString.AppendLine("[Strengths_4_2],")
                    execString.AppendLine("[AreasOfImprovement_4_2],")
                    execString.AppendLine("[Response_4_3],")
                    execString.AppendLine("[Strengths_4_3],")
                    execString.AppendLine("[AreasOfImprovement_4_3],")
                    execString.AppendLine("[Response_4_4],")
                    execString.AppendLine("[Strengths_4_4],")
                    execString.AppendLine("[AreasOfImprovement_4_4],")
                    execString.AppendLine("[Response_4_5],")
                    execString.AppendLine("[Strengths_4_5],")
                    execString.AppendLine("[AreasOfImprovement_4_5],")
                    execString.AppendLine("[Response_4_6],")
                    execString.AppendLine("[Strengths_4_6],")
                    execString.AppendLine("[AreasOfImprovement_4_6],")
                    execString.AppendLine("[Response_5_1],")
                    execString.AppendLine("[Strengths_5_1],")
                    execString.AppendLine("[AreasOfImprovement_5_1],")
                    execString.AppendLine("[Remarks],")
                    execString.AppendLine("[DateSubmitted],")
                    execString.AppendLine("[Status],")
                    execString.AppendLine("[PathID]")
                    execString.AppendLine(")")
                    execString.AppendLine("VALUES (")
                    execString.AppendLine("'" & .CompanyNum & "',")
                    execString.AppendLine("'" & txtParticipant_002.Text & "',")
                    execString.AppendLine("'" & .EmployeeNum & "',")
                    execString.AppendLine("'" & txtTrainingDate_002.Text.Split("-")(0).Trim() & "',")
                    execString.AppendLine("'" & txtTrainingProgram_002.Text & "',")
                    execString.AppendLine("'" & txtProvider_002.Text & "',")
                    execString.AppendLine("'" & txtTrainer_002.Text & "',")
                    execString.AppendLine("'" & txtDivision_002.Text & "',")
                    execString.AppendLine("'" & txtDepartment_002.Text & "',")
                    execString.AppendLine("'" & txtSection_002.Text & "',")
                    execString.AppendLine("'" & rbtContentDelivery_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoContentDelivery1_002.Text & "',")
                    execString.AppendLine("'" & memoContentDelivery2_002.Text & "',")
                    execString.AppendLine("'" & rbtContentMastery_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoContentMastery1_002.Text & "',")
                    execString.AppendLine("'" & memoContentMastery2_002.Text & "',")
                    execString.AppendLine("'" & rbtClassInteraction_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoClassInteraction1_002.Text & "',")
                    execString.AppendLine("'" & memoClassInteraction2_002.Text & "',")
                    execString.AppendLine("'" & rbtTimeManagement_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoTimeManagement1_002.Text & "',")
                    execString.AppendLine("'" & memoTimeManagement2_002.Text & "',")
                    execString.AppendLine("'" & rbtProfessionalism_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoProfessionalism1_002.Text & "',")
                    execString.AppendLine("'" & memoProfessionalism2_002.Text & "',")
                    execString.AppendLine("'" & rbtActivitiesWorkshop_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoActivitiesWorkshop1_002.Text & "',")
                    execString.AppendLine("'" & memoActivitiesWorkshop2_002.Text & "',")
                    execString.AppendLine("'" & rbtPaceTiming_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoPaceTiming1_002.Text & "',")
                    execString.AppendLine("'" & memoPaceTiming2_002.Text & "',")
                    execString.AppendLine("'" & rbtContentFlow_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoContentFlow1_002.Text & "',")
                    execString.AppendLine("'" & memoContentFlow2_002.Text & "',")
                    execString.AppendLine("'" & rbtContent_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoContent1_002.Text & "',")
                    execString.AppendLine("'" & memoContent2_002.Text & "',")
                    execString.AppendLine("'" & rbtRelevance_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoRelevance1_002.Text & "',")
                    execString.AppendLine("'" & memoRelevance2_002.Text & "',")
                    execString.AppendLine("'" & rbtTraining_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoTraining1_002.Text & "',")
                    execString.AppendLine("'" & memoTraining2_002.Text & "',")
                    execString.AppendLine("'" & rbtMaterials_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoMaterials1_002.Text & "',")
                    execString.AppendLine("'" & memoMaterials2_002.Text & "',")
                    execString.AppendLine("'" & rbtEquipment_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoEquipment1_002.Text & "',")
                    execString.AppendLine("'" & memoEquipment2_002.Text & "',")
                    execString.AppendLine("'" & rbtVenue_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoVenue1_002.Text & "',")
                    execString.AppendLine("'" & memoVenue2_002.Text & "',")
                    execString.AppendLine("'" & rbtFood_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoFood1_002.Text & "',")
                    execString.AppendLine("'" & memoFood2_002.Text & "',")
                    execString.AppendLine("'" & rbtAdminSupport_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoAdminSupport1_002.Text & "',")
                    execString.AppendLine("'" & memoAdminSupport2_002.Text & "',")
                    execString.AppendLine("'" & rbtOverall_002.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoOverall1_002.Text & "',")
                    execString.AppendLine("'" & memoOverall2_002.Text & "',")
                    execString.AppendLine("'" & memoCommentsSuggestion_002.Text & "',")
                    execString.AppendLine("GetDate(),")
                    execString.AppendLine("'Submitted',")
                    execString.AppendLine("'" & hfPathID.Value & "'")
                    execString.AppendLine(")")

                    bSaved = ExecSQL(execString.ToString())

                    If bSaved Then

                        execString = New StringBuilder()

                        execString.AppendLine("exec [ess.WFProc]")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("" & hfPathID.Value & ",")
                        execString.AppendLine("'Training',")
                        execString.AppendLine("'Evaluation',")
                        execString.AppendLine("'Approve',")
                        execString.AppendLine("'" & GetXML(PathData, KeyName:="ActionType") & "',")
                        execString.AppendLine("'" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        bSaved = ExecSQL(execString.ToString())

                    End If

                Else

                    bSaved = True

                End If

                If (bSaved) Then

                    Response.Redirect("tasks.aspx?Eval=success")

                Else

                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""information Failed to submit the evaluation!"")", True)

                End If

            Else

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

    Protected Sub btnSubmit_003_Click(sender As Object, e As EventArgs) Handles btnSubmit_003.Click

        Dim execString As StringBuilder

        ShowPopup = False

        With EDetails

            'Add Validation Here. Follow the format below
            '       If Condition Then
            '           ShowPopup = True
            '           ResultText = "information *Error Message do not remove information text*"
            '       End If

            If (Not ShowPopup) Then

                Dim bSaved As Boolean

                Dim origCompanyNum As String = ""
                Dim origEmployeeNum As String = ""

                Using dtPath As DataTable = GetSQLDT("SELECT OriginatorCompanyNum, OriginatorEmployeeNum FROM [ess.Path] WHERE [ID] = '" & hfPathID.Value & "'")

                    With dtPath.Rows(0)

                        origCompanyNum = .Item("OriginatorCompanyNum").ToString()
                        origEmployeeNum = .Item("OriginatorEmployeeNum").ToString()

                    End With

                    dtPath.Clear()

                End Using

                If origCompanyNum <> "" AndAlso origEmployeeNum <> "" Then



                    Dim PathData As String = GetPathData(hfPathID.Value)

                    execString = New StringBuilder()

                    execString.AppendLine("INSERT INTO [TrainingEvaluationOverseas] (")
                    execString.AppendLine("[CompanyNum],")
                    execString.AppendLine("[EmployeeName],")
                    execString.AppendLine("[EmployeeNum],")
                    execString.AppendLine("[CourseName],")
                    execString.AppendLine("[TrainingDate],")
                    execString.AppendLine("[Item1_1_Response],")
                    execString.AppendLine("[Item1_1_Explanation],")
                    execString.AppendLine("[Item1_1_Strengths],")
                    execString.AppendLine("[Item1_1_Improvements],")
                    execString.AppendLine("[Item1_2_Response],")
                    execString.AppendLine("[Item1_2_Comments],")
                    execString.AppendLine("[Item1_3_Response],")
                    execString.AppendLine("[Item1_3_Comments],")
                    execString.AppendLine("[Item2_Superior],")
                    execString.AppendLine("[Item2_Subordinates],")
                    execString.AppendLine("[Item2_Colleagues],")
                    execString.AppendLine("[Item2_1_Response],")
                    execString.AppendLine("[Item2_1_Comments],")
                    execString.AppendLine("[Item2_2_Response],")
                    execString.AppendLine("[Item2_2_Comments],")
                    execString.AppendLine("[Item3_1_Response],")
                    execString.AppendLine("[Item3_1_Explanation],")
                    execString.AppendLine("[Item3_1_Strengths],")
                    execString.AppendLine("[Item3_1_Improvements],")
                    execString.AppendLine("[Item3_2_Response],")
                    execString.AppendLine("[Item3_2_Comments],")
                    execString.AppendLine("[Item3_3_Response],")
                    execString.AppendLine("[Item3_3_Comments],")
                    execString.AppendLine("[Item3_4_Response],")
                    execString.AppendLine("[Item3_4_Comments],")
                    execString.AppendLine("[Item3_5_Response],")
                    execString.AppendLine("[Item3_5_Comments],")
                    execString.AppendLine("[Item3_6_Response],")
                    execString.AppendLine("[Item3_6_Comments],")
                    execString.AppendLine("[Item3_7_Response],")
                    execString.AppendLine("[Item3_7_Comments],")
                    execString.AppendLine("[Item3_8_Response],")
                    execString.AppendLine("[Item3_8_Comments],")
                    execString.AppendLine("[Item4_1_Response],")
                    execString.AppendLine("[Item4_1_Comments],")
                    execString.AppendLine("[Item4_2_Response],")
                    execString.AppendLine("[Item4_2_Comments],")
                    execString.AppendLine("[Item4_3_Response],")
                    execString.AppendLine("[Item4_3_Comments],")
                    execString.AppendLine("[Item4_4_Response],")
                    execString.AppendLine("[Item4_4_Comments],")
                    execString.AppendLine("[Item4_5_Response],")
                    execString.AppendLine("[Item4_5_Comments],")
                    execString.AppendLine("[Item4_6_Response],")
                    execString.AppendLine("[Item4_6_Comments],")
                    execString.AppendLine("[Item4_7_HospitalName],")
                    execString.AppendLine("[Item4_7_Response],")
                    execString.AppendLine("[Item4_7_Comments],")
                    execString.AppendLine("[Item4_8_TotalVisits],")
                    execString.AppendLine("[Item4_8_VisitsReason],")
                    execString.AppendLine("[Item5_HostDivision],")
                    execString.AppendLine("[Item5_HostHR],")
                    execString.AppendLine("[Item5_HomeDivision],")
                    execString.AppendLine("[Item5_HomeHR],")
                    execString.AppendLine("[DateSubmitted],")
                    execString.AppendLine("[Status],")
                    execString.AppendLine("[PathID]")
                    execString.AppendLine(")")
                    execString.AppendLine("VALUES (")
                    execString.AppendLine("'" & .CompanyNum & "',")
                    execString.AppendLine("'" & txtParticipant_003.Text & "',")
                    execString.AppendLine("'" & .EmployeeNum & "',")
                    execString.AppendLine("'" & txtTrainingProgram_003.Text & "',")
                    execString.AppendLine("'" & txtTrainingDate_003.Text.Split("-")(0).Trim() & "',")
                    execString.AppendLine("'" & rblExposure1_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoExposure1_003.Text & "',")
                    execString.AppendLine("'" & memoExposure2_003.Text & "',")
                    execString.AppendLine("'" & memoExposure3_003.Text & "',")
                    execString.AppendLine("'" & rblExperience_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoExperience_003.Text & "',")
                    execString.AppendLine("'" & rblExposureLevel_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoExposureLevel_003.Text & "',")
                    execString.AppendLine("'" & memoSuperior_003.Text & "',")
                    execString.AppendLine("'" & memoSubordinates_003.Text & "',")
                    execString.AppendLine("'" & memoColleagues_003.Text & "',")
                    execString.AppendLine("'" & rblAssignedGroup_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoAssignedGroup_003.Text & "',")
                    execString.AppendLine("'" & rblInterGroup_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoInterGroup_003.Text & "',")
                    execString.AppendLine("'" & rblHousing_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoHousing1_003.Text & "',")
                    execString.AppendLine("'" & memoHousing2_003.Text & "',")
                    execString.AppendLine("'" & memoHousing3_003.Text & "',")
                    execString.AppendLine("'" & rblComfort_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoComfort_003.Text & "',")
                    execString.AppendLine("'" & rblAccessibility_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoAccessibility_003.Text & "',")
                    execString.AppendLine("'" & rblCustomerService_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoCustomerService_003.Text & "',")
                    execString.AppendLine("'" & rblSecurity_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoSecurity_003.Text & "',")
                    execString.AppendLine("'" & rblAmenities_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoAmenities_003.Text & "',")
                    execString.AppendLine("'" & rblAmbience_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoAmbience.Text & "',")
                    execString.AppendLine("'" & rblRecommend_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoRecommend_003.Text & "',")
                    execString.AppendLine("'" & rblLevelOfSupport_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoLevelOfSupport_003.Text & "',")
                    execString.AppendLine("'" & rblCarCondition_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoCarCondition_003.Text & "',")
                    execString.AppendLine("'" & rblDriver_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoDriver_003.Text & "',")
                    execString.AppendLine("'" & rblPhonePlan_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoPhonePlan_003.Text & "',")
                    execString.AppendLine("'" & rblEducationSupport_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoEducationSupport_003.Text & "',")
                    execString.AppendLine("'" & rblSchool_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoSchool_003.Text & "',")
                    execString.AppendLine("'" & txtHospital_003.Text & "',")
                    execString.AppendLine("'" & rblHospital_003.SelectedItem.Value & "',")
                    execString.AppendLine("'" & memoHospital_003.Text & "',")
                    execString.AppendLine("'" & txtVisits_003.Text & "',")
                    execString.AppendLine("'" & memoVisits_003.Text & "',")
                    execString.AppendLine("'" & memoHostDivision_003.Text & "',")
                    execString.AppendLine("'" & memoHostHR_003.Text & "',")
                    execString.AppendLine("'" & memoHomeDivision_003.Text & "',")
                    execString.AppendLine("'" & memoHomeHR.Text & "',")
                    execString.AppendLine("GetDate(),")
                    execString.AppendLine("'Submitted',")
                    execString.AppendLine("'" & hfPathID.Value & "'")
                    execString.AppendLine(")")

                    bSaved = ExecSQL(execString.ToString())

                    If bSaved Then

                        execString = New StringBuilder()

                        execString.AppendLine("exec [ess.WFProc]")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("'" & origCompanyNum & "',")
                        execString.AppendLine("'" & origEmployeeNum & "',")
                        execString.AppendLine("" & hfPathID.Value & ",")
                        execString.AppendLine("'Training',")
                        execString.AppendLine("'Evaluation',")
                        execString.AppendLine("'Approve',")
                        execString.AppendLine("'" & GetXML(PathData, KeyName:="ActionType") & "',")
                        execString.AppendLine("'" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                        bSaved = ExecSQL(execString.ToString())

                    End If

                Else

                    bSaved = True

                End If

                If (bSaved) Then

                    Response.Redirect("tasks.aspx?Eval=success")

                Else

                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""information Failed to submit the evaluation!"")", True)

                End If

            Else

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

    Private Sub ShowTrainingEvaluationSpecificFields()

        Dim dtColumns As DataTable = GetSQLDT("SELECT TOP 1 te.[TrainingType] FROM TrainingEvaluation te WHERE te.[PathID] = '" & PathID & "'")

        If (IsData(dtColumns)) Then

            With dtColumns.Rows(0)

                TrainingType = .Item("TrainingType").ToString()

                Select Case TrainingType

                    Case "1"

                        pnlInHouse.Visible = True
                        PopulateInHouseTrainingEvaluationForm()

                    Case "2"

                        pnlExternal.Visible = True
                        PopulateExternalTrainingEvaluationForm()

                    Case "3"

                        pnlOverseas.Visible = True
                        PopulateOverseasTrainingEvaluationForm()

                End Select

            End With

            dtColumns.Dispose()

        End If

        dtColumns = Nothing

    End Sub

    Private Sub PopulateInHouseTrainingEvaluationForm()

        Try

            Dim dtColumns As DataTable = GetSQLDT("SELECT TOP 1 pt.[OriginatorEmployeeNum] [EmployeeNum], CASE WHEN pers.[MiddleName] IS NOT NULL AND pers.[FirstName] IS NOT NULL AND pers.[Surname] IS NOT NULL THEN pers.[Surname] + ', ' + pers.[FirstName] + ' ' + SUBSTRING(pers.[MiddleName], 1, 1) + '.' ELSE pers.[Surname] + ', ' + pers.[FirstName] END [Fullname], eval.[CourseName], eval.[ProviderName] [Provider], eval.[StartDate], eval.[EndDate], tp.[Mentor] [Facilitator], com.[Division], com.[SubDivision] [Department], com.[SubSubDivision] [Section] FROM [ess.Path] pt INNER JOIN Personnel pers ON pt.[OriginatorEmployeeNum] = pers.[EmployeeNum] INNER JOIN TrainingEvaluation eval ON pt.[ID] = eval.[PathID] LEFT JOIN TrainingPlan tp ON pt.[OriginatorEmployeeNum] = tp.[EmployeeNum] LEFT JOIN Company com ON pt.[OriginatorCompanyNum] = com.[CompanyNum] WHERE pt.[ID] = '" & PathID & "'")

            If (IsData(dtColumns)) Then

                With dtColumns.Rows(0)

                    txtIDNum_002.Text = .Item("EmployeeNum").ToString()

                    txtParticipant_002.Text = .Item("Fullname").ToString()

                    txtTrainingProgram_002.Text = .Item("CourseName").ToString()

                    txtProvider_002.Text = .Item("Provider").ToString()

                    txtTrainingDate_002.Text = String.Format("{0} - {1}", .Item("StartDate").ToString(), .Item("EndDate").ToString())

                    txtTrainer_002.Text = .Item("Facilitator").ToString()

                    txtDivision_002.Text = .Item("Division").ToString()

                    txtDepartment_002.Text = .Item("Department").ToString()

                    txtSection_002.Text = .Item("Section").ToString()

                End With

                dtColumns.Dispose()

            End If

            dtColumns = Nothing

        Catch ex As Exception

            Throw ex

        End Try

    End Sub

    Private Sub PopulateExternalTrainingEvaluationForm()

        Try

            Dim dtColumns As DataTable = GetSQLDT("SELECT pt.[OriginatorEmployeeNum] [EmployeeNum], CASE WHEN pers.[MiddleName] IS NOT NULL AND pers.[FirstName] IS NOT NULL AND pers.[Surname] IS NOT NULL THEN pers.[Surname] + ', ' + pers.[FirstName] + ' ' + SUBSTRING(pers.[MiddleName], 1, 1) + '.' ELSE pers.[Surname] + ', ' + pers.[FirstName] END [Fullname], eval.[CourseName], eval.[ProviderName] [Provider], eval.[StartDate], tp.[Mentor] [Facilitator], (cd.[Slots] - cd.[RemainingSlots]) [Participants], tc.[VenueName] [Venue], com.[Division], com.[SubDivision] [Department], com.[SubSubDivision] [Section] FROM [ess.Path] pt INNER JOIN Personnel pers ON pt.[OriginatorEmployeeNum] = pers.[EmployeeNum] INNER JOIN TrainingEvaluation eval ON pt.[ID] = eval.[PathID] LEFT JOIN TrainingPlan tp ON pt.[OriginatorEmployeeNum] = tp.[EmployeeNum] LEFT JOIN Company com ON pt.[OriginatorCompanyNum] = com.[CompanyNum] LEFT JOIN CourseDatesLU cd ON eval.[StartDate] = cd.[DateFrom] AND eval.[EndDate] = cd.[DateTo] AND eval.[CourseName] = cd.[CourseName] AND eval.[ProviderName] = cd.[ProviderName] LEFT JOIN TrainingCompleted tc ON pt.[OriginatorEmployeeNum] = tc.[EmployeeNum] AND pt.[OriginatorCompanyNum] = tc.[CompanyNum] AND eval.[CourseName] = tc.[CourseName] WHERE pt.[ID] = '" & PathID & "'")

            If (IsData(dtColumns)) Then

                With dtColumns.Rows(0)

                    txtID_001.Text = .Item("EmployeeNum").ToString()

                    txtParticipant_001.Text = .Item("Fullname").ToString()

                    txtProvider_001.Text = .Item("Provider").ToString()

                    txtTrainingProgram_001.Text = .Item("CourseName").ToString()

                    txtTrainingDate_001.Text = .Item("StartDate").ToString()

                    txtSpeaker_001.Text = .Item("Facilitator").ToString()

                    txtNoOfParticipants_001.Text = .Item("Participants").ToString()

                    txtVenue_001.Text = .Item("Venue").ToString()

                    txtDivision_001.Text = .Item("Division").ToString()

                    txtDepartment_001.Text = .Item("Department").ToString()

                    txtSection_001.Text = .Item("Section").ToString()

                End With

                dtColumns.Dispose()

            End If

            dtColumns = Nothing

        Catch ex As Exception

            Throw ex

        End Try

    End Sub

    Private Sub PopulateOverseasTrainingEvaluationForm()

        Try

            Dim dtColumns As DataTable = GetSQLDT("SELECT TOP 1 eval.[EmployeeNum], CASE WHEN pers.[MiddleName] IS NOT NULL AND pers.[FirstName] IS NOT NULL AND pers.[Surname] IS NOT NULL THEN pers.[Surname] + ', ' + pers.[FirstName] + ' ' + SUBSTRING(pers.[MiddleName], 1, 1) + '.' ELSE pers.[Surname] + ', ' + pers.[FirstName] END [Fullname], eval.[CourseName], eval.[StartDate], eval.[EndDate] FROM TrainingEvaluation eval INNER JOIN Personnel pers ON eval.EmployeeNum = pers.EmployeeNum WHERE eval.[PathID] = '" & PathID & "'")

            If (IsData(dtColumns)) Then

                With dtColumns.Rows(0)

                    txtIDNum_003.Text = .Item("EmployeeNum").ToString()

                    txtParticipant_003.Text = .Item("Fullname").ToString()

                    txtTrainingProgram_003.Text = .Item("CourseName").ToString()

                    txtTrainingDate_003.Text = String.Format("{0} - {1}", .Item("StartDate").ToString(), .Item("EndDate").ToString())


                End With

                dtColumns.Dispose()

            End If

            dtColumns = Nothing

        Catch ex As Exception

            Throw ex

        End Try

    End Sub

End Class