unit uDBDelete;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBDelete = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function DeleteTB_HOLIDAY_DayAll(aDate:string):Boolean;
  end;

var
  dmDBDelete: TdmDBDelete;

implementation
uses
  uCommonVariable,
  uDataBase;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDBDelete }


function TdmDBDelete.DeleteTB_HOLIDAY_DayAll(aDate: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_HOLIDAY ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND HO_DAY = ''' + aDate + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

end.