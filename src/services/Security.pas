unit Security;

interface

uses
  System.Hash, System.SysUtils, System.RegularExpressions;

type
  TSecurityService = class(TObject)
  public
    class function HashPassword(const Password: string): string;
    class function IsHash(const Value: string): boolean;
  end;

implementation

class function TSecurityService.HashPassword(const Password: string): string;
begin
  try
    Result := THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256);
  except
    on E: Exception do
      raise Exception.Create('Erro ao definir a senha: ' + E.Message);
  end;
end;

class function TSecurityService.IsHash(const Value: string): boolean;
var
  RegEx: TRegEx;
begin
  RegEx := TRegEx.Create('^[0-9A-Fa-f]{64}$', [roIgnoreCase]);
  Result := RegEx.IsMatch(Value);
end;

end.

