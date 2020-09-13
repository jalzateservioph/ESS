; Ensure installer is uptodate with 3.x - gives issues at clients to install crystal .NET 2.0 Framework
[PreCompile]
Name: rmdir; Parameters: /S /Q root; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: .. root *.asax *.aspx *.htm *.config *.skin *.js *.css /S /COPY:DAT /XD ?; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: .. root *.ico *.txt /COPY:DAT /XD ?; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\bin root\bin *.dll /COPY:DAT /XF DevExpress.*.dll SmartHR.ESS.dll; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\documents root\documents *.* /E /COPY:DAT /XF *.*; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\dictionaries root\dictionaries *.* /COPY:DAT; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\images root\images *.* /E /COPY:DAT /XD ?; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\obj\release root\bin SmartHR.ESS.dll /COPY:DAT; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\reports root\reports *.repx *.rpt /E /COPY:DAT /XD ?; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\settings root\settings *.* /E /COPY:DAT /XD ?; Flags: runminimized cmdprompt redirectoutput
Name: robocopy; Parameters: ..\uploads root\uploads *.* /E /COPY:DAT /XF *.*; Flags: runminimized cmdprompt redirectoutput

[Setup]
InternalCompressLevel=ultra
OutputDir=.
VersionInfoVersion=6.0.74
VersionInfoCompany=Absalom Systems
VersionInfoDescription=Absalom Systems
VersionInfoTextVersion=Absalom Systems v6.0.74
VersionInfoCopyright=© Absalom Systems
Compression=lzma/ultra
AppCopyright=© Absalom Systems
AppName=Absalom Systems
AppVerName=Absalom Systems v6.0.74
PrivilegesRequired=admin
ExtraDiskSpaceRequired=50000000
MinVersion=0,5.0.2195
ChangesAssociations=true
ChangesEnvironment=true
CreateAppDir=false
AlwaysShowDirOnReadyPage=false
AlwaysShowGroupOnReadyPage=false
ShowTasksTreeLines=true
SetupIconFile=skins\setup.ico
AppID={{907d43c2-a12d-4087-a256-8691f6c9ab59}
AppPublisher=Absalom Systems Pty Ltd
AppPublisherURL=http://www.absalomsystems.com
AppSupportURL=http://www.absalomsystems.com
AppUpdatesURL=http://www.absalomsystems.com
AppVersion=Absalom Systems v6.0.74
UninstallDisplayName=Absalom Systems
WizardImageFile=skins\Office2007.bmp
WizardSmallImageFile=skins\header.bmp
UserInfoPage=false
DisableProgramGroupPage=true

[Code]
const
  GetFileExInfoStandard = $0;
type
  FILETIME = record
    LowDateTime:  DWORD;
    HighDateTime: DWORD;
  end;

  WIN32_FILE_ATTRIBUTE_DATA = record
    FileAttributes: DWORD;
    CreationTime:   FILETIME;
    LastAccessTime: FILETIME;
    LastWriteTime:  FILETIME;
    FileSizeHigh:   DWORD;
    FileSizeLow:    DWORD;
  end;

  SYSTEMTIME = record
    Year:         WORD;
    Month:        WORD;
    DayOfWeek:    WORD;
    Day:          WORD;
    Hour:         WORD;
    Minute:       WORD;
    Second:       WORD;
    Milliseconds: WORD;
  end;

var
	vState: Array of Boolean;
	vIISRoot: String;
	vIISVirtual: String;
	pgUpdate: TOutputProgressWizardPage;
	pgIISServices: TOutputProgressWizardPage;

// Importing { Functions }
#include "include\ntservices.iss"
#include "include\iis.iss"
#include "include\sql.iss"

// Importing { Forms }
#include "forms\iisserver.iss"
#include "forms\prereq.iss"
#include "forms\sqlserver.iss"
#include "forms\sqlscripts.iss"

// Download Support
#include ReadReg(HKEY_LOCAL_MACHINE,'Software\Sherlock Software\InnoTools\Downloader','ScriptPath','');

// Importing LoadSkin API from ISSkin.DLL
procedure LoadSkin(lpszPath: String; lpszIniFileName: String);
external 'LoadSkin@files:ISSkin.dll stdcall';

// Importing UnloadSkin API from ISSkin.DLL
procedure UnloadSkin();
external 'UnloadSkin@files:ISSkin.dll stdcall';

// Importing ShowWindow Windows API from User32.DLL
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';

// Importing GetFileAttributesEx Windows API from kernel32.DLL
function GetFileAttributesEx(FileName: String; InfoLevelId: DWORD; var FileInformation: WIN32_FILE_ATTRIBUTE_DATA): Boolean;
external 'GetFileAttributesExA@kernel32.dll stdcall';

// Importing FileTimeToSystemTime Windows API from kernel32.DLL
function FileTimeToSystemTime(FileTime: FILETIME; var SystemTime: SYSTEMTIME): Boolean;
external 'FileTimeToSystemTime@kernel32.dll stdcall';

function InitializeSetup(): Boolean;
begin

  try

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPFromAddress')) then RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPFromAddress');

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPFromName')) then RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPFromName');

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPPort')) then RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPPort');

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPServer')) then RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPServer');

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPUsername')) then RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SMTPUsername');

    ExtractTemporaryFile('Office2007.cjstyles');

    LoadSkin(ExpandConstant('{tmp}\Office2007.cjstyles'), '');

  except

  end;

  Result := True;

end;

procedure InitializeWizard();
var
	pgID: Integer;

begin

	if (Not IsUninstaller()) then
	begin

    itd_init;

		vState := [false, false, false, false];

		vState[0] := ServiceRunning('IISADMIN');
		vState[1] := ServiceRunning('MSFtpsvc');
		vState[2] := ServiceRunning('SMTPSVC');
		vState[3] := ServiceRunning('W3SVC');

    pgUpdate := CreateOutputProgressPage(itd_getstring(itds_update_caption), itd_getstring(itds_update_description));

    itd_downloadafter(wpWelcome);

    pgID := prereq_CreatePage(wpWelcome + 1);
    
    pgID := sqlserver_CreatePage(pgID);

    pgID := iisserver_CreatePage(pgID);

    pgID := sqlscripts_CreatePage(pgID);

	end;

end;

procedure DeinitializeSetup();
begin

  try

    ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);

    UnloadSkin();

  except

  end;

end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  dlFile: Boolean;
  i, x, dc, fc, ds, fs, xIndex, xCount: Integer;
  xPath, xFile, dsFile, iniPath, iniOrig, fsDateTime, fsOrigDateTime, fsModDateTime: String;
  FileInformation: WIN32_FILE_ATTRIBUTE_DATA;
  SysInfo: SYSTEMTIME;
begin

  result := true;
  
  //CurPageID = wpWelcome
  
  if (result = false) then
  begin

    pgUpdate.Show;

    pgUpdate.SetText(itd_getstring(itds_update_checking), '');

    itd_setoption('UI_AllowContinue', '1');

    itd_setoption('UI_DetailedMode', '1');

    iniOrig := ExpandConstant('{src}\index.ini');

    iniPath := ExpandConstant('{src}\dl_index.ini');

    if (itd_downloadfile('http://downloads.absalomsystems.com/updates/SmartESS/index.ini', ExpandConstant('{src}\dl_index.ini')) = itderr_success) then
    begin

      xIndex := 1;

      xCount := GetIniInt('version', 'count', 0, 0, 0, iniPath);

      xCount := xCount + 1;
    
      pgUpdate.SetProgress(xIndex, xCount);

      dc := GetIniInt('delete', 'count', -1, 0, 0, iniPath);

      for i := 0 to (dc - 1) do
      begin

        if (FileExists(ExpandConstant('{src}\' + GetIniString('delete', 'file' + IntToStr(i), '', iniPath)))) then DeleteFile(ExpandConstant('{src}\' + GetIniString('delete', 'file' + IntToStr(i), '', iniPath)));

      end;

      dc := GetIniInt('dirs', 'count', -1, 0, 0, iniPath);

      for i := 0 to (dc - 1) do
      begin
      
        fc := GetIniInt('dir' + IntToStr(i), 'count', -1, 0, 0, iniPath);

        xPath := GetIniString('dirs', 'dir' + IntToStr(i), '', iniPath);

        for x := 0 to (fc - 1) do
        begin

          xFile := GetIniString('dir' + IntToStr(i), 'path' + IntToStr(x), '', iniPath);

          if (Length(xFile) > 0) then
          begin

            dsFile := xPath + '\' + xFile;

            StringChangeEx(dsFile, '\', '/', True);

            FileSize(ExpandConstant('{src}\' + xPath + '\' + xFile), fs);
            
            ds := GetIniInt('dir' + IntToStr(i), 'size' + IntToStr(x), 0, 0, 0, iniPath);

            dlFile := false;

            fsOrigDateTime := GetIniString('dir' + IntToStr(i), 'date' + IntToStr(x), '', iniPath);

            fsModDateTime := GetIniString('dir' + IntToStr(i), 'date' + IntToStr(x), fsOrigDateTime, iniOrig);

            SetIniString('dir' + IntToStr(i), 'date' + IntToStr(x), fsOrigDateTime, iniOrig);

            if (fs = ds) then
            begin
            
              GetFileAttributesEx(ExpandConstant('{src}\' + xPath + '\' + xFile), GetFileExInfoStandard, FileInformation);

              FileTimeToSystemTime(FileInformation.LastWriteTime, SysInfo);

              fsDateTime := Format('%4.4d%2.2d%2.2d%2.2d', [SysInfo.Year, SysInfo.Month, SysInfo.Day, SysInfo.Hour]);

              if ((fsDateTime <> fsOrigDateTime) and (Length(fsOrigDateTime) > 0)) then dlFile := true;

              if (fsOrigDateTime = fsModDateTime) then dlFile := false;

            end
            else
            begin
            
              dlFile := true;

            end;

            if (dlFile) then
            begin

              itd_addfile('http://downloads.absalomsystems.com/updates/SmartESS/' + dsFile, ExpandConstant('{src}\' + xPath + '\' + xFile));

            end;

          end;

          xIndex := xIndex + 1;

          pgUpdate.SetProgress(xIndex, xCount);

        end;
      
      end;

    end;

    pgUpdate.Hide;

  end;

end;

procedure CurStepChanged(CurStep: TSetupStep);
var
	ResultCode: Integer;

begin

		if (Not IsUninstaller()) then
		begin

			case CurStep of

				ssInstall:
					begin

						pgIISServices := CreateOutputProgressPage('Internet Information Services', 'Stopping internet information services...');

						StopIISServices(pgIISServices);

					end;

				ssPostInstall:
					begin

						WizardForm.Repaint;

						pgIISServices := CreateOutputProgressPage('Internet Information Services', 'Starting internet information services...');

						StartIISServices(pgIISServices);

						if (chkIISVirtual.Checked) then CreateVirtualDirectory();

            if (not RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'InstallationDate')) then RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'InstallationDate', GetDateTimeString('dd/MM/yyyy HH:nn:ss', '-', ':'));

			  		RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'UpdateDate', GetDateTimeString('dd/MM/yyyy HH:nn:ss', '-', ':'));

						if RegKeyExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems Pty. Ltd.\ESS') then RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems Pty. Ltd.\ESS');

			      Exec(ExpandConstant('{win}\Microsoft.NET\Framework\v2.0.50727\aspnet_regiis.exe'), '-s W3SVC/1/ROOT/' + vIISVirtual, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

            Exec(ExpandConstant('{src}\update\upgrade.exe'), 'upgrade -server' + #34 + txtSQLServer.Text + #34 + ' -database' + #34 + txtSQLDatabase.Text + #34 + ' -username' + #34 + txtSQLUsername.Text + #34 + ' -password' + #34 + txtSQLPassword.Text + #34 + ' -path' + #34 + IISDirectory('') + #34, '', SW_SHOW, ewWaitUntilTerminated, ResultCode);

					end;

			end;

		end;

end;

[Dirs]
Name: {code:IISDirectory}
Name: {code:IISDirectory|documents}
Name: {code:IISDirectory|documents\claims}
Name: {code:IISDirectory|documents\linked}
Name: {code:IISDirectory|documents\mapped}
Name: {code:IISDirectory|documents\news}
Name: {code:IISDirectory|linkdocs}; Flags: deleteafterinstall
Name: {code:IISDirectory|uploads}

[Files]
Source: {src}\devexpress\*.*; DestDir: {code:IISDirectory|bin}; Attribs: readonly hidden system; Flags: external overwritereadonly ignoreversion uninsremovereadonly skipifsourcedoesntexist recursesubdirs createallsubdirs
Source: skins\ISSkin.dll; DestDir: {app}; Flags: dontcopy
Source: skins\Office2007.cjstyles; DestDir: {tmp}; Flags: dontcopy
Source: {src}\root\*.*; DestDir: {code:IISDirectory}; Flags: external overwritereadonly ignoreversion uninsremovereadonly skipifsourcedoesntexist recursesubdirs createallsubdirs
Source: {code:IISDirectory|linkdocs\*.*}; DestDir: {code:IISDirectory|documents\linked}; Flags: external overwritereadonly ignoreversion uninsremovereadonly skipifsourcedoesntexist recursesubdirs createallsubdirs

[InstallDelete]
Name: {code:IISDirectory|\*.*}; Type: files
Name: {code:IISDirectory|App_Themes\Glass}; Type: filesandordirs
Name: {code:IISDirectory|App_Themes\Aqua}; Type: filesandordirs
Name: {code:IISDirectory|bin}; Type: filesandordirs
Name: {code:IISDirectory|DevExpress}; Type: filesandordirs
Name: {code:IISDirectory|dictionaries}; Type: filesandordirs
Name: {code:IISDirectory|PopCalendar2005AjaxNet}; Type: filesandordirs
Name: {code:IISDirectory|images}; Type: filesandordirs
Name: {code:IISDirectory|randimages}; Type: filesandordirs
Name: {code:IISDirectory|reports}; Type: filesandordirs
Name: {code:IISDirectory|requests}; Type: filesandordirs
Name: {code:IISDirectory|settings}; Type: filesandordirs
Name: {code:IISDirectory|styles}; Type: filesandordirs
Name: {code:IISDirectory|uploaded}; Type: filesandordirs
Name: {code:IISRoot|webctrl_client\ProgStudios}; Type: filesandordirs
