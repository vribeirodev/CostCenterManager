unit DBConn;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  System.IOUtils,
  System.SysUtils,
  LogUtils,
  DBConfig;

type
  TDBConn = class
  private
    class var FConn: TFDConnection;
    class constructor Create;
    class destructor Destroy;
  public
    class procedure ConfigurarConexao(const aDBConfig: TDBConfig);
    class function GetInstance: TFDConnection;
  end;
implementation

class constructor TDBConn.Create;
begin
  FConn := TFDConnection.Create(nil);
end;

class destructor TDBConn.Destroy;
begin
  if FConn.Connected then
    FConn.Close;
  FConn.Free;
end;

class procedure TDBConn.ConfigurarConexao(const aDBConfig: TDBConfig);
const
  FBCLIENT_DLL = 'fbclient.dll';
var
  FBDriverLink: TFDPhysFBDriverLink;
begin
  FBDriverLink:= TFDPhysFBDriverLink.Create(nil);

  try
    FBDriverLink.VendorLib := FBCLIENT_DLL;

    FConn.Params.Clear;
    FConn.Params.DriverID := 'FB';

    FConn.Params.Database := aDBConfig.Database;
    FConn.Params.UserName := aDBConfig.Username;
    FConn.Params.Password := aDBConfig.Password;
    FConn.Params.Add('Server=' + aDBConfig.Server);
    FConn.Params.Add('Port=' + aDBConfig.Port);
    FConn.Params.Add('Protocol=TCPIP');
  finally
    FBDriverLink.Free;
  end;
end;

class function TDBConn.GetInstance: TFDConnection;
begin
  if not FConn.Connected then
  begin
    try
      FConn.Open;
    except
      on E: EFDDBEngineException do
      begin
        TLogUtils.LogError(E.Message);
        raise;
      end;
    end;
  end;

  Result := FConn;
end;

end.
