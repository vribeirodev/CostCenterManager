unit FDQueryFactory;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  DBConn;

type
  TFDQueryFactory = class
  public
    class function CreateQuery: TFDQuery;
  end;

implementation

{ TFDQueryFactory }

class function TFDQueryFactory.CreateQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := TDBConn.CreateConnection;
end;

end.

