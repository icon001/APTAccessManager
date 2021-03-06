unit uPwChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls,ADODB,ActiveX, AdvAppStyler;

type
  TfmPwChange = class(TForm)
    lb_OldPassword: TLabel;
    edOrgpw: TEdit;
    Bevel1: TBevel;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    lb_NewPassword: TLabel;
    edNewPw1: TEdit;
    lb_ReNewPassword: TLabel;
    edNewPw2: TEdit;
    AdvFormStyler1: TAdvFormStyler;
    procedure sbCancelClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure edOrgpwKeyPress(Sender: TObject; var Key: Char);
    procedure edNewPw1KeyPress(Sender: TObject; var Key: Char);
    procedure edNewPw2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPwChange: TfmPwChange;

implementation

uses
  uDataBase,
  uDBFormName,
  uDBFunction,
  DiMime,
  uCommonVariable,
  uFunction;

{$R *.dfm}

procedure TfmPwChange.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmPwChange.sbSaveClick(Sender: TObject);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      stSql := 'select * from TB_ADMIN ';
      stSql := stSql + ' where GROUP_CODE = ''' + G_stGroupCode + '''';
      stSql := stSql + ' and AD_USERID = ''ADMIN''';
      stSql := stSql + ' and AD_PASSWD = ''' + MimeEncodeString(edOrgPw.Text) + '''';

      Close;
      Sql.Clear;
      Sql.Text := stSql;
      Try
        Open;
      Except
        showmessage('데이터베이스 오픈 실패');
        Exit;
      End;

      if RecordCount < 1 then
      begin
        showmessage('기존 사용 비밀번호가 틀립니다.');
        Exit;
      end;

      if edNewPw1.Text <> edNewPw2.Text then
      begin
        showmessage('신규 비밀번호가 올바르지 않습니다.');
        Exit;
      end;

      if Not (length(edNewPw1.Text) = 4) then
      begin
        showmessage('비밀번호 자릿수는 4자리 입니다.');
        Exit;
      end;

      if Not isdigit(edNewPw1.Text) then
      begin
        showmessage('비밀번호는 숫자 4자리 입니다.');
        Exit;
      end;


      stSql := 'Update TB_ADMIN Set AD_PASSWD = ''' + MimeEncodeString(edNewPw1.Text) + ''',' ;
      stSql := stSql + ' AD_RCVACK = ''N'' ';
      stSql := stSql + ' where GROUP_CODE = ''' + G_stGroupCode + '''';
      stSql := stSql + ' and AD_USERID = ''ADMIN''';

      if   Not dmDataBase.ProcessExecSql(stSql) then
      begin
        Showmessage('업데이트에 실패했습니다.');
        Exit;
      end;
      G_stMasterNo := edNewPw1.Text;
      dmDBFunction.updateTB_DOOR_AllMasterRcvAck('N');
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;

  Close;

end;

procedure TfmPwChange.edOrgpwKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edNewPw1.SetFocus;
  end;
end;

procedure TfmPwChange.FormCreate(Sender: TObject);
begin
  lb_OldPassword.Caption := dmFormName.GetFormMessage('4','M00104');
  lb_NewPassword.Caption := dmFormName.GetFormMessage('4','M00105');
  lb_ReNewPassword.Caption := dmFormName.GetFormMessage('4','M00106');
  sbSave.Caption := dmFormName.GetFormMessage('4','M00090');
  sbCancel.Caption := dmFormName.GetFormMessage('4','M00051');
end;

procedure TfmPwChange.edNewPw1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edNewPw2.SetFocus;
  end;

end;

procedure TfmPwChange.edNewPw2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    sbSaveClick(Self);
  end;

end;

end.
