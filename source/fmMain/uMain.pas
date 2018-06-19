unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvShapeButton, AdvToolBar,
  AdvGlowButton, AdvToolBarStylers, Vcl.ImgList, AdvPreviewMenu, Vcl.Menus,
  AdvMenus, AdvPreviewMenuStylers, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers, uSubForm, CommandArray, CPort,
  Vcl.StdCtrls,Data.Win.ADODB,Winapi.ActiveX,System.IniFiles,
  uDevicePacket, AdvAppStyler;

type

  TfmMain = class(TfmASubForm)
    AdvToolBarPager1: TAdvToolBarPager;
    ApManagerAdmin: TAdvPage;
    AdvToolBar1: TAdvToolBar;
    AdvGlowButton2: TAdvGlowButton;
    AdvToolBar4: TAdvToolBar;
    mn_btnMonitoring: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    ApBasicAdmin: TAdvPage;
    AdvToolBar7: TAdvToolBar;
    AdvGlowButton42: TAdvGlowButton;
    AdvToolBar8: TAdvToolBar;
    AdvShapeButton1: TAdvShapeButton;
    StartMenu: TAdvPreviewMenu;
    ImageList3: TImageList;
    ImageList2: TImageList;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvPreviewMenuOfficeStyler1: TAdvPreviewMenuOfficeStyler;
    AdvToolBar2: TAdvToolBar;
    AdvToolBar3: TAdvToolBar;
    btn_AlarmReport: TAdvGlowButton;
    AdvGlowButton67: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton53: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    Image1: TImage;
    sb_Status: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    AdvGlowButton5: TAdvGlowButton;
    ApEtc: TAdvPage;
    AdvToolBar5: TAdvToolBar;
    btn_fmConfigSetting: TAdvGlowButton;
    ComPort: TComPort;
    CardAutoDownTimer: TTimer;
    DeviceInfoSendTimer: TTimer;
    btn_Upgrade: TAdvGlowButton;
    btn_DBBackup: TAdvGlowButton;
    AdvToolBar6: TAdvToolBar;
    btn_DeviceLanSetting: TAdvGlowButton;
    pm_Person: TPopupMenu;
    pm_cardbackup: TMenuItem;
    pm_cardload: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    NodeOpenCheckTimer: TTimer;
    AdvGlowButton3: TAdvGlowButton;
    AdvToolBar9: TAdvToolBar;
    AdvGlowButton9: TAdvGlowButton;
    PCScheduleTimer: TTimer;
    AdvFormStyler1: TAdvFormStyler;
    AdvGlowButton10: TAdvGlowButton;
    procedure AdvPreviewMenu1MenuItems3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartMenuMenuItems1Click(Sender: TObject);
    procedure StartMenuMenuItems2Click(Sender: TObject);
    procedure StartMenuMenuItems3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AdvToolBarPager1HelpClick(Sender: TObject);
    procedure AdvGlowButton6Click(Sender: TObject);
    procedure AdvGlowButton7Click(Sender: TObject);
    procedure AdvGlowButton42Click(Sender: TObject);
    procedure AdvGlowButton67Click(Sender: TObject);
    procedure AdvGlowButton53Click(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure btn_fmConfigSettingClick(Sender: TObject);
    procedure CommandArrayCommandsTACTIONExecute(Command: TCommand;
      Params: TStringList);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure CommandArrayCommandsTFORMENABLEExecute(Command: TCommand;
      Params: TStringList);
    procedure AdvGlowButton8Click(Sender: TObject);
    procedure AdvGlowButton5Click(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure mn_btnMonitoringClick(Sender: TObject);
    procedure AdvGlowButton4Click(Sender: TObject);
    procedure btn_AlarmReportClick(Sender: TObject);
    procedure CommandArrayCommandsTSTATUSMSGExecute(Command: TCommand;
      Params: TStringList);
    procedure CardAutoDownTimerTimer(Sender: TObject);
    procedure DeviceInfoSendTimerTimer(Sender: TObject);
    procedure btn_UpgradeClick(Sender: TObject);
    procedure CommandArrayCommandsTFORMEXECExecute(Command: TCommand;
      Params: TStringList);
    procedure btn_RemoteControlClick(Sender: TObject);
    procedure btn_DBBackupClick(Sender: TObject);
    procedure btn_DeviceLanSettingClick(Sender: TObject);
    procedure CommandArrayCommandsTDEVICERELOADExecute(Command: TCommand;
      Params: TStringList);
    procedure pm_cardbackupClick(Sender: TObject);
    procedure pm_cardloadClick(Sender: TObject);
    procedure AdvGlowButton6MouseEnter(Sender: TObject);
    procedure NodeOpenCheckTimerTimer(Sender: TObject);
    procedure AdvGlowButton3Click(Sender: TObject);
    procedure AdvGlowButton9Click(Sender: TObject);
    procedure PCScheduleTimerTimer(Sender: TObject);
    procedure CommandArrayCommandsTCHANGEExecute(Command: TCommand;
      Params: TStringList);
    procedure FormActivate(Sender: TObject);
    procedure AdvGlowButton10Click(Sender: TObject);
  private
    FLogined: Boolean;

    procedure SetLogined(const Value: Boolean);
    { Private declarations }
    Procedure MDIChildShow(FormName:String);
    Function  MDIForm(FormName:string):TForm;
    procedure MDIFormAllClose;
    procedure ChildFormClose(aFormNumber:integer);
  private
    procedure  AppException( Sender:  TObject;  E:  Exception) ;
  private
    L_stRegistCardNo : string;
    L_bCardDownLoad : Boolean;
    L_bPasswordDownLoad : Boolean;
    L_bDeviceInfoDownLoad : Boolean;
    L_nCardNextSendSeq : integer;  //카드 데이터 보낼 장비 순서
    DoorScheduleList : TStringList;
    HoliDayList : TStringList;

    procedure LoadAlarmCode;
    procedure AlarmConfigSetting;
    procedure CardRegistPortOpen;
    procedure RcvCardDataByReader(aData:string);
    procedure CardRegisterReadingProcess(aData:string);

    procedure CardDataDownLoad(aNodeNo,aDeviceID:string);
    procedure PasswordDataDownLoad(aNodeNo,aDeviceID:string);
    function  DoorSettingInfoRegist(aNodeNo:integer;aEcuID:string): Boolean;  //출입문정보 등록
    function  MasterNoRegist(aNodeNo:integer;aEcuID:string): Boolean;  //출입문정보 등록
  private
    function CheckAccessCardGrade(aNodeNo,aECUID,aDoorNo,aCardNo:string):integer;
    function CheckAccessPasswordGrade(aNodeNo,aECUID,aDoorNo,aPassword:string):integer;
    function SaveCardToFile(aFileName:string):Boolean;
    function LoadCardFromFile(aFileName:string):Boolean;
    procedure FormNameSetting;
    Function FontSetting:Boolean;
  private
    procedure LoadDoorSchedule;
    procedure UnLoadDoorSchedule;
    procedure LoadHoliday;
    procedure PCScheduleStart;
  public
    { Public declarations }
    procedure DeviceConnected(Sender: TObject; aNodeNo,aECUID,aConnected,aData4,aData5,aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure DeviceSendDataProcess(Sender: TObject; aNodeNo : integer;aMcuID,aECUID,aCmd,aMsgNo,aDeviceVer,aRealData:string);
    procedure NodeRecvDataProcess(Sender: TObject; aNodeNo : integer;aMcuID,aECUID,aCmd,aMsgNo,aDeviceVer,aRealData:string);
    procedure RcvAlarmEvent(Sender: TObject; aNodeNo,aECUID,aDoorNo,aReaderNo,aInOut,aTime,aCardMode,aDoorMode,aAlarmCode,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvCardAccessEvent(Sender: TObject; aNodeNo,aECUID,aDoorNo,aReaderNo,aInOut,aTime,aCardMode,aDoorMode,aChangeState,aAccessResult,aDoorState,aATButton,aCardNo,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvCardRegData(Sender: TObject; aNodeNo,aECUID,aResult,aCardNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure ReceiveDeviceInitialize(Sender: TObject; aNodeNo,aECUID,aResult,aData4,aData5,aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvDoorModeChange(Sender: TObject; aNodeNo,aECUID,aCmd,aResult,aMode,aDoorState,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvDoorSetupAck(Sender: TObject; aNodeNo,aECUID,aCmd,aDoorNo,aCardMode,aDoorMode,aDoorControlTime,aLongDoorOpenTime,aSchedule,aDoorState,aLongDoorOpenUse,aDoorLockType,aFireDoorControl,aLockState,aDoorOpenState,aRemoteDoorOpen,aResult,aData18,aData19,aData20:string);
    procedure RcvMasterNoRegData(Sender: TObject; aNodeNo,aECUID,aResult,aMasterNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvPasswordRegData(Sender: TObject; aNodeNo,aECUID,aResult,aPassword,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvMessageData(Sender: TObject; aData1, aData2, aData3,  aData4, aData5, aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
  Published
    { Published declarations }
    Property Logined : Boolean read FLogined write SetLogined;
  end;

var
  fmMain: TfmMain;

implementation
uses
  uDataBase,
  systeminfos,
  uDBFunction,
  uCommonVariable,
  uDataBaseConfig,
  uLogin,
  uPWChange,
  uFunction,
  uDeviceControlCenter,
  uControler,
  uAreaCodeAdmin,
  uBuildingCodeAdmin,
  uCardAdmin,
  uConfigSetting,
  uDBFormName,
  uDeviceDoorSchedule,
  uDoorAdmin,
  uNodeAdmin,
  uPermitCodeAdmin,
  udmCardPermit,
  uPersonCardPermit,
  uDoorCardPermit,
  uAccessReport,
  uDeviceComMonitoring,
  uDevicePwAdmin,
  uMonitoring,
//  uRemoteControl,
  uDataBaseBackup,
  uNetConfig,
  uFormFontUtil;

{$R *.dfm}

procedure TfmMain.AdvGlowButton10Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmAccessReport');
end;

procedure TfmMain.AdvGlowButton1Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmCardAdmin');

end;

procedure TfmMain.btn_AlarmReportClick(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmAlarmReport');
end;

procedure TfmMain.AdvGlowButton2Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmDevicePwAdmin');

end;

procedure TfmMain.AdvGlowButton3Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmDoorSchedule');

end;

procedure TfmMain.mn_btnMonitoringClick(Sender: TObject);
begin
  inherited;
  mn_btnMonitoring.Enabled := False;
  MDIChildShow('TfmMonitoring');
  mn_btnMonitoring.Enabled := True;
end;

procedure TfmMain.AdvGlowButton42Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmNodeAdmin');

end;

procedure TfmMain.AdvGlowButton4Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmDeviceComMonitoring');

end;

procedure TfmMain.AdvGlowButton53Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmPermitCodeAdmin');

end;

procedure TfmMain.AdvGlowButton5Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmDoorCardPermit');

end;

procedure TfmMain.AdvGlowButton67Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmDoorAdmin');

end;

procedure TfmMain.AdvGlowButton6Click(Sender: TObject);
begin
  MDIChildShow('TfmBuildingCodeAdmin');
end;

procedure TfmMain.AdvGlowButton6MouseEnter(Sender: TObject);
begin
  inherited;
  self.FindSubForm('Main').FindCommand('STATUSMSG').Params.Values['DATA'] := TAdvGlowButton(Sender).Caption + dmFormName.GetFormMessage('2','M00008');
  self.FindSubForm('Main').FindCommand('STATUSMSG').Execute;

end;

procedure TfmMain.AdvGlowButton7Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmAreaCodeAdmin');

end;

procedure TfmMain.AdvGlowButton8Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmPersonCardPermit');
end;

procedure TfmMain.AdvGlowButton9Click(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmHolidayAdd');

end;

procedure TfmMain.AdvPreviewMenu1MenuItems3Click(Sender: TObject);
begin
  Close;
end;


procedure TfmMain.AdvToolBarPager1HelpClick(Sender: TObject);
begin
  if Not Logined then ShowMessage(dmFormName.GetFormMessage('2','M00055'))
  else ShowMessage(dmFormName.GetFormMessage('2','M00056'));
end;

procedure TfmMain.AlarmConfigSetting;
var
  ini_fun : TiniFile;
begin
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
    with ini_fun do
    begin
      if ReadInteger('AlarmEvent','Show',0) = 1 then
      begin
        btn_AlarmReport.Visible := True;
        AdvToolBar3.Width := 220;
      end  else
      begin
        btn_AlarmReport.Visible := False;
        AdvToolBar3.Width := 110;
      end;
    end;
  Finally
    ini_fun.Free;
  End;

end;

procedure TfmMain.AppException(Sender: TObject; E: Exception);
var
  sObj : string;
  ctrl : TControl;
  Comp : TComponent;
begin
  sObj := '';
  if Sender <> nil then
  begin
    if Sender.InheritsFrom(TControl) then
    begin
      ctrl := TControl(Sender);
      While (ctrl <> nil) do
      begin
        sObj := ctrl.Name + '->' + sObj;
        ctrl := ctrl.Parent;
      end;
    end else if Sender.InheritsFrom(TComponent) then
    begin
      Comp := TComponent(Sender);
      sObj := Comp.Name;
      if (Comp.Owner <> nil) then
      begin
        sObj := comp.Owner.Name + '->' + sObj;
      end;
    end;
  end;
  LogSave(G_stExeFolder + '\..\log\' + Application.Name + FormatDateTime('yyyymmdd',now) + '.log',sObj);

end;

procedure TfmMain.btn_DBBackupClick(Sender: TObject);
begin
  inherited;
  fmDataBaseBackup:= TfmDataBaseBackup.Create(Self);
  fmDataBaseBackup.SHowModal;
  fmDataBaseBackup.Free;

end;

procedure TfmMain.btn_DeviceLanSettingClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(PChar(dmFormName.GetFormMessage('2','M00058')),pchar(dmFormName.GetFormMessage('3','M00001')),MB_OKCANCEL) = IDCANCEL)  then Exit;

  fmNetConfig:= TfmNetConfig.Create(Self);
  fmNetConfig.SHowModal;
  fmNetConfig.Free;

end;

procedure TfmMain.btn_fmConfigSettingClick(Sender: TObject);
begin
  inherited;
  MDIChildShow('TfmConfigSetting');

end;


procedure TfmMain.btn_RemoteControlClick(Sender: TObject);
begin
  inherited;
//  MDIChildShow('TfmRemoteControl');

end;

procedure TfmMain.btn_UpgradeClick(Sender: TObject);
begin
  inherited;
  if Not FileExists(G_stExeFolder + '\SmartUpdate.exe') then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00057'));
    Exit;
  end;

  My_RunDosCommand(G_stExeFolder + '\SmartUpdate.exe',False,False);
  Close;

end;

procedure TfmMain.CardAutoDownTimerTimer(Sender: TObject);
var
  i : integer;
begin
  inherited;
  if G_bApplicationTerminate then Exit;
  CardAutoDownTimer.Interval := 200;
  Try
    CardAutoDownTimer.Enabled := False;
    if L_nCardNextSendSeq > (DeviceList.Count -1)  then L_nCardNextSendSeq := 0;

    for i := L_nCardNextSendSeq to DeviceList.Count -1 do
    begin
      if TDevice(DeviceList.Objects[i]).DeviceConnected then
      begin
        if G_bApplicationTerminate then Exit;
        CardDataDownLoad(inttostr(TDevice(DeviceList.Objects[i]).NodeNo),TDevice(DeviceList.Objects[i]).DeviceID);
        PasswordDataDownLoad(inttostr(TDevice(DeviceList.Objects[i]).NodeNo),TDevice(DeviceList.Objects[i]).DeviceID);
      end;
      L_nCardNextSendSeq := i + 1;
    end;
  Finally
    CardAutoDownTimer.Enabled := Not G_bApplicationTerminate;
  End;
end;

procedure TfmMain.CardDataDownLoad(aNodeNo,aDeviceID:string);
var
  stCardno: String;
  stAccess: String;
  stAlarm: String;
  stDoor1: String;
  stDoor2: String;
  cTimeCode: Char;
  stSend: String[1];
  cPermit: Char;
  cCardType: Char;
  cRegCode: Char;
  nDeviceIndex: Integer;
  stDownLoadData: String;
  stSql : String;
  TempAdoQuery : TADOQuery;
  i : integer;
  nPositionNum : integer;
  stValidDate : string;
  stDeivceCaption : string;
begin
  if L_bCardDownLoad then Exit;
  L_bCardDownLoad := True;

  stSql := 'Update TB_DEVICECARDNO Set DE_RCVACK = ''R'' '; //송신 준비 상태로 변경
  stSql := stSql + ' WHERE GROUP_CODE = ''' + G_stGroupCode + ''' ' ;
  stSql := stSql + ' AND DE_RCVACK = ''N'' ' ;
  if G_nDBType = POSTGRESQL then stSql := stSql + ' AND Length(CA_CARDNO) = ' + inttostr(G_nCardFixedLength) + ' '
  else stSql := stSql + ' AND Len(CA_CARDNO) = ' + inttostr(G_nCardFixedLength) + ' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';

  dmDataBase.ProcessExecSQL(stSql);

  stSql := 'Select top 1 ';
  stSql := stSql + 'a.* ';
  stSql := stSql + ' from TB_DEVICECARDNO a';
  stSql := stsql + ' Left Join TB_CARD b ';
  stSql := stSql + ' ON( a.GROUP_CODE = b.GROUP_CODE ';
  stSql := stSql + ' AND a.ca_cardno = b.ca_cardno ) ';
  stSql := stSql + ' Where a.DE_RCVACK = ''R'' ';
  stSql := stSql + ' AND a.GROUP_CODE = ''' + G_stGroupCode + ''' ' ;
  if G_nDBType = POSTGRESQL then stSql := stSql + ' AND Length(a.CA_CARDNO) = ' + inttostr(G_nCardFixedLength) + ' '
  else stSql := stSql + ' AND Len(a.CA_CARDNO) = ' + inttostr(G_nCardFixedLength) + ' ';
  stSql := stSql + ' AND a.ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND a.DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' order by a.de_permit,a.ca_cardno ';

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
        LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','Select Error');

        Exit;
      End;

      if RecordCount > 0  then
      begin
        First;
        Try
          while not eof do
          begin
            if G_bApplicationTerminate then Exit;
            stValidDate := ''; //유효기간
            if Length(stValidDate) <> 8 then stValidDate := '00000000';
            if Not IsDigit(stValidDate) then stValidDate := '00000000';
            stValidDate := copy(stValidDate,3,6); //유효기간

            stCardNo:= FindField('CA_CARDNO').asString;
            if IsAlphaNumeric(stCardNo) then  //카드번호 형태가 맞는 경우만 다운로드 하자.
            begin
              stDeivceCaption:= FillZeroNumber(FindField('ND_NODENO').asInteger,G_nNodeCodeLength) + FindField('DE_DEVICEID').AsString;
              dmDBFunction.UpdateTB_DEVICECARDNO_CardNoState(inttostr(FindField('ND_NODENO').asInteger),FindField('DE_DEVICEID').AsString,stCardNo,'R','S'); //송신데이터 송신중으로 처리
              nPositionNum := 0;

              if (FindField('DE_DOOR1').IsNull) or (Trim(FindField('DE_DOOR1').asstring) = '')  then stDoor1:='N'
              else stDoor1:= FindField('DE_DOOR1').asString;

              if (FindField('DE_DOOR2').IsNull) or (Trim(FindField('DE_DOOR2').asstring) = '') then stDoor2:='N'
              else stDoor2:= FindField('DE_DOOR2').asString;

              if (FindField('DE_USEACCESS').IsNull) or (Trim(FindField('DE_USEACCESS').asstring) = '')  then stAccess:='N'
              else stAccess:= FindField('DE_USEACCESS').asString;
              if (stDoor1 = 'N') and (stDoor2 = 'N') then stAccess := 'N'; //1번,2번 출입 권한 모두 없으면 출입권한 없는거임... 2011.06.09 수정

              if (FindField('DE_USEALARM').IsNull) or (Trim(FindField('DE_USEALARM').asstring) = '')  then stAlarm:='N'
              else stAlarm:= FindField('DE_USEALARM').asString;
              if (FindField('DE_TIMECODE').IsNull) or (Trim(FindField('DE_TIMECODE').asstring) = '')  then cTimeCode:='0'
              else cTimeCode:= FindField('DE_TIMECODE').asstring[1];
              if (FindField('DE_PERMIT').IsNull) or (Trim(FindField('DE_PERMIT').asstring) = '')  then cPermit:='N'
              else cPermit:= FindField('DE_PERMIT').asString[1];

              if cPermit = 'L' then
              begin

                if stAccess = 'Y' then   //출입 허가
                begin

                  if stAlarm = 'Y' then cCardType:= '2' //카드타입설정: 2=> 출입 + 방범
                  else                  cCardType:= '0'; //카드타입설정: 0=> 출입

                  if (stDoor1 = 'Y') and (stDoor2 = 'Y') then
                  begin
                    cRegCode:= '0';
                  end else if  stDoor1 = 'Y' then
                  begin
                    cRegCode:= '1';
                  end else if  stDoor2 = 'Y' then
                  begin
                    cRegCode:= '2';
                  end else
                  begin
                    if stAlarm = 'Y' then cCardType:= '1' //카드타입설정: 1=> 방범 전용
                    else
                    begin
                      cRegCode:= '0';
                      cPermit:= 'N';
                    end;
                  end;
                end else if stAlarm = 'Y' then  // 출입 X ,방범만 OK
                begin
                  //aRegCode:= '3';
                  cRegCode:= '0';
                  cCardType:= '1';

                end else
                begin
                  cCardType:= '0';
                  cRegCode:= '0';
                  cPermit:= 'N';
                end;
              end
              else
              begin
                  cCardType:= '0';
                  cRegCode:= '0';
                  cPermit:= 'N';
              end;


              nDeviceIndex:= DeviceList.IndexOf(stDeivceCaption);

              if nDeviceIndex < 0 then
              begin
                LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log',aDeviceID+'Not Device[CardDownLoad]');
                Exit;
              end else
              begin
                TDevice(DeviceList.Objects[nDeviceIndex]).CardDownload(stCardNo,stValidDate,cCardType,cRegCode,cTimeCode,cPermit,nPositionNum);
              end;
            end else
            begin
              dmDBFunction.UpdateTB_DEVICECARDNO_CardNoState(inttostr(FindField('ND_NODENO').asInteger),FindField('DE_DEVICEID').AsString,stCardNo,'R','Y');
            end;
            Next;
            Application.ProcessMessages;
          end;
        Except
          LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','DownLoad Error');

        End;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
    L_bCardDownLoad := False;
  End;
end;

procedure TfmMain.CardRegisterReadingProcess(aData: string);
var
  fmTemp : TForm;
begin
  //여기에서 카드등록기 리딩 데이터 처리 하자.
  fmTemp := MDIForm('TfmCardAdmin');
  if fmTemp <> nil then TfmCardAdmin(fmTemp).CardRegisterReadingProcess(aData);
end;

procedure TfmMain.CardRegistPortOpen;
begin
  if G_nCardRegisterPort = 0 then Exit;

  if ComPort.Connected then
  begin
    ComPort.Close;
    Delay(1000);
  end;

  ComPort.Port := 'COM' + inttostr(G_nCardRegisterPort);
  ComPort.BaudRate := br9600;

  if Not ComPort.Connected then
     ComPort.Open;
end;


function TfmMain.CheckAccessCardGrade(aNodeNo, aECUID, aDoorNo,
  aCardNo: string): integer;
var
  TempAdoQuery : TADOQuery;
  stSql : string;
begin
  result := -1;
  stSql := ' Select * from TB_DEVICECARDNO ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';
  stSql := stSql + ' AND DE_PERMIT = ''L'' ';
  stSql := stSql + ' AND DE_DOOR' + aDoorNo + ' = ''Y'' ';
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
      if recordcount = 0 then  result := 0
      else result := 1;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

function TfmMain.CheckAccessPasswordGrade(aNodeNo, aECUID, aDoorNo,
  aPassword: string): integer;
var
  TempAdoQuery : TADOQuery;
  stSql : string;
begin
  result := -1;
  stSql := ' Select * from TB_DEVICEPASSWD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';
  stSql := stSql + ' AND DE_PERMIT = ''L'' ';
  stSql := stSql + ' AND DE_DOOR' + aDoorNo + ' = ''Y'' ';
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
      if recordcount = 0 then  result := 0
      else result := 1;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmMain.ChildFormClose(aFormNumber: integer);
var
  fmTemp : TForm;
begin
  case aFormNumber of
    FORMACCESSREPORT :   //출입이력보고서
    begin
      fmTemp := MDIForm('TfmAccessReport');
      if fmTemp <> nil then TfmAccessReport(fmTemp).Form_Close;
    end;
    FORMAREACODE :    //출구코드관리
    begin
      fmTemp := MDIForm('TfmAreaCodeAdmin');
      if fmTemp <> nil then TfmAreaCodeAdmin(fmTemp).Form_Close;
    end;
    FORMBUILDINGCODE :  //빌딩코드관리
    begin
      fmTemp := MDIForm('TfmBuildingCodeAdmin');
      if fmTemp <> nil then TfmBuildingCodeAdmin(fmTemp).Form_Close;
    end;
    FORMCARDADMIN :    //카드관리
    begin
      fmTemp := MDIForm('TfmCardAdmin');
      if fmTemp <> nil then TfmCardAdmin(fmTemp).Form_Close;
    end;
    FORMCONFIGSETTING :  //환경설정
    begin
      fmTemp := MDIForm('TfmConfigSetting');
      if fmTemp <> nil then TfmConfigSetting(fmTemp).Form_Close;
    end;
    FORMDEVICECOMMONITORING:
    begin
      fmTemp := MDIForm('TfmDeviceComMonitoring');
      if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).Form_Close;
    end;
    FORMDEVICEPWADMIN:
    begin
      fmTemp := MDIForm('TfmDevicePwAdmin');
      if fmTemp <> nil then TfmDevicePwAdmin(fmTemp).Form_Close;
    end;
    FORMDOORADMIN :      //출입문관리
    begin
      fmTemp := MDIForm('TfmDoorAdmin');
      if fmTemp <> nil then TfmDoorAdmin(fmTemp).Form_Close;
    end;
    FORMDOORCARDPERMIT:
    begin
      fmTemp := MDIForm('TfmDoorCardPermit');
      if fmTemp <> nil then TfmDoorCardPermit(fmTemp).Form_Close;
    end;
    FORMMONITORING :
    begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).Form_Close;
    end;
    FORMNODEADMIN :      //노드관리
    begin
      fmTemp := MDIForm('TfmNodeAdmin');
      if fmTemp <> nil then TfmNodeAdmin(fmTemp).Form_Close;
    end;
    FORMPERMITCODE :     //출입승인코드관리
    begin
      fmTemp := MDIForm('TfmPermitCodeAdmin');
      if fmTemp <> nil then TfmPermitCodeAdmin(fmTemp).Form_Close;
    end;
    FORMPERSONCARDPERMIT :     //개인별카드권한관리
    begin
      fmTemp := MDIForm('TfmPersonCardPermit');
      if fmTemp <> nil then TfmPersonCardPermit(fmTemp).Form_Close;
    end;
    FORMREMOTECONTROL : //원격지원 서비스
    begin
      fmTemp := MDIForm('TfmRemoteControl');
      if fmTemp <> nil then TfmPersonCardPermit(fmTemp).Form_Close;
    end;
  end;
end;

procedure TfmMain.CommandArrayCommandsTACTIONExecute(Command: TCommand;
  Params: TStringList);
var
  stValue : string;
begin
  stValue := Params.Values['VALUE'];

  if stValue = 'CRADREGISTERPORTREFRESH' then CardRegistPortOpen;

end;

procedure TfmMain.CommandArrayCommandsTCHANGEExecute(Command: TCommand;
  Params: TStringList);
var
  stValue : string;
begin
  stValue := Params.Values['NAME'];

  if Not isDigit(stValue) then Exit;

  if strtoint(stValue) = FormDOORSCHEDULEADMIN then
  begin
    LoadDoorSchedule;
  end else if strtoint(stValue) = FormHOLIDAYADMIN then
  begin
    LoadHoliday;
  end else if strtoint(stValue) = FORMDOORADMIN then
  begin
    LoadDoorSchedule;
  end;
end;

procedure TfmMain.CommandArrayCommandsTDEVICERELOADExecute(Command: TCommand;
  Params: TStringList);
var
  fmTemp : TForm;
begin
  inherited;
  dmDeviceControlCenter.Start := False;
  Delay(1000);
  dmDeviceControlCenter.Start := True;
  if G_bFormEnabled[FORMMONITORING] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).DeviceReload;
  end;

end;

procedure TfmMain.CommandArrayCommandsTFORMENABLEExecute(Command: TCommand;
  Params: TStringList);
var
  stName : string;
  bValue : Boolean;
begin
  stName := Params.Values['NAME'];
  if UpperCase(Params.Values['VALUE']) = 'TRUE' then bValue := True
  else bValue := False;

  if Not isDigit(stName) then Exit;

  G_bFormEnabled[strtoint(stName)] := bValue;   //해당 폼

end;

procedure TfmMain.CommandArrayCommandsTFORMEXECExecute(Command: TCommand;
  Params: TStringList);
var
  stFormName : string;
  stAction : string;
  stData : string;
  stNodeName : string;
  fmTemp : TForm;
begin
  inherited;
  stFormName := Params.Values['FORMNAME'];
  stAction := Params.Values['ACTION'];
  stData := Params.Values['DATA'];
  stNodeName := Params.Values['NODENAME'];

  case strtoint(stFormName) of
    FORMDOORADMIN : begin
      MDIChildShow('TfmDoorAdmin');
      fmTemp := MDIForm('TfmDoorAdmin');
      if fmTemp <> nil then TfmDoorAdmin(fmTemp).Form_Exec(stAction,stData,stNodeName);
    end;
  end;

end;

procedure TfmMain.CommandArrayCommandsTSTATUSMSGExecute(Command: TCommand;
  Params: TStringList);
var
  stCaption : string;
begin
  stCaption := Params.Values['DATA'];

  sb_Status.Panels[2].Text := stCaption;

end;

procedure TfmMain.ComPortRxChar(Sender: TObject; Count: Integer);
var
  stBuffer:string;
begin
  inherited;
  ComPort.ReadStr(stBuffer, Count);
  RcvCardDataByReader(stBuffer);

end;



procedure TfmMain.DeviceConnected(Sender: TObject; aNodeNo, aECUID, aConnected,
  aData4, aData5, aData6, aData7, aData8, aData9, aData10, aData11, aData12,
  aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
var
  stDeviceCaption : string;
  nIndex : integer;
begin
  stDeviceCaption := FillZeroStrNum(aNodeNo,G_nNodeCodeLength) + FillZeroStrNum(aECUID,G_nDeviceCodeLength);
  if UpperCase(aConnected) = 'C' then //Connected 되었으면 출입문 상태를 확인 하자.
  begin
    nIndex := DeviceList.IndexOf(stDeviceCaption);
    if nIndex > -1 then
    begin
      TDevice(DeviceList.Objects[nIndex]).ModeChange('*');
    end;
  end else
  begin
    dmDBFunction.UpdateTB_DEVICECARDNO_DeviceStateChange(aNodeNo,aECUID,'S','N');
    dmDBFunction.UpdateTB_DEVICEPASSWD_DeviceStateChange(aNodeNo,aECUID,'S','N');
  end;
end;

procedure TfmMain.DeviceInfoSendTimerTimer(Sender: TObject);
var
  i : integer;
  bResult : Boolean;
begin
  if G_bApplicationTerminate then Exit;
  if L_bDeviceInfoDownLoad then Exit;
  L_bDeviceInfoDownLoad := True;
  bResult := False;
  Try
    //DeviceInfoSendTimer.Enabled := False;    //계속 변경된 내용이 있는지 체크 하자...
    sb_Status.Panels.Items[2].Text := 'DeviceInfoSendTimer';
    if DeviceList.Count < 1 then Exit;

    bResult := True;
    for i := 0 to DeviceList.Count - 1 do
    begin
      if TDevice(DeviceList.Objects[i]).DeviceConnected then
      begin
        if Not DoorSettingInfoRegist(TDevice(DeviceList.Objects[i]).NodeNo,TDevice(DeviceList.Objects[i]).DeviceID) then bResult := False;   //전송 성공하지 못한게 있으면 계속 타이머 돌리자.
        if Not MasterNoRegist(TDevice(DeviceList.Objects[i]).NodeNo,TDevice(DeviceList.Objects[i]).DeviceID) then bResult := False;
      end else bResult := False; //접속 안된 기기가 하나라도 있으면 계속 Timer 돌리자...
    end;
  Finally
    L_bDeviceInfoDownLoad := False;
    //DeviceInfoSendTimer.Enabled := Not bResult;
  End;

end;

procedure TfmMain.DeviceSendDataProcess(Sender: TObject; aNodeNo: integer;
  aMcuID, aECUID, aCmd, aMsgNo, aDeviceVer, aRealData: string);
var
  fmTemp : TForm;
begin
  if G_bFormEnabled[FORMDEVICECOMMONITORING] then
  begin
      fmTemp := MDIForm('TfmDeviceComMonitoring');
      if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).DeviceSendDataProcess(aNodeNo, aMcuID,
                            aECUID, aCmd, aMsgNo, aDeviceVer, aRealData);
  end;

end;

function TfmMain.DoorSettingInfoRegist(aNodeNo:integer;aEcuID:string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nDeviceIndex : integer;
  stDeivceCaption : string;
begin
  result := True;
  stSql := ' Select * from TB_DOOR ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND DO_DEVICEASYNC = ''N'' ';
  stSql := stSql + ' AND ND_NODENO = ' + inttostr(aNodeNo) + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery  do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        result := False;
        Exit;
      End;
      if recordCount < 1 then Exit; //전송할게 없다.
      while Not Eof do
      begin
        stDeivceCaption :=  FillZeroNumber(FindField('ND_NODENO').asInteger,G_nNodeCodeLength) + FindField('DE_DEVICEID').AsString;
        nDeviceIndex:= DeviceList.IndexOf(stDeivceCaption);
        if nDeviceIndex > -1 then
        begin
          TDevice(DeviceList.Objects[nDeviceIndex]).DeviceDoorInfoSetting(
                                    inttostr(FindField('DO_DOORNO').AsInteger),
                                    '0',                                                //aCardMode
                                    '0',                                                //aDoorMode
                                    FindField('DO_LOCKTIME').AsString, //aDoorControlTime
                                    '0',                                                //aOpenMoni
                                    '0',                                                //aUseSch
                                    '0',                                                //aSendDoor
                                    '0',                                                //aAlarmLong
                                    '0',                                                //aFire
                                    '0',                                                //aLockType
                                    '0',                                                //aDSOpen
                                    '0',                                                //aRemoteDoor
                                    'G'                                                //aCmd
                                    );
        end;
        Next;
      end;

    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

function TfmMain.FontSetting: Boolean;
var
  stDir : pchar;
  stFontDir : string;
  i : integer;
  ini_fun : TiniFile;
  FontList: TStringList;
  nIndex : integer;
begin
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Font.INI');
    with ini_fun do
    begin
      G_stFormStyle := ReadString('Config','FormStyle','bsOffice2007Luna');
      G_stFontName := ReadString('Config','FontName','맑은 고딕');
      G_nFontSize := ReadInteger('Config','FontSize',9);
      G_stMenuCaption := ReadString('Config','MenuCaptionVisible','1');
    end;
  Finally
    ini_fun.Free;
  End;

  if G_stFontName <> '' then Font.Name := G_stFontName;
  Font.Size := G_nFontSize;
  dmFormFontUtil.TravelAdvPreviewMenuFontSetting(startMenu,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.TravelFormFontSetting(fmMain,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormAdvPreviewMenuOfficeStylerSetting(AdvPreviewMenuOfficeStyler1,G_stFormStyle);

end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  inherited;
  FormNameSetting;
//showmessage('4');
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  fmTemp : TForm;
begin
  G_bApplicationTerminate := True;
  Delay(1000); //폼 종료에 따른 딜레이 가져가자....
  //출입 모니터링에 전송
  if G_bFormEnabled[FORMMONITORING] then
  begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).Form_Close;
  end;

  CardAutoDownTimer.Enabled := False; //카드다운로드 종료
  DeviceInfoSendTimer.Enabled := False;
  NodeOpenCheckTimer.Enabled := False;
  dmDeviceControlCenter.Start := False; //컨트롤러 통신 종료
  dmCardPermit.TimerStart := False;

  DoorScheduleList.Free;
  HoliDayList.Free;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  i : integer;
  stMsg : string;
  aResult : PDWORD_PTR;
  lParam, wParam : Integer;
  Buf : Array[0..10] of Char;
begin
//showmessage('1');
  AddFontResource(PChar(ExtractFileDir(Application.ExeName) + '/NanumGothic.ttf'));
  AddFontResource(PChar(ExtractFileDir(Application.ExeName) + '/NanumGothicBold.ttf'));
  //SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
  PostMessage(HWND_BROADCAST,WM_FONTCHANGE,0,0);
  (*wParam := 0;
  Buf := 'Environment';
  lParam := Integer(@Buf[0]);
  aResult  := nil;
  SendMessageTimeout(HWND_BROADCAST,
                           WM_FONTCHANGE,
                           0,
                           LPARAM(PChar('Environment')),
                           SMTO_NORMAL,
                           3000,
                           aResult );

  *)
  self.ModuleID := 'Main';
  DoorScheduleList := TStringList.Create;
  HoliDayList := TStringList.Create;

//showmessage('1-1');
  G_bApplicationTerminate := False;
  TDataBaseConfig.GetObject.DataBaseConnect(False);
  while Not TDataBaseConfig.GetObject.DBConnected do
  begin
    if G_bApplicationTerminate then Exit;
    if TDataBaseConfig.GetObject.Cancel then
    begin
      LogSave(G_stExeFolder + '\..\log\ServerHis.log','Daemon Program Close(DB Connect Fail) ');

      Application.Terminate;
      Exit;
    End;
    TDataBaseConfig.GetObject.ShowDataBaseConfig;
  end;
  Logined := False;
  LoadAlarmCode;
//showmessage('1-2');
  for i := 0 to HIGH(G_bFormEnabled) do G_bFormEnabled[i] := False;

  dmDeviceControlCenter.OnDeviceConnected := DeviceConnected;
  dmDeviceControlCenter.OnRcvData := NodeRecvDataProcess;
  dmDeviceControlCenter.OnSendData := DeviceSendDataProcess;
  dmDeviceControlCenter.OnRcvAlarmEvent := RcvAlarmEvent;
  dmDeviceControlCenter.OnRcvCardAccessEvent := RcvCardAccessEvent;
  dmDeviceControlCenter.OnRcvCardRegData := RcvCardRegData;
  dmDeviceControlCenter.OnRcvDeviceInitialize := ReceiveDeviceInitialize;
  dmDeviceControlCenter.OnRcvDoorModeChange := RcvDoorModeChange;
  dmDeviceControlCenter.OnRcvDoorSetupAck := RcvDoorSetupAck;
  dmDeviceControlCenter.OnRcvMasterNoRegData := RcvMasterNoRegData;
  dmDeviceControlCenter.OnRcvPasswordRegData := RcvPasswordRegData;
  dmDeviceControlCenter.OnMessage := RcvMessageData;

  Application.OnException := AppException;
  dmDBFunction.UpdateTB_DEVICECARDNO_AllState('S','N');
  dmDBFunction.UpdateTB_DEVICEPASSWD_AllState('S','N');

  StartMenu.SubMenuItems[1].Title := strBuildInfo;
  AdvToolBarPager1.Caption.Caption := '출입관리시스템[' + strBuildInfo + ']';
  LoadDoorSchedule;
  PCScheduleTimer.Enabled := True;

  FontSetting;
//showmessage('2');
end;

procedure TfmMain.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('1','M00001') + '[' + strBuildInfo + ']';
  AdvToolBarPager1.Caption.Caption := dmFormName.GetFormMessage('1','M00001') + '[' + strBuildInfo + ']';
  ApBasicAdmin.Caption := dmFormName.GetFormMessage('1','M00002');
  ApManagerAdmin.Caption := dmFormName.GetFormMessage('1','M00003');
  ApManagerAdmin.Caption := dmFormName.GetFormMessage('1','M00003');
  ApEtc.Caption := dmFormName.GetFormMessage('1','M00004');
  AdvToolBar8.Caption := dmFormName.GetFormMessage('1','M00005');
  AdvToolBar7.Caption := dmFormName.GetFormMessage('1','M00006');
  AdvToolBar2.Caption := dmFormName.GetFormMessage('1','M00007');
  AdvToolBar9.Caption := dmFormName.GetFormMessage('1','M00061');
  AdvToolBar1.Caption := dmFormName.GetFormMessage('1','M00008');
  AdvToolBar4.Caption := dmFormName.GetFormMessage('1','M00009');
  AdvToolBar3.Caption := dmFormName.GetFormMessage('1','M00010');
  AdvToolBar5.Caption := dmFormName.GetFormMessage('1','M00011');
  AdvToolBar6.Caption := dmFormName.GetFormMessage('1','M00062');
  AdvGlowButton6.Caption := dmFormName.GetFormMessage('1','M00012');
  AdvGlowButton7.Caption := dmFormName.GetFormMessage('1','M00013');
  AdvGlowButton42.Caption := dmFormName.GetFormMessage('1','M00059');
  AdvGlowButton67.Caption := dmFormName.GetFormMessage('1','M00015');
  AdvGlowButton53.Caption := dmFormName.GetFormMessage('1','M00016');
  AdvGlowButton9.Caption := dmFormName.GetFormMessage('1','M00061');
  AdvGlowButton1.Caption := dmFormName.GetFormMessage('1','M00017');
  AdvGlowButton8.Caption := dmFormName.GetFormMessage('1','M00018');
  AdvGlowButton5.Caption := dmFormName.GetFormMessage('1','M00019');
  AdvGlowButton2.Caption := dmFormName.GetFormMessage('1','M00020');
  mn_btnMonitoring.Caption := dmFormName.GetFormMessage('1','M00021');
  AdvGlowButton4.Caption := dmFormName.GetFormMessage('1','M00022');
  AdvGlowButton10.Caption := dmFormName.GetFormMessage('1','M00023');
  btn_AlarmReport.Caption := dmFormName.GetFormMessage('1','M00063');
  AdvGlowButton3.Caption := dmFormName.GetFormMessage('1','M00060');
  btn_DeviceLanSetting.Caption := dmFormName.GetFormMessage('1','M00062');
  btn_fmConfigSetting.Caption := dmFormName.GetFormMessage('1','M00025');
  btn_DBBackup.Caption := dmFormName.GetFormMessage('1','M00026');
  //btn_RemoteControl.Caption := dmFormName.GetFormMessage('1','M00027');
  btn_Upgrade.Caption := dmFormName.GetFormMessage('1','M00028');
  StartMenu.SubMenuCaption := dmFormName.GetFormMessage('1','M00029');
  StartMenu.MenuItems.Items[0].Caption := dmFormName.GetFormMessage('1','M00030');
  StartMenu.MenuItems.Items[1].Caption := dmFormName.GetFormMessage('1','M00031');
  StartMenu.MenuItems.Items[2].Caption := dmFormName.GetFormMessage('1','M00032');
  StartMenu.MenuItems.Items[3].Caption := dmFormName.GetFormMessage('1','M00033');
  StartMenu.MenuItems.Items[4].Caption := dmFormName.GetFormMessage('1','M00034');

  pm_cardbackup.Caption := dmFormName.GetFormMessage('4','M00063');
  pm_cardload.Caption := dmFormName.GetFormMessage('4','M00064');

end;

procedure TfmMain.FormShow(Sender: TObject);
var
  stLogoFile : string;
begin
//showmessage('3');
  stLogoFile := G_stExeFolder + '\..\image\Logo.JPG';
  if FileExists(stLogoFile) then
     Image1.Picture.LoadFromFile(stLogoFile);

  AdvToolBarPager1.ActivePageIndex := 1;

  if G_nCardRegisterPort > 0 then CardRegistPortOpen;

  dmCardPermit.TimerStart := True;
  CardAutoDownTimer.Enabled := True;
  dmDeviceControlCenter.Start := True;
  NodeOpenCheckTimer.Enabled := True;
  AlarmConfigSetting;
end;



procedure TfmMain.LoadAlarmCode;
var
  TempAdoQuery : TADOQuery;
  stSql : string;
begin
  if AlarmCodeList = nil then  AlarmCodeList := TStringList.Create;
  AlarmCodeList.Clear;
  stSql := 'select * from TB_ALARMCODE ';

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
        LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','LoadAlarmCode Error');

        Exit;
      End;

      if RecordCount > 0  then
      begin
        First;
        Try
          while not eof do
          begin
            if G_bApplicationTerminate then Exit;
            AlarmCodeList.Add( FindField('AE_ALARMCODE').AsString);
            Next;
            Application.ProcessMessages;
          end;
        Except
          LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','LoadAlarmCode Error');

        End;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
    L_bCardDownLoad := False;
  End;
end;

function TfmMain.LoadCardFromFile(aFileName: string): Boolean;
var
  TempLineList : TStringList;
  TempList : TStringList;
  i : integer;
  stSql : string;
  stCardNo : string;
  stCardName : string;
  stParentCode : string;
  stChildCode : string;
  stPosition : string;
  stTelNum : string;
begin
  result := False;
  TempLineList := TStringList.create;
  TempList := TStringList.create;
  Try
    TempLineList.LoadFromFile(aFileName);
    if TempLineList.Count < 1 then Exit;
    if (Application.MessageBox(PChar(dmFormName.GetFormMessage('2','M00059')),pchar(dmFormName.GetFormMessage('3','M00001')),MB_OKCANCEL) = IDOK)  then
    begin
      stSql := 'Delete from TB_CARD ';
      dmDataBase.ProcessExecSQL(stSql);
    end;

    for i := 0 to TempLineList.Count - 1 do
    begin
      TempList.Clear;
      TempList.Delimiter := ',';
      TempList.DelimitedText := TempLineList.Strings[i];
      if TempList.Count > 0 then stCardNo := TempList.Strings[0]
      else continue;
      if Length(stCardNo) <> 8 then continue;
      if TempList.Count > 1 then stCardName := TempList.Strings[1]
      else stCardName := stCardNo;
      if TempList.Count > 2 then stParentCode := TempList.Strings[2]
      else stParentCode := FillZeroNumber(0,G_nBuildingCodeLength);
      if TempList.Count > 3 then stChildCode := TempList.Strings[3]
      else stChildCode := FillZeroNumber(0,G_nBuildingCodeLength);
      if TempList.Count > 4 then stPosition := TempList.Strings[4]
      else stPosition := '';
      if TempList.Count > 5 then stTelNum := TempList.Strings[5]
      else stTelNum := '';

      stSql := 'Insert Into TB_CARD( ';
      stSql := stSql + 'GROUP_CODE,';
      stSql := stSql + 'CA_CARDNO,';
      stSql := stSql + 'CA_NAME,';
      stSql := stSql + 'BC_PARENTCODE,';
      stSql := stSql + 'BC_CHILDCODE,';
      stSql := stSql + 'CA_POSITION,';
      stSql := stSql + 'CA_TELNUM,';
      stSql := stSql + 'CA_ACCPERMIT,';
      stSql := stSql + 'CA_ASYNC )';
      stSql := stSql + ' Values( ';
      stSql := stSql + '''' + G_stGroupCode + ''',';
      stSql := stSql + '''' + stCardNo + ''',';
      stSql := stSql + '''' + stCardName + ''',';
      stSql := stSql + '''' + stParentCode + ''',';
      stSql := stSql + '''' + stChildCode + ''',';
      stSql := stSql + '''' + stPosition + ''',';
      stSql := stSql + '''' + stTelNum + ''',';
      stSql := stSql + '''N'',';
      stSql := stSql + '''N'') ';
      dmDataBase.ProcessExecSQL(stSql);
    end;
    result := True;
  Finally
    TempList.Free;
    TempLineList.Free;
  End;
end;

procedure TfmMain.LoadDoorSchedule;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nIndex : integer;
  stDeviceID : string;
  oDoorSchedule : TDoorSchedule;
begin
  UnLoadDoorSchedule;
  stSql := 'select a.* from TB_DOORSCHEDULE a ';
  stSql := stSql + ' Inner Join ( select * from TB_DOOR Where DO_SCHEDULE = ''1'') b ';
  stSql := stSql + ' ON(a.ND_NODENO = b.ND_NODENO ';
  stSql := stSql + ' AND a.DE_ECUID = b.DE_DEVICEID ';
  stSql := stSql + ' AND a.DO_DOORNO = b.DO_DOORNO ) ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery  do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit; //전송할게 없다.
      while Not Eof do
      begin
        stDeviceID := FillZeroNumber(FindField('ND_NODENO').asInteger,G_nNodeCodeLength) + FillZeroStrNum(FindField('DE_ECUID').AsString,G_nDeviceCodeLength);
        nIndex := DoorScheduleList.IndexOf(stDeviceID);
        if nIndex < 0 then
        begin
          oDoorSchedule := TDoorSchedule.Create(nil);
          oDoorSchedule.DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'1','0000',FindField('DS_TIME1').AsString,FindField('DS_TIMEMODE1').AsString);
          oDoorSchedule.DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'2',FindField('DS_TIME1').AsString,FindField('DS_TIME2').AsString,FindField('DS_TIMEMODE2').AsString);
          oDoorSchedule.DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'3',FindField('DS_TIME2').AsString,FindField('DS_TIME3').AsString,FindField('DS_TIMEMODE3').AsString);
          oDoorSchedule.DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'4',FindField('DS_TIME3').AsString,FindField('DS_TIME4').AsString,FindField('DS_TIMEMODE4').AsString);
          oDoorSchedule.DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'5',FindField('DS_TIME4').AsString,'2400',FindField('DS_TIMEMODE5').AsString);
          DoorScheduleList.AddObject(stDeviceID,oDoorSchedule);
        end else
        begin
          TDoorSchedule(DoorScheduleList.Objects[nIndex]).DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'1','0000',FindField('DS_TIME1').AsString,FindField('DS_TIMEMODE1').AsString);
          TDoorSchedule(DoorScheduleList.Objects[nIndex]).DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'2',FindField('DS_TIME1').AsString,FindField('DS_TIME2').AsString,FindField('DS_TIMEMODE2').AsString);
          TDoorSchedule(DoorScheduleList.Objects[nIndex]).DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'3',FindField('DS_TIME2').AsString,FindField('DS_TIME3').AsString,FindField('DS_TIMEMODE3').AsString);
          TDoorSchedule(DoorScheduleList.Objects[nIndex]).DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'4',FindField('DS_TIME3').AsString,FindField('DS_TIME4').AsString,FindField('DS_TIMEMODE4').AsString);
          TDoorSchedule(DoorScheduleList.Objects[nIndex]).DayOfWeekScheduleAdd(FindField('DS_DAYCODE').AsString,'5',FindField('DS_TIME4').AsString,'2400',FindField('DS_TIMEMODE5').AsString);
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadHoliday;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nIndex : integer;
  stDeviceID : string;
  oDoorSchedule : TDoorSchedule;
begin
  HoliDayList.Clear;
  stSql := 'select * from TB_HOLIDAY ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery  do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit; //전송할게 없다.
      while Not Eof do
      begin
        HoliDayList.Add(FindField('HO_DAY').AsString);
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmMain.MasterNoRegist(aNodeNo: integer; aEcuID: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nDeviceIndex : integer;
  stDeivceCaption : string;
begin
  if Not isDigit(G_stMasterNo) then Exit;
  if Length(G_stMasterNo) <> 4 then Exit; //마스터번호는 4자리 숫자이다.

  result := True;
  stSql := ' Select * from TB_DOOR ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND DO_MASTERRCV = ''N'' ';
  stSql := stSql + ' AND ND_NODENO = ' + inttostr(aNodeNo) + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aEcuID + ''' ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery  do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        result := False;
        Exit;
      End;
      if recordCount < 1 then Exit; //전송할게 없다.
      while Not Eof do
      begin
        stDeivceCaption :=  FillZeroNumber(FindField('ND_NODENO').asInteger,G_nNodeCodeLength) + FindField('DE_DEVICEID').AsString;
        nDeviceIndex:= DeviceList.IndexOf(stDeivceCaption);
        if nDeviceIndex > -1 then
        begin
          TDevice(DeviceList.Objects[nDeviceIndex]).MasterNoDownload(UpperCase(G_stMasterNo),'000000','1','0','0','L',1);
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.MDIChildShow(FormName: String);
var
  tmpFormClass : TFormClass;
  tmpClass : TPersistentClass;
  tmpForm : TForm;
  clsName : String;
  i : Integer;
begin
  clsName := FormName;
  tmpClass := FindClass(clsName);
  if tmpClass <> nil then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      if Screen.Forms[i].ClassNameIs(clsName) then
      begin
        if Screen.ActiveForm = Screen.Forms[i] then
        begin
          //Screen.Forms[i].WindowState := wsMaximized;
          Exit;
        end;
        Screen.Forms[i].Show;
        Exit;
      end;
    end;

    tmpFormClass := TFormClass(tmpClass);
    tmpForm := tmpFormClass.Create(Self);
    tmpForm.Show;
  end;
end;

function TfmMain.MDIForm(FormName: string): TForm;
var
  tmpFormClass : TFormClass;
  tmpClass : TPersistentClass;
  tmpForm : TForm;
  clsName : String;
  i : Integer;
begin
  result := nil;
  clsName := FormName;
  tmpClass := FindClass(clsName);
  if tmpClass <> nil then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      if Screen.Forms[i].ClassNameIs(clsName) then
      begin
        result := Screen.Forms[i];
        Exit;
      end;
    end;
  end;
end;

procedure TfmMain.MDIFormAllClose;
var
  i : integer;
begin
  for i := 0 to HIGH(G_bFormEnabled) do
  begin
    if G_bFormEnabled[i] then ChildFormClose(i);
  end;

end;

procedure TfmMain.NodeOpenCheckTimerTimer(Sender: TObject);
begin
  inherited;
  Try
    if G_bApplicationTerminate then Exit;

    NodeOpenCheckTimer.Enabled := False;
    sb_Status.Panels.Items[2].Text := 'NodeOpenCheckTimer';
    dmDeviceControlCenter.NodeOpenCheck;
  Finally
    NodeOpenCheckTimer.Enabled := Not G_bApplicationTerminate;
  End;
end;

procedure TfmMain.NodeRecvDataProcess(Sender: TObject; aNodeNo: integer; aMcuID,
  aECUID, aCmd, aMsgNo, aDeviceVer, aRealData: string);
var
  fmTemp : TForm;
begin
  if G_bFormEnabled[FORMDEVICECOMMONITORING] then
  begin
      fmTemp := MDIForm('TfmDeviceComMonitoring');
      if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).NodeRecvDataProcess(aNodeNo, aMcuID,
                            aECUID, aCmd, aMsgNo, aDeviceVer, aRealData);
  end;
end;

procedure TfmMain.PasswordDataDownLoad(aNodeNo,aDeviceID:string);
var
  stPassword: String;
  stAccess: String;
  stAlarm: String;
  stDoor1: String;
  stDoor2: String;
  cTimeCode: Char;
  stSend: String[1];
  cPermit: Char;
  cCardType: Char;
  cRegCode: Char;
  nDeviceIndex: Integer;
  stDownLoadData: String;
  stSql : String;
  TempAdoQuery : TADOQuery;
  i : integer;
  nPositionNum : integer;
  stValidDate : string;
  stDeivceCaption : string;
begin
  if L_bPasswordDownLoad then Exit;
  L_bPasswordDownLoad := True;

  stSql := 'Update TB_DEVICEPASSWD Set DE_RCVACK = ''R'' '; //송신 준비 상태로 변경
  stSql := stSql + ' WHERE GROUP_CODE = ''' + G_stGroupCode + ''' ' ;
  stSql := stSql + ' AND DE_RCVACK = ''N'' ' ;
  if G_nDBType = POSTGRESQL then stSql := stSql + ' AND Length(PA_PASSWORD) = ' + inttostr(G_nPasswordFixedLength) + ' '
  else stSql := stSql + ' AND Len(PA_PASSWORD) = ' + inttostr(G_nPasswordFixedLength) + ' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';

  dmDataBase.ProcessExecSQL(stSql);

  stSql := 'Select top 1 * ';
  stSql := stSql + ' from TB_DEVICEPASSWD ';
  stSql := stSql + ' Where DE_RCVACK = ''R'' ';
  stSql := stSql + ' AND GROUP_CODE = ''' + G_stGroupCode + ''' ' ;
  if G_nDBType = POSTGRESQL then stSql := stSql + ' AND Length(PA_PASSWORD) = ' + inttostr(G_nPasswordFixedLength) + ' '
  else stSql := stSql + ' AND Len(PA_PASSWORD) = ' + inttostr(G_nPasswordFixedLength) + ' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' order by de_permit,PA_PASSWORD ';

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
        LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','Select Error');

        Exit;
      End;

      if RecordCount > 0  then
      begin
        First;
        Try
          while not eof do
          begin
            if G_bApplicationTerminate then Exit;
            stValidDate := ''; //유효기간
            if Length(stValidDate) <> 8 then stValidDate := '00000000';
            if Not IsDigit(stValidDate) then stValidDate := '00000000';
            stValidDate := copy(stValidDate,3,6); //유효기간

            stPassword:= FindField('PA_PASSWORD').asString;
            stDeivceCaption:= FillZeroNumber(FindField('ND_NODENO').asInteger,G_nNodeCodeLength) + FindField('DE_DEVICEID').AsString;
            dmDBFunction.UpdateTB_DEVICEPASSWD_PasswordState(inttostr(FindField('ND_NODENO').asInteger),FindField('DE_DEVICEID').AsString,stPassword,'R','S'); //송신데이터 송신중으로 처리
            nPositionNum := 0;

            if (FindField('DE_DOOR1').IsNull) or (Trim(FindField('DE_DOOR1').asstring) = '')  then stDoor1:='N'
            else stDoor1:= FindField('DE_DOOR1').asString;

            if (FindField('DE_DOOR2').IsNull) or (Trim(FindField('DE_DOOR2').asstring) = '') then stDoor2:='N'
            else stDoor2:= FindField('DE_DOOR2').asString;

            if (FindField('DE_USEACCESS').IsNull) or (Trim(FindField('DE_USEACCESS').asstring) = '')  then stAccess:='N'
            else stAccess:= FindField('DE_USEACCESS').asString;
            if (stDoor1 = 'N') and (stDoor2 = 'N') then stAccess := 'N'; //1번,2번 출입 권한 모두 없으면 출입권한 없는거임... 2011.06.09 수정

            if (FindField('DE_USEALARM').IsNull) or (Trim(FindField('DE_USEALARM').asstring) = '')  then stAlarm:='N'
            else stAlarm:= FindField('DE_USEALARM').asString;
            if (FindField('DE_TIMECODE').IsNull) or (Trim(FindField('DE_TIMECODE').asstring) = '')  then cTimeCode:='0'
            else cTimeCode:= FindField('DE_TIMECODE').asstring[1];
            if (FindField('DE_PERMIT').IsNull) or (Trim(FindField('DE_PERMIT').asstring) = '')  then cPermit:='N'
            else cPermit:= FindField('DE_PERMIT').asString[1];

            if cPermit = 'L' then
            begin

              if stAccess = 'Y' then   //출입 허가
              begin

                if stAlarm = 'Y' then cCardType:= '2' //카드타입설정: 2=> 출입 + 방범
                else                  cCardType:= '0'; //카드타입설정: 0=> 출입

                if (stDoor1 = 'Y') and (stDoor2 = 'Y') then
                begin
                  cRegCode:= '0';
                end else if  stDoor1 = 'Y' then
                begin
                  cRegCode:= '1';
                end else if  stDoor2 = 'Y' then
                begin
                  cRegCode:= '2';
                end else
                begin
                  if stAlarm = 'Y' then cCardType:= '1' //카드타입설정: 1=> 방범 전용
                  else
                  begin
                    cRegCode:= '0';
                    cPermit:= 'N';
                  end;
                end;
              end else if stAlarm = 'Y' then  // 출입 X ,방범만 OK
              begin
                //aRegCode:= '3';
                cRegCode:= '0';
                cCardType:= '1';

              end else
              begin
                cCardType:= '0';
                cRegCode:= '0';
                cPermit:= 'N';
              end;
            end
            else
            begin
                cCardType:= '0';
                cRegCode:= '0';
                cPermit:= 'N';
            end;


            //if cPermit = 'L' then cPermit := 'p'   //비밀번호 등록 p,삭제 n
            //else cPermit := 'n';

            nDeviceIndex:= DeviceList.IndexOf(stDeivceCaption);

            if nDeviceIndex < 0 then
            begin
              LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log',aDeviceID+'미등록 기기[카드다운로드]');
              Exit;
            end else
            begin
              TDevice(DeviceList.Objects[nDeviceIndex]).PasswordDownload(stPassword,stValidDate,cCardType,cRegCode,cTimeCode,cPermit,nPositionNum);
            end;
            Next;
            Application.ProcessMessages;
          end;
        Except
          LogSave(G_stExeFolder + '\..\log\err'+ FormatDateTIme('yyyymmdd',Now)+'.log','DownLoad Error');

        End;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
    L_bPasswordDownLoad := False;
  End;
end;

procedure TfmMain.PCScheduleStart;
var
  nWeekCode : integer;
  stTime : string;
  stDayCode : string;
  i : integer;
  stDoorMode : string;
  stDeviceID : string;
  nIndex : integer;
begin
  if DoorScheduleList.Count < 1 then Exit;

  nWeekCode := 8;
  stTime := FormatDateTime('yyyymmddhhnnss',now);
  if HoliDayList.IndexOf(copy(stTime,1,8)) > -1 then nWeekCode := 0; //공휴일
  if nWeekCode <> 0 then
  begin
    nWeekCode := DayOfWeek(now); //1: 일요일,7:토요일
  end;
  if nWeekCode = 0 then stDayCode := '3'   //특정일
  else if nWeekCode = 1 then stDayCode := '2' //일요일
  else if nWeekCode = 7 then stDayCode := '1' //토요일
  else stDayCode := '0'; //평일

  for i := DoorScheduleList.Count - 1  downto 0 do
  begin
    stDeviceID := DoorScheduleList.Strings[i];
    stDoorMode := TDoorSchedule(DoorScheduleList.Objects[i]).GetCurrentTimeDoorMode(stDayCode,copy(stTime,9,4));
    nIndex := DeviceList.IndexOf(stDeviceID);
    if nIndex > -1 then
    begin
      if stDoorMode = '0' then  //운영모드
      begin
        if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorMode) <> 'C' then
           TDevice(DeviceList.Objects[nIndex]).ModeChange('c');
      end else if stDoorMode = '1' then   //개방모드
      begin
        if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorMode) <> 'O' then
           TDevice(DeviceList.Objects[nIndex]).ModeChange('o');
      end;
    end;
  end;
end;

procedure TfmMain.PCScheduleTimerTimer(Sender: TObject);
begin
  inherited;
  PCScheduleTimer.Enabled := False;
  if G_bApplicationTerminate then Exit;
  sb_Status.Panels[2].Text := 'PCScheduleTimerStart';

  Try
    PCScheduleStart;
  Finally
    PCScheduleTimer.Enabled := Not G_bApplicationTerminate;
  End;
  sb_Status.Panels[2].Text := 'PCScheduleTimerEnd';

end;

procedure TfmMain.pm_cardbackupClick(Sender: TObject);
var
  stFileName : string;
begin
  inherited;
  SaveDialog1.defaultExt := 'csv';
  SaveDialog1.Filter := 'CSV files (*.CSV)|*.CSV';
  if SaveDialog1.Execute then
  begin
    stFileName := SaveDialog1.FileName;
    if SaveCardToFile(stFileName) then
    begin
      showmessage('카드백업 완료');
    end else showmessage('카드백업 실패');
  end;
end;

procedure TfmMain.pm_cardloadClick(Sender: TObject);
var
  stFileName : string;
begin
  inherited;
  OpenDialog1.defaultExt := 'csv';
  OpenDialog1.Filter := 'CSV files (*.CSV)|*.CSV';
  if OpenDialog1.Execute then
  begin
    stFileName := OpenDialog1.FileName;
    if LoadCardFromFile(stFileName) then
    begin
      showmessage('카드등록 완료');
    end else showmessage('카드등록 실패');
  end;

end;

procedure TfmMain.RcvAlarmEvent(Sender: TObject; aNodeNo, aECUID, aDoorNo,
  aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aAlarmCode, aData10, aData11,
  aData12, aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
var
  fmTemp : TForm;
  nDeviceIndex : integer;
  stDeivceCaption : string;
  nResult : integer;
begin
//  if ord(aDoorMode[1]) < 20 then aDoorMode := '0';

  //출입 모니터링에 전송
  if G_bFormEnabled[FORMMONITORING] then
  begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).RcvAlarmEvent(aNodeNo, aECUID, aDoorNo,
        aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aAlarmCode);
  end;
  //여기에서 출입데이터 저장하자.
  dmDBFunction.InsertTB_ALARMEVENT(copy(aTime,1,8), copy(aTime,9,6), aNodeNo, aEcuID,
  aDoorNo, aAlarmCode);

end;

procedure TfmMain.RcvCardAccessEvent(Sender: TObject; aNodeNo, aECUID, aDoorNo,
  aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aChangeState, aAccessResult,
  aDoorState, aATButton, aCardNo, aData14, aData15, aData16, aData17, aData18,
  aData19, aData20: string);
var
  fmTemp : TForm;
  nDeviceIndex : integer;
  stDeivceCaption : string;
  nResult : integer;
begin
  if ord(aDoorMode[1]) < 20 then aDoorMode := '0';

  //출입 모니터링에 전송
  if G_bFormEnabled[FORMMONITORING] then
  begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).RcvCardAccessEvent(aNodeNo, aECUID, aDoorNo,
        aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aChangeState, aAccessResult,aDoorState, aATButton, aCardNo);
  end;
  //여기에서 출입데이터 저장하자.
  dmDBFunction.InsertTB_ACCESSEVENT(copy(aTime,1,8), copy(aTime,9,6), aNodeNo, aEcuID,
  aDoorNo, aCardNo, aReaderNo, aATButton, aInOut, aChangeState, aDoorMode,
  aCardMode, aAccessResult);

  stDeivceCaption:= FillZeroNumber(strtoint(aNodeNo),G_nNodeCodeLength) + aECUID;
  nDeviceIndex:= DeviceList.IndexOf(stDeivceCaption);
  if nDeviceIndex < 0 then Exit;

  if UpperCase(aChangeState) = 'C' then    //카드 데이터 이면
  begin
    //여기에서 권한 체크 해서 권한이 틀리면 다운로드 하자...
    nResult := CheckAccessCardGrade(aNodeNo,aECUID,aDoorNo,aCardNo);
    if nResult = 0 then      //권한없음
    begin
      if aAccessResult = '1' then //출입승인이면 삭제 하자
        TDevice(DeviceList.Objects[nDeviceIndex]).CardDownload(aCardNo,'000000','0','0','0','N',0);
    end else if nResult = 1 then //권한있음
    begin
      if aAccessResult = 'A' then //미승인이면 출입권한 등록하자
        TDevice(DeviceList.Objects[nDeviceIndex]).CardDownload(aCardNo,'000000','0','0','0','L',0);
    end;
  end else if UpperCase(aChangeState) = 'P' then    //비밀번호이면
  begin
    //여기에서 비밀번호 체크 해서 상태가 틀리면 다운로드 하자...
    nResult := CheckAccessPasswordGrade(aNodeNo,aECUID,aDoorNo,aCardNo);
    if nResult = 0 then      //권한없음
    begin
      if aAccessResult = '1' then //출입승인이면 삭제 하자
        TDevice(DeviceList.Objects[nDeviceIndex]).PasswordDownload(aCardNo,'000000','0','0','0','N',0);
    end else if nResult = 1 then //권한있음
    begin
      if aAccessResult = 'A' then //미승인이면 출입권한 등록하자
        TDevice(DeviceList.Objects[nDeviceIndex]).PasswordDownload(aCardNo,'000000','0','0','0','L',0);
    end;
  end;


end;

procedure TfmMain.RcvCardDataByReader(aData: string);
var
  nIndex: Integer;
  stData : string;
begin
  L_stRegistCardNo := L_stRegistCardNo + aData;

  repeat
    if G_bApplicationTerminate then Exit;
    nIndex := Pos(ETX,L_stRegistCardNo);
    if nIndex = 0 then Exit;
    stData:= Copy(L_stRegistCardNo,1,Pos(ETX,L_stRegistCardNo));
    Delete(L_stRegistCardNo,1,Pos(ETX,L_stRegistCardNo));
    //STX 삭제
    nIndex:= Pos(STX,stData);
    if nIndex > 0 then Delete(stData,1,nIndex);
    //ETX삭제
    nIndex:= Pos(ETX,stData);
    if nIndex > 0 then Delete(stData,nIndex,1);

    CardRegisterReadingProcess(stData);

    Application.ProcessMessages;
  until pos(ETX,L_stRegistCardNo) = 0;

end;

procedure TfmMain.RcvCardRegData(Sender: TObject; aNodeNo, aECUID,aResult,aCardNo,aCardType,aCmd, aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20: string);
begin
  case aCmd[1] of
    'g','h' : begin //카드등록
      if aResult = '1' then dmDBFunction.UpdateTB_DEVICECARDNO_CardNoState(aNodeNo,aEcuID,aCardNo,'S','Y');
    end;
    'j' : begin  //카드 삭제
      //if aResult = '1' then
      dmDBFunction.DeleteTB_DEVICECARDNO_CardNoPermit(aNodeNo,aEcuID,aCardNo,'N');
    end;
  end;
end;

procedure TfmMain.RcvDoorModeChange(Sender: TObject; aNodeNo, aECUID, aCmd,
  aResult, aMode, aDoorState, aData7, aData8, aData9, aData10, aData11, aData12,
  aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
var
  fmTemp : TForm;
begin
  //출입 모니터링에 전송
  if G_bFormEnabled[FORMMONITORING] then
  begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).RcvDoorModeChange(aNodeNo, aECUID, aResult,aMode,aDoorState);
  end;

end;

procedure TfmMain.RcvDoorSetupAck(Sender: TObject; aNodeNo, aECUID, aCmd,
  aDoorNo,aCardMode,aDoorMode,aDoorControlTime,aLongDoorOpenTime,aSchedule,aDoorState,aLongDoorOpenUse,aDoorLockType,aFireDoorControl,aLockState,aDoorOpenState,aRemoteDoorOpen,aResult,aData18,aData19,aData20: string);
begin
  if aResult = '1' then
    dmDBFunction.UpdateTB_DOORDeviceAsync(aNodeNo,aEcuID,aDoorNo,'Y');//출입문 정보 다운로드
end;

procedure TfmMain.RcvMasterNoRegData(Sender: TObject; aNodeNo, aECUID, aResult,
  aMasterNo, aCardType, aCmd, aData7, aData8, aData9, aData10, aData11, aData12,
  aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
begin
  case aCmd[1] of
    'g','h' : begin //마스터번호등록
      if aResult = '1' then dmDBFunction.UpdateTB_DOORMasterRcv(aNodeNo,aECUID,'1','Y');
    end;
  end;
end;

procedure TfmMain.RcvMessageData(Sender: TObject; aData1, aData2, aData3,
  aData4, aData5, aData6, aData7, aData8, aData9, aData10, aData11, aData12,
  aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
begin
  self.FindSubForm('Main').FindCommand('STATUSMSG').Params.Values['DATA'] := aData2;
  self.FindSubForm('Main').FindCommand('STATUSMSG').Execute;
end;

procedure TfmMain.RcvPasswordRegData(Sender: TObject; aNodeNo,aECUID,aResult,aPassword,aCardType,aCmd, aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20: string);
begin
  case aCmd[1] of
    'g','h' : begin //비밀번호등록
      if aResult = '1' then dmDBFunction.UpdateTB_DEVICEPASSWD_PasswordState(aNodeNo,aEcuID,aPassword,'S','Y');
    end;
    'j' : begin  //비밀번호 삭제
      dmDBFunction.DeleteTB_DEVICEPASSWD_PasswordPermit(aNodeNo,aEcuID,aPassword,'N');
    end;
  end;

end;

procedure TfmMain.ReceiveDeviceInitialize(Sender: TObject; aNodeNo, aECUID,
  aResult, aData4, aData5, aData6, aData7, aData8, aData9, aData10, aData11,
  aData12, aData13, aData14, aData15, aData16, aData17, aData18, aData19,
  aData20: string);
var
  fmTemp : TForm;
begin
  //출입 모니터링에 전송
  if G_bFormEnabled[FORMMONITORING] then
  begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).ReceiveDeviceInitialize(aNodeNo, aECUID, aResult);
  end;
end;

function TfmMain.SaveCardToFile(aFileName: string): Boolean;
var
  TempList : TStringList;
  TempAdoQuery : TADOQuery;
  stSql : string;
begin
  result := False;
  TempList := TStringList.create;
  Try
    stSql := 'select * from tb_card ';

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
        TempList.Clear;
        while Not Eof do
        begin
          TempList.Add(FindField('CA_CARDNO').asstring + ',' + FindField('CA_NAME').asstring + ',' + FindField('BC_PARENTCODE').asstring + ',' + FindField('BC_CHILDCODE').asstring + ',' + FindField('CA_POSITION').asstring + ',' + FindField('CA_TELNUM').asstring);
          Next;
        end;
        TempList.SaveToFile(aFileName);
        result := True;
      end;
    Finally
      TempAdoQuery.EnableControls;
      TempAdoQuery.Free;
      CoUninitialize;
    End;
  Finally
    TempList.Free;
  End;
end;

procedure TfmMain.SetLogined(const Value: Boolean);
begin
  FLogined := Value;
  {ApBasicAdmin.Enabled := Value;
  ApManagerAdmin.Enabled := Value;
  }
  //dmDeviceControlCenter.Start := Value;

  StartMenu.MenuItems.Items[1].Enabled := Not Value;
  StartMenu.MenuItems.Items[2].Enabled := Value;
  StartMenu.MenuItems.Items[3].Enabled := Value;
  ApBasicAdmin.TabVisible := Value;
  ApManagerAdmin.TabVisible := Value;
  ApEtc.TabVisible := Value;
  if Value then AdvToolBarPager1.Expand
  else AdvToolBarPager1.Collaps;

  if Not Value then MDIFormAllClose
  else mn_btnMonitoringClick(self); // MDIChildShow('TfmMonitoring');

  if Not Value then sb_Status.Panels[2].Text := dmFormName.GetFormMessage('2','M00055')
  else sb_Status.Panels[2].Text :=dmFormName.GetFormMessage('2','M00056');


end;

procedure TfmMain.StartMenuMenuItems1Click(Sender: TObject);
begin
  TLogin.GetObject.ShowLoginDlg;
  Logined := TLogin.GetObject.Logined;
end;

procedure TfmMain.StartMenuMenuItems2Click(Sender: TObject);
begin
  Logined := False;
end;

procedure TfmMain.StartMenuMenuItems3Click(Sender: TObject);
begin
  fmPwChange:= TfmPwChange.Create(Self);
  fmPwChange.Caption := StartMenu.MenuItems.Items[3].Caption;
  fmPwChange.SHowModal;
  fmPwChange.Free;
end;

procedure TfmMain.UnLoadDoorSchedule;
var
  i : integer;
begin
  if DoorScheduleList.Count < 1 then Exit;
  for i := DoorScheduleList.Count - 1 downto 0 do
  begin
    TDoorSchedule(DoorScheduleList.Objects[i]).Free;
  end;
  DoorScheduleList.Clear;
end;

end.
