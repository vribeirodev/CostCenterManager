  unit CentroCustoDAOIntf;

interface

uses
  CentroCustoModel,
  System.Generics.Collections;

type
  {$M+}
  ICentroCustoDAO = interface
  ['{53D37716-E82C-4D92-93A6-1272D800E53C}']
    function Insert(CentroCusto: TCentroCusto): Boolean;
    function Update(CentroCusto: TCentroCusto): Boolean;
    function Delete(CentroCusto: TCentroCusto): Boolean;
    function Select(CodigoPai: Integer; CodigoFilho: Integer): TCentroCusto;
    function GetAll: TObjectList<TCentroCusto>;
    function GetByOrcamentoId(OrcamentoId: Integer): TObjectList<TCentroCusto>;
  end;

implementation

end.

