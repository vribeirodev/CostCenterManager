unit DBConfigValidator;

interface

uses
  DBConfig;
type
  TDBConfigValidator = class
  public
    class function AreFieldsValid(DBConfig: TDBConfig): Boolean;
  end;

implementation

class function TDBConfigValidator.AreFieldsValid(DBConfig: TDBConfig): Boolean;
begin
  Result := (DBConfig.Database  <> '') and
            (DBConfig.Username  <> '') and
            (DBConfig.Password  <> '') and
            (DBConfig.Server    <> '') and
            (DBConfig.Port      <> '');
end;
end.
