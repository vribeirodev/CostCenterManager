unit LancamentoModel;

interface

uses
  System.SysUtils;

type
  TLancamento = class
  private
    FId: Integer;
    FCodigoPai: Integer;
    FCodigoFilho: Integer;
    FValor: Real;
  public
    property Id: Integer read FId write FId;
    property CodigoPai: Integer read FCodigoPai write FCodigoPai;
    property CodigoFilho: Integer read FCodigoFilho write FCodigoFilho;
    property Valor: Real read FValor write FValor;

    constructor Create(const Id, CodigoPai, CodigoFilho: Integer; const Valor: Real);
  end;

implementation

constructor TLancamento.Create(const Id, CodigoPai, CodigoFilho: Integer; const Valor: Real);
begin
  if (Id < 1) then
    raise Exception.Create('Id de lançamento inválido.');
  if (Valor < 0) then
    raise Exception.Create('Valor de lançamento inválido.');
  if (CodigoPai < 1) or (CodigoPai > 99) then
    raise Exception.Create('Código de centro de custo pai inválido.');
  if (CodigoFilho < 1000) or (CodigoFilho > 9999) then
    raise Exception.Create('Código de centro de custo filho inválido.');

  FId := Id;
  FValor := Valor;
  FCodigoPai := CodigoPai;
  FCodigoFilho := CodigoFilho;
end;

end.

