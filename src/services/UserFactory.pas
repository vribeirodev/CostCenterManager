unit UserFactory;

interface

uses
  UserModel,
  UserFactoryIntf;

type
  TUserFactory = class(TInterfacedObject, IUserFactory)
  public
    function CreateUser(const Username, Password: string): TUser;
  end;

implementation

function TUserFactory.CreateUser(const Username, Password: string): TUser;
begin
  Result := TUser.Create(Username, Password);
end;

end.

