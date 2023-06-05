unit CentroCustoModel;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  LancamentoModel;

type
  TCentroCusto = class
  private
    FCodigoPai: Integer;
    FCodigoFilho: Integer;
    FIdOrcamento: Integer;
    FLancamentos: TObjectList<TLancamento>;
  public
    property CodigoPai: Integer read FCodigoPai write FCodigoPai;
    property CodigoFilho: Integer read FCodigoFilho write FCodigoFilho;
    property IdOrcamento: Integer read FIdOrcamento write FIdOrcamento;
    property Lancamentos: TObjectList<TLancamento> read FLancamentos;

    constructor Create(const CodigoPai, CodigoFilho, IdOrcamento: Integer); overload;
    constructor Create(const CodigoPai, CodigoFilho: Integer); overload;
    destructor Destroy; override;
    function GetCodigoCompleto: string;
    function GetValorTotal: Real;

    procedure AdicionarLancamento(const Lancamento: TLancamento);
  end;

implementation

constructor TCentroCusto.Create(const CodigoPai, CodigoFilho, IdOrcamento: Integer);
begin
  if (CodigoPai < 1) or (CodigoPai > 99) then
    raise Exception.Create('Código de centro de custo pai inválido.');
  if (CodigoFilho < 1) or (CodigoFilho > 9999) then
    raise Exception.Create('Código de centro de custo filho inválido.');

  FCodigoPai := CodigoPai;
  FCodigoFilho := CodigoFilho;
  FIdOrcamento := IdOrcamento;
  FLancamentos := TObjectList<TLancamento>.Create;
end;

constructor TCentroCusto.Create(const CodigoPai, CodigoFilho: Integer);
begin
  Create(CodigoPai, CodigoFilho, 0);
end;

destructor TCentroCusto.Destroy;
begin
  FLancamentos.Free;
  inherited;
end;

procedure TCentroCusto.AdicionarLancamento(const Lancamento: TLancamento);
begin
  FLancamentos.Add(Lancamento);
end;

function TCentroCusto.GetCodigoCompleto: string;
begin
  Result := Format('%.2d%.4d', [FCodigoPai, FCodigoFilho]);
end;

function TCentroCusto.GetValorTotal: Real;
var
  Lancamento: TLancamento;
begin
  Result := 0;
  for Lancamento in FLancamentos do
    Result := Result + Lancamento.Valor;
end;

end.

