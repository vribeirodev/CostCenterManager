unit uDBConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.JSON, DBConn, System.IOUtils, System.Hash, DBConfig,
  uLayout, DBConfigController, LogUtils;

type
  TFormDBConfig = class(TFormLayout)
    pnlTitle: TPanel;
    lblTitle: TLabel;
    pnlLineTitle: TPanel;
    pnlDatabase: TPanel;
    lblDatabase: TLabel;
    pnlLineDatabase: TPanel;
    edtDatabase: TEdit;
    btnDatabase: TSpeedButton;
    pnlUsername: TPanel;
    lblUsername: TLabel;
    pnlLineUsername: TPanel;
    edtUsername: TEdit;
    pnlPassword: TPanel;
    lblPassword: TLabel;
    pnlLinePassword: TPanel;
    edtPassword: TEdit;
    pnlButtons: TPanel;
    pnlGravar: TPanel;
    btnGravar: TSpeedButton;
    pnlCancelar: TPanel;
    btnCancelar: TSpeedButton;
    pnlTestar: TPanel;
    btnTestar: TSpeedButton;
    pnlBtnMargimRight: TPanel;
    pnlBtnMargimLeft: TPanel;
    pnlServer: TPanel;
    lblServer: TLabel;
    pnlLineServer: TPanel;
    edtServer: TEdit;
    pnlPort: TPanel;
    lblPort: TLabel;
    pnlLinePort: TPanel;
    edtPort: TEdit;
    procedure btnDatabaseClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDBConfigController: TDBConfigController;
    FDBConfig: TDBConfig;
  public
    { Public declarations }
  end;
const
  CONFIG_FILE_NAME = 'DBConfig.json';

var
  FormDBConfig: TFormDBConfig;

implementation

{$R *.dfm}
procedure TFormDBConfig.FormCreate(Sender: TObject);
begin
  FDBConfigController := TDBConfigController.Create;

  FDBConfig := FDBConfigController.LoadConfig;

  edtDatabase.Text := FDBConfig.Database;
  edtUsername.Text := FDBConfig.Username;
  edtPassword.Text := FDBConfig.Password;
  edtServer.Text   := FDBConfig.Server;
  edtPort.Text     := FDBConfig.Port;
end;

procedure TFormDBConfig.FormDestroy(Sender: TObject);
begin
  FDBConfigController.Free;
  FDBConfig.Free;
  inherited;
end;

procedure TFormDBConfig.btnDatabaseClick(Sender: TObject);
begin
  edtDatabase.Text := FDBConfigController.SelectDatabaseFile;
end;

procedure TFormDBConfig.btnGravarClick(Sender: TObject);
begin
  try
    FDBConfig.Database := edtDatabase.Text;
    FDBConfig.Username := edtUsername.Text;
    FDBConfig.Password := edtPassword.Text;
    FDBConfig.Server   := edtServer.Text;
    FDBConfig.Port     := edtPort.Text;

    FDBConfigController.GravarConfiguracoes(FDBConfig);
    ShowMessage('Configurações gravadas com sucesso!');
    Self.Close;
  except
    on E: Exception do
    begin
      TLogUtils.LogError(E.Message);
      ShowMessage('Falha ao gravar configurações: ' + E.Message);
    end;
  end;
end;

procedure TFormDBConfig.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFormDBConfig.btnTestarClick(Sender: TObject);
begin
  try
    FDBConfig.Database := edtDatabase.Text;
    FDBConfig.Username := edtUsername.Text;
    FDBConfig.Password := edtPassword.Text;
    FDBConfig.Server   := edtServer.Text;
    FDBConfig.Port     := edtPort.Text;

    if FDBConfigController.TestarConexao(FDBConfig) then
      ShowMessage('Conexão realizada com sucesso!')
    else
      ShowMessage('Falha ao se conectar');
  except
    on E: Exception do
      ShowMessage('Falha ao se conectar: ' + E.Message);
  end;
end;

end.
