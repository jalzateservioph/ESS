[CustomMessages]
prereq_Caption=Prerequisites
prereq_Description=Installs the following required components...

[Code]
var
  imgPREItems: TBitmapImage;
  txtPREItems: TMemo;

{ prereq_Activate }

procedure prereq_Activate(Page: TWizardPage);
begin

  WizardForm.NextButton.Caption := 'Install';

	with txtPREItems do
	begin

    Lines.Clear();

		if (not RegValueExists(HKLM, 'SOFTWARE\Microsoft\.NETFramework\policy\v2.0', '50727')) then Lines.Add('Microsoft .NET Framework v2.0.50727');

    if (not RegKeyExists(HKLM, 'SOFTWARE\Crystal Decisions\10.2')) then Lines.Add('Crystal Reports .NET Framework 2.0');

  end;

end;

{ prereq_ShouldSkipPage }

function prereq_ShouldSkipPage(Page: TWizardPage): Boolean;
var
  SkipPage: Boolean;
begin

  SkipPage := true;

  if (SkipPage) then SkipPage := RegKeyExists(HKLM, 'SOFTWARE\Crystal Decisions\10.2');

	if (SkipPage) then SkipPage := RegValueExists(HKLM, 'SOFTWARE\Microsoft\.NETFramework\policy\v2.0', '50727');

  Result := SkipPage;
  
end;

{ prereq_BackButtonClick }

function prereq_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

{ prereq_NextkButtonClick }

function prereq_NextButtonClick(Page: TWizardPage): Boolean;
var
  iCount: Integer;
  iTopPos: Integer;
  iLoop: Integer;
  ResultCode: Integer;
  imgPRECompleted: TBitmapImage;

begin

	with WizardForm do
	begin

    CancelButton.Enabled := false;
		BackButton.Enabled := false;
		NextButton.Enabled := false;

	end;

	iCount := txtPREItems.Lines.Count;

	if (iCount > 0) then
	begin

		with imgPREItems do
		begin

			Bitmap.LoadFromFile(ExpandConstant('{src}\images\installing.bmp'));

			Visible := true;

		end;

		iTopPos := 1;
		
		for iLoop := 0 to (iCount - 1) do
		begin

			imgPREItems.Top := iTopPos;
			
			WizardForm.Repaint;

			iTopPos := iTopPos + 17;

			case txtPREItems.Lines[iLoop] of

				'Crystal Reports .NET Framework 2.0':
					Exec(ExpandConstant('{sys}\msiexec.exe'), '/i "' + ExpandConstant('{src}\redist\crnetfx.msi') + '" /norestart /qb', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

				'Microsoft .NET Framework v2.0.50727':
					if (Is64BitInstallMode) then
						Exec(ExpandConstant('{src}\runtime\x64\dotnetfx64.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
					else
						Exec(ExpandConstant('{src}\runtime\x86\dotnetfx.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);

			end;

			imgPRECompleted := TBitmapImage.Create(Page);

			with imgPRECompleted do
			begin

				Parent := Page.Surface;
				Left := ScaleX(4);
				Top := (iTopPos - 17);
				Width := ScaleX(16);
				Height := ScaleY(16);

				Bitmap.LoadFromFile(ExpandConstant('{src}\images\done.bmp'));

			end;

			WizardForm.Repaint;

			Sleep(1000);

		end;

  end;

	with WizardForm do
	begin

    CancelButton.Enabled := true;
		BackButton.Enabled := true;
		NextButton.Enabled := true;

	end;

  Result := True;
  
end;

{ prereq_CancelButtonClick }

procedure prereq_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
  // enter code here...
end;

{ prereq_CreatePage }

function prereq_CreatePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(
    PreviousPageId,
    ExpandConstant('{cm:prereq_Caption}'),
    ExpandConstant('{cm:prereq_Description}')
  );

  { imgPREItems }
  imgPREItems := TBitmapImage.Create(Page);
  with imgPREItems do
  begin
    Parent := Page.Surface;
    Left := ScaleX(4);
    Top := ScaleY(0);
    Width := ScaleX(16);
    Height := ScaleY(16);
  end;

  { txtPREItems }
  txtPREItems := TMemo.Create(Page);
  with txtPREItems do
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
    OnActivate := @prereq_Activate;
    OnShouldSkipPage := @prereq_ShouldSkipPage;
    OnBackButtonClick := @prereq_BackButtonClick;
    OnNextButtonClick := @prereq_NextButtonClick;
    OnCancelButtonClick := @prereq_CancelButtonClick;
  end;

  Result := Page.ID;
end;
