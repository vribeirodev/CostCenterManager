unit CentroCustoModelTests;

interface

uses
  DUnitX.TestFramework,
  CentroCustoModel,
  LancamentoModel,
  System.SysUtils;

type

  [TestFixture]
  TCentroCustoModelTests = class(TObject)
  public
    [Test]
    procedure TestCreateCentroCusto;
    [Test]
    procedure TestGetCodigoCompleto;
    [Test]
    procedure TestGetValorTotal;
  end;

implementation

procedure TCentroCustoModelTests.TestCreateCentroCusto;
var
  CentroCusto: TCentroCusto;
begin
  CentroCusto := TCentroCusto.Create(10, 2000, 1001);  // Incluiu o campo IdOrcamento
  try
    Assert.IsNotNull(CentroCusto);
  finally
    CentroCusto.Free;
  end;
end;

procedure TCentroCustoModelTests.TestGetCodigoCompleto;
var
  CentroCusto: TCentroCusto;
  CodigoCompleto: string;
begin
  CentroCusto := TCentroCusto.Create(10, 2000, 1001);  // Incluiu o campo IdOrcamento
  try
    CodigoCompleto := '102000';
    Assert.AreEqual(CodigoCompleto, CentroCusto.GetCodigoCompleto);
  finally
    CentroCusto.Free;
  end;
end;

procedure TCentroCustoModelTests.TestGetValorTotal;
var
  CentroCusto: TCentroCusto;
  Lancamento1, Lancamento2: TLancamento;
  ValorTotal: Real;
begin
  CentroCusto := TCentroCusto.Create(10, 2000, 1001);  // Incluiu o campo IdOrcamento
  try
    Lancamento1 := TLancamento.Create(1, 10, 2000, 1, 3000.00);
    Lancamento2 := TLancamento.Create(2, 10, 2000, 1, 5000.00);
    CentroCusto.AdicionarLancamento(Lancamento1);
    CentroCusto.AdicionarLancamento(Lancamento2);
    ValorTotal := 8000.00; // 3000 + 5000
    Assert.AreEqual(ValorTotal, CentroCusto.GetValorTotal);
  finally
    CentroCusto.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TCentroCustoModelTests);

end.

