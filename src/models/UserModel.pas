unit UserModel;

interface

type
  TUser = class(TObject)
  private
    FUsername: string;
    FPassword: string;
  public
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;

    constructor Create(const Username, Password: string);
  end;

implementation

constructor TUser.Create(const Username, Password: string);
begin
  FUsername := Username;
  FPassword := Password;
end;

end.
