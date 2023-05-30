unit DBConn;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  System.IOUtils,
  System.SysUtils,
  LogUtils;

type
  TDBConn = class
  private
    class var FConn: TFDConnection;
    class constructor Create;
    class destructor Destroy;
    class procedure ConfigurarConexao(aDatabase, aUserName, aPassword: string;
                                      aServer: string = 'localhost';
                                      aPort: string = '3050');
  public
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

class procedure TDBConn.ConfigurarConexao(aDatabase: string; aUserName: string; aPassword: string; aServer: string = 'localhost'; aPort: string = '3050');
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
    FConn.Params.Database := aDatabase;
    FConn.Params.UserName := aUserName;
    FConn.Params.Password := aPassword;
    FConn.Params.Add('Protocol=TCPIP');
    FConn.Params.Add('Server=' + aServer);
    FConn.Params.Add('Port=' + aPort);
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
