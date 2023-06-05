unit OrcamentoDAO;

interface

uses
  OrcamentoModel,
  OrcamentoDAOIntf,
  FDQueryFactory,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  System.SysUtils,
  System.Generics.Collections;

const
  SQL_INSERT_ORCAMENTO = 'INSERT INTO "ORCAMENTO" DEFAULT VALUES RETURNING "ID", "DATA_ORCAMENTO"';
  SQL_UPDATE_ORCAMENTO = 'UPDATE "ORCAMENTO" SET "DATA_ORCAMENTO" = :DATA_ORCAMENTO WHERE "ID" = :ID';
  SQL_DELETE_ORCAMENTO = 'DELETE FROM "ORCAMENTO" WHERE "ID" = :ID';
  SQL_SELECT_ORCAMENTO = 'SELECT "ID", "DATA_ORCAMENTO" FROM "ORCAMENTO" WHERE "ID" = :ID';
  SQL_SELECT_ALL_ORCAMENTOS = 'SELECT "ID", "DATA_ORCAMENTO" FROM "ORCAMENTO"';

type
   TOrcamentoDAO = class(TInterfacedObject, IOrcamentoDAO)
  private
    function OrcamentoFromQuery(Query: TFDQuery): TOrcamentoModel;
  public
    function Insert: TOrcamentoModel;
    function Delete(Orcamento: TOrcamentoModel): Boolean;
    function Select(OrcamentoID: Integer): TOrcamentoModel;
    function GetAll: TObjectList<TOrcamentoModel>;
  end;

implementation

function TOrcamentoDAO.OrcamentoFromQuery(Query: TFDQuery): TOrcamentoModel;
begin
  Result := TOrcamentoModel.Create;
  Result.Id := Query.FieldByName('ID').AsInteger;
  Result.DataOrcamento := Query.FieldByName('DATA_ORCAMENTO').AsDateTime;
end;

function TOrcamentoDAO.Insert: TOrcamentoModel;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_INSERT_ORCAMENTO;
    Query.Open;
    Result := OrcamentoFromQuery(Query);
  finally
    Query.Free;
  end;
end;


function TOrcamentoDAO.Delete(Orcamento: TOrcamentoModel): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_DELETE_ORCAMENTO;
    Query.ParamByName('ID').AsInteger := Orcamento.Id;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TOrcamentoDAO.Select(OrcamentoID: Integer): TOrcamentoModel;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_ORCAMENTO;
    Query.ParamByName('ID').AsInteger := OrcamentoID;
    Query.Open;
    if not Query.Eof then
      Result := OrcamentoFromQuery(Query)
    else
      Result := TOrcamentoModel.Create;
  finally
    Query.Free;
  end;
end;

function TOrcamentoDAO.GetAll: TObjectList<TOrcamentoModel>;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_ALL_ORCAMENTOS;
    Query.Open;
    Result := TObjectList<TOrcamentoModel>.Create;
    while not Query.Eof do
    begin
      Result.Add(OrcamentoFromQuery(Query));
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

end.

