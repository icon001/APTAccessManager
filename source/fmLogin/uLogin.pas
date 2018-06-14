unit uLogin;
 
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls,ADODB,ActiveX, DB, AdvAppStyler;

type

  TLogin = class(TComponent)
  private
    FLogined: Boolean;
    class function FindSelf:TComponent;
    procedure SetLogined(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    Procedure ShowLoginDlg;
    class Function GetObject:TLogin;   //자기자신을 찾는것  class 는 폼생성전에도 사용가능
  Published
    { Published declarations }
    Property Logined : Boolean read FLogined write SetLogined;
  end;

  TfmLogin = class(TForm)
    lb_Passwd: TLabel;
    edPassword: TEdit;
    Bevel1: TBevel;
    sbLogin: TSpeedButton;
    sbCancel: TSpeedButton;
    ADOQuery: TADOQuery;
    AdvFormStyler1: TAdvFormStyler;
    procedure sbCancelClick(Sender: TObject);
    procedure sbLoginClick(Sender: TObject);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure FormNameSetting;
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

uses
  uDataBase,
  uDBFormName,
  DIMime,
  uCommonVariable;

{$R *.dfm}

{ TLogin }

class function TLogin.FindSelf: TComponent;
var
  Loop:Integer;
begin
  Result:=Nil;
  for Loop:=0 to Application.ComponentCount-1 do begin
      if Application.Components[Loop] is TLogin then begin
          Result:= Application.Components[Loop];
          Break;
      end;
  end;
end;

class function TLogin.GetObject: TLogin;
begin
   If FindSelf = Nil then TLogin.Create(Application);
   Result := TLogin(FindSelf);
end;

procedure TLogin.SetLogined(const Value: Boolean);
begin
  FLogined := Value;
end;

procedure TLogin.ShowLoginDlg;
begin
  FLogined := False;

  fmLogin:=TfmLogin.Create(Nil);
  Try
    fmLogin.ShowModal;
  Finally
    fmLogin.Free;
  End;
end;

procedure TfmLogin.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('4','M00057');
  lb_Passwd.Caption := dmFormName.GetFormMessage('4','M00058');
  sbLogin.Caption := dmFormName.GetFormMessage('4','M00059');
  sbCancel.Caption := dmFormName.GetFormMessage('4','M00051');
end;

procedure TfmLogin.FormShow(Sender: TObject);
begin
  FormNameSetting;
end;

procedure TfmLogin.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmLogin.sbLoginClick(Sender: TObject);
var
  stSql : string;
begin

  TLogin.GetObject.Logined  := False ;
  with dmDataBase.ADOQuery do
  begin
    stSql := 'select * from TB_ADMIN ';
    stSql := stSql + ' where GROUP_CODE = ''' + G_stGroupCode + '''';
    stSql := stSql + ' and AD_USERID = ''ADMIN''';
    stSql := stSql + ' and AD_PASSWD = ''' + MimeEncodeString(edPassword.Text) + '''';

    Close;
    Sql.Clear;
    Sql.Text := stSql;
    Try
      Open;
    Except
      showmessage(dmFormName.GetFormMessage('2','M00038'));
      Exit;
    End;

    if RecordCount < 1 then
    begin
      showmessage(dmFormName.GetFormMessage('2','M00039'));
      Exit;
    end;
  end;
  G_stMasterNo := edPassword.Text;
  TLogin.GetObject.Logined  := True ;
  Close;
end;

procedure TfmLogin.edPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    sbLoginClick(Self);
  end;
end;

end.
