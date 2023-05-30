unit DBConfigController;

interface

uses
  System.JSON,
  System.SysUtils,
  DBConn,
  System.IOUtils,
  System.Hash,
  Dialogs,
  DBConfigFileHandler,
  DBConfig;

type
  TDBConfigController = class
  private
    FDBConfigFileHandler: TDBConfigFileHandler;
    const CONFIG_FILE_NAME = 'DBConfig.json';
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
  FDBConfigFileHandler.SaveToFile(DBConfig);
end;

function TDBConfigController.TestarConexao(DBConfig: TDBConfig): Boolean;
begin
  TDBConn.ConfigurarConexao(DBConfig);
  TDBConn.GetInstance;
  Result := True;
end;

function TDBConfigController.LoadConfig: TDBConfig;
begin
  Result := FDBConfigFileHandler.LoadFromFile;
end;

end.
