unit UserModel;

interface

uses
  System.Hash, System.SysUtils, Security;

type
  TUser = class(TObject)
  private
    FUserID   : integer;
    FUsername : string;
    FPassword : string;

    function GetUserID    : integer;
    function GetUsername  : string;
    function GetPassword  : string;

    procedure SetUserID   (const Value: integer);
    procedure SetUsername (const Value: string);
    procedure SetPassword (const Value: string);
  public
    property UserID   : integer read GetUserID   write SetUserID;
    property Username : string  read GetUsername write SetUsername;
    property Password : string  read GetPassword write SetPassword;

    constructor Create(const Username, Password: string); overload;
    constructor Create(const Username, Password: string; UserID: integer); overload;

    function CheckPassword(const Password: string): boolean;
  end;

implementation

constructor TUser.Create(const Username, Password: string);
begin
  Create(Username, Password, 0);
end;

constructor TUser.Create(const Username, Password: string; UserID: integer);
begin
  try
    Self.UserID   := UserID;
    Self.Username := Username;
    Self.Password := Password;
  except
    on E: Exception do
      raise Exception.Create('Error creating user: ' + E.Message);
  end;
end;

function TUser.GetUserID: integer;
begin
  Result := FUserID;
end;

function TUser.GetUsername: string;
begin
  Result := FUsername;
end;

function TUser.GetPassword: string;
begin
  Result := FPassword;
end;

procedure TUser.SetUserID(const Value: integer);
begin
  FUserID := Value;
end;

procedure TUser.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

procedure TUser.SetPassword(const Value: string);
begin
  if not TSecurityService.IsHash(Value) then
    FPassword := TSecurityService.HashPassword(Value)
  else
    FPassword := Value;
end;


function TUser.CheckPassword(const Password: string): boolean;
begin
  Result := Password = FPassword;
end;
end.

