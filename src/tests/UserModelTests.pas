unit UserModelTests;

interface

uses
  DUnitX.TestFramework, UserModel, Security;

type

  [TestFixture]
  TUserModelTests = class(TObject)
  public
    [Test]
    procedure TestCreateUser;
    [Test]
    procedure TestSetAndGetUsername;
    [Test]
    procedure TestSetAndGetPassword;
    [Test]
    procedure TestSetAndGetUserID;
  end;

implementation

procedure TUserModelTests.TestCreateUser;
var
  User: TUser;
begin
  User := TUser.Create('testUsername', 'testPassword');
  try
    Assert.IsNotNull(User);
  finally
    User.Free;
  end;
end;

procedure TUserModelTests.TestSetAndGetUsername;
var
  User: TUser;
  Username: string;
begin
  User := TUser.Create('testUsername', 'testPassword');
  try
    Username := 'newUsername';
    User.Username := Username;
    Assert.AreEqual(Username, User.Username);
  finally
    User.Free;
  end;
end;

procedure TUserModelTests.TestSetAndGetPassword;
var
  User: TUser;
  Password: string;
begin
  User := TUser.Create('testUsername', 'testPassword');
  try
    Password := 'newPassword';
    User.Password := Password;
    Assert.IsTrue(User.CheckPassword(User.Password), 'The password does not match');
  finally
    User.Free;
  end;
end;


procedure TUserModelTests.TestSetAndGetUserID;
var
  User: TUser;
  UserID: integer;
begin
  User := TUser.Create('testUsername', 'testPassword', 123);
  try
    UserID := 456;
    User.UserID := UserID;
    Assert.AreEqual(UserID, User.UserID);
  finally
    User.Free;
  end;
end;

[Test]
procedure TestSetPasswordWithHash;
var
  User: TUser;
  Password, PasswordHash: string;
begin
  Password := 'newPassword';
  PasswordHash := TSecurityService.HashPassword(Password);

  User := TUser.Create('testUsername', 'testPassword');
  try
    User.Password := PasswordHash;

    // Verifica se a senha armazenada é o hash e não o texto original
    Assert.AreEqual(PasswordHash, User.Password);

    // Verifica se a senha ainda pode ser verificada corretamente
    Assert.IsTrue(User.CheckPassword(Password), 'The password does not match');
  finally
    User.Free;
  end;
end;


initialization
  TDUnitX.RegisterTestFixture(TUserModelTests);

end.

