unit UserDAO;

interface

uses
  UserModel,
  UserDAOIntf,
  FDQueryFactory,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  System.SysUtils,
  System.Generics.Collections;

const
  SQL_INSERT_USER = 'INSERT INTO "User" ("Username", "Password") VALUES (:Username, :Password) RETURNING "UserID"';
  SQL_UPDATE_USER = 'UPDATE "User" SET "Username" = :Username, "Password" = :Password WHERE "UserID" = :UserID';
  SQL_DELETE_USER = 'DELETE FROM "User" WHERE "UserID" = :UserID';
  SQL_SELECT_USER = 'SELECT "UserID", "Username", "Password" FROM "User" WHERE "UserID" = :UserID';
  SQL_SELECT_ALL_USERS = 'SELECT "UserID", "Username", "Password" FROM "User"';
  SQL_SELECT_USER_BY_USERNAME = 'SELECT "UserID", "Username", "Password" FROM "User" WHERE "Username" = :Username';

type
   TUserDAO = class(TInterfacedObject, IUserDAO)
  private
    function UserFromQuery(Query: TFDQuery): TUser;
  public
    function Insert(User: TUser): Integer;
    function Update(User: TUser): Boolean;
    function Delete(User: TUser): Boolean;
    function Select(UserID: Integer): TUser;
    function SelectByUsername(const Username: string): TUser;
    function GetAll: TObjectList<TUser>;
  end;

implementation

function TUserDAO.Insert(User: TUser): Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.Connection.StartTransaction;
    try
      Query.SQL.Text := SQL_INSERT_USER;
      Query.ParamByName('Username').AsString := User.Username;
      Query.ParamByName('Password').AsString := User.Password;
      Query.Open;
      Result := Query.Fields[0].AsInteger;
      Query.Connection.Commit;
    except
      on E: Exception do
      begin
        Query.Connection.Rollback;
        raise Exception.Create('Erro ao inserir o usuário: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TUserDAO.Update(User: TUser): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.Connection.StartTransaction;
    try
      Query.SQL.Text := SQL_UPDATE_USER;
      Query.ParamByName('Username').AsString := User.Username;
      Query.ParamByName('Password').AsString := User.Password;
      Query.ParamByName('UserID').AsInteger := User.UserID;
      Query.ExecSQL;
      Query.Connection.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Connection.Rollback;
        raise Exception.Create('Erro ao atualizar o usuário: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TUserDAO.Delete(User: TUser): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.Connection.StartTransaction;
    try
      Query.SQL.Text := SQL_DELETE_USER;
      Query.ParamByName('UserID').AsInteger := User.UserID;
      Query.ExecSQL;
      Query.Connection.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Connection.Rollback;
        raise Exception.Create('Erro ao deletar o usuário: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TUserDAO.Select(UserID: Integer): TUser;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    try
      Query.SQL.Text := SQL_SELECT_USER;
      Query.ParamByName('UserID').AsInteger := UserID;
      Query.Open;
      if not Query.Eof then
        Result := UserFromQuery(Query)
      else
        Result := nil;
    except
      on E: Exception do
        raise Exception.Create('Erro ao buscar o usuário: ' + E.Message);
    end;
  finally
    Query.Free;
  end;
end;

function TUserDAO.SelectByUsername(const Username: string): TUser;
var
  Query: TFDQuery;
begin
  Query := TFDQueryFactory.CreateQuery;
  try
    try
      Query.SQL.Text := SQL_SELECT_USER_BY_USERNAME;
      Query.ParamByName('Username').AsString := Username;
      Query.Open;
      if not Query.Eof then
        Result := UserFromQuery(Query)
      else
        Result := nil;
    except
      on E: Exception do
        raise Exception.Create('Erro ao buscar o usuário: ' + E.Message);
    end;
  finally
    Query.Free;
  end;
end;

function TUserDAO.GetAll: TObjectList<TUser>;
var
  Query: TFDQuery;
  Users: TObjectList<TUser>;
begin
  Users := TObjectList<TUser>.Create;
  Query := TFDQueryFactory.CreateQuery;
  try
    Query.SQL.Text := SQL_SELECT_ALL_USERS;
    Query.Open;
    while not Query.Eof do
    begin
      Users.Add(UserFromQuery(Query));
      Query.Next;
    end;
  finally
    Query.Free;
  end;
  Result := Users;
end;

function TUserDAO.UserFromQuery(Query: TFDQuery): TUser;
begin
  Result := TUser.Create(Query.FieldByName('Username').AsString,
                         Query.FieldByName('Password').AsString,
                         Query.FieldByName('UserID').AsInteger);
end;

end.

