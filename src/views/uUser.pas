unit uUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uLayout, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, UserController, UserDAO, UserFactory, UserModel, System.Generics.Collections;

type
  TFormUser = class(TFormLayout)
    edtUsername: TEdit;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    grdUsers: TStringGrid;
    btnExcluir: TButton;
    btnNovo: TButton;
    btnAlterar: TButton;
    procedure FormShow(Sender: TObject);
    procedure grdUsersSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FUser: TUser;
    FIsEditing: Boolean;
    FController: TUserController;
    procedure LoadUsersIntoGrid;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormUser: TFormUser;

implementation

{$R *.dfm}

procedure TFormUser.btnAlterarClick(Sender: TObject);
begin
  if grdUsers.Row > 0 then
  begin
    edtUsername.Enabled := True;
    edtPassword.Enabled := True;

    edtPassword.Text := '';
    FIsEditing := True;
    btnNovo.Caption := 'Salvar';
    btnAlterar.Caption := 'Cancelar';
    btnAlterar.OnClick := btnCancelarClick;
  end
  else
    ShowMessage('Nenhum usuário selecionado.');
end;

procedure TFormUser.btnCancelarClick(Sender: TObject);
begin

  edtUsername.Enabled := False;
  edtPassword.Enabled := False;
  edtUsername.Text := '';
  edtPassword.Text := '';
  FIsEditing := False;
  btnNovo.Caption := 'Novo';
  btnAlterar.Caption := 'Alterar';
  btnAlterar.OnClick := btnAlterarClick;
  end;

procedure TFormUser.btnNovoClick(Sender: TObject);
var
  NewUserID: Integer;
begin
  if FIsEditing then
  begin
    if Assigned(FUser) then
    begin

      FUser.Username := edtUsername.Text;
      FUser.Password := edtPassword.Text;

      if FController.UpdateUser(FUser) then
      begin
        ShowMessage('Usuário atualizado com sucesso.');
        LoadUsersIntoGrid;
      end
      else
        ShowMessage('Falha ao atualizar usuário.');
    end
    else
    begin

      FUser := TUser.Create;
      FUser.Username := edtUsername.Text;
      FUser.Password := edtPassword.Text;

      NewUserID := FController.CreateUser(FUser.Username, FUser.Password);
      if NewUserID > 0 then
      begin
        ShowMessage('Usuário criado com sucesso.');
        LoadUsersIntoGrid;
      end
      else
        ShowMessage('Falha ao criar usuário.');
    end;


    edtUsername.Text := '';
    edtPassword.Text := '';
    edtUsername.Enabled := False;
    edtPassword.Enabled := False;

    btnNovo.Caption := 'Novo';
    FIsEditing := False;

    btnAlterar.Caption := 'Alterar';
    btnAlterar.OnClick := btnAlterarClick;

  end
  else
  begin
    FUser := nil;

    edtUsername.Text := '';
    edtPassword.Text := '';

    edtUsername.Enabled := True;
    edtPassword.Enabled := True;

    edtUsername.SetFocus;
    btnNovo.Caption := 'Salvar';
    FIsEditing := True;

    btnAlterar.Caption := 'Cancelar';
    btnAlterar.OnClick := btnCancelarClick;
  end;
end;

constructor TFormUser.Create(AOwner: TComponent);
begin
  inherited;
  FController := TUserController.Create(TUserDAO.Create, TUserFactory.Create);


  edtUsername.Enabled := False;
  edtPassword.Enabled := False;
end;

destructor TFormUser.Destroy;
begin
  FController.Free;
  inherited;
end;

procedure TFormUser.FormShow(Sender: TObject);
var
  MaxWidth: Integer;
  I: Integer;
begin
  inherited;
  FUser := nil;
  FIsEditing := False;
  btnNovo.Caption := 'Novo';

  btnAlterar.Caption := 'Alterar';
  btnAlterar.OnClick := btnAlterarClick;

  LoadUsersIntoGrid;

  for I := 0 to grdUsers.ColCount - 1 do
  begin
    MaxWidth := Canvas.TextWidth(grdUsers.Cells[I, 0]);
    grdUsers.ColWidths[I] := MaxWidth + 20;
  end;
end;

procedure TFormUser.LoadUsersIntoGrid;
var
  Users: TObjectList<TUser>;
  I: Integer;
begin
  Users := FController.GetAllUsers;

  grdUsers.ColCount := 2;


  grdUsers.Cells[0, 0] := 'Id';
  grdUsers.Cells[1, 0] := 'User Name';

  grdUsers.RowCount := Users.Count + 1;

  for I := 0 to Users.Count - 1 do
  begin
    grdUsers.Cells[0, I + 1] := IntToStr(Users[I].UserID);
    grdUsers.Cells[1, I + 1] := Users[I].Username;


    grdUsers.Objects[0, I + 1] := Users[I];
  end;
end;

procedure TFormUser.grdUsersSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  FUser := TUser(grdUsers.Objects[0, ARow]);
  if Assigned(FUser) then
  begin
    edtUsername.Text := FUser.Username;
    edtPassword.Text := '********';
  end;
end;

procedure TFormUser.btnExcluirClick(Sender: TObject);
begin
  if Assigned(FUser) then
  begin
    if MessageDlg('Tem certeza de que deseja excluir este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if FController.DeleteUser(FUser) then
      begin
        ShowMessage('Usuário excluído com sucesso.');
        FUser := nil;
        LoadUsersIntoGrid;
      end
      else
        ShowMessage('Falha ao excluir usuário.');
    end;
  end
  else
    ShowMessage('Nenhum usuário selecionado.');
end;

end.
