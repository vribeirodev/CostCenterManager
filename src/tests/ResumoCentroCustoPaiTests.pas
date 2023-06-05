unit ResumoCentroCustoPaiTests;

interface

uses
  DUnitX.TestFramework,
  CentroCustoModel,
  ResumoCentroCustoPai,
  LancamentoModel;

type
  [TestFixture]
  TResumoCentroCustoPaiTests = class(TObject)
  public
    [Test]
    procedure Atualizar_DeveIncrementarOValorResumo;
    [Test]
    procedure Atualizar_ComMultiplosLancamentos_DeveSomarValores;
    [Test]
    procedure Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveIgnorarCentrosCustosDiferentes;
  end;

implementation

procedure TResumoCentroCustoPaiTests.Atualizar_DeveIncrementarOValorResumo;
var
  Resumo: TResumoCentroCustoPai;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoCentroCustoPai.Create;
  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(50.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoCentroCustoPaiTests.Atualizar_ComMultiplosLancamentos_DeveSomarValores;
var
  Resumo: TResumoCentroCustoPai;
  CentroCusto: TCentroCusto;
begin
  Resumo := TResumoCentroCustoPai.Create;
  CentroCusto := TCentroCusto.Create(1, 1000, 1);
  CentroCusto.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));
  CentroCusto.AdicionarLancamento(TLancamento.Create(2, 1, 1000, 1, 75.0));

  Resumo.Atualizar(CentroCusto);

  Assert.AreEqual(125.0, Resumo.Resumo, 0.001);

  CentroCusto.Free;
  Resumo.Free;
end;

procedure TResumoCentroCustoPaiTests.Atualizar_ComLancamentosDeCentrosCustosDiferentes_DeveIgnorarCentrosCustosDiferentes;
var
  Resumo: TResumoCentroCustoPai;
  CentroCusto1, CentroCusto2: TCentroCusto;
begin
  Resumo := TResumoCentroCustoPai.Create;
  CentroCusto1 := TCentroCusto.Create(1, 1000, 1);
  CentroCusto2 := TCentroCusto.Create(2, 1000, 1);
  CentroCusto1.AdicionarLancamento(TLancamento.Create(1, 1, 1000, 1, 50.0));
  CentroCusto2.AdicionarLancamento(TLancamento.Create(2, 2, 1000, 1, 75.0));

  Resumo.Atualizar(CentroCusto1);

  Assert.AreEqual(50.0, Resumo.Resumo, 0.001);

  CentroCusto1.Free;
  CentroCusto2.Free;
  Resumo.Free;
end;

end.

