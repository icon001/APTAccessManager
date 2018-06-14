unit uDBCreate;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBCreate = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function AlterTB_CARD_CARDCodeADD : Boolean;
    Function AlterTB_DOOR_SCHEDULEAdd : Boolean;
    Function CreateTB_ALARMCODE : Boolean;
    Function CreateTB_ALARMEVENT : Boolean;
    Function CreateTB_CONFIG:Boolean;
    Function CreateTB_DOORSCHEDULE : Boolean;
    Function CreateTB_FORMNAME : Boolean;
    Function CreateTB_HOLIDAY:Boolean;

  end;

var
  dmDBCreate: TdmDBCreate;

implementation

uses
  uCommonVariable,
  uDataBase;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDBCreate }

function TdmDBCreate.AlterTB_CARD_CARDCodeADD: Boolean;
var
  stSql : string;
begin
  stSql := 'ALTER TABLE TB_CARD ADD CA_CODE CHAR(50) NULL ';
  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'CHAR','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.AlterTB_DOOR_SCHEDULEAdd: Boolean;
var
  stSql : string;
begin
  stSql := 'ALTER TABLE TB_DOOR ADD DO_SCHEDULE CHAR(1) NULL ';
  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'CHAR','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_ALARMCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_ALARMCODE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' AE_ALARMCODE varchar(2) NOT NULL,';
  stSql := stSql + ' AE_ALARMNAME varchar(100) ,';
  stSql := stSql + ' AE_Event Integer,';
  stSql := stSql + ' AE_Sound integer ,';
  stSql := stSql + ' AE_Alarm integer ,';
  stSql := stSql + ' AE_Color integer ,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,AE_ALARMCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_ALARMEVENT: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_ALARMEVENT(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' AE_DATE varchar(8) NOT NULL,';
  stSql := stSql + ' AE_TIME varchar(9) NOT NULL,';
  stSql := stSql + ' ND_NODENO integer NOT NULL,';
  stSql := stSql + ' DE_ECUID varchar(2) NOT NULL,';
  stSql := stSql + ' DO_DOORNO integer NOT NULL,';
  stSql := stSql + ' AE_ALARMCODE varchar(2) NOT NULL,';
  stSql := stSql + ' AE_INSERTTIME varchar(17) ,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,AE_DATE,AE_TIME,ND_NODENO,DE_ECUID,DO_DOORNO,AE_ALARMCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CONFIG: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CONFIG(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CO_CONFIGGROUP varchar(20) NOT NULL,';
  stSql := stSql + ' CO_CONFIGCODE varchar(30) NOT NULL,';
  stSql := stSql + ' CO_CONFIGVALUE varchar(50),';
  stSql := stSql + ' CO_CONFIGDETAIL varchar(100),';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CO_CONFIGGROUP,CO_CONFIGCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DOORSCHEDULE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DOORSCHEDULE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' ND_NODENO integer NOT NULL,';
  stSql := stSql + ' DE_ECUID varchar(2) NOT NULL,';
  stSql := stSql + ' DO_DOORNO integer NOT NULL,';
  stSql := stSql + ' DS_DAYCODE char(1) NOT NULL,';
  stSql := stSql + ' DS_TIME1 varchar(4) DEFAULT ''0500'' NOT NULL,';
  stSql := stSql + ' DS_TIMEMODE1 char(1) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' DS_TIME2 varchar(4) DEFAULT ''1200'' NOT NULL,';
  stSql := stSql + ' DS_TIMEMODE2 char(1) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' DS_TIME3 varchar(4) DEFAULT ''1300'' NOT NULL,';
  stSql := stSql + ' DS_TIMEMODE3 char(1) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' DS_TIME4 varchar(4) DEFAULT ''1600'' NOT NULL,';
  stSql := stSql + ' DS_TIMEMODE4 char(1) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' DS_TIME5 varchar(4) DEFAULT ''0000'' NOT NULL,';
  stSql := stSql + ' DS_TIMEMODE5 char(1) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' DS_DEVICESYNC char(1) DEFAULT ''N'' NOT NULL,';
  stSql := stSql + ' DS_UPDATETIME varchar(14) ,';
  stSql := stSql + ' AD_USERID varchar(30) ,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,ND_NODENO,DE_ECUID,DO_DOORNO,DS_DAYCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_FORMNAME: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_FORMNAME(';
  stSql := stSql + ' FM_GUBUN char(1)  NOT NULL,';
  stSql := stSql + ' FM_CODE varchar(50) NOT NULL,';
  stSql := stSql + ' FM_NAME1 varchar(100),';
  stSql := stSql + ' FM_NAME2 varchar(100),';
  stSql := stSql + ' FM_NAME3 varchar(100),';
  stSql := stSql + ' PRIMARY KEY (FM_GUBUN,FM_CODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_HOLIDAY: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_HOLIDAY(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' HO_DAY varchar(8) NOT NULL,';
  stSql := stSql + ' HO_ACUSE char(1) DEFAULT ''1'' NOT NULL,';
  stSql := stSql + ' HO_ATUSE char(1) DEFAULT ''1'' NOT NULL,';
  stSql := stSql + ' HO_NAME1 varchar(100),';
  stSql := stSql + ' HO_NAME2 varchar(100),';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,HO_DAY) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'image','OLEObject',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'image','oid',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

end.
