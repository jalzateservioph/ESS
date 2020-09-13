/**********************************************************************************************************

							*** v6.0.74 (Restore database backup) ***

***********************************************************************************************************/
use [master]
GO

declare @dbPath nvarchar(260)
declare @dbPathBack nvarchar(260)
declare @dbRecoveryModel nvarchar(128)

declare @nPos int

select top 1 @dbPath = [filename] from [dbo].[sysfiles]

set @dbPath = reverse(@dbPath)

set @nPos = charindex('\', @dbPath)

set @dbPathBack = substring(@dbPath, @nPos + 1, 260 - @nPos)

set @dbPathBack = ltrim(reverse(@dbPathBack))

declare @dbDAT nvarchar(260)
declare @dbLOG nvarchar(260)

if (not '<%scripts.backup%>' = '<SQL data folder>')
	set @dbPathBack = '<%scripts.backup%>'

set @dbDAT = @dbPathBack + '\ESSBackup - (' + convert(nvarchar(10), getdate(), 110) + ').dat'
set @dbLOG = @dbPathBack + '\ESSBackup - (' + convert(nvarchar(10), getdate(), 110) + ').log'

select @dbRecoveryModel = convert(nvarchar(128), databasepropertyex('<%scripts.database%>', 'Recovery'))

if exists(select [name] from [sysdevices] where ([name] = 'ESS_dat') and ([phyname] = @dbDAT))
	exec sp_dropdevice 'ESS_dat'

if exists(select [name] from [sysdevices] where ([name] = 'ESS_log') and ([phyname] = @dbLOG))
	exec sp_dropdevice 'ESS_log'

exec sp_addumpdevice 'disk', 'ESS_dat', @dbDAT
exec sp_addumpdevice 'disk', 'ESS_log', @dbLOG

declare @activespid bigint,
	@sql nvarchar(4000),
	@i tinyint

while (1 = 1)
begin

	select @activespid = spid from [master].[dbo].[sysprocesses] (NOLOCK) where (db_name(dbid) = '<%scripts.database%>'
 and [spid] > 50)

	if (@@ROWCOUNT = 0)
	begin

		break

	end
	else
	begin

		set @sql = 'kill ' + cast(@activespid as varchar(10))

		exec (@sql)

		waitfor delay '00:00:00.1'

	end

	set @i = @i + 1

	if (@i > 100)
	begin

		break

	end

end

if (@i > 100)
begin

	raiserror(60000, 10, 1, '<%scripts.database%>') with log

	goto ContinueRestore

end

ContinueRestore:

set @sql = N'restore filelistonly from disk=''' + @dbDAT + ''''

declare @version varchar

select @version = cast(serverproperty('productversion') as varchar)

if (@version = '8')
begin

	create table [#RestoreFileListOnly_8]
	(
		[LogicalName] [nvarchar] (128),
		[PhysicalName] [nvarchar] (260),
		[Type] char(1),
		[FileGroupName] [nvarchar] (128),
		[Size] [numeric] (20, 0),
		[MaxSize] [numeric] (20, 0)
	)

	insert into [#RestoreFileListOnly_8] exec(@sql)

	select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_8] where ([PhysicalName] like '%.mdf')

	if (@dbRecoveryModel <> 'SIMPLE')
	begin

		restore database [SmartHRNG] from [ESS_dat] with replace, move @dbPath to @dbPathBack
/*
		select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_8] where ([PhysicalName] like '%.ldf')

		restore log [SmartHRNG] from [ESS_log] with recovery, move @dbPath to @dbPathBack
*/
	end
	else
	begin

		restore database [SmartHRNG] from [ESS_dat] with recovery, move @dbPath to @dbPathBack

	end

	drop table [#RestoreFileListOnly_8]

end

if (@version = '9')
begin

	create table [#RestoreFileListOnly_9]
	(
		[LogicalName] [nvarchar] (128),
		[PhysicalName] [nvarchar] (260),
		[Type] char(1),
		[FileGroupName] [nvarchar] (128),
		[Size] [numeric] (20, 0),
		[MaxSize] [numeric] (20, 0),
		FileID [bigint],
		CreateLSN [numeric] (25, 0),
		DropLSN [numeric] (25, 0) null,
		UniqueID [uniqueidentifier],
		ReadOnlyLSN [numeric] (25, 0) null,
		ReadWriteLSN [numeric] (25, 0) null,
		BackupSizeInBytes [bigint],
		SourceBlockSize [int],
		FileGroupID [int],
		LogGroupGUID [uniqueidentifier] null,
		DifferentialBaseLSN [numeric] (25, 0) null,
		DifferentialBaseGUID [uniqueidentifier],
		IsReadOnly [bit],
		IsPresent [bit]
	)

	insert into [#RestoreFileListOnly_9] exec(@sql)

	select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_9] where ([PhysicalName] like '%.mdf')

	if (@dbRecoveryModel <> 'SIMPLE')
	begin

		restore database [SmartHRNG] from [ESS_dat] with replace, move @dbPath to @dbPathBack
/*
		select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_9] where ([PhysicalName] like '%.ldf')

		restore log [SmartHRNG] from [ESS_log] with recovery, move @dbPath to @dbPathBack
*/
	end
	else
	begin

		restore database [SmartHRNG] from [ESS_dat] with recovery, move @dbPath to @dbPathBack

	end

	drop table [#RestoreFileListOnly_9]

end

if (@version = '10')
begin

	create table [#RestoreFileListOnly_10]
	(
		[LogicalName] [nvarchar] (128),
		[PhysicalName] [nvarchar] (260),
		[Type] char(1),
		[FileGroupName] [nvarchar] (128),
		[Size] [numeric] (20, 0),
		[MaxSize] [numeric] (20, 0),
		FileID [bigint],
		CreateLSN [numeric] (25, 0),
		DropLSN [numeric] (25, 0) null,
		UniqueID [uniqueidentifier],
		ReadOnlyLSN [numeric] (25, 0) null,
		ReadWriteLSN [numeric] (25, 0) null,
		BackupSizeInBytes [bigint],
		SourceBlockSize [int],
		FileGroupID [int],
		LogGroupGUID [uniqueidentifier] null,
		DifferentialBaseLSN [numeric] (25, 0) null,
		DifferentialBaseGUID [uniqueidentifier],
		IsReadOnly [bit],
		IsPresent [bit],
		[TDEThumbprint] [varbinary] (32)
	)

	insert into [#RestoreFileListOnly_10] exec(@sql)

	select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_10] where ([PhysicalName] like '%.mdf')

	if (@dbRecoveryModel <> 'SIMPLE')
	begin

		restore database [SmartHRNG] from [ESS_dat] with replace, move @dbPath to @dbPathBack
/*
		select @dbPath = [LogicalName], @dbPathBack = [PhysicalName] from [#RestoreFileListOnly_10] where ([PhysicalName] like '%.ldf')

		restore log [SmartHRNG] from [ESS_log] with recovery, move @dbPath to @dbPathBack
*/
	end
	else
	begin

		restore database [SmartHRNG] from [ESS_dat] with recovery, move @dbPath to @dbPathBack

	end

	drop table [#RestoreFileListOnly_10]

end

if exists(select [name] from [sysdevices] where ([name] = 'ESS_dat') and ([phyname] = @dbDAT))
	exec sp_dropdevice 'ESS_dat'

if exists(select [name] from [sysdevices] where ([name] = 'ESS_log') and ([phyname] = @dbLOG))
	exec sp_dropdevice 'ESS_log'
GO