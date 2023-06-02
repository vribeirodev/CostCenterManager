unit UserValidator;

interface

uses
  UserModel, System.SysUtils;

const
  ERR_USERNAME_EMPTY      = 'Nome de usuário não pode ser vazio.';
  ERR_USERNAME_TOO_SHORT  = 'Nome de usuário deve ter pelo menos 3 caracteres.';
  ERR_PASSWORD_EMPTY      = 'Senha não pode ser vazia.';
  ERR_PASSWORD_TOO_SHORT  = 'Senha deve ter pelo menos 6 caracteres.';

type
  TUserValidator = class
  public
    class function Validate(const Username, Password: string): string;
  end;

implementation

class function TUserValidator.Validate(const Username, Password: string): string;
begin
  if Username.Trim = '' then
    Exit(ERR_USERNAME_EMPTY);

  if Length(Username) < 3 then
    Exit(ERR_USERNAME_TOO_SHORT);

  if Password.Trim = '' then
    Exit(ERR_PASSWORD_EMPTY);

  if Length(Password) < 6 then
    Exit(ERR_PASSWORD_TOO_SHORT);

  Result := '';
end;

end.

