unit uDBInsert;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBInsert = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function InsertIntoTB_ALARMCODE_Value(aCode,aName,aEvent,aSound,aAlarm,aColor:string):Boolean;
    Function InsertIntoTB_CONFIG_All(aCONFIGGROUP,aCONFIGCODE,aCONFIGVALUE:string;aDetail:string=''):Boolean;
    function InsertIntoTB_DOORSCHEDULE_All(aNodeNo,aECUID,aDOORNO,aDayCode,a1Time,a2Time,a3Time,a4Time,a5Time,a1Mode,a2Mode,a3Mode,a4Mode,a5Mode,aRcvAck:string):Boolean;
    Function InsertIntoTB_FormName_Value(aGubun,aCode,aName1,aName2,aName3:string):Boolean;
    Function InsertIntoTB_HOLIDAY_Value(aDay,aName,aAcUse,aAtUse:string):Boolean;
  end;

var
  dmDBInsert: TdmDBInsert;

implementation

uses
  uCommonVariable,
  uDataBase;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDBInsert }

function TdmDBInsert.InsertIntoTB_ALARMCODE_Value(aCode, aName, aEvent, aSound,
  aAlarm, aColor: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_ALARMCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' AE_ALARMCODE,';
  stSql := stSql + ' AE_ALARMNAME,';
  stSql := stSql + ' AE_Event,';
  stSql := stSql + ' AE_Sound,';
  stSql := stSql + ' AE_Alarm,';
  stSql := stSql + ' AE_Color) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''', ';
  stSql := stSql + '' + aEvent + ',';
  stSql := stSql + '' + aSound + ',';
  stSql := stSql + '' + aAlarm + ',';
  stSql := stSql + '' + aColor + ') ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBInsert.InsertIntoTB_CONFIG_All(aCONFIGGROUP, aCONFIGCODE,
  aCONFIGVALUE, aDetail: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CONFIG (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CO_CONFIGGROUP,';
  stSql := stSql + ' CO_CONFIGCODE,';
  stSql := stSql + ' CO_CONFIGVALUE,';
  stSql := stSql + ' CO_CONFIGDETAIL) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCONFIGGROUP + ''', ';
  stSql := stSql + '''' + aCONFIGCODE + ''', ';
  stSql := stSql + '''' + aCONFIGVALUE + ''',';
  stSql := stSql + '''' + aDetail + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_DOORSCHEDULE_All(aNodeNo, aECUID, aDOORNO,
  aDayCode, a1Time, a2Time, a3Time, a4Time, a5Time, a1Mode, a2Mode, a3Mode,
  a4Mode, a5Mode, aRcvAck: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Insert Into TB_DOORSCHEDULE (';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'ND_NODENO,';
  stSql := stSql + 'DE_ECUID,';
  stSql := stSql + 'DO_DOORNO,';
  stSql := stSql + 'DS_DAYCODE,';
  stSql := stSql + 'DS_TIME1,';
  stSql := stSql + 'DS_TIME2,';
  stSql := stSql + 'DS_TIME3,';
  stSql := stSql + 'DS_TIME4,';
  stSql := stSql + 'DS_TIME5,';
  stSql := stSql + 'DS_TIMEMODE1,';
  stSql := stSql + 'DS_TIMEMODE2,';
  stSql := stSql + 'DS_TIMEMODE3,';
  stSql := stSql + 'DS_TIMEMODE4,';
  stSql := stSql + 'DS_TIMEMODE5,';
  stSql := stSql + 'DS_UPDATETIME,';
  stSql := stSql + 'DS_DEVICESYNC )';
  stSql := stSql + ' values (';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + aNodeNo + ',';
  stSql := stSql + '''' + aEcuID + ''',';
  stSql := stSql + '' + aDoorNo + ',';
  stSql := stSql + '''' + aDayCode + ''',';
  stSql := stSql + '''' + a1Time + ''',';
  stSql := stSql + '''' + a2Time + ''',';
  stSql := stSql + '''' + a3Time + ''',';
  stSql := stSql + '''' + a4Time + ''',';
  stSql := stSql + '''' + a5Time + ''',';
  stSql := stSql + '''' + a1Mode + ''',';
  stSql := stSql + '''' + a2Mode + ''',';
  stSql := stSql + '''' + a3Mode + ''',';
  stSql := stSql + '''' + a4Mode + ''',';
  stSql := stSql + '''' + a5Mode + ''',';
  stSql := stSql + '''' + FormatDateTime('yyyymmddhhnnss',now) + ''',';
  stSql := stSql + '''' + aRcvAck + ''' ) ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_FormName_Value(aGubun, aCode, aName1, aName2,
  aName3: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_FormName (';
  stSql := stSql + ' FM_GUBUN,';
  stSql := stSql + ' FM_CODE,';
  stSql := stSql + ' FM_NAME1,';
  stSql := stSql + ' FM_NAME2,';
  stSql := stSql + ' FM_NAME3) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + aGubun + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName1 + ''', ';
  stSql := stSql + '''' + aName2 + ''',';
  stSql := stSql + '''' + aName3 + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_HOLIDAY_Value(aDay, aName, aAcUse,
  aAtUse: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_HOLIDAY(';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' HO_DAY,';
  stSql := stSql + ' HO_ACUSE,';
  stSql := stSql + ' HO_ATUSE,';
  stSql := stSql + ' HO_NAME' + inttostr(G_nLangeType) + ') ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aDay + ''', ';
  stSql := stSql + '''' + aAcUse + ''', ';
  stSql := stSql + '''' + aAtUse + ''', ';
  stSql := stSql + '''' + aName+ ''' ) ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

end.
