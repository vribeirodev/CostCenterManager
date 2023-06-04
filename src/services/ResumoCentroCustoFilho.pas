unit ResumoCentroCustoFilho;

interface

uses
  CentroCustoModel,
  ResumoObserverIntf;

type
  TResumoCentroCustoFilho = class(TInterfacedObject, IResumoObserver)
  private
    FResumo: Real;
  public
    procedure Atualizar(const centroCusto: TCentroCusto);
    property Resumo: Real read FResumo;
  end;


implementation

procedure TResumoCentroCustoFilho.Atualizar(const centroCusto: TCentroCusto);
begin
  FResumo := FResumo + centroCusto.GetValorTotal;
end;


end.
