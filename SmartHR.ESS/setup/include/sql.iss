function Connected(Server, Database, UserID, Pwd: String): Boolean;
var
	dbCon: Variant;
  Success: Boolean;

begin

  Success := false;

  try

    dbCon := CreateOleObject('ADODB.Connection');

		dbCon.Open('Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=' + Server + ';Database=' + Database + ';User ID=' + UserID + ';Password=' + Pwd);

		dbCon.Close();

    Success := true;

  except

    MsgBox('Connection failure; details follow:' + #13#13 + GetExceptionMessage, mbInformation, MB_OK);

  end;

  Result := Success;

end;
