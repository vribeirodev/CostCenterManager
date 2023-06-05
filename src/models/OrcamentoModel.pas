unit OrcamentoModel;

interface

uses
  System.SysUtils;

type
  TOrcamentoModel = class
  private
    FId: Integer;
    FDataOrcamento: TDate;
  public
    property Id: Integer read FId write FId;
    property DataOrcamento: TDate read FDataOrcamento write FDataOrcamento;

    constructor Create; overload;
  end;

implementation

constructor TOrcamentoModel.Create;
begin

end;

end.

