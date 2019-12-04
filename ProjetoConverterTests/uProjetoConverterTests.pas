unit uProjetoConverterTests;

interface

uses
  DUnitX.TestFramework, uConverteTexto;

type
  [TestFixture]
  TTesteConverter = class
  public
    FConverter: TConverteTexto;
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarConverter;
  end;

implementation

uses System.SysUtils;

procedure TTesteConverter.Setup;
begin
  FConverter := TConverteTexto.Create;
end;

procedure TTesteConverter.TearDown;
begin
  FreeAndNil(FConverter);
end;

procedure TTesteConverter.TestarConverter;
begin
  FConverter.Texto := '';

  if FConverter.Texto = '' then
    raise ExcepcionErroConverter.Create('O campo está vazio');
end;

initialization
  TDUnitX.RegisterTestFixture(TTesteConverter);

end.
