unit Controller.PersistentObject;
interface
uses
  Rtti,StrUtils,Variants,Classes,FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.DApt, Controller.Connection, Controller.Atributo, SysUtils,
  u_dicionarioDados;
type
  TPersintentObject = class
  private
    FSQL: WideString;
    wp_id: Integer;
    function GetValue(const ARTP: TRttiProperty; const AFK: Boolean): String;
    procedure SetValue(P: TRttiProperty; S: Variant);
    function Deletar(AEmpresa, AUsuario: Integer): Boolean;
  public
    property CustomSQL: WideString read FSQL write FSQL;
    function Insert: String;
    function Delete: Boolean;
    function Update(ACond: String = ''): String;
    procedure GetID(const AValue: Integer);
    procedure Load(const AValue: Integer; ACampoFK: String = ''); overload; virtual; abstract;
    function Load: Boolean; overload;
  end;
implementation
{ TPersintentObject }
function TPersintentObject.Deletar(AEmpresa, AUsuario: Integer): Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Value,
  FieldID,
  NomeTabela,Error: String;
begin
  Field := '';
  Value := '';
  TConnection.GetInstance.BeginTrans;
  Ctx := TRttiContext.Create;
  try
    try
      RTT := CTX.GetType(ClassType);
      for Att in RTT.GetAttributes do
      begin
        if Att is TableName then
        begin
          SQL := 'DELETE FROM ' + TableName(ATT).Name;
          NomeTabela := TableName(ATT).Name;
        end;
      end;
      for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
         begin
           if Att is FieldName then
           begin
             if (FieldName(ATT).AutoInc) then
             begin
               Field := Field + FieldName(ATT).Name + ',';
               Value := Value + GetValue(RTP,FieldName(ATT).FK) + ',';
             end
             else
               FieldID := FieldName(ATT).Name;
           end;
         end;
      end;
      Field := Copy(Field,1,Length(Field)-1);
      Value := Copy(Value,1,Length(Value)-1);
      Value := StringReplace(Value, '"', '',[rfReplaceAll, rfIgnoreCase]);
      SQL := SQL + ' WHERE ' + Field + ' = ' + Value ;
      if Trim(CustomSQL) <> '' then
        SQL := CustomSQL;
      Result := TConnection.GetInstance.Execute(SQL,Error);
    finally
      CustomSQL := '';
      TConnection.GetInstance.Commit;
      CTX.Free;
    end;
  except on E: Exception do
    begin
      TConnection.GetInstance.Rollback;
      CTX.Free;
      raise;
    end;
  end;
end;
function TPersintentObject.Update(ACond: String = ''): String;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Value_New,
  Where,
  Error: String;
begin
  Field := '';
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
    begin
      if Att is TableName then
        SQL := 'UPDATE ' + TableName(ATT).Name + ' SET';
      if ACond <> '' then
        SQL := 'UPDATE ' + TableName(ATT).Name ;
    end;
    if Acond = '' then
    begin
      for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
         begin
           if Att is FieldName then
           begin
             if (not (FieldName(ATT).AutoInc)) and (not (FieldName(ATT).PK)) then {Auto incremento não pode entrar no update}
             begin
               Value_New:= GetValue(RTP,FieldName(ATT).FK);
               if (trim(Value_New) <> cs_string_branco) and (Value_New <> 'null') and (Value_New <> '-1') and (Value_New <>'''""''') then
               begin
                 Field := Field + FieldName(ATT).Name + ' = ' + Value_New + ',';
               end;
             end
             else if (FieldName(ATT).PK) then
               Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK);
           end;
         end;
      end;
      Field := Copy(Field,1,Length(Field)-1);
      Field := StringReplace(Field, '"', '',[rfReplaceAll, rfIgnoreCase]);
    end;
    if ACond <> '' then
      SQL := SQL + ' ' + ACond
    else
      SQL := SQL + ' ' + Field + ' WHERE ' + Where;
    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;
      Result := TConnection.GetInstance.Execute(SQL,Error).ToString;
    if Result = '' then
      raise Exception.Create(Error);
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

function TPersintentObject.Insert: String;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Value,
  Value_New,
  FieldID,
  NomeTabela,Error: String;
  Pk: String;
  Qry: TFDQuery;
  Id_Return: String;
begin
  Id_Return:= '';
  Field    := '';
  Value    := '';
  TConnection.GetInstance.BeginTrans;
  Ctx := TRttiContext.Create;
  try
    try
      RTT := CTX.GetType(ClassType);
      for Att in RTT.GetAttributes do
      begin
        if Att is TableName then
        begin
          SQL := 'INSERT INTO ' + TableName(ATT).Name;
          NomeTabela := TableName(ATT).Name;
        end;
      end;
      for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
         begin
           if Att is FieldName then
           begin
             if not (FieldName(ATT).AutoInc) then
             begin
               Value_New:= GetValue(RTP,FieldName(ATT).FK);
               if trim(Value_New) <> cs_string_branco then
               begin
                 if (FieldName(ATT).FK) and ((Value_New = '0') or (Value_New = 'null')) then
                   Field:= Field
                 else
                 begin
                   Field := Field + FieldName(ATT).Name + ',';
                   Value := Value + Value_New + ',';
                 end;
               end;
             end
             else
             if (FieldName(ATT).AutoInc) then
               Pk:= FieldName(ATT).Name
             else
               FieldID := FieldName(ATT).Name;
           end;
         end;
      end;
      Field := Copy(Field,1,Length(Field)-1);
      Value := Copy(Value,1,Length(Value)-1);
      Value := StringReplace(Value, '"', '',[rfReplaceAll, rfIgnoreCase]);
      SQL := SQL + ' (' + Field + ') VALUES (' + Value + ')';
      if Trim(CustomSQL) <> '' then
        SQL := CustomSQL;
      try
        TConnection.GetInstance.Execute(SQL,Error);
        if Pk <> '' then
        begin
          SQL := 'SELECT ' + Pk + ' FROM ' + NomeTabela + ' ORDER BY ' + Pk + ' DESC';
          try
            Qry := TConnection.GetInstance.ExecuteQuery(SQL);
            for RTP in RTT.GetProperties do
            begin
              for Att in RTP.GetAttributes do
              begin
                if (Att is FieldName) and (FieldName(ATT).AutoInc) then
                begin
                  Id_Return:= qry.Fields[0].Asstring;
                  result   := Id_Return;
                end;
              end;
            end;
          finally
            FreeAndNil(qry);
          end;
        end
        else
          result:= '0';
      except on E: Exception do
        begin
          result:= '0';
        end;
      end;
    finally
      CustomSQL := '';
      TConnection.GetInstance.Commit;
      CTX.Free;
    end;
  except
    TConnection.GetInstance.Rollback;
    raise;
  end;
end;

function TPersintentObject.Delete: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Where,
  Error: String;
begin
  Field := '';
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
    begin
      if Att is TableName then
        SQL := 'DELETE FROM ' + TableName(ATT).Name ;
    end;
    for RTP in RTT.GetProperties do
    begin
       for Att in RTP.GetAttributes do
       begin
         if Att is FieldName then
         begin
           if (not (FieldName(ATT).AutoInc)) and
              ((not (FieldName(ATT).PK)) or (FieldName(ATT).Name_FK = '')) and (FieldName(ATT).FK) then {Auto incremento não pode entrar no update}
           begin
             if Field <> '' then
               Field:= Field+' AND ';
             Field := Field + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK) ;
           end
           else if (FieldName(ATT).PK) and (GetValue(RTP,FieldName(ATT).PK) <> 'null') then
           begin
             Field := Field + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK) ;
           end;
         end
       end;
    end;
    SQL := SQL + ' WHERE ' + Field + Where;
    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;
    Result := TConnection.GetInstance.Execute(SQL,Error);
    if not Result then
      raise Exception.Create(Error);
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;
procedure TPersintentObject.GetID(const AValue: Integer);
begin
  wp_id:= AValue;
  load;
end;

function TPersintentObject.GetValue(const ARTP: TRttiProperty;
  const AFK: Boolean): String;
begin
  case ARTP.PropertyType.TypeKind of
    tkUnknown, tkInteger,
    tkInt64: Result := ARTP.GetValue(Self).ToString;
    tkEnumeration: Result := IntToStr(Integer(ARTP.GetValue(Self).AsBoolean));
    tkChar, tkString,
    tkWChar, tkLString,
    tkWString, tkUString: Result := QuotedStr(ARTP.GetValue(Self).ToString);
    tkFloat: Result := StringReplace(FormatFloat('0.00',ARTP.GetValue(Self).AsCurrency)
              ,FormatSettings.DecimalSeparator,'.',[rfReplaceAll,rfIgnoreCase]);
  end;
  if (AFK) and (Result = '0') then
    Result := 'null';
end;
function TPersintentObject.Load: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Where: String;
  Reader: TFDQuery;
begin
  Result := True;
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
    begin
      if Att is TableName then
        SQL := 'SELECT * FROM ' + TableName(ATT).Name;
    end;
    for RTP in RTT.GetProperties do
    begin
       for Att in RTP.GetAttributes do
       begin
         if Att is FieldName then
         begin
           if (FieldName(ATT).PK) and (FieldName(ATT).Name_FK = '') then
             Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK)
           else if (Where = '') and (FieldName(ATT).FK) and (wp_id <> 0) then
             Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name_FK + ' = ' + IntToStr(wp_id)
           else if wp_id = 0 then
             Where := Where + Ifthen(Trim(where)='','',' AND ') +  '1 = 1';
         end;
       end;
    end;
    SQL := SQL + ' WHERE ' + Where;
    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;
    Reader := TConnection.GetInstance.ExecuteQuery(SQL);
    if (Assigned(Reader)) and (Reader.RecordCount > 0) then
    begin
      with Reader do
      begin
        First;
        while not EOF do
        begin
          for RTP in RTT.GetProperties do
          begin
             for Att in RTP.GetAttributes do
             begin
               if Att is FieldName then
               begin
                 if Assigned(FindField(FieldName(ATT).Name)) then
                   SetValue(RTP,FieldByName(FieldName(ATT).Name).Value);
               end;
             end;
          end;
          Next;
        end;
      end;
    end
    else
      Result := False;
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;
procedure TPersintentObject.SetValue(P: TRttiProperty; S: Variant);
var
  V: TValue;
  w: Word;
begin
  w := VarType(S);
  case w of
    271: v := StrToFloat(S); {smallmoney}
    272: v := StrToDateTime(S); {smalldatetime}
    3: v := StrToInt(S);
    else
    begin
      P.SetValue(Self,TValue.FromVariant(S));
      exit;
    end;
  end;
  p.SetValue(Self,v);
end;
end.
