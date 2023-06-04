unit LancamentoDAO;

interface

uses
  LancamentoModel,
  LancamentoDAOIntf,
  FDQueryFactory,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  System.SysUtils,
  System.Generics.Collections;

const
  SQL_INSERT_LANCAMENTO = 'INSERT INTO "LANCAMENTO" ("CODIGO_PAI", "CODIGO_FILHO", "VALOR") VALUES (:CodigoPai, :CodigoFilho, :Valor) RETURNING "ID"';
  SQL_UPDATE_LANCAMENTO = 'UPDATE "LANCAMENTO" SET "CODIGO_PAI" = :CodigoPai, "CODIGO_FILHO" = :CodigoFilho, "VALOR" = :Valor WHERE "ID" = :LancamentoID';
  SQL_DELETE_LANCAMENTO = 'DELETE FROM "LANCAMENTO" WHERE "ID" = :LancamentoID';
  SQL_SELECT_LANCAMENTO = 'SELECT "ID", "CODIGO_PAI", "CODIGO_FILHO", "VALOR" FROM "LANCAMENTO" WHERE "ID" = :LancamentoID';
  SQL_SELECT_ALL_LANCAMENTOS = 'SELECT "ID", "CODIGO_PAI", "CODIGO_FILHO", "VALOR" FROM "LANCAMENTO"';

type
   TLancamentoDAO = class(TInterfacedObject, ILancamentoDAO)
  private
    function LancamentoFromQuery(Query: TFDQuery): TLancamento;
  public
    function Insert(Lancamento: TLancamento): Integer;
    function Update(Lancamento: TLancamento): Boolean;
    function Delete(Lancamento: TLancamento): Boolean;
    function Select(LancamentoID: Integer): TLancamento;
    function GetAll: TObjectList<TLancamento>;
  end;

implementation

function TLancamentoDAO.LancamentoFromQuery(Query: TFDQuery): TLancamento;
begin
  Result := TLancamento.Create(
    Query.FieldByName('LancamentoID').AsInteger,
    Query.FieldByName('CodigoPai').AsInteger,
    Query.FieldByName('CodigoFilho').AsInteger,
    Query.FieldByName('Valor').AsFloat
  );
end;

function TLancamentoDAO.Insert(Lancamento: TLancamento): Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_INSERT_LANCAMENTO;
    Query.ParamByName('CodigoPai').AsInteger := Lancamento.CodigoPai;
    Query.ParamByName('CodigoFilho').AsInteger := Lancamento.CodigoFilho;
    Query.ParamByName('Valor').AsFloat := Lancamento.Valor;
    Query.Open;
    Result := Query.FieldByName('LancamentoID').AsInteger;
  finally
    Query.Free;
  end;
end;

function TLancamentoDAO.Update(Lancamento: TLancamento): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_UPDATE_LANCAMENTO;
    Query.ParamByName('CodigoPai').AsInteger := Lancamento.CodigoPai;
    Query.ParamByName('CodigoFilho').AsInteger := Lancamento.CodigoFilho;
    Query.ParamByName('Valor').AsFloat := Lancamento.Valor;
    Query.ParamByName('LancamentoID').AsInteger := Lancamento.Id;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
  finally
    Query.Free;
  end;
end;

function TLancamentoDAO.Delete(Lancamento: TLancamento): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_DELETE_LANCAMENTO;
    Query.ParamByName('LancamentoID').AsInteger := Lancamento.Id;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
  finally
    Query.Free;
  end;
end;

function TLancamentoDAO.Select(LancamentoID: Integer): TLancamento;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_LANCAMENTO;
    Query.ParamByName('LancamentoID').AsInteger := LancamentoID;
    Query.Open;
    if not Query.Eof then
      Result := LancamentoFromQuery(Query)
    else
      Result := nil;
  finally
    Query.Free;
  end;
end;

function TLancamentoDAO.GetAll: TObjectList<TLancamento>;
var
  Query: TFDQuery;
  Lancamento: TLancamento;
begin
  Result := TObjectList<TLancamento>.Create;
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_ALL_LANCAMENTOS;
    Query.Open;
    while not Query.Eof do
    begin
      Lancamento := LancamentoFromQuery(Query);
      Result.Add(Lancamento);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

end.

