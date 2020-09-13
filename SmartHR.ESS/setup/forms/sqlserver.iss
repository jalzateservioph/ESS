[CustomMessages]
sqlserver_Caption=SQL Server
sqlserver_Description=Where is the SQL Server located?
sqlserver_lblsqlserver_Caption0=Server name
sqlserver_lblSQLDatabase_Caption0=Database name
sqlserver_lblUsername_Caption0=Username
sqlserver_lblSQLPassword_Caption0=Password
sqlserver_lblSQLBackup_Caption0=Backup to
sqlserver_chkSQLBackup_Caption0=Create a backup of the database
sqlserver_chkSQLRestore_Caption0=Restore the database upon upgrade failure
sqlserver_cmdSQLBackup_Caption0=...

[Code]
var
  lblSQLServer: TLabel;
  lblSQLDatabase: TLabel;
  lblUsername: TLabel;
  lblSQLPassword: TLabel;
  lblSQLBackup: TLabel;
  txtSQLServer: TEdit;
  txtSQLDatabase: TEdit;
  txtSQLUsername: TEdit;
  txtSQLPassword: TEdit;
  txtSQLBackup: TEdit;
  cmdSQLBackup: TButton;
  chkSQLBackup: TCheckBox;
  chkSQLRestore: TCheckBox;

procedure sqlserver_Browse(Sender: TObject);
var
  selected: String;

begin

	if (BrowseForFolder('Where do you wish to backup your database to?', selected, true)) then txtSQLBackup.Text := selected;

end;

{ sqlserver_Activate }

procedure sqlserver_Activate(Page: TWizardPage);
begin
  // enter code here...
end;

{ sqlserver_ShouldSkipPage }

function sqlserver_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

{ sqlserver_BackButtonClick }

function sqlserver_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

{ sqlserver_NextkButtonClick }

function sqlserver_NextButtonClick(Page: TWizardPage): Boolean;
var
  Success: Boolean;
  chkValue: Cardinal;
begin

  Success := Connected(txtSQLServer.Text, txtSQLDatabase.Text, txtSQLUsername.Text, txtSQLPassword.Text);

  if (Success) then
  begin

    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLServername', txtSQLServer.Text);
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLDatabase', txtSQLDatabase.Text);
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLUsername', txtSQLUsername.Text);
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLBackup', txtSQLBackup.Text);

    chkValue := 0;

    if (chkSQLBackup.Checked) then chkValue := 1;

    RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLCreateBackup', chkValue);

    chkValue := 0;

    if (chkSQLRestore.Checked) then chkValue := 1;

    RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLRestoreBackup', chkValue);

  end;

  Result := Success;

end;

{ sqlserver_CancelButtonClick }

procedure sqlserver_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
  // enter code here...
end;

{ sqlserver_CreatePage }

function sqlserver_CreatePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
  chkValue: Cardinal;
  txtValue: String;

begin
  Page := CreateCustomPage(
    PreviousPageId,
    ExpandConstant('{cm:sqlserver_Caption}'),
    ExpandConstant('{cm:sqlserver_Description}')
  );

{ lblSQLServer }
  lblSQLServer := TLabel.Create(Page);
  with lblSQLServer do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_lblSQLServer_Caption0}');
    Left := ScaleX(32);
    Top := ScaleY(20);
    Width := ScaleX(65);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblSQLDatabase }
  lblSQLDatabase := TLabel.Create(Page);
  with lblSQLDatabase do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_lblSQLDatabase_Caption0}');
    Left := ScaleX(18);
    Top := ScaleY(52);
    Width := ScaleX(79);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblUsername }
  lblUsername := TLabel.Create(Page);
  with lblUsername do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_lblUsername_Caption0}');
    Left := ScaleX(46);
    Top := ScaleY(84);
    Width := ScaleX(52);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblSQLPassword }
  lblSQLPassword := TLabel.Create(Page);
  with lblSQLPassword do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_lblSQLPassword_Caption0}');
    Left := ScaleX(48);
    Top := ScaleY(116);
    Width := ScaleX(50);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { lblSQLBackup }
  lblSQLBackup := TLabel.Create(Page);
  with lblSQLBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_lblSQLBackup_Caption0}');
    Left := ScaleX(47);
    Top := ScaleY(148);
    Width := ScaleX(51);
    Height := ScaleY(13);
    Alignment := taRightJustify;
  end;

  { txtSQLServer }
  txtSQLServer := TEdit.Create(Page);
  with txtSQLServer do
  begin
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(16);
    Width := ScaleX(185);
    Height := ScaleY(21);
    TabOrder := 0;

		if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLServername')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLServername', txtValue)) then Text := txtValue;

		end;

  end;

  { txtSQLDatabase }
  txtSQLDatabase := TEdit.Create(Page);
  with txtSQLDatabase do
  begin
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(48);
    Width := ScaleX(125);
    Height := ScaleY(21);
    TabOrder := 1;

		if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLDatabase')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLDatabase', txtValue)) then Text := txtValue;

		end;

  end;

  { txtSQLUsername }
  txtSQLUsername := TEdit.Create(Page);
  with txtSQLUsername do
  begin
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(80);
    Width := ScaleX(125);
    Height := ScaleY(21);
    TabOrder := 2;

		if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLUsername')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLUsername', txtValue)) then Text := txtValue;

		end;

  end;

  { txtSQLPassword }
  txtSQLPassword := TEdit.Create(Page);
  with txtSQLPassword do
  begin
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(112);
    Width := ScaleX(125);
    Height := ScaleY(21);
    PasswordChar := '*';
    TabOrder := 3;
  end;

  { txtSQLBackup }
  txtSQLBackup := TEdit.Create(Page);
  with txtSQLBackup do
  begin
    ReadOnly := true;
    Parent := Page.Surface;
    Left := ScaleX(104);
    Top := ScaleY(144);
    Width := ScaleX(265);
    Height := ScaleY(21);
    TabOrder := 4;

		if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLBackup')) then
		begin

			if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLBackup', txtValue)) then Text := txtValue;

		end;

  end;

  { cmdSQLBackup }
  cmdSQLBackup := TButton.Create(Page);
  with cmdSQLBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_cmdSQLBackup_Caption0}');
    Left := ScaleX(374);
    Top := ScaleY(142);
    Width := ScaleX(32);
    Height := ScaleY(25);
    TabOrder := 5;
    OnClick := @sqlserver_Browse;
  end;

  chkValue := 1;

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLCreateBackup')) then
  begin

    RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLCreateBackup', chkValue);

  end;

  { chkSQLBackup }
  chkSQLBackup := TCheckBox.Create(Page);
  with chkSQLBackup do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_chkSQLBackup_Caption0}');
    Left := ScaleX(104);
    Top := ScaleY(176);
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

  if (RegValueExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLRestoreBackup')) then
  begin

    RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Absalom Systems\ESS', 'SQLRestoreBackup', chkValue);

  end;

  { chkSQLRestore }
  chkSQLRestore := TCheckBox.Create(Page);
  with chkSQLRestore do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:sqlserver_chkSQLRestore_Caption0}');
    Left := ScaleX(104);
    Top := ScaleY(200);
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
    OnActivate := @sqlserver_Activate;
    OnShouldSkipPage := @sqlserver_ShouldSkipPage;
    OnBackButtonClick := @sqlserver_BackButtonClick;
    OnNextButtonClick := @sqlserver_NextButtonClick;
    OnCancelButtonClick := @sqlserver_CancelButtonClick;
  end;

  Result := Page.ID;
end;
