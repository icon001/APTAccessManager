unit uPwChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls,ADODB,ActiveX;

type
  TfmPwChange = class(TForm)
    Label1: TLabel;
    edOrgpw: TEdit;
    Bevel1: TBevel;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    Label2: TLabel;
    edNewPw1: TEdit;
    Label3: TLabel;
    edNewPw2: TEdit;
    procedure sbCancelClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure edOrgpwKeyPress(Sender: TObject; var Key: Char);
    procedure edNewPw1KeyPress(Sender: TObject; var Key: Char);
    procedure edNewPw2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPwChange: TfmPwChange;

implementation

uses
  uDataModule1,DiMime;

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
    TempAdoQuery.Connection := DataModule1.ADOConnection;

    with TempAdoQuery do
    begin
      stSql := 'select * from TB_CURRENTDAEMON ';
      stSql := stSql + ' where GROUP_CODE = ''' + GROUPCODE + '''';
      stSql := stSql + ' and CU_STATECODE = ''Password''';
      stSql := stSql + ' and CU_STATEVALUE = ''' + MimeEncodeString(edOrgPw.Text) + '''';

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

      if (length(edNewPw1.Text) < 6) or (length(edNewPw1.Text) > 12) then
      begin
        showmessage('비밀번호 자릿수는 6~12자리 입니다.');
        Exit;
      end;


      stSql := 'Update TB_CURRENTDAEMON Set CU_STATEVALUE = ''' + MimeEncodeString(edNewPw1.Text) + '''' ;
      stSql := stSql + ' where GROUP_CODE = ''' + GROUPCODE + '''';
      stSql := stSql + ' and CU_STATECODE = ''Password''';

      if   Not DataModule1.ProcessExecSql(stSql) then
      begin
        Showmessage('업데이트에 실패했습니다.');
        Exit;
      end;

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
