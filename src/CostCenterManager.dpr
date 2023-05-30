program CostCenterManager;

uses
  Vcl.Forms,
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
  UserModel in 'models\UserModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  if true then
  begin
    Application.CreateForm(TFormMain, FormMain);
    Application.Run;
  end
  else
    Application.Terminate;
end.
