unit ResumoCentroCustoPai;

interface

uses
  CentroCustoModel,
  ResumoObserverIntf;

type
  TResumoCentroCustoPai = class(TInterfacedObject, IResumoObserver)
  private
    FResumo: Real;
  public
    procedure Atualizar(const centroCusto: TCentroCusto);
    property Resumo: Real read FResumo;
  end;

implementation

procedure TResumoCentroCustoPai.Atualizar(const centroCusto: TCentroCusto);
begin
  FResumo := FResumo + centroCusto.GetValorTotal;
end;

end.
