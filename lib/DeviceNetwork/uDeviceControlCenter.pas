unit uDeviceControlCenter;

interface

uses
  System.SysUtils, System.Classes,Data.DB,
  Data.Win.ADODB,Winapi.ActiveX, Vcl.ExtCtrls,
  uDevicePacket;

type
  TdmDeviceControlCenter = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    NodeOpenCheckTimer: TTimer;
    SendPacketTimer: TTimer;
    L_bDataModuleDestroy : Boolean;
    L_NodeOpenCheckTimerStart : Boolean;
    L_bDataSendStarting : Boolean;
    L_nSendNodeSeq : integer;
    L_nReConnectSeq : integer;
    FStart: Boolean;
    FStop: Boolean;
    FOnRcvData: TReceiveData;
    FOnRcvCardRegData: TComEventData;
    FOnRcvPasswordRegData: TComEventData;
    FOnRcvDoorSetupAck: TComEventData;
    FOnRcvCardAccessEvent: TComEventData;
    FOnRcvDoorModeChange: TComEventData;
    FOnRcvDeviceInitialize: TComEventData;
    FOnSendData: TReceiveData;
    FOnRcvMasterNoRegData: TComEventData;
    FOnDeviceConnected: TComEventData;
    FOnCardDeleteData: TComEventData;
    FOnMessage: TComEventData;
    FOnRcvAlarmEvent: TComEventData;
    procedure SetStart(const Value: Boolean);
    { Private declarations }
    procedure DeviceLoad;
    procedure DeviceUnLoad;
    function NodeLoad :Boolean;
    procedure NodeUnLoad;
    procedure NodeSocketOpen;
    procedure NodeSocketClose;
    procedure NodeOpenCheckTimerTimer(Sender: TObject);
    procedure SendPacketTimerTimer(Sender: TObject);
    procedure DeviceSendTimerTimer(Sender:TObject);
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
    procedure RcvMasterRegData(Sender: TObject; aNodeNo,aECUID,aResult,aMasterNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure RcvPasswordRegData(Sender: TObject; aNodeNo,aECUID,aResult,aCardNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string);
    procedure NodeOpenCheck;

  published
    property Start :Boolean read FStart write SetStart;
  public
    property OnSendData : TReceiveData read FOnSendData write FOnSendData;
    ProPerty OnRcvData : TReceiveData read FOnRcvData write FOnRcvData;

    proPerty OnDeviceConnected : TComEventData read FOnDeviceConnected write FOnDeviceConnected;
    property OnRcvAlarmEvent : TComEventData read FOnRcvAlarmEvent write FOnRcvAlarmEvent;
    property OnRcvCardAccessEvent : TComEventData read FOnRcvCardAccessEvent write FOnRcvCardAccessEvent;
    property OnRcvCardRegData : TComEventData read FOnRcvCardRegData write FOnRcvCardRegData;
    property OnCardDeleteData : TComEventData read FOnCardDeleteData write FOnCardDeleteData;
    property OnRcvDeviceInitialize : TComEventData read FOnRcvDeviceInitialize write FOnRcvDeviceInitialize;
    property OnRcvDoorModeChange : TComEventData read FOnRcvDoorModeChange write FOnRcvDoorModeChange;
    property OnRcvDoorSetupAck : TComEventData read FOnRcvDoorSetupAck write FOnRcvDoorSetupAck;
    ProPerty OnRcvMasterNoRegData : TComEventData read FOnRcvMasterNoRegData write FOnRcvMasterNoRegData;
    property OnRcvPasswordRegData : TComEventData read FOnRcvPasswordRegData write FOnRcvPasswordRegData;
    property OnMessage : TComEventData read FOnMessage write FOnMessage;
  end;

var
  dmDeviceControlCenter: TdmDeviceControlCenter;

implementation
uses
  uCommonVariable,
  uDataBase,
  uControler,
  uFunction;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDeviceControlCenter }

procedure TdmDeviceControlCenter.RcvAlarmEvent(Sender: TObject; aNodeNo, aECUID,
  aDoorNo, aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aAlarmCode, aData10,
  aData11, aData12, aData13, aData14, aData15, aData16, aData17, aData18,
  aData19, aData20: string);
begin
  if Assigned(FOnRcvAlarmEvent) then
  begin
    OnRcvAlarmEvent(Sender,aNodeNo,aECUID,aDoorNo,aReaderNo,aInOut,aTime,aCardMode,aDoorMode,aAlarmCode,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvCardAccessEvent(Sender: TObject; aNodeNo,
  aECUID, aDoorNo, aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aChangeState,
  aAccessResult, aDoorState, aATButton, aCardNo, aData14, aData15, aData16,
  aData17, aData18, aData19, aData20: string);
begin
  if Assigned(FOnRcvCardAccessEvent) then
  begin
    OnRcvCardAccessEvent(Sender,aNodeNo,aECUID,aDoorNo,aReaderNo,aInOut,aTime,aCardMode,aDoorMode,aChangeState,aAccessResult,aDoorState,aATButton,aCardNo,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvCardRegData(Sender: TObject; aNodeNo,
  aECUID, aResult,aCardNo,aCardType,aCmd, aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20: string);
begin
  if Assigned(FOnRcvCardRegData) then
  begin
    OnRcvCardRegData(Sender,aNodeNo,aECUID,aResult,aCardNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvDoorModeChange(Sender: TObject; aNodeNo,
  aECUID, aCmd, aResult, aMode, aDoorState, aData7, aData8, aData9, aData10,
  aData11, aData12, aData13, aData14, aData15, aData16, aData17, aData18,
  aData19, aData20: string);
begin
  if Assigned(FOnRcvDoorModeChange) then
  begin
    OnRcvDoorModeChange(Sender,aNodeNo,aECUID,aCmd,aResult,aMode,aDoorState,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvDoorSetupAck(Sender: TObject; aNodeNo,
  aECUID, aCmd, aDoorNo,aCardMode,aDoorMode,aDoorControlTime,aLongDoorOpenTime,aSchedule,aDoorState,aLongDoorOpenUse,aDoorLockType,aFireDoorControl,aLockState,aDoorOpenState,aRemoteDoorOpen,aResult,aData18,aData19,aData20: string);
begin
  if Assigned(FOnRcvDoorSetupAck) then
  begin
    OnRcvDoorSetupAck(Sender,aNodeNo,aECUID,aCmd,aDoorNo,aCardMode,aDoorMode,aDoorControlTime,aLongDoorOpenTime,aSchedule,aDoorState,aLongDoorOpenUse,aDoorLockType,aFireDoorControl,aLockState,aDoorOpenState,aRemoteDoorOpen,aResult,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvMasterRegData(Sender: TObject; aNodeNo,
  aECUID, aResult, aMasterNo, aCardType, aCmd, aData7, aData8, aData9, aData10,
  aData11, aData12, aData13, aData14, aData15, aData16, aData17, aData18,
  aData19, aData20: string);
begin
  if Assigned(FOnRcvMasterNoRegData) then
  begin
    OnRcvMasterNoRegData(Sender,aNodeNo,aECUID,aResult,aMasterNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.RcvPasswordRegData(Sender: TObject; aNodeNo,aECUID,aResult,aCardNo,aCardType,aCmd, aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20: string);
begin
  if Assigned(FOnRcvPasswordRegData) then
  begin
    OnRcvPasswordRegData(Sender,aNodeNo,aECUID,aResult,aCardNo,aCardType,aCmd,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.ReceiveDeviceInitialize(Sender: TObject;
  aNodeNo, aECUID, aResult, aData4, aData5, aData6, aData7, aData8, aData9,
  aData10, aData11, aData12, aData13, aData14, aData15, aData16, aData17,
  aData18, aData19, aData20: string);
begin
  if Assigned(FOnRcvDeviceInitialize) then
  begin
    OnRcvDeviceInitialize(Sender,aNodeNo,aECUID,aResult,aData4,aData5,aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.DataModuleCreate(Sender: TObject);
begin
  NodeOpenCheckTimer := TTimer.Create(nil);
  NodeOpenCheckTimer.Interval := 100;
  NodeOpenCheckTimer.OnTimer := NodeOpenCheckTimerTimer;
  NodeOpenCheckTimer.Enabled := False;
  SendPacketTimer:= TTimer.Create(nil);
  SendPacketTimer.Interval := G_nComDelayTime;
  SendPacketTimer.OnTimer := SendPacketTimerTimer;
  SendPacketTimer.Enabled := False;
  L_nSendNodeSeq := 0;
end;

procedure TdmDeviceControlCenter.DataModuleDestroy(Sender: TObject);
begin
  L_bDataModuleDestroy := True;
  NodeOpenCheckTimer.Enabled := False;
  NodeOpenCheckTimer.Free;
end;

procedure TdmDeviceControlCenter.DeviceConnected(Sender: TObject; aNodeNo,
  aECUID, aConnected, aData4, aData5, aData6, aData7, aData8, aData9, aData10,
  aData11, aData12, aData13, aData14, aData15, aData16, aData17, aData18,
  aData19, aData20: string);
begin
  if Assigned(FOnDeviceConnected) then
  begin
    OnDeviceConnected(Self,aNodeNo,aECUID,aConnected,aData4,aData5,aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20);
  end;

end;

procedure TdmDeviceControlCenter.DeviceLoad;
var
  stSql : String;
  TempAdoQuery : TADOQuery;
  oNode   : TNode;
  oDevice     : TDevice;
  nOldNodeNo : integer;
  nNodeNo : integer;
  nIndex : integer;
  stDeviceCaption : string;
begin
  if DeviceList = nil then DeviceList := TStringList.Create;
  DeviceList.Clear;
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    stSql := 'select * from TB_DEVICE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + '''';
    stSql := stSql + ' order by ND_NODENO,DE_DEVICEID ';

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      nOldNodeNo:= 0;
      First;
      while not eof do
      begin
        if G_bApplicationTerminate then Exit;
        nNodeNo:= FindField('ND_NODENO').asInteger;
        // Append Treeview
        if nOldNodeNo <> nNodeNo then
        begin
          nIndex := NodeList.IndexOf(FillzeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength));
          if nIndex < 0 then
          begin
            oNode := nil;
            Next;
            continue;
          end;
          oNode:= TNode(NodeList.Objects[nIndex]);
          nOldNodeNo := nNodeNo;
        end;
        stDeviceCaption:=FillzeroNumber(nNodeNo,G_nNodeCodeLength) + FillZeroStrNum(FindField('DE_DEVICEID').asString,G_nDeviceCodeLength);

        //Create TDevice
        oDevice:= TDevice.Create(Self);
        oDevice.NodeNo := nNodeNo;
        oDevice.DeviceID := FillZeroStrNum(FindField('DE_DEVICEID').asString,G_nDeviceCodeLength);
        oDevice.DeviceName := FindField('DE_DEVICENAME').AsString;
        oDevice.OnAlarmEvent := RcvAlarmEvent;
        oDevice.OnCardAccessEvent := RcvCardAccessEvent;
        oDevice.OnCardRegData := RcvCardRegData;
        oDevice.OnDeviceConnected := DeviceConnected;
        oDevice.OnDeviceInitialize := ReceiveDeviceInitialize;
        oDevice.OnDoorModeChange := RcvDoorModeChange;
        oDevice.OnDoorSetupAck := RcvDoorSetupAck;
        oDevice.OnMasterNoRegData := RcvMasterRegData;
        oDevice.OnPasswordRegData := RcvPasswordRegData;
        oDevice.OnSendData := DeviceSendDataProcess;

        if oNode <> nil then
        begin
          oDevice.Node            := oNode;
          oNode.AddDeviceList(FillZeroStrNum(FindField('DE_DEVICEID').asString,G_nDeviceCodeLength));

          DeviceList.AddObject( stDeviceCaption,oDevice);
        end;
        next;
      end;
    end;

  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmDeviceControlCenter.DeviceSendDataProcess(Sender: TObject;
  aNodeNo: integer; aMcuID, aECUID, aCmd, aMsgNo, aDeviceVer,
  aRealData: string);
begin
  if Assigned(FOnSendData) then
  begin
    OnSendData(Self,aNodeNo,aMcuID,aECUID,aCmd,aMsgNo,aDeviceVer,aRealData);
  end;
end;

procedure TdmDeviceControlCenter.DeviceSendTimerTimer(Sender: TObject);
var
  //DelayTickCount : double;
  i : integer;
begin
{  Try
    DeviceSendTimer.Enabled := False;
    if DeviceList.Count < 1 then Exit;
    for i := 0 to DeviceList.Count -1 do
    begin
      if G_bApplicationTerminate then Exit;
      if Not L_bDataSendStarting then Exit;

      TDevice(DeviceList.Objects[i]).ExecSendPacket;
      Delay(ENQDelayTime);
    end;

  Finally
    DeviceSendTimer.Enabled := L_bDataSendStarting;
  End;
}
end;

procedure TdmDeviceControlCenter.DeviceUnLoad;
var
  i : integer;
begin
  for i := DeviceList.Count - 1 downto 0 do
  begin
    TDevice(DeviceList.Objects[i]).DeviceConnected := False;
    TDevice(DeviceList.Objects[i]).Free;
  end;
  DeviceList.Clear;

end;

function TdmDeviceControlCenter.NodeLoad:Boolean;
var
  stSql : String;
  TempAdoQuery : TADOQuery;
  obNode   : TNODE;
begin
  result := False;
  if NodeList = nil then NodeList := TStringList.Create;
  NodeList.Clear;
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    stSql := 'select * from TB_NODE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + '''';
    stSql := stSql + ' order by ND_NODENO ';

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      First;
      while Not Eof do
      begin
        if G_bApplicationTerminate then Exit;

        obNode := TNode.Create(nil);
        obNode.Connected := False;
        obNode.NodeNo := FindField('ND_NODENO').AsInteger;
        obNode.SocketType := FindField('ND_TYPE').AsInteger;
        obNode.ComPortNo := FindField('ND_COMPORT').AsInteger;
        obNode.LanIP := FindField('ND_NODEIP').AsString;
        obNode.LanPort := FindField('ND_NODEPORT').AsInteger;
        obNode.NodeName := FindField('ND_NAME').AsString;
        obNode.OnRcvData := NodeRecvDataProcess;

        NodeList.AddObject(FillzeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength),obNode);
        Next;
      end;
      result := True;
    end;

  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmDeviceControlCenter.NodeOpenCheck;
var
  i : integer;
  dtPollingTime: TDatetime;
  dtTimeOut: TDatetime;
begin
  for i := 0 to NodeList.Count - 1 do
  begin
    if G_bApplicationTerminate or L_bDataModuleDestroy then Exit;
    if TNode(NodeList.Objects[i]).Open then
    begin
      Try
        dtPollingTime:= TNode(NodeList.Objects[i]).LastReceiveTime;
        dtTimeOut:= IncTime(dtPollingTime,0,0,NODESOCKETDELAYTIME,0);
        if Now > dtTimeOut then
        begin
          if TNode(NodeList.Objects[i]).SocketType = TCPIP then
          begin
             TNode(NodeList.Objects[i]).Open := False; //15초간 아무 데이터가 없으면 소켓 끊고 재접속 해 보자
             TNode(NodeList.Objects[i]).LastReceiveTime := Now; //일정시간 후에 다시 Open 시도
          end else
          begin
             TNode(NodeList.Objects[i]).Open := False; //15초간 아무 데이터가 없으면 소켓 끊고 재접속 해 보자
             TNode(NodeList.Objects[i]).LastReceiveTime := Now; //일정시간 후에 다시 Open 시도
          end;
//          if Assigned(FOnMessage) then
//          begin
//            OnMessage(self,'','NodeCloseTry' +  TNode(NodeList.Objects[i]).NodeName,'','','','','','','','','','','','','','','','','','');
//          end;
        end;
      Except
        //
      End;
    end;
  end;

  if L_nReConnectSeq > (NodeList.Count - 1)  then L_nReConnectSeq := 0;

  for i := L_nReConnectSeq to NodeList.Count - 1 do
  begin
    if G_bApplicationTerminate or L_bDataModuleDestroy then Exit;
    if Not TNode(NodeList.Objects[i]).Open then
    begin
      TNode(NodeList.Objects[i]).Open := True;
      L_nReConnectSeq := i + 1;
      if Assigned(FOnMessage) then
      begin
        OnMessage(self,'','NodeOpenTry' + TNode(NodeList.Objects[i]).NodeName,'','','','','','','','','','','','','','','','','','');
      end;
      break;
    end;
    L_nReConnectSeq := i + 1;
  end;

end;

procedure TdmDeviceControlCenter.NodeOpenCheckTimerTimer(Sender: TObject);
var
  i : integer;
//  dtPollingTime: TDatetime;
//  dtTimeOut: TDatetime;
begin
  Try
    NodeOpenCheckTimer.Enabled := False;
    NodeOpenCheckTimer.Interval := 2000;
    NodeOpenCheck;
    {
    for i := 0 to NodeList.Count - 1 do
    begin
      if G_bApplicationTerminate then Exit;
      if TNode(NodeList.Objects[i]).Open then
      begin
        Try
          dtPollingTime:= TNode(NodeList.Objects[i]).LastReceiveTime;
          dtTimeOut:= IncTime(dtPollingTime,0,0,NODESOCKETDELAYTIME,0);
          if Now > dtTimeOut then
          begin
            if TNode(NodeList.Objects[i]).SocketType = TCPIP then
               TNode(NodeList.Objects[i]).Open := False; //15초간 아무 데이터가 없으면 소켓 끊고 재접속 해 보자
          end;
        Except
          //
        End;
      end;
    end;

    if L_nReConnectSeq > (NodeList.Count - 1)  then L_nReConnectSeq := 0;

    for i := L_nReConnectSeq to NodeList.Count - 1 do
    begin
      if G_bApplicationTerminate then Exit;
      L_nReConnectSeq := i;
      if Not TNode(NodeList.Objects[i]).Open then
      begin
        TNode(NodeList.Objects[i]).Open := True;
        L_nReConnectSeq := i + 1;
        if Assigned(FOnMessage) then
        begin
          OnMessage(Sender,'','NodeOpenTry' + TNode(NodeList.Objects[i]).NodeName,'','','','','','','','','','','','','','','','','','');
        end;
        break;
        //Delay(1000);
      end;
    end;  }

  Finally
    //NodeOpenCheckTimer.Enabled := Not G_bApplicationTerminate;
  End;
end;

procedure TdmDeviceControlCenter.NodeRecvDataProcess(Sender: TObject;
  aNodeNo: integer; aMcuID, aECUID, aCmd, aMsgNo, aDeviceVer,
  aRealData: string);
begin
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,aNodeNo,aMcuID,aECUID,aCmd,aMsgNo,aDeviceVer,aRealData);
  end;
end;

procedure TdmDeviceControlCenter.NodeSocketClose;
var
  i : integer;
begin
  L_NodeOpenCheckTimerStart := False;
  //NodeOpenCheckTimer.Enabled := L_NodeOpenCheckTimerStart;

  for i := 0 to NodeList.Count - 1 do
  begin
    TNode(NodeList.Objects[i]).Open := False;
  end;
end;

procedure TdmDeviceControlCenter.NodeSocketOpen;
begin
  L_NodeOpenCheckTimerStart := True;
  //NodeOpenCheckTimer.Enabled := L_NodeOpenCheckTimerStart;
end;

procedure TdmDeviceControlCenter.NodeUnLoad;
var
  i : integer;
begin
  for i  := NodeList.Count - 1 downto 0 do
  begin
    if TNode(NodeList.Objects[i]).Open then TNode(NodeList.Objects[i]).Open := False;
    TNode(NodeList.Objects[i]).Free;
  end;
  NodeList.Clear;
end;

procedure TdmDeviceControlCenter.SendPacketTimerTimer(Sender: TObject);
begin
  if G_bApplicationTerminate then  Exit;
  Try
    SendPacketTimer.Enabled := False;
    if NodeList.Count = 0 then Exit;
    if (NodeList.Count - 1) < L_nSendNodeSeq then L_nSendNodeSeq := 0;

    TNode(NodeList.Objects[L_nSendNodeSeq]).SendNextDevicePacket;
    L_nSendNodeSeq := L_nSendNodeSeq + 1;
  Finally
    SendPacketTimer.Enabled := Start;
  End;
end;

procedure TdmDeviceControlCenter.SetStart(const Value: Boolean);
begin
  if FStart = Value then Exit;

  FStart := Value;

  if Value then
  begin
    NodeLoad;
    DeviceLoad;
    NodeSocketOpen; //해당 노드의 소켓을 Open 후 통신 시작 하자
    L_bDataSendStarting := Value;
  end else
  begin
    L_bDataSendStarting := Value;
    NodeSocketClose;
    DeviceUnLoad;
    NodeUnLoad;
  end;
  SendPacketTimer.Enabled := Value;
end;

end.
