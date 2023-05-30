program CostCenterManager;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FormMain},
  DBConn in 'services\DBConn.pas',
  LogUtils in 'services\LogUtils.pas',
  Login in 'views\Login.pas' {FormLogin},
  Layout in 'views\Layout.pas' {FormLayout},
  DBConfig in 'views\DBConfig.pas' {FormDBConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormLayout, FormLayout);
  Application.CreateForm(TFormDBConfig, FormDBConfig);
  if true then
  begin
    Application.CreateForm(TFormMain, FormMain);
    Application.Run;
  end
  else
    Application.Terminate;
end.
