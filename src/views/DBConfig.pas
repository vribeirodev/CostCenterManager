unit DBConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Layout, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormDBConfig = class(TFormLayout)
    pnlTitle: TPanel;
    lblTitle: TLabel;
    pnlLineTitle: TPanel;
    pnlDatabase: TPanel;
    lblDatabase: TLabel;
    pnlLineDatabase: TPanel;
    edtDatabase: TEdit;
    btnDatabase: TSpeedButton;
    procedure btnDatabaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDBConfig: TFormDBConfig;

implementation

{$R *.dfm}

procedure TFormDBConfig.btnDatabaseClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
  FileTypeItem: TFileTypeItem;
begin
  Dialog := TFileOpenDialog.Create(nil);
  try
    Dialog.Options := [fdoFileMustExist];
    Dialog.DefaultFolder := GetCurrentDir;

    FileTypeItem := Dialog.FileTypes.Add;
    FileTypeItem.DisplayName := 'Firebird files';
    FileTypeItem.FileMask := '*.fdb';

    if Dialog.Execute then
      edtDatabase.Text := Dialog.FileName;
  finally
    Dialog.Free;
  end;
end;

end.
