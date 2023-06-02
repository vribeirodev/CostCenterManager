unit SecurityTests;

interface

uses
  DUnitX.TestFramework, Security, System.Hash;

type

  [TestFixture]
  TSecurityTests = class(TObject)
  public
    [Test]
    procedure TestHashPassword;
    [Test]
    procedure TestIsHash;
  end;

implementation

procedure TSecurityTests.TestHashPassword;
var
  Password: string;
  HashedPassword: string;
  ExpectedHashedPassword: string;
begin
  Password := 'testPassword';
  HashedPassword := TSecurityService.HashPassword(Password);

  // Compara com o hash gerado diretamente pela função de hash
  ExpectedHashedPassword := THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256);

  Assert.AreEqual(ExpectedHashedPassword, HashedPassword);
end;

procedure TSecurityTests.TestIsHash;
var
  Hash, NotHash: string;
begin
  Hash := '4E07408562BEDB8B60CE05C1DECFE3AD16B72230967DE01F640B7E4729B49FCE'; // SHA256 hash de 'Hello World'
  NotHash := 'Hello World';

  // Verifica se IsHash retorna verdadeiro para uma string que é um hash
  Assert.IsTrue(TSecurityService.IsHash(Hash));

  // Verifica se IsHash retorna falso para uma string que não é um hash
  Assert.IsFalse(TSecurityService.IsHash(NotHash));
end;


initialization
  TDUnitX.RegisterTestFixture(TSecurityTests);

end.

