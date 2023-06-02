unit UserControllerTests;

interface

uses
  DUnitX.TestFramework, Delphi.Mocks, UserController, UserDAOIntf, UserModel, UserFactoryIntf;

type
  [TestFixture]
  TUserControllerTest = class
  private
    FUserController: TUserController;
    TestUser: TUser;
    FUserDAOMock: TMock<IUserDAO>;
    FUserFactoryMock: TMock<IUserFactory>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure CreateUser_WithValidParameters_ShouldReturnUserID;

    [Test]
    procedure UpdateUser_WithValidParameters_ShouldReturnTrue;

    [Test]
    procedure DeleteUser_ExistingUser_ShouldReturnTrue;

    [Test]
    procedure GetUser_WithValidID_ShouldReturnUser;

    [Test]
    procedure Authenticate_WithValidCredentials_ShouldReturnTrue;
  end;

implementation

procedure TUserControllerTest.Setup;
var
  TestUserID: Integer;
begin
  FUserDAOMock := TMock<IUserDAO>.Create;
  FUserFactoryMock := TMock<IUserFactory>.Create; // Crie o mock IUserFactory

  TestUser := TUser.Create('TestUser', 'TestPassword');

  TestUserID := 1;

  // Configure o mock IUserFactory para retornar TestUser
  FUserFactoryMock.Setup.WillReturn(TestUser).When.CreateUser(TestUser.Username, TestUser.Password);

  // Configure o mock IUserDAO para retornar TestUserID para qualquer usuário
  FUserDAOMock.Setup.WillReturn(TestUserID).When.Insert(TestUser);


  FUserDAOMock.Setup.WillReturn(TestUser).When.Select(TestUserID);
  FUserDAOMock.Setup.WillReturn(True).When.Update(TestUser);
  FUserDAOMock.Setup.WillReturn(True).When.Delete(TestUser);

  // Passe o mock IUserFactory para o controlador
  FUserController := TUserController.Create(FUserDAOMock.Instance, FUserFactoryMock.Instance);
end;

procedure TUserControllerTest.TearDown;
begin
  FUserController.Free;
  FUserDAOMock.Free;
end;

procedure TUserControllerTest.CreateUser_WithValidParameters_ShouldReturnUserID;
var
  UserID: Integer;
begin
  UserID := FUserController.CreateUser(TestUser.Username, TestUser.Password);

  Assert.AreEqual(1, UserID);
end;


procedure TUserControllerTest.UpdateUser_WithValidParameters_ShouldReturnTrue;
var
  Result: Boolean;
begin
  Result := FUserController.UpdateUser(TestUser);

  Assert.IsTrue(Result);
end;

procedure TUserControllerTest.DeleteUser_ExistingUser_ShouldReturnTrue;
var
  Result: Boolean;
begin
  Result := FUserController.DeleteUser(TestUser);

  Assert.IsTrue(Result);
end;

procedure TUserControllerTest.GetUser_WithValidID_ShouldReturnUser;
var
  ResultUser: TUser;
begin
  ResultUser := FUserController.GetUser(1);

  Assert.AreEqual(TestUser.Username, ResultUser.Username);
  Assert.AreEqual(TestUser.Password, ResultUser.Password);
end;

procedure TUserControllerTest.Authenticate_WithValidCredentials_ShouldReturnTrue;
var
  Result: Boolean;
begin
  FUserDAOMock.Setup.WillReturn(TestUser).When.SelectByUsername(TestUser.Username);

  Result := FUserController.AuthenticateUser(TestUser);

  Assert.IsTrue(Result);
end;

initialization
  TDUnitX.RegisterTestFixture(TUserControllerTest);
end.

