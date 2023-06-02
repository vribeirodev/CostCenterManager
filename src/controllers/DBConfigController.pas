unit DBConfigController;

interface

uses
  System.JSON,
  System.Hash,
  System.IOUtils,
  System.SysUtils,
  Dialogs,
  DBConn,
  DBConfig,
  DBConfigValidator,
  DBConfigFileHandler;

type
  TDBConfigController = class
  private
    FDBConfigFileHandler: TDBConfigFileHandler;
    const
      CONFIG_FILE_NAME = 'DBConfig.json';
      ERR_FIELDS_NOT_FILLED = 'Por favor, preencha todos os campos.';

  public
    constructor Create;
    destructor Destroy; override;

    procedure GravarConfiguracoes(DBConfig: TDBConfig);

    function TestarConexao(DBConfig: TDBConfig): Boolean;
    function LoadConfig: TDBConfig;
    function SelectDatabaseFile: String;
  end;

implementation

constructor TDBConfigController.Create;
begin
  FDBConfigFileHandler := TDBConfigFileHandler.Create;
end;

destructor TDBConfigController.Destroy;
begin
  FDBConfigFileHandler.Free;
  inherited;
end;

function TDBConfigController.SelectDatabaseFile: String;
var
  Dialog: TFileOpenDialog;
  FileTypeItem: TFileTypeItem;
begin
  Dialog := TFileOpenDialog.Create(nil);
  try
    Dialog.Options := [fdoFileMustExist];
    Dialog.DefaultFolder := GetCurrentDir;

    FileTypeItem := Dialog.FileTypes.Add;
    FileTypeItem.DisplayName := 'Firebird files';
    FileTypeItem.FileMask := '*.fdb';

    if Dialog.Execute then
      result := Dialog.FileName;
  finally
    Dialog.Free;
  end;
end;

procedure TDBConfigController.GravarConfiguracoes(DBConfig: TDBConfig);
begin
  if not TDBConfigValidator.AreFieldsValid(DBConfig) then
    raise Exception.Create(ERR_FIELDS_NOT_FILLED);

  FDBConfigFileHandler.SaveToFile(DBConfig);
end;

function TDBConfigController.TestarConexao(DBConfig: TDBConfig): Boolean;
begin
  TDBConn.SetConfig(DBConfig);
  TDBConn.CreateConnection;
  Result := True;
end;


function TDBConfigController.LoadConfig: TDBConfig;
begin
  Result := FDBConfigFileHandler.LoadFromFile;
end;

end.
