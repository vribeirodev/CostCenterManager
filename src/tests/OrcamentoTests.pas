unit OrcamentoTests;

interface

uses
  DUnitX.TestFramework,
  Orcamento,
  CentroCustoModel,
  ResumoObserverIntf,
  LancamentoModel,
  ResumoCentroCustoPai,
  ResumoCentroCustoFilho,
  ResumoValorTotal;

type

  [TestFixture]
  TOrcamentoTests = class(TObject)
  public
    [Test]
    procedure AdicionarCentroCusto_DeveAdicionarCentroCustoNaLista;

    [Test]
    procedure AdicionarObservador_DeveAdicionarObservadorNaLista;

    [Test]
    procedure Notificar_DeveAtualizarTodosObservadores;
  end;

implementation

procedure TOrcamentoTests.AdicionarCentroCusto_DeveAdicionarCentroCustoNaLista;
var
  Orcamento: TOrcamento;
  CentroCusto: TCentroCusto;
begin
  Orcamento := TOrcamento.Create;
  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));

  Orcamento.AdicionarCentroCusto(CentroCusto);

  Assert.AreEqual(1, Orcamento.CentrosCustos.Count);

  Orcamento.Free;
end;

procedure TOrcamentoTests.AdicionarObservador_DeveAdicionarObservadorNaLista;
var
  Orcamento: TOrcamento;
  Observador: IResumoObserver;
begin
  Orcamento := TOrcamento.Create;
  Observador := TResumoCentroCustoPai.Create;

  Orcamento.AdicionarObservador(Observador);

  Assert.AreEqual(1, Orcamento.Observadores.Count);

  Orcamento.Free;
end;

procedure TOrcamentoTests.Notificar_DeveAtualizarTodosObservadores;
var
  Orcamento: TOrcamento;
  Observador1: IResumoObserver;
  Observador2: IResumoObserver;
  CentroCusto: TCentroCusto;
begin
  Orcamento := TOrcamento.Create;
  Observador1 := TResumoCentroCustoPai.Create;
  Observador2 := TResumoCentroCustoFilho.Create;

  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));

  Orcamento.AdicionarObservador(Observador1);
  Orcamento.AdicionarObservador(Observador2);

  Orcamento.AdicionarCentroCusto(CentroCusto);

  Assert.AreEqual<Real>(50.0, (Observador1 as TResumoCentroCustoPai).Resumo);
  Assert.AreEqual<Real>(50.0, (Observador2 as TResumoCentroCustoFilho).Resumo);

  Orcamento.Free;
end;

end.

