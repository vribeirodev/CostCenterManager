unit UserControllerTest;

interface

uses
  DUnitX.TestFramework,
  UserController,
  UserDAO,
  UserModel,
  SysUtils;

type
  [TestFixture]
  TUserControllerTest = class(TObject)
  private
    FUserController: TUserController;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestCreateUser;
    [Test]
    procedure TestCreateUserException;
  end;

implementation

procedure TUserControllerTest.Setup;
begin
  FUserController := TUserController.Create(TUserDAO.Create);
end;

procedure TUserControllerTest.TearDown;
begin
  FUserController.Free;
end;

procedure TUserControllerTest.TestCreateUser;
var
  Result: Boolean;
begin
  Result := FUserController.CreateUser('testuser', 'testpassword');
  Assert.IsTrue(Result, 'User creation failed');
end;

procedure TUserControllerTest.TestCreateUserException;
begin
  Assert.WillRaise(
    procedure
    begin
      FUserController.CreateUser('', '');
    end,
    Exception,
    'An exception was not raised for an invalid user'
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TUserControllerTest);
end.

