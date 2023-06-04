unit ResumoValorTotal;

interface

uses
  CentroCustoModel,
  ResumoObserverIntf;

type
  TResumoValorTotal = class(TInterfacedObject, IResumoObserver)
  private
    FResumo: Real;
  public
    procedure Atualizar(const centroCusto: TCentroCusto);
    property Resumo: Real read FResumo;
  end;


implementation

procedure TResumoValorTotal.Atualizar(const centroCusto: TCentroCusto);
begin
  FResumo := FResumo + centroCusto.GetValorTotal;
end;

end.
