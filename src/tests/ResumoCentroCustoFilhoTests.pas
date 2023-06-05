unit ResumoCentroCustoFilhoTests;

interface

uses
  DUnitX.TestFramework,
  CentroCustoModel,
  ResumoCentroCustoFilho,
  LancamentoModel;

type
  [TestFixture]
  TResumoCentroCustoFilhoTests = class(TObject)
  public
    [Test]
    procedure Atualizar_DeveIncrementarOValorResumo;
    [Test]
    procedure Atualizar_ComMultiplosLancamentos_DeveSomarValores;
    [Test]
    procedure Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveIgnorarCentrosCustosDiferentes;
  end;

implementation

procedure TResumoCentroCustoFilhoTests.Atualizar_DeveIncrementarOValorResumo;
var
  Resumo: TResumoCentroCustoFilho;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoCentroCustoFilho.Create;
  CentroCusto := TCentroCusto.Create(1, 2000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 2000, 1, 100.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(100.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoCentroCustoFilhoTests.Atualizar_ComMultiplosLancamentos_DeveSomarValores;
var
  Resumo: TResumoCentroCustoFilho;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoCentroCustoFilho.Create;
  CentroCusto := TCentroCusto.Create(1, 2000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 2000, 1, 100.0));
  CentroCusto.AdicionarLancamento(TLancamento.Create(2, 1, 2000, 1, 200.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(300.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoCentroCustoFilhoTests.Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveIgnorarCentrosCustosDiferentes;
var
  Resumo: TResumoCentroCustoFilho;
  CentroCusto1, CentroCusto2: TCentroCusto;
begin
  Resumo := TResumoCentroCustoFilho.Create;
  CentroCusto1 := TCentroCusto.Create(1, 2000, 1);
  CentroCusto2 := TCentroCusto.Create(1, 3000, 1);
  CentroCusto1.AdicionarLancamento(TLancamento.Create(1, 1, 2000, 1, 100.0));
  CentroCusto2.AdicionarLancamento(TLancamento.Create(2, 1, 3000, 1, 200.0));

  Resumo.Atualizar(CentroCusto1);

  Assert.AreEqual(100.0, Resumo.Resumo, 0.001);

  CentroCusto1.Free;
  CentroCusto2.Free;
  Resumo.Free;
end;

end.

