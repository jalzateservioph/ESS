function IISRoot(S: String): String;
var
	sDirUse: String;

begin

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\InetStp', 'PathWWWRoot')) then
  begin
  
    RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\InetStp', 'PathWWWRoot', vIISRoot);

  end;

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRoot')) then
  begin

    RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRoot', vIISRoot);

  end;

  StringChangeEx(vIISRoot, '%SystemDrive%', ExpandConstant('{sd}'), true);

	sDirUse := vIISRoot;

	if (Length(S) > 0) then sDirUse := sDirUse + '\' + S;

	Result := sDirUse;

end;

function IISDirectory(S: String): String;
var
	sDirUse: String;

begin

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISDirectory')) then
  begin

    RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISDirectory', vIISVirtual);

  end;

	sDirUse := IISRoot('') + '\' + vIISVirtual;

	if (Length(S) > 0) then sDirUse := sDirUse + '\' + S;

	Result := sDirUse;

end;

procedure CreateVirtualDirectory();
var
	IIS, WebSite, WebServer, WebRoot, VDir: Variant;

begin

	try

		IIS := CreateOleObject('IISNamespace');
		WebSite := IIS.GetObject('IIsWebService', 'localhost/w3svc');
		WebServer := WebSite.GetObject('IIsWebServer', '1');
		WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');

		try

			WebRoot.Delete('IISWebVirtualDir', vIISVirtual);
			WebRoot.SetInfo();

		except

		end;

		try

			if(Not IsUninstaller()) then
			begin

				VDir := WebRoot.Create('IISWebVirtualDir', vIISVirtual);
				VDir.AccessScript := true;
				VDir.AppIsolated := 2;
				VDir.AppFriendlyName := vIISVirtual;
				VDir.AccessRead := True;
				VDir.AccessWrite := True;
				VDir.EnableDefaultDoc := true;
				VDir.DefaultDoc := 'default.aspx';
				VDir.Path := IISDirectory('');
				VDir.AppCreate(true);
				VDir.SetInfo();

			end;

		except

		end;

	except

	end;

end;

procedure StartIISServices(pgIISServices: TOutputProgressWizardPage);
begin

	pgIISServices.SetText('Initializing...', '');
	pgIISServices.SetProgress(0, 0);
	pgIISServices.Show;

	try

		pgIISServices.SetText('Starting » IIS Admin Service', '');
		pgIISServices.SetProgress(0, 4);

		if (vState[0]) then StartService('IISADMIN');

		Sleep(1500);

		pgIISServices.SetText('Starting » FTP Publishing Service', '');
		pgIISServices.SetProgress(1, 4);

		if (vState[1]) then StartService('MSFtpsvc');

		Sleep(1500);

		pgIISServices.SetText('Starting » Simple Mail Transport Protocol Service', '');
		pgIISServices.SetProgress(2, 4);

		if (vState[2]) then StartService('SMTPSVC');

		Sleep(1500);

		pgIISServices.SetText('Starting » World Wide Web Publishing Service', '');
		pgIISServices.SetProgress(3, 4);

		if (vState[3]) then StartService('W3SVC');

		pgIISServices.SetProgress(4, 4);

		Sleep(1500);

		WizardForm.Repaint;

	finally
	
		pgIISServices.Hide;

	end;

end;

procedure StopIISServices(pgIISServices: TOutputProgressWizardPage);
begin

	pgIISServices.SetText('Initializing...', '');
	pgIISServices.SetProgress(0, 0);
	pgIISServices.Show;

	try

		pgIISServices.SetText('Stopping » World Wide Web Publishing Service', '');
		pgIISServices.SetProgress(0, 4);

		if (vState[3]) then StopService('W3SVC');

		Sleep(1500);

		pgIISServices.SetText('Stopping » FTP Publishing Service', '');
		pgIISServices.SetProgress(1, 4);

		if (vState[2]) then StopService('SMTPSVC');

		Sleep(1500);

		pgIISServices.SetText('Stopping » Simple Mail Transport Protocol Service', '');
		pgIISServices.SetProgress(2, 4);

		if (vState[1]) then StopService('MSFtpsvc');

		Sleep(1500);

		pgIISServices.SetText('Stopping » IIS Admin Service', '');
		pgIISServices.SetProgress(3, 4);

		if (vState[0]) then StopService('IISADMIN');

		pgIISServices.SetProgress(4, 4);

		Sleep(1500);

		WizardForm.Repaint;

	finally

		pgIISServices.Hide;

	end;

end;
