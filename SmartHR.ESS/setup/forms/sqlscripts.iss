[CustomMessages]
sqlscripts_Caption=SQL Server Upgrade
sqlscripts_Description=Upgrading the SQL Server database...

[Code]
var
  imgSCRItems: TBitmapImage;
  txtSCRItems: TMemo;

{ sqlscripts_Activate }

//chkSQLRestore
procedure sqlscripts_Activate(Page: TWizardPage);
begin

  WizardForm.NextButton.Caption := 'Install';

	with txtSCRItems do
	begin

    Lines.Clear();

		if (chkSQLBackup.Checked) then Lines.Add('Creating backup');

		Lines.Add('Updating existing structures');
		Lines.Add('Creating new structures');
		Lines.Add('Updating existing structures');
		Lines.Add('Importing');
		Lines.Add('Updating triggers');
		Lines.Add('Performing cleanup');

  end;

end;

{ sqlscripts_ShouldSkipPage }

function sqlscripts_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

{ sqlscripts_BackButtonClick }

function sqlscripts_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

{ sqlscripts_NextkButtonClick }

function sqlscripts_NextButtonClick(Page: TWizardPage): Boolean;
var
	iLoop: Integer;
	iLoopRem: Integer;
	iCount: Integer;
	iTopPos: Integer;
	ResultCode: Integer;
	imgPRECompleted: TBitmapImage;
	bError: Boolean;
	bExit: Boolean;
	params: String;

begin

	bError := false;
	bExit := false;

	with WizardForm do
	begin

    CancelButton.Enabled := false;
		BackButton.Enabled := false;
		NextButton.Enabled := false;

	end;

	iCount := txtSCRItems.Lines.Count;

	if (iCount > 0) then
	begin

		with imgSCRItems do
		begin

			Bitmap.LoadFromFile(ExpandConstant('{src}\images\installing.bmp'));

			Visible := true;

		end;

		iTopPos := 1;

		for iLoop := 0 to (iCount - 1) do
		begin

			imgSCRItems.Top := iTopPos;
			
			WizardForm.Repaint;

			iTopPos := iTopPos + 17;

			if(not bError) then
			begin

				try
				
				  params := 'sqlexec -server' + #34 + txtSQLServer.Text + #34 + ' -database' + #34 + txtSQLDatabase.Text + #34 + ' -username' + #34 + txtSQLUsername.Text + #34 + ' -password' + #34 + txtSQLPassword.Text + #34 + ' -path' + #34 + txtSQLBackup.Text + #34 + ' -script' + #34 + ExpandConstant('{src}\sql\<%script%>.sql') + #34;

					case txtSCRItems.Lines[iLoop] of

						'Creating backup':
						  StringChangeEx(params, '<%script%>', 'backup', true);

						'Creating new structures':
						  StringChangeEx(params, '<%script%>', 'create', true);

						'Updating existing structures':
						  StringChangeEx(params, '<%script%>', 'update', true);

						'Importing':
						  StringChangeEx(params, '<%script%>', 'import', true);

						'Updating triggers':
						  StringChangeEx(params, '<%script%>', 'triggers', true);

						'Performing cleanup':
						  StringChangeEx(params, '<%script%>', 'delete', true);

					end;
				
				  StringChangeEx(params, '\"', '"', true);

          Exec(ExpandConstant('{src}\update\sqlexec.exe'), params, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

          if (ResultCode <> 0) then
          begin
          
            bError := true;
            bExit := true;
            
          end;
					
				except

					bError := true;
					bExit := true;

				end;

        if (ResultCode <> 0) then
        begin

          if (chkSQLRestore.Checked) then
          begin

            bError := true;
            bExit := true;

		        for iLoopRem := 0 to (iCount - iLoop) do
		        begin

              txtSCRItems.Lines.Delete(iLoop + 1);

            end;

            txtSCRItems.Lines.Add('Attempting to restore the database backup');

			     end
			     else
			     begin
			     
			       iLoop := iCount;
			     
			     end;
			
        end;

			end
			else
			begin
			
			 if (chkSQLRestore.Checked) then
			 begin

			  iLoop:= iCount;
			
        params := 'sqlexec -server' + #34 + txtSQLServer.Text + #34 + ' -database' + #34 + txtSQLDatabase.Text + #34 + ' -username' + #34 + txtSQLUsername.Text + #34 + ' -password' + #34 + txtSQLPassword.Text + #34 + ' -path' + #34 + txtSQLBackup.Text + #34 + ' -script' + #34 + ExpandConstant('{src}\sql\restore.sql') + #34;

        StringChangeEx(params, '\"', '"', true);

        bError := not Exec(ExpandConstant('{src}\update\upgrade.exe'), params, '', SW_SHOW, ewWaitUntilTerminated, ResultCode);

			 end;
			
			end;

      imgPRECompleted := TBitmapImage.Create(Page);

			with imgPRECompleted do
			begin

				Parent := Page.Surface;
				Left := ScaleX(4);
				Top := (iTopPos - 17);
				Width := ScaleX(16);
				Height := ScaleY(16);

				if (not bError) then
          Bitmap.LoadFromFile(ExpandConstant('{src}\images\done.bmp'))
        else
          Bitmap.LoadFromFile(ExpandConstant('{src}\images\error.bmp'));

			end;

			WizardForm.Repaint;

			Sleep(1000);

		end;

	end;
	
  if(bExit) and (chkSQLRestore.Checked) then
  begin

    if (bExit) and (not bError) then
      MsgBox('An error occurred during the database upgrade.' + #13#13 + 'Please send the error.log file contained in the upgrade folder to your SmartHR Distributor for further analysis.' + #13#13 + 'The database has now been restored.' + #13#13 + 'Please forward a backup of your database to your SmartHR distributor for further analysis.', mbInformation, MB_OK)
    else
      MsgBox('An error occurred during the database upgrade.' + #13#13 + 'Please send the error.log file contained in the upgrade folder to your SmartHR Distributor for further analysis.' + #13#13 + 'The attempt to automatically restore the database has failed.' + #13#13 + '*** ENSURE THAT YOU MANUALLY RESTORE THE DATABASE! ***' + #13#13 + 'Please forward a backup of your database to your SmartHR distributor for further analysis.', mbInformation, MB_OK);

  end
  else
  begin

    if(bExit) then
      MsgBox('An error occurred during the database upgrade.' + #13#13 + 'Please send the error.log file contained in the upgrade folder to your SmartHR Distributor for further analysis.' + #13#13 + 'Please restore the database to it' + #39 + 's original backup state that you created before installation.' + #13#13 + 'Please forward a backup of your database to your SmartHR distributor for further analysis.', mbInformation, MB_OK)

  end;

	with WizardForm do
	begin

    CancelButton.Enabled := true;
		BackButton.Enabled := not bExit;
		NextButton.Enabled := not bExit;

	end;

	Result := not bExit;

end;

{ sqlscripts_CancelButtonClick }

procedure sqlscripts_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
  // enter code here...
end;

{ sqlscripts_CreatePage }

function sqlscripts_CreatePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(
    PreviousPageId,
    ExpandConstant('{cm:sqlscripts_Caption}'),
    ExpandConstant('{cm:sqlscripts_Description}')
  );

  { imgSCRItems }
  imgSCRItems := TBitmapImage.Create(Page);
  with imgSCRItems do
  begin
    Parent := Page.Surface;
    Left := ScaleX(4);
    Top := ScaleY(0);
    Width := ScaleX(16);
    Height := ScaleY(16);
  end;

  { txtSCRItems }
  txtSCRItems := TMemo.Create(Page);
  with txtSCRItems do
  begin
		Parent := Page.Surface;
		Left := ScaleX(24);
		Top := ScaleY(0);
		Width := ScaleX(385);
		Height := ScaleY(233);
		TabStop := false;
		BorderStyle := bsNone;
		Color := -16777201;
		Font.Color := -16777208;
		Font.Height := ScaleY(-14);
		Font.Name := 'Tahoma';
		ReadOnly := true;
		WantReturns := false;
		TabOrder := 0;
  end;

  with Page do
  begin
    OnActivate := @sqlscripts_Activate;
    OnShouldSkipPage := @sqlscripts_ShouldSkipPage;
    OnBackButtonClick := @sqlscripts_BackButtonClick;
    OnNextButtonClick := @sqlscripts_NextButtonClick;
    OnCancelButtonClick := @sqlscripts_CancelButtonClick;
  end;

  if (FileExists(ExpandConstant('{src}\update\error.log'))) then
    RenameFile(ExpandConstant('{src}\update\error.log'), ExpandConstant('{src}\update\error.lo_'));

  Result := Page.ID;

end;
