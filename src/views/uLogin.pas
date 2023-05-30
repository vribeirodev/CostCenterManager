unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, uDBConfig;

type
  TFormLogin = class(TForm)
    pnlFundo: TPanel;
    lblCredenciais: TLabel;
    btnFechar: TSpeedButton;
    pnlLateral: TPanel;
    lblBemVindo: TLabel;
    igmLogo: TImage;
    lblRodape: TLabel;
    pnlUsuario: TPanel;
    lblUsuario: TLabel;
    pnlLinhaUsuario: TPanel;
    edtUsuario: TEdit;
    pnlSenha: TPanel;
    lblSeha: TLabel;
    pnlLinhaSenha: TPanel;
    edtSenha: TEdit;
    pnlConfirmar: TPanel;
    btnConfirmar: TSpeedButton;
    pnlConfig: TPanel;
    imgConfig: TImage;
    btnConfig: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure PositionPanel;
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

procedure TFormLogin.FormResize(Sender: TObject);
begin
   PositionPanel;
end;

procedure TFormLogin.PositionPanel;
begin
  if Assigned(pnlFundo) and Assigned(FormLogin) then
  begin
    pnlFundo.Left := Round((FormLogin.Width - pnlFundo.Width) / 2);
    pnlFundo.Top := Round((FormLogin.Height - pnlFundo.Height) / 2);
  end;
end;

procedure TFormLogin.btnConfigClick(Sender: TObject);
var
  FormDBConfig: TFormDBConfig;
begin
  FormDBConfig := TFormDBConfig.Create(nil);
  try
    FormDBConfig.ShowModal;
  finally
    FormDBConfig.Free;
  end;
end;

procedure TFormLogin.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  PositionPanel;
end;
end.
