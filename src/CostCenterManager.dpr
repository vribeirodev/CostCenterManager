program CostCenterManager;

uses
  Vcl.Forms,
  System.SysUtils,
  MainForm in 'MainForm.pas' {FormMain},
  DBConn in 'services\DBConn.pas',
  LogUtils in 'services\LogUtils.pas',
  uLogin in 'views\uLogin.pas' {FormLogin},
  uLayout in 'views\uLayout.pas' {FormLayout},
  uDBConfig in 'views\uDBConfig.pas' {FormDBConfig},
  DBConfig in 'services\DBConfig.pas' {$R *.res},
  DBConfigController in 'controllers\DBConfigController.pas',
  DBConfigFileHandler in 'services\DBConfigFileHandler.pas',
  DBConfigValidator in 'validators\DBConfigValidator.pas',
  UserModel in 'models\UserModel.pas',
  UserDAO in 'dao\UserDAO.pas',
  FDQueryFactory in 'services\FDQueryFactory.pas',
  UserController in 'controllers\UserController.pas',
  UserValidator in 'validators\UserValidator.pas',
  Security in 'services\Security.pas',
  UserDAOIntf in 'dao\UserDAOIntf.pas',
  FireDAC.Comp.UI,
  FireDAC.VCLUI.Wait,
  UserFactoryIntf in 'services\UserFactoryIntf.pas',
  UserFactory in 'services\UserFactory.pas';

{$R *.res}

var
  DBConfigFileHandler: TDBConfigFileHandler;
  DBConfig: TDBConfig;
begin
  Application.Initialize;
  TFDGUIxWaitCursor.Create(nil);

  DBConfigFileHandler := TDBConfigFileHandler.Create;
  try
    DBConfig := DBConfigFileHandler.LoadFromFile;
    TDBConn.SetConfig(DBConfig);
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Halt(1);
    end;
  end;

  Application.CreateForm(TFormLogin, FormLogin);
  if true then
  begin
    Application.CreateForm(TFormMain, FormMain);
    Application.Run;
  end
  else
    Application.Terminate;
end.

