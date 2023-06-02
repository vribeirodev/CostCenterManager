unit UserValidatorTest;

interface

uses
  DUnitX.TestFramework,
  UserModel,
  UserValidator;

type
  [TestFixture]
  TUserValidatorTest = class(TObject)
  private
    FUser: TUser;
  public
    [Setup]
    procedure SetUp;
    [TearDown]
    procedure TearDown;

  published
    [Test]
    procedure TestValidUser;
    [Test]
    procedure TestUsernameEmpty;
    [Test]
    procedure TestUsernameTooShort;
    [Test]
    procedure TestPasswordEmpty;
    [Test]
    procedure TestPasswordTooShort;
  end;

implementation

procedure TUserValidatorTest.SetUp;
begin
  FUser := TUser.Create('TestUser', 'TestPass');
end;

procedure TUserValidatorTest.TearDown;
begin
  if Assigned(FUser) then
    FUser.Free;
end;

procedure TUserValidatorTest.TestValidUser;
var
  Username: string;
  Password: string;
begin
  Username := 'TestUser';
  Password := 'TestPass';
  Assert.AreEqual(TUserValidator.Validate(Username, Password), '');
  FUser := TUser.Create(Username, Password);
end;

procedure TUserValidatorTest.TestUsernameEmpty;
var
  Username: string;
  Password: string;
begin
  Username := '';
  Password := 'TestPass';
  Assert.AreEqual(TUserValidator.Validate(Username, Password), 'Nome de usuário não pode ser vazio.');
end;

procedure TUserValidatorTest.TestUsernameTooShort;
var
  Username: string;
  Password: string;
begin
  Username := 'Te';
  Password := 'TestPass';
  Assert.AreEqual(TUserValidator.Validate(Username, Password), 'Nome de usuário deve ter pelo menos 3 caracteres.');
end;

procedure TUserValidatorTest.TestPasswordEmpty;
var
  Username: string;
  Password: string;
begin
  Username := 'TestUser';
  Password := '';
  Assert.AreEqual(TUserValidator.Validate(Username, Password), 'Senha não pode ser vazia.');
end;

procedure TUserValidatorTest.TestPasswordTooShort;
var
  Username: string;
  Password: string;
begin
  Username := 'TestUser';
  Password := '12345';
  Assert.AreEqual(TUserValidator.Validate(Username, Password), 'Senha deve ter pelo menos 6 caracteres.');
end;

initialization
  TDUnitX.RegisterTestFixture(TUserValidatorTest);
end.

