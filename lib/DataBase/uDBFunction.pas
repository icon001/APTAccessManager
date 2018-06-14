unit uDBFunction;

interface

uses
  System.SysUtils, System.Classes,ADODB,ActiveX;

type
  TdmDBFunction = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function checkTB_DOORSCHEDULE_DayCode(aNodeNo,aEcuID,aDoorNo,aDayCode:string):integer;
    function CheckTB_HOLIDAY_Date(aDate:string):integer;

    function CopyHolidayToAllDevice(aDate:string):Boolean;

    Function DeleteTB_DEVICECARDNO_CardNoPermit(aNodeNo,aEcuID,aCardNo,aPermit:string):Boolean; //카드삭제 응답시 카드권한 필드 삭제
    Function DeleteTB_DEVICEPASSWD_PasswordPermit(aNodeNo,aEcuID,aPassword,aPermit:string):Boolean; //카드삭제 응답시 카드권한 필드 삭제

    Function InsertTB_ACCESSEVENT(aDate,aTime,aNodeNo,aEcuID,aDoorNo,aCardNo,aReaderNo,aButton,aPosi,aInputType,aDoorMode,aPermitMode,aPermitCode:string):Boolean;
    Function InsertTB_ALARMEVENT(aDate,aTime, aNodeNo, aEcuID, aDoorNo, aAlarmCode:string):Boolean;
    Function InsertTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo, aDeviceID,aDoorNo,aPermit:string):Boolean;
    Function InsertTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo, aDeviceID,aDoorNo,aPermit:string):Boolean;

    Function UpdateTB_CARDCardAsync(aCardNo,aAsync:string):Boolean;  //카드 권한 동기화 여부
    Function UpdateTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo, aDeviceID,aDoorNo,aPermit:string):Boolean;  //카드출입권한 수정
    Function UpdateTB_DEVICECARDNO_AllState(OrgState,NewState:String):Boolean;   //권한전송 상태 변경
    Function UpdateTB_DEVICECARDNO_CardNoState(aNodeNo,aEcuID,aCardNo,aOldState,aNewState:String):Boolean;
    Function UpdateTB_DEVICECARDNO_DeviceState(aNodeNo,aEcuID,aState:String):Boolean;    //기기교체시 기기전체권한 상태 변경
    Function UpdateTB_DEVICECARDNO_DeviceStateChange(aNodeNo,aEcuID,aOldState,aState:String):Boolean;    //DisConnect시 비밀번호 전송 상태 변경
    Function UpdateTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo, aDeviceID,aDoorNo,aPermit:string):Boolean;  //비밀번호출입권한 수정
    Function UpdateTB_DEVICEPASSWD_PasswordDelete(aPassword:String):Boolean;   //권한전송 상태 변경
    Function UpdateTB_DEVICEPASSWD_AllState(OrgState,NewState:String):Boolean;   //권한전송 상태 변경
    Function UpdateTB_DEVICEPASSWD_DeviceState(aNodeNo,aEcuID,aState:String):Boolean;  //기기교체시 비밀번호 전체 상태 변경
    Function UpdateTB_DEVICEPASSWD_DeviceStateChange(aNodeNo,aEcuID,aOldState,aState:String):Boolean;  //DisConnect시 비밀번호 전송 상태 변경
    Function UpdateTB_DEVICEPASSWD_PasswordState(aNodeNo,aEcuID,aPassword,aOldState,aNewState:String):Boolean;
    Function updateTB_DOOR_AllMasterRcvAck(aRcvAck:string):Boolean;
    Function UpdateTB_DOORCardAsync(aNodeNo,aDeviceID,aDoorNO,aAsync:string):Boolean;   //출입문별 카드권한 동기화
    Function UpdateTB_DOORDeviceAsync(aNodeNo,aDeviceID,aDoorNO,aAsync:string):Boolean; //기기 정보 동기화
    Function UpdateTB_DOORMasterRcv(aNodeNo,aDeviceID,aDoorNO,aRcvAck:string):Boolean; //기기 정보 동기화
  end;

var
  dmDBFunction: TdmDBFunction;

implementation

uses
  uDataBase,
  uCommonVariable,
  uFunction,
  DIMime;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule1 }

function TdmDBFunction.checkTB_DOORSCHEDULE_DayCode(aNodeNo, aEcuID, aDoorNo,
  aDayCode: string): integer;
var
  stSql : string;
  TempAdoQuery :TADOQuery;
begin
  result := -1;

  stSql := 'select * from TB_DOORSCHEDULE ';
  stSql := stSql + ' Where  GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_ECUID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND DO_DOORNO = ' + aDoorNo + ' ';
  stSql := stSql + ' AND DS_DAYCODE = ''' + aDayCode + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;
      if recordcount = 0 then result := 0
      else result := 1;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmDBFunction.CheckTB_HOLIDAY_Date(aDate: string): integer;
var
  stSql : string;
  TempAdoQuery :TADOQuery;
begin
  result := -1;
  stSql := 'select * from TB_HOLIDAY ';
  stSql := stSql + ' Where  GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND HO_DAY = ''' + aDate + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;
      if recordcount = 0 then result := 0
      else
      begin
        result := 1;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmDBFunction.CopyHolidayToAllDevice(aDate: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Insert Into TB_HOLIDAYDEVICE( ';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'ND_NODENO,';
  stSql := stSql + 'DE_ECUID,';
  stSql := stSql + 'HO_DAY,';
  stSql := stSql + 'HD_USE,';
  stSql := stSql + 'HD_SEND) ';
  stSql := stSql + 'select GROUP_CODE,' ;
  stSql := stSql + 'ND_NODENO,';
  stSql := stSql + 'DE_ECUID,';
  stSql := stSql + '''' + aDate + ''',';
  stSql := stSql + '''1'',';
  stSql := stSql + '''N'' ';
  stSql := stSql + ' From TB_DEVICE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' and DE_EXTENDID = 0 ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.DeleteTB_DEVICECARDNO_CardNoPermit(aNodeNo, aEcuID, aCardNo,
  aPermit: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Delete From TB_DEVICECARDNO ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';
  stSql := stSql + ' AND DE_PERMIT = ''' + aPermit + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.DeleteTB_DEVICEPASSWD_PasswordPermit(aNodeNo, aEcuID,
  aPassword, aPermit: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Delete From TB_DEVICEPASSWD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';
  stSql := stSql + ' AND DE_PERMIT = ''' + aPermit + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.InsertTB_ACCESSEVENT(aDate, aTime, aNodeNo, aEcuID,
  aDoorNo, aCardNo, aReaderNo, aButton, aPosi, aInputType, aDoorMode,
  aPermitMode, aPermitCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Insert Into TB_ACCESSEVENT ( ';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'AC_DATE,';
  stSql := stSql + 'AC_TIME,';
  stSql := stSql + 'ND_NODENO,';
  stSql := stSql + 'DE_DEVICEID,';
  stSql := stSql + 'DO_DOORNO,';
  stSql := stSql + 'CA_CARDNO,';
  stSql := stSql + 'AC_READERNO,';
  stSql := stSql + 'AC_BUTTONNO,';
  stSql := stSql + 'AC_DOORPOSI,';
  stSql := stSql + 'AC_INPUTTYPE,';
  stSql := stSql + 'AC_DOORMODE,';
  stSql := stSql + 'AC_PERMITMODE,';
  stSql := stSql + 'PE_PERMITCODE,';
  stSql := stSql + 'AC_INSERTDATE) ';
  stSql := stSql + ' Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + '''' + aDate + ''',';
  stSql := stSql + '''' + aTime + ''',';
  stSql := stSql + '' + aNodeNo + ',';
  stSql := stSql + '''' + aEcuID + ''',';
  stSql := stSql + '' + aDoorNo + ',';
  stSql := stSql + '''' + aCardNo + ''',';
  stSql := stSql + '''' + aReaderNo + ''',';
  stSql := stSql + '''' + aButton + ''',';
  stSql := stSql + '''' + aPosi + ''',';
  stSql := stSql + '''' + aInputType + ''',';
  stSql := stSql + '''' + aDoorMode + ''',';
  stSql := stSql + '''' + aPermitMode + ''',';
  stSql := stSql + '''' + aPermitCode + ''',';
  stSql := stSql + '''' + formatDateTime('yyyymmddhhnnss',now) + ''')';

  result := dmDataBase.ProcessEventExecSQL(stSql);
end;

function TdmDBFunction.InsertTB_ALARMEVENT(aDate, aTime, aNodeNo, aEcuID,
  aDoorNo, aAlarmCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Insert Into TB_ALARMEVENT ( ';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'AE_DATE,';
  stSql := stSql + 'AE_TIME,';
  stSql := stSql + 'ND_NODENO,';
  stSql := stSql + 'DE_ECUID,';
  stSql := stSql + 'DO_DOORNO,';
  stSql := stSql + 'AE_ALARMCODE,';
  stSql := stSql + 'AE_INSERTTIME) ';
  stSql := stSql + ' Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + '''' + aDate + ''',';
  stSql := stSql + '''' + aTime + ''',';
  stSql := stSql + '' + aNodeNo + ',';
  stSql := stSql + '''' + aEcuID + ''',';
  stSql := stSql + '' + aDoorNo + ',';
  stSql := stSql + '''' + aAlarmCode + ''',';
  stSql := stSql + '''' + formatDateTime('yyyymmddhhnnsszzz',now) + ''')';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.InsertTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo,
  aDeviceID, aDoorNo, aPermit: string): Boolean;
var
  stSql : string;
begin
  if Not isDigit(aDoorNo) then aDoorNo := '1';
  if ( strtoint(aDoorNo) > 2) or ( strtoint(aDoorNo) < 1)  then aDoorNo := '1';


  stSql := ' Insert Into TB_DEVICECARDNO( ';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' ND_NODENO,';
  stSql := stSql + ' DE_DEVICEID,';
  stSql := stSql + ' CA_CARDNO,';
  stSql := stSql + ' DE_DOOR' + aDoorNo + ' ,';
  stSql := stSql + ' DE_USEACCESS,';
  stSql := stSql + ' DE_PERMIT, ';
  stSql := stSql + ' DE_RCVACK) ';
  stSql := stSql + ' Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + ' ' + aNodeNo + ',';
  stSql := stSql + '''' + aDeviceID + ''',';
  stSql := stSql + '''' + aCardNo + ''',';
  stSql := stSql + '''Y'',';
  stSql := stSql + '''Y'',';
  stSql := stSql + '''' + aPermit + ''',';
  stSql := stSql + '''N'') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.InsertTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo,
  aDeviceID, aDoorNo, aPermit: string): Boolean;
var
  stSql : string;
begin
  if Not isDigit(aDoorNo) then aDoorNo := '1';
  if ( strtoint(aDoorNo) > 2) or ( strtoint(aDoorNo) < 1)  then aDoorNo := '1';


  stSql := ' Insert Into TB_DEVICEPASSWD( ';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' ND_NODENO,';
  stSql := stSql + ' DE_DEVICEID,';
  stSql := stSql + ' PA_PASSWORD,';
  stSql := stSql + ' DE_DOOR' + aDoorNo + ' ,';
  stSql := stSql + ' DE_USEACCESS,';
  stSql := stSql + ' DE_PERMIT, ';
  stSql := stSql + ' DE_RCVACK) ';
  stSql := stSql + ' Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + ' ' + aNodeNo + ',';
  stSql := stSql + '''' + aDeviceID + ''',';
  stSql := stSql + '''' + aPassword + ''',';
  stSql := stSql + '''Y'',';
  stSql := stSql + '''Y'',';
  stSql := stSql + '''' + aPermit + ''',';
  stSql := stSql + '''N'') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_CARDCardAsync(aCardNo, aAsync: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_CARD set CA_ASYNC = ''' + aAsync + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo,
  aDeviceID, aDoorNo, aPermit: string): Boolean;
var
  stSql : string;
begin
  if Not isDigit(aDoorNo) then aDoorNo := '1';
  if ( strtoint(aDoorNo) > 2) or ( strtoint(aDoorNo) < 1)  then aDoorNo := '1';

  stSql := ' Update TB_DEVICECARDNO Set ';
  stSql := stSql + ' DE_DOOR' + aDoorNo + ' = ''Y'',';
  stSql := stSql + ' DE_USEACCESS = ''Y'',';
  stSql := stSql + ' DE_PERMIT =''' + aPermit + ''', ';
  stSql := stSql + ' DE_RCVACK =''N'' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + '''';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICECARDNO_AllState(OrgState,
  NewState: String): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DEVICECARDNO set DE_RCVACK = ''' + NewState + ''' ';
  stSql := stSql + ' Where DE_RCVACK = ''' + OrgState + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.UpdateTB_DEVICECARDNO_CardNoState(aNodeNo, aEcuID,
  aCardNo, aOldState, aNewState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICECARDNO set DE_RCVACK = ''' + aNewState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';
  stsql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';
  stSql := stSql + ' AND DE_RCVACK = ''' + aOldState + ''' '; //전송준비중인 데이터만 송신하자.

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICECARDNO_DeviceState(aNodeNo, aEcuID,
  aState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICECARDNO set DE_RCVACK = ''' + aState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.UpdateTB_DEVICECARDNO_DeviceStateChange(aNodeNo, aEcuID,
  aOldState, aState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICECARDNO set DE_RCVACK = ''' + aState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';
  stSql := stSql + ' AND DE_RCVACK = ''' + aOldState + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo,
  aDeviceID, aDoorNo, aPermit: string): Boolean;
var
  stSql : string;
begin
  if Not isDigit(aDoorNo) then aDoorNo := '1';
  if ( strtoint(aDoorNo) > 2) or ( strtoint(aDoorNo) < 1)  then aDoorNo := '1';

  stSql := ' Update TB_DEVICEPASSWD Set ';
  stSql := stSql + ' DE_DOOR' + aDoorNo + ' = ''Y'',';
  stSql := stSql + ' DE_USEACCESS = ''Y'',';
  stSql := stSql + ' DE_PERMIT =''' + aPermit + ''', ';
  stSql := stSql + ' DE_RCVACK =''N'' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + '''';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_PasswordDelete(
  aPassword: String): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DEVICEPASSWD Set ';
  stSql := stSql + ' DE_PERMIT =''N'', ';
  stSql := stSql + ' DE_RCVACK =''N'' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + '''';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_AllState(OrgState,
  NewState: String): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DEVICEPASSWD set DE_RCVACK = ''' + NewState + ''' ';
  stSql := stSql + ' Where DE_RCVACK = ''' + OrgState + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_DeviceState(aNodeNo, aEcuID,
  aState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICEPASSWD set DE_RCVACK = ''' + aState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_DeviceStateChange(aNodeNo, aEcuID,
  aOldState, aState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICEPASSWD set DE_RCVACK = ''' + aState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';
  stSql := stSql + ' AND DE_RCVACK = ''' + aOldState + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DEVICEPASSWD_PasswordState(aNodeNo, aEcuID,
  aPassword, aOldState, aNewState: String): Boolean;
var
  stSql : string;
begin
  stSql := 'update TB_DEVICEPASSWD set DE_RCVACK = ''' + aNewState + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aECUID + ''' ';
  stsql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';
  stSql := stSql + ' AND DE_RCVACK = ''' + aOldState + ''' '; //전송준비중인 데이터만 송신하자.

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DOORCardAsync(aNodeNo, aDeviceID, aDoorNO,
  aAsync: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DOOR set DO_CARDASYNC = ''' + aAsync + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND DO_DOORNO = ' + aDoorNO + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DOORDeviceAsync(aNodeNo, aDeviceID, aDoorNO,
  aAsync: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DOOR set DO_DEVICEASYNC = ''' + aAsync + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND DO_DOORNO = ' + aDoorNO + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBFunction.UpdateTB_DOORMasterRcv(aNodeNo, aDeviceID, aDoorNO,
  aRcvAck: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DOOR set DO_MASTERRCV = ''' + aRcvAck + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND DO_DOORNO = ' + aDoorNO + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBFunction.updateTB_DOOR_AllMasterRcvAck(aRcvAck: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Update TB_DOOR set DO_MASTERRCV = ''' + aRcvAck + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

end.
