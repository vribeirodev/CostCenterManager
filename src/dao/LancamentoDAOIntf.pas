unit LancamentoDAOIntf;

interface

uses
  LancamentoModel,
  System.Generics.Collections,
  CentroCustoModel;

type
  ILancamentoDAO = interface
  ['{82FAE972-2F19-460A-8D42-F28E4B2E57AF}']
    function Insert(Lancamento: TLancamento): Integer;
    function Update(Lancamento: TLancamento): Boolean;
    function Delete(Lancamento: TLancamento): Boolean;
    function Select(LancamentoID: Integer): TLancamento;
    function GetAll: TObjectList<TLancamento>;
    function GetByCentroCusto(CentroCusto: TCentroCusto): TObjectList<TLancamento>;

  end;

implementation

end.

