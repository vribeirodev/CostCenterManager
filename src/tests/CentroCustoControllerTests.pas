unit CentroCustoControllerTests;

interface

uses
  DUnitX.TestFramework,
  Delphi.Mocks,
  CentroCustoModel,
  CentroCustoController,
  CentroCustoDAOIntf;

type
  [TestFixture]
  TCentroCustoControllerTests = class(TObject)
  private
    FCentroCustoController: TCentroCustoController;
    FCentroCustoDAOMock: TMock<ICentroCustoDAO>;
    TestCentroCusto: TCentroCusto;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Insert_WhenCalled_ShouldReturnTrue;

    [Test]
    procedure Update_WhenCalled_ShouldReturnTrue;

    [Test]
    procedure Delete_WhenCalled_ShouldReturnTrue;
  end;

implementation

procedure TCentroCustoControllerTests.Setup;
begin
  FCentroCustoDAOMock := TMock<ICentroCustoDAO>.Create;


  TestCentroCusto := TCentroCusto.Create(1, 1000, 1);

  // Configurar o mock para retornar os valores esperados
  FCentroCustoDAOMock.Setup.WillReturn(True).When.Insert(TestCentroCusto);
  FCentroCustoDAOMock.Setup.WillReturn(True).When.Update(TestCentroCusto);
  FCentroCustoDAOMock.Setup.WillReturn(True).When.Delete(TestCentroCusto);

  FCentroCustoController := TCentroCustoController.Create(FCentroCustoDAOMock.Instance);
end;

procedure TCentroCustoControllerTests.TearDown;
begin
  FCentroCustoController.Free;
  FCentroCustoDAOMock.Free;
  TestCentroCusto.Free;
end;

procedure TCentroCustoControllerTests.Insert_WhenCalled_ShouldReturnTrue;
begin
  Assert.IsTrue(FCentroCustoController.Insert(TestCentroCusto));
end;

procedure TCentroCustoControllerTests.Update_WhenCalled_ShouldReturnTrue;
begin
  Assert.IsTrue(FCentroCustoController.Update(TestCentroCusto));
end;

procedure TCentroCustoControllerTests.Delete_WhenCalled_ShouldReturnTrue;
begin
  Assert.IsTrue(FCentroCustoController.Delete(TestCentroCusto));
end;

initialization
  TDUnitX.RegisterTestFixture(TCentroCustoControllerTests);

end.

