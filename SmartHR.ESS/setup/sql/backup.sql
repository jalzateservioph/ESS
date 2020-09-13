/**********************************************************************************************************

							*** v6.0.74 (Create database backup) ***

***********************************************************************************************************/
use [master]
GO

declare @dbPath nvarchar(260)
declare @dbPathBack nvarchar(260)
declare @dbRecoveryModel nvarchar(128)

declare @nPos int

select @dbPath = [filename] from [dbo].[sysfiles]

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

backup database [<%scripts.database%>] to [ESS_dat]

if (@dbRecoveryModel <> 'SIMPLE')
	backup log [<%scripts.database%>] to [ESS_log]

if exists(select [name] from [sysdevices] where ([name] = 'ESS_dat') and ([phyname] = @dbDAT))
	exec sp_dropdevice 'ESS_dat'

if exists(select [name] from [sysdevices] where ([name] = 'ESS_log') and ([phyname] = @dbLOG))
	exec sp_dropdevice 'ESS_log'
GO