unit uConverteTexto;

interface

uses System.Classes, uIConverter, Vcl.Forms, System.StrUtils,
SysUtils;

type

ExcepcionErroConverter = class(Exception);

TConverteTexto = class(TInterfacedObject, IConverter)
private
  FTexto: string;
public
  function Converter: string; virtual; abstract;
  function GetTexto: string;
  procedure SetTexto(const value: string);
  property Texto: string read GetTexto write SetTexto;
end;

TConverteInvertido = class(TConverteTexto)
  function Converter: string;  override;
  function GetTexto: string;
  procedure SetTexto(const value: string);
  property Texto: string read GetTexto write SetTexto;
end;

TConvertePrimeiraMaiuscula = class(TConverteTexto)
  function Converter: string; override;
  function GetTexto: string;
  procedure SetTexto(const value: string);
  property Texto: string read GetTexto write SetTexto;
end;

TConverteOrdenado = class(TConverteTexto)
  function Converter: string; override;
  function GetTexto: string;
  procedure SetTexto(const value: string);
  property Texto: string read GetTexto write SetTexto;
end;


implementation

{ TConverteTexto }

function TConverteTexto.GetTexto: string;
begin
  result := FTexto;
end;

procedure TConverteTexto.SetTexto(const value: string);
begin
  if value = '' then
    raise ExcepcionErroConverter.Create('O texto está vazio.');

  FTexto := Value;
end;

{ TConvertePrimeiraMaiuscula }

function TConvertePrimeiraMaiuscula.Converter: string;
var I: Integer;
begin
  result := LowerCase(Texto);
  result[1] := UpCase(result[1]);
  for I := 1 to Length(Texto) - 1 do
  begin
    if (result[I] = ' ')   or (result[I] = '''')
      or (result[I] = '-') or (result[I] = '.')
      or (result[I] = '(') then
    result[I + 1] := UpCase(result[I + 1]);
  end;
end;

function TConvertePrimeiraMaiuscula.GetTexto: string;
begin
  result := FTexto;
end;

procedure TConvertePrimeiraMaiuscula.SetTexto(const value: string);
begin
  FTexto := Value;
end;

{ TConverteInvertido }

function TConverteInvertido.Converter: string;
begin
  result := ReverseString(Texto);
end;

function TConverteInvertido.GetTexto: string;
begin
  result := FTexto;
end;

procedure TConverteInvertido.SetTexto(const value: string);
begin
  FTexto := Value;
end;

{ TConverteOrdenado }

function TConverteOrdenado.Converter: string;
var
  oTexto: TStringList;
  i: integer;
begin
  oTexto := TStringList.Create;
  try
    Trim(Texto);
    for i := 1 to Length(Texto) do
    begin
      oTexto.Add(FTexto[i]);
    end;
    oTexto.Sorted := True;
    result := oTexto.Text;
    result := StringReplace(result, #$D#$A, '', [rfReplaceAll]);
  finally
    FreeAndnIl(oTexto);
  end;
end;

function TConverteOrdenado.GetTexto: string;
begin
  Result := FTexto;
end;

procedure TConverteOrdenado.SetTexto(const value: string);
begin
  FTexto := Value;
end;

end.
