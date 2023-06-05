unit ResumoValorTotalTests;

interface

uses
  DUnitX.TestFramework,
  CentroCustoModel,
  ResumoValorTotal,
  LancamentoModel;

type
  [TestFixture]
  TResumoValorTotalTests = class(TObject)
  public
    [Test]
    procedure Atualizar_DeveIncrementarOValorResumo;
    [Test]
    procedure Atualizar_ComMultiplosLancamentos_DeveSomarValores;
    [Test]
    procedure Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveSomarValores;
  end;

implementation

procedure TResumoValorTotalTests.Atualizar_DeveIncrementarOValorResumo;
var
  Resumo: TResumoValorTotal;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoValorTotal.Create;
  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(50.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoValorTotalTests.Atualizar_ComMultiplosLancamentos_DeveSomarValores;
var
  Resumo: TResumoValorTotal;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoValorTotal.Create;
  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));
  CentroCusto.AdicionarLancamento(TLancamento.Create(2, 1, 1000, 1, 70.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(120.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoValorTotalTests.Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveSomarValores;
var
  Resumo: TResumoValorTotal;
  CentroCusto1, CentroCusto2: TCentroCusto;
begin
  Resumo := TResumoValorTotal.Create;
  CentroCusto1 := TCentroCusto.Create(1, 1000, 1);
  CentroCusto2 := TCentroCusto.Create(2, 2000, 1);
  CentroCusto1.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));
  CentroCusto2.AdicionarLancamento(TLancamento.Create(2, 2, 2000, 1, 70.0));

  Resumo.Atualizar(CentroCusto1);
  Resumo.Atualizar(CentroCusto2);

  Assert.AreEqual(120.0, Resumo.Resumo, 0.001);

  CentroCusto1.Free;
  CentroCusto2.Free;
  Resumo.Free;
end;

end.

