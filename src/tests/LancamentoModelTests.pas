unit LancamentoModelTests;

interface

uses
  DUnitX.TestFramework,
  LancamentoModel,
  System.SysUtils;

type
  [TestFixture]
  TTestLancamentoModel = class(TObject)
  public
    [Test]
    procedure TestCreateLancamento;
    [Test]
    [TestCase('Test1','50, 2000, 1, 1000')]
    [TestCase('Test2','99, 9999, 1, 5000')]
    procedure TestValidValues(const ACodigoPai, ACodigoFilho, AIDOrcamento: Integer; const AValor: Real);
    [Test]
    [TestCase('Test1','1, 50, 2000, 1, -1000')]
    [TestCase('Test2','1, -50, 2000, 1, 1000')]
    [TestCase('Test3','1, 50, -2000, 1, 1000')]
    procedure TestInvalidValues(const AId, ACodigoPai, ACodigoFilho, AIDOrcamento: Integer; const AValor: Real);

  end;

implementation

procedure TTestLancamentoModel.TestCreateLancamento;
var
  Lancamento: TLancamento;
begin
  Lancamento := TLancamento.Create(1, 50, 2000, 1000);
  try
    Assert.IsNotNull(Lancamento);
  finally
    Lancamento.Free;
  end;
end;

procedure TTestLancamentoModel.TestValidValues(const ACodigoPai, ACodigoFilho, AIDOrcamento: Integer; const AValor: Real);
var
  Lancamento: TLancamento;
begin
  Lancamento := TLancamento.Create(ACodigoPai, ACodigoFilho, AValor, AIDOrcamento);
  try
    Assert.AreEqual(ACodigoPai, Lancamento.CodigoPai);
    Assert.AreEqual(ACodigoFilho, Lancamento.CodigoFilho);
    Assert.AreEqual(AValor, Lancamento.Valor);
    Assert.AreEqual(0, Lancamento.IdOrcamento); // Mudança aqui
  finally
    Lancamento.Free;
  end;
end;

procedure TTestLancamentoModel.TestInvalidValues(const AId, ACodigoPai, ACodigoFilho, AIDOrcamento: Integer; const AValor: Real);
begin
  Assert.WillRaise(
    procedure
    begin
      TLancamento.Create(AId, ACodigoPai, ACodigoFilho, AIDOrcamento, AValor);
    end, Exception, 'Deve lançar exceção quando os valores são inválidos');
end;


initialization
  TDUnitX.RegisterTestFixture(TTestLancamentoModel);
end.

