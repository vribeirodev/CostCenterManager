unit DBConfig;

interface

uses
  System.IOUtils,
  System.JSON;

type
  TDBConfig = class
  private
    FDatabase: string;
    FUsername: string;
    FPassword: string;
    FServer  : string;
    FPort    : string;
  public
    property Database: string read FDatabase write FDatabase;
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;
    property Server  : string read FServer   write FServer;
    property Port    : string read FPort     write FPort;

    constructor Create(const ADatabase, AUsername, APassword, AServer, APort: string);
    class function FromFile(const FileName: string): TDBConfig;
  end;

implementation

constructor TDBConfig.Create(const ADatabase, AUsername, APassword, AServer, APort: string);
begin
  FDatabase := ADatabase;
  FUsername := AUsername;
  FPassword := APassword;
  FServer   := AServer;
  FPort     := APort;
end;

class function TDBConfig.FromFile(const FileName: string): TDBConfig;
var
  JSONObj: TJSONObject;
begin
  Result := TDBConfig.Create('','','','','');

  if TFile.Exists(FileName) then
  begin
    JSONObj := TJSONObject.ParseJSONValue(TFile.ReadAllText(FileName)) as TJSONObject;
    try
      Result.Database := JSONObj.GetValue('database').Value;
      Result.Username := JSONObj.GetValue('username').Value;
      Result.Password := JSONObj.GetValue('password').Value;
      Result.Server   := JSONObj.GetValue('server').Value;
      Result.Port     := JSONObj.GetValue('port').Value;
    finally
      JSONObj.Free;
    end;
  end;
end;


end.

