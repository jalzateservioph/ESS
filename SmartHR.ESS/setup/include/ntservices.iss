const
	SC_MANAGER_ALL_ACCESS = $f003f;
	SERVICE_CONTROL_STOP = $1;
	SERVICE_QUERY_CONFIG = $1;
	SERVICE_QUERY_STATUS = $4;
	SERVICE_RUNNING = $4;
	SERVICE_START = $10;
	SERVICE_START_PENDING = $2;
	SERVICE_STOP = $20;
	SERVICE_STOP_PENDING = $3;
	SERVICE_STOPPED = $1;

type
	SERVICE_STATUS = record
		dwServiceType: longint;
		dwCurrentState: longint;
		dwControlsAccepted: longint;
		dwWin32ExitCode: longint;
		dwServiceSpecificExitCode: longint;
		dwCheckPoint: longint;
		dwWaitHint: longint;
	end;

function OpenSCManager(lpMachineName, lpDatabaseName: string; dwDesiredAccess: longint): longint;
	external 'OpenSCManagerA@advapi32.dll stdcall';

function OpenService(hSCManager: longint; lpServiceName: string; dwDesiredAccess: longint): longint;
	external 'OpenServiceA@advapi32.dll stdcall';

function CloseServiceHandle(hSCObject: longint): longint;
	external 'CloseServiceHandle@advapi32.dll stdcall';

function QueryServiceStatus(hService: longint; var lpServiceStatus: SERVICE_STATUS): longint;
	external 'QueryServiceStatus@advapi32.dll stdcall';

function StartNTService(hService, dwNumServiceArgs, lpServiceArgVectors: longint): longint;
	external 'StartServiceA@advapi32.dll stdcall';

function ControlService(hService, dwControl: longint; var lpServiceStatus: SERVICE_STATUS): longint;
	external 'ControlService@advapi32.dll stdcall';

function ServiceInstalled(ServiceName: string): boolean;
var
	hSCM: longint;
	hService: longint;

begin

	hSCM := OpenSCManager('', '', SC_MANAGER_ALL_ACCESS);

	if (hSCM <> 0) then
	begin

		hService := OpenService(hSCM, ServiceName, SERVICE_QUERY_CONFIG);

		if (hService <> 0) then
		begin

			Result := true;

			CloseServiceHandle(hService);

		end;

		CloseServiceHandle(hSCM);

	end;

end;

function ServiceRunning(ServiceName: string): boolean;
var
	hSCM: longint;
	hService: longint;
	lpStatus: SERVICE_STATUS;

begin

	if (ServiceInstalled(ServiceName)) then
	begin

		hSCM := OpenSCManager('', '', SC_MANAGER_ALL_ACCESS);

		if (hSCM <> 0) then
		begin

			hService := OpenService(hSCM, ServiceName, SERVICE_QUERY_STATUS);

			if (hService <> 0) then
			begin

				if (QueryServiceStatus(hService, lpStatus) <> 0) then Result := (lpStatus.dwCurrentState = SERVICE_RUNNING);

				CloseServiceHandle(hService);

			end;

			CloseServiceHandle(hSCM);

		end;

	end;

end;

function StartService(ServiceName: string): boolean;
var
	hSCM: longint;
	hService: longint;
	lpStatus: SERVICE_STATUS;
	dwWaitHint: longint;

begin

	if (not ServiceRunning(ServiceName)) then
	begin

		hSCM := OpenSCManager('', '', SC_MANAGER_ALL_ACCESS);

		if (hSCM <> 0) then
		begin

			hService := OpenService(hSCM, ServiceName, SERVICE_START);

			if (hService <> 0) then
			begin

				if (StartNTService(hService, 0, 0) <> 0) then
				begin

					if (QueryServiceStatus(hService, lpStatus) <> 0) then
					begin

						while (lpStatus.dwCurrentState = SERVICE_START_PENDING) do
						begin

							dwWaitHint := lpStatus.dwWaitHint;

							if (dwWaitHint = 0) then dwWaitHint := 500;

							Sleep(dwWaitHint);

							if (QueryServiceStatus(hService, lpStatus) = 0) then break;

						end;

						Result := (lpStatus.dwCurrentState = SERVICE_RUNNING);

					end;

				end;

				CloseServiceHandle(hService);

			end;

			CloseServiceHandle(hSCM);

		end;

	end;

end;

function StopService(ServiceName: string): boolean;
var
	hSCM: longint;
	hService: longint;
	lpStatus: SERVICE_STATUS;
	dwWaitHint: longint;

begin

	if (ServiceRunning(ServiceName)) then
	begin

		hSCM := OpenSCManager('', '', SC_MANAGER_ALL_ACCESS);

		if (hSCM <> 0) then
		begin

			hService := OpenService(hSCM, ServiceName, SERVICE_STOP);

			if (hService <> 0) then
			begin

				if (ControlService(hService, SERVICE_CONTROL_STOP, lpStatus) <> 0) then
				begin

					CloseServiceHandle(hService);

					hService := OpenService(hSCM, ServiceName, SERVICE_QUERY_STATUS);

					if (hService <> 0) then
					begin

						if (QueryServiceStatus(hService, lpStatus) <> 0) then
						begin

							dwWaitHint := lpStatus.dwWaitHint;

							if (dwWaitHint = 0) then dwWaitHint := 500;

							Sleep(lpStatus.dwWaitHint);

							if (QueryServiceStatus(hService, lpStatus) <> 0) then
							begin

								while (lpStatus.dwCurrentState = SERVICE_STOP_PENDING) do
								begin

									dwWaitHint := lpStatus.dwWaitHint;

									if (dwWaitHint = 0) then dwWaitHint := 500;

									Sleep(dwWaitHint);

									if (QueryServiceStatus(hService, lpStatus) = 0) then break;

								end;

								Result := (lpStatus.dwCurrentState = SERVICE_STOPPED);

							end;

						end;

					end;

				end
				else
				begin

					CloseServiceHandle(hService);

				end;

			end;

			CloseServiceHandle(hSCM);

		end;

	end;

end;
