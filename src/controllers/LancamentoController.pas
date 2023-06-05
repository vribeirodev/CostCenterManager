unit LancamentoController;

interface

uses
  LancamentoModel,
  LancamentoDAOIntf,
  System.SysUtils,
  System.Generics.Collections,
  CentroCustoModel;

type
  TLancamentoController = class
  private
    FLancamentoDAO: ILancamentoDAO;
  public
    constructor Create(LancamentoDAO: ILancamentoDAO);
    function Insert(Lancamento: TLancamento): Integer;
    function Update(Lancamento: TLancamento): Boolean;
    function Delete(Lancamento: TLancamento): Boolean;
    function Select(LancamentoID: Integer): TLancamento;
    function GetAll: TObjectList<TLancamento>;
    function GetByCentroCusto(CentroCusto: TCentroCusto): TObjectList<TLancamento>;
end;

implementation

function TLancamentoController.GetByCentroCusto(CentroCusto: TCentroCusto): TObjectList<TLancamento>;
begin
  Result := FLancamentoDAO.GetByCentroCusto(CentroCusto);
end;

constructor TLancamentoController.Create(LancamentoDAO: ILancamentoDAO);
begin
  FLancamentoDAO := LancamentoDAO;
end;

function TLancamentoController.Insert(Lancamento: TLancamento): Integer;
begin
  Result := FLancamentoDAO.Insert(Lancamento);
end;

function TLancamentoController.Update(Lancamento: TLancamento): Boolean;
begin
  Result := FLancamentoDAO.Update(Lancamento);
end;

function TLancamentoController.Delete(Lancamento: TLancamento): Boolean;
begin
  Result := FLancamentoDAO.Delete(Lancamento);
end;

function TLancamentoController.Select(LancamentoID: Integer): TLancamento;
begin
  Result := FLancamentoDAO.Select(LancamentoID);
end;

function TLancamentoController.GetAll: TObjectList<TLancamento>;
begin
  Result := FLancamentoDAO.GetAll;
end;

end.

