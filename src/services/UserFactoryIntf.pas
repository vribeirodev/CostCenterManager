unit UserFactoryIntf;

interface

uses
  UserModel;

type
  {$M+}
  IUserFactory = interface
    ['{A254E5A1-20E8-4C7E-8A6C-E0B194E10E3D}']
    function CreateUser(const Username, Password: string): TUser;
  end;

implementation

end.
