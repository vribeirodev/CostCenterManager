unit CentroCustoController;

interface

uses
  CentroCustoModel,
  CentroCustoDAOIntf,
  System.SysUtils,
  System.Generics.Collections;

type
  TCentroCustoController = class
  private
    FCentroCustoDAO: ICentroCustoDAO;
  public
    constructor Create(CentroCustoDAO: ICentroCustoDAO);
    function Insert(CentroCusto: TCentroCusto): Boolean;
    function Update(CentroCusto: TCentroCusto): Boolean;
    function Delete(CentroCusto: TCentroCusto): Boolean;
    function Select(CodigoPai: Integer; CodigoFilho: Integer): TCentroCusto;
    function GetAll: TObjectList<TCentroCusto>;
    function GetByOrcamentoId(OrcamentoId: Integer): TObjectList<TCentroCusto>;
end;

implementation

constructor TCentroCustoController.Create(CentroCustoDAO: ICentroCustoDAO);
begin
  FCentroCustoDAO := CentroCustoDAO;
end;

function TCentroCustoController.Insert(CentroCusto: TCentroCusto): Boolean;
begin
  Result := FCentroCustoDAO.Insert(CentroCusto);
end;

function TCentroCustoController.Update(CentroCusto: TCentroCusto): Boolean;
begin
  Result := FCentroCustoDAO.Update(CentroCusto);
end;

function TCentroCustoController.Delete(CentroCusto: TCentroCusto): Boolean;
begin
  Result := FCentroCustoDAO.Delete(CentroCusto);
end;

function TCentroCustoController.Select(CodigoPai: Integer; CodigoFilho: Integer): TCentroCusto;
begin
  Result := FCentroCustoDAO.Select(CodigoPai, CodigoFilho);
end;

function TCentroCustoController.GetAll: TObjectList<TCentroCusto>;
begin
  Result := FCentroCustoDAO.GetAll;
end;

function TCentroCustoController.GetByOrcamentoId(OrcamentoId: Integer): TObjectList<TCentroCusto>;
begin
  Result := FCentroCustoDAO.GetByOrcamentoId(OrcamentoId);
end;

end.

