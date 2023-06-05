unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections, uFormOrcamento, uUser;

type
  TPanelIndex = (piConfig = 1, piClient, piProduct, piOrders);

  TFormPrincipal = class(TForm)
    pnlFundo: TPanel;
    pnlBot: TPanel;
    pnlBotoes: TPanel;
    pnlMarginLeft: TPanel;
    pnlMarginRight: TPanel;
    pnlBtnOrcamentos: TPanel;
    pnlOrcamentos: TPanel;
    pnlMargimRight: TPanel;
    pnlMargimLeft: TPanel;
    pnlMargimTop: TPanel;
    pnlMargimBot: TPanel;
    pnlOrcamentosFundo: TPanel;
    lblOrcamentos: TLabel;
    imgOrcamentos: TImage;
    pnlOrcamentosBorda1: TPanel;
    pnlOrcamentosBorda2: TPanel;
    pnlBtnUsuarios: TPanel;
    pnlUsuarios: TPanel;
    pnlUsuariosLinha2: TPanel;
    pnlUsuariosLinha4: TPanel;
    pnlUsuariosLinha1: TPanel;
    pnlUsuariosLinha3: TPanel;
    pnlUsuariosFundo: TPanel;
    lblUsuarios: TLabel;
    imgUsuarios: TImage;
    pnlBtnUsuariosBorda1: TPanel;
    pnlBtnUsuariosBorda2: TPanel;
    pnlTop: TPanel;
    Panel17: TPanel;
    btnFechar: TSpeedButton;
    Panel18: TPanel;
    imgLogo: TImage;
    procedure btnFecharClick(Sender: TObject);
    procedure pnlUsuariosFundoClick(Sender: TObject);
    procedure imgUsuariosClick(Sender: TObject);
    procedure lblUsuariosClick(Sender: TObject);
    procedure pnlOrcamentosFundoClick(Sender: TObject);
    procedure imgOrcamentosClick(Sender: TObject);
    procedure lblOrcamentosClick(Sender: TObject);
  private
    PanelList: Array[TPanelIndex] of TPanel;
    procedure AssignCommonProperties(img: TImage; lbl: TLabel; pnl: TPanel; index: TPanelIndex);
    procedure ChangePanelColor(panel: TPanel; color: TColor);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangeColorOnMouseEnter(Sender: TObject);
    procedure ChangeColorOnMouseLeave(Sender: TObject);
  end;

var
  FormPrincipal: TFormPrincipal;

const
    PanelMouseEnterColor = clBtnFace;
  PanelMouseLeaveColor = clWhite;

implementation

{$R *.dfm}

procedure TFormPrincipal.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.AssignCommonProperties(img: TImage; lbl: TLabel; pnl: TPanel; index: TPanelIndex);
var
  TagValue: Integer;
begin
  TagValue := Ord(index);

  img.Tag := TagValue;
  lbl.Tag := TagValue;
  pnl.Tag := TagValue;

  img.OnMouseEnter := ChangeColorOnMouseEnter;
  img.OnMouseLeave := ChangeColorOnMouseLeave;
  lbl.OnMouseEnter := ChangeColorOnMouseEnter;
  lbl.OnMouseLeave := ChangeColorOnMouseLeave;
  pnl.OnMouseEnter := ChangeColorOnMouseEnter;
  pnl.OnMouseLeave := ChangeColorOnMouseLeave;
end;

constructor TFormPrincipal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  PanelList[piConfig]  := pnlUsuariosFundo;
  PanelList[piOrders]  := pnlOrcamentosFundo;

  AssignCommonProperties(imgUsuarios, lblUsuarios, pnlUsuariosFundo, piConfig);
  AssignCommonProperties(imgOrcamentos, lblOrcamentos, pnlOrcamentosFundo, piOrders);
end;


procedure TFormPrincipal.imgOrcamentosClick(Sender: TObject);
begin
  pnlOrcamentosFundoClick(Sender);
end;

procedure TFormPrincipal.imgUsuariosClick(Sender: TObject);
begin
  pnlUsuariosFundoClick(Sender);
end;

procedure TFormPrincipal.lblOrcamentosClick(Sender: TObject);
begin
  pnlOrcamentosFundoClick(Sender);
end;

procedure TFormPrincipal.lblUsuariosClick(Sender: TObject);
begin
  pnlUsuariosFundoClick(Sender);
end;

procedure TFormPrincipal.pnlOrcamentosFundoClick(Sender: TObject);
var
  FormOrcamento: TFormOrcamento;
begin
  FormOrcamento := TFormOrcamento.Create(nil);
  try
    FormOrcamento.ShowModal;
  finally
    FormOrcamento.Free;
  end;
end;

procedure TFormPrincipal.pnlUsuariosFundoClick(Sender: TObject);
var
  FormUser: TFormUser;
begin
  FormUser := TFormUser.Create(nil);
  try
    FormUser.ShowModal;
  finally
    FormUser.Free;
  end;
end;

procedure TFormPrincipal.ChangeColorOnMouseEnter(Sender: TObject);
begin
  if Sender is TComponent then
    ChangePanelColor(PanelList[TPanelIndex((Sender as TComponent).Tag)], PanelMouseEnterColor);
end;

procedure TFormPrincipal.ChangeColorOnMouseLeave(Sender: TObject);
begin
  if Sender is TComponent then
    ChangePanelColor(PanelList[TPanelIndex((Sender as TComponent).Tag)], PanelMouseLeaveColor);
end;

procedure TFormPrincipal.ChangePanelColor(panel: TPanel; color: TColor);
begin
  if Assigned(panel) then
    panel.Color := color;
end;


end.
