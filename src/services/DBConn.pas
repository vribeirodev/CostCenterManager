unit DBConn;

interface

uses
  FireDAC.DApt,
  FireDAC.Phys.FB,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Error,
  FireDAC.Stan.Async,
  System.IOUtils,
  System.SysUtils,
  LogUtils,
  DBConfig;

type
  TDBConn = class
  private
    class var FDBConfig: TDBConfig;
  public
    class procedure SetConfig(const aDBConfig: TDBConfig);
    class function CreateConnection: TFDConnection;
  end;

implementation

class procedure TDBConn.SetConfig(const aDBConfig: TDBConfig);
begin
  FDBConfig := aDBConfig;
end;

class function TDBConn.CreateConnection: TFDConnection;
const
  FBCLIENT_DLL = 'fbclient.dll';
var
  FBDriverLink: TFDPhysFBDriverLink;
begin
  if FDBConfig = nil then
    raise Exception.Create('DB Config não configurado');

  FBDriverLink := TFDPhysFBDriverLink.Create(nil);
  try
    FBDriverLink.VendorLib := FBCLIENT_DLL;

    Result := TFDConnection.Create(nil);
    Result.Params.Clear;
    Result.Params.DriverID := 'FB';

    Result.Params.Database := FDBConfig.Database;
    Result.Params.UserName := FDBConfig.Username;
    Result.Params.Password := FDBConfig.Password;
    Result.Params.Add('Server=' + FDBConfig.Server);
    Result.Params.Add('Port=' + FDBConfig.Port);
    Result.Params.Add('Protocol=TCPIP');

    Result.Params.Add('POOLING=true');
    Result.Params.Add('POOL_MAXIMUM_ITEMS=50');
    Result.Params.Add('POOL_CLEANUP_TIMEOUT=60');
    Result.Params.Add('POOL_EXPIRE_TIMEOUT=120');

  finally
    FBDriverLink.Free;
  end;
end;

end.
