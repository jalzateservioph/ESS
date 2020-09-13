Imports DevExpress.Web.ASPxGridView.Export
Imports System.Web.HttpUtility

Partial Public Class training
    Inherits System.Web.UI.Page

    Private cpHtmlText As String = String.Empty
    Private cpShowDetails As Boolean = False
    Private CancelEdit As Boolean
    Private ResultText As String = String.Empty
    Private ShowPopup As Boolean = False
    Private UDetails As Users = Nothing
    Private EDetails As Users = Nothing
    Dim editingKeyValue As String = ""

#Region " *** Web Form Functions *** "

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        Dim OnOffer As Boolean

        With UDetails

            Select Case tabTraining.ActiveTabIndex

                Case 0 ' Training Curriculum

                    If (Not IsNull(GetArrayItem(Nothing, "eTraining.OnOffer"))) Then OnOffer = Convert.ToBoolean(GetArrayItem(Nothing, "eTraining.OnOffer"))

                    ClearFromCache("Data.Training.TrainingCurriculum." & Session.SessionID)

                    ClearFromCache("Data.Training.Local." & Session.SessionID)

                    ClearFromCache("Data.Training.External." & Session.SessionID)

                    ClearFromCache("Data.Training.Overseas." & Session.SessionID)

                    LoadExpDS(
                        dsCourseLU_External,
                        "SELECT " +
                        "   DISTINCT " +
                        "   [CourseName] " +
                        "FROM [CourseLU] C " +
                        "INNER JOIN [Personnel1] P " +
                        "   ON C.[JobTitles] LIKE '%|' + p.[IndividualJobTitle] + '|%' " +
                        "   OR C.[JOBTITLES] = '' " +
                        "   OR C.[JOBTITLES] IS NULL " +
                        "WHERE P.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "ORDER BY C.[COURSENAME]")

                    LoadExpDS(
                        dsCourseLU_Overseas,
                        "SELECT " +
                        "   DISTINCT " +
                        "   [CourseName] " +
                        "FROM [CourseLU] C " +
                        "INNER JOIN [Personnel1] P " +
                        "   ON C.[JobTitles] LIKE '%|' + p.[IndividualJobTitle] + '|%' " +
                        "   OR C.[JOBTITLES] = '' " +
                        "   OR C.[JOBTITLES] IS NULL " +
                        "WHERE P.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND C.[Overseas] = 1 " +
                        "ORDER BY C.[COURSENAME]")

                    dgView_008.SettingsText.Title = "<Required=[CourseName][ProviderName]>"

                    dgView_009.SettingsText.Title = "<Required=[CourseName][ProviderName]>"

                    LoadExpGrid(
                        Session, dgView_006, "Training Tab",
                        "<<CustomSelectQuery=" +
                        "SELECT * " +
                        "FROM ( " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TP.[CompanyNum] + ' ' + " +
                        "        TP.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TP.[StartDate], 120) + ' ' + " +
                        "        TP.[CourseName] + ' ' + " +
                        "        TP.[ProviderName], " +
                        "    [CourseName] = TP.[CourseName], " +
                        "    [DateRegistered] = TP.[StartDate], " +
                        "    [StartDate] = TP.[StartDate], " +
                        "    [CompletionDate] = TP.[CompletionDate], " +
                        "    [ProviderName] = TP.[ProviderName], " +
                        "    [VenueName] = TP.[VenueName], " +
                        "    [TrainingStatus] = TP.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = NULL, " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "LEFT JOIN TrainingCompleted TC " +
                        "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " +
                        "   AND TC.[CompanyNum] = TP.[CompanyNum] " +
                        "   AND TC.[CourseName] = TP.[CourseName] " +
                        "   AND TC.[ProviderName] = TP.[ProviderName] " +
                        "   AND TC.[StartDate] = TP.[StartDate] " +
                        "WHERE TP.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TP.[CourseName] IS NOT NULL " +
                        "  AND TP.[CourseName] <> '' " +
                        "  AND TC.[CompanyNum] IS NULL " +
                        "UNION ALL " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TC.[CompanyNum] + ' ' + " +
                        "        TC.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                        "        TC.[CourseName] + ' ' + " +
                        "        TC.[ProviderName], " +
                        "    [CourseName] = TC.[CourseName], " +
                        "    [DateRegistered] = NULL, " +
                        "    [StartDate] = TC.[StartDate], " +
                        "    [CompletionDate] = TC.[CompletionDate], " +
                        "    [ProviderName] = TC.[ProviderName], " +
                        "    [VenueName] = TC.[VenueName], " +
                        "    [TrainingStatus] = ISNULL(TC.[TrainingStatus], 'Completed'), " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = " +
                        "       ISNULL(" +
                        "       CASE  " +
                        "           WHEN TE.[TrainingType] = '1' THEN (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationInHouse TEI WHERE TEI.[PathID] = TE.[PathID]) " +
                        "           WHEN TE.[TrainingType] = '2' THEN (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationExternal TEE WHERE TEE.[PathID] = TE.[PathID]) " +
                        "           WHEN TE.[TrainingType] = '3' THEN (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationOverseas TEO WHERE TEO.[PathID] = TE.[PathID]) " +
                        "       END, CASE WHEN TE.[PathID] IS NOT NULL THEN 'Assigned' ELSE 'Pending' END), " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "LEFT JOIN TrainingEvaluation TE " +
                        "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " +
                        "   AND TE.[CompanyNum] = TC.[CompanyNum] " +
                        "   AND TE.[CourseName] = TC.[CourseName] " +
                        "   AND TE.[ProviderName] = TC.[ProviderName] " +
                        "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        ") T " +
                        "ORDER BY [SequenceNum], [StartDate] DESC " +
                        ">>", "Data.Training.TrainingCurriculum." & Session.SessionID)

                    LoadExpGrid(
                        Session, dgView_007, "Training Tab",
                        "<<CustomSelectQuery=" +
                        "SELECT * " +
                        "FROM ( " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TP.[CompanyNum] + ' ' + " +
                        "        TP.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TP.[StartDate], 120) + ' ' + " +
                        "        TP.[CourseName] + ' ' + " +
                        "        TP.[ProviderName], " +
                        "    [CourseName] = TP.[CourseName], " +
                        "    [DateRegistered] = NULL, " +
                        "    [StartDate] = TP.[StartDate], " +
                        "    [CompletionDate] = TP.[CompletionDate], " +
                        "    [ProviderName] = TP.[ProviderName], " +
                        "    [VenueName] = TP.[VenueName], " +
                        "    [TrainingStatus] = TP.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = NULL, " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "LEFT JOIN TrainingCompleted TC " +
                        "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " +
                        "   AND TC.[CompanyNum] = TP.[CompanyNum] " +
                        "   AND TC.[CourseName] = TP.[CourseName] " +
                        "   AND TC.[ProviderName] = TP.[ProviderName] " +
                        "   AND TC.[StartDate] = TP.[StartDate] " +
                        "WHERE TP.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TP.[CourseName] IS NOT NULL " +
                        "  AND TP.[CourseName] <> '' " +
                        "  AND C.[InternalCourse] = 1 " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "  AND TC.[CompanyNum] IS NULL " +
                        "UNION ALL " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TC.[CompanyNum] + ' ' + " +
                        "        TC.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                        "        TC.[CourseName] + ' ' + " +
                        "        TC.[ProviderName], " +
                        "    [CourseName] = TC.[CourseName], " +
                        "    [DateRegistered] = NULL, " +
                        "    [StartDate] = TC.[StartDate], " +
                        "    [CompletionDate] = TC.[CompletionDate], " +
                        "    [ProviderName] = TC.[ProviderName], " +
                        "    [VenueName] = TC.[VenueName], " +
                        "    [TrainingStatus] = ISNULL(TC.[TrainingStatus], 'Completed'), " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = " +
                        "       ISNULL(" +
                        "       (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationInHouse TEI WHERE TEI.[PathID] = TE.[PathID]), " +
                        "       CASE WHEN TE.[PathID] IS NOT NULL THEN 'Assigned' ELSE 'Pending' END), " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "LEFT JOIN TrainingEvaluation TE " +
                        "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " +
                        "   AND TE.[CompanyNum] = TC.[CompanyNum] " +
                        "   AND TE.[CourseName] = TC.[CourseName] " +
                        "   AND TE.[ProviderName] = TC.[ProviderName] " +
                        "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        "  AND C.[InternalCourse] = 1 " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        ") T " +
                        "ORDER BY [StartDate] DESC " +
                        ">>", "Data.Training.Local." & Session.SessionID)

                    LoadExpGrid(
                        Session, dgView_008, "Training Tab",
                        "<<CustomSelectQuery=" +
                        "SELECT * " +
                        "FROM ( " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TP.[CompanyNum] + ' ' + " +
                        "        TP.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TP.[StartDate], 120) + ' ' + " +
                        "        TP.[CourseName] + ' ' + " +
                        "        TP.[ProviderName], " +
                        "    [CourseName] = TP.[CourseName], " +
                        "    [DateRegistered] = TAF.[CapturedOn], " +
                        "    [StartDate] = TAD.[DateFrom], " +
                        "    [CompletionDate] = TAD.[DateTo], " +
                        "    [ProviderName] = TP.[ProviderName], " +
                        "    [VenueName] = TP.[VenueName], " +
                        "    [TrainingStatus] = TP.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = NULL, " +
                        "    [PathID] = TP.[PathID], " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "LEFT JOIN TrainingAgreementForm TAF " +
                        "    ON TP.[PathID] = TAF.[PathID] " +
                        "LEFT JOIN TAFProgramDetails TAD " +
                        "    ON TAF.[TAFID] = TAD.[TAFID] " +
                        "LEFT JOIN TrainingCompleted TC " +
                        "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " +
                        "   AND TC.[CompanyNum] = TP.[CompanyNum] " +
                        "   AND TC.[CourseName] = TP.[CourseName] " +
                        "   AND TC.[ProviderName] = TP.[ProviderName] " +
                        "   AND TC.[StartDate] = TP.[StartDate] " +
                        "WHERE TP.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TP.[CourseName] IS NOT NULL " +
                        "  AND TP.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "  AND TC.[CompanyNum] IS NULL " +
                        "UNION ALL " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TC.[CompanyNum] + ' ' + " +
                        "        TC.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                        "        TC.[CourseName] + ' ' + " +
                        "        TC.[ProviderName], " +
                        "    [CourseName] = TC.[CourseName], " +
                        "    [DateRegistered] = TAF.[CapturedOn], " +
                        "    [StartDate] = TAD.[DateFrom], " +
                        "    [CompletionDate] = TAD.[DateTo], " +
                        "    [ProviderName] = TC.[ProviderName], " +
                        "    [VenueName] = TC.[VenueName], " +
                        "    [TrainingStatus] = TC.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = " +
                        "       ISNULL(" +
                        "       (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationExternal TEE WHERE TEE.[PathID] = TE.[PathID]), " +
                        "       CASE WHEN TE.[PathID] IS NOT NULL THEN 'Assigned' ELSE 'Pending' END), " +
                        "    [PathID] = TC.[PathID], " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "LEFT JOIN TrainingAgreementForm TAF " +
                        "    ON TC.[PathID] = TAF.[PathID] " +
                        "LEFT JOIN TAFProgramDetails TAD " +
                        "    ON TAF.[TAFID] = TAD.[TAFID] " +
                        "LEFT JOIN TrainingEvaluation TE " +
                        "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " +
                        "   AND TE.[CompanyNum] = TC.[CompanyNum] " +
                        "   AND TE.[CourseName] = TC.[CourseName] " +
                        "   AND TE.[ProviderName] = TC.[ProviderName] " +
                        "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        ") T " +
                        "ORDER BY [StartDate] DESC " +
                        ">>", "Data.Training.External." & Session.SessionID)

                    'LoadExpGrid(
                    '    Session, dgView_008, "Training Tab",
                    '    "<CustomSelectQuery=" +
                    '    "SELECT * " +
                    '    "FROM ( " +
                    '    "SELECT " +
                    '    "    [CompositeKey] = " +
                    '    "        TP.[CompanyNum] + ' ' + " +
                    '    "        TP.[EmployeeNum] + ' ' + " +
                    '    "        CONVERT(NVARCHAR(19), TP.[StartDate], 120) + ' ' + " +
                    '    "        TP.[CourseName] + ' ' + " +
                    '    "        TP.[ProviderName], " +
                    '    "    [CourseName] = TP.[CourseName], " +
                    '    "    [DateRegistered] = TP.[StartDate], " +
                    '    "    [StartDate] = TP.[StartDate], " +
                    '    "    [CompletionDate] = TP.[CompletionDate], " +
                    '    "    [ProviderName] = TP.[ProviderName], " +
                    '    "    [VenueName] = TP.[VenueName], " +
                    '    "    [TrainingStatus] = TP.[TrainingStatus], " +
                    '    "    [Remarks] = NULL, " +
                    '    "    [Evaluated] = NULL, " +
                    '    "    [SequenceNum] = C.[SequenceNum] " +
                    '    "FROM TrainingPlanned TP " +
                    '    "INNER JOIN CourseLU C " +
                    '    "    ON C.[CourseName] = TP.[CourseName] " +
                    '    "WHERE TP.[CompanyNum] = '" & .CompanyNum & "' " +
                    '    "  AND TP.[EmployeeNum] = '" & .EmployeeNum & "' " +
                    '    "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                    '    "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                    '    "UNION ALL " +
                    '    "SELECT " +
                    '    "    [CompositeKey] = " +
                    '    "        TC.[CompanyNum] + ' ' + " +
                    '    "        TC.[EmployeeNum] + ' ' + " +
                    '    "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                    '    "        TC.[CourseName] + ' ' + " +
                    '    "        TC.[ProviderName], " +
                    '    "    [CourseName] = TC.[CourseName], " +
                    '    "    [DateRegistered] = TC.[StartDate], " +
                    '    "    [StartDate] = TC.[StartDate], " +
                    '    "    [CompletionDate] = TC.[CompletionDate], " +
                    '    "    [ProviderName] = TC.[ProviderName], " +
                    '    "    [VenueName] = TC.[VenueName], " +
                    '    "    [TrainingStatus] = TC.[TrainingStatus], " +
                    '    "    [Remarks] = NULL, " +
                    '    "    [Evaluated] = " +
                    '    "    (ISNULL( " +
                    '    "    (SELECT TOP 1 " +
                    '    "        CASE " +
                    '    "            WHEN COUNT(*) = 1 " +
                    '    "                THEN (SELECT 'Completed') " +
                    '    "            ELSE " +
                    '    "                (SELECT 'Assigned') " +
                    '    "        END " +
                    '    "    FROM TrainingEvaluationExternal TEE " +
                    '    "    WHERE TEE.[PathID] = TE.[PathID] " +
                    '    "    GROUP BY TEE.[PathID]) " +
                    '    "    , (SELECT 'Pending'))), " +
                    '    "    [SequenceNum] = C.[SequenceNum] " +
                    '    "FROM TrainingCompleted TC " +
                    '    "INNER JOIN CourseLU C " +
                    '    "    ON C.[CourseName] = TC.[CourseName] " +
                    '    "LEFT JOIN TrainingEvaluation TE " +
                    '    "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " +
                    '    "    AND TE.[CompanyNum] = TC.[CompanyNum] " +
                    '    "    AND TE.[CourseName] = TC.[CourseName] " +
                    '    "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                    '    "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                    '    "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                    '    "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                    '    ") T " +
                    '    "ORDER BY [StartDate] DESC " +
                    '    ">", "Data.Training.External." & Session.SessionID)

                    LoadExpGrid(
                        Session, dgView_009, "Training Tab",
                        "<<CustomSelectQuery=" +
                        "SELECT * " +
                        "FROM ( " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TP.[CompanyNum] + ' ' + " +
                        "        TP.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TP.[StartDate], 120) + ' ' + " +
                        "        TP.[CourseName] + ' ' + " +
                        "        TP.[ProviderName], " +
                        "    [CourseName] = TP.[CourseName], " +
                        "    [DateRegistered] = TP.[StartDate], " +
                        "    [StartDate] = TP.[StartDate], " +
                        "    [CompletionDate] = TP.[CompletionDate], " +
                        "    [ProviderName] = TP.[ProviderName], " +
                        "    [VenueName] = TP.[VenueName], " +
                        "    [TrainingStatus] = TP.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = NULL, " +
                        "    [PathID] = TP.[PathID], " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "LEFT JOIN TrainingCompleted TC " +
                        "    ON TC.[EmployeeNum] = TP.[EmployeeNum] " +
                        "   AND TC.[CompanyNum] = TP.[CompanyNum] " +
                        "   AND TC.[CourseName] = TP.[CourseName] " +
                        "   AND TC.[ProviderName] = TP.[ProviderName] " +
                        "   AND TC.[StartDate] = TP.[StartDate] " +
                        "WHERE TP.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TP.[CourseName] IS NOT NULL " +
                        "  AND TP.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND C.[Overseas] = 1 " +
                        "  AND TC.[CompanyNum] IS NULL " +
                        "UNION ALL " +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TC.[CompanyNum] + ' ' + " +
                        "        TC.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                        "        TC.[CourseName] + ' ' + " +
                        "        TC.[ProviderName], " +
                        "    [CourseName] = TC.[CourseName], " +
                        "    [DateRegistered] = TC.[StartDate], " +
                        "    [StartDate] = TC.[StartDate], " +
                        "    [CompletionDate] = TC.[CompletionDate], " +
                        "    [ProviderName] = TC.[ProviderName], " +
                        "    [VenueName] = TC.[VenueName], " +
                        "    [TrainingStatus] = TC.[TrainingStatus], " +
                        "    [Remarks] = NULL, " +
                        "    [Evaluated] = " +
                        "       ISNULL(" +
                        "       (SELECT TOP 1 CASE WHEN COUNT(*) = 1 THEN 'Completed' END FROM TrainingEvaluationOverseas TEO WHERE TEO.[PathID] = TE.[PathID]), " +
                        "       CASE WHEN TE.[PathID] IS NOT NULL THEN 'Assigned' ELSE 'Pending' END), " +
                        "    [PathID] = TC.[PathID], " +
                        "    [SequenceNum] = C.[SequenceNum] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "LEFT JOIN TrainingEvaluation TE " +
                        "    ON TE.[EmployeeNum] = TC.[EmployeeNum] " +
                        "   AND TE.[CompanyNum] = TC.[CompanyNum] " +
                        "   AND TE.[CourseName] = TC.[CourseName] " +
                        "   AND TE.[ProviderName] = TC.[ProviderName] " +
                        "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND C.[Overseas] = 1 " +
                        ") T " +
                        "ORDER BY [StartDate] DESC " +
                        ">>", "Data.Training.Overseas." & Session.SessionID)

                Case 1 ' Planned

                    If (ClearCache) Then

                        ClearFromCache("Data.Training.Planned." & Session.SessionID)

                        ClearFromCache("Data.Training.Planned.Requests." & Session.SessionID)

                    End If

                    LoadExpGrid(Session, dgView_001, "Training Tab", "<Tablename=TrainingPlanned><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [CourseName] + ' ' + [ProviderName]><Columns=[StartDate], [CompletionDate], [CourseName], [ProviderName], [VenueName], [TrainingStatus]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and ([PathID] is null or ([PathID] is not null and [TrainingStatus] = 'HR Granted')) and (not [PDTraining] = 1 or [PDTraining] is null))>", "Data.Training.Planned." & Session.SessionID)

                    LoadExpGrid(Session, dgView_002, "Training Tab", "<Tablename=TrainingPlanned><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [CourseName] + ' ' + [ProviderName]><Columns=[StartDate], [CompletionDate], [CourseName], [ProviderName], [VenueName], [TrainingStatus]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and not [PathID] is null and [PDTraining] is null and [LEID] is null)>", "Data.Training.Planned.Requests." & Session.SessionID)

                Case 2 ' Completed

                    If (ClearCache) Then ClearFromCache("Data.Training.Completed." & Session.SessionID)

                    LoadExpGrid(Session, dgView_003, "Training Tab", "<Tablename=TrainingCompleted><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [CourseName] + ' ' + [ProviderName]><Columns=[StartDate], [CompletionDate], [CourseName], [ProviderName], [VenueName], [TrainingStatus]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Training.Completed." & Session.SessionID)

                Case 3 ' Skills

                    If (ClearCache) Then ClearFromCache("Data.Training.Skills." & Session.SessionID)

                    LoadExpDS(dsContactType, "select distinct [ContactType] from [Skills] order by [ContactType]")

                    LoadExpDS(dsCourseCategory, "select [CourseCategory] from [CourseCategoryLU] order by [CourseCategory]")

                    LoadExpDS(dsCourseName, "select [CourseName] from [CourseLU] order by [CourseName]")

                    LoadExpDS(dsMainField, "select [MainField] from [UnitStandardFieldLU] order by [MainField]")

                    LoadExpDS(dsNQFLevel, "select [NQFLevel] from [CourseNQFLevelLU] order by [NQFLevel]")

                    LoadExpDS(dsSkillName, "select [SkillName] from [SkillLU] order by [SkillName]")

                    LoadExpGrid(Session, dgView_004, "Training Tab", "<Tablename=Skills><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Skill_Name]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Skill_Name], [Start_Date], [End_Date], [ContactType], [Reference_Person], [CourseCategory], [CourseSubCategory], [NQFLevel], [MainField], [SubField], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Training.Skills." & Session.SessionID)

                Case 4 ' Courses

                    If (Not IsNull(GetArrayItem(Nothing, "eTraining.OnOffer"))) Then OnOffer = Convert.ToBoolean(GetArrayItem(Nothing, "eTraining.OnOffer"))

                    If (ClearCache) Then ClearFromCache("Data.Training.CourseLU." & Session.SessionID)

                    'LoadExpGrid(Session, dgView_005, "Training Tab", "<Tablename=CourseLU><Join=[{%Tablename%}] [c] inner join [TrainingProviderLU] [p] on [p].[ProviderName] = [c].[ProviderName]><PrimaryKey=[CourseName] + ' ' + [c].[ProviderName]><Columns=[CourseName], [c].[ProviderName], [DeliveryMethod], [InternalCourse], [Duration], [DirectCost], [JobTitles] = ISNULL([JobTitles], '')><Where=(" & IIf(OnOffer, "[OnOffer] = 1", "[OnOffer] is null or [OnOffer] = 0") & ") and ([p].[ProviderType] is null or [p].[ProviderType] = '')>", "Data.Training.CourseLU." & Session.SessionID)
                    LoadExpGrid(
                        Session, dgView_005, "Training Tab",
                        "<Tablename=CourseLU><CustomSelectQuery=" +
                        "SELECT DISTINCT " +
                        "	[c].[CourseName] + ' ' + [c].[ProviderName] as [CompositeKey], " +
                        "	[c].[CourseName], " +
                        "	[c].[ProviderName], " +
                        "	[DeliveryMethod] = ISNULL([DeliveryMethod], 'Empty'), " +
                        "	[TrainingType] = " +
                        "	  CASE " +
                        "	      WHEN InternalCourse = 1 " +
                        "	          THEN 'Internal' " +
                        "	      WHEN Overseas = 1 " +
                        "	          THEN 'Overseas' " +
                        "	      WHEN InternalCourse = 1 AND Overseas = 1 " +
                        "	          THEN 'Empty' " +
                        "	      WHEN (Overseas = 0 OR Overseas IS NULL AND (InternalCourse = 0 OR InternalCourse IS NULL)) " +
                        "	          THEN 'External' " +
                        "	  END, " +
                        "	[Duration] = ISNULL((SELECT TOP 1 DATEDIFF(DAY, CONVERT(varchar(8), [d].DateFrom, 1), CONVERT(varchar(8), [d].DateTo, 1)) + 1 " +
                        "					FROM [CourseDatesLU] [d] " +
                        "					WHERE [d].CourseName = [c].CourseName " +
                        "					AND [d].DateFrom &gt; GETDATE() " +
                        "					ORDER BY [d].DateFrom asc), [Duration]), " +
                        "	[DurationType] = ISNULL([DurationType], 'Day(s)'), " +
                        "	[TrainingSched] = (SELECT TOP 1 CONVERT(varchar(10), [d].DateFrom, 101) + ' - ' + CONVERT(varchar(10), [d].DateTo, 101) " +
                        "	                FROM [CourseDatesLU] [d] " +
                        "	                WHERE [d].CourseName = [c].CourseName " +
                        "	                AND [d].DateFrom &gt; GETDATE() " +
                        "	                ORDER BY [d].DateFrom asc), " +
                        "	[DirectCost], " +
                        "	[RemSlots] = ISNULL((SELECT TOP 1 [d].Slots From [CourseDatesLU] [d] " +
                        "					WHERE [d].CourseName = [c].CourseName " +
                        "					AND [d].DateFrom &gt; GETDATE() " +
                        "					ORDER BY [d].DateFrom asc), 0), " +
                        "   [SequenceNum] = ISNULL([SequenceNum], 0), " +
                        "	[JobTitles] = ISNULL([JobTitles], '') " +
                        "FROM [CourseLU] [c] " +
                        "INNER JOIN [TrainingProviderLU] [p] " +
                        "	on [p].[ProviderName] = [c].[ProviderName] " +
                        "LEFT JOIN [CourseDatesLU] [d] " +
                        "	ON [d].CourseName = [c].CourseName " +
                        "ORDER BY [TrainingType] ASC, [c].[CourseName] ASC, [SequenceNum] ASC " +
                        ">", "Data.Training.CourseLU." & Session.SessionID)

                    '"	and ([p].[ProviderType] is null or [p].[ProviderType] = '') " +

                Case 5 ' Evaluation

                    ' do nothing...

                Case 6 ' Application

                    ' do nothing...

                Case 7 ' TAF

                    btnSubmitAgreement_014.Enabled = cbxTrainingAgreement_014.Checked

                    ClearFromCache("Data.Training.TAF.ProgramDetails." & Session.SessionID)

                    dgView_014.SettingsText.Title = "<Required=[ProgramTitle][Type][ProgramType][Investment][Provider][Venue][DateFrom][DateTo]>"

                    LoadExpGrid(
                        Session, dgView_014, "Training Tab",
                        "<Tablename=TAFProgramDetails><CustomSelectQuery=" +
                        "SELECT " +
                        "	tpd.[ProgramDetailsID], " +
                        "	tpd.[Type], " +
                        "	tpd.[ProgramType], " +
                        "	tpd.[ProgramTitle], " +
                        "	tpd.[Provider], " +
                        "	tpd.[DateFrom], " +
                        "	tpd.[DateTo], " +
                        "	tpd.[Venue], " +
                        "	tpd.[Investment], " +
                        "	tpd.[TAFID] " +
                        "FROM TAFProgramDetails tpd " +
                        "INNER JOIN TrainingAgreementForm taf " +
                        "	ON taf.TAFID = tpd.TAFID " +
                        "WHERE taf.[Status] = 'Draft' " +
                        "	AND taf.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "	AND taf.[CompanyNum] = '" & .CompanyNum & "' " +
                        "	AND tpd.[TAFID] = '" & txtTAFID_007.Text & "' " +
                        "ORDER BY tpd.[ProgramTitle] ASC " +
                        ">", "Data.Training.TAF.ProgramDetails." & Session.SessionID)

                Case 8 ' History

                    ClearFromCache("Data.Training.TAF.History." & Session.SessionID)

                    'Dim dtSource As DataTable = GetSQLDT("select [XMLTag],[ID] as [CompositeKey], [XMLTag], [ActionDate], [PrevActioner], [Summary], (select (CASE WHEN [Status] = 'Approve' THEN 'Submitted' WHEN [Status] = 'Start' THEN 'Approved' END) [Status] from [ess.StatusLU] where ([id] = (select [StatusID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [AppStatus], (select [WFType] from [ess.WFLU] where ([id] = (select [WFLUID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [WFType] from [ess.Path] where (((select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start' or [Status] = 'Approve')) and ([OriginatorUsername] = '" & .UserID & "') and (([Frozen] is null) or ([Frozen] = 0)) and ([XMLTag] like '%AppType=Agreement%')) order by ActionDate desc", "Data.Training.TAF.History." & Session.SessionID)

                    Dim dtSource As DataTable = GetSQLDT("SELECT [CompositeKey] = taf.[PathID], tad.[Type], tad.[ProgramType], tad.[ProgramTitle], [TAFDuration] = CONVERT(varchar, tad.[DateFrom], 101) + ' - ' + CONVERT(varchar, tad.[DateTo], 101), taf.[DatePrepared], [Status] = ( CASE WHEN taf.[Status] = 'Approve' THEN 'Approved' WHEN taf.[Status] = 'Reject' THEN 'Rejected' ELSE taf.[Status] END ) FROM TrainingAgreementForm taf INNER JOIN TAFProgramDetails tad ON taf.[TAFID] = tad.[TAFID] WHERE taf.[EmployeeNum] = '" & .EmployeeNum & "' ORDER BY taf.[DatePrepared] DESC", "Data.Training.TAF.History." & Session.SessionID)

                    dgView_015.DataSource = dtSource

                    GridFormat(dgView_015, .Template)

                    dgView_015.DataBind()

                Case 9 ' TAF Maintenance Tab

                    ClearFromCache("Data.Training.TAFMaintenance.Functional." & Session.SessionID)
                    ClearFromCache("Data.Training.TAFMaintenance.Specialized." & Session.SessionID)

                    LoadExpGrid(
                        Session, dgView_012, "Training Tab",
                        "<Tablename=FunctionalTrainingProgram><CustomSelectQuery=" +
                        "SELECT " +
                        "    [ID] = FTP.[ID], " +
                        "    [ServiceAgreement] = FTP.[ServiceAgreement], " +
                        "    [Min] = FTP.[Min], " +
                        "    [Max] = FTP.[Max], " +
                        "    [Years] = FTP.[Years], " +
                        "    [Months] = FTP.[Months], " +
                        "    [CapturedBy] = FTP.[CapturedBy], " +
                        "    [CapturedOn] = FTP.[CapturedOn] " +
                        "FROM FunctionalTrainingProgram FTP " +
                        "ORDER BY [Min] ASC " +
                        ">", "Data.Training.TAFMaintenance.Functional." & Session.SessionID)

                    LoadExpGrid(
                        Session, dgView_013, "Training Tab",
                        "<Tablename=SpecializedDevelopmentProgram><CustomSelectQuery=" +
                        "SELECT " +
                        "    [ID] = SDP.[ID], " +
                        "    [ServiceAgreement] = SDP.[ServiceAgreement], " +
                        "    [Program] = SDP.[Program], " +
                        "    [CapturedBy] = SDP.[CapturedBy], " +
                        "    [CapturedOn] = SDP.[CapturedOn] " +
                        "FROM SpecializedDevelopmentProgram SDP " +
                        "ORDER BY [Program] ASC " +
                        ">", "Data.Training.TAFMaintenance.Specialized." & Session.SessionID)

                Case 10 ' External

                    ClearFromCache("Data.Training.External.Budget." & Session.SessionID)
                    ClearFromCache("Data.Training.External.Monitoring." & Session.SessionID)

                    dgView_010.SettingsText.Title = "<Required=[CategoryName][Year][Month][Budget]>"

                    LoadExpGrid(
                        Session, dgView_010, "Training Tab",
                        "<Tablename=TrainingExternalBudget><CustomSelectQuery=" +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        TEB.[CompanyNum] + ' ' + " +
                        "        TEB.[CategoryName] + ' ' + " +
                        "        CONVERT(NVARCHAR(10), TEB.[Year]) + ' ' + " +
                        "        CONVERT(NVARCHAR(10), TEB.[Month]), " +
                        "    [CategoryName] = TEB.[CategoryName], " +
                        "    [Year] = TEB.[Year], " +
                        "    [Month] = TEB.[Month], " +
                        "    [MonthText] = DATENAME(MONTH, CONVERT(NVARCHAR(10), TEB.[Month]) + '/1/1900'), " +
                        "    [Budget] = TEB.[Budget], " +
                        "    [RemainingBudget] = TEB.[RemainingBudget], " +
                        "    [CapturedBy] = TEB.[CapturedBy], " +
                        "    [CapturedOn] = TEB.[CapturedOn] " +
                        "FROM TrainingExternalBudget TEB " +
                        "ORDER BY [CategoryName] DESC " +
                        ">", "Data.Training.External.Budget." & Session.SessionID)

                    '"WHERE TEB.[CompanyNum] = '" & .CompanyNum & "' " +

                    dgViewBC_010.SettingsText.Title = "<Required=[BudgetCode][CategoryName][Year][Text][SequenceNum]>"

                    LoadExpGrid(
                        Session, dgViewBC_010, "Training Tab",
                        "<Tablename=TrainingExternalBudgetMonitoring><CustomSelectQuery=" +
                        "SELECT " +
                        "    [CompositeKey] = " +
                        "        EBM.[BudgetCode] + ' ' + " +
                        "        EBM.[CategoryName] + ' ' + " +
                        "        CONVERT(NVARCHAR(10), EBM.[Year]), " +
                        "    [BudgetCode] = EBM.[BudgetCode], " +
                        "    [CategoryName] = EBM.[CategoryName], " +
                        "    [Year] = EBM.[Year], " +
                        "    [Text] = EBM.[Text], " +
                        "    [SequenceNum] = EBM.[SequenceNum], " +
                        "    [CapturedBy] = EBM.[CapturedBy], " +
                        "    [CapturedOn] = EBM.[CapturedOn] " +
                        "FROM TrainingExternalBudgetMonitoring EBM " +
                        "ORDER BY [CategoryName] DESC, [BudgetCode] " +
                        ">", "Data.Training.External.Monitoring." & Session.SessionID)

            End Select

        End With

    End Sub

    Private Sub PopulateYearAndMonth(cbYear As DevExpress.Web.ASPxEditors.ASPxComboBox, cbMonth As DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cbYear IsNot Nothing Then

            cbYear.Items.Clear()

            Dim currentYear As Integer = DateTime.Today.Year

            For i = currentYear + 10 To currentYear - 50 Step -1

                cbYear.Items.Add(i, i)

            Next

        End If

        If cbMonth IsNot Nothing Then

            cbMonth.Items.Clear()

            For i = 1 To 12

                cbMonth.Items.Add(New DateTime(1900, i, 1).ToString("MMMM"), i)

            Next

        End If

    End Sub

    Private Sub PopulateTrainingType(cbTrainType As DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cbTrainType IsNot Nothing Then

            cbTrainType.Items.Clear()

            cbTrainType.Items.Add("", "")
            cbTrainType.Items.Add("In-house", "1")
            cbTrainType.Items.Add("External", "2")
            cbTrainType.Items.Add("Overseas", "3")

        End If

    End Sub

    Private Sub ValidateFunctionalFieldsValue(min As Object, max As Object, months As Object, years As Object, Optional id As Object = Nothing)

        Dim dtFuncTrainProg As DataTable = Nothing

        Try

            If Not Decimal.TryParse(min, 0) Then

                Throw New Exception("Min. Training Investment should be numerical value.")

            End If

            If Not Decimal.TryParse(max, 0) Then

                Throw New Exception("Max. Training Investment should be numerical value.")

            End If

            If Not Int32.TryParse(years, 0) Then

                Throw New Exception("Year/s should be numerical value.")

            End If

            If Not Int32.TryParse(months, 0) Then

                Throw New Exception("Month/s should be numerical value.")

            End If

            If (months > 11) Then

                Throw New Exception("Month/s cannot be greater than 11.")

            End If

            If (min > max) Then

                Throw New Exception("Min. Training Investment cannot be greater than Max. Training Investment.")

            End If

            Dim sql As String =
                "SELECT " +
                "   TOP 1 " +
                "   ServiceAgreement " +
                "FROM FunctionalTrainingProgram " +
                "WHERE (('" + min + "' BETWEEN Min AND Max) " +
                "  OR ('" + max + "' BETWEEN Min AND Max))"

            If Not id = Nothing Then

                sql += "AND ID <> '" + id + "'"

            End If

            dtFuncTrainProg = GetSQLDT(sql)

            If dtFuncTrainProg.Rows.Count > 0 Then

                Throw New Exception("Investment range overlaps with other service agreement/s.")

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtFuncTrainProg IsNot Nothing Then

                dtFuncTrainProg.Clear()
                dtFuncTrainProg.Dispose()
                dtFuncTrainProg = Nothing

            End If

        End Try

    End Sub

    Private Function ConstructServiceAgreement(months As Object, years As Object) As String

        Dim monthsInt, yearsInt As Int32

        If Int32.TryParse(months, monthsInt) AndAlso
           Int32.TryParse(years, yearsInt) Then

            yearsInt += (monthsInt - (monthsInt Mod 12)) / 12

            monthsInt = monthsInt Mod 12

            Dim srvAgr As StringBuilder = New StringBuilder()

            If yearsInt > 0 Then

                srvAgr.Append(yearsInt)
                srvAgr.Append(" year")

                If yearsInt > 1 Then srvAgr.Append("s")

                srvAgr.Append(" ")

            End If

            If monthsInt > 0 Then

                srvAgr.Append(monthsInt)
                srvAgr.Append(" month")

                If monthsInt > 1 Then srvAgr.Append("s")

            End If

            Return srvAgr.ToString()

        End If

        Return ""

    End Function

    Private Sub ValidateSpecializedFieldsValue(ByVal program As Object, serviceAgreement As Object, Optional id As Object = Nothing)

        Dim dtSpecDevProg As DataTable = Nothing

        Try

            If Not Int32.TryParse(serviceAgreement, 0) OrElse serviceAgreement < 0 OrElse serviceAgreement > 99 Then

                Throw New Exception("Service Agreement should be numerical value (0 to 99).")

            End If

            Dim sql As String =
                "SELECT " +
                "   TOP 1 " +
                "   ServiceAgreement " +
                "FROM SpecializedDevelopmentProgram " +
                "WHERE [Program] = '" + program + "' " +
                "  AND [ServiceAgreement] = '" + serviceAgreement + "'"

            If Not sql = Nothing Then

                sql += "AND ID <> '" + id + "'"

            End If

            dtSpecDevProg = GetSQLDT(sql)

            If dtSpecDevProg.Rows.Count > 0 Then

                Throw New Exception("Record with same Program and Service agreement already exists!")

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtSpecDevProg IsNot Nothing Then

                dtSpecDevProg.Clear()
                dtSpecDevProg.Dispose()
                dtSpecDevProg = Nothing

            End If

        End Try

    End Sub

    Private Sub PopulateTAFTeamMemberProfile()

        With UDetails

            Dim dtTAFRecord As DataTable = GetSQLDT("SELECT taf.[TAFID] [TAFID], taf.[EmployeeNum] [ID], taf.[Name], co.[Division], co.[SubDivision] Department, co.[SubSubDivision] Section, pers1.[OFOCode] [Level], taf.[ExternalPositionTitle], pers.[HomeTel] [LocalNum], taf.[MobileNum], taf.[RTANum], taf.[DatePrepared], taf.[Status], taf.[CapturedBy], taf.[CapturedOn] FROM TrainingAgreementForm taf INNER JOIN Personnel1 pers1 ON taf.EmployeeNum = pers1.EmployeeNum INNER JOIN Personnel pers ON taf.EmployeeNum = pers.EmployeeNum INNER JOIN Company co ON taf.CompanyNum = co.CompanyNum WHERE taf.[Status] = 'Draft' AND taf.[EmployeeNum] = '" & .EmployeeNum & "' AND taf.[CompanyNum] = '" & .CompanyNum & "'")

            If (IsData(dtTAFRecord)) Then

                pnlAgreement_002.Visible = True
                pnlAgreement_004.Visible = True
                btnSave_007.Visible = False

                txtEmployeeNum_007.Text = dtTAFRecord.Rows(0).Item("ID").ToString()
                txtTAFID_007.Text = dtTAFRecord.Rows(0).Item("TAFID").ToString()
                txtDatePrep_007.Text = dtTAFRecord.Rows(0).Item("DatePrepared").ToShortDateString.ToString()
                txtName_007.Text = dtTAFRecord.Rows(0).Item("Name").ToString()
                txtLocal_007.Text = dtTAFRecord.Rows(0).Item("LocalNum").ToString()
                txtDivision_007.Text = dtTAFRecord.Rows(0).Item("Division").ToString()
                txtDepartment_007.Text = dtTAFRecord.Rows(0).Item("Department").ToString()
                txtSection_007.Text = dtTAFRecord.Rows(0).Item("Section").ToString()
                txtLevel_007.Text = dtTAFRecord.Rows(0).Item("Level").ToString()
                txtMobile_007.Text = dtTAFRecord.Rows(0).Item("MobileNum").ToString()
                txtExternalPos_007.Text = dtTAFRecord.Rows(0).Item("ExternalPositionTitle").ToString()
                txtRTA_007.Text = dtTAFRecord.Rows(0).Item("RTANum").ToString()

                dtTAFRecord.Dispose()

            Else

                pnlAgreement_002.Visible = False
                pnlAgreement_004.Visible = False
                btnSave_007.Visible = True

                Dim dtColumns As DataTable = GetSQLDT("SELECT TOP 1 Personnel1.[EmployeeNum], CONVERT(DATE, GETDATE())[DatePrep], CASE WHEN MiddleName IS NOT NULL AND FirstName IS NOT NULL AND Surname IS NOT NULL THEN Surname + ', ' + FirstName + ' ' + SUBSTRING(MiddleName, 1, 1) + '.' ELSE Surname + ', ' + FirstName END [Name], ISNULL(HomeTel, '-') [LocalNo], [Division], SubDivision [Department], Subsubdivision [Section], OFOCode [Level] FROM Personnel INNER JOIN Company ON Company.CompanyNum = Personnel.CompanyNum INNER JOIN Personnel1 ON Personnel.EmployeeNum = Personnel1.EmployeeNum WHERE Personnel.EmployeeNum = '" & .EmployeeNum & "' AND Personnel.CompanyNum = '" & .CompanyNum & "'")

                If (IsData(dtColumns)) Then

                    For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                        With dtColumns.Rows(iLoop)

                            txtEmployeeNum_007.Text = dtColumns.Rows(iLoop).Item("EmployeeNum").ToString()
                            txtDatePrep_007.Text = dtColumns.Rows(iLoop).Item("DatePrep").ToShortDateString.ToString()
                            txtName_007.Text = dtColumns.Rows(iLoop).Item("Name").ToString()
                            txtLocal_007.Text = dtColumns.Rows(iLoop).Item("LocalNo").ToString()
                            txtDivision_007.Text = dtColumns.Rows(iLoop).Item("Division").ToString()
                            txtDepartment_007.Text = dtColumns.Rows(iLoop).Item("Department").ToString()
                            txtSection_007.Text = dtColumns.Rows(iLoop).Item("Section").ToString()
                            txtLevel_007.Text = dtColumns.Rows(iLoop).Item("Level").ToString()

                        End With

                    Next

                    dtColumns.Dispose()

                End If

                dtColumns = Nothing

            End If

            dtTAFRecord = Nothing

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

        If Not IsNothing(Session("LoggedOn")) Then

            Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")

            visible = True ' delete this flag

            tabTraining.TabPages.FindByText("External").ClientVisible = visible
            tabTraining.TabPages.FindByText("TAF Maintenance").ClientVisible = visible

        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim redirected As String = Request.QueryString("success")

        Dim OnOffer As Boolean

        If (Not IsNull(GetArrayItem(Nothing, "eTraining.OnOffer"))) Then OnOffer = Convert.ToBoolean(GetArrayItem(Nothing, "eTraining.OnOffer"))

        If redirected = "1" Then

            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "SuccessSubmitShow", "window.parent.ShowPopup(""success Training Agreement form is submitted! Kindly print accomplished TAF for additional manual approval. <br /> Also, you may monitor your Training Agreement form status in ESS >> Tasks >> Pending"")", True)

            PopulateTAFTeamMemberProfile()

        End If

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        UDetails = GetUserDetails(Session, "Training Tab")

        EDetails = GetUserDetails(Session, "Training Tab", True)

        'Evaluation, External, Training Agreement Form
        If (Not IsPostBack) Then

            ClientScript.RegisterClientScriptBlock(Me.GetType(), "IsPostBack", "isPostBack = true;", True)

            SetEmployeeData(Session, Session("Selected.Value"))

            PopulateTrainingType(cmbTrainType_011)

            PopulateYearAndMonth(cmbYear_007, cmbMonthFrom_007)

            PopulateTAFTeamMemberProfile()

            'jlacno 9/11/2018
            LoadExpDS(
                dsCourseLU,
                "SELECT DISTINCT [CourseName] " +
                "FROM [CourseLU] C " +
                "INNER JOIN [Personnel1] P " +
                "ON C.[JobTitles] like '%|' + P.[IndividualJobTitle] + '|%' " +
                "OR C.[JobTitles] = '' " +
                "OR C.[JobTitles] IS NULL " +
                "WHERE (" & IIf(OnOffer, "[OnOffer] = 1", "[OnOffer] IS NULL OR [OnOffer] = 0") & ") " +
                "  AND P.[EmployeeNum] = '" & UDetails.EmployeeNum & "' " +
                "  AND C.[InternalCourse] = 1 " +
                "ORDER BY C.[CourseName]")

        End If

        LoadData()

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabTraining.TabPages(tabTraining.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabTraining.TabPages(tabTraining.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

                Select Case e.Item.Name

                    Case "mnuExp_CSV"
                        dgExports.WriteCsvToResponse(xFilePath)

                    Case "mnuExp_XLS"
                        dgExports.WriteXlsToResponse(xFilePath)

                    Case "mnuExp_XLSX"
                        dgExports.WriteXlsxToResponse(xFilePath)

                    Case "mnuExp_RTF"
                        dgExports.WriteRtfToResponse(xFilePath)

                    Case "mnuExp_PDF"
                        dgExports.WritePdfToResponse(xFilePath)

                End Select

            End If

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dgExports)) Then

                dgExports.Dispose()

                dgExports = Nothing

            End If

        End Try

    End Sub

#Region "Courses"

    Protected Sub dgView_005_HtmlRowPrepared(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs)

        If e.RowType = DevExpress.Web.ASPxGridView.GridViewRowType.Data Then

            Dim jobTitles As String = e.GetValue("JobTitles").ToString()
            Dim individualJobTitle = EDetails.IndividualJobTitle

            If jobTitles <> "" AndAlso Not jobTitles.Contains("|" & individualJobTitle & "|") Then

                e.Row.BackColor = Drawing.Color.LightGray

            End If

        End If

    End Sub

    Private Sub dgView_005_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_005.CustomJSProperties

        Dim cpToolURL As String = "tools/index.aspx"

        e.Properties("cpHtmlText") = cpHtmlText

        e.Properties("cpToolURL") = cpToolURL

        e.Properties("cpShowDetails") = cpShowDetails

    End Sub

    Private Sub dgView_005_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_005.CustomCallback

        Dim dtData As DataTable = Nothing

        Try

            Dim SQL As String = String.Empty

            Dim iIndex As Integer = Convert.ToInt32(e.Parameters.Split(" ")(1))

            Dim Course As String = sender.GetRowValues(iIndex, "CourseName").ToString()

            SQL =
                "SELECT " +
                "	[Training Schedule:] = CONVERT(varchar(10), [d].DateFrom, 101) + ' - ' + CONVERT(varchar(10), [d].DateTo, 101), " +
                "	[Remaining Slots:] = [d].Slots " +
                "FROM [CourseDatesLU] [d] " +
                "WHERE [d].CourseName = '" + Course + "'" +
                "ORDER BY [d].DateFrom asc"

            dtData = GetSQLDT(SQL)

            If (IsData(dtData)) Then

                cpHtmlText = "<table cellpadding=""0"" style=""text-align: left; width: 100%"">"

                cpHtmlText &= "<tr>"

                cpHtmlText &= "<td style=""font-weight: bold; text-align: center; "" colspan=3 width=100%>" & Course & "</td><td style=""width: 10px"" />"

                cpHtmlText &= "</tr>"

                cpHtmlText &= "<tr> <td> <br /> </td> </tr>"

                For x As Integer = 0 To (dtData.Rows.Count - 1)

                    For i As Integer = 0 To (dtData.Columns.Count - 1)

                        cpHtmlText &= "<tr>"

                        cpHtmlText &= "<td style=""font-weight: bold; text-align: right; width: 125px"">" & dtData.Columns(i).ColumnName & "</td><td style=""width: 10px"" /><td>"

                        cpHtmlText &= dtData.Rows(x).Item(i).ToString()

                        cpHtmlText &= "</td></tr>"

                    Next

                    If (x < (dtData.Rows.Count - 1)) Then cpHtmlText &= "<tr><td colspan=""3"" style=""height: 5px"" /></tr>"

                Next

                cpHtmlText &= "</table>"

            End If

            cpShowDetails = True

        Catch ex As Exception

            WriteEventLog(ex)

        Finally

            If (Not IsNull(dtData)) Then

                dtData.Dispose()

                dtData = Nothing

            End If

        End Try

    End Sub

#End Region

#Region "Application"

    Private Sub cmbCourse_006_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbCourse_006.SelectedIndexChanged

        cmbProvider_006.Items.Clear()

        memoPrereq.Text = String.Empty

        RetrievePrerequisiteCourses(sender)

        If cmbProvider_006.Items.Count > 1 Then
            cmbProvider_006.SelectedIndex = 1
        ElseIf cmbProvider_006.Items.Count = 1 Then
            cmbProvider_006.SelectedIndex = 0
        End If

    End Sub

    Private Function RetrievePrerequisiteCourses(sender As Object) As Boolean

        ResultText = String.Empty

        Dim valid As Boolean = True

        Dim outputPrereq As StringBuilder = New StringBuilder

        Dim dtColumns As DataTable = GetSQLDT("select top 1 [ProviderName], [SequenceNum] from [CourseLU] where ([CourseName] = '" & cmbCourse_006.Text & "') order by [ProviderName]")

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    If iLoop = 0 Then

                        cmbProvider_006.Items.Add(String.Empty)

                    End If

                    cmbProvider_006.Items.Add(dtColumns.Rows(iLoop).Item(0))

                    Dim seqNum As Integer

                    If Integer.TryParse(dtColumns.Rows(iLoop).Item(1).ToString(), seqNum) Then

                        Dim dtColumns2 As DataTable = GetSQLDT("select [CourseName], [SequenceNum] from [CourseLU] where [SequenceNum] < " & seqNum.ToString() & " order by [SequenceNum] asc")

                        If (IsData(dtColumns2)) Then

                            If (sender.GetType().Name.ToLower() = "aspxcombobox") Then

                                For iLoop2 As Integer = 0 To (dtColumns2.Rows.Count - 1)

                                    With dtColumns2.Rows(iLoop2)

                                        outputPrereq.AppendLine(String.Format("{0}. {1}", dtColumns2.Rows(iLoop2).Item(1), dtColumns2.Rows(iLoop2).Item(0)))

                                    End With

                                Next

                            ElseIf (sender.GetType().Name.ToLower() = "aspxbutton") Then

                                ResultText = "information Please take the prerequisite courses first:"

                                For iLoop2 As Integer = 0 To (dtColumns2.Rows.Count - 1)

                                    With dtColumns2.Rows(iLoop2)

                                        With UDetails

                                            Dim dtColumns3 As DataTable = GetSQLDT("select [CourseName] from [TrainingCompleted] where [CourseName] = '" & dtColumns2.Rows(iLoop2).Item(0) & "' and [CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "'")

                                            If (Not IsData(dtColumns3)) Then

                                                valid = False

                                                ResultText += String.Format("<br>{0}. {1}", dtColumns2.Rows(iLoop2).Item(1), dtColumns2.Rows(iLoop2).Item(0))

                                            Else

                                                dtColumns3.Dispose()

                                            End If

                                            dtColumns3 = Nothing

                                        End With

                                    End With

                                Next

                                If (valid) Then ResultText = String.Empty

                            End If

                            dtColumns2.Dispose()

                        End If

                        dtColumns2 = Nothing

                    End If

                End With

            Next

            dtColumns.Dispose()

            If (sender.GetType().Name.ToLower() = "aspxcombobox") Then memoPrereq.Text = outputPrereq.ToString()

        End If

        dtColumns = Nothing

        Return valid

    End Function

    Private Sub cmbProvider_006_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbProvider_006.SelectedIndexChanged

        cmbSched_006.Items.Clear()

        Dim dtColumns As DataTable = GetSQLDT("select (convert(varchar(10), cast(DateFrom as date), 101) + ' - ' + convert(varchar(10), cast(DateTo as date), 101)) as [ScheduleDate] from [CourseDatesLU] where ([CourseName] = '" & cmbCourse_006.Text & "' and [ProviderName] = '" & cmbProvider_006.Text & "') and (convert(varchar(10), DATEADD(DAY, 1, GETDATE()), 101) BETWEEN convert(varchar(10), cast(DateFrom as date), 101) AND convert(varchar(10), cast(DateTo as date), 101) OR convert(varchar(10), DATEADD(DAY, 1, GETDATE()), 101) < convert(varchar(10), cast(DateFrom as date), 101))")

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    If iLoop = 0 Then

                        cmbSched_006.Items.Add(String.Empty)

                    End If

                    cmbSched_006.Items.Add(dtColumns.Rows(iLoop).Item(0))

                End With

            Next

            dtColumns.Dispose()

        End If

        dtColumns = Nothing

    End Sub

    Protected Sub cmbSched_006_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbSched_006.SelectedIndexChanged

        If (cmbProvider_006.Items.Count = 0) Then
            cmbSched_006.Items.Clear()
        End If

        If (cmbSched_006.SelectedItem.Value().ToString() = "") Then
            txtSlotsLeft.Text = "0"
            Return
        End If

        Dim scheduleDate As String() = cmbSched_006.SelectedItem.Value().ToString().Split(New Char() {"-"})

        txtSlotsLeft.Text = "N/A"

        Dim dtColumns As DataTable = GetSQLDT("select top 1 [RemainingSlots] from CourseDatesLU where CourseName = '" & cmbCourse_006.SelectedItem.Value().ToString() & "' and ProviderName = '" & cmbProvider_006.SelectedItem.Value().ToString() & "' and DateFrom = '" & scheduleDate(0).ToString().Trim() & "' and DateTo = '" & scheduleDate(1).ToString().Trim() & "'")

        If (IsData(dtColumns)) Then

            For iLoop As Integer = 0 To (dtColumns.Rows.Count - 1)

                With dtColumns.Rows(iLoop)

                    txtSlotsLeft.Text = dtColumns.Rows(iLoop).Item(0).ToString()

                End With

            Next

            dtColumns.Dispose()

        End If

        dtColumns = Nothing

    End Sub

    Private Sub cmdSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click

        ShowPopup = False

        With UDetails

            Dim scheduleDate As String() = cmbSched_006.SelectedItem.Value().ToString().Split(New Char() {"-"})

            'If (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CompanyNum] from [TrainingPlanned] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and (([StartDate] >= '" & dteStart_006.Date.ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & dteEnd_006.Date.ToString("yyyy-MM-dd 23:59:59") & "') or ([EndDate] >= '" & dteEnd_006.Date.ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & dteEnd_006.Date.ToString("yyyy-MM-dd 23:59:59") & "')))")))) Then
            If (Not ShowPopup AndAlso Not RetrievePrerequisiteCourses(sender)) Then

                ShowPopup = True

            ElseIf (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CoompanyNum] from [TrainingPlanned] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [CourseName] = '" & cmbCourse_006.SelectedItem.Value().ToString() & "' and ([TrainingStatus] = 'New' or [TrainingStatus] = 'HOD Accepted' or [TrainingStatus] = 'HR Granted'))")))) Then

                ShowPopup = True

                ResultText = "information You already have an existing training application for the selected training course."

            ElseIf (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CompanyNum] from [TrainingCompleted] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [CourseName] = '" & cmbCourse_006.SelectedItem.Value().ToString() & "')")))) Then

                ShowPopup = True

                ResultText = "information You have already completed the selected training course."

            ElseIf (Not ShowPopup AndAlso (IsData(GetSQLDT("select [CompanyNum] from [TrainingPlanned] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and (([StartDate] >= '" & Date.Parse(scheduleDate(0).Trim()).Date.ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & Date.Parse(scheduleDate(1).Trim()).Date.ToString("yyyy-MM-dd 23:59:59") & "') or ([CompletionDate] >= '" & Date.Parse(scheduleDate(1).Trim()).Date.ToString("yyyy-MM-dd 00:00:00") & "' and [StartDate] <= '" & Date.Parse(scheduleDate(0).Trim()).Date.ToString("yyyy-MM-dd 23:59:59") & "')))")))) Then

                ShowPopup = True

                ResultText = "information You already have a training application between the start and end dates."

            ElseIf (Not ShowPopup AndAlso Convert.ToInt32(txtSlotsLeft.Text) <= 0) Then

                ShowPopup = True

                ResultText = "information There are no more slots left in the selected course/schedule date. "

            End If

            If (Not ShowPopup) Then

                Dim bSaved As Boolean

                Dim StartDate As String = "'" & Date.Parse(scheduleDate(0).Trim()).Date.ToString("yyyy-MM-dd HH:mm:ss") & "'"

                Dim EndDate As String = "'" & Date.Parse(scheduleDate(1).Trim()).Date.ToString("yyyy-MM-dd HH:mm:ss") & "'"

                Dim Duration As Integer = (Date.Parse(scheduleDate(1).Trim()) - Date.Parse(scheduleDate(0).Trim())).TotalDays + 1

                Dim execute As String = "insert into [TrainingPlanned]([CompanyNum], [EmployeeNum], [CourseName], [ProviderName], [StartDate], [CourseCategory], [CourseSubCategory], [NQFLevel], [Description], [Duration], [DurationType], [DeliveryMethod], [InternalCourse], [CompletionDate], [TrainingStatus], [CapturedByUsername]) select '" & .CompanyNum & "', '" & .EmployeeNum & "', '" & cmbCourse_006.Value & "', '" & cmbProvider_006.Value & "', " & StartDate & ", [CourseCategory], [CourseSubCategory], [NQFLevel], [Description], '" & Duration & "', 'Day(s)', [DeliveryMethod], [InternalCourse], " & EndDate & ", 'New', '" & Session("LoggedOn").UserID & "' from [CourseLU] where (([CourseName] = '" & cmbCourse_006.Value & "') and ([ProviderName] = '" & cmbProvider_006.Value & "')) "

                bSaved = ExecSQL(execute)

                If bSaved Then

                    execute = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Training', 'Training', 'Start', 'Start', " & StartDate & " "

                    execute += "update CD set CD.[RemainingSlots] =  CD.[RemainingSlots] - 1 from [CourseDatesLU] as CD where CD.[CourseName] = '" & cmbCourse_006.Value & "' and CD.[ProviderName] = '" & cmbProvider_006.Value & "' and CD.DateFrom = " & StartDate & " and CD.[DateTo] = " & EndDate

                    bSaved = ExecSQL(execute)

                    If (bSaved) Then Response.Redirect("tasks.aspx")

                End If

            Else

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

#End Region

#Region "Skills"

    Protected Sub dgView_004_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_004"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim cmbSkill As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSkill_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbSkill.DataBindItems()


        Dim dteStartDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteStartDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)
        Dim dteEndDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteEndDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim cmbReference As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReference_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbReference.DataBindItems()
        Dim cmbReferenceType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReferenceType_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbReferenceType.DataBindItems()

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbCategory.DataBindItems()
        Dim cmbSubCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubcategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbSubCategory.DataBindItems()

        Dim cmbNQFLevel As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbNQFLevel_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbNQFLevel.DataBindItems()
        Dim cmbField As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbField_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbField.DataBindItems()
        Dim cmbSubfield As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubfield_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        cmbSubfield.DataBindItems()
        Dim txtComment As DevExpress.Web.ASPxEditors.ASPxMemo =
             TryCast(pgControl.FindControl("commentsEditor_004"), DevExpress.Web.ASPxEditors.ASPxMemo)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then
            Dim compositeKey As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CompositeKey")
            Dim skill As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Skill_Name")
            Dim startDate As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Start_Date")
            Dim endDate As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "End_Date")
            Dim reference As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Reference_Person")
            Dim referenceType As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ContactType")
            Dim category As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CourseCategory")
            Dim subcategory As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CourseSubCategory")
            Dim nqfLevel As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "NQFLevel")
            Dim field As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "MainField")
            Dim subfield As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "SubField")
            Dim comment As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Comments")
            'Dim sql As StringBuilder = New StringBuilder()

            'sql.AppendLine("SELECT TOP 1")
            'sql.AppendLine("*")
            'sql.AppendLine("FROM Skills")
            'sql.AppendLine("WHERE CONCAT(CompanyNum,' ',EmployeeNum,' ',SkillName)='" & editingKeyValue & "'")

            'Dim dtColumns As DataTable = GetSQLDT(sql.ToString())

            'If (IsData(dtColumns)) Then

            'End If

            ' Dim a As Integer = cmbSkill.Items.Count

            cmbSkill.SelectedItem = cmbSkill.Items.FindByValue(skill.ToString())

            If (Not IsDBNull(startDate)) Then dteStartDate.Date = startDate.ToString()
            If (Not IsDBNull(endDate)) Then dteEndDate.Date = endDate.ToString()
            cmbReference.SelectedItem = cmbReference.Items.FindByValue(reference.ToString())
            cmbReferenceType.SelectedItem = cmbReferenceType.Items.FindByValue(referenceType.ToString())
            cmbCategory.SelectedItem = cmbCategory.Items.FindByValue(category.ToString())
            cmbSubCategory.SelectedItem = cmbSubCategory.Items.FindByValue(subcategory.ToString())
            cmbNQFLevel.SelectedItem = cmbNQFLevel.Items.FindByValue(nqfLevel.ToString())
            cmbField.SelectedItem = cmbField.Items.FindByValue(field.ToString())
            cmbSubfield.SelectedItem = cmbSubfield.Items.FindByValue(subfield.ToString())
            txtComment.Text = comment.ToString()

        End If


    End Sub

    Private Sub dgView_004_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_004.CustomCallback

        Dim sCourseCategory As String = String.Empty
        Dim sMainField As String = String.Empty

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            sCourseCategory = sender.GetRowValues(sender.EditingRowVisibleIndex, "CourseCategory").ToString()

            sMainField = sender.GetRowValues(sender.EditingRowVisibleIndex, "MainField").ToString()

        End If

        Select Case GetXML(e.Parameters, KeyName:="ID")

            Case "CourseCategory"
                sCourseCategory = GetXML(e.Parameters, KeyName:="Value")

            Case "MainField"
                sMainField = GetXML(e.Parameters, KeyName:="Value")

        End Select

        If (sCourseCategory.Length > 0) Then
            LoadExpDS(dsCourseSubCategory, "select [CourseSubCategory] from [CourseSubCategoryLU] where ([CourseCategory] = '" & GetDataText(sCourseCategory) & "') order by [CourseSubCategory]")
        End If

        If (sMainField.Length > 0) Then
            LoadExpDS(dsSubField, "select [SubField] from [UnitStandardSubFieldLU] where ([MainField] = '" & GetDataText(sMainField) & "') order by [SubField]")
        End If

    End Sub

    Private Sub dgView_004_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_004.RowDeleting
        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim SQLAudit As String = "<Tablename=Skills><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><Skill_Name=" & e.Values("Skill_Name").ToString() & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        gridView.CancelEdit()

        If (e.Cancel) Then
            CancelEdit = True
        End If

        With UDetails
            ClearFromCache("Data.Training.Skills." & Session.SessionID)
            LoadExpGrid(Session, dgView_004, "Training Tab", "<Tablename=Skills><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Skill_Name]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Skill_Name], [Start_Date], [End_Date], [ContactType], [Reference_Person], [CourseCategory], [CourseSubCategory], [NQFLevel], [MainField], [SubField], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Training.Skills." & Session.SessionID)
            gridView.DataBind()
        End With
    End Sub

    Private Sub dgView_004_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_004.RowInserting

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_004"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim cmbSkill As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSkill_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)


        Dim dteStartDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteStartDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)
        Dim dteEndDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteEndDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim cmbReference As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReference_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbReferenceType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReferenceType_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbSubCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubcategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbNQFLevel As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbNQFLevel_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbField As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbField_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbSubfield As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubfield_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim txtComment As DevExpress.Web.ASPxEditors.ASPxMemo =
             TryCast(pgControl.FindControl("commentsEditor_004"), DevExpress.Web.ASPxEditors.ASPxMemo)

        With UDetails

            Dim SQLAudit As String = "<Tablename=Skills><CompanyNum=" & .CompanyNum & "><EmployeeNum=" & .EmployeeNum & ">"


            Dim sql As StringBuilder = New StringBuilder()
            sql.AppendLine("INSERT INTO SKILLS")
            sql.AppendLine("(CompanyNum, EmployeeNum, Skill_Name")
            If (dteStartDate.Value IsNot Nothing) Then sql.AppendLine(", Start_Date")
            If (dteEndDate.Value IsNot Nothing) Then sql.AppendLine(", End_Date")
            If (cmbReference.Value IsNot Nothing) Then sql.AppendLine(", Reference_Person")
            If (cmbReferenceType.Value IsNot Nothing) Then sql.AppendLine(", ContactType")
            If (cmbCategory.Value IsNot Nothing) Then sql.AppendLine(", CourseCategory")
            If (cmbSubCategory.Value IsNot Nothing) Then sql.AppendLine(", CourseSubCategory")
            If (cmbNQFLevel.Value IsNot Nothing) Then sql.AppendLine(", nqfLevel")
            If (cmbField.Value IsNot Nothing) Then sql.AppendLine(", MainField")
            If (cmbSubfield.Value IsNot Nothing) Then sql.AppendLine(", subfield")
            If (txtComment.Text IsNot Nothing) Then sql.AppendLine(", Comments")
            sql.AppendLine(")")
            sql.AppendLine($"Values ('{ .CompanyNum}', '{ .EmployeeNum}', '{cmbSkill.Value.ToString()}'")
            If (dteStartDate.Value IsNot Nothing) Then sql.AppendLine($", '{dteStartDate.Value.ToString()}'")
            If (dteEndDate.Value IsNot Nothing) Then sql.AppendLine($", '{dteEndDate.Value.ToString()}'")
            If (cmbReference.Value IsNot Nothing) Then sql.AppendLine($", '{cmbReference.Value.ToString()}'")
            If (cmbReferenceType.Value IsNot Nothing) Then sql.AppendLine($", '{cmbReferenceType.Value.ToString()}'")
            If (cmbCategory.Value IsNot Nothing) Then sql.AppendLine($", '{cmbCategory.Value.ToString()}'")
            If (cmbSubCategory.Value IsNot Nothing) Then sql.AppendLine($", '{cmbSubCategory.Value.ToString()}'")
            If (cmbNQFLevel.Value IsNot Nothing) Then sql.AppendLine($", '{cmbNQFLevel.Value.ToString()}'")
            If (cmbField.Value IsNot Nothing) Then sql.AppendLine($", '{cmbField.Value.ToString()}'")
            If (cmbSubfield.Value IsNot Nothing) Then sql.AppendLine($", '{cmbSubfield.Value.ToString()}'")
            If (txtComment.Text IsNot Nothing) Then sql.AppendLine($", '{txtComment.Text}'")
            sql.AppendLine(")")

            Try
                e.Cancel = ExecSQL(sql.ToString())
                gridView.CancelEdit()

                If (e.Cancel) Then
                    CancelEdit = True
                End If
            Catch ex As Exception

            Finally
                sql.Clear()
                sql = Nothing
                ClearFromCache("Data.Training.Skills." & Session.SessionID)
                LoadExpGrid(Session, dgView_004, "Training Tab", "<Tablename=Skills><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Skill_Name]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Skill_Name], [Start_Date], [End_Date], [ContactType], [Reference_Person], [CourseCategory], [CourseSubCategory], [NQFLevel], [MainField], [SubField], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Training.Skills." & Session.SessionID)
                gridView.DataBind()
            End Try
        End With


    End Sub

    Private Sub dgView_004_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_004.RowUpdating

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_004"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim cmbSkill As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSkill_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)


        Dim dteStartDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteStartDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)
        Dim dteEndDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteEndDate_004"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim cmbReference As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReference_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbReferenceType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbReferenceType_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbSubCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubcategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbNQFLevel As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbNQFLevel_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbField As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbField_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbSubfield As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbSubfield_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim txtComment As DevExpress.Web.ASPxEditors.ASPxMemo =
             TryCast(pgControl.FindControl("commentsEditor_004"), DevExpress.Web.ASPxEditors.ASPxMemo)

        With UDetails

            Dim sql As StringBuilder = New StringBuilder()

            sql.AppendLine("UPDATE SKILLS SET ")
            sql.AppendLine($"Start_Date = {If(dteStartDate.Value IsNot Nothing, "'" & dteStartDate.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",End_Date = {If(dteEndDate.Value IsNot Nothing, "'" & dteEndDate.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",Reference_Person = {If(cmbReference.Value IsNot Nothing, "'" & cmbReference.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",ContactType = {If(cmbReferenceType.Value IsNot Nothing, "'" & cmbReferenceType.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",CourseCategory = {If(cmbCategory.Value IsNot Nothing, "'" & cmbCategory.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",CourseSubCategory = {If(cmbSubCategory.Value IsNot Nothing, "'" & cmbSubCategory.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",NQFLevel = {If(cmbNQFLevel.Value IsNot Nothing, "'" & cmbNQFLevel.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",MainField = {If(cmbField.Value IsNot Nothing, "'" & cmbField.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",SubField = {If(cmbSubfield.Value IsNot Nothing, "'" & cmbSubfield.Value.ToString() & "'", "NULL")}")
            sql.AppendLine($",Comments = {If(txtComment.Text IsNot Nothing, "'" & txtComment.Text & "'", "NULL")}")
            sql.AppendLine($"WHERE CONCAT(CompanyNum, ' ', EmployeeNum, ' ', Skill_Name) = '{ .CompanyNum & " " & .EmployeeNum & " " & cmbSkill.Value.ToString()}'")


            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then
                CancelEdit = True
            End If

            ClearFromCache("Data.Training.Skills." & Session.SessionID)
            LoadExpGrid(Session, dgView_004, "Training Tab", "<Tablename=Skills><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Skill_Name]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Skill_Name], [Start_Date], [End_Date], [ContactType], [Reference_Person], [CourseCategory], [CourseSubCategory], [NQFLevel], [MainField], [SubField], [Comments]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Training.Skills." & Session.SessionID)
            gridView.DataBind()

        End With
    End Sub

    Private Sub dgView_004_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_004.RowValidating

        'e.RowError = ValidateExpGrid(sender, e)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_004"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        e.RowError = dgView_004_ValidateForm(pgControl)

    End Sub

    Private Function dgView_004_ValidateForm(ByVal pageControl As DevExpress.Web.ASPxTabControl.ASPxPageControl)
        Dim counter As Integer = 0


        Dim cmbSkill As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pageControl.FindControl("cmbSkill_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pageControl.FindControl("cmbCategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)
        Dim cmbSubCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pageControl.FindControl("cmbSubcategory_004"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (cmbSkill.Value Is Nothing) Then counter += 1
        If (cmbCategory.Value Is Nothing) Then counter += 1
        If (cmbSubCategory.Value Is Nothing) Then counter += 1

        If (counter > 0) Then Return "Please input a data for the list of fields with (*) symbol, it is indicated that it is a required field."
    End Function

    Private Sub dgView_004_StartRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs) Handles dgView_004.StartRowEditing

        editingKeyValue = e.EditingKeyValue
        Dim sCourseCategory As String = String.Empty
        Dim sMainField As String = String.Empty

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then

            sCourseCategory = sender.GetRowValuesByKeyValue(e.EditingKeyValue, "CourseCategory").ToString()

            sMainField = sender.GetRowValuesByKeyValue(e.EditingKeyValue, "MainField").ToString()

        End If

        If (sCourseCategory.Length > 0) Then LoadExpDS(dsCourseSubCategory, "select [CourseSubCategory] from [CourseSubCategoryLU] where ([CourseCategory] = '" & GetDataText(sCourseCategory) & "') order by [CourseSubCategory]")

        If (sMainField.Length > 0) Then LoadExpDS(dsSubField, "select [SubField] from [UnitStandardSubFieldLU] where ([MainField] = '" & GetDataText(sMainField) & "') order by [SubField]")

    End Sub

#End Region

#Region "Training Curriculum External"

    Protected Sub cmdCreate_008_Load(sender As Object, e As EventArgs)

        Dim btnCreate As DevExpress.Web.ASPxEditors.ASPxButton =
            TryCast(sender, DevExpress.Web.ASPxEditors.ASPxButton)

        If Not IsNothing(btnCreate) Then

            Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")

            visible = True ' delete this flag

            btnCreate.ClientVisible = visible
            btnCreate.Visible = visible

        End If

    End Sub

    Private Function dgView_008_ValidateCustomRequiredFields(e As DevExpress.Web.Data.ASPxDataValidationEventArgs) As String

        Dim counter As Integer = 0

        Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")
        visible = True ' delete this flag

        If (e.NewValues("ProgramTitle").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("Type").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("ProgramType").ToString() = String.Empty) Then counter = counter + 1

        If (Not e.NewValues("Type").ToString() = "Specialized Development Program") Then
            If (e.NewValues("Investment").ToString() = String.Empty) Then counter = counter + 1
        End If

        If (e.NewValues("ProviderName").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("VenueName").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("DateFrom").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("CompletionDate").ToString() = String.Empty) Then counter = counter + 1
        If (e.NewValues("ExistingStart").ToString() = String.Empty) Then counter = counter + 1

        If (visible) Then
            If (e.NewValues("DateReceived").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("BudgetCategory").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("Division").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("Department").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("Section").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("Level").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("Designation").ToString() = String.Empty) Then counter = counter + 1
            If (e.NewValues("LateRegistration").ToString() = String.Empty) Then counter = counter + 1
        End If

        If (counter > 0) Then Return "Please input a data for the list of fields with (*) symbol, it is indicated that it is a required field."

        If (e.NewValues("ProgramTitle").ToString() = String.Empty) Then Return "Program Title is required."
        If (e.NewValues("Type").ToString() = String.Empty) Then Return "Type is required."
        If (e.NewValues("ProgramType").ToString() = String.Empty) Then Return "Program Type is required."
        If (e.NewValues("Investment").ToString() = String.Empty) Then Return "Investment is required."
        If (e.NewValues("ProviderName").ToString() = String.Empty) Then Return "Provider is required."
        If (e.NewValues("VenueName").ToString() = String.Empty) Then Return "Venue is required."
        If (e.NewValues("DateFrom").ToString() = String.Empty) Then Return "Date From is required."
        If (e.NewValues("CompletionDate").ToString() = String.Empty) Then Return "Date To is required."
        If (e.NewValues("ExistingStart").ToString() = String.Empty) Then Return "Existing/Start is required."

        If (visible) Then
            If (e.NewValues("DateReceived").ToString() = String.Empty) Then Return "Date Received is required."
            If (e.NewValues("BudgetCategory").ToString() = String.Empty) Then Return "External Training Budget Category is required."
            If (e.NewValues("Division").ToString() = String.Empty) Then Return "Division is required."
            If (e.NewValues("Department").ToString() = String.Empty) Then Return "Department is required."
            If (e.NewValues("Section").ToString() = String.Empty) Then Return "Section is required."
            If (e.NewValues("Level").ToString() = String.Empty) Then Return "Level is required."
            If (e.NewValues("Designation").ToString() = String.Empty) Then Return "Designation is required."
            If (e.NewValues("LateRegistration").ToString() = String.Empty) Then Return "Late Registration is required."
        End If

        Dim investment As Object = e.NewValues("Investment")
        Dim remainingBudget As Object = e.NewValues("RemainingBudget")

        ' jalzate - 05/06/2019
        ' disabled 
        'If remainingBudget.ToString() <> String.Empty AndAlso investment.ToString() <> String.Empty AndAlso
        '   Decimal.Parse(remainingBudget.ToString()) - Decimal.Parse(investment.ToString()) < 0 Then

        '    Return "Investment (" + investment.ToString() + ") exceeds the Remaining Budget (" + remainingBudget.ToString() + ")."

        'End If

        Return String.Empty

    End Function

    Protected Sub dgView_008_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

        'If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

        '    Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
        '        DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        '    Dim trainingStatus As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "TrainingStatus")

        '    If trainingStatus.ToString() = "Completed" OrElse trainingStatus.ToString() = "PendingApproval" OrElse trainingStatus.ToString() = "Cancelled" Then



        '    End If

        'End If

    End Sub

    Protected Sub dgView_008_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_008"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")
        visible = True ' delete this flag

        pgControl.TabPages.FindByText("Training Budget Details").ClientVisible = visible
        pgControl.TabPages.FindByText("Post Training Info.").ClientVisible = visible

        'Contract Details Fields
        Dim txtPathID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPathID_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProgramTitle_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbProgramType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtInvestment_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim hfInvestment As HiddenField =
            TryCast(pgControl.FindControl("hfInvestment_008"), HiddenField)

        Dim txtCostUSD As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtCostUSD_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProvider_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtVenue_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateFrom_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateTo_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDuration_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteExistingStart As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteExistingStart_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtExpiry As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpiry_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtExpiryEndDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpiryEndDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtExpirySystemDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpirySystemDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtContractCompletion As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtContractCompletion_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtContractStatus As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtContractStatus_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteSeparationDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteSeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtExpirySeparationDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpirySeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMonthsUnserved As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtMonthsUnserved_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtUnservedContract As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtUnservedContract_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtPenalty As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPenalty_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)


        'Post Training Information Fields
        Dim cmbCertificate As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCertificate_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbTrainingMaterial As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbTrainingMaterial_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtPlannedEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtActualEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtPlannedPaxEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedPaxEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtActualPaxEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualPaxEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)


        'External Training Budget Detail Fields
        Dim dteDateReceived As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateReceived_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtBudgetCode_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbBudgetCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbBudgetCategory_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtRFPNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtRFPNum_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSAPDocNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSAPDocNum_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDivision_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDepartment_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSection_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtLevel As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLevel_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtDesignation As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDesignation_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSubCategory As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSubCategory_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbLateRegistration As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbLateRegistration_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        'Status
        Dim cmbTrainingStatus As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbTrainingStatus_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim hfTrainingStatus As HiddenField =
            TryCast(pgControl.FindControl("hfTrainingStatus_008"), HiddenField)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim compositeKey As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CompositeKey")
            Dim programTitle As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CourseName")
            Dim dateRegistered As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "DateRegistered")
            Dim completionDate As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CompletionDate")
            Dim providerName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ProviderName")
            Dim venueName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "VenueName")
            Dim trainingStatus As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "TrainingStatus")
            Dim remarks As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Remarks")
            Dim evaluated As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Evaluated")
            Dim pathID As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "PathID")

            Dim sql As StringBuilder = New StringBuilder()

            sql.AppendLine("SELECT TOP 1")
            sql.AppendLine("[PathID] = tp.[PathID],")
            sql.AppendLine("[ProgramTitle] = tp.[CourseName],")
            sql.AppendLine("[Provider] = tp.[ProviderName],")
            sql.AppendLine("[Venue] = tp.[VenueName],")
            sql.AppendLine("[Type] = ISNULL(tp.[cfType], ''),")
            sql.AppendLine("[ProgramType] = ISNULL(tp.[cfProgramType], ''),")
            sql.AppendLine("[Investment] = ISNULL(tp.[cfInvestment], ''),")
            sql.AppendLine("[InvestmentUSD] = ISNULL(tp.[cfInvestmentUSD], ''),")
            sql.AppendLine("[DateFrom] = ISNULL(tad.[DateFrom], ''),")
            sql.AppendLine("[DateTo] = ISNULL(tad.[DateTo], ''),")
            sql.AppendLine("[ExistingStart] = ISNULL(tp.[cfExistingStart], ''),")
            sql.AppendLine("[Duration] = ISNULL(tp.[cfDuration], ''),")
            sql.AppendLine("[Expiry] = ISNULL(tp.[cfExpiry], ''),")
            sql.AppendLine("[CELastDay] = ISNULL(tp.[cfCELastDay], ''),")
            sql.AppendLine("[CEDateToday] = ISNULL(tp.[cfCEDateToday], ''),")
            sql.AppendLine("[ContractCompletion] = ISNULL(tp.[cfContractCompletion], ''),")
            sql.AppendLine("[ContractStatus] = ISNULL(tp.[cfContractStatus], ''),")
            sql.AppendLine("[SeparationDate] = ISNULL(tp.[cfSeparationDate], ''),")
            sql.AppendLine("[CESeparation] = ISNULL(tp.[cfCESeparation], ''),")
            sql.AppendLine("[MonthsUnserved] = ISNULL(tp.[cfMonthsUnserved], ''),")
            sql.AppendLine("[UnservedContract] = ISNULL(tp.[cfUnservedContract], ''),")
            sql.AppendLine("[Penalty] = ISNULL(tp.[cfPenalty], ''),")

            sql.AppendLine("[Certificate] = ISNULL(tp.[cfCertificate], ''),")
            sql.AppendLine("[TrainingMaterial] = ISNULL(tp.[cfTrainingMaterial], ''),")
            sql.AppendLine("[PlannedEcho] = ISNULL(tp.[cfPlannedEcho], ''),")
            sql.AppendLine("[ActualEcho] = ISNULL(tp.[cfActualEcho], ''),")
            sql.AppendLine("[PlannedPaxEcho] = ISNULL(tp.[cfPlannedPaxEcho], ''),")
            sql.AppendLine("[ActualPaxEcho] = ISNULL(tp.[cfActualPaxEcho], ''),")

            sql.AppendLine("[DateReceived] = ISNULL(tp.[cfDateReceived], ''),")
            sql.AppendLine("[BudgetCode] = ISNULL(tp.[cfBudgetCode], ''),")
            sql.AppendLine("[BudgetCategory] = ISNULL(tp.[cfBudgetCategory], ''),")
            sql.AppendLine("[RFPNum] = ISNULL(tp.[cfRFPNum], ''),")
            sql.AppendLine("[SAPDocNum] = ISNULL(tp.[cfSAPDocNum], ''),")
            sql.AppendLine("[Division] = COALESCE(tp.[cfDivision], co.[Division], ''),")
            sql.AppendLine("[Department] = COALESCE(tp.[cfDepartment], co.[SubDivision], ''),")
            sql.AppendLine("[Section] = COALESCE(tp.[cfSection], co.[SubSubDivision], ''),")
            sql.AppendLine("[Level] = COALESCE(tp.[cfLevel], pers1.[OFOCode], ''),")
            sql.AppendLine("[Designation] = ISNULL(tp.[cfDesignation], ''),")
            sql.AppendLine("[SubCategory] = ISNULL(tp.[cfSubCategory], ''),")
            sql.AppendLine("[LateRegistration] = ISNULL(tp.[cfLateRegistration], '')")

            'MADE retrieval from TrainingCompleted/TrainingPlanned depending on TrainingStatus 
            'Having Completed Status will make all fields disabled future.
            sql.AppendLine(IIf(trainingStatus = "Completed", "FROM TrainingCompleted tp", "FROM TrainingPlanned tp"))
            sql.AppendLine("INNER JOIN TrainingAgreementForm taf")
            sql.AppendLine("    ON tp.[PathID] = taf.[PathID]")
            sql.AppendLine("INNER JOIN TAFProgramDetails tad")
            sql.AppendLine("    ON taf.[TAFID] = tad.[TAFID]")
            sql.AppendLine("INNER JOIN [Personnel1] pers1")
            sql.AppendLine("	ON taf.[EmployeeNum] = pers1.[EmployeeNum]")
            sql.AppendLine("INNER JOIN [Company] co")
            sql.AppendLine("	ON taf.[CompanyNum] = co.[CompanyNum]")
            sql.AppendLine("WHERE tp.[PathID] = '" & pathID & "'")

            Dim dtColumns As DataTable = GetSQLDT(sql.ToString())

            If (IsData(dtColumns)) Then

                Dim progTypeList As DataTable = New DataTable()

                Dim budgetCategoryList As DataTable = GetSQLDT("SELECT DISTINCT teb.[CategoryName] FROM TrainingExternalBudget teb")

                Dim investment As Double

                txtPathID.Text = dtColumns.Rows(0).Item("PathID").ToString()
                txtProgramTitle.Text = dtColumns.Rows(0).Item("ProgramTitle").ToString()
                txtProvider.Text = dtColumns.Rows(0).Item("Provider").ToString()
                txtVenue.Text = dtColumns.Rows(0).Item("Venue").ToString()
                cmbType.SelectedItem = cmbType.Items.FindByValue(dtColumns.Rows(0).Item("Type").ToString())

                If (dtColumns.Rows(0).Item("Type").ToString() = "Functional Training Program") Then

                    progTypeList = GetSQLDT("SELECT 'Business Trip (Local and Overseas)' [ProgramType] UNION ALL SELECT 'Public Seminar/External Training Program' [ProgramType] UNION ALL SELECT 'In-house Special Training Program' [ProgramType] ORDER BY [ProgramType] ASC")

                    txtInvestment.ReadOnly = False

                ElseIf (dtColumns.Rows(0).Item("Type").ToString() = "Specialized Development Program") Then

                    progTypeList = GetSQLDT("SELECT [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] ORDER BY [Program] ASC")

                    txtInvestment.Text = "0.00"

                    txtInvestment.ReadOnly = True

                End If

                If (Double.TryParse(txtInvestment.Text, investment) AndAlso investment > 0) Then

                    txtInvestment.Text = investment.ToString("#.00")

                Else

                    txtInvestment.Text = "0.00"

                End If

                If (IsData(progTypeList)) Then

                    For Each drProgType As DataRow In progTypeList.Rows

                        If Not drProgType.IsNull("ProgramType") Then

                            Dim programType As String = drProgType("ProgramType").ToString()

                            cmbProgramType.Items.Add(programType, programType)

                        End If

                    Next

                End If

                If (IsData(budgetCategoryList)) Then

                    For Each drBudgetCateg As DataRow In budgetCategoryList.Rows

                        If Not drBudgetCateg.IsNull("CategoryName") Then

                            Dim budgetCategory As String = drBudgetCateg("CategoryName").ToString()

                            cmbBudgetCategory.Items.Add(budgetCategory, budgetCategory)

                        End If

                    Next

                End If

                cmbProgramType.SelectedItem = cmbProgramType.Items.FindByValue(dtColumns.Rows(0).Item("ProgramType").ToString())
                txtInvestment.Text = dtColumns.Rows(0).Item("Investment").ToString()
                txtCostUSD.Text = dtColumns.Rows(0).Item("InvestmentUSD").ToString()
                dteDateFrom.Date = dtColumns.Rows(0).Item("DateFrom").ToString()
                dteDateTo.Date = dtColumns.Rows(0).Item("DateTo").ToString()
                txtDuration.Text = dtColumns.Rows(0).Item("Duration").ToString()
                If (dtColumns.Rows(0).Item("ExistingStart").ToString() <> String.Empty) Then dteExistingStart.Date = dtColumns.Rows(0).Item("ExistingStart").ToString()
                txtExpiry.Text = dtColumns.Rows(0).Item("Expiry").ToString()
                txtExpiryEndDate.Text = dtColumns.Rows(0).Item("CELastDay").ToString()
                txtExpirySystemDate.Text = dtColumns.Rows(0).Item("CEDateToday").ToString()
                txtContractCompletion.Text = dtColumns.Rows(0).Item("ContractCompletion").ToString()
                txtContractStatus.Text = dtColumns.Rows(0).Item("ContractStatus").ToString()

                hfInvestment.Value = txtInvestment.Text

                'txtSeparationDate.Text = dtColumns.Rows(0).Item("SeparationDate").ToString()
                If (dtColumns.Rows(0).Item("SeparationDate").ToString() <> String.Empty) Then dteSeparationDate.Date = dtColumns.Rows(0).Item("SeparationDate").ToString()
                txtExpirySeparationDate.Text = dtColumns.Rows(0).Item("CESeparation").ToString()
                txtMonthsUnserved.Text = dtColumns.Rows(0).Item("MonthsUnserved").ToString()
                txtUnservedContract.Text = dtColumns.Rows(0).Item("UnservedContract").ToString()
                txtPenalty.Text = dtColumns.Rows(0).Item("Penalty").ToString()

                cmbCertificate.SelectedItem = cmbCertificate.Items.FindByValue(dtColumns.Rows(0).Item("Certificate").ToString())
                cmbTrainingMaterial.SelectedItem = cmbTrainingMaterial.Items.FindByValue(dtColumns.Rows(0).Item("TrainingMaterial").ToString())
                txtPlannedEcho.Text = dtColumns.Rows(0).Item("PlannedEcho").ToString()
                txtActualEcho.Text = dtColumns.Rows(0).Item("ActualEcho").ToString()
                txtPlannedPaxEcho.Text = dtColumns.Rows(0).Item("PlannedPaxEcho").ToString()
                txtActualPaxEcho.Text = dtColumns.Rows(0).Item("ActualPaxEcho").ToString()

                If (dtColumns.Rows(0).Item("DateReceived").ToString() <> String.Empty) Then dteDateReceived.Date = dtColumns.Rows(0).Item("DateReceived").ToString()
                txtBudgetCode.Text = dtColumns.Rows(0).Item("BudgetCode").ToString()
                cmbBudgetCategory.SelectedItem = cmbBudgetCategory.Items.FindByValue(dtColumns.Rows(0).Item("BudgetCategory").ToString())
                txtRFPNum.Text = dtColumns.Rows(0).Item("RFPNum").ToString()
                txtSAPDocNum.Text = dtColumns.Rows(0).Item("SAPDocNum").ToString()
                txtDivision.Text = dtColumns.Rows(0).Item("Division").ToString()
                txtDepartment.Text = dtColumns.Rows(0).Item("Department").ToString()
                txtSection.Text = dtColumns.Rows(0).Item("Section").ToString()
                txtLevel.Text = dtColumns.Rows(0).Item("Level").ToString()
                txtDesignation.Text = dtColumns.Rows(0).Item("Designation").ToString()
                txtSubCategory.Text = dtColumns.Rows(0).Item("SubCategory").ToString()
                cmbLateRegistration.SelectedItem = cmbLateRegistration.Items.FindByValue(dtColumns.Rows(0).Item("LateRegistration").ToString())

            End If

            ' jalzate, amanriza - 05/17/2019
            ' added computation for training completion field on open of record
            If (txtDuration.Text <> String.Empty AndAlso dteExistingStart.Text <> String.Empty) Then

                Dim duration As Double = Double.Parse(txtDuration.Text.ToUpper().Replace("YEARS", ""))

                Dim totalMonths As Integer = (Math.Truncate(duration) * 12) + ((duration - Math.Truncate(duration)) * 0.12 * 100)

                Dim expiry As Date = Date.Parse(dteExistingStart.Date).AddMonths(totalMonths)

                Dim totalTrainingEnd As Integer = (expiry.Date - dteDateTo.Date).TotalDays

                Dim totalToday As Integer = (expiry.Date - Date.Today).TotalDays

                txtExpiry.Text = expiry

                txtExpiryEndDate.Text = totalTrainingEnd

                txtExpirySystemDate.Text = totalToday

                txtContractCompletion.Text = Decimal.Parse(IIf((((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100) < 0, 0, ((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100)).ToString("#.00")

                txtContractCompletion.Text = IIf(txtContractCompletion.Text = ".00", "0", txtContractCompletion.Text)

                If (Date.Today > expiry) Then

                    txtContractStatus.Text = "Served"

                ElseIf (Date.Today <= expiry) Then

                    txtContractStatus.Text = "Pending Completion"

                End If

                sql.Clear()

                sql.AppendLine("UPDATE TrainingPlanned")
                sql.AppendLine("SET ")
                sql.AppendLine("cfContractCompletion = " & Decimal.Parse(IIf((((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100) < 0, 0, ((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100)).ToString("#.00"))
                sql.AppendLine(", cfContractStatus = " & IIf(Date.Today <= expiry, "'Pending Completion'", "'Served'"))
                sql.AppendLine("WHERE PathID = '" & pathID & "';")

                sql.AppendLine("UPDATE TrainingCompleted")
                sql.AppendLine("SET cfContractCompletion = " & Decimal.Parse(IIf((((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100) < 0, 0, ((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100)).ToString("#.00"))
                sql.AppendLine(", cfContractStatus = " & IIf(Date.Today <= expiry, "'Pending Completion'", "'Served'"))
                sql.AppendLine("WHERE PathID = '" & pathID & "';")

                ExecSQL(sql.ToString())

            End If
            ' end

            cmbTrainingStatus.Items.Clear()

            If trainingStatus.ToString() = "Approved" Then

                cmbTrainingStatus.Items.Add(trainingStatus.ToString(), trainingStatus.ToString())
                cmbTrainingStatus.Items.Add("Completed", "Completed")
                cmbTrainingStatus.Items.Add("Cancelled", "Cancelled")

            Else

                cmbTrainingStatus.Items.Add(trainingStatus.ToString(), trainingStatus.ToString())

            End If

            cmbTrainingStatus.SelectedItem = cmbTrainingStatus.Items.FindByValue(trainingStatus.ToString())

            hfTrainingStatus.Value = trainingStatus.ToString()

            If trainingStatus.ToString() = "Completed" OrElse trainingStatus.ToString() = "PendingApproval" OrElse Not visible Then

                gridView.FindEditFormTemplateControl("UpdateButton").Visible = False

                For Each page As DevExpress.Web.ASPxTabControl.TabPage In pgControl.TabPages

                    For Each ctrl As Control In page.Controls

                        If TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxDateEdit Then

                            Dim dteControl As DevExpress.Web.ASPxEditors.ASPxDateEdit = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxDateEdit)

                            'dteControl.ReadOnly = True
                            'dteControl.DropDownButton.Visible = False
                            dteControl.Enabled = False

                        ElseIf TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxTextBox Then

                            Dim txtControl As DevExpress.Web.ASPxEditors.ASPxTextBox = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxTextBox)

                            txtControl.Enabled = False
                            'txtControl.ReadOnly = True

                        ElseIf TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxComboBox Then

                            If (Not (ctrl.ID = "cmbTrainingStatus_008" AndAlso trainingStatus.ToString() = "Approved")) Then

                                Dim cmbControl As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxComboBox)

                                'cmbControl.ReadOnly = True
                                cmbControl.Enabled = False

                            End If

                        End If

                    Next

                Next

            End If

        End If

        If (cmbBudgetCategory.Text <> String.Empty) Then cmbBudgetCategory.ReadOnly = True
        txtDuration.ReadOnly = True
        txtExpiry.ReadOnly = True
        txtExpiryEndDate.ReadOnly = True
        txtExpirySystemDate.ReadOnly = True
        txtContractCompletion.ReadOnly = True
        txtContractStatus.ReadOnly = True
        txtExpirySeparationDate.ReadOnly = True
        txtMonthsUnserved.ReadOnly = True
        txtUnservedContract.ReadOnly = True
        txtPenalty.ReadOnly = True
        txtBudgetCode.ReadOnly = True
        'enabled seperation date
        dteSeparationDate.ReadOnly = False

    End Sub

    Protected Sub dgView_008_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        GetGridValue_dgView_008(gridView, e.NewValues)

        e.RowError = dgView_008_ValidateCustomRequiredFields(e)

    End Sub

    Protected Sub dgView_008_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_008(gridView, e.NewValues)

            Dim pathID As Object = e.NewValues("PathID")
            Dim programTitle As Object = e.NewValues("ProgramTitle")
            Dim type As Object = e.NewValues("Type")
            Dim programType As Object = e.NewValues("ProgramType")
            Dim investment As Object = e.NewValues("Investment")
            Dim investmentUSD As Object = e.NewValues("InvestmentUSD")
            Dim dateFrom As Object = e.NewValues("DateFrom")
            Dim completionDate As Object = e.NewValues("CompletionDate")
            Dim providerName As Object = e.NewValues("ProviderName")
            Dim venueName As Object = e.NewValues("VenueName")
            Dim existingStart As Object = e.NewValues("ExistingStart")
            Dim duration As Object = e.NewValues("Duration")
            Dim expiry As Object = e.NewValues("Expiry")
            Dim expiryEndDate As Object = e.NewValues("ExpiryEndDate")
            Dim expirySystemDate As Object = e.NewValues("ExpirySystemDate")
            Dim contractCompletion As Object = e.NewValues("ContractCompletion")
            Dim contractStatus As Object = e.NewValues("ContractStatus")
            Dim separationDate As Object = e.NewValues("SeparationDate")
            Dim expirySeparationDate As Object = e.NewValues("ExpirySeparationDate")
            Dim monthsUnserved As Object = e.NewValues("MonthsUnserved")
            Dim unservedContract As Object = e.NewValues("UnservedContract")
            Dim penalty As Object = e.NewValues("Penalty")

            Dim certificate As Object = e.NewValues("Certificate")
            Dim trainingMaterial As Object = e.NewValues("TrainingMaterial")
            Dim plannedEcho As Object = e.NewValues("PlannedEcho")
            Dim actualEcho As Object = e.NewValues("ActualEcho")
            Dim plannedPaxEcho As Object = e.NewValues("PlannedPaxEcho")
            Dim actualPaxEcho As Object = e.NewValues("ActualPaxEcho")

            Dim dateReceived As Object = e.NewValues("DateReceived")
            Dim budgetCode As Object = e.NewValues("BudgetCode")
            Dim budgetCategory As Object = e.NewValues("BudgetCategory")
            Dim remainingBudget As Object = e.NewValues("RemainingBudget")
            Dim rfpNum As Object = e.NewValues("RFPNum")
            Dim sapDocNum As Object = e.NewValues("SAPDocNum")
            Dim division As Object = e.NewValues("Division")
            Dim department As Object = e.NewValues("Department")
            Dim section As Object = e.NewValues("Section")
            Dim level As Object = e.NewValues("Level")
            Dim designation As Object = e.NewValues("Designation")
            Dim subCategory As Object = e.NewValues("SubCategory")
            Dim lateRegistration As Object = e.NewValues("LateRegistration")

            'TO BE FOLLOWED VALIDATION
            'ValidateSpecializedFieldsValue(serviceAgreement, Nothing)

            sql = New StringBuilder()

            With UDetails

                sql.AppendLine("DECLARE @NewPathID BIGINT")
                sql.AppendLine("DECLARE @NewTAFID BIGINT")
                sql.AppendLine("")
                sql.AppendLine("INSERT INTO [ess.Path] (WFLUID) VALUES ('52')")
                sql.AppendLine("")
                sql.AppendLine("SELECT @NewPathID = scope_identity()")
                sql.AppendLine("")
                sql.AppendLine("DELETE [ess.Path] WHERE id = @NewPathID")
                sql.AppendLine("")
                sql.AppendLine("INSERT INTO [TrainingPlanned] (")
                sql.AppendLine("PathID,")
                sql.AppendLine("TrainingStatus,")
                sql.AppendLine("CompanyNum,")
                sql.AppendLine("EmployeeNum,")
                sql.AppendLine("CourseName,")
                sql.AppendLine("ProviderName,")
                sql.AppendLine("StartDate,")
                sql.AppendLine("CompletionDate,")
                sql.AppendLine("VenueName,")
                sql.AppendLine("InternalCourse,")
                sql.AppendLine("CapturedByUsername,")
                sql.AppendLine("cfType,")
                sql.AppendLine("cfProgramType,")
                sql.AppendLine("cfInvestment,")
                sql.AppendLine("cfInvestmentUSD,")
                sql.AppendLine("cfExistingStart,")
                sql.AppendLine("cfDuration,")
                sql.AppendLine("cfExpiry,")
                sql.AppendLine("cfCELastDay,")
                sql.AppendLine("cfCEDateToday,")
                sql.AppendLine("cfContractCompletion,")
                sql.AppendLine("cfContractStatus,")
                sql.AppendLine("cfSeparationDate,")
                sql.AppendLine("cfCESeparation,")
                sql.AppendLine("cfMonthsUnserved,")
                sql.AppendLine("cfUnservedContract,")
                sql.AppendLine("cfPenalty,")

                sql.AppendLine("cfCertificate,")
                sql.AppendLine("cfTrainingMaterial,")
                sql.AppendLine("cfPlannedEcho,")
                sql.AppendLine("cfActualEcho,")
                sql.AppendLine("cfPlannedPaxEcho,")
                sql.AppendLine("cfActualPaxEcho,")

                sql.AppendLine("cfDateReceived,")
                sql.AppendLine("cfBudgetCode,")
                sql.AppendLine("cfBudgetCategory,")
                sql.AppendLine("cfRFPNum,")
                sql.AppendLine("cfSAPDocNum,")
                sql.AppendLine("cfDivision,")
                sql.AppendLine("cfDepartment,")
                sql.AppendLine("cfSection,")
                sql.AppendLine("cfLevel,")
                sql.AppendLine("cfDesignation,")
                sql.AppendLine("cfSubCategory,")
                sql.AppendLine("cfLateRegistration")
                sql.AppendLine(")")
                sql.AppendLine("VALUES (")
                sql.AppendLine("@NewPathID,")
                sql.AppendLine("'Approved',")
                sql.AppendLine("'" & .CompanyNum & "', ")
                sql.AppendLine("'" & .EmployeeNum & "', ")
                sql.AppendLine("'" & programTitle.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & providerName.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & dateFrom.ToString() & "',")
                sql.AppendLine("'" & completionDate.ToString() & "',")
                sql.AppendLine("'" & venueName.ToString().Replace("'", "''") & "',")
                sql.AppendLine("0,")
                sql.AppendLine("'" & Session("LoggedOn").EmployeeNum & "',")
                sql.AppendLine("'" & type.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & programType.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & investment.ToString() & "',")
                sql.AppendLine("'" & investmentUSD.ToString() & "',")
                sql.AppendLine("'" & existingStart.ToString() & "',")
                sql.AppendLine("'" & duration.ToString() & "',")
                sql.AppendLine("'" & expiry.ToString() & "',")
                sql.AppendLine("'" & expiryEndDate.ToString() & "',")
                sql.AppendLine("'" & expirySystemDate.ToString() & "',")
                sql.AppendLine("'" & contractCompletion.ToString() & "',")
                sql.AppendLine("'" & contractStatus.ToString() & "',")
                sql.AppendLine("'" & separationDate.ToString() & "',")
                sql.AppendLine("'" & expirySeparationDate.ToString() & "',")
                sql.AppendLine("'" & monthsUnserved.ToString() & "',")
                sql.AppendLine("'" & unservedContract.ToString() & "',")
                sql.AppendLine("'" & penalty.ToString() & "',")

                sql.AppendLine("'" & certificate.ToString() & "',")
                sql.AppendLine("'" & trainingMaterial.ToString() & "',")
                sql.AppendLine("'" & plannedEcho.ToString() & "',")
                sql.AppendLine("'" & actualEcho.ToString() & "',")
                sql.AppendLine("'" & plannedPaxEcho.ToString() & "',")
                sql.AppendLine("'" & actualPaxEcho.ToString() & "',")

                sql.AppendLine("'" & dateReceived.ToString() & "',")
                sql.AppendLine("'" & budgetCode.ToString() & "',")
                sql.AppendLine("'" & budgetCategory.ToString() & "',")
                sql.AppendLine("'" & rfpNum.ToString() & "',")
                sql.AppendLine("'" & sapDocNum.ToString() & "',")
                sql.AppendLine("'" & division.ToString() & "',")
                sql.AppendLine("'" & department.ToString() & "',")
                sql.AppendLine("'" & section.ToString() & "',")
                sql.AppendLine("'" & level.ToString() & "',")
                sql.AppendLine("'" & designation.ToString() & "',")
                sql.AppendLine("'" & subCategory.ToString() & "',")
                sql.AppendLine("'" & lateRegistration.ToString() & "'")
                sql.AppendLine(")")

                sql.AppendLine("INSERT INTO [TrainingAgreementForm] (")
                sql.AppendLine("[EmployeeNum],")
                sql.AppendLine("[CompanyNum],")
                sql.AppendLine("[Name],")
                sql.AppendLine("[ExternalPositionTitle],")
                sql.AppendLine("[MobileNum],")
                sql.AppendLine("[RTANum],")
                sql.AppendLine("[DatePrepared],")
                sql.AppendLine("[Status],")
                sql.AppendLine("[CapturedBy],")
                sql.AppendLine("[CapturedOn],")
                sql.AppendLine("[pathID],")
                sql.AppendLine("[Category],")
                sql.AppendLine("[BudgetCode],")
                sql.AppendLine("[BeginningBalance],")
                sql.AppendLine("[EndingBalance],")
                sql.AppendLine("[Objectives1],")
                sql.AppendLine("[Objectives2],")
                sql.AppendLine("[Objectives3],")
                sql.AppendLine("[Justification1],")
                sql.AppendLine("[Justification2],")
                sql.AppendLine("[Justification3]")
                sql.AppendLine(")")
                sql.AppendLine("VALUES(")
                sql.AppendLine("'" & .EmployeeNum & "',")
                sql.AppendLine("'" & .CompanyNum & "',")
                sql.AppendLine("'" & String.Format("{0}, {1}", .Surname, .Name) & "',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("GETDATE(),")
                sql.AppendLine("'Approved',")
                sql.AppendLine("'" & String.Format("{0}, {1}", Session("LoggedOn").Surname, Session("LoggedOn").Name) & "',")
                sql.AppendLine("GETDATE(),")
                sql.AppendLine("@NewPathID,")
                sql.AppendLine("'" & budgetCategory.ToString() & "',")
                sql.AppendLine("'" & budgetCode.ToString() & "',")
                sql.AppendLine("'" & remainingBudget.ToString() & "',")

                If (remainingBudget.ToString() <> String.Empty AndAlso investment.ToString() <> String.Empty) Then
                    sql.AppendLine("CONVERT(DECIMAL(16,2), '" & Decimal.Parse(remainingBudget.ToString()) - Decimal.Parse(investment.ToString()) & "'),")
                ElseIf (remainingBudget.ToString() <> String.Empty) Then
                    sql.AppendLine("CONVERT(Decimal(16,2), '" & remainingBudget.ToString() & "'),")
                Else
                    sql.AppendLine("'',")
                End If

                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required',")
                sql.AppendLine("'Required'")
                sql.AppendLine(")")
                sql.AppendLine("")
                sql.AppendLine("SELECT @NewTAFID = scope_identity()")

                sql.AppendLine("INSERT INTO [TAFProgramDetails] (")
                sql.AppendLine("[type],")
                sql.AppendLine("[programType],")
                sql.AppendLine("[programTitle],")
                sql.AppendLine("[Provider],")
                sql.AppendLine("[dateFrom],")
                sql.AppendLine("[DateTo],")
                sql.AppendLine("[Venue],")
                sql.AppendLine("[investment],")
                sql.AppendLine("[duration],")
                sql.AppendLine("[existingStart],")
                sql.AppendLine("[expiry],")
                sql.AppendLine("[TAFID]")
                sql.AppendLine(")")
                sql.AppendLine("VALUES(")
                sql.AppendLine("'" & type.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & programType.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & programTitle.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & providerName.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & dateFrom & "',")
                sql.AppendLine("'" & completionDate & "',")
                sql.AppendLine("'" & venueName.ToString().Replace("'", "''") & "',")
                sql.AppendLine("'" & investment & "',")
                sql.AppendLine("'" & duration & "',")
                sql.AppendLine("'" & existingStart & "',")
                sql.AppendLine("'" & expiry & "',")
                sql.AppendLine("@NewTAFID")
                sql.AppendLine(")")

                If remainingBudget.ToString() <> String.Empty AndAlso
                   budgetCategory.ToString() <> String.Empty AndAlso
                   dateFrom.ToString() <> String.Empty Then

                    sql.AppendLine("UPDATE tem SET")
                    sql.AppendLine("tem.[BudgetCode] = CONVERT(VARCHAR, tem.[Year]) + tem.[Text] + REPLICATE(0, LEN(tem.[SequenceNum]) - LEN(ABS(tem.[SequenceNum]) + 1)) + CONVERT(VARCHAR, ABS(tem.[SequenceNum]) + 1), ")
                    sql.AppendLine("tem.[SequenceNum] = REPLICATE(0, Len(tem.[SequenceNum]) - Len(ABS(tem.[SequenceNum]) + 1)) + CONVERT(VARCHAR, ABS(tem.[SequenceNum]) + 1)")
                    sql.AppendLine("FROM TrainingExternalBudgetMonitoring tem")
                    sql.AppendLine("WHERE tem.[Year] = Year('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND tem.[CategoryName] = '" & budgetCategory.ToString() & "'")

                    sql.AppendLine("UPDATE teb SET")

                    If (remainingBudget.ToString() <> String.Empty AndAlso investment.ToString() <> String.Empty) Then

                        sql.AppendLine("teb.[RemainingBudget] = CONVERT(DECIMAL(16,2), '" & Decimal.Parse(remainingBudget.ToString()) - Decimal.Parse(investment.ToString()) & "')")

                    ElseIf (remainingBudget.ToString() <> String.Empty) Then

                        sql.AppendLine("teb.[RemainingBudget] = CONVERT(Decimal(16,2), '" & remainingBudget.ToString() & "')")

                    End If

                    sql.AppendLine("FROM TrainingExternalBudget teb")
                    sql.AppendLine("WHERE teb.[Year] = YEAR('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND teb.[Month] = MONTH('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND teb.[CategoryName] = '" & budgetCategory.ToString() & "'")

                End If

            End With

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_008_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_008(gridView, e.NewValues)

            Dim pathID As Object = e.NewValues("PathID")
            Dim programTitle As Object = e.NewValues("ProgramTitle")
            Dim type As Object = e.NewValues("Type")
            Dim programType As Object = e.NewValues("ProgramType")
            Dim investment As Object = e.NewValues("Investment")
            Dim investmentOrig As Object = e.NewValues("Investment_Orig")
            Dim investmentUSD As Object = e.NewValues("InvestmentUSD")
            Dim dateFrom As Object = e.NewValues("DateFrom")
            Dim completionDate As Object = e.NewValues("CompletionDate")
            Dim providerName As Object = e.NewValues("ProviderName")
            Dim venueName As Object = e.NewValues("VenueName")
            Dim existingStart As Object = e.NewValues("ExistingStart")
            Dim duration As Object = e.NewValues("Duration")
            Dim expiry As Object = e.NewValues("Expiry")
            Dim expiryEndDate As Object = e.NewValues("ExpiryEndDate")
            Dim expirySystemDate As Object = e.NewValues("ExpirySystemDate")
            Dim contractCompletion As Object = e.NewValues("ContractCompletion")
            Dim contractStatus As Object = e.NewValues("ContractStatus")
            Dim separationDate As Object = e.NewValues("SeparationDate")
            Dim expirySeparationDate As Object = e.NewValues("ExpirySeparationDate")
            Dim monthsUnserved As Object = e.NewValues("MonthsUnserved")
            Dim unservedContract As Object = e.NewValues("UnservedContract")
            Dim penalty As Object = e.NewValues("Penalty")

            Dim certificate As Object = e.NewValues("Certificate")
            Dim trainingMaterial As Object = e.NewValues("TrainingMaterial")
            Dim plannedEcho As Object = e.NewValues("PlannedEcho")
            Dim actualEcho As Object = e.NewValues("ActualEcho")
            Dim plannedPaxEcho As Object = e.NewValues("PlannedPaxEcho")
            Dim actualPaxEcho As Object = e.NewValues("ActualPaxEcho")

            Dim dateReceived As Object = e.NewValues("DateReceived")
            Dim budgetCode As Object = e.NewValues("BudgetCode")
            Dim budgetCategory As Object = e.NewValues("BudgetCategory")
            Dim remainingBudget As Object = e.NewValues("RemainingBudget")
            Dim rfpNum As Object = e.NewValues("RFPNum")
            Dim sapDocNum As Object = e.NewValues("SAPDocNum")
            Dim division As Object = e.NewValues("Division")
            Dim department As Object = e.NewValues("Department")
            Dim section As Object = e.NewValues("Section")
            Dim level As Object = e.NewValues("Level")
            Dim designation As Object = e.NewValues("Designation")
            Dim subCategory As Object = e.NewValues("SubCategory")
            Dim lateRegistration As Object = e.NewValues("LateRegistration")

            Dim trainingStatus As Object = e.NewValues("TrainingStatus")
            Dim trainingStatusOrig As Object = e.NewValues("TrainingStatus_Orig")

            'TO BE FOLLOWED VALIDATION
            'ValidateSpecializedFieldsValue(e)

            sql = New StringBuilder()

            With UDetails

                If (trainingStatus.ToString() = "Completed") Then

                    sql.AppendLine("INSERT INTO [TrainingCompleted] (")
                    sql.AppendLine("PathID,")
                    sql.AppendLine("TrainingStatus,")
                    sql.AppendLine("CompanyNum,")
                    sql.AppendLine("EmployeeNum,")
                    sql.AppendLine("CourseName,")
                    sql.AppendLine("ProviderName,")
                    sql.AppendLine("StartDate,")
                    sql.AppendLine("CompletionDate,")
                    sql.AppendLine("VenueName,")
                    sql.AppendLine("InternalCourse,")
                    sql.AppendLine("CapturedByUsername,")
                    sql.AppendLine("cfType,")
                    sql.AppendLine("cfProgramType,")
                    sql.AppendLine("cfInvestment,")
                    sql.AppendLine("cfInvestmentUSD,")
                    sql.AppendLine("cfExistingStart,")
                    sql.AppendLine("cfDuration,")
                    sql.AppendLine("cfExpiry,")
                    sql.AppendLine("cfCELastDay,")
                    sql.AppendLine("cfCEDateToday,")
                    sql.AppendLine("cfContractCompletion,")
                    sql.AppendLine("cfContractStatus,")
                    sql.AppendLine("cfSeparationDate,")
                    sql.AppendLine("cfCESeparation,")
                    sql.AppendLine("cfMonthsUnserved,")
                    sql.AppendLine("cfUnservedContract,")
                    sql.AppendLine("cfPenalty,")

                    sql.AppendLine("cfCertificate,")
                    sql.AppendLine("cfTrainingMaterial,")
                    sql.AppendLine("cfPlannedEcho,")
                    sql.AppendLine("cfActualEcho,")
                    sql.AppendLine("cfPlannedPaxEcho,")
                    sql.AppendLine("cfActualPaxEcho,")

                    sql.AppendLine("cfDateReceived,")
                    sql.AppendLine("cfBudgetCode,")
                    sql.AppendLine("cfBudgetCategory,")
                    sql.AppendLine("cfRFPNum,")
                    sql.AppendLine("cfSAPDocNum,")
                    sql.AppendLine("cfDivision,")
                    sql.AppendLine("cfDepartment,")
                    sql.AppendLine("cfSection,")
                    sql.AppendLine("cfLevel,")
                    sql.AppendLine("cfDesignation,")
                    sql.AppendLine("cfSubCategory,")
                    sql.AppendLine("cfLateRegistration")
                    sql.AppendLine(")")

                    sql.AppendLine("SELECT ")
                    sql.AppendLine("PathID,")
                    sql.AppendLine("'Completed',")
                    sql.AppendLine("CompanyNum,")
                    sql.AppendLine("EmployeeNum,")
                    sql.AppendLine("CourseName,")
                    sql.AppendLine("ProviderName,")
                    sql.AppendLine("StartDate,")
                    sql.AppendLine("CompletionDate,")
                    sql.AppendLine("VenueName,")
                    sql.AppendLine("InternalCourse,")
                    sql.AppendLine("CapturedByUsername,")
                    sql.AppendLine("cfType,")
                    sql.AppendLine("cfProgramType,")
                    sql.AppendLine("cfInvestment,")
                    sql.AppendLine("cfInvestmentUSD,")
                    sql.AppendLine("cfExistingStart,")
                    sql.AppendLine("cfDuration,")
                    sql.AppendLine("cfExpiry,")
                    sql.AppendLine("cfCELastDay,")
                    sql.AppendLine("cfCEDateToday,")
                    sql.AppendLine("cfContractCompletion,")
                    sql.AppendLine("cfContractStatus,")
                    sql.AppendLine("cfSeparationDate,")
                    sql.AppendLine("cfCESeparation,")
                    sql.AppendLine("cfMonthsUnserved,")
                    sql.AppendLine("cfUnservedContract,")
                    sql.AppendLine("cfPenalty,")
                    sql.AppendLine("cfCertificate,")
                    sql.AppendLine("cfTrainingMaterial,")
                    sql.AppendLine("cfPlannedEcho,")
                    sql.AppendLine("cfActualEcho,")
                    sql.AppendLine("cfPlannedPaxEcho,")
                    sql.AppendLine("cfActualPaxEcho,")
                    sql.AppendLine("cfDateReceived,")
                    sql.AppendLine("cfBudgetCode,")
                    sql.AppendLine("cfBudgetCategory,")
                    sql.AppendLine("cfRFPNum,")
                    sql.AppendLine("cfSAPDocNum,")
                    sql.AppendLine("cfDivision,")
                    sql.AppendLine("cfDepartment,")
                    sql.AppendLine("cfSection,")
                    sql.AppendLine("cfLevel,")
                    sql.AppendLine("cfDesignation,")
                    sql.AppendLine("cfSubCategory,")
                    sql.AppendLine("cfLateRegistration")
                    sql.AppendLine("FROM [TrainingPlanned]")
                    sql.AppendLine("WHERE PathID = '" & pathID.ToString() & "'")

                    ' jalzate - 05/07/2019
                    ' insert into skills
                    sql.AppendLine("insert into Skills")
                    sql.AppendLine("select ")
                    sql.AppendLine("	b.CompanyNum,")
                    sql.AppendLine("	b.EmployeeNum,")
                    sql.AppendLine("	b.StartDate,")
                    sql.AppendLine("	SkillName,")
                    sql.AppendLine("	'',")
                    sql.AppendLine("	b.CompletionDate,")
                    sql.AppendLine("	'', ")
                    sql.AppendLine("	ContactType, ")
                    sql.AppendLine("	a.CourseCategory,")
                    sql.AppendLine("	a.CourseSubCategory,")
                    sql.AppendLine("	a.NQFLevel,")
                    sql.AppendLine("	MainField, ")
                    sql.AppendLine("	SubField,")
                    sql.AppendLine("	'',")
                    sql.AppendLine("	'',")
                    sql.AppendLine("	b.PathID")
                    sql.AppendLine("from ")
                    sql.AppendLine("	CourseSkillsLU a inner join")
                    sql.AppendLine("	TrainingPlanned b on a.CourseName = b.CourseName")
                    sql.AppendLine("where ")
                    sql.AppendLine("	PathID = '" & pathID.ToString() & "'")

                    sql.AppendLine("DELETE tp ")
                    sql.AppendLine("FROM [TrainingPlanned] tp")
                    sql.AppendLine("WHERE tp.[PathID] = '" & pathID.ToString() & "'")

                Else

                    sql.AppendLine("UPDATE tp")
                    sql.AppendLine("SET")
                    sql.AppendLine("tp.[CompanyNum] = '" & .CompanyNum & "',")
                    sql.AppendLine("tp.[EmployeeNum] = '" & .EmployeeNum & "',")
                    sql.AppendLine("tp.[CourseName] = '" & programTitle.ToString().Replace("'", "''") & "',")
                    sql.AppendLine("tp.[ProviderName] = '" & providerName.ToString().Replace("'", "''") & "',")
                    sql.AppendLine("tp.[StartDate] = '" & dateFrom.ToString() & "',")
                    sql.AppendLine("tp.[CompletionDate] = '" & completionDate.ToString() & "',")
                    sql.AppendLine("tp.[VenueName] = '" & venueName.ToString().Replace("'", "''") & "',")
                    sql.AppendLine("tp.[InternalCourse] = 0,")
                    sql.AppendLine("tp.[CapturedByUsername] = '" & Session("LoggedOn").EmployeeNum & "',")
                    sql.AppendLine("tp.[cfType] = '" & type.ToString().Replace("'", "''") & "',")
                    sql.AppendLine("tp.[cfProgramType] = '" & programType.ToString().Replace("'", "''") & "',")
                    sql.AppendLine("tp.[cfInvestment] = '" & investment.ToString() & "',")
                    sql.AppendLine("tp.[cfInvestmentUSD] = '" & investmentUSD.ToString() & "',")
                    sql.AppendLine("tp.[cfExistingStart] = '" & existingStart.ToString() & "',")
                    sql.AppendLine("tp.[cfDuration] = '" & duration.ToString() & "',")
                    sql.AppendLine("tp.[cfExpiry] = '" & expiry.ToString() & "',")
                    sql.AppendLine("tp.[cfCELastDay] = '" & expiryEndDate.ToString() & "',")
                    sql.AppendLine("tp.[cfCEDateToday] = '" & expirySystemDate.ToString() & "',")
                    sql.AppendLine("tp.[cfContractCompletion] = '" & contractCompletion.ToString() & "',")
                    sql.AppendLine("tp.[cfContractStatus] = '" & contractStatus.ToString() & "',")
                    sql.AppendLine("tp.[cfSeparationDate] = '" & separationDate.ToString() & "',")
                    sql.AppendLine("tp.[cfCESeparation] = '" & expirySeparationDate.ToString() & "',")
                    sql.AppendLine("tp.[cfMonthsUnserved] = '" & monthsUnserved.ToString() & "',")
                    sql.AppendLine("tp.[cfUnservedContract] = '" & unservedContract.ToString() & "',")

                    sql.AppendLine("tp.[cfCertificate] = '" & certificate.ToString() & "',")
                    sql.AppendLine("tp.[cfTrainingMaterial] = '" & trainingMaterial.ToString() & "',")
                    sql.AppendLine("tp.[cfPlannedEcho] = '" & plannedEcho.ToString() & "',")
                    sql.AppendLine("tp.[cfActualEcho] = '" & actualEcho.ToString() & "',")
                    sql.AppendLine("tp.[cfPlannedPaxEcho] = '" & plannedPaxEcho.ToString() & "',")
                    sql.AppendLine("tp.[cfActualPaxEcho] = '" & actualPaxEcho.ToString() & "',")

                    sql.AppendLine("tp.[cfDateReceived] = '" & dateReceived.ToString() & "',")
                    sql.AppendLine("tp.[cfBudgetCode] = '" & budgetCode.ToString() & "',")
                    sql.AppendLine("tp.[cfBudgetCategory] = '" & budgetCategory.ToString() & "',")
                    sql.AppendLine("tp.[cfRFPNum] = '" & rfpNum.ToString() & "',")
                    sql.AppendLine("tp.[cfSAPDocNum] = '" & sapDocNum.ToString() & "',")
                    sql.AppendLine("tp.[cfDivision] = '" & division.ToString() & "',")
                    sql.AppendLine("tp.[cfDepartment] = '" & department.ToString() & "',")
                    sql.AppendLine("tp.[cfSection] = '" & section.ToString() & "',")
                    sql.AppendLine("tp.[cfLevel] = '" & level.ToString() & "',")
                    sql.AppendLine("tp.[cfDesignation] = '" & designation.ToString() & "',")
                    sql.AppendLine("tp.[cfSubCategory] = '" & subCategory.ToString() & "',")
                    sql.AppendLine("tp.[cfLateRegistration] = '" & lateRegistration.ToString() & "',")
                    sql.AppendLine("tp.[TrainingStatus] = '" & trainingStatus.ToString() & "',")

                    sql.AppendLine("tp.[cfPenalty] = '" & penalty.ToString() & "'")
                    sql.AppendLine("FROM [TrainingPlanned] tp")
                    sql.AppendLine("WHERE tp.[PathID] = '" & pathID.ToString() & "'")

                End If

                sql.AppendLine("UPDATE taf SET")
                sql.AppendLine("taf.[EmployeeNum] = '" & .EmployeeNum & "',")
                sql.AppendLine("taf.[CompanyNum] = '" & .CompanyNum & "',")
                sql.AppendLine("taf.[Name] = '" & String.Format("{0}, {1}", .Surname, .Name) & "',")
                sql.AppendLine("taf.[ExternalPositionTitle] = 'Required',")
                sql.AppendLine("taf.[MobileNum] = 'Required',")
                sql.AppendLine("taf.[RTANum] = 'Required',")
                sql.AppendLine("taf.[DatePrepared] = GETDATE(),")
                sql.AppendLine("taf.[Status] = '" & trainingStatus.ToString() & "',")

                Dim investmentDiff As Decimal = 0

                If trainingStatus.ToString() = "Approved" Then

                    If investment.ToString() <> investmentOrig.ToString() Then

                        investmentDiff =
                            Decimal.Parse(investment.ToString()) -
                            Decimal.Parse(investmentOrig.ToString())

                    End If

                    'Needed for Category Selection
                    If remainingBudget.ToString() <> String.Empty AndAlso
                       budgetCategory.ToString() <> String.Empty AndAlso
                       investment.ToString() <> investmentOrig.ToString() Then

                        sql.AppendLine("taf.[Category] = '" & budgetCategory.ToString() & "',")
                        sql.AppendLine("taf.[BudgetCode] = '" & budgetCode.ToString() & "',")
                        sql.AppendLine("taf.[BeginningBalance] = '" & remainingBudget.ToString() & "',")
                        sql.AppendLine("taf.[EndingBalance] = CONVERT(DECIMAL(16,2), '" & (Decimal.Parse(remainingBudget.ToString()) - investmentDiff) & "'),")

                    End If

                End If

                sql.AppendLine("taf.[Objectives1] = 'Required',")
                sql.AppendLine("taf.[Objectives2] = 'Required',")
                sql.AppendLine("taf.[Objectives3] = 'Required',")
                sql.AppendLine("taf.[Justification1] = 'Required',")
                sql.AppendLine("taf.[Justification2] = 'Required',")
                sql.AppendLine("taf.[Justification3] = 'Required'")
                sql.AppendLine("FROM TrainingAgreementForm taf")
                sql.AppendLine("INNER JOIN TAFProgramDetails tad")
                sql.AppendLine("    ON taf.TAFID = tad.TAFID")
                sql.AppendLine("WHERE taf.[PathID] = '" & pathID.ToString() & "'")

                sql.AppendLine("UPDATE tad SET")
                sql.AppendLine("tad.[Type] = '" & type.ToString().Replace("'", "''") & "',")
                sql.AppendLine("tad.[ProgramType] = '" & programType.ToString() & "',")
                sql.AppendLine("tad.[ProgramTitle] = '" & programTitle.ToString() & "',")
                sql.AppendLine("tad.[Provider] = '" & providerName.ToString() & "',")
                sql.AppendLine("tad.[DateFrom] = '" & dateFrom.ToString() & "',")
                sql.AppendLine("tad.[DateTo] = '" & completionDate.ToString() & "',")
                sql.AppendLine("tad.[Venue] = '" & venueName.ToString() & "',")
                sql.AppendLine("tad.[Investment] = '" & investment.ToString() & "',")
                sql.AppendLine("tad.[Duration] = '" & duration.ToString() & "',")
                sql.AppendLine("tad.[ExistingStart] = '" & existingStart.ToString() & "',")
                sql.AppendLine("tad.[Expiry] = '" & expiry.ToString() & "'")
                sql.AppendLine("FROM TAFProgramDetails tad")
                sql.AppendLine("INNER JOIN TrainingAgreementForm taf")
                sql.AppendLine("    ON tad.[TAFID] = taf.[TAFID]")
                sql.AppendLine("WHERE taf.[PathID] = '" & pathID.ToString() & "'")

                If trainingStatusOrig.ToString() = "Approved" AndAlso
                   remainingBudget.ToString() <> String.Empty AndAlso
                   budgetCategory.ToString() <> String.Empty AndAlso
                   dateFrom.ToString() <> String.Empty Then

                    sql.AppendLine("UPDATE tem SET")
                    sql.AppendLine("tem.[BudgetCode] = CONVERT(VARCHAR, tem.[Year]) + tem.[Text] + REPLICATE(0, LEN(tem.[SequenceNum]) - LEN(ABS(tem.[SequenceNum]) + 1)) + CONVERT(VARCHAR, ABS(tem.[SequenceNum]) + 1), ")
                    sql.AppendLine("tem.[SequenceNum] = REPLICATE(0, Len(tem.[SequenceNum]) - Len(ABS(tem.[SequenceNum]) + 1)) + CONVERT(VARCHAR, ABS(tem.[SequenceNum]) + 1)")
                    sql.AppendLine("FROM TrainingExternalBudgetMonitoring tem")
                    sql.AppendLine("WHERE tem.[Year] = Year('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND tem.[CategoryName] = '" & budgetCategory.ToString() & "'")

                    sql.AppendLine("UPDATE teb SET")

                    If trainingStatus.ToString() = "Cancelled" Then

                        sql.AppendLine("teb.[RemainingBudget] = teb.[RemainingBudget] + CONVERT(DECIMAL(16,2), '" & Decimal.Parse(investment.ToString()) & "')")

                    ElseIf trainingStatus.ToString() = "Approved" AndAlso
                           investment.ToString() <> investmentOrig.ToString() Then

                        sql.AppendLine("teb.[RemainingBudget] = CONVERT(DECIMAL(16,2), '" & (Decimal.Parse(remainingBudget.ToString()) - investmentDiff) & "')")

                    Else

                        sql.AppendLine("teb.[CompanyNum] = teb.[CompanyNum]")

                    End If

                    sql.AppendLine("FROM TrainingExternalBudget teb")
                    sql.AppendLine("WHERE teb.[Year] = YEAR('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND teb.[Month] = MONTH('" & dateFrom.ToString() & "')")
                    sql.AppendLine("AND teb.[CategoryName] = '" & budgetCategory.ToString() & "'")

                End If

            End With

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    ''' <summary>
    ''' NO DELETE FUNCTION YET
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub dgView_008_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        'Dim sql As StringBuilder = Nothing

        'Try

        '    Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
        '        DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        '    Dim programDetailsID As Object = e.Values("ProgramDetailsID")
        '    Dim tafID As Object = e.Values("TAFID")

        '    sql = New StringBuilder()

        '    sql.AppendLine("DELETE FROM [TAFProgramDetails] ")
        '    sql.AppendLine("WHERE TAFID = '" & tafID.ToString() & "' ")
        '    sql.AppendLine("  AND ProgramDetailsID = '" & programDetailsID.ToString() & "' ")

        '    e.Cancel = ExecSQL(sql.ToString())

        '    gridView.CancelEdit()

        '    If (e.Cancel) Then

        '        CancelEdit = True

        '    End If

        'Catch ex As Exception

        '    Throw ex

        'Finally

        '    If sql IsNot Nothing Then

        '        sql.Clear()
        '        sql = Nothing

        '    End If

        'End Try

    End Sub

    Private Sub GetGridValue_dgView_008(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_008"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim txtPathID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPathID_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtPathID IsNot Nothing Then

            newValues("PathID") = txtPathID.Text

        End If

        Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProgramTitle_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtProgramTitle IsNot Nothing Then

            newValues("ProgramTitle") = txtProgramTitle.Text
            newValues("CourseName") = txtProgramTitle.Text

        End If

        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbType IsNot Nothing Then

            newValues("Type") = cmbType.Text

        End If

        Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbProgramType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbProgramType IsNot Nothing Then

            newValues("ProgramType") = cmbProgramType.Text

        End If

        Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtInvestment_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtInvestment IsNot Nothing Then

            newValues("Investment") = txtInvestment.Text

        End If

        Dim hfInvestment As HiddenField =
            TryCast(pgControl.FindControl("hfInvestment_008"), HiddenField)

        If hfInvestment IsNot Nothing Then

            newValues("Investment_Orig") = hfInvestment.Value

        End If

        Dim txtCostUSD As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtCostUSD_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtCostUSD IsNot Nothing Then

            newValues("InvestmentUSD") = txtCostUSD.Text

        End If

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProvider_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtProvider IsNot Nothing Then

            newValues("ProviderName") = txtProvider.Text

        End If

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtVenue_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtVenue IsNot Nothing Then

            newValues("VenueName") = txtVenue.Text

        End If

        Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateFrom_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteDateFrom IsNot Nothing Then

            newValues("DateFrom") = dteDateFrom.Text

        End If

        Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateTo_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteDateTo IsNot Nothing Then

            newValues("CompletionDate") = dteDateTo.Text

        End If

        Dim txtDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDuration_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtDuration IsNot Nothing Then

            newValues("Duration") = txtDuration.Text

        End If

        Dim dteExistingStart As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteExistingStart_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteExistingStart IsNot Nothing Then

            newValues("ExistingStart") = dteExistingStart.Text

        End If

        Dim txtExpiry As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpiry_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtExpiry IsNot Nothing Then

            newValues("Expiry") = txtExpiry.Text

        End If

        Dim txtExpiryEndDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpiryEndDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtExpiryEndDate IsNot Nothing Then

            newValues("ExpiryEndDate") = txtExpiryEndDate.Text

        End If

        Dim txtExpirySystemDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpirySystemDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtExpirySystemDate IsNot Nothing Then

            newValues("ExpirySystemDate") = txtExpirySystemDate.Text

        End If

        Dim txtContractCompletion As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtContractCompletion_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtContractCompletion IsNot Nothing Then

            newValues("ContractCompletion") = txtContractCompletion.Text

        End If

        Dim txtContractStatus As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtContractStatus_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtContractStatus IsNot Nothing Then

            newValues("ContractStatus") = txtContractStatus.Text

        End If

        Dim dteSeparationDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteSeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteSeparationDate IsNot Nothing Then

            newValues("SeparationDate") = dteSeparationDate.Text

        End If

        Dim txtExpirySeparationDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExpirySeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtExpirySeparationDate IsNot Nothing Then

            newValues("ExpirySeparationDate") = txtExpirySeparationDate.Text

        End If

        Dim txtMonthsUnserved As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtMonthsUnserved_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtMonthsUnserved IsNot Nothing Then

            newValues("MonthsUnserved") = txtMonthsUnserved.Text

        End If

        Dim txtUnservedContract As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtUnservedContract_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtUnservedContract IsNot Nothing Then

            newValues("UnservedContract") = txtUnservedContract.Text

        End If

        Dim txtPenalty As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPenalty_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtPenalty IsNot Nothing Then

            newValues("Penalty") = txtPenalty.Text

        End If


        'Post Training Information Fields

        Dim cmbCertification As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCertificate_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbCertification IsNot Nothing Then

            newValues("Certificate") = cmbCertification.Text

        End If

        Dim cmbTrainingMaterial As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbTrainingMaterial_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbTrainingMaterial IsNot Nothing Then

            newValues("TrainingMaterial") = cmbTrainingMaterial.Text

        End If

        Dim txtPlannedEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtPlannedEcho IsNot Nothing Then

            newValues("PlannedEcho") = txtPlannedEcho.Text

        End If

        Dim txtActualEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtActualEcho IsNot Nothing Then

            newValues("ActualEcho") = txtActualEcho.Text

        End If

        Dim txtPlannedPaxEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedPaxEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtPlannedPaxEcho IsNot Nothing Then

            newValues("PlannedPaxEcho") = txtPlannedPaxEcho.Text

        End If

        Dim txtActualPaxEcho As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualPaxEcho_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtActualPaxEcho IsNot Nothing Then

            newValues("ActualPaxEcho") = txtActualPaxEcho.Text

        End If

        'External Training Budget Detail Fields

        Dim dteDateReceived As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteDateReceived_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteDateReceived IsNot Nothing Then

            newValues("DateReceived") = dteDateReceived.Text

        End If

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtBudgetCode_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbBudgetCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbBudgetCategory_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtRemainingBudget As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtRemainingBudget_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtBudgetCode IsNot Nothing AndAlso
           cmbBudgetCategory IsNot Nothing AndAlso
           txtRemainingBudget IsNot Nothing AndAlso
           dteDateFrom IsNot Nothing Then

            Dim sqlBudget As StringBuilder = New StringBuilder()

            sqlBudget.AppendLine("SELECT TOP 1 tem.[BudgetCode], teb.[RemainingBudget]")
            sqlBudget.AppendLine("FROM TrainingExternalBudget teb")
            sqlBudget.AppendLine("LEFT JOIN TrainingExternalBudgetMonitoring tem")
            sqlBudget.AppendLine("    ON teb.[CategoryName] = tem.[CategoryName]")
            sqlBudget.AppendLine("    AND teb.[Year] = tem.[Year]")
            sqlBudget.AppendLine("WHERE teb.[Year] = YEAR('" & dteDateFrom.Date & "')")
            sqlBudget.AppendLine("AND teb.[Month] = MONTH('" & dteDateFrom.Date & "')")
            sqlBudget.AppendLine("AND teb.[CategoryName] = '" & cmbBudgetCategory.Text & "'")

            Using budgetRecord As DataTable = GetSQLDT(sqlBudget.ToString())

                sqlBudget.Clear()

                If (IsData(budgetRecord)) Then

                    txtBudgetCode.Text = budgetRecord.Rows(0).Item("BudgetCode").ToString()
                    txtRemainingBudget.Text = budgetRecord.Rows(0).Item("RemainingBudget").ToString()

                    budgetRecord.Clear()

                End If

            End Using

        End If

        If txtBudgetCode IsNot Nothing Then

            newValues("BudgetCode") = txtBudgetCode.Text

        End If

        If cmbBudgetCategory IsNot Nothing Then

            newValues("BudgetCategory") = cmbBudgetCategory.Text

        End If

        If txtRemainingBudget IsNot Nothing Then

            newValues("RemainingBudget") = txtRemainingBudget.Text

        End If

        Dim txtRFPNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtRFPNum_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtRFPNum IsNot Nothing Then

            newValues("RFPNum") = txtRFPNum.Text

        End If

        Dim txtSAPDocNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSAPDocNum_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtSAPDocNum IsNot Nothing Then

            newValues("SAPDocNum") = txtSAPDocNum.Text

        End If

        Dim txtDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDivision_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtDivision IsNot Nothing Then

            newValues("Division") = txtDivision.Text

        End If

        Dim txtDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDepartment_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtDepartment IsNot Nothing Then

            newValues("Department") = txtDepartment.Text

        End If

        Dim txtSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSection_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtSection IsNot Nothing Then

            newValues("Section") = txtSection.Text

        End If

        Dim txtLevel As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLevel_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtLevel IsNot Nothing Then

            newValues("Level") = txtLevel.Text

        End If

        Dim txtDesignation As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtDesignation_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtDesignation IsNot Nothing Then

            newValues("Designation") = txtDesignation.Text

        End If

        Dim txtSubCategory As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtSubCategory_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtSubCategory IsNot Nothing Then

            newValues("SubCategory") = txtSubCategory.Text

        End If

        Dim cmbLateRegistration As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbLateRegistration_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbLateRegistration IsNot Nothing Then

            newValues("LateRegistration") = cmbLateRegistration.Text

        End If

        Dim cmbTrainingStatus As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbTrainingStatus_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbTrainingStatus IsNot Nothing Then

            newValues("TrainingStatus") = cmbTrainingStatus.Text

        End If

        Dim hfTrainingStatus As HiddenField =
            TryCast(pgControl.FindControl("hfTrainingStatus_008"), HiddenField)

        If hfTrainingStatus IsNot Nothing Then

            newValues("TrainingStatus_Orig") = hfTrainingStatus.Value

        End If

    End Sub

    Private Sub dgView_008_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_008.CustomCallback

        Dim dtProgramType As DataTable = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
                TryCast(gridView.FindEditFormTemplateControl("pageControl_008"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

            Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(pgControl.FindControl("cmbType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtInvestment_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dteDateFrom_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Dim lblInvestmentRequired As DevExpress.Web.ASPxEditors.ASPxLabel =
                TryCast(pgControl.FindControl("lblInvestment_008_required"), DevExpress.Web.ASPxEditors.ASPxLabel)

            Select Case GetXML(e.Parameters, KeyName:="ID")

                Case "cmbType_008"

                    Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                        TryCast(pgControl.FindControl("cmbProgramType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    Dim type As String = GetXML(e.Parameters, KeyName:="Value")

                    cmbProgramType.Text = String.Empty
                    cmbProgramType.Items.Clear()

                    If (type = "Functional Training Program") Then

                        LoadExpDS(dsTCProgType, "SELECT 'Business Trip (Local and Overseas)' [ProgramType] UNION ALL SELECT 'Public Seminar/External Training Program' [ProgramType] UNION ALL SELECT 'In-house Special Training Program' [ProgramType] ORDER BY [ProgramType] ASC")

                        txtInvestment.ReadOnly = False
                        txtInvestment.Attributes.Remove("onkeydown")

                        lblInvestmentRequired.Visible = True

                    ElseIf (type = "Specialized Development Program") Then

                        LoadExpDS(dsTCProgType, "SELECT [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] ORDER BY [Program] ASC")

                        txtInvestment.Text = "0.00"

                        txtInvestment.ReadOnly = True
                        txtInvestment.Attributes.Add("onkeydown", "return false;")

                        lblInvestmentRequired.Visible = False

                    End If

                Case "txtInvestment_008"

                    Dim investment As Double

                    If (Double.TryParse(txtInvestment.Text, investment) AndAlso investment > 0) Then

                        txtInvestment.Text = IIf(investment.ToString("#.00") = ".00", String.Empty, investment.ToString("#.00"))

                    Else

                        txtInvestment.Text = "0.00"

                    End If

                    GoTo populateDuration

                Case "cmbProgramType_008", "dteExistingStart_008", "dteSeparationDate_008"

populateDuration:

                    Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtProgramTitle_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                        TryCast(pgControl.FindControl("cmbProgramType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    Dim txtDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtDuration_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim dteExistingStart As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                        TryCast(pgControl.FindControl("dteExistingStart_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

                    Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                        TryCast(pgControl.FindControl("dteDateTo_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

                    Dim txtExpiry As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtExpiry_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtExpiryEndDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtExpiryEndDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtExpirySystemDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtExpirySystemDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtContractCompletion As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtContractCompletion_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtContractStatus As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtContractStatus_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim cmbTrainingStatus As DevExpress.Web.ASPxEditors.ASPxComboBox =
                        TryCast(pgControl.FindControl("cmbTrainingStatus_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    Dim cmbBudgetCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
                        TryCast(pgControl.FindControl("cmbBudgetCategory_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    Dim serviceAgreement As DataTable = New DataTable()

                    Dim budgetCategoryList As DataTable = GetSQLDT("SELECT DISTINCT teb.[CategoryName] FROM TrainingExternalBudget teb")

                    'Category

                    If (IsData(budgetCategoryList)) Then

                        cmbBudgetCategory.Items.Clear()

                        For Each drBudgetCateg As DataRow In budgetCategoryList.Rows

                            If Not drBudgetCateg.IsNull("CategoryName") Then

                                Dim budgetCategory As String = drBudgetCateg("CategoryName").ToString()

                                cmbBudgetCategory.Items.Add(budgetCategory, budgetCategory)

                            End If

                        Next

                    End If

                    'cmbType

                    If (cmbType.Text = "Functional Training Program" AndAlso txtInvestment.Text <> String.Empty) Then

                        serviceAgreement = GetSQLDT("SELECT TOP 1 [ServiceAgreement] = (	CASE WHEN ftp.Years > 0	THEN ftp.Years + cast((ftp.Months / CONVERT(decimal(4,2), 12))as float) ELSE cast((ftp.Months / CONVERT(decimal(4,2), 12))as float) END) FROM FunctionalTrainingProgram ftp WHERE (" & txtInvestment.Text & " BETWEEN ftp.[Min] AND ftp.[Max]) OR (ftp.[Min] IS NULL AND " & txtInvestment.Text & " <= ftp.[Max]) OR (ftp.[Max] IS NULL AND " & txtInvestment.Text & " >= ftp.[Min])")

                        If (IsData(serviceAgreement)) Then

                            txtDuration.Text = serviceAgreement.Rows(0).Item("ServiceAgreement").ToString()

                        End If

                    ElseIf (cmbType.Text = "Specialized Development Program" AndAlso cmbProgramType.Text <> String.Empty) Then

                        serviceAgreement = GetSQLDT("SELECT TOP 1 [serviceAgreement] FROM SpecializedDevelopmentProgram sdp WHERE sdp.[Program] = '" & cmbProgramType.Text & "'")

                        If (IsData(serviceAgreement)) Then

                            txtDuration.Text = serviceAgreement.Rows(0).Item("ServiceAgreement").ToString()

                        End If

                    End If

                    'If (dteDateFrom.Text <> String.Empty) Then dteExistingStart.Date = dteDateFrom.Date

                    If (txtDuration.Text <> String.Empty AndAlso dteExistingStart.Text <> String.Empty) Then

                        Dim duration As Double = Double.Parse(txtDuration.Text)

                        Dim totalMonths As Integer = (Math.Truncate(duration) * 12) + ((duration - Math.Truncate(duration)) * 0.12 * 100)

                        Dim expiry As Date = Date.Parse(dteExistingStart.Date).AddMonths(totalMonths)

                        Dim totalTrainingEnd As Integer = (expiry.Date - dteDateTo.Date).TotalDays

                        Dim totalToday As Integer = (expiry.Date - Date.Today).TotalDays

                        txtExpiry.Text = expiry

                        txtExpiryEndDate.Text = totalTrainingEnd

                        txtExpirySystemDate.Text = totalToday

                        txtContractCompletion.Text = Decimal.Parse(IIf((((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100) < 0, 0, ((totalTrainingEnd - totalToday) / totalTrainingEnd) * 100)).ToString("#.00")

                        txtContractCompletion.Text = IIf(txtContractCompletion.Text = ".00", "0", txtContractCompletion.Text)

                        If (Date.Today > expiry) Then

                            txtContractStatus.Text = "Served"

                        ElseIf (Date.Today <= expiry) Then

                            txtContractStatus.Text = "Pending Completion"

                        End If

                    End If

                    Dim dteSeparationDate As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                        TryCast(pgControl.FindControl("dteSeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

                    Dim txtExpirySeparationDate As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtExpirySeparationDate_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtMonthsUnserved As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtMonthsUnserved_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtUnservedContract As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtUnservedContract_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtPenalty As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtPenalty_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    txtExpirySeparationDate.Text = String.Empty
                    txtMonthsUnserved.Text = String.Empty
                    txtUnservedContract.Text = String.Empty
                    txtPenalty.Text = String.Empty

                    If (dteSeparationDate.Text <> String.Empty AndAlso txtExpiry.Text <> String.Empty AndAlso dteDateTo.Text <> String.Empty) Then
                        'amanriza 16/5/2019
                        'Changed formula of penalty and added conditions to restrict negative values.
                        If (dteSeparationDate.Date < Date.Parse(txtExpiry.Text)) Then

                            Dim totalSeparationDays As Integer = (Date.Parse(txtExpiry.Text) - dteSeparationDate.Date).TotalDays

                            Dim totalTrainingEnd As Integer = (Date.Parse(txtExpiry.Text) - dteDateTo.Date).TotalDays

                            txtExpirySeparationDate.Text = totalSeparationDays

                            txtMonthsUnserved.Text = String.Format("{0:#0.#0}", (totalSeparationDays / 30))

                            Dim unservedContract As Decimal = (totalSeparationDays / totalTrainingEnd) * 100

                            txtUnservedContract.Text = Decimal.Parse(IIf(unservedContract < 0, 0, unservedContract)).ToString("#.00")

                            txtUnservedContract.Text = IIf(txtUnservedContract.Text = ".00", "0", txtUnservedContract.Text)


                            Dim _serviceagreement As Decimal

                            _serviceagreement = If(serviceAgreement.Rows.Count > 0, Convert.ToDecimal(serviceAgreement.Rows(0)(0)), 0)

                            txtPenalty.Text = (Math.Round(Convert.ToDecimal(txtInvestment.Text) / _serviceagreement * Convert.ToDecimal(txtMonthsUnserved.Text), 2)).ToString()

                            'txtPenalty.Text = Decimal.Parse(IIf(txtInvestment.Text = String.Empty, String.Empty, Decimal.Parse(txtInvestment.Text) - (Decimal.Parse(txtUnservedContract.Text) / 100 * Decimal.Parse(txtInvestment.Text)))).ToString("#.00")

                            txtPenalty.Text = (Math.Round(Convert.ToDecimal(txtInvestment.Text) / Convert.ToDecimal(txtDuration.Text) * Convert.ToDecimal(txtMonthsUnserved.Text), 2)).ToString("#.00")

                            txtPenalty.Text = IIf(txtPenalty.Text = ".00", "0.00", txtPenalty.Text)
                        Else

                            txtUnservedContract.Text = "0.00"

                            txtMonthsUnserved.Text = "0.00"

                            txtExpirySeparationDate.Text = "0.00"

                            txtPenalty.Text = "0.00"

                        End If
                        'txtPenalty.Text = Decimal.Parse(IIf(txtInvestment.Text = String.Empty, String.Empty, Decimal.Parse(txtInvestment.Text) - (Decimal.Parse(txtUnservedContract.Text) / 100 * Decimal.Parse(txtInvestment.Text)))).ToString("#.00")
                        'amanriza end
                    End If

                Case "cmbBudgetCategory_008"

                    'If (dteDateFrom.Text = String.Empty) Then Return

                    Dim txtPathID As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtPathID_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtBudgetCode_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtRemainingBudget As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtRemainingBudget_008"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim cmbBudgetCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
                        TryCast(pgControl.FindControl("cmbBudgetCategory_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    Dim budgetCategoryList As DataTable = GetSQLDT("SELECT DISTINCT teb.[CategoryName] FROM TrainingExternalBudget teb")

                    Dim budgetCheck As DataTable = GetSQLDT("SELECT TOP 1 [PathID] FROM TrainingAgreementForm WHERE [PathID] = '" & txtPathID.Text & "' AND [BudgetCode] IS NOT NULL")

                    'Category

                    If (IsData(budgetCategoryList)) Then

                        cmbBudgetCategory.Items.Clear()

                        For Each drBudgetCateg As DataRow In budgetCategoryList.Rows

                            If Not drBudgetCateg.IsNull("CategoryName") Then

                                Dim budgetCategory As String = drBudgetCateg("CategoryName").ToString()

                                cmbBudgetCategory.Items.Add(budgetCategory, budgetCategory)

                            End If

                        Next

                    End If

                    Dim sqlBudget As StringBuilder = New StringBuilder()

                    If (Not IsData(budgetCheck)) Then

                        sqlBudget.AppendLine("SELECT TOP 1 tem.[BudgetCode], teb.[RemainingBudget]")
                        sqlBudget.AppendLine("FROM TrainingExternalBudget teb")
                        sqlBudget.AppendLine("LEFT JOIN TrainingExternalBudgetMonitoring tem")
                        sqlBudget.AppendLine("    ON teb.[CategoryName] = tem.[CategoryName]")
                        sqlBudget.AppendLine("    AND teb.[Year] = tem.[Year]")
                        sqlBudget.AppendLine("WHERE teb.[Year] = YEAR('" & dteDateFrom.Date & "')")
                        sqlBudget.AppendLine("AND teb.[Month] = MONTH('" & dteDateFrom.Date & "')")
                        sqlBudget.AppendLine("AND teb.[CategoryName] = '" & cmbBudgetCategory.Text & "'")

                        Dim budgetRecord As DataTable = GetSQLDT(sqlBudget.ToString())

                        If (IsData(budgetRecord)) Then

                            txtBudgetCode.Text = budgetRecord.Rows(0).Item("BudgetCode").ToString()
                            txtRemainingBudget.Text = budgetRecord.Rows(0).Item("RemainingBudget").ToString()

                        End If

                    End If

                    'Case "cmbTrainingStatus_008"

                    'If cmbTrainingStatus.Text = "Approved" Then

                    '    cmbTrainingStatus.Items.Clear()
                    '    cmbTrainingStatus.Items.Add(cmbTrainingStatus.Text, cmbTrainingStatus.Text)
                    '    cmbTrainingStatus.Items.Add("Cancelled", "Cancelled")

                    'Else


                    '    cmbTrainingStatus.Items.Clear()
                    '    cmbTrainingStatus.Items.Add(cmbTrainingStatus.Text, cmbTrainingStatus.Text)

                    'End If

                    'cmbTrainingStatus.SelectedItem = cmbTrainingStatus.Items.FindByValue(cmbTrainingStatus.Text)

            End Select

            Dim progTypeList As DataTable = New DataTable()

            Dim cmbProgramType2 As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(pgControl.FindControl("cmbProgramType_008"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            If (cmbType.Text = "Functional Training Program") Then

                progTypeList = GetSQLDT("SELECT 'Business Trip (Local and Overseas)' [ProgramType] UNION ALL SELECT 'Public Seminar/External Training Program' [ProgramType] UNION ALL SELECT 'In-house Special Training Program' [ProgramType] ORDER BY [ProgramType] ASC")

                txtInvestment.ReadOnly = False

            ElseIf (cmbType.Text = "Specialized Development Program") Then

                progTypeList = GetSQLDT("SELECT [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] ORDER BY [Program] ASC")

                txtInvestment.ReadOnly = True

            End If

            If (IsData(progTypeList)) Then

                For Each drProgType As DataRow In progTypeList.Rows

                    If Not drProgType.IsNull("ProgramType") Then

                        Dim programType As String = drProgType("ProgramType").ToString()

                        cmbProgramType2.Items.Add(programType, programType)

                    End If

                Next

                cmbProgramType2.SelectedItem = cmbProgramType2.Items.FindByValue(cmbProgramType2.Text)

            End If


        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtProgramType IsNot Nothing Then

                dtProgramType.Clear()
                dtProgramType.Dispose()
                dtProgramType = Nothing

            End If

        End Try

    End Sub

#End Region

#Region "Training Curriculum Overseas"

    Protected Sub cmdCreate_009_Load(sender As Object, e As EventArgs)

        Dim btnCreate As DevExpress.Web.ASPxEditors.ASPxButton =
            TryCast(sender, DevExpress.Web.ASPxEditors.ASPxButton)

        If Not IsNothing(btnCreate) Then

            Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")
            visible = True ' delete this flag

            btnCreate.ClientVisible = visible
            btnCreate.Visible = visible

        End If

    End Sub

    Protected Sub dgView_008_009_010_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_008.CustomJSProperties, dgView_009.CustomJSProperties, dgViewBC_010.CustomJSProperties, dgView_010.CustomJSProperties, dgView_012.CustomJSProperties, dgView_013.CustomJSProperties, dgView_014.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Function dgView_009_ValidateCustomRequiredFields(e As DevExpress.Web.Data.ASPxDataValidationEventArgs) As String

        Dim counter As Integer = 0

        If (e.NewValues("Course").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("Provider").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("Type").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("Category").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("SOA").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("Extension").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("PlannedEOA").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("PlannedDuration").ToString() = String.Empty) Then counter += 1
        If (e.NewValues("Active").ToString() = String.Empty) Then counter += 1

        If (counter > 0) Then Return "Please input a data for the list of fields with (*) symbol, it is indicated that it is a required field."

        If (e.NewValues("Course").ToString() = String.Empty) Then Return "Course is required."
        If (e.NewValues("Provider").ToString() = String.Empty) Then Return "Provider is required."
        ' jalzate - 04/12/2019
        ' disabled validation for field venue
        ' If (e.NewValues("Venue").ToString() = String.Empty) Then Return "Venue is required."
        ' jalzate - end
        If (e.NewValues("Type").ToString() = String.Empty) Then Return "ICT Type is required."
        If (e.NewValues("Category").ToString() = String.Empty) Then Return "ICT Category is required."
        If (e.NewValues("SOA").ToString() = String.Empty) Then Return "Start of Assignment is required."
        If (e.NewValues("Extension").ToString() = String.Empty) Then Return "Extension (Months) is required."
        If (e.NewValues("PlannedEOA").ToString() = String.Empty) Then Return "End of Assignment (Planned) is required."
        If (e.NewValues("PlannedDuration").ToString() = String.Empty) Then Return "Duration of ICT Assignment (Planned) is required."
        If (e.NewValues("Active").ToString() = String.Empty) Then Return "Active field is required."

        ' jalzate - 04/12/2019
        ' TSK0000393
        ' added validation for Start date and end date 
        If (DateCompareParse(e.NewValues("SOA").ToString(), e.NewValues("PlannedEOA").ToString()) > 0) Then

            Return "Start of assignement cannot be greater than end of assignment ."

        End If
        ' jalzate - end

        ' jalzate - 04/12/2019
        ' TSK0000392
        If (DateCompareParse(e.NewValues("FirstWD").ToString(), e.NewValues("LastWD").ToString()) > 0) Then

            Return "First Work. Day at Home Company cannot be greater than Last Work. Day at Host Company."

        End If
        ' jalzate - end

        'Dim extension As Integer

        'If (Integer.TryParse(e.NewValues("Extension").ToString(), extension)) Then
        '    If (extension > 99 OrElse extension < 1) Then
        '        Return "Invalid Extension! Input should be ranging from 1 to 99."
        '    End If
        'Else
        '    Return "Invalid Extension! Input should be ranging from 1 to 99."
        'End If

        'If (Date.Parse(e.NewValues("SOA").ToString()) > e.NewValues("PlannedEOA").ToString()) Then
        '    Return "End of Assignment (Planned) cannot be greater than Start of Assignment"
        'End If


        Return String.Empty

    End Function

    Protected Sub dgView_009_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgView_009_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_009"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        Dim visible As Boolean = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID).Contains("'TrainingAdmin'")
        visible = True ' delete this flag

        Dim cmbCourse As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCourse_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProvider_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtVenue_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtPathID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPathID_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        'ICT Assignment Info.
        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbType_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCategory_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim dteSOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteSOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtExtension As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExtension_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dtePlannedEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dtePlannedEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteActualEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteActualEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtPlannedDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtActualDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtActive As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActive_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtLocation As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLocation_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)


        'Repatriation Info.
        Dim dteFirstWD As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteFirstWD_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteLastWD As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteLastWD_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)


        'ICT Contact Info.

        Dim txtHomeContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomePEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomePEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHomeAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostPEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostPEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtHostAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)



        'Service Contract Info.

        Dim dteStartOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteStartOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteEndOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteEndOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtLengthOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLengthOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtStatusOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtStatusOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)


        Dim dtCourseName As DataTable = GetSQLDT("SELECT CourseName FROM CourseLU WHERE (InternalCourse = 0  OR InternalCourse IS NULL) and Overseas = 1 ORDER BY CourseName")

        If (IsData(dtCourseName)) Then

            If cmbCourse.Items.Count > 0 Then cmbCourse.Items.Clear()

            For Each drCourseName As DataRow In dtCourseName.Rows

                If Not drCourseName.IsNull("CourseName") Then

                    Dim courseName As String = drCourseName("CourseName").ToString()

                    cmbCourse.Items.Add(courseName, courseName)

                End If

            Next

        End If

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim compositeKey As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CompositeKey")
            Dim programTitle As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CourseName")
            Dim dateRegistered As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "DateRegistered")
            Dim completionDate As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CompletionDate")
            Dim providerName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ProviderName")
            Dim venueName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "VenueName")
            Dim trainingStatus As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "TrainingStatus")
            Dim remarks As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Remarks")
            Dim evaluated As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Evaluated")
            Dim pathID As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "PathID")

            Dim sql As StringBuilder = New StringBuilder()

            sql.AppendLine("SELECT TOP 1")
            'sql.AppendLine("[Course] = ISNULL(tc.[CourseName], '' ),")
            'sql.AppendLine("[Provider] = ISNULL(tc.[ProviderName], '' ),")
            'sql.AppendLine("[Venue] = ISNULL(tc.[VenueName], '' ),")
            sql.AppendLine("[Type] = ISNULL(tc.[cfICTType], '' ),")
            sql.AppendLine("[Category] = ISNULL(tc.[cfCategory], '' ),")
            sql.AppendLine("[SOA] = ISNULL(tc.[cfSOA], '' ),")
            sql.AppendLine("[Extension] = ISNULL(tc.[cfExtension], '' ),")
            sql.AppendLine("[EOAP] = ISNULL(tc.[cfEOAP], '' ),")
            sql.AppendLine("[EOAA] = ISNULL(tc.[cfEOAA], '' ),")
            sql.AppendLine("[DurationOIAA] = ISNULL(tc.[cfDurationOIAA], '' ),")
            sql.AppendLine("[DurationOIAP] = ISNULL(tc.[cfDurationOIAP], '' ),")
            sql.AppendLine("[Active] = ISNULL(tc.[cfActive], '' ),")
            sql.AppendLine("[Location] = ISNULL(tc.[cfLocation], '' ),")
            sql.AppendLine("[HostCompany] = ISNULL(tc.[cfHostCompany], '' ),")
            sql.AppendLine("[HostDivision] = ISNULL(tc.[cfHostDivision], '' ),")
            sql.AppendLine("[HostDepartment] = ISNULL(tc.[cfHostDepartment], '' ),")
            sql.AppendLine("[HostSection] = ISNULL(tc.[cfHostSection], '' ),")
            sql.AppendLine("[HomeCompany] = ISNULL(tc.[cfHomeCompany], '' ),")
            sql.AppendLine("[HomeDivision] = ISNULL(tc.[cfHomeDivision], '' ),")
            sql.AppendLine("[HomeDepartment] = ISNULL(tc.[cfHomeDepartment], '' ),")
            sql.AppendLine("[HomeSection] = ISNULL(tc.[cfHomeSection], '' ),")
            sql.AppendLine("[FirstWD] = ISNULL(tc.[cfFirstWD], '' ),")
            sql.AppendLine("[LastWD] = ISNULL(tc.[cfLastWD], '' ),")
            sql.AppendLine("[HostContactHC] = ISNULL(tc.[cfHostContactHC], '' ),")
            sql.AppendLine("[HostContactRes] = ISNULL(tc.[cfHostContactRes], '' ),")
            sql.AppendLine("[HostAddress] = ISNULL(tc.[cfHostAddress], '' ),")
            sql.AppendLine("[HostPEmail] = ISNULL(tc.[cfHostPEmail], '' ),")
            sql.AppendLine("[HostAEmail] = ISNULL(tc.[cfHostAEmail], '' ),")
            sql.AppendLine("[HomeContactHC] = ISNULL(tc.[cfHomeContactHC], '' ),")
            sql.AppendLine("[HomeContactRes] = ISNULL(tc.[cfHomeContactRes], '' ),")
            sql.AppendLine("[HomeAddress] = ISNULL(tc.[cfHomeAddress], '' ),")
            sql.AppendLine("[HomePEmail] = ISNULL(tc.[cfHomePEmail], '' ),")
            sql.AppendLine("[HomeAEmail] = ISNULL(tc.[cfHomeAEmail], '' ),")
            sql.AppendLine("[StartOSC] = ISNULL(tc.[cfStartOSC], '' ),")
            sql.AppendLine("[EndOSC] = ISNULL(tc.[cfEndOSC], '' ),")
            sql.AppendLine("[LengthOSC] = ISNULL(tc.[cfLengthOSC], '' ),")
            sql.AppendLine("[StatusOSC] = ISNULL(tc.[cfStatusOSC], '')")
            sql.AppendLine("FROM TrainingCompleted tc")
            sql.AppendLine("WHERE tc.[PathID] = '" & pathID & "'")

            Dim dtColumns As DataTable = GetSQLDT(sql.ToString())

            If (IsData(dtColumns)) Then

                'txtPathID.Text = dtColumns.Rows(0).Item("PathID").ToString()
                cmbCourse.SelectedItem = cmbCourse.Items.FindByValue(programTitle.ToString())
                txtProvider.Text = providerName.ToString()
                txtVenue.Text = venueName.ToString()
                cmbType.SelectedItem = cmbType.Items.FindByValue(dtColumns.Rows(0).Item("Type").ToString())
                cmbCategory.SelectedItem = cmbCategory.Items.FindByValue(dtColumns.Rows(0).Item("Category").ToString())
                If (dtColumns.Rows(0).Item("SOA").ToString() <> String.Empty) Then dteSOA.Date = dtColumns.Rows(0).Item("SOA").ToString()
                txtExtension.Text = dtColumns.Rows(0).Item("Extension").ToString()
                If (dtColumns.Rows(0).Item("EOAP").ToString() <> String.Empty) Then dtePlannedEOA.Date = dtColumns.Rows(0).Item("EOAP").ToString()
                If (dtColumns.Rows(0).Item("EOAA").ToString() <> String.Empty) Then dteActualEOA.Date = dtColumns.Rows(0).Item("EOAA").ToString()
                txtPlannedDuration.Text = dtColumns.Rows(0).Item("DurationOIAP").ToString()
                txtActualDuration.Text = dtColumns.Rows(0).Item("DurationOIAA").ToString()
                txtActive.Text = dtColumns.Rows(0).Item("Active").ToString()
                txtLocation.Text = dtColumns.Rows(0).Item("Location").ToString()
                txtHomeCompany.Text = dtColumns.Rows(0).Item("HomeCompany").ToString()
                txtHomeDivision.Text = dtColumns.Rows(0).Item("HomeDivision").ToString()
                txtHomeDepartment.Text = dtColumns.Rows(0).Item("HomeDepartment").ToString()
                txtHomeSection.Text = dtColumns.Rows(0).Item("HomeSection").ToString()
                txtHostCompany.Text = dtColumns.Rows(0).Item("HostCompany").ToString()
                txtHostDivision.Text = dtColumns.Rows(0).Item("HostDivision").ToString()
                txtHostDepartment.Text = dtColumns.Rows(0).Item("HostDepartment").ToString()
                txtHostSection.Text = dtColumns.Rows(0).Item("HostSection").ToString()

                'Repatriation Info.
                If (dtColumns.Rows(0).Item("FirstWD").ToString() <> String.Empty) Then dteFirstWD.Date = dtColumns.Rows(0).Item("FirstWD").ToString()
                If (dtColumns.Rows(0).Item("LastWD").ToString() <> String.Empty) Then dteLastWD.Date = dtColumns.Rows(0).Item("LastWD").ToString()

                'ICT Contact Info.
                txtHomeContactHC.Text = dtColumns.Rows(0).Item("HomeContactHC").ToString()
                txtHomeContactRes.Text = dtColumns.Rows(0).Item("HomeContactRes").ToString()
                txtHomeAddress.Text = dtColumns.Rows(0).Item("HomeAddress").ToString()
                txtHomePEmail.Text = dtColumns.Rows(0).Item("HomePEmail").ToString()
                txtHomeAEmail.Text = dtColumns.Rows(0).Item("HomeAEmail").ToString()
                txtHostContactHC.Text = dtColumns.Rows(0).Item("HostContactHC").ToString()
                txtHostContactRes.Text = dtColumns.Rows(0).Item("HostContactRes").ToString()
                txtHostAddress.Text = dtColumns.Rows(0).Item("HostAddress").ToString()
                txtHostPEmail.Text = dtColumns.Rows(0).Item("HostPEmail").ToString()
                txtHostAEmail.Text = dtColumns.Rows(0).Item("HostAEmail").ToString()

                'Service Contract Info.
                If (dtColumns.Rows(0).Item("StartOSC").ToString() <> String.Empty) Then dteStartOSC.Date = dtColumns.Rows(0).Item("StartOSC").ToString()
                If (dtColumns.Rows(0).Item("EndOSC").ToString() <> String.Empty) Then dteEndOSC.Date = dtColumns.Rows(0).Item("EndOSC").ToString()
                txtLengthOSC.Text = dtColumns.Rows(0).Item("LengthOSC").ToString()
                txtStatusOSC.Text = dtColumns.Rows(0).Item("StatusOSC").ToString()

                gridView.FindEditFormTemplateControl("UpdateButton").Visible = False

                For Each page As DevExpress.Web.ASPxTabControl.TabPage In pgControl.TabPages

                    For Each ctrl As Control In page.Controls

                        If TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxDateEdit Then

                            Dim dteControl As DevExpress.Web.ASPxEditors.ASPxDateEdit = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxDateEdit)

                            'dteControl.ReadOnly = True
                            'dteControl.DropDownButton.Visible = False
                            dteControl.Enabled = False

                        ElseIf TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxTextBox Then

                            Dim txtControl As DevExpress.Web.ASPxEditors.ASPxTextBox = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxTextBox)

                            txtControl.Enabled = False
                            'txtControl.ReadOnly = True

                        ElseIf TypeOf ctrl Is DevExpress.Web.ASPxEditors.ASPxComboBox Then

                            If (Not (ctrl.ID = "cmbTrainingStatus_008" AndAlso trainingStatus.ToString() = "Approved")) Then

                                Dim cmbControl As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(ctrl, DevExpress.Web.ASPxEditors.ASPxComboBox)

                                'cmbControl.ReadOnly = True
                                cmbControl.Enabled = False

                            End If

                        End If

                    Next

                Next

            End If

        End If

    End Sub

    Protected Sub dgView_009_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_009.RowValidating

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        GetGridValue_dgView_009(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

        e.RowError = dgView_009_ValidateCustomRequiredFields(e)

    End Sub

    Protected Sub dgView_009_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_009.RowInserting

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_009(gridView, e.NewValues)

            Dim course As Object = e.NewValues("Course")
            Dim provider As Object = e.NewValues("Provider")
            Dim venue As Object = e.NewValues("Venue")
            Dim type As Object = e.NewValues("Type")
            Dim category As Object = e.NewValues("Category")
            Dim soa As Object = e.NewValues("SOA")
            Dim extension As Object = e.NewValues("Extension")
            Dim plannedEOA As Object = e.NewValues("PlannedEOA")
            Dim actualEOA As Object = e.NewValues("ActualEOA")
            Dim actualDuration As Object = e.NewValues("ActualDuration")
            Dim plannedDuration As Object = e.NewValues("PlannedDuration")
            Dim active As Object = e.NewValues("Active")
            Dim location As Object = e.NewValues("Location")
            Dim hostCompany As Object = e.NewValues("HostCompany")
            Dim hostDivision As Object = e.NewValues("HostDivision")
            Dim hostDepartment As Object = e.NewValues("HostDepartment")
            Dim hostSection As Object = e.NewValues("HostSection")
            Dim homeCompany As Object = e.NewValues("HomeCompany")
            Dim homeDivision As Object = e.NewValues("HomeDivision")
            Dim homeDepartment As Object = e.NewValues("HomeDepartment")
            Dim homeSection As Object = e.NewValues("HomeSection")
            Dim firstWD As Object = e.NewValues("FirstWD")
            Dim lastWD As Object = e.NewValues("LastWD")
            Dim hostContactHC As Object = e.NewValues("HostContactHC")
            Dim hostContactRes As Object = e.NewValues("HostContactRes")
            Dim hostAddress As Object = e.NewValues("HostAddress")
            Dim hostPEmail As Object = e.NewValues("HostPEmail")
            Dim hostAEmail As Object = e.NewValues("HostAEmail")
            Dim homeContactHC As Object = e.NewValues("HomeContactHC")
            Dim homeContactRes As Object = e.NewValues("HomeContactRes")
            Dim homeAddress As Object = e.NewValues("HomeAddress")
            Dim homePEmail As Object = e.NewValues("HomePEmail")
            Dim homeAEmail As Object = e.NewValues("HomeAEmail")
            Dim startOSC As Object = e.NewValues("StartOSC")
            Dim endOSC As Object = e.NewValues("EndOSC")
            Dim lengthOSC As Object = e.NewValues("LengthOSC")
            Dim statusOSC As Object = e.NewValues("StatusOSC")

            'check for duplicates
            With UDetails
                sql = New StringBuilder()
                sql.AppendLine(" SELECT TOP 1
                [CompositeKey] = TC.[CompanyNum] + ' ' + TC.[EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + TC.[CourseName] + ' ' + TC.[ProviderName]
                FROM TrainingCompleted TC 
                LEFT JOIN CourseLU C     ON C.[CourseName] = TC.[CourseName] 
                LEFT JOIN TrainingEvaluation TE     ON TE.[EmployeeNum] = TC.[EmployeeNum]    AND TE.[CompanyNum] = TC.[CompanyNum]    AND TE.[CourseName] = TC.[CourseName]    AND TE.[ProviderName] = TC.[ProviderName] 
                WHERE " +
                $"CONCAT(TC.[CompanyNum],' ', TC.[EmployeeNum], ' ', CONVERT(NVARCHAR(19), TC.[StartDate], 120), ' ', TC.[CourseName], ' ',TC.[ProviderName]) = '{ .CompanyNum} { .EmployeeNum } ' + CONVERT(NVARCHAR(19), CAST('{soa.ToString()}' as DateTime), 120) + ' {course.ToString()} {provider.ToString()}'" +
                "AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0)   AND C.[Overseas] = 1")

                Dim existing As DataTable = GetSQLDT(sql.ToString())

                If (IsData(existing)) Then
                    Throw New Exception("Duplicate training. Please check start date, course, and provider name")
                End If

            End With

            'Check if dates collide with other overseas trainings
            If (soa IsNot Nothing AndAlso actualEOA IsNot Nothing) Then
                sql = New StringBuilder()
                With UDetails



                    sql.AppendLine("SELECT " +
                        "    [CompositeKey] = " +
                        "        TC.[CompanyNum] + ' ' + " +
                        "        TC.[EmployeeNum] + ' ' + " +
                        "        CONVERT(NVARCHAR(19), TC.[StartDate], 120) + ' ' + " +
                        "        TC.[CourseName] + ' ' + " +
                        "        TC.[ProviderName] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "WHERE TC.[CompanyNum] = '" & .CompanyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        "  AND (" +
                            $"('{soa.ToString()}' <= TC.[StartDate] AND '{actualEOA.ToString()}' >= TC.[StartDate])" +
                            "OR " +
                            $"('{soa.ToString()}' > TC.[StartDate] AND '{actualEOA.ToString()}' <= Cast(TC.[cfEOAA] as DateTime)) " +
                            " ) " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND C.[Overseas] = 1 ")

                    Dim existingTrainings As DataTable = GetSQLDT(sql.ToString())

                    If (IsData(existingTrainings)) Then
                        Throw New Exception("Training Dates overlap with another training. Please check the dates.")
                    Else
                        sql = New StringBuilder()

                        With UDetails
                            sql.AppendLine("DECLARE @NewPathID BIGINT")
                            sql.AppendLine("DECLARE @NewTAFID BIGINT")
                            sql.AppendLine("")
                            sql.AppendLine("INSERT INTO [ess.Path] (WFLUID) VALUES ('52')")
                            sql.AppendLine("")
                            sql.AppendLine("SELECT @NewPathID = scope_identity()")
                            sql.AppendLine("")
                            sql.AppendLine("DELETE [ess.Path] WHERE id = @NewPathID")
                            sql.AppendLine("")
                            sql.AppendLine("INSERT INTO [TrainingCompleted] (")
                            sql.AppendLine("PathID,")
                            sql.AppendLine("TrainingStatus,")
                            sql.AppendLine("CompanyNum,")
                            sql.AppendLine("EmployeeNum,")
                            sql.AppendLine("CourseName,")
                            sql.AppendLine("ProviderName,")
                            sql.AppendLine("StartDate,")
                            sql.AppendLine("CompletionDate,")
                            sql.AppendLine("VenueName,")
                            sql.AppendLine("InternalCourse,")
                            sql.AppendLine("CapturedByUsername,")
                            sql.AppendLine("CapturedOn,")
                            sql.AppendLine("cfICTType,")
                            sql.AppendLine("cfCategory,")
                            sql.AppendLine("cfSOA,")
                            sql.AppendLine("cfExtension,")
                            sql.AppendLine("cfEOAA,")
                            sql.AppendLine("cfEOAP,")
                            sql.AppendLine("cfDurationOIAA,")
                            sql.AppendLine("cfDurationOIAP,")
                            sql.AppendLine("cfActive,")
                            sql.AppendLine("cfLocation,")
                            sql.AppendLine("cfHostCompany,")
                            sql.AppendLine("cfHostDivision,")
                            sql.AppendLine("cfHostDepartment,")
                            sql.AppendLine("cfHostSection,")
                            sql.AppendLine("cfHomeCompany,")
                            sql.AppendLine("cfHomeDivision,")
                            sql.AppendLine("cfHomeDepartment,")
                            sql.AppendLine("cfHomeSection,")
                            sql.AppendLine("cfFirstWD,")
                            sql.AppendLine("cfLastWD,")
                            sql.AppendLine("cfHostContactHC,")
                            sql.AppendLine("cfHostContactRes,")
                            sql.AppendLine("cfHostAddress,")
                            sql.AppendLine("cfHostPEmail,")
                            sql.AppendLine("cfHostAEmail,")
                            sql.AppendLine("cfHomeContactHC,")
                            sql.AppendLine("cfHomeContactRes,")
                            sql.AppendLine("cfHomeAddress,")
                            sql.AppendLine("cfHomePEmail,")
                            sql.AppendLine("cfHomeAEmail,")
                            sql.AppendLine("cfStartOSC,")
                            sql.AppendLine("cfEndOSC,")
                            sql.AppendLine("cfLengthOSC,")
                            sql.AppendLine("cfStatusOSC")
                            sql.AppendLine(")")
                            sql.AppendLine("VALUES (")
                            sql.AppendLine("@NewPathID,")
                            sql.AppendLine("'Completed',")
                            sql.AppendLine("'" & .CompanyNum & "', ")
                            sql.AppendLine("'" & .EmployeeNum & "', ")
                            sql.AppendLine("'" & course.ToString().Replace("'", "''") & "',")
                            sql.AppendLine("'" & provider.ToString().Replace("'", "''") & "',")
                            sql.AppendLine("'" & soa.ToString() & "',")
                            sql.AppendLine("'" & plannedEOA.ToString() & "',")
                            sql.AppendLine("'" & venue.ToString().Replace("'", "''") & "',")
                            sql.AppendLine("0,")
                            sql.AppendLine("'" & Session("LoggedOn.EmployeeNum") & "',")
                            sql.AppendLine("GETDATE(),")
                            sql.AppendLine("'" & type.ToString().Replace("'", "''") & "',")
                            sql.AppendLine("'" & category.ToString().Replace("'", "''") & "',")
                            sql.AppendLine("'" & soa.ToString() & "',")
                            sql.AppendLine("'" & extension.ToString() & "',")
                            sql.AppendLine("'" & actualEOA.ToString() & "',")
                            sql.AppendLine("'" & plannedEOA.ToString() & "',")
                            sql.AppendLine("'" & actualDuration.ToString() & "',")
                            sql.AppendLine("'" & plannedDuration.ToString() & "',")
                            sql.AppendLine("'" & active.ToString() & "',")
                            sql.AppendLine("'" & location.ToString() & "',")
                            sql.AppendLine("'" & hostCompany.ToString() & "',")
                            sql.AppendLine("'" & hostDivision.ToString() & "',")
                            sql.AppendLine("'" & hostDepartment.ToString() & "',")
                            sql.AppendLine("'" & hostSection.ToString() & "',")
                            sql.AppendLine("'" & homeCompany.ToString() & "',")
                            sql.AppendLine("'" & homeDivision.ToString() & "',")
                            sql.AppendLine("'" & homeDepartment.ToString() & "',")
                            sql.AppendLine("'" & homeSection.ToString() & "',")
                            sql.AppendLine("'" & firstWD.ToString() & "',")
                            sql.AppendLine("'" & lastWD.ToString() & "',")
                            sql.AppendLine("'" & hostContactHC.ToString() & "',")
                            sql.AppendLine("'" & hostContactRes.ToString() & "',")
                            sql.AppendLine("'" & hostAddress.ToString() & "',")
                            sql.AppendLine("'" & hostPEmail.ToString() & "',")
                            sql.AppendLine("'" & hostAEmail.ToString() & "',")
                            sql.AppendLine("'" & homeContactHC.ToString() & "',")
                            sql.AppendLine("'" & homeContactRes.ToString() & "',")
                            sql.AppendLine("'" & homeAddress.ToString() & "',")
                            sql.AppendLine("'" & homePEmail.ToString() & "',")
                            sql.AppendLine("'" & homeAEmail.ToString() & "',")
                            sql.AppendLine("'" & startOSC.ToString() & "',")
                            sql.AppendLine("'" & endOSC.ToString() & "',")
                            sql.AppendLine("'" & lengthOSC.ToString() & "',")
                            sql.AppendLine("'" & statusOSC.ToString() & "'")
                            sql.AppendLine(")")

                            If Not (HasRows("select * from skills where CompanyNum = '" & .CompanyNum & "' and EmployeeNum = '" & .EmployeeNum & "' and Skill_Name = (select SkillName from CourseSkillsLU where CourseName = '" & course.ToString().Replace("'", "''") & "')")) Then

                                ' jalzate - 05/07/2019
                                ' insert into skills
                                sql.AppendLine("insert into Skills")
                                sql.AppendLine("select ")
                                sql.AppendLine("	'" & .CompanyNum & "',")
                                sql.AppendLine("	'" & .EmployeeNum & "',")
                                sql.AppendLine("	'" & soa.ToString() & "',")
                                sql.AppendLine("	SkillName,")
                                sql.AppendLine("	'',")
                                sql.AppendLine("	'" & Date.Now.ToString() & "',")
                                sql.AppendLine("	'', ")
                                sql.AppendLine("	ContactType, ")
                                sql.AppendLine("	CourseCategory,")
                                sql.AppendLine("	CourseSubCategory,")
                                sql.AppendLine("	NQFLevel,")
                                sql.AppendLine("	MainField, ")
                                sql.AppendLine("	SubField,")
                                sql.AppendLine("	'',")
                                sql.AppendLine("	'',")
                                sql.AppendLine("	@NewPathID")
                                sql.AppendLine("from ")
                                sql.AppendLine("	CourseSkillsLU ")
                                sql.AppendLine("where ")
                                sql.AppendLine("	CourseName = '" & course.ToString().Replace("'", "''") & "'")

                            End If

                        End With

                        e.Cancel = ExecSQL(sql.ToString())

                        gridView.CancelEdit()

                        If (e.Cancel) Then

                            CancelEdit = True

                        End If
                    End If
                End With

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    ''' <summary>
    ''' NO UPDATE FUNCTION
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub dgView_009_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim test As Integer = 0

        Dim Sql As StringBuilder = New StringBuilder()

        ' jalzate - 05/07/2019
        ' insert into skills
        Sql.AppendLine("insert into Skills")
        Sql.AppendLine("select ")
        Sql.AppendLine("	b.CompanyNum,")
        Sql.AppendLine("	b.EmployeeNum,")
        Sql.AppendLine("	b.StartDate,")
        Sql.AppendLine("	SkillName,")
        Sql.AppendLine("	'',")
        Sql.AppendLine("	b.CompletionDate,")
        Sql.AppendLine("	'', ")
        Sql.AppendLine("	ContactType, ")
        Sql.AppendLine("	a.CourseCategory,")
        Sql.AppendLine("	a.CourseSubCategory,")
        Sql.AppendLine("	a.NQFLevel,")
        Sql.AppendLine("	MainField, ")
        Sql.AppendLine("	SubField,")
        Sql.AppendLine("	'',")
        Sql.AppendLine("	'',")
        Sql.AppendLine("	b.PathID")
        Sql.AppendLine("from ")
        Sql.AppendLine("	CourseSkillsLU a inner join")
        Sql.AppendLine("	TrainingPlanned b on a.CourseName = b.CourseName")
        Sql.AppendLine("where ")
        'Sql.AppendLine("	PathID = '" & pathID.ToString() & "'")

        Return

    End Sub

    ''' <summary>
    ''' NO DELETE FUNCTION YET
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub dgView_009_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Return

    End Sub

    Private Sub GetGridValue_dgView_009(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
            TryCast(gridView.FindEditFormTemplateControl("pageControl_009"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

        'Dim txtPathID As DevExpress.Web.ASPxEditors.ASPxTextBox =
        '    TryCast(pgControl.FindControl("txtPathID_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        'If txtPathID IsNot Nothing Then

        '    newValues("PathID") = txtPathID.Text

        'End If

        Dim cmbCourse As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCourse_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbCourse IsNot Nothing Then

            newValues("CourseName") = cmbCourse.Text
            newValues("Course") = cmbCourse.Text

        End If

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtProvider_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtProvider IsNot Nothing Then

            newValues("ProviderName") = txtProvider.Text
            newValues("Provider") = txtProvider.Text

        End If

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtVenue_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtVenue IsNot Nothing Then

            newValues("VenueName") = txtVenue.Text
            newValues("Venue") = txtVenue.Text

        End If


        'ICT Assignment Info.
        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbType_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbType IsNot Nothing Then

            newValues("Type") = cmbType.Text

        End If

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(pgControl.FindControl("cmbCategory_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        If cmbCategory IsNot Nothing Then

            newValues("Category") = cmbCategory.Text

        End If

        Dim dteSOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteSOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteSOA IsNot Nothing Then

            newValues("SOA") = dteSOA.Text

        End If

        Dim txtExtension As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtExtension_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtExtension IsNot Nothing Then

            newValues("Extension") = txtExtension.Text

        End If

        Dim dtePlannedEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dtePlannedEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dtePlannedEOA IsNot Nothing Then

            newValues("PlannedEOA") = dtePlannedEOA.Text

        End If

        Dim dteActualEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteActualEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteActualEOA IsNot Nothing Then

            newValues("ActualEOA") = dteActualEOA.Text

        End If

        Dim txtPlannedDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtPlannedDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtPlannedDuration IsNot Nothing Then

            newValues("PlannedDuration") = txtPlannedDuration.Text

        End If

        Dim txtActualDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActualDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtActualDuration IsNot Nothing Then

            newValues("ActualDuration") = txtActualDuration.Text

        End If

        Dim txtActive As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtActive_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtActive IsNot Nothing Then

            newValues("Active") = txtActive.Text

        End If

        Dim txtLocation As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLocation_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtLocation IsNot Nothing Then

            newValues("Location") = txtLocation.Text

        End If

        Dim txtHomeCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeCompany IsNot Nothing Then

            newValues("HomeCompany") = txtHomeCompany.Text

        End If

        Dim txtHomeDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeDivision IsNot Nothing Then

            newValues("HomeDivision") = txtHomeDivision.Text

        End If

        Dim txtHomeDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeDepartment IsNot Nothing Then

            newValues("HomeDepartment") = txtHomeDepartment.Text

        End If

        Dim txtHomeSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeSection IsNot Nothing Then

            newValues("HomeSection") = txtHomeSection.Text

        End If

        Dim txtHostCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostCompany IsNot Nothing Then

            newValues("HostCompany") = txtHostCompany.Text

        End If

        Dim txtHostDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostDivision IsNot Nothing Then

            newValues("HostDivision") = txtHostDivision.Text

        End If

        Dim txtHostDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostDepartment IsNot Nothing Then

            newValues("HostDepartment") = txtHostDepartment.Text

        End If

        Dim txtHostSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostSection IsNot Nothing Then

            newValues("HostSection") = txtHostSection.Text

        End If


        'Repatriation Info.
        Dim dteFirstWD As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteFirstWD_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteFirstWD IsNot Nothing Then

            newValues("FirstWD") = dteFirstWD.Text

        End If

        Dim dteLastWD As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteLastWD_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteLastWD IsNot Nothing Then

            newValues("LastWD") = dteLastWD.Text

        End If


        'ICT Contact Info.

        Dim txtHomeContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeContactHC IsNot Nothing Then

            newValues("HomeContactHC") = txtHomeContactHC.Text

        End If

        Dim txtHomeContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeContactRes IsNot Nothing Then

            newValues("HomeContactRes") = txtHomeContactRes.Text

        End If

        Dim txtHomeAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeAddress IsNot Nothing Then

            newValues("HomeAddress") = txtHomeAddress.Text

        End If

        Dim txtHomePEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomePEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomePEmail IsNot Nothing Then

            newValues("HomePEmail") = txtHomePEmail.Text

        End If

        Dim txtHomeAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHomeAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHomeAEmail IsNot Nothing Then

            newValues("HomeAEmail") = txtHomeAEmail.Text

        End If

        Dim txtHostContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostContactHC IsNot Nothing Then

            newValues("HostContactHC") = txtHostContactHC.Text

        End If

        Dim txtHostContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostContactRes IsNot Nothing Then

            newValues("HostContactRes") = txtHostContactRes.Text

        End If

        Dim txtHostAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostAddress IsNot Nothing Then

            newValues("HostAddress") = txtHostAddress.Text

        End If

        Dim txtHostPEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostPEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostPEmail IsNot Nothing Then

            newValues("HostPEmail") = txtHostPEmail.Text

        End If

        Dim txtHostAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtHostAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtHostAEmail IsNot Nothing Then

            newValues("HostAEmail") = txtHostAEmail.Text

        End If



        'Service Contract Info.

        Dim dteStartOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteStartOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteStartOSC IsNot Nothing Then

            newValues("StartOSC") = dteStartOSC.Text

        End If

        Dim dteEndOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(pgControl.FindControl("dteEndOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        If dteEndOSC IsNot Nothing Then

            newValues("EndOSC") = dteEndOSC.Text

        End If

        Dim txtLengthOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtLengthOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtLengthOSC IsNot Nothing Then

            newValues("LengthOSC") = txtLengthOSC.Text

        End If

        Dim txtStatusOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(pgControl.FindControl("txtStatusOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtStatusOSC IsNot Nothing Then

            newValues("StatusOSC") = txtStatusOSC.Text

        End If

        'Dim cbCourse As DevExpress.Web.ASPxEditors.ASPxComboBox =
        '    TryCast(gridView.FindEditFormTemplateControl("cbCourse"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        'Dim cbProvider As DevExpress.Web.ASPxEditors.ASPxComboBox =
        '    TryCast(gridView.FindEditFormTemplateControl("cbProvider"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        'Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
        '    TryCast(gridView.FindEditFormTemplateControl("txtVenue"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        'newValues("CourseName") = cbCourse.Value
        'newValues("ProviderName") = cbProvider.Value
        'newValues("VenueName") = txtVenue.Text

    End Sub

    Private Sub dgView_009_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_009.CustomCallback

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim pgControl As DevExpress.Web.ASPxTabControl.ASPxPageControl =
                TryCast(gridView.FindEditFormTemplateControl("pageControl_009"), DevExpress.Web.ASPxTabControl.ASPxPageControl)

            Dim cmbCourse As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(pgControl.FindControl("cmbCourse_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(pgControl.FindControl("cmbCategory_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(pgControl.FindControl("cmbType_009"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtProvider_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtExtension As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtExtension_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtPlannedDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtPlannedDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtActualDuration As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtActualDuration_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtActive As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtActive_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtLengthOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtLengthOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim txtStatusOSC As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(pgControl.FindControl("txtStatusOSC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            Dim dteSOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dteSOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Dim dtePlannedEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dtePlannedEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Dim dteActualEOA As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dteActualEOA_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Dim dteStartOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dteStartOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Dim dteEndOSC As DevExpress.Web.ASPxEditors.ASPxDateEdit =
                TryCast(pgControl.FindControl("dteEndOSC_009"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

            Select Case GetXML(e.Parameters, KeyName:="ID")

                Case "txtExtension_009"

                    Dim value = GetXML(e.Parameters, KeyName:="Value")
                    Dim months As Integer

                    If (Integer.TryParse(value, months)) Then
                        If (months < 1 OrElse months > 99) Then
                            txtExtension.Text = String.Empty
                            Throw New Exception("Extension (Months) cannot be less than 1 or greater than 99.")
                        End If
                    Else
                        txtExtension.Text = String.Empty
                        Throw New Exception("Invalid Extension (Months) value.")
                    End If

                    GoTo CalculatePlannedActual

                Case "dteActualEOA_009", "dtePlannedEOA_009", "dteSOA_009"
CalculatePlannedActual:
                    If (dteSOA.Text <> String.Empty AndAlso dtePlannedEOA.Text <> String.Empty) Then

                        txtPlannedDuration.Text = String.Format("{0} year/s and {1} month/s ({2})", Math.Truncate(DateDiff(DateInterval.Month, dteSOA.Date, dtePlannedEOA.Date) / 12), DateDiff(DateInterval.Month, dteSOA.Date, dtePlannedEOA.Date) Mod 12, IIf((Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dtePlannedEOA.Date)) / 12).ToString("#.00") = ".00", "0", (Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dtePlannedEOA.Date)) / 12).ToString("#.00")))

                    Else

                        txtPlannedDuration.Text = String.Empty

                    End If

                    If (dtePlannedEOA.Text = String.Empty OrElse txtExtension.Text = String.Empty) Then

                        dteActualEOA.Text = String.Empty

                    Else

                        dteActualEOA.Date = dtePlannedEOA.Date.AddMonths(Integer.Parse(txtExtension.Text))

                    End If

                    If (dteActualEOA.Text <> String.Empty) Then

                        dteStartOSC.Date = dteActualEOA.Date.AddDays(1)

                        If (Date.Today <= dteActualEOA.Date) Then

                            txtActive.Text = "Yes"

                        ElseIf (Date.Today > dteActualEOA.Date) Then

                            txtActive.Text = "No"

                        Else

                            txtActive.Text = String.Empty

                        End If

                    End If


                    If (dteSOA.Text <> String.Empty AndAlso dteActualEOA.Text <> String.Empty) Then

                        txtActualDuration.Text = String.Format("{0} year/s and {1} month/s ({2})", Math.Truncate(DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date) / 12), DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date) Mod 12, IIf((Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date)) / 12).ToString("#.00") = ".00", "0", (Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date)) / 12).ToString("#.00")))

                    Else

                        txtActualDuration.Text = String.Empty

                    End If

                    If dteActualEOA.Text <> String.Empty Then GoTo ServiceContractInfo

                Case "ServiceContractInfo"
ServiceContractInfo:
                    If (cmbCategory.Text <> String.Empty AndAlso txtActualDuration.Text <> String.Empty) Then

                        Dim actualDuration As String = IIf((Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date)) / 12).ToString("#.00") = ".00", "0", (Decimal.Parse(DateDiff(DateInterval.Month, dteSOA.Date, dteActualEOA.Date)) / 12).ToString("#.00"))

                        If (cmbCategory.SelectedItem.Text.Contains("A -") OrElse cmbCategory.SelectedItem.Text.Contains("B -")) Then

                            If (Decimal.Parse(actualDuration) < 1.5) Then

                                txtLengthOSC.Text = "4 years"

                            ElseIf (Decimal.Parse(actualDuration) < 2) Then

                                txtLengthOSC.Text = "4.5 years"

                            ElseIf (Decimal.Parse(actualDuration) < 2.5) Then

                                txtLengthOSC.Text = "5 years"

                            ElseIf (Decimal.Parse(actualDuration) < 3) Then

                                txtLengthOSC.Text = "5.5 years"

                            ElseIf (Decimal.Parse(actualDuration) >= 3) Then

                                txtLengthOSC.Text = "6 years"

                            End If

                        ElseIf (cmbCategory.SelectedItem.Text.Contains("C -") OrElse cmbCategory.SelectedItem.Text.Contains("D -")) Then

                            If (Decimal.Parse(actualDuration) < 1.5) Then

                                txtLengthOSC.Text = "5 years"

                            ElseIf (Decimal.Parse(actualDuration) < 2) Then

                                txtLengthOSC.Text = "5.5 years"

                            ElseIf (Decimal.Parse(actualDuration) < 2.5) Then

                                txtLengthOSC.Text = "6 years"

                            ElseIf (Decimal.Parse(actualDuration) < 3) Then

                                txtLengthOSC.Text = "6.5 years"

                            ElseIf (Decimal.Parse(actualDuration) >= 3) Then

                                txtLengthOSC.Text = "7 years"

                            End If

                        Else

                            txtLengthOSC.Text = String.Empty

                        End If

                        If (txtLengthOSC.Text <> String.Empty AndAlso dteStartOSC.Text <> String.Empty) Then

                            Dim duration As String = txtLengthOSC.Text.Replace(" years", String.Empty)

                            dteEndOSC.Date = dteStartOSC.Date.AddYears(Math.Truncate(Double.Parse(duration)))

                            If (duration.Contains(".5")) Then

                                dteEndOSC.Date = dteEndOSC.Date.AddMonths(6)

                            End If

                        End If

                        If (dteEndOSC.Text <> String.Empty) Then

                            Dim dtTermination As DataTable = GetSQLDT("SELECT TOP 1 p.TerminationDate FROM Personnel p WHERE p.Termination = 1 AND p.EmployeeNum = '" & UDetails.EmployeeNum & "' AND p.TerminationDate IS NOT NULL")

                            If (IsData(dtTermination)) Then

                                Dim terminationDate As Date = Date.Parse(dtTermination.Rows(0).Item("TerminationDate").ToString())

                                If (terminationDate > dteEndOSC.Date) Then

                                    txtStatusOSC.Text = "Served"

                                ElseIf (terminationDate <= dteEndOSC.Date) Then

                                    txtStatusOSC.Text = "Unserved"

                                Else

                                    txtStatusOSC.Text = String.Empty

                                End If

                            Else

                                If (Date.Today > dteEndOSC.Date) Then

                                    txtStatusOSC.Text = "Served"

                                ElseIf (Date.Today <= dteEndOSC.Date) Then

                                    txtStatusOSC.Text = "Pending Completion"

                                Else

                                    txtStatusOSC.Text = String.Empty

                                End If

                            End If

                        End If

                    End If

                Case "cmbCourse_009"

                    Dim value = GetXML(e.Parameters, KeyName:="Value")

                    Dim dtProviderName As DataTable = GetSQLDT("SELECT TOP 1 ProviderName FROM CourseLU WHERE (InternalCourse = 0  OR InternalCourse IS NULL) AND Overseas = 1 AND CourseName = '" & value & "' ORDER BY CourseName")

                    If (IsData(dtProviderName)) Then

                        txtProvider.Text = dtProviderName.Rows(0).Item("ProviderName").ToString()

                    End If

                Case "cmbType_009"

                    Dim value As String = GetXML(e.Parameters, KeyName:="Value")

                    If (txtProvider.Text = String.Empty) Then Throw New Exception("Course should be populated before selecting ICT Type.")

                    Dim txtHomeCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostCompany As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostCompany_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostDivision As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostDivision_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostDepartment As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostDepartment_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostSection As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostSection_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)


                    Dim txtHomeContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomePEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomePEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHomeAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHomeAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostContactHC As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostContactHC_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostContactRes As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostContactRes_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostAddress As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostAddress_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostPEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostPEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)

                    Dim txtHostAEmail As DevExpress.Web.ASPxEditors.ASPxTextBox =
                        TryCast(pgControl.FindControl("txtHostAEmail_009"), DevExpress.Web.ASPxEditors.ASPxTextBox)


                    Dim dtEmployeeCompany As DataTable = GetSQLDT("SELECT c.Division, c.SubDivision, c.SubSubDivision, p.HomeTel, p.CellTel, p.Address1, p.EMailAddress, p.EMailAddress1 FROM Personnel p INNER JOIN Company c ON p.CompanyNum = c.CompanyNum WHERE p.EmployeeNum = '" & UDetails.EmployeeNum & "'")

                    If value = "Local" Then

                        If (IsData(dtEmployeeCompany)) Then

                            txtHomeCompany.Text = "Toyota Motor Philippines"
                            txtHomeDivision.Text = dtEmployeeCompany.Rows(0).Item("Division").ToString()
                            txtHomeDepartment.Text = dtEmployeeCompany.Rows(0).Item("SubDivision").ToString()
                            txtHomeSection.Text = dtEmployeeCompany.Rows(0).Item("SubSubDivision").ToString()

                            txtHomeContactHC.Text = dtEmployeeCompany.Rows(0).Item("HomeTel").ToString()
                            txtHomeContactRes.Text = dtEmployeeCompany.Rows(0).Item("CellTel").ToString()
                            txtHomeAddress.Text = dtEmployeeCompany.Rows(0).Item("Address1").ToString()
                            txtHomePEmail.Text = dtEmployeeCompany.Rows(0).Item("EMailAddress").ToString()
                            txtHomeAEmail.Text = dtEmployeeCompany.Rows(0).Item("EMailAddress1").ToString()

                            txtHostCompany.Text = String.Empty
                            txtHostDivision.Text = String.Empty
                            txtHostDepartment.Text = String.Empty
                            txtHostSection.Text = String.Empty

                            txtHostContactHC.Text = String.Empty
                            txtHostContactRes.Text = String.Empty
                            txtHostAddress.Text = String.Empty
                            txtHostPEmail.Text = String.Empty
                            txtHostAEmail.Text = String.Empty

                        End If

                    ElseIf value = "Foreign" Then

                        If (IsData(dtEmployeeCompany)) Then

                            txtHomeCompany.Text = String.Empty
                            txtHomeDivision.Text = String.Empty
                            txtHomeDepartment.Text = String.Empty
                            txtHomeSection.Text = String.Empty

                            txtHomeContactHC.Text = String.Empty
                            txtHomeContactRes.Text = String.Empty
                            txtHomeAddress.Text = String.Empty
                            txtHomePEmail.Text = String.Empty
                            txtHomeAEmail.Text = String.Empty

                            txtHostCompany.Text = "Toyota Motor Philippines"
                            txtHostDivision.Text = dtEmployeeCompany.Rows(0).Item("Division").ToString()
                            txtHostDepartment.Text = dtEmployeeCompany.Rows(0).Item("SubDivision").ToString()
                            txtHostSection.Text = dtEmployeeCompany.Rows(0).Item("SubSubDivision").ToString()

                            txtHostContactHC.Text = dtEmployeeCompany.Rows(0).Item("HomeTel").ToString()
                            txtHostContactRes.Text = dtEmployeeCompany.Rows(0).Item("CellTel").ToString()
                            txtHostAddress.Text = dtEmployeeCompany.Rows(0).Item("Address1").ToString()
                            txtHostPEmail.Text = dtEmployeeCompany.Rows(0).Item("EMailAddress").ToString()
                            txtHostAEmail.Text = dtEmployeeCompany.Rows(0).Item("EMailAddress1").ToString()

                        End If

                    End If

            End Select

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

        End Try



        'Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
        '    DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        'Dim courseName As String = String.Empty

        'Select Case GetXML(e.Parameters, KeyName:="ID")

        '    Case "CourseName"

        '        courseName = GetXML(e.Parameters, KeyName:="Value")

        '        LoadExpDS(dsProviders_Overseas, "SELECT DISTINCT ProviderName FROM CourseLU WHERE CourseName = '" & courseName & "' ORDER BY ProviderName")

        'End Select

    End Sub

#End Region

#Region "External"

    Protected Sub dgViewBC_010_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgViewBC_010_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbCategoryBC_010"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudgetCodeBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtYear As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYearBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtText As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTextBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSequenceNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtSequenceNumBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        'LoadExpDS(dsCategoryBC_010, "SELECT DISTINCT [CategoryName] FROM TrainingExternalBudget WHERE [Year] = " &  & " ORDER BY [CategoryName]")

        LoadExpDS(dsCategoryBC_010, "SELECT DISTINCT [CategoryName] FROM TrainingExternalBudget ORDER BY [CategoryName]")

        txtBudgetCode.Enabled = False

        txtBudgetCode.Width = IIf(sender.IsNewRowEditing, New Unit("96%"), New Unit("100%"))

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim categoryName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CategoryName")
            Dim budgetCode As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "BudgetCode")
            Dim year As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Year")
            Dim text As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Text")
            Dim sequenceNum As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "SequenceNum")

            cmbCategory.Text = categoryName.ToString()
            txtBudgetCode.Text = budgetCode
            txtYear.Text = year.ToString()
            txtText.Text = text
            txtSequenceNum.Text = sequenceNum

            cmbCategory.Enabled = False
            txtYear.Enabled = False
            txtText.Enabled = False
            txtSequenceNum.Enabled = False

        End If

    End Sub

    Protected Sub dgViewBC_010_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbCategoryBC_010"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudgetCodeBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtYear As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYearBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtText As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTextBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSequenceNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtSequenceNumBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        GetGridValue_dgViewBC_010(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

        If e.RowError Is Nothing OrElse e.RowError = "" Then

            Dim year As Object = e.NewValues("Year")

            Dim seqNum As Object = e.NewValues("SequenceNum")

            Dim tryYear As Integer

            Dim trySeqNum As Integer

            If Not Integer.TryParse(year.ToString(), tryYear) Then

                e.RowError = "Year is invalid"

            End If

            If Not Integer.TryParse(seqNum.ToString(), trySeqNum) Then

                e.RowError = "Sequence Number is invalid!"

            End If

        End If

    End Sub

    Private Sub GetGridValue_dgViewBC_010(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As OrderedDictionary)

        Dim cmbCategory As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbCategoryBC_010"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudgetCodeBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtYear As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYearBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtText As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTextBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtSequenceNum As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtSequenceNumBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If cmbCategory IsNot Nothing Then

            newValues("CategoryName") = cmbCategory.Text

        End If

        If txtBudgetCode IsNot Nothing Then

            newValues("BudgetCode") = String.Format("{0}{1}{2}", txtYear.Text, txtText.Text, txtSequenceNum.Text)

        End If

        If txtYear IsNot Nothing Then

            If txtYear.Value IsNot Nothing Then

                newValues("Year") = txtYear.Value.ToString()

            Else

                newValues("Year") = ""

            End If

        End If

        If txtText IsNot Nothing Then

            newValues("Text") = txtText.Text

        End If

        If txtSequenceNum IsNot Nothing Then

            newValues("SequenceNum") = txtSequenceNum.Text

        End If

    End Sub

    Protected Sub dgViewBC_010_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim dtExtBudg As DataTable = Nothing
        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgViewBC_010(gridView, e.NewValues)

            Dim categoryName As Object = e.NewValues("CategoryName")
            Dim budgetCode As Object = e.NewValues("BudgetCode")
            Dim year As Object = e.NewValues("Year")
            Dim text As Object = e.NewValues("Text")
            Dim sequenceNum As Object = e.NewValues("SequenceNum")
            Dim capturedBy As String = UDetails.EmployeeNum
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            dtExtBudg = GetSQLDT(
                "SELECT " +
                "   TOP 1 " +
                "   CategoryName " +
                "FROM TrainingExternalBudgetMonitoring " +
                "WHERE CategoryName = '" + categoryName.ToString() + "' " +
                "  AND Year = '" + year.ToString() + "' ")

            If dtExtBudg.Rows.Count > 0 Then

                Throw New Exception("Record with same category name and year already exists.")

            End If

            sql = New StringBuilder()

            sql.AppendLine("INSERT INTO [TrainingExternalBudgetMonitoring] (")
            sql.AppendLine("CategoryName,")
            sql.AppendLine("BudgetCode,")
            sql.AppendLine("Year,")
            sql.AppendLine("Text,")
            sql.AppendLine("SequenceNum,")
            sql.AppendLine("CapturedBy,")
            sql.AppendLine("CapturedOn")
            sql.AppendLine(")")
            sql.AppendLine("VALUES (")
            sql.AppendLine("'" & IIf(categoryName IsNot Nothing, categoryName.ToString(), "") & "',")
            sql.AppendLine("'" & IIf(budgetCode IsNot Nothing, budgetCode.ToString(), "") & "',")
            sql.AppendLine(IIf(year IsNot Nothing, year, "0") & ",")
            sql.AppendLine("'" & IIf(text IsNot Nothing, text.ToString(), "") & "',")
            sql.AppendLine("'" & IIf(sequenceNum IsNot Nothing, sequenceNum.ToString(), "") & "',")
            sql.AppendLine("'" & capturedBy & "',")
            sql.AppendLine("'" & capturedOn & "'")
            sql.AppendLine(")")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtExtBudg IsNot Nothing Then

                dtExtBudg.Clear()
                dtExtBudg.Dispose()
                dtExtBudg = Nothing

            End If

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgViewBC_010_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim categoryName As Object = e.Values("CategoryName")
            Dim year As Object = e.Values("Year")
            Dim budgetCode As Object = e.Values("BudgetCode")
            sql = New StringBuilder()

            sql.AppendLine("DELETE FROM [TrainingExternalBudgetMonitoring] ")
            sql.AppendLine("WHERE CategoryName = '" & IIf(categoryName IsNot Nothing, categoryName.ToString(), "") & "' AND Year=" & year.ToString() & " AND BudgetCode='" & budgetCode.ToString() & "'")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Private Sub dgViewBC_010_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgViewBC_010.CustomCallback

        Dim budgetCode As String = String.Empty

        If (sender.IsEditing) Then

            Select Case GetXML(e.Parameters, KeyName:="ID")

                Case "BudgetCode"
                    budgetCode = GetXML(e.Parameters, KeyName:="Value").Replace("null", String.Empty)

            End Select

        End If

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtBudgetCode As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudgetCodeBC_010"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        txtBudgetCode.Text = budgetCode

    End Sub

    'No Updating of Records Once Created Removed from aspx.
    'Protected Sub dgViewBC_010_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

    'End Sub

    Protected Sub dgView_010_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtCatergory As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtCatergory"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cbYear As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbYear"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cbMonth As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbMonth"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtBudget As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudget"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        PopulateYearAndMonth(cbYear, cbMonth)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim categoryName As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "CategoryName")
            Dim year As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Year")
            Dim month As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Month")
            Dim budget As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Budget")

            txtCatergory.Text = categoryName
            cbYear.SelectedItem = cbYear.Items.FindByValue(year.ToString())
            cbMonth.SelectedItem = cbMonth.Items.FindByValue(month.ToString())
            txtBudget.Text = budget

            txtCatergory.Enabled = False
            cbYear.Enabled = False
            cbMonth.Enabled = False
            txtBudget.Enabled = False

        End If

        gridView.FindEditFormTemplateControl("UpdateButton").Visible = False

    End Sub

    Protected Sub dgView_010_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgView_010_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtCatergory As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtCatergory"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cbYear As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbYear"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cbMonth As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbMonth"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        GetGridValue_dgView_010(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

        If e.RowError Is Nothing OrElse e.RowError = "" Then

            Dim budget As Object = e.NewValues("Budget")

            Dim tryBudget As Decimal

            If Not Decimal.TryParse(budget.ToString(), tryBudget) Then

                e.RowError = "Budget is invalid"

            End If

        End If

    End Sub

    Protected Sub dgView_010_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim dtExtBudg As DataTable = Nothing
        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_010(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim categoryName As Object = e.NewValues("CategoryName")
            Dim year As Object = e.NewValues("Year")
            Dim month As Object = e.NewValues("Month")
            Dim budget As Object = e.NewValues("Budget")
            Dim capturedBy As String = UDetails.EmployeeNum
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            dtExtBudg = GetSQLDT(
                "SELECT " +
                "   TOP 1 " +
                "   CategoryName " +
                "FROM TrainingExternalBudget " +
                "WHERE CategoryName = '" + categoryName + "' " +
                "  AND Year = '" + year + "' " +
                "  AND Month = '" + month + "' ")

            If dtExtBudg.Rows.Count > 0 Then

                Throw New Exception("Record with same Category, Year and Month is already existing.")

            End If

            sql = New StringBuilder()

            sql.AppendLine("INSERT INTO [TrainingExternalBudget] (")
            sql.AppendLine("CompanyNum,")
            sql.AppendLine("CategoryName,")
            sql.AppendLine("Year,")
            sql.AppendLine("Month,")
            sql.AppendLine("Budget,")
            sql.AppendLine("RemainingBudget,")
            sql.AppendLine("CapturedBy,")
            sql.AppendLine("CapturedOn")
            sql.AppendLine(")")
            sql.AppendLine("VALUES (")
            sql.AppendLine("'" & companyNum & "',")
            sql.AppendLine("'" & IIf(categoryName IsNot Nothing, categoryName, "") & "',")
            sql.AppendLine(IIf(year IsNot Nothing, year, "0") & ",")
            sql.AppendLine(IIf(month IsNot Nothing, month, "0") & ",")
            sql.AppendLine(IIf(budget IsNot Nothing, "'" & budget & "'", "NULL") & ",")
            sql.AppendLine(IIf(budget IsNot Nothing, "'" & budget & "'", "NULL") & ",")
            sql.AppendLine("'" & capturedBy & "',")
            sql.AppendLine("'" & capturedOn & "'")
            sql.AppendLine(")")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtExtBudg IsNot Nothing Then

                dtExtBudg.Clear()
                dtExtBudg.Dispose()
                dtExtBudg = Nothing

            End If

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_010_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_010(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim categoryName As Object = e.NewValues("CategoryName")
            Dim year As Object = e.NewValues("Year")
            Dim month As Object = e.NewValues("Month")
            Dim budget As Object = e.NewValues("Budget")
            Dim capturedBy As String = UDetails.EmployeeNum
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            sql = New StringBuilder()

            sql.AppendLine("UPDATE [TrainingExternalBudget] SET ")
            sql.AppendLine("    Budget = " & IIf(budget IsNot Nothing, "'" & budget & "'", "NULL") & ", ")
            sql.AppendLine("    CapturedBy = '" & capturedBy & "', ")
            sql.AppendLine("    CapturedOn = '" & capturedOn & "' ")
            sql.AppendLine("WHERE CategoryName = '" & IIf(categoryName IsNot Nothing, categoryName, "") & "' ")
            sql.AppendLine("  AND Year = " & IIf(year IsNot Nothing, year, "0") & " ")
            sql.AppendLine("  AND Month = " & IIf(month IsNot Nothing, month, "0") & " ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_010_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim companyNum As String = EDetails.CompanyNum
            Dim categoryName As Object = e.Values("CategoryName")
            Dim year As Object = e.Values("Year")
            Dim month As Object = e.Values("Month")

            sql = New StringBuilder()

            sql.AppendLine("select count(*) from TrainingAgreementForm where Category = '" & categoryName & "'")

            Dim records As Int16 = 0

            ExecSQL(sql.ToString(), records)

            If (records = 0) Then
                sql.Clear()

                sql.AppendLine("DELETE FROM [TrainingExternalBudget] ")
                sql.AppendLine("WHERE CategoryName = '" & IIf(categoryName IsNot Nothing, categoryName, "") & "' ")
                sql.AppendLine("  AND Year = " & IIf(year IsNot Nothing, year, "0") & " ")
                sql.AppendLine("  AND Month = " & IIf(month IsNot Nothing, month, "0") & " ")

                e.Cancel = ExecSQL(sql.ToString())

                gridView.CancelEdit()
            Else
                e.Cancel = True

                Throw New Exception("Cannot delete budget category. Record is in use.")
            End If

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Private Sub GetGridValue_dgView_010(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim txtCatergory As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtCatergory"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cbYear As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbYear"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cbMonth As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cbMonth"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtBudget As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtBudget"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtCatergory IsNot Nothing Then

            newValues("CategoryName") = txtCatergory.Text

        End If

        If cbYear IsNot Nothing Then

            newValues("Year") = cbYear.Value

        End If

        If cbMonth IsNot Nothing Then

            newValues("Month") = cbMonth.Value

        End If

        If txtBudget IsNot Nothing Then

            newValues("Budget") = txtBudget.Text

        End If

    End Sub

    ''' <summary>
    ''' Open/Generates External Budget Monitoring Report 
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>
    ''' Param0 is Year
    ''' Param1 is Month From
    ''' Param2 is Month To
    ''' Param3 is Generates As (PDF or EXCEL) added in webmain.vb
    ''' webmain.vb will only capture pParam3 from External Budget Monitoring's as the File Format.
    ''' </remarks>
    Protected Sub cmdGenerate_007_Click(sender As Object, e As EventArgs) Handles cmdGenerate_007.Click

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        Dim Param0 As String = cmbYear_007.SelectedItem.Value

        Dim Param1 As String = cmbMonthFrom_007.SelectedItem.Value

        Dim Param2 As String = cmbMonthTo_007.SelectedItem.Value

        Dim Param3 As String = rblGenerate_007.SelectedItem.Value

        ReportID = "External Budget Monitoring"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=" & Param0 & "><param1=" & Param1 & "><param2=" & Param2 & "><param3=" & Param3 & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "GenerateReport", "window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open')", True)

    End Sub

    Protected Sub cmbMonthFrom_007_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbMonthFrom_007.SelectedIndexChanged

        If cmbMonthFrom_007 IsNot Nothing Then

            cmbMonthTo_007.Items.Clear()

            For i = cmbMonthFrom_007.SelectedItem.Index + 1 To 12

                cmbMonthTo_007.Items.Add(New DateTime(1900, i, 1).ToString("MMMM"), i)

            Next

        End If

        updMonthTo_007.Update()

    End Sub

#End Region

#Region "TAF"

    Protected Sub btnMainSubmit_014_Click(sender As Object, e As EventArgs) Handles btnMainSubmit_014.Click

        Dim programTitle As String = String.Empty
        Dim provider As String = String.Empty
        Dim venue As String = String.Empty
        Dim investment As String = String.Empty

        Dim dtColumns As DataTable = GetSQLDT(
                    "SELECT " +
                    "   TOP 1 " +
                    "   tad.[ProgramTitle], " +
                    "   tad.[Provider], " +
                    "   tad.[Venue], " +
                    "   tad.[Investment] " +
                    "FROM TAFProgramDetails tad " +
                    "INNER JOIN TrainingAgreementForm taf " +
                    "   ON tad.[TAFID] = taf.[TAFID]" +
                    "WHERE taf.[TAFID] = '" + txtTAFID_007.Text + "' ")

        If (IsData(dtColumns)) Then

            programTitle = IIf(IsDBNull(dtColumns.Rows(0).Item("ProgramTitle")), String.Empty, dtColumns.Rows(0).Item("ProgramTitle").ToString())
            provider = IIf(IsDBNull(dtColumns.Rows(0).Item("Provider")), String.Empty, dtColumns.Rows(0).Item("Provider").ToString())
            venue = IIf(IsDBNull(dtColumns.Rows(0).Item("Venue")), String.Empty, dtColumns.Rows(0).Item("Venue").ToString())
            investment = IIf(IsDBNull(dtColumns.Rows(0).Item("Investment")), String.Empty, dtColumns.Rows(0).Item("Investment").ToString())

        End If

        With EDetails

            Dim bSaved As Boolean
            Dim sql As StringBuilder = Nothing
            Dim startDate As String = DateTime.Today.ToString("MM/dd/yyyy")

            sql = New StringBuilder()

            sql.AppendLine("UPDATE taf SET")
            sql.AppendLine("taf.[MobileNum] = '" & txtMobile_007.Text & "',")
            sql.AppendLine("taf.[ExternalPositionTitle] = '" & txtExternalPos_007.Text.Replace("'", "''").Replace("''''", "''") & "',")
            sql.AppendLine("taf.[Objectives1] = '" & txtObjectives1_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Objectives2] = '" & txtObjectives2_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Objectives3] = '" & txtObjectives3_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Justification1] = '" & txtJustification1_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Justification2] = '" & txtJustification2_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Justification3] = '" & txtJustification3_014.Text.Replace("'", "''") & "',")
            sql.AppendLine("taf.[Status] = 'Submitted',")
            sql.AppendLine("taf.[DatePrepared] = '" & startDate & "'")
            sql.AppendLine("FROM TrainingAgreementForm taf")
            sql.AppendLine("WHERE")
            sql.AppendLine("taf.[TAFID] = '" & txtTAFID_007.Text & "'")
            sql.AppendLine()
            sql.AppendLine("IF NOT EXISTS (SELECT CourseName From CourseNameLU WHERE CourseName = '" & programTitle & "')")
            sql.AppendLine("INSERT INTO CourseNameLU (CourseName)")
            sql.AppendLine("VALUES('" & programTitle & "')")
            sql.AppendLine()
            sql.AppendLine("IF NOT EXISTS (SELECT CourseName From CourseLU WHERE CourseName = '" & programTitle & "' AND ProviderName = '" & provider & "')")
            sql.AppendLine("INSERT INTO CourseLU (CourseName, ProviderName,  InternalCourse)")
            sql.AppendLine("VALUES('" & programTitle & "', '" & provider & "', 0)")
            sql.AppendLine()
            sql.AppendLine("INSERT INTO [TrainingPlanned]")
            sql.AppendLine("(")
            sql.AppendLine("[CompanyNum],")
            sql.AppendLine("[EmployeeNum],")
            sql.AppendLine("[CourseName],")
            sql.AppendLine("[ProviderName],")
            sql.AppendLine("[StartDate],")
            sql.AppendLine("[CapturedByUsername],")
            sql.AppendLine("[TrainingStatus],")
            sql.AppendLine("[VenueName]")
            sql.AppendLine(")")
            sql.AppendLine("VALUES")
            sql.AppendLine("(")
            sql.AppendLine("'" & .CompanyNum & "',")
            sql.AppendLine("'" & .EmployeeNum & "',")
            sql.AppendLine("'" & programTitle & "',")
            sql.AppendLine("'" & provider & "',")
            sql.AppendLine("'" & startDate & "',")
            sql.AppendLine("'" & Session("LoggedOn").EmployeeNum & "',")
            sql.AppendLine("'PendingApproval',")
            sql.AppendLine("'" & venue & "'")
            sql.AppendLine(")")

            bSaved = ExecSQL(sql.ToString())

            If bSaved Then

                sql = New StringBuilder()

                sql.AppendLine("exec [ess.WFProc]")
                sql.AppendLine("'" & Session("LoggedOn").CompanyNum & "',")
                sql.AppendLine("'" & Session("LoggedOn").EmployeeNum & "',")
                sql.AppendLine("'" & .CompanyNum & "',")
                sql.AppendLine("'" & .EmployeeNum & "',")
                sql.AppendLine("0, 'Training', 'Agreement', 'Start', 'Start',")
                sql.AppendLine("'" & startDate & "'")

                bSaved = ExecSQL(sql.ToString())

            End If

            If (bSaved) Then

                Response.Redirect("training.aspx?success=1")

            Else

                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""information Failed to submit the agreement!"")", True)

            End If

        End With

        dtColumns.Dispose()

        dtColumns = Nothing

    End Sub

    Protected Sub btnSubmitAgreement_Click(sender As Object, e As EventArgs) Handles btnSubmitAgreement_014.Click

        ShowPopup = False

        With UDetails

            'jlacno 10/31/18 page 32 Validate
            If (Not ShowPopup AndAlso dgView_014.VisibleRowCount > 1) Then

                ShowPopup = True

                ResultText = "information Invalid number of Program Details Record! Kindly create only 1 record."

            End If

            ' jalzate - 04/12/2019
            ' validate program detail on submit
            If (Not ShowPopup AndAlso dgView_014.VisibleRowCount < 1) Then

                ShowPopup = True

                ResultText = "information Please add one program detail to proceed."

            End If
            ' jalzate - end

            Dim dtColumns As DataTable = GetSQLDT(
                    "SELECT " +
                    "   TOP 1 " +
                    "   [Investment] " +
                    "FROM TAFProgramDetails " +
                    "WHERE [TAFID] = '" + txtTAFID_007.Text + "' " +
                    "  AND [ProgramType] = 'Public Seminar/External Training Program' ")

            If (IsData(dtColumns)) Then

                If (Decimal.Parse(dtColumns.Rows(0).Item(0).ToString()) > 50000) Then

                    ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "SubmitFormShow", "window.parent.ShowPopup(""yesorno publicseminar"")", True)

                    dtColumns.Dispose()

                    dtColumns = Nothing

                    Return

                End If

            End If

            dtColumns.Dispose()

            dtColumns = Nothing

            If (Not ShowPopup) Then

                'This will call btnMainSubmit_014_Click event above
                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "SubmitFormShow", "window.parent.ShowPopup(""yesorno"")", True)

            Else

                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

    Protected Sub dgView_014_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgView_014_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtProgramDetailsID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramDetailsID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramTitle_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbProgramType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtInvestment_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProvider_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtVenue_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateFrom_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateTo_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)
        Dim txtTAFID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTAFID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim programDetailsID As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ProgramDetailsID")
            Dim programTitle As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ProgramTitle")
            Dim type As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Type")
            Dim programType As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ProgramType")
            Dim investment As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Investment")
            Dim venue As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Venue")
            Dim provider As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Provider")
            Dim dateFrom As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "DateFrom")
            Dim dateTo As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "DateTo")
            Dim tafID As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "TAFID")

            If (type.ToString() = "Functional Training Program") Then

                Dim sqlSelect As String = "SELECT 'Business Trip (Local and Overseas)' [ProgramType] UNION ALL SELECT 'Public Seminar/External Training Program' [ProgramType] UNION ALL SELECT 'In-house Special Training Program' [ProgramType] ORDER BY [ProgramType] ASC"

                LoadExpDS(dsTAFProgType, sqlSelect)
                txtInvestment.ReadOnly = False

            ElseIf (type.ToString() = "Specialized Development Program") Then

                LoadExpDS(dsTAFProgType, "SELECT [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] ORDER BY [Program] ASC")
                txtInvestment.ReadOnly = True

            End If

            txtProgramDetailsID.Text = programDetailsID.ToString()
            txtProgramTitle.Text = programTitle.ToString()
            cmbType.SelectedItem = cmbType.Items.FindByValue(type.ToString())
            cmbProgramType.Text = programType.ToString()
            txtInvestment.Text = investment.ToString()
            txtVenue.Text = venue.ToString()
            txtProvider.Text = provider.ToString()
            dteDateFrom.Date = dateFrom.ToString()
            dteDateTo.Date = dateTo.ToString()
            txtTAFID.Text = tafID.ToString()

            txtProgramDetailsID.Enabled = False
            txtTAFID.Enabled = False

        End If

    End Sub

    Protected Sub dgView_014_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtProgramDetailsID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramDetailsID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramTitle_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbProgramType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtInvestment_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProvider_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtVenue_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateFrom_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateTo_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtTAFID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTAFID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        GetGridValue_dgView_014(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

        e.RowError = dgView_0014_ValidateCustomRequiredFields(e)

    End Sub

    Private Function dgView_0014_ValidateCustomRequiredFields(e As DevExpress.Web.Data.ASPxDataValidationEventArgs) As String

        ' jalzate - 04/12/2019
        ' TSK0000398
        ' added validation for Start date and end date 
        Dim counter As Integer = 0

        If (IsNothing(e.NewValues("ProgramTitle")) OrElse e.NewValues("ProgramTitle").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("Type")) OrElse e.NewValues("Type").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("ProgramType")) OrElse e.NewValues("ProgramType").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("Investment")) OrElse e.NewValues("Investment").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("Provider")) OrElse e.NewValues("Provider").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("Venue")) OrElse e.NewValues("Venue").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("DateFrom")) OrElse e.NewValues("DateFrom").ToString() = String.Empty) Then counter += 1
        If (IsNothing(e.NewValues("DateTo")) OrElse e.NewValues("DateTo").ToString() = String.Empty) Then counter += 1

        If (counter > 1) Then Return "Please input a data for the list of fields with (*) symbol, it is indicated that it is a required field."

        If (IsNothing(e.NewValues("ProgramTitle")) OrElse e.NewValues("ProgramTitle").ToString() = String.Empty) Then Return "Program Title is required."
        If (IsNothing(e.NewValues("Type")) OrElse e.NewValues("Type").ToString() = String.Empty) Then Return "Type is required."
        If (IsNothing(e.NewValues("ProgramType")) OrElse e.NewValues("ProgramType").ToString() = String.Empty) Then Return "Program Type is required."
        If (IsNothing(e.NewValues("Investment")) OrElse e.NewValues("Investment").ToString() = String.Empty) Then Return "Investment is required."
        If (IsNothing(e.NewValues("Provider")) OrElse e.NewValues("Provider").ToString() = String.Empty) Then Return "Provider is required."
        If (IsNothing(e.NewValues("Venue")) OrElse e.NewValues("Venue").ToString() = String.Empty) Then Return "Venue is required."
        If (IsNothing(e.NewValues("DateFrom")) OrElse e.NewValues("DateFrom").ToString() = String.Empty) Then Return "DateFrom is required."
        If (IsNothing(e.NewValues("DateTo")) OrElse e.NewValues("DateTo").ToString() = String.Empty) Then Return "Provider is required."

        ' jalzate - end


        ' jalzate - 04/12/2019
        ' TSK0000390
        ' added validation for Start date and end date 

        If (DateCompareParse(e.NewValues("DateFrom").ToString(), e.NewValues("DateTo").ToString()) > 0) Then Return "Start date cannot be greater than end date."

        ' jalzate - end

    End Function

    Protected Sub dgView_014_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_014(gridView, e.NewValues)

            Dim type As Object = e.NewValues("Type")
            Dim programType As Object = e.NewValues("ProgramType")
            Dim programTitle As Object = e.NewValues("ProgramTitle")
            Dim provider As Object = e.NewValues("Provider")
            Dim dateFrom As Object = e.NewValues("DateFrom")
            Dim dateTo As Object = e.NewValues("DateTo")
            Dim venue As Object = e.NewValues("Venue")
            Dim investment As Object = e.NewValues("Investment")
            Dim tafID As Object = txtTAFID_007.Text

            'TO BE FOLLOWED VALIDATION
            'ValidateSpecializedFieldsValue(serviceAgreement, Nothing)

            sql = New StringBuilder()

            sql.AppendLine("INSERT INTO [TAFProgramDetails] (")
            sql.AppendLine("Type,")
            sql.AppendLine("ProgramType,")
            sql.AppendLine("ProgramTitle,")
            sql.AppendLine("Provider,")
            sql.AppendLine("DateFrom,")
            sql.AppendLine("DateTo,")
            sql.AppendLine("Venue,")
            sql.AppendLine("Investment,")
            sql.AppendLine("TAFID")
            sql.AppendLine(")")
            sql.AppendLine("VALUES (")
            sql.AppendLine("'" & type.ToString().Replace("'", "''") & "',")
            sql.AppendLine("'" & programType.ToString().Replace("'", "''") & "',")
            sql.AppendLine("'" & programTitle.ToString().Replace("'", "''") & "',")
            sql.AppendLine("'" & provider.ToString().Replace("'", "''") & "',")
            sql.AppendLine("'" & dateFrom & "',")
            sql.AppendLine("'" & dateTo & "',")
            sql.AppendLine("'" & venue.ToString().Replace("'", "''") & "',")
            sql.AppendLine("'" & investment & "',")
            sql.AppendLine("'" & tafID & "'")
            sql.AppendLine(")")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_014_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_014(gridView, e.NewValues)

            Dim programDetailsID As Object = e.NewValues("ProgramDetailsID")
            Dim type As Object = e.NewValues("Type")
            Dim programType As Object = e.NewValues("ProgramType")
            Dim programTitle As Object = e.NewValues("ProgramTitle")
            Dim provider As Object = e.NewValues("Provider")
            Dim dateFrom As Object = e.NewValues("DateFrom")
            Dim dateTo As Object = e.NewValues("DateTo")
            Dim venue As Object = e.NewValues("Venue")
            Dim investment As Object = e.NewValues("Investment")
            Dim tafID As Object = e.NewValues("TAFID")

            'TO BE FOLLOWED VALIDATION
            'ValidateSpecializedFieldsValue(e)

            sql = New StringBuilder()

            sql.AppendLine("UPDATE [TAFProgramDetails] SET ")
            sql.AppendLine("    Type = '" & type.ToString().Replace("'", "''") & "', ")
            sql.AppendLine("    ProgramType = '" & programType.ToString().Replace("'", "''") & "', ")
            sql.AppendLine("    ProgramTitle = '" & programTitle.ToString().Replace("'", "''") & "', ")
            sql.AppendLine("    Provider = '" & provider.ToString().Replace("'", "''") & "', ")
            sql.AppendLine("    DateFrom = '" & dateFrom & "', ")
            sql.AppendLine("    DateTo = '" & dateTo & "', ")
            sql.AppendLine("    Venue = '" & venue.ToString().Replace("'", "''") & "' ")
            sql.AppendLine("WHERE TAFID = '" & tafID.ToString() & "' ")
            sql.AppendLine("  AND ProgramDetailsID = '" & programDetailsID.ToString() & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_014_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim programDetailsID As Object = e.Values("ProgramDetailsID")
            Dim tafID As Object = e.Values("TAFID")

            sql = New StringBuilder()

            sql.AppendLine("DELETE FROM [TAFProgramDetails] ")
            sql.AppendLine("WHERE TAFID = '" & tafID.ToString() & "' ")
            sql.AppendLine("  AND ProgramDetailsID = '" & programDetailsID.ToString() & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Private Sub GetGridValue_dgView_014(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim txtProgramDetailsID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramDetailsID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgramTitle As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgramTitle_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
            TryCast(gridView.FindEditFormTemplateControl("cmbProgramType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

        Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtInvestment_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProvider As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProvider_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtVenue As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtVenue_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim dteDateFrom As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateFrom_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim dteDateTo As DevExpress.Web.ASPxEditors.ASPxDateEdit =
            TryCast(gridView.FindEditFormTemplateControl("dteDateTo_014"), DevExpress.Web.ASPxEditors.ASPxDateEdit)

        Dim txtTAFID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtTAFID_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtProgramDetailsID IsNot Nothing Then

            newValues("ProgramDetailsID") = txtProgramDetailsID.Text

        End If

        If txtProgramTitle IsNot Nothing Then

            newValues("ProgramTitle") = txtProgramTitle.Text

        End If

        If cmbType IsNot Nothing Then

            newValues("Type") = cmbType.Value

        End If

        If cmbProgramType IsNot Nothing Then

            newValues("ProgramType") = cmbProgramType.Value

        End If

        If txtProvider IsNot Nothing Then

            newValues("Provider") = txtProvider.Text

        End If

        If dteDateFrom IsNot Nothing Then

            newValues("DateFrom") = dteDateFrom.Text

        End If

        If dteDateTo IsNot Nothing Then

            newValues("DateTo") = dteDateTo.Text

        End If

        If txtVenue IsNot Nothing Then

            newValues("Venue") = txtVenue.Text

        End If

        If txtInvestment IsNot Nothing Then

            newValues("Investment") = txtInvestment.Text

        End If

        If txtTAFID IsNot Nothing Then

            newValues("TAFID") = txtTAFID.Text

        End If

    End Sub

    Private Sub dgView_014_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_014.CustomCallback

        Dim dtProgramType As DataTable = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim cmbType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(gridView.FindEditFormTemplateControl("cmbType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim cmbProgramType As DevExpress.Web.ASPxEditors.ASPxComboBox =
                TryCast(gridView.FindEditFormTemplateControl("cmbProgramType_014"), DevExpress.Web.ASPxEditors.ASPxComboBox)

            Dim txtInvestment As DevExpress.Web.ASPxEditors.ASPxTextBox =
                TryCast(gridView.FindEditFormTemplateControl("txtInvestment_014"), DevExpress.Web.ASPxEditors.ASPxTextBox)

            If (cmbType.Text = "Functional Training Program") Then

                Dim sqlSelect As String = "SELECT 'Business Trip (Local and Overseas)' [ProgramType] UNION ALL SELECT 'Public Seminar/External Training Program' [ProgramType] UNION ALL SELECT 'In-house Special Training Program' [ProgramType] ORDER BY [ProgramType] ASC"

                LoadExpDS(dsTAFProgType, sqlSelect)
                txtInvestment.ReadOnly = False

                If (sqlSelect.IndexOf(cmbProgramType.Text) < 0) Then

                    cmbProgramType.Text = String.Empty

                End If

            ElseIf (cmbType.Text = "Specialized Development Program") Then

                LoadExpDS(dsTAFProgType, "SELECT [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] ORDER BY [Program] ASC")
                txtInvestment.Text = "0.00"
                txtInvestment.ReadOnly = True

                dtProgramType = GetSQLDT("SELECT TOP 1 [Program] [ProgramType] FROM [SpecializedDevelopmentProgram] WHERE [Program] = '" & cmbProgramType.Text & "' ORDER BY [Program] ASC")

                If dtProgramType.Rows.Count = 0 Then

                    cmbProgramType.Text = String.Empty

                End If

            End If

            Dim investment As Double

            If (Double.TryParse(txtInvestment.Text, investment) AndAlso investment > 0) Then

                txtInvestment.Text = investment.ToString("#.00")

            Else

                txtInvestment.Text = "0.00"

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtProgramType IsNot Nothing Then

                dtProgramType.Clear()
                dtProgramType.Dispose()
                dtProgramType = Nothing

            End If

        End Try

    End Sub

#End Region

#Region "TAF History"

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim PathID As String = Container.Grid.GetRowValues(Container.VisibleIndex, "CompositeKey")

        Dim EncryptedURL As String = ""

        Dim ReportID As String = ""

        ReportID = "Training Agreement Form"

        EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=" & PathID & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function

    Private Sub dgView_015_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_015.CustomColumnDisplayText

        If (e.Column.FieldName = "XMLTag") Then

            Dim xmlTag As String = e.GetFieldValue("XMLTag").ToString()

            If (xmlTag.Length = 0) Then

                xmlTag =
                    "<WFType=" & sender.GetRowValues(e.VisibleRowIndex, "WFType") & ">" &
                    "<AppType=" & sender.GetRowValues(e.VisibleRowIndex, "Summary") & ">"

            End If

            Dim wfType As String = GetXML(xmlTag, KeyName:="WFType")

            Dim appType As String = GetXML(xmlTag, KeyName:="AppType")

            Dim summary As String = sender.GetRowValues(e.VisibleRowIndex, "Summary")

            e.DisplayText =
                wfType & ": " &
                appType & ": " &
                summary & ": " &
                GetXML(xmlTag, KeyName:="StartDate")

        End If

    End Sub

#End Region

#Region "TAFMaintenance"

    Protected Sub btnSave_007_Click(sender As Object, e As EventArgs) Handles btnSave_007.Click

        ShowPopup = False

        With UDetails

            'Insert here validation for future error message.

            If (Not ShowPopup) Then

                Dim bSaved As Boolean

                Dim capturedBy As String = String.Format("{0}, {1}", .Surname, .Name)

                Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

                Dim execute As StringBuilder = New StringBuilder()

                execute.AppendLine("INSERT INTO TrainingAgreementForm (")
                execute.AppendLine("[EmployeeNum],")
                execute.AppendLine("[CompanyNum],")
                execute.AppendLine("[Name],")
                execute.AppendLine("[ExternalPositionTitle],")
                execute.AppendLine("[MobileNum],")
                execute.AppendLine("[DatePrepared],")
                execute.AppendLine("[Status],")
                execute.AppendLine("[CapturedBy],")
                execute.AppendLine("[CapturedOn]")
                execute.AppendLine(")")
                execute.AppendLine("VALUES (")
                execute.AppendLine("'" & .EmployeeNum & "',")
                execute.AppendLine("'" & .CompanyNum & "',")
                execute.AppendLine("'" & txtName_007.Text & "',")
                execute.AppendLine("'" & txtExternalPos_007.Text.Replace("'", "''") & "',")
                execute.AppendLine("'" & txtMobile_007.Text & "',")
                execute.AppendLine("'" & DateTime.Now.ToString("MM/dd/yyyy") & "',")
                execute.AppendLine("'Draft',")
                execute.AppendLine("'" & capturedBy & "',")
                execute.AppendLine("'" & capturedOn & "')")

                bSaved = ExecSQL(execute.ToString())

                If (bSaved) Then

                    PopulateTAFTeamMemberProfile()

                Else

                    ResultText = "information An unknown error has occurred while saving your TAF, Please contact your system administrator."

                    GoTo ErrorMessage

                End If

            Else

ErrorMessage:
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

            End If

        End With

    End Sub

    Protected Sub dgView_012_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMin As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMin"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMax As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMax"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMonths As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMonths"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtYears As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYears"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim id As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ID")
            Dim min As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Min")
            Dim max As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Max")
            Dim Months As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Months")
            Dim Years As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Years")

            txtID.Text = id
            txtMin.Text = min.ToString()
            txtMax.Text = max.ToString()
            txtMonths.Text = Months.ToString()
            txtYears.Text = Years.ToString()

            txtID.Enabled = False
            'txtMin.Enabled = False
            'txtMax.Enabled = False
            'txtMonths.Enabled = False
            'txtYears.Enabled = False

        End If

    End Sub

    Protected Sub dgView_012_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgView_012_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim id As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim min As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMin"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim max As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMax"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim months As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMonths"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim years As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYears"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        GetGridValue_dgView_012(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub dgView_012_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_012(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim min As Object = e.NewValues("Min")
            Dim max As Object = e.NewValues("Max")
            Dim months As Object = e.NewValues("Months")
            Dim years As Object = e.NewValues("Years")
            Dim capturedBy As String = String.Format("{0}, {1}", UDetails.Surname, UDetails.Name)
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            ValidateFunctionalFieldsValue(min, max, months, years, Nothing)

            Dim serviceAgreement As String = ConstructServiceAgreement(months, years)

            sql = New StringBuilder()

            sql.AppendLine("INSERT INTO [FunctionalTrainingProgram] (")
            sql.AppendLine("CompanyNum,")
            sql.AppendLine("Min,")
            sql.AppendLine("Max,")
            sql.AppendLine("ServiceAgreement,")
            sql.AppendLine("Years,")
            sql.AppendLine("Months,")
            sql.AppendLine("CapturedBy,")
            sql.AppendLine("CapturedOn")
            sql.AppendLine(")")
            sql.AppendLine("VALUES (")
            sql.AppendLine("'" & companyNum & "',")
            sql.AppendLine("'" & min & "',")
            sql.AppendLine("'" & max & "',")
            sql.AppendLine("'" & serviceAgreement & "',")
            sql.AppendLine("'" & years & "',")
            sql.AppendLine("'" & months & "',")
            sql.AppendLine("'" & capturedBy & "',")
            sql.AppendLine("'" & capturedOn & "'")
            sql.AppendLine(")")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_012_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_012(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim id As Object = e.NewValues("ID")
            Dim min As Object = e.NewValues("Min")
            Dim max As Object = e.NewValues("Max")
            Dim months As Object = e.NewValues("Months")
            Dim years As Object = e.NewValues("Years")
            Dim capturedBy As String = String.Format("{0}, {1}", UDetails.Surname, UDetails.Name)
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            ValidateFunctionalFieldsValue(min, max, months, years, id)

            Dim serviceAgreement As String = ConstructServiceAgreement(months, years)

            sql = New StringBuilder()

            sql.AppendLine("UPDATE [FunctionalTrainingProgram] SET ")
            sql.AppendLine("    Min = " & min & ", ")
            sql.AppendLine("    Max = " & max & ", ")
            sql.AppendLine("    ServiceAgreement = '" & serviceAgreement & "', ")
            sql.AppendLine("    Months = " & months & ", ")
            sql.AppendLine("    Years = " & years & ", ")
            sql.AppendLine("    CapturedBy = '" & capturedBy & "', ")
            sql.AppendLine("    CapturedOn = '" & capturedOn & "' ")
            sql.AppendLine("WHERE CompanyNum = '" & companyNum & "' ")
            sql.AppendLine("  AND ID = '" & id.ToString() & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_012_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim companyNum As String = EDetails.CompanyNum
            Dim id As Object = e.Values("ID")

            sql = New StringBuilder()

            sql.AppendLine("DELETE FROM [FunctionalTrainingProgram] ")
            sql.AppendLine("WHERE CompanyNum = '" & companyNum & "' ")
            sql.AppendLine("  AND ID = '" & id & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Private Sub GetGridValue_dgView_012(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim txtID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMin As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMin"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMax As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMax"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtMonths As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtMonths"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtYears As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtYears"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtID IsNot Nothing Then

            newValues("ID") = txtID.Text

        End If

        If txtMin IsNot Nothing Then

            newValues("Min") = txtMin.Text

        End If

        If txtMax IsNot Nothing Then

            newValues("Max") = txtMax.Text

        End If

        If txtMonths IsNot Nothing Then

            newValues("Months") = txtMonths.Text

        End If

        If txtYears IsNot Nothing Then

            newValues("Years") = txtYears.Text

        End If

        newValues("ServiceAgreement") = "-"

    End Sub

    Protected Sub dgView_013_HtmlEditFormCreated(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewEditFormEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim txtID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgram As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgram_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtServiceAgreement As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtServiceAgreement_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If editingKeyValue IsNot Nothing AndAlso editingKeyValue <> "" Then

            Dim id As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ID")
            Dim program As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "Program")
            Dim serviceAgreement As Object = gridView.GetRowValuesByKeyValue(editingKeyValue, "ServiceAgreement")

            txtID.Text = id.ToString()
            txtProgram.Text = program.ToString()
            txtServiceAgreement.Text = serviceAgreement.ToString()

            txtID.Enabled = False
            'txtMin.Enabled = False
            'txtMax.Enabled = False
            'txtServiceAgreement.Enabled = False
            'txtMonths.Enabled = False
            'txtYears.Enabled = False

        End If

    End Sub

    Protected Sub dgView_013_StartRowEditing(sender As Object, e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        editingKeyValue = e.EditingKeyValue

    End Sub

    Protected Sub dgView_013_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
            DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

        Dim id As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim program As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgram_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim serviceAgreement As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtServiceAgreement_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        GetGridValue_dgView_013(gridView, e.NewValues)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub dgView_013_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_013(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim program As Object = e.NewValues("Program")
            Dim serviceAgreement As Object = e.NewValues("ServiceAgreement")
            Dim capturedBy As String = String.Format("{0}, {1}", UDetails.Surname, UDetails.Name)
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            ValidateSpecializedFieldsValue(program, serviceAgreement, Nothing)

            sql = New StringBuilder()

            sql.AppendLine("INSERT INTO [SpecializedDevelopmentProgram] (")
            sql.AppendLine("CompanyNum,")
            sql.AppendLine("Program,")
            sql.AppendLine("ServiceAgreement,")
            sql.AppendLine("CapturedBy,")
            sql.AppendLine("CapturedOn")
            sql.AppendLine(")")
            sql.AppendLine("VALUES (")
            sql.AppendLine("'" & companyNum & "',")
            sql.AppendLine("'" & program & "',")
            sql.AppendLine("'" & serviceAgreement & "',")
            sql.AppendLine("'" & capturedBy & "',")
            sql.AppendLine("'" & capturedOn & "'")
            sql.AppendLine(")")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_013_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            GetGridValue_dgView_013(gridView, e.NewValues)

            Dim companyNum As String = EDetails.CompanyNum
            Dim id As Object = e.NewValues("ID")
            Dim program As Object = e.NewValues("Program")
            Dim serviceAgreement As Object = e.NewValues("ServiceAgreement")
            Dim capturedBy As String = String.Format("{0}, {1}", UDetails.Surname, UDetails.Name)
            Dim capturedOn As String = DateTime.Now.ToString("MM/dd/yyyy HH:mm")

            ValidateSpecializedFieldsValue(program, serviceAgreement, id)

            sql = New StringBuilder()

            sql.AppendLine("UPDATE [SpecializedDevelopmentProgram] SET ")
            sql.AppendLine("    Program = '" & program & "', ")
            sql.AppendLine("    ServiceAgreement = '" & serviceAgreement & "', ")
            sql.AppendLine("    CapturedBy = '" & capturedBy & "', ")
            sql.AppendLine("    CapturedOn = '" & capturedOn & "' ")
            sql.AppendLine("WHERE CompanyNum = '" & companyNum & "' ")
            sql.AppendLine("  AND ID = '" & id.ToString() & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Protected Sub dgView_013_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim sql As StringBuilder = Nothing

        Try

            Dim gridView As DevExpress.Web.ASPxGridView.ASPxGridView =
                DirectCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)

            Dim companyNum As String = EDetails.CompanyNum
            Dim id As Object = e.Values("ID")

            sql = New StringBuilder()

            sql.AppendLine("DELETE FROM [SpecializedDevelopmentProgram] ")
            sql.AppendLine("WHERE CompanyNum = '" & companyNum & "' ")
            sql.AppendLine("  AND ID = '" & id & "' ")

            e.Cancel = ExecSQL(sql.ToString())

            gridView.CancelEdit()

            If (e.Cancel) Then

                CancelEdit = True

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

    Private Sub GetGridValue_dgView_013(ByVal gridView As DevExpress.Web.ASPxGridView.ASPxGridView, ByVal newValues As System.Collections.Specialized.OrderedDictionary)

        Dim txtID As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtID_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtProgram As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtProgram_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        Dim txtServiceAgreement As DevExpress.Web.ASPxEditors.ASPxTextBox =
            TryCast(gridView.FindEditFormTemplateControl("txtServiceAgreement_013"), DevExpress.Web.ASPxEditors.ASPxTextBox)

        If txtID IsNot Nothing Then

            newValues("ID") = txtID.Text

        End If

        If txtProgram IsNot Nothing Then

            newValues("Program") = txtProgram.Text

        End If

        If txtServiceAgreement IsNot Nothing Then

            newValues("ServiceAgreement") = txtServiceAgreement.Text

        End If

    End Sub

#End Region

#Region "Evaluation"

    Protected Sub cmbTrainType_011_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim dtCourses As DataTable = Nothing

        Try

            cmbCourse_011.Items.Clear()
            cmbProvider_011.Items.Clear()
            cmbSchedDate_011.Items.Clear()

            cmbCourse_011.Value = ""
            cmbProvider_011.Value = ""
            cmbSchedDate_011.Value = ""

            cmbCourse_011.Text = ""
            cmbProvider_011.Text = ""
            cmbSchedDate_011.Text = ""

            Dim trainType As Object = cmbTrainType_011.Value

            If trainType IsNot Nothing AndAlso trainType <> "" Then

                Dim companyNum As String = EDetails.CompanyNum
                Dim employeeNum As String = EDetails.EmployeeNum

                If trainType = "2" Then ' External

                    dtCourses = GetSQLDT(
                        "SELECT DISTINCT [CourseName] " +
                        "FROM ( " +
                        "SELECT " +
                        "    [CourseName] = TP.[CourseName] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "WHERE TP.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TP.[TrainingStatus] = 'Completed' " +
                        "  AND TP.[CourseName] IS NOT NULL " +
                        "  AND TP.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "UNION " +
                        "SELECT " +
                        "    [CourseName] = TC.[CourseName] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "WHERE TC.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TC.[TrainingStatus] = 'Completed' " +
                        "  AND TC.[CourseName] IS NOT NULL " +
                        "  AND TC.[CourseName] <> '' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        ") T " +
                        "ORDER BY [CourseName] ")

                Else

                    dtCourses = GetSQLDT(
                        "SELECT " +
                        "    DISTINCT " +
                        "    [CourseName] = TC.[CourseName] " +
                        "FROM TrainingCompleted TC " +
                        "INNER JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "WHERE TC.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & employeeNum & "' " +
                        IIf(trainType = "1", "  AND C.[InternalCourse] = 1 ", "") +
                        IIf(trainType = "2" OrElse trainType = "3", "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) ", "") +
                        IIf(trainType = "2", "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) ", "") +
                        IIf(trainType = "3", "  AND C.[Overseas] = 1 ", "") +
                        "ORDER BY [CourseName] ")

                End If

                If dtCourses.Rows.Count > 0 Then

                    cmbCourse_011.Items.Add("", "")

                    For Each drCourse As DataRow In dtCourses.Rows

                        If Not drCourse.IsNull("CourseName") Then

                            Dim courseName As String = drCourse("CourseName").ToString()

                            cmbCourse_011.Items.Add(courseName, courseName)

                        End If

                    Next

                End If

            Else

                cmbCourse_011.Items.Clear()
                cmbProvider_011.Items.Clear()
                cmbSchedDate_011.Items.Clear()

            End If

            updCourse_011.Update()
            updProvider_011.Update()
            updSchedDate_011.Update()

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtCourses IsNot Nothing Then

                dtCourses.Clear()
                dtCourses.Dispose()
                dtCourses = Nothing

            End If

        End Try

    End Sub

    Protected Sub cmbCourse_011_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim dtProviders As DataTable = Nothing

        Try

            cmbProvider_011.Items.Clear()
            cmbSchedDate_011.Items.Clear()

            cmbProvider_011.Value = ""
            cmbSchedDate_011.Value = ""

            cmbProvider_011.Text = ""
            cmbSchedDate_011.Text = ""

            Dim trainType As Object = cmbTrainType_011.Value
            Dim courseName As Object = cmbCourse_011.Value

            If trainType IsNot Nothing AndAlso trainType <> "" AndAlso
               courseName IsNot Nothing AndAlso courseName <> "" Then

                If trainType = "2" Then ' External

                    Dim companyNum As String = EDetails.CompanyNum
                    Dim employeeNum As String = EDetails.EmployeeNum

                    dtProviders = GetSQLDT(
                        "SELECT DISTINCT [ProviderName] " +
                        "FROM ( " +
                        "SELECT " +
                        "    [ProviderName] = TP.[ProviderName] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "WHERE TP.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TP.[CourseName] = '" & courseName & "' " +
                        "  AND TP.[TrainingStatus] = 'Completed' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "UNION " +
                        "SELECT " +
                        "    [ProviderName] = TC.[ProviderName] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "WHERE TC.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TC.[CourseName] = '" & courseName & "' " +
                        "  AND TC.[TrainingStatus] = 'Completed' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        ") T " +
                        "ORDER BY [ProviderName] ")

                Else

                    dtProviders = GetSQLDT(
                        "SELECT " +
                        "    DISTINCT " +
                        "    [ProviderName] " +
                        "FROM CourseLU " +
                        "WHERE [CourseName] = '" & courseName & "' " +
                        "ORDER BY [ProviderName] ")

                End If

                If dtProviders.Rows.Count > 0 Then

                    cmbProvider_011.Items.Add("", "")

                    For Each drProvider As DataRow In dtProviders.Rows

                        If Not drProvider.IsNull("ProviderName") Then

                            Dim providerName As String = drProvider("ProviderName").ToString()

                            cmbProvider_011.Items.Add(providerName, providerName)

                        End If

                    Next

                End If

            Else

                cmbProvider_011.Items.Clear()
                cmbSchedDate_011.Items.Clear()

            End If

            updProvider_011.Update()
            updSchedDate_011.Update()

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtProviders IsNot Nothing Then

                dtProviders.Clear()
                dtProviders.Dispose()
                dtProviders = Nothing

            End If

        End Try

    End Sub

    Protected Sub cmbProvider_011_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim dtSchedDates As DataTable = Nothing

        Try

            cmbSchedDate_011.Items.Clear()

            cmbSchedDate_011.Value = ""

            cmbSchedDate_011.Text = ""

            Dim trainType As Object = cmbTrainType_011.Value
            Dim courseName As Object = cmbCourse_011.Value
            Dim providerName As Object = cmbProvider_011.Value

            If trainType IsNot Nothing AndAlso trainType <> "" AndAlso
               courseName IsNot Nothing AndAlso courseName <> "" AndAlso
               providerName IsNot Nothing AndAlso providerName <> "" Then

                If trainType = "2" Then ' External

                    Dim companyNum As String = EDetails.CompanyNum
                    Dim employeeNum As String = EDetails.EmployeeNum

                    dtSchedDates = GetSQLDT(
                        "SELECT DISTINCT [DateFrom], [DateTo] " +
                        "FROM ( " +
                        "SELECT " +
                        "    [DateFrom] = TP.[StartDate], " +
                        "    [DateTo] = TP.[CompletionDate] " +
                        "FROM TrainingPlanned TP " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TP.[CourseName] " +
                        "WHERE TP.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TP.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TP.[CourseName] = '" & courseName & "' " +
                        "  AND TP.[ProviderName] = '" & providerName & "' " +
                        "  AND TP.[TrainingStatus] = 'Completed' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        "UNION " +
                        "SELECT " +
                        "    [DateFrom] = TC.[StartDate], " +
                        "    [DateTo] = TC.[CompletionDate] " +
                        "FROM TrainingCompleted TC " +
                        "LEFT JOIN CourseLU C " +
                        "    ON C.[CourseName] = TC.[CourseName] " +
                        "WHERE TC.[CompanyNum] = '" & companyNum & "' " +
                        "  AND TC.[EmployeeNum] = '" & employeeNum & "' " +
                        "  AND TC.[CourseName] = '" & courseName & "' " +
                        "  AND TC.[ProviderName] = '" & providerName & "' " +
                        "  AND TC.[TrainingStatus] = 'Completed' " +
                        "  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0) " +
                        "  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) " +
                        ") T " +
                        "ORDER BY [DateFrom], [DateTo] ")

                Else

                    dtSchedDates = GetSQLDT(
                        "SELECT " +
                        "    DISTINCT " +
                        "    [DateFrom], " +
                        "    [DateTo] " +
                        "FROM CourseDatesLU " +
                        "WHERE [CourseName] = '" & courseName & "' " +
                        "  AND [ProviderName] = '" & providerName & "' " +
                        "  AND CONVERT(VARCHAR(10), DATEADD(DAY, 1, GETDATE()), 111) > " +
                        "      CONVERT(VARCHAR(10), CAST([DateFrom] AS DATE), 111) " +
                        "ORDER BY [DateFrom], [DateTo] ")

                End If

                If dtSchedDates.Rows.Count > 0 Then

                    cmbSchedDate_011.Items.Add("", "")

                    For Each drSchedDate As DataRow In dtSchedDates.Rows

                        If Not drSchedDate.IsNull("DateFrom") AndAlso
                           Not drSchedDate.IsNull("DateTo") Then

                            Dim dateFrom As String = Convert.ToDateTime(drSchedDate("DateFrom").ToString()).ToString("MM/dd/yyyy")
                            Dim dateTo As String = Convert.ToDateTime(drSchedDate("DateTo").ToString()).ToString("MM/dd/yyyy")

                            Dim schedDate As String = dateFrom + " - " + dateTo

                            cmbSchedDate_011.Items.Add(schedDate, schedDate)

                        End If

                    Next

                End If

            Else

                cmbSchedDate_011.Items.Clear()

            End If

            updSchedDate_011.Update()

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtSchedDates IsNot Nothing Then

                dtSchedDates.Clear()
                dtSchedDates.Dispose()
                dtSchedDates = Nothing

            End If

        End Try

    End Sub

    Protected Sub cmdEvaluate_011_Click(sender As Object, e As EventArgs)

        Dim dtTrainEval As DataTable = Nothing
        Dim sql As StringBuilder = Nothing

        Try

            ShowPopup = False

            Dim companyNum As String = EDetails.CompanyNum
            Dim employeeNum As String = EDetails.EmployeeNum
            Dim trainingType As Object = cmbTrainType_011.Value
            Dim courseName As Object = cmbCourse_011.Value
            Dim providerName As Object = cmbProvider_011.Value
            Dim schedDate As Object = cmbSchedDate_011.Value

            If trainingType IsNot Nothing AndAlso trainingType <> "" AndAlso
               courseName IsNot Nothing AndAlso courseName <> "" AndAlso
               providerName IsNot Nothing AndAlso providerName <> "" AndAlso
               schedDate IsNot Nothing AndAlso schedDate <> "" Then

                Dim schedDateArr As String() = schedDate.ToString().Split(New Char() {"-"})

                Dim startDate As String = schedDateArr(0).Trim()
                Dim endDate As String = schedDateArr(1).Trim()

                dtTrainEval = GetSQLDT(
                    "SELECT " +
                    "   TOP 1 " +
                    "   TrainingType " +
                    "FROM TrainingEvaluation " +
                    "WHERE CompanyNum = '" + companyNum + "' " +
                    "  AND EmployeeNum = '" + employeeNum + "' " +
                    "  AND TrainingType = " + trainingType + " " +
                    "  AND CourseName = '" + courseName + "' " +
                    "  AND ProviderName = '" + providerName + "' " +
                    "  AND StartDate = '" + startDate + "' ")

                If Not ShowPopup AndAlso dtTrainEval.Rows.Count > 0 Then

                    ShowPopup = True

                    ResultText = "information You already have submitted an evaluation for the selected training course."

                End If

                If (Not ShowPopup) Then

                    sql = New StringBuilder()

                    sql.AppendLine("INSERT INTO [TrainingEvaluation] (")
                    sql.AppendLine("CompanyNum,")
                    sql.AppendLine("EmployeeNum,")
                    sql.AppendLine("TrainingType,")
                    sql.AppendLine("CourseName,")
                    sql.AppendLine("ProviderName,")
                    sql.AppendLine("StartDate,")
                    sql.AppendLine("EndDate")
                    sql.AppendLine(")")
                    sql.AppendLine("VALUES (")
                    sql.AppendLine("'" & companyNum & "',")
                    sql.AppendLine("'" & employeeNum & "',")
                    sql.AppendLine(trainingType & ",")
                    sql.AppendLine("'" & courseName & "',")
                    sql.AppendLine("'" & providerName & "',")
                    sql.AppendLine("'" & startDate & "',")
                    sql.AppendLine("'" & endDate & "'")
                    sql.AppendLine(")")

                    Dim bSaved As Boolean = ExecSQL(sql.ToString())

                    If bSaved Then

                        sql = New StringBuilder()

                        sql.AppendLine("exec [ess.WFProc]")
                        sql.AppendLine("'" & Session("LoggedOn").CompanyNum & "',")
                        sql.AppendLine("'" & Session("LoggedOn").EmployeeNum & "',")
                        sql.AppendLine("'" & companyNum & "',")
                        sql.AppendLine("'" & employeeNum & "',")
                        sql.AppendLine("0, 'Training', 'Evaluation', 'Start', 'Start',")
                        sql.AppendLine("'" & startDate & "'")

                        bSaved = ExecSQL(sql.ToString())

                    End If

                    If (bSaved) Then

                        Response.Redirect("tasks.aspx")

                    Else

                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""information Failed to submit the evaluation"")", True)

                    End If

                Else

                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMessageShow", "window.parent.ShowPopup(""" & ResultText & """)", True)

                End If

            End If

        Catch ex As Exception

            WriteEventLog(ex)

            Throw ex

        Finally

            If dtTrainEval IsNot Nothing Then

                dtTrainEval.Clear()
                dtTrainEval.Dispose()
                dtTrainEval = Nothing

            End If

            If sql IsNot Nothing Then

                sql.Clear()
                sql = Nothing

            End If

        End Try

    End Sub

#End Region

#End Region

    Protected Sub dgView_007_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

    End Sub

    Protected Sub dgView_010_CommandButtonInitialize(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewCommandButtonEventArgs)
        If (e.ButtonType = DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Update) Then
            e.Visible = False
        End If
    End Sub
End Class