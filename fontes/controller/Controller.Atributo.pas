unit Controller.Atributo;

interface

type
  TableName = class(TCustomAttribute)
  private
    FName: String;
  public
    property Name: String read FName write FName;
    constructor Create(const AValue: String);
  end;

  FieldName = class(TCustomAttribute)
  private
    FName: String;
    FNameFK: String;
    FFK: Boolean;
    FAutoInc: Boolean;
    FPK: Boolean;
  public
    property Name: String read FName write FName;
    property Name_FK: String read FNameFK write FNameFK;
    property PK: Boolean read FPK write FPK;
    property AutoInc: Boolean read FAutoInc write FAutoInc;
    property FK: Boolean read FFK write FFK;
    constructor Create(const AValue: String; const ACampoFK:String = '';
                       const APK: Boolean = False; const AAutoInc: Boolean = false;
                       const AFK: Boolean = False);
  end;

implementation

{ TableName }

constructor TableName.Create(const AValue: String);
begin
  FName   := AValue;
end;

{ FieldName }

constructor FieldName.Create(const AValue: String; const ACampoFK:String = '';
                       const APK: Boolean = False; const AAutoInc: Boolean = false;
                       const AFK: Boolean = False);
begin
  FName := AValue;
  FNameFK:= ACampoFK;
  FPK := APK;
  FAutoInc := AAutoInc;
  FFK := AFK;
end;

end.
