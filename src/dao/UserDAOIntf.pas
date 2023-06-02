unit UserDAOIntf;

interface

uses
  System.Generics.Collections,
  UserModel;

type
  {$M+}
  IUserDAO = interface(IInterface)
    ['{B4E1D7D7-0505-49A7-B8B4-53062F68D034}']
    function Insert(User: TUser): Integer;
    function Update(User: TUser): Boolean;
    function Delete(User: TUser): Boolean;
    function Select(UserID: Integer): TUser;
    function SelectByUsername(const Username: string): TUser;
    function GetAll: TObjectList<TUser>;
  end;

implementation

end.

