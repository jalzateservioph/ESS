[CustomMessages]
iisserver_Caption=IIS Server
iisserver_Description=Where should Absalom Systems be installed?
iisserver_lblIISInstall_Caption0=Install to
iisserver_lblIISVirtual_Caption0=Virtual directory
iisserver_lblIISBackup_Caption0=Backup to
iisserver_chkIISBackup_Caption0=Create a backup of the files
iisserver_chkIISRestore_Caption0=Restore the files upon upgrade failure
iisserver_cmdIISBackup_Caption0=...
iisserver_cmdIISInstall_Caption0=...
iisserver_chkIISVirtual_Caption0=Create the virtual directory

[Code]
var
  lblIISInstall: TLabel;
  lblIISVirtual: TLabel;
  lblIISBackup: TLabel;
  txtIISInstall: TEdit;
  txtIISVirtual: TEdit;
  txtIISBackup: TEdit;
  cmdIISBackup: TButton;
  cmdIISInstall: TButton;
  chkIISVirtual: TCheckBox;
  chkIISBackup: TCheckBox;
  chkIISRestore: TCheckBox;

procedure iisserver_Path(Sender: TObject);
var
  selected: String;

begin

	if (BrowseForFolder('Where do you wish to install your files to?', selected, true)) then txtIISInstall.Text := selected;

end;

procedure iisserver_Browse(Sender: TObject);
var
  selected: String;

begin

	if (BrowseForFolder('Where do you wish to backup your files to?', selected, true)) then txtIISBackup.Text := selected;

end;

{ iisserver_Activate }

procedure iisserver_Activate(Page: TWizardPage);
begin
  // enter code here...
end;

{ iisserver_ShouldSkipPage }

function iisserver_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

{ iisserver_BackButtonClick }

function iisserver_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

{ iisserver_NextkButtonClick }

function iisserver_NextButtonClick(Page: TWizardPage): Boolean;
var
  Success: Boolean;
  chkValue: Cardinal;
begin

  Success := true;

  RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRoot', txtIISInstall.Text);
  RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISDirectory', txtIISVirtual.Text);
  RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISBackup', txtIISBackup.Text);

  chkValue := 0;

  if (chkIISVirtual.Checked) then chkValue := 1;

  RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreate', chkValue);

  chkValue := 0;

  if (chkIISBackup.Checked) then chkValue := 1;

  RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreateBackup', chkValue);

  chkValue := 0;

  if (chkIISRestore.Checked) then chkValue := 1;

  RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRestoreBackup', chkValue);

  Result := Success;

end;

{ iisserver_CancelButtonClick }

procedure iisserver_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
  // enter code here...
end;

{ iisserver_CreatePage }

function iisserver_CreatePage(IISviousPageId: Integer): Integer;
var
  Page: TWizardPage;
  chkValue: Cardinal;
  txtValue: String;

begin
  Page := CreateCustomPage(
    IISviousPageId,
    ExpandConstant('{cm:iisserver_Caption}'),
    ExpandConstant('{cm:iisserver_Description}')
  );

{ lblIISInstall }
  lblIISInstall := TLabel.Create(Page);
  with lblIISInstall do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_lblIISInstall_Caption0}');
    Left := ScaleX(53);
    Top := ScaleY(20);
    Width := ScaleX(44);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblIISVirtual }
  lblIISVirtual := TLabel.Create(Page);
  with lblIISVirtual do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_lblIISVirtual_Caption0}');
    Left := ScaleX(21);
    Top := ScaleY(52);
    Width := ScaleX(76);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblIISBackup }
  lblIISBackup := TLabel.Create(Page);
  with lblIISBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_lblIISBackup_Caption0}');
    Left := ScaleX(48);
    Top := ScaleY(84);
    Width := ScaleX(50);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { txtIISInstall }
  txtIISInstall := TEdit.Create(Page);
  with txtIISInstall do
  begin
    ReadOnly := true;
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(16);
    Width := ScaleX(265);
    Height := ScaleY(21);
    TabOrder := 0;

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRoot')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRoot', txtValue)) then Text := txtValue;

		end;

  end;

  { cmdIISInstall }
  cmdIISInstall := TButton.Create(Page);
  with cmdIISInstall do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_cmdIISInstall_Caption0}');
    Left := ScaleX(374);
    Top := ScaleY(14);
    Width := ScaleX(32);
    Height := ScaleY(25);
    TabOrder := 1;
    OnClick := @iisserver_Path;
  end;
  
  { txtIISVirtual }
  txtIISVirtual := TEdit.Create(Page);
  with txtIISVirtual do
  begin
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(48);
    Width := ScaleX(125);
    Height := ScaleY(21);
    TabOrder := 2;

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISDirectory')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISDirectory', txtValue)) then Text := txtValue;

		end;

  end;

  { txtIISBackup }
  txtIISBackup := TEdit.Create(Page);
  with txtIISBackup do
  begin
    ReadOnly := true;
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(80);
    Width := ScaleX(265);
    Height := ScaleY(21);
    TabOrder := 3;

    if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISBackup')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISBackup', txtValue)) then Text := txtValue;

		end;

  end;

  { cmdIISBackup }
  cmdIISBackup := TButton.Create(Page);
  with cmdIISBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_cmdIISBackup_Caption0}');
    Left := ScaleX(374);
    Top := ScaleY(78);
    Width := ScaleX(32);
    Height := ScaleY(25);
    TabOrder := 4;
    OnClick := @iisserver_Browse;
  end;

  chkValue := 1;

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreate')) then
  begin

    RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreate', chkValue);

  end;

  { chkIISVirtual }
  chkIISVirtual := TCheckBox.Create(Page);
  with chkIISVirtual do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_chkIISVirtual_Caption0}');
    Left := ScaleX(104);
    Top := ScaleY(112);
    Width := ScaleX(185);
    Height := ScaleY(17);

    if (chkValue = 0) then
    begin

      Checked := false;

    end
    else
    begin

      Checked := true;

    end;

    TabOrder := 5;
  end;

  chkValue := 1;

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreateBackup')) then
  begin

    RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISCreateBackup', chkValue);

  end;

  { chkIISBackup }
  chkIISBackup := TCheckBox.Create(Page);
  with chkIISBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_chkIISBackup_Caption0}');
    Left := ScaleX(104);
    Top := ScaleY(136);
    Width := ScaleX(185);
    Height := ScaleY(17);

    if (chkValue = 0) then
    begin

      Checked := false;

    end
    else
    begin

      Checked := true;

    end;

    TabOrder := 6;
  end;

  chkValue := 1;

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRestoreBackup')) then
  begin

    RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'IISRestoreBackup', chkValue);

  end;

  { chkIISRestore }
  chkIISRestore := TCheckBox.Create(Page);
  with chkIISRestore do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:iisserver_chkIISRestore_Caption0}');
    Left := ScaleX(104);
    Top := ScaleY(160);
    Width := ScaleX(233);
    Height := ScaleY(17);

    if (chkValue = 0) then
    begin

      Checked := false;

    end
    else
    begin

      Checked := true;

    end;

    TabOrder := 7;
  end;

  with Page do
  begin
    OnActivate := @iisserver_Activate;
    OnShouldSkipPage := @iisserver_ShouldSkipPage;
    OnBackButtonClick := @iisserver_BackButtonClick;
    OnNextButtonClick := @iisserver_NextButtonClick;
    OnCancelButtonClick := @iisserver_CancelButtonClick;
  end;

  Result := Page.ID;
end;
