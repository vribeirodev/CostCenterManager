unit uFormOrcamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  CentroCustoModel, LancamentoModel, Orcamento, ResumoCentroCustoPai,
  ResumoCentroCustoFilho, ResumoValorTotal, Vcl.Grids, OrcamentoDAO, OrcamentoDAOIntf,
  CentroCustoController, LancamentoController, OrcamentoModel, CentroCustoDao, LancamentoDAO,
  uFormConsulta, System.Generics.Collections, Vcl.Buttons;

type
  TFormOrcamento = class(TForm)
    pnlTop: TPanel;
    Panel2: TPanel;
    pnlContent: TPanel;
    edtCentroCusto: TEdit;
    edtLancamento: TEdit;
    btnAdicionar: TButton;
    pnlPai: TPanel;
    pnlFilho: TPanel;
    pnlTotal: TPanel;
    sGridPai: TStringGrid;
    sGridFilho: TStringGrid;
    sGridTotal: TStringGrid;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    btnNovoOrcamento: TButton;
    btnConfirmar: TButton;
    btnConsultar: TButton;
    btnCancelar: TButton;
    btnFechar: TSpeedButton;
    lblCentroCusto: TLabel;
    lblValor: TLabel;
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoOrcamentoClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    Orcamento: TOrcamento;
    OrcamentoModel: TOrcamentoModel;
    ResumoPai: TResumoCentroCustoPai;
    ResumoFilho: TResumoCentroCustoFilho;
    ResumoTotal: TResumoValorTotal;

    procedure AutoSizeGrid(Grid: TStringGrid);
    procedure EnableControls(Enable: Boolean);
    procedure CarregarOrcamento(OrcamentoId: Integer);
    procedure ClearControls;
  public
    { Public declarations }
  end;

var
  FormOrcamento: TFormOrcamento;

implementation

{$R *.dfm}

procedure TFormOrcamento.ClearControls;
begin
  edtCentroCusto.Text := '';
  edtLancamento.Text := '';

  sGridPai.RowCount := 1;
  sGridFilho.RowCount := 1;
  sGridTotal.Cells[0, 1] := '0';
end;

procedure TFormOrcamento.EnableControls(Enable: Boolean);
begin
  edtCentroCusto.Enabled := Enable;
  edtLancamento.Enabled := Enable;
  btnAdicionar.Enabled := Enable;
  sGridPai.Enabled := Enable;
  sGridFilho.Enabled := Enable;
  sGridTotal.Enabled := Enable;
  btnConfirmar.Enabled := Enable;
  btnCancelar.Enabled := Enable;
end;

procedure TFormOrcamento.AutoSizeGrid(Grid: TStringGrid);
var
  maxColWidth, i, j: Integer;
  maxColWidths: array of Integer;
begin
  SetLength(maxColWidths, Grid.ColCount);

  for i := 0 to Grid.ColCount - 1 do
  begin
    maxColWidth := 0;
    for j := 0 to Grid.RowCount - 1 do
    begin
      if Grid.Canvas.TextWidth(Grid.Cells[i, j]) > maxColWidth then
        maxColWidth := Grid.Canvas.TextWidth(Grid.Cells[i, j]);
    end;
    maxColWidths[i] := maxColWidth;
  end;

  for i := 0 to Grid.ColCount - 1 do
    Grid.ColWidths[i] := maxColWidths[i] + 20;
end;


procedure TFormOrcamento.btnAdicionarClick(Sender: TObject);
var
  codigoCentroCusto: string;
  valorLancamento: Extended;
  codigoPai: Integer;
  codigoFilho: Integer;
  lancamento: TLancamento;
  centroCusto: TCentroCusto;
  i: Integer;
  encontrado: Boolean;
begin
  // Pega o código do centro de custo do edtCentroCusto
  codigoCentroCusto := edtCentroCusto.Text;


  if Length(codigoCentroCusto) <> 6 then
  begin
    MessageDlg('Código de Centro de Custo inválido.' + sLineBreak +
               'O código deve ter 6 dígitos, sendo os 2 primeiros para o centro de custo pai (valores de 01 até 99)' + sLineBreak +
               'e os 4 últimos para o centro de custo filho (valores de 0001 até 9999).',
               mtInformation, [mbOK], 0);
    Exit;
  end;

  if not TryStrToInt(Copy(codigoCentroCusto, 1, 2), codigoPai) or
     not ((codigoPai >= 1) and (codigoPai <= 99)) then
  begin
    MessageDlg('Código do centro de custo pai inválido.' + sLineBreak +
               'Ele deve ser um número entre 01 e 99.',
               mtInformation, [mbOK], 0);
    Exit;
  end;

  if not TryStrToInt(Copy(codigoCentroCusto, 3, 4), codigoFilho) or
     not ((codigoFilho >= 1) and (codigoFilho <= 9999)) then
  begin
    MessageDlg('Código do centro de custo filho inválido.' + sLineBreak +
               'Ele deve ser um número entre 0001 e 9999.',
               mtInformation, [mbOK], 0);
    Exit;
  end;

  if not TryStrToFloat(edtLancamento.Text, valorLancamento) then
  begin
    MessageDlg('Valor de Lançamento inválido.', mtInformation, [mbOK], 0);
    Exit;
  end;


  // Cria o lançamento
  lancamento := TLancamento.Create(codigoPai, codigoFilho, valorLancamento, OrcamentoModel.Id); // O id é aleatório, você pode mudar isso

  // Verifica se o centro de custo já existe
  if Orcamento.CentrosCustos.ContainsKey(codigoCentroCusto) then
  begin
    centroCusto := Orcamento.CentrosCustos.Items[codigoCentroCusto];
    centroCusto.AdicionarLancamento(lancamento);
  end
  else
  begin
    centroCusto := TCentroCusto.Create(codigoPai, codigoFilho);
    centroCusto.AdicionarLancamento(lancamento);
    Orcamento.AdicionarCentroCusto(centroCusto);
  end;

  encontrado := False;

  // Procura o código do pai na TStringGrid do Centro de Custo Pai
  for i := 1 to sGridPai.RowCount - 1 do
  begin
    if sGridPai.Cells[0, i] = IntToStr(codigoPai) then
    begin
      // Se encontrou, atualiza o valor do lançamento
      sGridPai.Cells[1, i] := FloatToStr(StrToFloat(StringReplace(sGridPai.Cells[1, i], 'R$ ', '', [rfReplaceAll])) + valorLancamento);

      encontrado := True;
      break;
    end;
  end;

  // Se não encontrou, adiciona uma nova linha
  if not encontrado then
  begin
    sGridPai.RowCount := sGridPai.RowCount + 1;
    sGridPai.Cells[0, sGridPai.RowCount-1] := IntToStr(codigoPai);
    sGridPai.Cells[1, sGridPai.RowCount-1] := FormatFloat('R$ #,##0.00', valorLancamento);
  end;

  AutoSizeGrid(sGridPai);

  // Atualiza a TStringGrid do Centro de Custo Filho
  sGridFilho.RowCount := sGridFilho.RowCount + 1;
  sGridFilho.Cells[0, sGridFilho.RowCount-1] := codigoCentroCusto;
  sGridFilho.Cells[1, sGridFilho.RowCount-1] := FormatFloat('R$ #,##0.00', valorLancamento);

  AutoSizeGrid(sGridFilho);

  // Atualiza a TStringGrid do Total
  sGridTotal.Cells[0, 1] := FormatFloat('R$ #,##0.00', StrToFloat(StringReplace(sGridTotal.Cells[0, 1], 'R$ ', '', [rfReplaceAll])) + valorLancamento);
  AutoSizeGrid(sGridTotal);

    // Limpa edtCentroCusto e edtLancamento
  edtCentroCusto.Text := '';
  edtLancamento.Text := '';

  // Define o foco para edtCentroCusto
  edtCentroCusto.SetFocus;
end;

procedure TFormOrcamento.btnCancelarClick(Sender: TObject);
var
  OrcamentoDAO : TOrcamentoDAO;
begin
  ClearControls;
  EnableControls(False);
  OrcamentoDAO := TOrcamentoDAO.Create;

  try
    orcamentoDAO.Delete(OrcamentoModel);
  finally
    OrcamentoDAO.Free;
  end;
end;

procedure TFormOrcamento.btnConfirmarClick(Sender: TObject);
var
  CentroCustoController: TCentroCustoController;
  LancamentoController: TLancamentoController;
  CentroCusto: TCentroCusto;
  Lancamento: TLancamento;
  OrcamentoTotal: Real;
begin
  CentroCustoController := TCentroCustoController.Create(TCentroCustoDAO.Create);
  LancamentoController := TLancamentoController.Create(TLancamentoDAO.Create);

  try
    OrcamentoTotal := 0;
    for CentroCusto in Orcamento.CentrosCustos.Values do
    begin
      CentroCusto.IdOrcamento := OrcamentoModel.Id;
      CentroCustoController.Insert(CentroCusto);
      for Lancamento in CentroCusto.Lancamentos do
      begin
        Lancamento.IdOrcamento := OrcamentoModel.Id;
        LancamentoController.Insert(Lancamento);
        OrcamentoTotal := OrcamentoTotal + Lancamento.Valor;
      end;
    end;

    edtCentroCusto.Text := '';
    edtLancamento.Text := '';
    sGridPai.RowCount := 1;
    sGridFilho.RowCount := 1;
    sGridTotal.Cells[0, 1] := '0';


    EnableControls(False);


    ShowMessage('Orçamento salvo com sucesso.' + sLineBreak + 'Total do orçamento: ' + FormatFloat('R$ #,##0.00', OrcamentoTotal));
  finally
    CentroCustoController.Free;
    LancamentoController.Free;
  end;
end;

procedure TFormOrcamento.CarregarOrcamento(OrcamentoId: Integer);
var
  CentroCustoController : TCentroCustoController;
  CentrosCustos: TObjectList<TCentroCusto>;
  CentroCusto: TCentroCusto;
  codigoPai, i, indexPai: integer;
  valorPai, valorAtual, valorTotal: real;
  LancamentoController: TLancamentoController;
  Lancamentos: TObjectList<TLancamento>;
  Lancamento: TLancamento;
  encontrado: Boolean;
begin
  CentroCustoController := TCentroCustoController.Create(TCentroCustoDAO.Create);
  CentrosCustos := CentroCustoController.GetByOrcamentoId(OrcamentoId);

  LancamentoController := TLancamentoController.Create(TLancamentoDAO.Create);
  valorTotal := 0;
  for CentroCusto in CentrosCustos do
  begin
    encontrado := false;
    Lancamentos := LancamentoController.GetByCentroCusto(CentroCusto);
    valorPai := 0;
    for Lancamento in Lancamentos do
    begin
      sGridFilho.RowCount := sGridFilho.RowCount + 1;
      sGridFilho.Cells[0, sGridFilho.RowCount-1] := CentroCusto.GetCodigoCompleto;
      sGridFilho.Cells[1, sGridFilho.RowCount-1] := FormatFloat('R$ #,##0.00', Lancamento.Valor);

      valorPai := valorPai + Lancamento.Valor;
      valorTotal := valorTotal + Lancamento.Valor;
    end;

    for i := 1 to sGridPai.RowCount - 1 do
    begin
      if sGridPai.Cells[0, i] = IntToStr(CentroCusto.CodigoPai) then
      begin
        encontrado := True;

        valorAtual := StrToFloatDef(StringReplace(sGridPai.Cells[1, i], 'R$ ', '', [rfReplaceAll]), 0.0);
        valorAtual := valorAtual + valorPai;
        sGridPai.Cells[1, i] := FormatFloat('R$ ,0.00', valorAtual);
      end;
    end;

    if not encontrado then
    begin
      codigoPai := CentroCusto.CodigoPai;

      sGridPai.RowCount := sGridPai.RowCount + 1;
      sGridPai.Cells[0, sGridPai.RowCount-1] := IntToStr(codigoPai);
      sGridPai.Cells[1, sGridPai.RowCount-1] := FormatFloat('R$ #,##0.00', valorPai);
    end;

  end;

  sGridTotal.Cells[0, 1] := FormatFloat('R$ #,##0.00', valorTotal);

  AutoSizeGrid(sGridPai);
  AutoSizeGrid(sGridFilho);
  AutoSizeGrid(sGridTotal);

end;



procedure TFormOrcamento.btnConsultarClick(Sender: TObject);
var
  FormConsulta: TFormConsulta;
  OrcamentoId: Integer;
begin
    ClearControls;

  FormConsulta := TFormConsulta.Create(Self);
  try
    if FormConsulta.ShowModal = mrOk then
    begin
      OrcamentoId := FormConsulta.SelectedOrcamentoId;

      CarregarOrcamento(OrcamentoId);
    end;
  finally
    FormConsulta.Free;
  end;
end;

procedure TFormOrcamento.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormOrcamento.btnNovoOrcamentoClick(Sender: TObject);
var
  OrcamentoDAO: TOrcamentoDAO;
begin
  OrcamentoDAO := TOrcamentoDAO.Create;

  OrcamentoModel := OrcamentoDAO.Insert;

  edtCentroCusto.Text := '';
  edtLancamento.Text := '';
  sGridPai.RowCount := 1;
  sGridFilho.RowCount := 1;
  sGridTotal.Cells[0, 1] := '0';

  EnableControls(True);


  edtCentroCusto.SetFocus;
end;

procedure TFormOrcamento.Button1Click(Sender: TObject);
var
  FormOrcamento: TFormOrcamento;
begin
  FormOrcamento := TFormOrcamento.Create(Self);
  FormOrcamento.ShowModal;

end;

procedure TFormOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
  Orcamento := TOrcamento.Create;
  OrcamentoModel := TOrcamentoModel.Create;

  sGridPai.ColCount := 2;
  sGridPai.RowCount := 1;
  sGridPai.Cells[0, 0] := 'Centro de Custo Pai';
  sGridPai.Cells[1, 0] := 'Valor';

  sGridFilho.ColCount := 2;
  sGridFilho.RowCount := 1;
  sGridFilho.Cells[0, 0] := 'Centro de Custo Filho';
  sGridFilho.Cells[1, 0] := 'Valor';

  sGridTotal.ColCount := 1;
  sGridTotal.RowCount := 2;
  sGridTotal.Cells[0, 0] := 'Valor Total';
  sGridTotal.Cells[0, 1] := '0';

  AutoSizeGrid(sGridPai);
  AutoSizeGrid(sGridFilho);
  AutoSizeGrid(sGridTotal);

  EnableControls(False);
end;

end.
