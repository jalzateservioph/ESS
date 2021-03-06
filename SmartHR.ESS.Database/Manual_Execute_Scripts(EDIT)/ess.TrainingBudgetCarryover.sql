SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [msdb]
GO

IF NOT EXISTS (
	SELECT *
	FROM dbo.sysjobs
	WHERE name = 'TrainingBudgetCarryover'
)
BEGIN

	DECLARE @jobId BINARY(16)
	EXEC  msdb.dbo.sp_add_job @job_name=N'TrainingBudgetCarryover', 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=2, 
			@notify_level_netsend=2, 
			@notify_level_page=2, 
			@delete_level=0, 
			@description=N'Remaining budget carryover', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'sa', @job_id = @jobId OUTPUT
	select @jobId
	
	EXEC msdb.dbo.sp_add_jobserver @job_name=N'TrainingBudgetCarryover', @server_name = @@SERVERNAME
	
	EXEC msdb.dbo.sp_add_jobstep @job_name=N'TrainingBudgetCarryover', @step_name=N'exec [ess.TrainingBudgetCarryover]', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_fail_action=2, 
			@retry_attempts=2, 
			@retry_interval=1440, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'exec [ess.TrainingBudgetCarryover]', 
			--IMPORTANT CHANGE TO DBName
			@database_name=N'TMP-SHR-DEV', 
			--IMPORTANT
			@flags=0
	
	EXEC msdb.dbo.sp_update_job @job_name=N'TrainingBudgetCarryover', 
			@enabled=1, 
			@start_step_id=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=2, 
			@notify_level_netsend=2, 
			@notify_level_page=2, 
			@delete_level=0, 
			@description=N'Remaining budget carryover', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'sa', 
			@notify_email_operator_name=N'', 
			@notify_netsend_operator_name=N'', 
			@notify_page_operator_name=N''
	
	DECLARE @schedule_id int
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'TrainingBudgetCarryover', @name=N'Monthly 12am', 
			@enabled=1, 
			@freq_type=16, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20181217, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
	select @schedule_id

END