unit Utils.Criptografia;

interface

uses
  System.NetEncoding, System.SysUtils;

type
  TCriptografia = class
  private
    class function ObterChave: String; static;
  public
    class function Criptografar(aValue: string): string;
    class function Descriptografar(aValue: string): string;
  end;

implementation

{ TCripitografia }

class function TCriptografia.Criptografar(aValue: string): string;
var
  KeyLen: Integer;
	KeyPos: Integer;
	OffSet: Integer;
	Dest: String;
  Key: String;
	SrcPos: Integer;
	SrcAsc: Integer;
	Range: Integer;
  Src: String;
begin
  Src := aValue;
	Key := ObterChave;
	Dest := EmptyStr;
	KeyLen := Length(Key);
	KeyPos := 0;
	Range := 256;
  Randomize;
	OffSet := Random(Range);
	Dest := Format('%1.2x', [OffSet]);
	for SrcPos := 1 to Length(Src) do
	begin
		SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
		if KeyPos < KeyLen then
      KeyPos := KeyPos + 1
    else
      KeyPos := 1;
    SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
		Dest := Dest + Format('%1.2x', [SrcAsc]);
		OffSet := SrcAsc;
	end;
  Result := Dest;
end;

class function TCriptografia.Descriptografar(aValue: string): string;
var
  KeyLen: Integer;
	KeyPos: Integer;
	OffSet: Integer;
	Dest: String;
  Key: String;
	SrcPos: Integer;
	SrcAsc: Integer;
	TmpSrcAsc: Integer;
  Src: String;
begin
  Src := aValue;
	Key := ObterChave;
	Dest := EmptyStr;
	KeyLen := Length(Key);
	KeyPos := 0;
	OffSet := StrToInt('$' + copy(Src, 1, 2));
	SrcPos := 3;
	repeat
		SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
		if (KeyPos < KeyLen) Then
      KeyPos := KeyPos + 1
    else
      KeyPos := 1;
		TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then
      TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else
      TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
		OffSet := SrcAsc;
		SrcPos := SrcPos + 2;
 	until (SrcPos >= Length(Src));
	Result:= Dest;
end;

class function TCriptografia.ObterChave: String;
begin
  Result := 'MIIBOQIBAAJAbcV3a+l7DgiAP2FNwURltyuc6AQDkWMZU1dk82jjzuQTwqoDH/36' +
            'vfJIH9bxcYmTX9G7d/JFNenMScmdV3eKLwIDAQABAkAGZYpm/G0STUaD6vyn9X9j' +
            '5CO5lXpLv5WbOK2GTadwx+Ad91xt0kb3AyaDMHWb1dgPlfVDHz9md99aO5C5L9sx' +
            'AiEAre32ztpDMKtYon7tP3TFZ17rObk06l+kzPKjomzufQcCIQChkW8BP3K+MDid' +
            'XFb5FwNS/PG2KOLbws/EreUYSxdnmQIhAIr8R2dQfrSbl75yEv/MPhq2fN2ppCFN' +
            'wJGNqzkWNxVtAiAAszyj6L56jILyS6Ak3DCrf2UcwPiaszFrTMWdYVXsoQIgKPs7' +
            'h6o1z+lxtUGIeSct6uHBElM9/PEnk1lI9A/trM8=';
end;

end.
