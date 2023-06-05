unit DBConfigFileHandler;

interface

uses
  System.SysUtils,
  System.Hash,
  System.IOUtils,
  System.JSON,
  DBConfig,
  System.Classes;

type
  TDBConfigFileHandler = class
    private
      const
        CONFIG_FILE_NAME  = 'DBConfig.json';
        JSON_KEY_DATABASE = 'database';
        JSON_KEY_USERNAME = 'username';
        JSON_KEY_PASSWORD = 'password';
        JSON_KEY_SERVER   = 'server';
        JSON_KEY_PORT     = 'port';

    public
      procedure SaveToFile(DBConfig: TDBConfig);
      function LoadFromFile: TDBConfig;
  end;
implementation

{
  Salva a configuração do banco de dados para um arquivo JSON.
  @param DBConfig A configuração do banco de dados a ser salva.
}
procedure TDBConfigFileHandler.SaveToFile(DBConfig: TDBConfig);
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.Create;
  try
    JSONObj.AddPair('database', DBConfig.Database);
    JSONObj.AddPair('username', DBConfig.Username);
    JSONObj.AddPair('password', DBConfig.Password);
    JSONObj.AddPair('server', DBConfig.Server);
    JSONObj.AddPair('port', DBConfig.Port);

    TFile.WriteAllText(CONFIG_FILE_NAME, JSONObj.ToString);
  finally
    JSONObj.Free;
  end;
end;

{
  Carrega a configuração do banco de dados de um arquivo JSON.
  @return A configuração do banco de dados carregada do arquivo.
  @raises Exception Se o arquivo de configuração não contiver todos os valores necessários.
}
function TDBConfigFileHandler.LoadFromFile: TDBConfig;
var
  JSONObj: TJSONObject;
  JSONValue: TJSONValue;
  DBConfig: TDBConfig;
begin
   Result := TDBConfig.Create('','','','','');

  // Define os valores padrão
  Result.Server := 'localhost';
  Result.Port := '3050';

  if TFile.Exists(CONFIG_FILE_NAME) then
  begin
    JSONObj := TJSONObject.ParseJSONValue(TFile.ReadAllText(CONFIG_FILE_NAME)) as TJSONObject;
    try
      if JSONObj.TryGetValue(JSON_KEY_DATABASE, JSONValue) then
        Result.Database := JSONValue.Value;
      if JSONObj.TryGetValue(JSON_KEY_USERNAME, JSONValue) then
        Result.Username := JSONValue.Value;
      if JSONObj.TryGetValue(JSON_KEY_PASSWORD, JSONValue) then
        Result.Password := JSONValue.Value;
      if JSONObj.TryGetValue(JSON_KEY_SERVER, JSONValue) then
        Result.Server := JSONValue.Value;
      if JSONObj.TryGetValue(JSON_KEY_PORT, JSONValue) then
        Result.Port := JSONValue.Value;
    finally
      JSONObj.Free;
    end;
  end
  else
  begin
    DBConfig := TDBConfig.Create('','','','','');
    DBConfig.Database := TPath.Combine(TPath.GetDirectoryName(ExtractFilePath(ParamStr(0))), '..\database\database.fdb');
    DBConfig.Username := 'sysdba';
    DBConfig.Password := 'masterkey';
    DBConfig.Server   := 'localhost';
    DBConfig.Port     := '3050';

    Self.SaveToFile(DBConfig);
    Result:= DBConfig;
  end;
end;



end.
