unit LancamentoDAOTests;

interface

uses
  TestFramework,
  LancamentoDAO,
  LancamentoModel,
  System.SysUtils,
  LancamentoDAOIntf,
  DBConn,
  DbConfig;

type
  TLancamentoDAOTest = class(TTestCase)
  private
    DBConfig: TDBConfig;
    FLancamentoDAO: ILancamentoDAO;
    FLancamento: TLancamento;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestInsertAndSelect;
    procedure TestUpdate;
    procedure TestDelete;
  end;

implementation

procedure TLancamentoDAOTest.SetUp;
begin
    DBConfig := TDBConfig.Create('C:\Users\Vinicius Ribeiro\Documents\Projetos\CostCenterManager\database\DATABASE.FDB',
                                 'sysdba',
                                 'masterkey',
                                 'localhost',
                                 '3050');

  TDBConn.SetConfig(DBConfig);

  FLancamentoDAO := TLancamentoDAO.Create;
  FLancamento := TLancamento.Create(1, 10, 1001, 1, 100.0);
end;

procedure TLancamentoDAOTest.TearDown;
begin
  FLancamento.Free;
end;

procedure TLancamentoDAOTest.TestInsertAndSelect;
var
  Id: Integer;
  SelectedLancamento: TLancamento;
begin
  Id := FLancamentoDAO.Insert(FLancamento);
  SelectedLancamento := FLancamentoDAO.Select(Id);

  CheckNotNull(SelectedLancamento, 'Selected Lancamento is null');
  CheckEquals(FLancamento.Id, SelectedLancamento.Id, 'Selected Lancamento has wrong Id');
  CheckEquals(FLancamento.CodigoPai, SelectedLancamento.CodigoPai, 'Selected Lancamento has wrong CodigoPai');
  CheckEquals(FLancamento.CodigoFilho, SelectedLancamento.CodigoFilho, 'Selected Lancamento has wrong CodigoFilho');
  CheckEquals(FLancamento.Valor, SelectedLancamento.Valor, 0.01, 'Selected Lancamento has wrong Valor');
end;

procedure TLancamentoDAOTest.TestUpdate;
var
  IsUpdated: Boolean;
begin
  FLancamentoDAO.Insert(FLancamento);
  FLancamento.Valor := 200.0;

  IsUpdated := FLancamentoDAO.Update(FLancamento);

  CheckTrue(IsUpdated, 'Lancamento was not updated');
end;

procedure TLancamentoDAOTest.TestDelete;
var
  IsDeleted: Boolean;
begin
  FLancamentoDAO.Insert(FLancamento);

  IsDeleted := FLancamentoDAO.Delete(FLancamento);

  CheckTrue(IsDeleted, 'Lancamento was not deleted');
end;

initialization
  RegisterTest(TLancamentoDAOTest.Suite);

end.

