unit Orcamento;

interface

uses
  ResumoObserverIntf,
  CentroCustoModel,
  System.Generics.Collections;

type
  TOrcamento = class
  private
    FObservadores: TList<IResumoObserver>;
    FCentrosCustos: TDictionary<string, TCentroCusto>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarCentroCusto(const centroCusto: TCentroCusto);
    procedure AdicionarObservador(const observador: IResumoObserver);
    procedure Notificar(const centroCusto: TCentroCusto);
    procedure ClearCentrosCustos;
    procedure AddCentrosCustos(const Value: TDictionary<string, TCentroCusto>);

    property Observadores: TList<IResumoObserver> read FObservadores;
    property CentrosCustos: TDictionary<string, TCentroCusto> read FCentrosCustos;
  end;

implementation

constructor TOrcamento.Create;
begin
  FObservadores := TList<IResumoObserver>.Create;
  FCentrosCustos := TDictionary<string, TCentroCusto>.Create;
end;

destructor TOrcamento.Destroy;
begin
  FObservadores.Free;
  FCentrosCustos.Free;
end;

procedure TOrcamento.AdicionarCentroCusto(const centroCusto: TCentroCusto);
begin
  FCentrosCustos.Add(centroCusto.GetCodigoCompleto, centroCusto);
  Notificar(centroCusto);
end;

procedure TOrcamento.AdicionarObservador(const observador: IResumoObserver);
begin
  FObservadores.Add(observador);
end;

procedure TOrcamento.Notificar(const centroCusto: TCentroCusto);
var
  Observador: IResumoObserver;
begin
  for Observador in FObservadores do
    Observador.Atualizar(centroCusto);
end;

procedure TOrcamento.ClearCentrosCustos;
begin
  FCentrosCustos.Clear;
end;

procedure TOrcamento.AddCentrosCustos(const Value: TDictionary<string, TCentroCusto>);
var
  Pair: TPair<string, TCentroCusto>;
begin
  for Pair in Value do
    FCentrosCustos.Add(Pair.Key, Pair.Value);
end;


end.
