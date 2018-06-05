unit uDBSelect;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBSelect = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function SelectTB_DOORSCHEDULE_DoorNo(aNodeNo,aEcuID,aDoorNo:string):string;
    Function SelectTB_DOOR_ScheduleDoorName(aName:string):string;
    Function SelectTB_Holiday_Year(aYear:string):string;
  end;

var
  dmDBSelect: TdmDBSelect;

implementation
uses
  uCommonVariable;
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDBSelect }

function TdmDBSelect.SelectTB_DOORSCHEDULE_DoorNo(aNodeNo, aEcuID,
  aDoorNo: string): string;
var
  stSql : string;
begin
  stSql := 'select * from TB_DOORSCHEDULE ';
  stSql := stSql + ' where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_ECUID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND DO_DOORNO = ' + aDoorNo + ' ';
  stSql := stSql + ' Order By DS_DAYCODE ';

  result := stSql;
end;

function TdmDBSelect.SelectTB_DOOR_ScheduleDoorName(aName: string): string;
var
  stSql : string;
begin
  stSql := 'Select * ';
  stSql := stSql + ' From TB_DOOR  ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND DO_NAME Like ''%' + aName + '%'' ';
  stSql := stSql + ' AND DO_SCHEDULE = ''1'' ';

  result := stSql;
end;

function TdmDBSelect.SelectTB_Holiday_Year(aYear: string): string;
var
  stSql : string;
begin
  stSql := ' Select HO_DAY,HO_ACUSE,HO_ATUSE,HO_NAME' + inttostr(G_nLangeType) + ' as NAME from TB_HOLIDAY ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if G_nDBType = MSSQL then
    stSql := stSql + ' AND SUBSTRING(HO_DAY,1,4) = ''' + aYear + ''' '
  else if G_nDBType = POSTGRESQL then
    stSql := stSql + ' AND SUBSTR(HO_DAY,1,4) = ''' + aYear + ''' '
  else if G_nDBType = FIREBIRD then
    stSql := stSql + ' AND SUBSTRING(HO_DAY From 1 for 4) = ''' + aYear + ''' ';
  stSql := stSql + ' order by HO_DAY ';

  result := stSql;
end;

end.
