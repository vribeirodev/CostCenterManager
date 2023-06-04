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
    [Test]
    procedure TestAdicionarLancamentoInvalido;
    [Test]
    [TestCase('Test1','0,1000')]
    [TestCase('Test2','100,1000')]
    [TestCase('Test3','1,999')]
    [TestCase('Test4','1,10000')]
    [ExpectedException('Exception')]
    procedure TestInvalidCentroCusto(const CodigoPai, CodigoFilho: Integer);
  end;

implementation

procedure TCentroCustoModelTests.TestCreateCentroCusto;
var
  CentroCusto: TCentroCusto;
begin
  CentroCusto := TCentroCusto.Create(10, 2000);
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
  CentroCusto := TCentroCusto.Create(10, 2000);
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
  CentroCusto := TCentroCusto.Create(10, 2000);
  try
    Lancamento1 := TLancamento.Create(1, 10, 2000, 3000.00);
    Lancamento2 := TLancamento.Create(2, 10, 2000, 5000.00);
    CentroCusto.AdicionarLancamento(Lancamento1);
    CentroCusto.AdicionarLancamento(Lancamento2);
    ValorTotal := 8000.00; // 3000 + 5000
    Assert.AreEqual(ValorTotal, CentroCusto.GetValorTotal);
  finally
    CentroCusto.Free;
  end;
end;

procedure TCentroCustoModelTests.TestAdicionarLancamentoInvalido;
var
  CentroCusto: TCentroCusto;
  LancamentoInvalido: TLancamento;
begin
  CentroCusto := TCentroCusto.Create(10, 2000);
  try
    LancamentoInvalido := TLancamento.Create(1, 11, 2001, 1000.00);
    Assert.WillRaise(procedure begin
      CentroCusto.AdicionarLancamento(LancamentoInvalido);
    end, Exception);
  finally
    CentroCusto.Free;
  end;
end;

procedure TCentroCustoModelTests.TestInvalidCentroCusto(const CodigoPai, CodigoFilho: Integer);
begin
  Assert.WillRaise(procedure begin
    TCentroCusto.Create(CodigoPai, CodigoFilho);
  end, Exception);
end;

initialization
  TDUnitX.RegisterTestFixture(TCentroCustoModelTests);

end.

