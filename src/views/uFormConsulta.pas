unit uFormConsulta;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, OrcamentoDAO, OrcamentoModel, System.Generics.Collections,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormConsulta = class(TForm)
    sGridOrcamentos: TStringGrid;
    pnlTop: TPanel;
    pnlContent: TPanel;
    lblDescricao: TLabel;
    procedure sGridOrcamentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedOrcamentoId: Integer;
  end;

var
  FormConsulta: TFormConsulta;

implementation

{$R *.dfm}

procedure TFormConsulta.FormShow(Sender: TObject);
var
  OrcamentoDAO: TOrcamentoDAO;
  Orcamentos: TObjectList<TOrcamentoModel>;
  i, TotalWidth, ColWidth, MaxHeight, BorderWidth, BorderHeight: Integer;
  Text: string;
begin
  OrcamentoDAO := TOrcamentoDAO.Create;
  try
    Orcamentos := OrcamentoDAO.GetAll;

    sGridOrcamentos.ColCount := 2;
    sGridOrcamentos.RowCount := Orcamentos.Count + 1;
    sGridOrcamentos.FixedCols := 0;
    sGridOrcamentos.FixedRows := 0;

    Text := 'ID';
    ColWidth := sGridOrcamentos.Canvas.TextWidth(Text) + 20;
    sGridOrcamentos.Cells[0, 0] := Text;
    sGridOrcamentos.ColWidths[0] := ColWidth;

    Text := 'Data de Criação';
    ColWidth := sGridOrcamentos.Canvas.TextWidth(Text) + 20;
    sGridOrcamentos.Cells[1, 0] := Text;
    sGridOrcamentos.ColWidths[1] := ColWidth;

    TotalWidth := sGridOrcamentos.ColWidths[0] + sGridOrcamentos.ColWidths[1];

    for i := 0 to Orcamentos.Count - 1 do
    begin
      sGridOrcamentos.Cells[0, i + 1] := IntToStr(Orcamentos[i].Id);
      sGridOrcamentos.Cells[1, i + 1] := DateToStr(Orcamentos[i].DataOrcamento);
    end;

    MaxHeight := sGridOrcamentos.DefaultRowHeight * (Orcamentos.Count + 1);

    sGridOrcamentos.ClientWidth := TotalWidth;
    sGridOrcamentos.ClientHeight := MaxHeight;

    BorderWidth := Width - ClientWidth;
    BorderHeight := Height - ClientHeight;
    FormConsulta.Width := sGridOrcamentos.Width + BorderWidth + sGridOrcamentos.Left * 2;
    FormConsulta.Height := sGridOrcamentos.Height + BorderHeight + sGridOrcamentos.Top * 2;

  finally
    OrcamentoDAO.Free;
  end;
end;


procedure TFormConsulta.sGridOrcamentosDblClick(Sender: TObject);
begin
  if sGridOrcamentos.Row > 0 then
  begin
    SelectedOrcamentoId := StrToInt(sGridOrcamentos.Cells[0, sGridOrcamentos.Row]);
    ModalResult := mrOk;
  end;
end;

end.
