unit uDBFormName;

interface

uses
  System.SysUtils, System.Classes,Data.Win.ADODB,Winapi.ActiveX;

type
  TdmFormName = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function GetFormMessage(aGubun,aCode:string):string;
  end;

var
  dmFormName: TdmFormName;

implementation
uses
  uDataBase,
  uCommonVariable;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule1 }

function TdmFormName.GetFormMessage(aGubun, aCode: string): string;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := '';
  stSql := ' Select FM_NAME' + inttostr(G_nLangeType) + ' as NAME from TB_FORMNAME ';
  stSql := stSql + ' Where FM_GUBUN = ''' + aGubun + ''' ';
  stSql := stSql + ' AND FM_CODE = ''' + aCode + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery  do
    begin
      Close;
      SQL.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit;
      result := FindField('NAME').AsString;
    end;

  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

end.
