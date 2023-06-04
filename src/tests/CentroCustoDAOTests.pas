unit CentroCustoDAOTests;

interface

uses
  DUnitX.TestFramework,
  CentroCustoModel,
  CentroCustoDAO,
  System.Generics.Collections,
  DBConn,
  DBConfig;

type

  [TestFixture]
  TCentroCustoDAOTest = class(TObject)
  private
    FCentroCustoDAO: TCentroCustoDAO;
    FCentroCusto: TCentroCusto;
    DBConfig: TDBConfig;
  public
    [Setup]
    procedure SetUp;
    [TearDown]
    procedure TearDown;
  published
    [Test]
    procedure TestInsertAndSelect;
    [Test]
    procedure TestUpdate;
    [Test]
    procedure TestDelete;
    [Test]
    procedure TestGetAll;
  end;

implementation

procedure TCentroCustoDAOTest.SetUp;
begin
  DBConfig := TDBConfig.Create('C:\Users\Vinicius Ribeiro\Documents\Projetos\CostCenterManager\database\DATABASE.FDB',
                                 'sysdba',
                                 'masterkey',
                                 'localhost',
                                 '3050');

  TDBConn.SetConfig(DBConfig);

  FCentroCustoDAO := TCentroCustoDAO.Create;

  // Cria alguns registros de teste
  FCentroCustoDAO.Insert(TCentroCusto.Create(10, 2000));
  FCentroCustoDAO.Insert(TCentroCusto.Create(20, 3000));
  FCentroCustoDAO.Insert(TCentroCusto.Create(30, 4000));

  FCentroCusto := TCentroCusto.Create(40, 2000);
end;



procedure TCentroCustoDAOTest.TearDown;
begin
  // Remove registros de teste
  FCentroCustoDAO.Delete(TCentroCusto.Create(10, 2000));
  FCentroCustoDAO.Delete(TCentroCusto.Create(20, 3000));
  FCentroCustoDAO.Delete(TCentroCusto.Create(30, 4000));

  FCentroCustoDAO.Free;
  FCentroCusto.Free;
  DBConfig.Free;
end;


procedure TCentroCustoDAOTest.TestInsertAndSelect;
var
  NewCentroCusto: TCentroCusto;
begin
  // Test Insert
  Assert.IsTrue(FCentroCustoDAO.Insert(FCentroCusto), 'Failed on Insert');

  // Test Select
  NewCentroCusto := FCentroCustoDAO.Select(FCentroCusto.CodigoPai, FCentroCusto.CodigoFilho);
  try
    Assert.IsNotNull(NewCentroCusto, 'Failed on Select');
    Assert.AreEqual(FCentroCusto.CodigoPai, NewCentroCusto.CodigoPai, 'CodigoPai does not match');
    Assert.AreEqual(FCentroCusto.CodigoFilho, NewCentroCusto.CodigoFilho, 'CodigoFilho does not match');
  finally
    NewCentroCusto.Free;
  end;
end;

procedure TCentroCustoDAOTest.TestUpdate;
begin
  Assert.IsTrue(FCentroCustoDAO.Update(FCentroCusto), 'Failed on Update');
end;

procedure TCentroCustoDAOTest.TestDelete;
begin
  Assert.IsTrue(FCentroCustoDAO.Delete(FCentroCusto), 'Failed on Delete');
end;

procedure TCentroCustoDAOTest.TestGetAll;
var
  CentroCustos: TObjectList<TCentroCusto>;
begin
  CentroCustos := FCentroCustoDAO.GetAll;
  try
    Assert.IsTrue(CentroCustos.Count > 0, 'No CentroCustos found');
  finally
    CentroCustos.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TCentroCustoDAOTest);

end.

