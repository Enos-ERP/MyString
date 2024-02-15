unit mystring;

interface

uses
  System.Classes,
  System.SysUtils,
  System.AnsiStrings;

type
  TMyString = class
  private
    { private declarations }
  public
    { public declarations }

///<summary>Remove caracteres especificados de uma String.</summary>
///<param name="ACharacters">String que cont�m os caracteres que ser�o removidos.</param>
///<param name="AString">String onde os caracteres ser�o removidos.</param>
///<returns>Retorna a String com os caracteres removidos.</returns>
///<remarks>O par�metro ACharacters pode conter mais de um caracteres. N�o funciona com caracteres com acentos.</remarks>
    class function RemoveCharacters(ACharacters, AString: String): String;

///<summary>Recebe uma String e retorna a String somente com n�meros.</summary>
///<param name="AString">String que ser� tratada.</param>
///<returns>Retorna uma String somente com n�meros.</returns>
///<remarks>Entrada: 'A1a2' Sa�da: '12'.</remarks>
    class function OnlyNumber(AString: String): String;

///<summary>Separa/Divide uma cadeia de String delimitadas por um separador.</summary>
///<param name="AString">String que cont�m a cadeia de valores.</param>
///<param name="ASeparator">Caractere separador.</param>
///<returns>Retorna um TStringList onde cada item armazena um valor da cadeia de valores em String.</returns>
///<remarks>Entrada: 'Value1, Value2, Value3' Sa�da: TStringList [1]('Value1') [2]('Value2') [3]('Value3').</remarks>
///<exception cref="Exception">Em caso de exce��o retorna nil.</exception>
    class function SeparateText(AString: String; ASeparator: Char): TStringList;

///<summary>Conta quantas palavras cont�m em uma String.</summary>
///<param name="AString">String para contar as palavras.</param>
///<returns>Retorna quantas palavras foram encontradas na String.</returns>
///<remarks>Entrada: 'Lorem Ipsum is simply dummy.' Sa�da: 5.</remarks>
    class function WordCount(AString: String): Integer;

///<summary>Conta o n�mero de vezes que uma Substring � encontrada dentro de uma String.</summary>
///<param name="ASubString">SubString a ser localizada na String.</param>
///<param name="AString">String onde a Substring ser� localizada.</param>
///<returns>Retorna quantas vezes a Substring foi localizada na String.</returns>
///<remarks>Entrada: 'is', 'Lorem Ipsum is simply dummy' Sa�da: 1.</remarks>
    class function CountPos(const ASubString: String; AString: String): Integer;

///<summary>Converte a String fornecida em um valor inteiro. Se a String n�o cont�m um valor v�lido retorna 0.</summary>
///<param name="AString">String que ser� convertida para inteiro.</param>
///<returns>Retorna um valor inteiro convertido com base na String.</returns>
///<remarks>Entrada: '32' Sa�da: 32.</remarks>
///<exception cref="Exception">Em caso de exce��o retorna 0.</exception>
    class function MyTryStrToInt(AString: String): Integer;

///<summary>Remove os caracteres especiais, deixando somente caracteres numericos e letras.</summary>
///<param name="AString">String original.</param>
///<returns>Retorna uma String que cont�m somente numeros e letras.</returns>
///<remarks>Entrada: 'A*1#3!B' Sa�da: 'A13B'.</remarks>
    class function RemoveCharSpecial(AString: String): String;
  end;

implementation

{ TMyString }

class function TMyString.RemoveCharacters(ACharacters, AString: String): String;
var
  LTextClear: TStringBuilder;
  LCharLetter: Char;
begin
  LTextClear := TStringBuilder.Create;
  try
    for LCharLetter in AString do
      if Pos(AnsiUpperCase(LCharLetter), ACharacters.ToUpper) = 0  then
        LTextClear.Append(LCharLetter);
    Result := LTextClear.ToString;
  finally
    FreeAndNil(LTextClear);
  end;
end;

class function TMyString.OnlyNumber(AString: String): String;
var
  LS1, LS2: String;
  LIndex: Integer;
begin
  LS1 := AString;
  LS2 := '';
  for LIndex := 1 to Length(LS1) do
    if LS1[LIndex] in ['0'..'9'] then
      LS2 := LS2 + LS1[LIndex];
  Result := LS2;
end;

class function TMyString.SeparateText(AString: String; ASeparator: Char): TStringList;
begin
  AString := StringReplace(AString, ', ', ',', [rfReplaceAll, rfIgnoreCase]);
  Result := TStringList.Create;
  Result.StrictDelimiter := True;
  Result.Delimiter := ASeparator;
  Result.DelimitedText := AString;
end;

class function TMyString.WordCount(AString: String): Integer;
var
  LCount: Integer;
  LIndex: Integer;
  LLen: Integer;
begin
  LLen := Length(AString);
  LCount := 0;
  LIndex := 1;
  while LIndex <= LLen do
  begin
    while ((LIndex <= LLen) and ((AString[LIndex] = #32) or (AString[LIndex] = #9) or (AString[LIndex] = ';'))) do
      Inc(LIndex);
    if LIndex <= LLen then
      Inc(LCount);
    while ((LIndex <= LLen) and ((AString[LIndex] <> #32) and (AString[LIndex] <> #9) and (AString[LIndex] <> ';'))) do
      Inc(LIndex);
  end;
  WordCount := LCount;
end;

class function TMyString.CountPos(const ASubString: String; AString: String): Integer;
begin
  if (Length(ASubString) = 0) or (Length(AString) = 0) or (Pos(ASubString, AString) = 0) then
    Result := 0
  else
    Result := (Length(AString) - Length(StringReplace(AString, ASubString, '', [rfReplaceAll]))) div Length(ASubString);
end;

class function TMyString.MyTryStrToInt(AString: String): Integer;
begin
  Result := 0;
  try
    if not TryStrToInt(AString, Result) then
      Result := 0;
  except
    Result := 0;
  end;
end;

class function TMyString.RemoveCharSpecial(AString: String): String;
var
  LString1, LString2: String;
  LIndex: Integer;
begin
  LString1 := AString;
  LString2 := '';
  for LIndex := 1 to Length(LString1) do
    if (LString1[LIndex] in ['0'..'9']) or (LString1[LIndex] in ['a'..'z']) or (LString1[LIndex] in ['A'..'Z']) then
      LString2 := LString2 + LString1[LIndex];
  Result := LString2;
end;

end.
