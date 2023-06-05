program CostCenterManager;

uses
  Vcl.Forms,
  System.SysUtils,
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
  UserFactory in 'services\UserFactory.pas',
  CentroCustoModel in 'models\CentroCustoModel.pas',
  LancamentoModel in 'models\LancamentoModel.pas',
  ResumoObserverIntf in 'services\ResumoObserverIntf.pas',
  ResumoCentroCustoPai in 'services\ResumoCentroCustoPai.pas',
  ResumoCentroCustoFilho in 'services\ResumoCentroCustoFilho.pas',
  ResumoValorTotal in 'services\ResumoValorTotal.pas',
  Orcamento in 'services\Orcamento.pas',
  CentroCustoDAO in 'dao\CentroCustoDAO.pas',
  CentroCustoDAOIntf in 'dao\CentroCustoDAOIntf.pas',
  LancamentoDAOIntf in 'dao\LancamentoDAOIntf.pas',
  LancamentoDAO in 'dao\LancamentoDAO.pas',
  LancamentoController in 'controllers\LancamentoController.pas',
  CentroCustoController in 'controllers\CentroCustoController.pas',
  OrcamentoModel in 'models\OrcamentoModel.pas',
  OrcamentoDAO in 'dao\OrcamentoDAO.pas',
  OrcamentoDAOIntf in 'dao\OrcamentoDAOIntf.pas',
  uFormConsulta in 'views\uFormConsulta.pas' {FormConsulta},
  uFormOrcamento in 'views\uFormOrcamento.pas' {FormOrcamento},
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uUser in 'views\uUser.pas' {FormUser};

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
  Application.CreateForm(TFormConsulta, FormConsulta);
  Application.CreateForm(TFormOrcamento, FormOrcamento);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormUser, FormUser);
  if true then
  begin
    Application.CreateForm(TFormPrincipal, FormPrincipal);
    Application.Run;
  end
  else
    Application.Terminate;
end.

