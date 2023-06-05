unit OrcamentoDAOIntf;

interface

uses
  System.Generics.Collections, OrcamentoModel;

type
  IOrcamentoDAO = interface
    ['{B3F1F7F5-4C22-4091-A581-BCEB3FA7536A}']
    function Insert: TOrcamentoModel;
    function Delete(Orcamento: TOrcamentoModel): Boolean;
    function Select(OrcamentoID: Integer): TOrcamentoModel;
    function GetAll: TObjectList<TOrcamentoModel>;
  end;

implementation

end.

