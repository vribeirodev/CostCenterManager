unit UserDAOTest;

interface

uses
  System.Generics.Collections,
  DUnitX.TestFramework,
  UserModel,
  UserDAO,
  DBConn,
  DBConfig;

type

  [TestFixture]
  TUserDAOTest = class(TObject)
  private
    FUserDAO: TUserDAO;
    FUser: TUser;
    DBConfig: TDBConfig;
  public
    [Setup]
    procedure SetUp;
    [TearDown]
    procedure TearDown;
  published
    [Test]
    procedure TestInsertAndSelect;
    [Test]
    procedure TestUpdate;
    [Test]
    procedure TestDelete;
    [Test]
    procedure TestGetAll;
    [Test]
    procedure TestSelectByUsername;
  end;

implementation

procedure TUserDAOTest.SetUp;
begin
  DBConfig := TDBConfig.Create('C:\Users\Vinicius Ribeiro\Documents\Projetos\CostCenterManager\database\DATABASE.FDB',
                                 'sysdba',
                                 'masterkey',
                                 'localhost',
                                 '3050');
  TDBConn.SetConfig(DBConfig);


  FUserDAO := TUserDAO.Create;
  FUser := TUser.Create('userTest', 'tespass');
end;

procedure TUserDAOTest.TearDown;
begin
  FUserDAO.Free;
  FUser.Free;
  DBConfig.Free;
end;

procedure TUserDAOTest.TestInsertAndSelect;
var
  NewUserID: Integer;
  User: TUser;
begin
  // Test Insert
  NewUserID := FUserDAO.Insert(FUser);
  FUser.UserID := NewUserID;
  Assert.IsTrue(NewUserID > 0, 'Failed on Insert');

  // Test Select
  User := FUserDAO.Select(NewUserID);
  try
    Assert.IsNotNull(User, 'Failed on Select');
    Assert.AreEqual(FUser.Username, User.Username, 'Username does not match');
    Assert.IsTrue(User.CheckPassword(FUser.Password), 'Password does not match');
  finally
    User.Free;
  end;
end;


procedure TUserDAOTest.TestUpdate;
begin
  Assert.IsTrue(FUserDAO.Update(FUser), 'Failed on Update');
end;

procedure TUserDAOTest.TestDelete;
begin
  Assert.IsTrue(FUserDAO.Delete(FUser), 'Failed on Delete');
end;

procedure TUserDAOTest.TestGetAll;
var
  Users: TObjectList<TUser>;
begin
  Users := FUserDAO.GetAll;
  try
    Assert.IsTrue(Users.Count > 0, 'No users found');
  finally
    Users.Free;
  end;
end;

procedure TUserDAOTest.TestSelectByUsername;
var
  User: TUser;
begin
  FUserDAO.Insert(FUser);

  User := FUserDAO.SelectByUsername(FUser.Username);

  try
    Assert.IsNotNull(User, 'Failed on SelectByUsername');
    Assert.AreEqual(FUser.Username, User.Username, 'Username does not match');
    Assert.IsTrue(User.CheckPassword(FUser.Password), 'Password does not match');
  finally
    User.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TUserDAOTest);

end.

