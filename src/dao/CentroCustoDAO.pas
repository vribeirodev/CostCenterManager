unit CentroCustoDAO;

interface

uses
  CentroCustoModel,
  CentroCustoDAOIntf,
  FDQueryFactory,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  System.SysUtils,
  System.Generics.Collections;

const
  SQL_INSERT_CENTROCUSTO = 'INSERT INTO "CENTROCUSTO" ("CODIGO_PAI", "CODIGO_FILHO") VALUES (:CODIGO_PAI, :CODIGO_FILHO)';
  SQL_UPDATE_CENTROCUSTO = 'UPDATE "CENTROCUSTO" SET "CODIGO_PAI" = :CODIGO_PAI, "CODIGO_FILHO" = :CODIGO_FILHO WHERE "CODIGO_PAI" = :CODIGO_PAI AND "CODIGO_FILHO" = :CODIGO_FILHO';
  SQL_DELETE_CENTROCUSTO = 'DELETE FROM "CENTROCUSTO" WHERE "CODIGO_PAI" = :CODIGO_PAI AND "CODIGO_FILHO" = :CODIGO_FILHO';
  SQL_SELECT_CENTROCUSTO = 'SELECT "CODIGO_PAI", "CODIGO_FILHO" FROM "CENTROCUSTO" WHERE "CODIGO_PAI" = :CODIGO_PAI AND "CODIGO_FILHO" = :CODIGO_FILHO';
  SQL_SELECT_ALL_CENTROCUSTOS = 'SELECT "CODIGO_PAI", "CODIGO_FILHO" FROM "CENTROCUSTO"';

type
   TCentroCustoDAO = class(TInterfacedObject, ICentroCustoDAO)
  private
    function CentroCustoFromQuery(Query: TFDQuery): TCentroCusto;
  public
    function Insert(CentroCusto: TCentroCusto): Boolean;
    function Update(CentroCusto: TCentroCusto): Boolean;
    function Delete(CentroCusto: TCentroCusto): Boolean;
    function Select(CodigoPai: Integer; CodigoFilho: Integer): TCentroCusto;
    function GetAll: TObjectList<TCentroCusto>;
  end;

implementation

function TCentroCustoDAO.CentroCustoFromQuery(Query: TFDQuery): TCentroCusto;
begin
  Result := TCentroCusto.Create(
    Query.FieldByName('CODIGO_PAI').AsInteger,
    Query.FieldByName('CODIGO_FILHO').AsInteger
  );
end;

function TCentroCustoDAO.Insert(CentroCusto: TCentroCusto): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_INSERT_CENTROCUSTO;
    Query.ParamByName('CODIGO_PAI').AsInteger := CentroCusto.CodigoPai;
    Query.ParamByName('CODIGO_FILHO').AsInteger := CentroCusto.CodigoFilho;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
  finally
    Query.Free;
  end;
end;

function TCentroCustoDAO.Update(CentroCusto: TCentroCusto): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_UPDATE_CENTROCUSTO;
    Query.ParamByName('CODIGO_PAI').AsInteger := CentroCusto.CodigoPai;
    Query.ParamByName('CODIGO_FILHO').AsInteger := CentroCusto.CodigoFilho;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
  finally
    Query.Free;
  end;
end;

function TCentroCustoDAO.Delete(CentroCusto: TCentroCusto): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_DELETE_CENTROCUSTO;
    Query.ParamByName('CODIGO_PAI').AsInteger := CentroCusto.CodigoPai;
    Query.ParamByName('CODIGO_FILHO').AsInteger := CentroCusto.CodigoFilho;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
  finally
    Query.Free;
  end;
end;

function TCentroCustoDAO.Select(CodigoPai: Integer; CodigoFilho: Integer): TCentroCusto;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_CENTROCUSTO;
    Query.ParamByName('CODIGO_PAI').AsInteger := CodigoPai;
    Query.ParamByName('CODIGO_FILHO').AsInteger := CodigoFilho;
    Query.Open;
    if not Query.Eof then
      Result := CentroCustoFromQuery(Query)
    else
      Result := nil;
  finally
    Query.Free;
  end;
end;

function TCentroCustoDAO.GetAll: TObjectList<TCentroCusto>;
var
  Query: TFDQuery;
  CentroCusto: TCentroCusto;
begin
  Result := TObjectList<TCentroCusto>.Create;
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_ALL_CENTROCUSTOS;
    Query.Open;
    while not Query.Eof do
    begin
      CentroCusto := CentroCustoFromQuery(Query);
      Result.Add(CentroCusto);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

end.

