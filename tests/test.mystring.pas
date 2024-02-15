unit test.mystring;

interface

uses
  TestFramework, System.AnsiStrings, System.SysUtils, System.Classes, mystring;

type
  TestTMyString = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRemoveCharacters;
    procedure TestOnlyNumber;
    procedure TestSeparateText;
    procedure TestWordCount;
    procedure TestEmptyWordCount;
    procedure TestCountPos;
    procedure TestMyTryStrToInt;
    procedure TestZeroMyTryStrToInt;
    procedure TestRemoveCharSpecial;
    procedure TestCharIsNum;
  end;

implementation

procedure TestTMyString.SetUp;
begin

end;

procedure TestTMyString.TearDown;
begin

end;

procedure TestTMyString.TestRemoveCharacters;
var
  ReturnValue: String;
  AString: String;
  ACharacters: String;
begin
  ACharacters := '!@#$%&*()';
  AString := '(My !@# clean $%&* string.)';
  ReturnValue := TMyString.RemoveCharacters(ACharacters, AString);
  CheckEquals('My  clean  string.', ReturnValue, 'TestRemoveCharacters failed.');
end;

procedure TestTMyString.TestOnlyNumber;
var
  ReturnValue: String;
  AString: String;
begin
  AString := 'A1b2C3d4E5f6G7H8I9';
  ReturnValue := TMyString.OnlyNumber(AString);
  CheckEquals('123456789', ReturnValue, 'TestOnlyNumber failed.');
end;

procedure TestTMyString.TestSeparateText;
var
  ReturnValue: TStringList;
  ASeparator: Char;
  AString: String;
  Item: String;
begin
  AString := 'Value, Value, Value';
  ASeparator := ',';
  ReturnValue := TMyString.SeparateText(AString, ASeparator);
  for Item in ReturnValue do
    CheckEquals('Value', Item, 'TestSeparateText failed.');
end;

procedure TestTMyString.TestWordCount;
var
  ReturnValue: Integer;
  AString: String;
begin
  AString := 'Lorem ipsum proin phasellus non mollis eleifend himenaeos leo, ' +
            'mattis vivamus sit dictum leo sociosqu ad mattis eget, hac sed ' +
            'sagittis fringilla adipiscing conubia hac.';
  ReturnValue := TMyString.WordCount(AString);
  CheckEquals(25, ReturnValue, 'TestWordCount failed.');
end;

procedure TestTMyString.TestEmptyWordCount;
var
  ReturnValue: Integer;
  AString: String;
begin
  AString := '';
  ReturnValue := TMyString.WordCount(AString);
  CheckEquals(0, ReturnValue, 'TestEmptyWordCount failed. Not returned 0.');
end;

procedure TestTMyString.TestCountPos;
var
  ReturnValue: Integer;
  AString: String;
  ASubString: String;
begin
  ASubString := 'leo';
  AString := 'Lorem ipsum proin phasellus non mollis eleifend himenaeos leo, ' +
                'mattis vivamus sit dictum leo sociosqu ad mattis eget, hac sed ' +
                'sagittis fringilla adipiscing conubia hac.';
  ReturnValue := TMyString.CountPos(ASubString, AString);
  CheckEquals(2, ReturnValue, 'TestCountPos failed.');
end;

procedure TestTMyString.TestMyTryStrToInt;
var
  ReturnValue: Integer;
  AString: String;
begin
  AString := '12';
  ReturnValue := TMyString.MyTryStrToInt(AString);
  CheckEquals(12, ReturnValue, 'TestMyTryStrToInt failed.');
end;

procedure TestTMyString.TestZeroMyTryStrToInt;
var
  ReturnValue: Integer;
  AString: String;
begin
  AString := '12.5';
  ReturnValue := TMyString.MyTryStrToInt(AString);
  CheckEquals(0, ReturnValue, 'TestZeroMyTryStrToInt failed. Not returned 0.');
end;

procedure TestTMyString.TestRemoveCharSpecial;
var
  ReturnValue: String;
  AString: String;
begin
  AString := 'A*1#3!B';
  ReturnValue := TMyString.RemoveCharSpecial(AString);
  CheckEquals('A13B', ReturnValue, 'TestRemoveCharSpecial failed.');
end;

procedure TestTMyString.TestCharIsNum;
var
  ReturnValue: Boolean;
  AChar: Char;
begin
  AChar := '1';
  ReturnValue := TMyString.CharIsNum(AChar);
  CheckEquals(True, ReturnValue, 'TestCharIsNum failed.');
end;

initialization
  RegisterTest(TestTMyString.Suite);

end.

