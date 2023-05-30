unit uLayout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormLayout = class(TForm)
    pnlBackground: TPanel;
    pnlMarginRight: TPanel;
    pnlMarginBot: TPanel;
    pnlMarginLeft: TPanel;
    pnlMargimTop: TPanel;
    btnClose: TSpeedButton;
    pnlMain: TPanel;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLayout: TFormLayout;

implementation

{$R *.dfm}

procedure TFormLayout.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
