unit ResumoObserverIntf;

interface

uses
  CentroCustoModel;

type
  {$M+}
  IResumoObserver = interface
    ['{3D5AA5B3-44DA-4ED6-9ACF-94D778D50008}']
    procedure Atualizar(const centroCusto: TCentroCusto);
  end;


implementation

end.
