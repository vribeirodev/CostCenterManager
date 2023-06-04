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
    [TestCase('Test1','1, 50, 2000, 1000')]
    [TestCase('Test2','2, 99, 9999, 5000')]
    procedure TestValidValues(const AId, ACodigoPai, ACodigoFilho: Integer; const AValor: Real);
    [Test]
    [TestCase('Test1','-1, 50, 2000, 1000')]
    [TestCase('Test2','1, -50, 2000, 1000')]
    [TestCase('Test3','1, 50, -2000, 1000')]
    [TestCase('Test4','1, 50, 2000, -1000')]
    procedure TestInvalidValues(const AId, ACodigoPai, ACodigoFilho: Integer; const AValor: Real);
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

procedure TTestLancamentoModel.TestValidValues(const AId, ACodigoPai, ACodigoFilho: Integer; const AValor: Real);
var
  Lancamento: TLancamento;
begin
  Lancamento := TLancamento.Create(AId, ACodigoPai, ACodigoFilho, AValor);
  try
    Assert.AreEqual(AId, Lancamento.Id);
    Assert.AreEqual(ACodigoPai, Lancamento.CodigoPai);
    Assert.AreEqual(ACodigoFilho, Lancamento.CodigoFilho);
    Assert.AreEqual(AValor, Lancamento.Valor);
  finally
    Lancamento.Free;
  end;
end;

procedure TTestLancamentoModel.TestInvalidValues(const AId, ACodigoPai, ACodigoFilho: Integer; const AValor: Real);
begin
  Assert.WillRaise(
    procedure
    begin
      TLancamento.Create(AId, ACodigoPai, ACodigoFilho, AValor);
    end, Exception, 'Deve lançar exceção quando os valores são inválidos');
end;


initialization
  TDUnitX.RegisterTestFixture(TTestLancamentoModel);
end.

