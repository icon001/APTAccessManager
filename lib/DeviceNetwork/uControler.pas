unit uControler;

interface

uses
  System.SysUtils, System.Classes, Web.Win.Sockets,Vcl.Forms,
  Winapi.Windows, CPort,CPortCtl,System.SyncObjs,Vcl.ExtCtrls,
  uDevicePacket, OoMisc, AdPort, AdWnPort,AdSocket;

const
    FIRSTRECV = 1;
    DATARECV = 2;
    CARDRECV = 3;
    ENQRECV = 4;
    CARDDELETERECV = 5;

    WSAEWOULDBLOCK = 10035;  //�񵿱� ���� �޽���

//{$DEFINE TApdWinsockport}  //{$DEFINE TClientSocket}

type

  TNode = Class(TComponent)
  private
    DelayTimer: TTimer;
    SocketReceiveTimer: TTimer;
    ComPort: TComPort;
    TcpClient: TTcpClient;
    ApdWinsockPort: TApdWinsockPort;

    NodeDeviceList : TStringList;

    L_stComBuffer : string; //��� ���Ž� �޴� ������
    L_bDataSendStarting : Boolean;  //DataSend Start
    L_bDataReceive : Boolean;  //��� ���� ����
    L_nSearchDeviceIndex : integer;  // Enq üũ �ϴ� SearchDeviceIndex;
    L_bNextDevicePacketSending : Boolean;
    L_bSocketReceiveBuffer : Boolean;

    { Private declarations }
    procedure ComPortCreate;
    procedure ComPortFree;
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure ComPortAfterOpen(Sender: TObject);
    procedure ComPortAfterClose(Sender: TObject);
    procedure ComPortError(Sender: TObject; Errors: TComErrors);
    procedure TcpClientReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure TcpClientConnect(Sender: TObject);
    procedure TcpClientDisconnect(Sender: TObject);
    procedure TcpClientError(Sender: TObject; SocketError: Integer);
    procedure TcpClientSend(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);

    procedure ApdWinsockPortTriggerAvail(CP: TObject; Count: Word);
    procedure ApdWinsockPortWsConnect(Sender: TObject);
    procedure ApdWinsockPortWsDisconnect(Sender: TObject);
    procedure ApdWinsockPortWsError(Sender: TObject; ErrCode: Integer);
  private
    FTCSDeviceSender : TCriticalSection;
    FTCSDeviceOpen : TCriticalSection;

    FSocketType: integer;
    FComPortNo: integer;
    FLanIP: string;
    FLanPort: integer;
    FConnected: Boolean;
    FOpen: Boolean;
    FNodeNo: integer;
    FNodeName: string;
    procedure DataReadingProcessing;
    procedure SetConnected(const Value: Boolean);
    procedure SetOpen(const Value: Boolean);

    procedure DeviceComnunicationStart;  //���� PC�� ��� ����
    procedure DeviceListBufferClear;     //���� ����� ��Ʈ�ѷ� ���� ���� Ŭ����
    procedure DeviceListDisConnect;      //���� ����� �ش� ����� ���ӻ��¸� ���� ���·� ����
  private
    FLastReceiveTime: TDateTime;
    FOnRcvData: TReceiveData;
    FDeviceRcvAck: Boolean;
    FOnConnected: TComEventData;
    procedure NodeDataPaceketProcess(aPacketData:string);
    procedure DelayTimerTimer(Sender: TObject);
    procedure SocketReceiveTimerTimer(Sender:TObject);
    procedure SetDeviceRcvAck(const Value: Boolean);
  public
    { Public declarations }
    function PutString(aData:string):Boolean;
    function ReceiveBuff(aDelayTime:integer):Boolean;
    function AddDeviceList(aDeviceID:string):Boolean;
    function DeleteDeviceList(aDeviceID:string):Boolean;
    function DeviceListClear:Boolean;
    procedure SendNextDevicePacket;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property NodeNo : integer read FNodeNo write FNodeNo;
    property NodeName : string read FNodeName write FNodeName;
    property SocketType : integer read FSocketType write FSocketType;
    property ComPortNo : integer read FComPortNo write FComPortNo;
    property LanIP : string read FLanIP write FLanIP;
    property LanPort : integer read FLanPort write FLanPort;
  public
    property Connected : Boolean read FConnected write SetConnected;
    property Open : Boolean read FOpen write SetOpen;
    property LastReceiveTime : TDateTime read FLastReceiveTime write FLastReceiveTime;
    property DeviceRcvAck : Boolean read FDeviceRcvAck write SetDeviceRcvAck;
  public
    ProPerty OnRcvData : TReceiveData read FOnRcvData write FOnRcvData;
    ProPerty OnConnected : TComEventData read FOnConnected write FOnConnected;

  end;

  TDevice = Class(TComponent)
  private
    FTCSSendPacket : TCriticalSection;

    ReserveTimer: TTimer;
    L_bDeviceResponse : Array [0..100] of Boolean; //�۽� �� ���� ���� ��Ŷ
    L_stLastPacket : string;  //���� ��Ŷ
    L_stAccessLastPacket : string;  //���� ���� ��Ŷ
    L_nLastPacketCount : integer; //���� ��Ŷ�� �ö�� �ݺ� Ƚ��
    L_nLastAccessPacketCount : integer; //���� ���� ��Ŷ�� �����ϰ� �ö�� �ݺ� Ƚ��
    L_nENQErrorCount : integer;   //ENQ ���� Ƚ��
    L_nReserveIndex : integer;    //0:ENQ,1:First
    L_nENQNotSendCount : integer; //ENQ�� �������� ���� Count 10ȸ �̻��̸� ENQ�� ��������.
    ReceiveDataList : TStringList;
    AckSendDataList : TStringList;
    FirstSendDataList: TStringList; // ���� ������ ������ ���
    SendDataList: TStringList; //������ ������ ���
    CardSendDataList: TStringList; //ī�� ������ ���
    CardDeleteSendDataList: TStringList; //ī�� ������ ���
    FDeviceConnected: Boolean;
    FNode: TNode;
    FNodeNo: integer;
    FDeviceID: string;
    FDeviceName: string;
    FLastReceiveTime: TDateTime;
    FECUID: string;
    FSendMsgNo: integer;
    procedure SetDeviceConnected(const Value: Boolean);
    procedure SetNode(const Value: TNode);
    procedure SetSendMsgNo(const Value: integer); // ī�嵥���� ������ ���
    procedure ReserveTimerTimer(Sender: TObject);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    { Public declarations }
    procedure ExecSendPacket;  //���⿡�� ������ ���� ����
    procedure BufferClear;

    Procedure ReceiveAccessEventData(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData:string); //�����̺�Ʈ ����
    procedure ReceiveCardRegAck(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData:string);  //ī����
    procedure ReceiveCardDeleteAck(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData:string);
    Procedure ReceiveDataPacket(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData:string);
    procedure ReceiveDeviceInitialize(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData:string);  //���Թ��������
    procedure ReceiveDoorModeChange(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData:string);  //���Թ��������
    procedure ReceiveDoorSetupAck(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData:string);  //���Թ��������
    procedure ReceiveDoorAckData(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData:string);

    Function SendACK(aCmd,aMsgNo,aData,aVer:string):Boolean;  //���⿡�� ������ ���� ����
    Function SendPacket(aCmd,aMsgNo,aData,aVer:string;aPriority:integer=2):Boolean;
  public
    Function CardAllDelete(aQuick:Boolean = False):Boolean;
    Function CardDownload(aCardNo:String; ValidDay: String; cardType:Char; RegCode:Char; aTimeCode:Char; func:Char;
                           aPositionNum:integer = 0;aQuick:Boolean = False):Boolean;
    Function CardDelete(aCardNo:String;aQuick:Boolean = False):Boolean;
    Function CardSearch(aCardNo:String;aQuick:Boolean = False):Boolean;
    Function DeviceDoorInfoSetting(aDoor,aCardMode,aDoorMode,aDoorControlTime,aOpenMoni,aUseSch,aSendDoor,aAlarmLong,
               aFire,aLockType,aDSOpen,aRemoteDoor,aCmd:string):Boolean;
    Function DeviceInitialize:Boolean; //����ʱ�ȭ
    Function MacReg(aMac:string;aQuick:Boolean = True):Boolean;
    Function MasterNoSearch(aQuick:Boolean = False):Boolean;
    Function MasterNoDownload(aPassword:String; ValidDay: String; cardType:Char; RegCode:Char; aTimeCode:Char; func:Char;
                           aPositionNum:integer = 0;aQuick:Boolean = False):Boolean;
    Function ModeChange(aMode:string):Boolean;
    Function PasswordAllDelete(aQuick:Boolean = False):Boolean;
    Function PasswordDelete(aPassword:String;aQuick:Boolean = False):Boolean;
    Function PasswordDownload(aPassword:String; ValidDay: String; cardType:Char; RegCode:Char; aTimeCode:Char; func:Char;
                           aPositionNum:integer = 0;aQuick:Boolean = False):Boolean;
    Function PasswordSearch(aPassword:String;aQuick:Boolean = False):Boolean;
  private
    FOnCardRegData: TComEventData;
    FOnPasswordRegData: TComEventData;
    FOnDoorSetupAck: TComEventData;
    FOnExitButtonEvent: TComEventData;
    FOnCardAccessEvent: TComEventData;
    FOnDoorModeChange: TComEventData;
    FOnDeviceInitialize: TComEventData;
    FOnSendData: TReceiveData;
    FOnCardDeleteData: TComEventData;
    FOnPasswordDeleteData: TComEventData;
    FOnMasterNoRegData: TComEventData;
    FDoorMode: string;
    FOnDeviceConnected: TComEventData;
    FDoorSTATE: string;
    Function ErrorDataProcess(aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData:string):Boolean;
    procedure SetDoorMode(const Value: string);
    procedure SetDoorSTATE(const Value: string);
  public
    property DeviceConnected : Boolean read FDeviceConnected write SetDeviceConnected;
    property LastReceiveTime : TDateTime read FLastReceiveTime write FLastReceiveTime;
  public
    property Node : TNode read FNode write SetNode;
    property NodeNo : integer read FNodeNo write FNodeNo;
    property DeviceID : string read FDeviceID write FDeviceID;
    property DeviceName : string read FDeviceName write FDeviceName;
    property SendMsgNo : integer read FSendMsgNo write SetSendMsgNo;
    property DoorMode : string read FDoorMode write SetDoorMode;
    property DoorSTATE : string read FDoorSTATE write SetDoorSTATE;
  public
    property OnCardAccessEvent : TComEventData read FOnCardAccessEvent write FOnCardAccessEvent;
    ProPerty OnCardRegData : TComEventData read FOnCardRegData write FOnCardRegData;
    proPerty OnDeviceConnected : TComEventData read FOnDeviceConnected write FOnDeviceConnected;
    property OnDeviceInitialize : TComEventData read FOnDeviceInitialize write FOnDeviceInitialize;
    property OnDoorModeChange : TComEventData read FOnDoorModeChange write FOnDoorModeChange;
    property OnDoorSetupAck : TComEventData read FOnDoorSetupAck write FOnDoorSetupAck;
    ProPerty OnMasterNoRegData : TComEventData read FOnMasterNoRegData write FOnMasterNoRegData;
    property OnExitButtonEvent : TComEventData read FOnExitButtonEvent write FOnExitButtonEvent;
    ProPerty OnSendData : TReceiveData read FOnSendData write FOnSendData;
    ProPerty OnPasswordRegData : TComEventData read FOnPasswordRegData write FOnPasswordRegData;
    ProPerty OnPasswordDeleteData : TComEventData read FOnPasswordDeleteData write FOnPasswordDeleteData;

  end;

  TdmControler = class(TDataModule)
    ComPort1: TComPort;
    TcpClient1: TTcpClient;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmControler: TdmControler;

implementation
uses
  uCommonVariable,
  uFunction;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TControler }

function TNode.AddDeviceList(aDeviceID: string): Boolean;
begin
  if NodeDeviceList.IndexOf(aDeviceID) < 0 then NodeDeviceList.Add(aDeviceID);
end;

procedure TNode.ApdWinsockPortTriggerAvail(CP: TObject; Count: Word);
var
  stBuf: string;
  i : integer;
begin
{$IFDEF TApdWinsockport}
  stBuf:= '';
  for I := 1 to Count do stBuf := stBuf + ApdWinsockPort.GetChar;
  L_stComBuffer := L_stComBuffer + stBuf;
  DataReadingProcessing;
{$ENDIF}
end;

procedure TNode.ApdWinsockPortWsConnect(Sender: TObject);
begin
  Connected := True;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','Connected');
  end;
end;

procedure TNode.ApdWinsockPortWsDisconnect(Sender: TObject);
begin
  Connected := False;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','DisConnected');
  end;
end;

procedure TNode.ApdWinsockPortWsError(Sender: TObject; ErrCode: Integer);
begin
{$IFDEF TApdWinsockport}
  if ErrCode = WSAEWOULDBLOCK then TApdWinsockPort(Sender).Tag := 0
  else begin
    Connected := False;
    TApdWinsockPort(Sender).Tag := ErrCode;
    if Assigned(FOnRcvData) then
    begin
      OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','SocketError-' + inttostr(ErrCode));
    end;
  end;
{$ENDIF}
end;

procedure TNode.ComPortAfterClose(Sender: TObject);
begin
  // Port Close;
  Connected := False;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','DisConnected');
  end;
end;

procedure TNode.ComPortAfterOpen(Sender: TObject);
begin
  // Port Open Success;
  Connected := True;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','Connected');
  end;
end;

procedure TNode.ComPortCreate;
begin
  ComPort:= TComPort.Create(nil);
  ComPort.OnRxChar := ComPortRxChar;
  ComPort.OnAfterOpen := ComPortAfterOpen;
  ComPort.OnAfterClose := ComPortAfterClose;
  ComPort.OnError := ComPortError;

end;

procedure TNode.ComPortError(Sender: TObject; Errors: TComErrors);
begin
  // Port Open Error
//  Connected := False;
//  ComPort.Close; //���� �� ��츸 Close ����...
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','ComPort Error');
  end;
end;

procedure TNode.ComPortFree;
begin
  Try
    ComPort.Free;
  Finally
    ComPort := nil;
  End;
end;

procedure TNode.ComPortRxChar(Sender: TObject; Count: Integer);
var
  stBuffer:string;
begin
  TComPort(Sender).ReadStr(stBuffer, Count);
  L_stComBuffer := L_stComBuffer + stBuffer;
  DataReadingProcessing;
end;

constructor TNode.Create(AOwner: TComponent);
begin
  inherited;
  L_bDataSendStarting := False;
  L_stComBuffer := '';
  ComPort := nil;
{$IFDEF TApdWinsockport}
  ApdWinsockPort := TApdWinsockPort.Create(nil);
  ApdWinsockPort.AutoOpen := False;
  ApdWinsockPort.DeviceLayer:= dlWinsock;
  ApdWinsockPort.WsMode:= wsClient;
  ApdWinsockPort.wsTelnet := False;
  ApdWinsockPort.OnWsConnect := ApdWinsockPortWsConnect;
  ApdWinsockPort.OnTriggerAvail := ApdWinsockPortTriggerAvail;
  ApdWinsockPort.OnWsDisconnect := ApdWinsockPortWsDisconnect;
  ApdWinsockPort.OnWsError := ApdWinsockPortWsError;
{$ELSE}
  TcpClient:= TTcpClient.Create(nil);
  TcpClient.BlockMode := bmBlocking;
  TcpClient.OnReceive := TcpClientReceive;
  TcpClient.OnConnect := TcpClientConnect;
  TcpClient.OnDisconnect := TcpClientDisconnect;
  TcpClient.OnError := TcpClientError;
  TcpClient.OnSend := TcpClientSend;
{$ENDIF}
  FTCSDeviceSender := TCriticalSection.Create;
  FTCSDeviceOpen := TCriticalSection.Create;

  NodeDeviceList := TStringList.Create; // ��Ʈ�ѷ� ���

  DelayTimer:= TTimer.Create(nil);
  DelayTimer.OnTimer := DelayTimerTimer;
  DelayTimer.Interval := G_nComDelayTime;
  DelayTimer.Enabled := False;

  SocketReceiveTimer := TTimer.Create(nil);
  SocketReceiveTimer.OnTimer := SocketReceiveTimerTimer;
  SocketReceiveTimer.Interval := 5;
  SocketReceiveTimer.Enabled := False;
  L_nSearchDeviceIndex := 0;
  DeviceRcvAck := False;  //Ack �����Ͱ� ����.
end;

procedure TNode.DataReadingProcessing;
var
  stPacketData : string;
  stLeavePacketData : string;
begin
  LastReceiveTime := now;
//���⿡�� L_stComBuffer �� packet üũ�Ͽ� ó�� ����
  repeat
    stPacketData:= MSR7000CheckDataPacket(L_stComBuffer,stLeavePacketData);
    L_stComBuffer:= stLeavePacketData;
    if stPacketData <> '' then NodeDataPaceketProcess(stPacketData);
  until pos(ETX,L_stComBuffer) = 0;

end;

procedure TNode.DelayTimerTimer(Sender: TObject);
var
  stSelectDeviceID : string;
  nIndex : integer;
begin
  DelayTimer.Enabled := False;
  if Not Open then Exit;
  if G_bApplicationTerminate then  Exit;
  //if DeviceRcvAck then Exit; //EnQ�� ���� Ack�� �����Ƿ� Ack �������� ����.
  Try
    if NodeDeviceList.Count < 1 then Exit;
    //Delay(1000);
    SendNextDevicePacket;
  Finally
    //DelayTimer.Enabled := Open;
  End;
end;

function TNode.DeleteDeviceList(aDeviceID: string): Boolean;
var
  nIndex : integer;
begin
  nIndex := NodeDeviceList.IndexOf(aDeviceID);
  if nIndex > -1 then NodeDeviceList.Delete(nIndex);
end;

destructor TNode.Destroy;
begin
  DelayTimer.Enabled := False;
  DelayTimer.Free;
  SocketReceiveTimer.Enabled := False;
  SocketReceiveTimer.Free;
  FTCSDeviceSender.Free;
  FTCSDeviceOpen.Free;
{$IFDEF TApdWinsockport}
  ApdWinsockPort.Free;
{$ELSE}
  TcpClient.Free;
{$ENDIF}

  NodeDeviceList.Free;
  inherited;
end;

procedure TNode.DeviceComnunicationStart;
//var
  //DelayTickCount : double;
//  i : integer;
begin
{  while L_bDataSendStarting do
  begin
    if DeviceList.Count < 1 then Exit;
    for i := 0 to DeviceList.Count -1 do
    begin
      if G_bApplicationTerminate then Exit;

      if Not Connected then
      begin
        L_bDataSendStarting := False;
        Exit;
      end;
      TDevice(DeviceList.Objects[i]).ExecSendPacket;
      L_bDataReceive := False;
      Delay(ENQDelayTime);
    end;

    Application.ProcessMessages;
  end;
}
end;

procedure TNode.DeviceListBufferClear;
var
  i : integer;
begin
  if DeviceList = nil then Exit;
  for i  := 0 to DeviceList.Count - 1 do
  begin
    if TDevice(DeviceList.Objects[i]).NodeNo = NodeNo then
      TDevice(DeviceList.Objects[i]).BufferClear;
  end;

end;

function TNode.DeviceListClear: Boolean;
begin
  NodeDeviceList.clear;
end;

procedure TNode.DeviceListDisConnect;
var
  i : integer;
begin
  if DeviceList = nil then Exit;
  Try
    for i  := 0 to DeviceList.Count - 1 do
    begin
      if TDevice(DeviceList.Objects[i]).NodeNo = NodeNo then
        TDevice(DeviceList.Objects[i]).DeviceConnected := False;
    end;
  Except
    Exit;
  End;

end;

procedure TNode.NodeDataPaceketProcess(aPacketData: string);
var
  aCommand: Char;
  stECUID: String;
  stCMD : String;
  cRcvMsgNo : char;
  stLength : string;
  stRealData : string;
  stDeviceCaption : string;
  nDeviceIndex: Integer;
  StatusCode: String;
  aSubCLass:String;
begin
  //LastReceiveTime := Now;
  //��Ŷ �м��ؼ� �ش� ����� ���ź������� ���� ����...
  if aPacketData = '' then Exit;
  stECUID := copy(aPacketData,2,2);
  stCMD:= copy(aPacketData,5,1);  //4��°�� ���� 0
  cRcvMsgNo:= aPacketData[6];
  stLength := copy(aPacketData,7,2);
  stRealData := Copy(aPacketData,9,strtoint(stLength));
  //������ ������Ȳ�� ������ �ѷ��� {TO DO}
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000',stECUID,stCMD,cRcvMsgNo,'K1',stRealData);
  end;
  stDeviceCaption := FillzeroNumber(NodeNo,G_nNodeCodeLength) + stEcuID;
  nDeviceIndex := DeviceList.IndexOf(stDeviceCaption);
  if nDeviceIndex < 0 then
  begin
    //��ϵ��� ���� ��� ���� �޽��� ���
    Exit;
  end;
  TDevice(DeviceList.Objects[nDeviceIndex]).ReceiveDataPacket(NodeNo,'0000000',stECUID,stCMD,cRcvMsgNo,'K1',stRealData);
end;

function TNode.PutString(aData: string): Boolean;
begin
  Try
    FTCSDeviceSender.Enter;
    result := False;
    if Not Open then Exit;
    if Not Connected then Exit;

    Try

      if SocketType = RS232 then
      begin
        if ComPort <> nil then
        begin
          if ComPort.Connected then
             ComPort.WriteStr(aData);
        end;
      end else if SocketType = TCPIP then
      begin
{$IFDEF TApdWinsockport}
        ApdWinsockPort.PutString(aData);
{$ELSE}
        TcpClient.Sendln(aData,''); //TcpClient.SendBuf(aData,Length(aData));
{$ENDIF}
      end;
    Except
      Open := False;
      Exit;
    End;
    result := True;
  Finally
    FTCSDeviceSender.Leave;
  End;
end;

function TNode.ReceiveBuff(aDelayTime:integer): Boolean;
var
  DelayTickCount : double;
  stBuff : string;
begin
  if L_bSocketReceiveBuffer then Exit;
  L_bSocketReceiveBuffer := True;
  Try
    DelayTickCount := GetTickCount + aDelayTime;
    if SocketType = RS232 then Exit;
    repeat
{$IFDEF TApdWinsockport}
      result := True;
      Exit;
{$ELSE}
      stBuff := TCPClient.Receiveln(#$03);
{$ENDIF}
      if GetTickCount > DelayTickCount then Break;
      Application.ProcessMessages;
    until stBuff <> '';
  Finally
    L_bSocketReceiveBuffer := False;
  End;
end;

procedure TNode.SendNextDevicePacket;
var
  stSelectDeviceID : string;
  nIndex : integer;
begin
  if G_bApplicationTerminate then Exit;
  if L_bNextDevicePacketSending then Exit;
  Try
    L_bNextDevicePacketSending := True;

    if L_nSearchDeviceIndex > (NodeDeviceList.Count - 1) then L_nSearchDeviceIndex := 0;
    stSelectDeviceID := NodeDeviceList.Strings[L_nSearchDeviceIndex];
    nIndex := DeviceList.IndexOf(FillZeroNumber(NodeNO,G_nNodeCodeLength) + stSelectDeviceID);
    if nIndex > -1 then
    begin
      TDevice(DeviceList.Objects[nIndex]).ExecSendPacket;
    end;
    L_nSearchDeviceIndex := L_nSearchDeviceIndex + 1;

  Finally
    L_bNextDevicePacketSending := False;
  End;
end;

procedure TNode.SetConnected(const Value: Boolean);
var
  stConnected : string;
  stTemp : string;
begin
  //if FConnected = Value then Exit;  //Open �ϴٰ� ���н� ��� Open ���·� ���� ����

  if FConnected <> Value then
  begin
    if Value then  LastReceiveTime := Now;
  end;

  FConnected := Value;
  if Value then
  begin
    //���⿡�� ���Ͽ� ENQ/ACK ��� ���� ����...
    L_bDataSendStarting := True;
    DeviceComnunicationStart;
    stConnected := 'C';
  end else
  begin
    L_bDataSendStarting := False;  //���� ��� ���� ����...
    //if Value <> Open then Open := Value;  //������ ���� ���� ����� ���� Close ����...
    DeviceListDisConnect;
    DeviceListBufferClear;
    stConnected := 'D';
  end;

  if Assigned(FOnConnected) then
  begin
    OnConnected(Self,inttostr(NodeNo),stConnected,'','','','','','','','','','','','','','','','','','');
  end;
end;

procedure TNode.SetDeviceRcvAck(const Value: Boolean);
begin
  if FDeviceRcvAck = Value then Exit;
  FDeviceRcvAck := Value;
  //DelayTimer.Enabled := Not Value;
  if Value then
  begin
    //Ack ��ȣ�� ������ ���� ��Ŷ�� �ٷ� ��������.
    //if Open and connected then SendNextDevicePacket;
  end;
end;

procedure TNode.SetOpen(const Value: Boolean);
var
  i : integer;
  nIndex : integer;
  stTemp : string;
begin
  if FOpen = Value then Exit;
  FOpen := Value;

  if Assigned(FOnRcvData) then
  begin
    if Value then stTemp := 'Connecting'
    else stTemp := 'DisConnecting';
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1',stTemp);
  end;

  FTCSDeviceOpen.Enter;
  Try
    Try
      //���⿡�� Port Open �Ǵ� Close ����...
      if Value then
      begin
        if SocketType = RS232 then
        begin
          if ComPort = nil then ComportCreate;

          if ComPort <> nil then
          begin
            ComPort.Port := 'COM' + inttostr(ComPortNo);
            ComPort.BaudRate := br9600;

            if Not ComPort.Connected then
                   ComPort.Open;
          end;
        end else if SocketType = TCPIP then
        begin
{$IFDEF TApdWinsockport}
          ApdWinsockPort.WsAddress := LanIP;
          ApdWinsockPort.WsPort := inttostr(LanPort);
          ApdWinsockPort.Open := True;
{$ELSE}
          TcpClient.RemoteHost := LanIP;
          TcpClient.RemotePort := inttostr(LanPort);
          TcpClient.BlockMode := bmNonBlocking;
          //TcpClient.BlockMode := bmBlocking;
          TcpClient.Tag := 0;
          Connected := TcpClient.Connect;
          //TcpClient.Active := True;
          if (not Connected) and (TcpClient.Tag = 0) then
          begin
            TcpClient.Select(nil, @Connected, nil, 1000);
            if not Connected then
              TcpClient.Disconnect;
          end;
{$ENDIF}
        end;
        Delay(500);
      end else
      begin
        for i := NodeDeviceList.Count -1 downto 0 do
        begin
          nIndex := DeviceList.IndexOf(FillZeroNumber(NodeNo,G_nNodeCodeLength) + NodeDeviceList.Strings[i]);
          if nIndex > -1 then
          begin
            TDevice(DeviceList.Objects[nIndex]).DeviceConnected := False;
          end;
         end;
         Delay(1000);
         if SocketType = RS232 then
         begin
            Try
              FTCSDeviceSender.Enter;
              if ComPort <> nil then
              begin
                Try
                  if ComPort.Connected then
                  begin
                     ComPort.ClearBuffer(True,True);
                     ComPort.Close;
                     //Delay(1000);
                  end;
                Finally
                  ComportFree;
                End;
              end;
            Finally
              FTCSDeviceSender.Leave;
            End;
         end else if SocketType = TCPIP then
         begin
  {$IFDEF TApdWinsockport}
            ApdWinsockPort.Open := False;
  {$ELSE}
            TcpClient.Close;
            //TcpClient.Disconnect;
  {$ENDIF}
         end;

      end;
      //DelayTimer.Enabled := Value;
    Except
      Exit;
    End;
  Finally
    FTCSDeviceOpen.Leave;
  End;
end;

procedure TNode.SocketReceiveTimerTimer(Sender: TObject);
begin
  SocketReceiveTimer.Enabled := False;
  ReceiveBuff(REPLYDelayTime);
end;

procedure TNode.TcpClientConnect(Sender: TObject);
begin
  // Connected
//  Connected := True;
//  TcpClient.BlockMode := bmNonBlocking;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','Connected');
  end;
end;

procedure TNode.TcpClientDisconnect(Sender: TObject);
begin
  // DisConnected
  Connected := False;
  if Assigned(FOnRcvData) then
  begin
    OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','DisConnected');
  end;
end;

procedure TNode.TcpClientError(Sender: TObject; SocketError: Integer);
begin
  // TCP Connected Error
  //if SocketError = WSAEWOULDBLOCK then Connected := True
  //else Connected := False;
  //Connected := False;
  if SocketError = WSAEWOULDBLOCK then TTcpClient(Sender).Tag := 0
  else begin
    Connected := False;
    TTcpClient(Sender).Tag := SocketError;
    if Assigned(FOnRcvData) then
    begin
      OnRcvData(Self,NodeNo,'0000000','01','e','0','K1','SocketError-' + inttostr(SocketError));
    end;
  end;

end;

procedure TNode.TcpClientReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
begin
  L_stComBuffer := L_stComBuffer + Buf;
  DataReadingProcessing;
end;

procedure TNode.TcpClientSend(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
begin
// TCP Socket Sending
end;


{ TDevice }

procedure TDevice.BufferClear;
begin
  ReceiveDataList.Clear;
  AckSendDataList.clear; //���䵥����
  FirstSendDataList.clear; // ���� ������ ������ ���
  SendDataList.clear; //������ ������ ���
  CardSendDataList.clear; // ī�嵥���� ������ ���
  CardDeleteSendDataList.Clear;
end;

function TDevice.CardAllDelete(aQuick:Boolean = False): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'k';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'c' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length('FFFFFFFF'),2) + //ī�����
            'FFFFFFFF';
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,4)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,4);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

function TDevice.CardDelete(aCardNo: String; aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'j';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'c' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aCardNo),2) + //ī�����
            UpperCase(aCardNo);
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

function TDevice.CardDownload(aCardNo, ValidDay: String; cardType, RegCode,
  aTimeCode, func: Char; aPositionNum: integer;
  aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  case func of
    'L' : begin
      stCmd := 'g';
    end;
    'N' : begin
      stCmd := 'j';
    end;
  end;
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'c' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aCardNo),2) + //ī�����
            UpperCase(aCardNo);
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

function TDevice.CardSearch(aCardNo: String;aQuick:Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'h';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'c' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aCardNo),2) + //ī�����
            UpperCase(aCardNo);
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

constructor TDevice.Create(AOwner: TComponent);
begin
  inherited;
  FTCSSendPacket := TCriticalSection.Create;

  ReceiveDataList := TStringList.Create;
  AckSendDataList := TStringList.Create; //���䵥����
  FirstSendDataList:= TStringList.Create; // ���� ������ ������ ���
  SendDataList:= TStringList.Create; //������ ������ ���
  CardSendDataList:= TStringList.Create; // ī�嵥���� ������ ���
  CardDeleteSendDataList := TStringList.Create;

  SendMsgNo := 0;
  L_nENQNotSendCount := 0;
  ReserveTimer:= TTimer.Create(AOwner);
  ReserveTimer.OnTimer := ReserveTimerTimer;
  ReserveTimer.Interval := 1;
  ReserveTimer.Enabled := True;
end;

destructor TDevice.Destroy;
begin
  ReserveTimer.Enabled := False;
  ReserveTimer.Free;
  ReceiveDataList.Free;
  AckSendDataList.Free;
  FirstSendDataList.Free; // ���� ������ ������ ���
  SendDataList.Free; //������ ������ ���
  CardSendDataList.Free; // ī�嵥���� ������ ���
  CardDeleteSendDataList.Free;
  FTCSSendPacket.Free;

  inherited;
end;

function TDevice.DeviceDoorInfoSetting(aDoor, aCardMode, aDoorMode,
  aDoorControlTime, aOpenMoni, aUseSch, aSendDoor, aAlarmLong, aFire, aLockType,
  aDSOpen, aRemoteDoor, aCmd: string): Boolean;
var
  stData: string;
begin
  stData := '*' + // ��� 0:�̵��,1:���
            FillZeroStrNum(aDoorControlTime,3) ;

  result := SendPacket('d',inttostr(SendMsgNo),stData,G_stDeviceVer,2);
  SendMsgNo := SendMsgNo + 1;
end;

function TDevice.DeviceInitialize: Boolean;
var
  stData : string;
begin
  stData := '*' ; // ��� 0:�̵��,1:���

  result := SendPacket('f',inttostr(SendMsgNo),stData,G_stDeviceVer,2);
  SendMsgNo := SendMsgNo + 1;

end;

function TDevice.ErrorDataProcess(aMcuID, aECUID, aCMD, aRcvMsgNo, aDeviceVer,
  aRealData: string): Boolean;
var
  stSubCmd : string;
begin
  stSubCmd := copy(aRealData,1,4);
  if isDigit(aRcvMsgNo) then L_bDeviceResponse[strtoint(aRcvMsgNo)] := True;
{  L_bDeviceResponse[FIRSTRECV] := True;   //���߿� ��Ȳ���� �����Ҽ� ������ ���� ����.
  L_bDeviceResponse[DATARECV] := True;
  L_bDeviceResponse[CARDRECV] := True;   }
  //if stSubCmd =

end;

procedure TDevice.ExecSendPacket;
var
  stSendData : string;
  DelayTickCount : double;
  nRecvCheckIndex : integer;
  stBuff : string;
  cCmd : char;
  cMsgNo : char;
  stData : string;
  stPacket : string;
  nCheckMsgNo : integer;
  nReplyDelayTime : integer;
begin

    //if Not FNode.Open then Exit;
  if Not FNode.Connected then Exit;

  Try
    FTCSSendPacket.Enter;
    nReplyDelayTime := REPLYDelayTime;

    if L_nReserveIndex = -1 then L_nReserveIndex := 0; //���� �ɸ��� ������ ENQ�� ������

    //if Not DeviceConnected then Exit; //ó�� ���� Ȯ�� �ϱ� ���ؼ��� ENQ�� ���� ���� ��
    case L_nReserveIndex of
      0 : begin  //ENQ
        //ENQ ������ ���� ����...
        nRecvCheckIndex := ENQRECV;
        //stSendData := PacketCreate(G_nProgramType,FillZeroNumber((G_nIDLength + 14), 3),G_stDeviceVer,FillZeroNumber(0,G_nIDLength) + DeviceID,'e','',inttostr(SendMsgNo)); //ENQ ������ ����
        cCmd := 'e';
        cMsgNo := inttostr(SendMsgNo)[1];
        stData := '';
        SendMsgNo := SendMsgNo + 1;
      end;
      FIRSTRECV : begin
        nRecvCheckIndex := FIRSTRECV;
        //L_bDeviceResponse[nRecvCheckIndex] := False;
        stSendData := FirstSendDataList.Strings[0]; //���� �Ϸ� �� ���� ����
        cCmd := stSendData[1];
        cMsgNo := stSendData[2];
        delete(stSendData,1,2);
        stData := stSendData;
      end;
      DATARECV : begin
        nRecvCheckIndex := DATARECV;
        //L_bDeviceResponse[nRecvCheckIndex] := False;
        stSendData := SendDataList.Strings[0]; //���� �Ϸ� �� ���� ����
        cCmd := stSendData[1];
        cMsgNo := stSendData[2];
        delete(stSendData,1,2);
        stData := stSendData;
      end;
      CARDRECV : begin
        nRecvCheckIndex := CARDRECV;
        //L_bDeviceResponse[nRecvCheckIndex] := False;
        stSendData := CardSendDataList.Strings[0]; //���� �Ϸ� �� ���� ����
        cCmd := stSendData[1];
        cMsgNo := stSendData[2];
        delete(stSendData,1,2);
        stData := stSendData;
        nReplyDelayTime := 15000;
      end;
      CARDDELETERECV : begin
        nRecvCheckIndex := CARDDELETERECV;
        stSendData := CardDeleteSendDataList.Strings[0]; //���� �Ϸ� �� ���� ����
        cCmd := stSendData[1];
        cMsgNo := stSendData[2];
        delete(stSendData,1,2);
        stData := stSendData;
        nReplyDelayTime := 15000;
      end;
    end;
    if Assigned(FOnSendData) then
    begin
      OnSendData(Self,NodeNo,'0000000',DeviceID,cCmd,cMsgNo,'K1',stData);
    end;
    stPacket := MSR7000PacketCreate(DeviceID,cCmd,cMsgNo,stData);
    if isDigit(cMsgNo) then nCheckMsgNo := strtoint(cMsgNo)
    else nCheckMsgNo := 0;
    L_bDeviceResponse[nCheckMsgNo] := False;

    if FNode = nil then Exit;

    Try
      //���⿡�� ����� ���Ͽ� ������ �۽�
      FNode.DeviceRcvAck := False;
      if Not FNode.PutString(stPacket) then Exit;
      //FNode.DelayTimer.Enabled := True; //�����ð� �����Ͱ� ������ ENQ�� ������.

      FNode.ReceiveBuff(nReplyDelayTime); //������ ��������
    Except
      Exit;
    End;

    // ���ð� ���� ������ �����ؼ� ó�� ��
    DelayTickCount := GetTickCount + nReplyDelayTime;
    //DelayTickCount := GetTickCount + 600;
    while Not L_bDeviceResponse[nCheckMsgNo] do //������ ���� �� ���� ��� ����... �ִ� 3��
    begin
      if GetTickCount > DelayTickCount then
      begin
        FNode.SocketReceiveTimer.Enabled := True;
        Break;
      end;
      Application.ProcessMessages;
    end;

    if Not L_bDeviceResponse[nCheckMsgNo] then
    begin
      L_nENQErrorCount := L_nENQErrorCount + 1;

      if L_nENQErrorCount > DEVICECONNECTERRORMAXCOUNT then
      begin
        DeviceConnected := False;
        L_nENQErrorCount := 0;
      end;
      Exit;
    end;
    //DataPacket �м� �ؼ� �ش� ���α׷� ó�� ����
    //���⼭ �۽� ���� Clear;
    if nRecvCheckIndex = FIRSTRECV then FirstSendDataList.Delete(0)
    else if nRecvCheckIndex = DATARECV then SendDataList.Delete(0)
    else if nRecvCheckIndex = CARDRECV then CardSendDataList.Delete(0)
    else if nRecvCheckIndex = CARDDELETERECV then CardDeleteSendDataList.Delete(0);

  Finally
    L_nReserveIndex := -1;  //���⼭ ���� Ǯ��
    //FNode.DelayTimer.Enabled := True;
    FTCSSendPacket.Leave;
  End;

end;

function TDevice.MacReg(aMac: string; aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'm';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            aMac;
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;

end;

function TDevice.MasterNoDownload(aPassword, ValidDay: String; cardType,
  RegCode, aTimeCode, func: Char; aPositionNum: integer;
  aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  case func of
    'L' : begin
      stCmd := 'g';
    end;
    'N' : begin
      stCmd := 'j';
    end;
  end;

  stData := '*' + //��� '0' : �̵��,'1' : ���
            'm' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aPassword),2) + //ī�����
            aPassword;
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
end;

function TDevice.MasterNoSearch(aQuick:Boolean = False): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'h';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'm' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length('0000'),2) + //ī�����
            '0000';
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;

end;

function TDevice.ModeChange(aMode: string): Boolean;
var
  stData: String;
begin

  stData := '*' + //��� '0' : �̵��,'1' : ���
            aMode ; //��� 'o':������,'c':����
  result := SendPacket('b',inttostr(SendMsgNo),stData,G_stDeviceVer,1);

  SendMsgNo := SendMsgNo + 1;

end;


function TDevice.PasswordAllDelete(aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'k';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'p' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length('0000'),2) + //ī�����
            '0000';
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,4)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,4);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

function TDevice.PasswordDelete(aPassword: String; aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'j';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'p' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aPassword),2) + //ī�����
            aPassword;
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;
end;

function TDevice.PasswordDownload(aPassword, ValidDay: String; cardType,
  RegCode, aTimeCode, func: Char; aPositionNum: integer;
  aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  case func of
    'L' : begin
      stCmd := 'g';
    end;
    'N' : begin
      stCmd := 'j';
    end;
  end;

  stData := '*' + //��� '0' : �̵��,'1' : ���
            'p' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aPassword),2) + //ī�����
            aPassword;
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;

end;

function TDevice.PasswordSearch(aPassword: String; aQuick: Boolean): Boolean;
var
  stData: String;
  stCmd : string;
begin
  stCmd := 'h';
  stData := '*' + //��� '0' : �̵��,'1' : ���
            'p' + //���� 'c':ī��,'p':��й�ȣ,'m':�����͹�ȣ
            FillZeroNumber(Length(aPassword),2) + //ī�����
            aPassword;
  if aQuick then result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,1)
  else  result := SendPacket(stCmd[1],inttostr(SendMsgNo),stData,G_stDeviceVer,3);

  SendMsgNo := SendMsgNo + 1;
  result := True;

end;

procedure TDevice.ReceiveAccessEventData(aNodeNo, aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
var
  stDoorNo : string;
  stReaderNo : string;
  stInOut : string;
  stTime : string;
  stCardMode : string;
  stChangeState :string;
  stAccessResult : string;
  stDoorState : string;
  stATButton : string;
  stCardMsgNo : string;

  nCardNoLen : integer;
  stCardNo : string;
  stExitButton : string;
  bExitButton : Boolean;
begin

  bExitButton := False;
  stDoorNo:=  '1';
  stReaderNo := '1';
  stInOut := '*';
  stTime  := FormatDateTime('yyyymmddhhnnss',now);
  stCardMode := '*'; //Posi/Nega
  DoorMode:=  aRealData[2]; //�/����
  stChangeState := aRealData[3]; //�������  c:ī��,p:��й�ȣ,m:�����͹�ȣ
  stAccessResult := aRealData[1]; //���Խ��ΰ��  1:����,A:�̽���
  stCardMsgNo := aRealData[4];
  stDoorState:= '*'; //������
  stATButton:= '*'; //���¹�ư

  nCardNoLen := 0;
  if isDigit(Copy(aRealData,5,2)) then
  begin
    nCardNoLen := strtoint(Copy(aRealData,5,2));
    stCardNo:= copy(aRealData,7,nCardNoLen);
  end else
  begin
    stCardNo:= copy(aRealData,7,8);
  end;
  stCardNo := UpperCase(stCardNo);

  if Assigned(FOnCardAccessEvent) then
  begin
    OnCardAccessEvent(Self,aNodeNo,aECUID,stDoorNo,stReaderNo,stInOut,stTime,
                      stCardMode,DoorMode,stChangeState,stAccessResult,
                      stDoorState,stATButton,stCardNo,'','','','','','','');
  end;

end;


procedure TDevice.ReceiveCardDeleteAck(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
var
  stResult : string;
  stDoorNo : string;
  stCardType : string;
  nCardLen : integer;
  stData : string;
begin
  if Length(aRealData) < 5 then Exit;

  stResult := aRealData[1];
  stDoorNo   := '1';
  stCardType := aRealData[2];
  nCardLen := strtoint(copy(aRealData,3,2));
  stData := copy(aRealData,5,nCardLen);
  stData := UpperCase(stData);
  if stCardType = 'c' then
  begin
    if Assigned(FOnCardRegData) then
    begin
      OnCardRegData(Self,inttostr(aNodeNo),aECUID,stResult,stData,stCardType,aCMD,'','','','','','','','','','','','','','');
    end;
  end else if stCardType = 'p'  then
  begin
    if Assigned(FOnPasswordRegData) then
    begin
      OnPasswordRegData(Self,inttostr(aNodeNo),aECUID,stResult,stData,stCardType,aCMD,'','','','','','','','','','','','','','');
    end;
  end;
end;

procedure TDevice.ReceiveCardRegAck(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
var
  stResult : string;
  stDoorNo : string;
  stCardType : string;
  nCardLen : integer;
  stData : string;
begin
  if Length(aRealData) < 5 then Exit;

  stResult := aRealData[1];
  stDoorNo   := '1';
  stCardType := aRealData[2];
  nCardLen := strtoint(copy(aRealData,3,2));
  stData := copy(aRealData,5,nCardLen);
  stData := UpperCase(stData);
  if stCardType = 'c' then
  begin
    if Assigned(FOnCardRegData) then
    begin
      OnCardRegData(Self,inttostr(aNodeNo),aECUID,stResult,stData,stCardType,aCMD,'','','','','','','','','','','','','','');
    end;
  end else if stCardType = 'p'  then
  begin
    if Assigned(FOnPasswordRegData) then
    begin
      OnPasswordRegData(Self,inttostr(aNodeNo),aECUID,stResult,stData,stCardType,aCMD,'','','','','','','','','','','','','','');
    end;
  end else if stCardType = 'm'  then
  begin
    if Assigned(FOnMasterNoRegData) then
    begin
      OnMasterNoRegData(Self,inttostr(aNodeNo),aECUID,stResult,stData,stCardType,aCMD,'','','','','','','','','','','','','','');
    end;
  end;
end;

procedure TDevice.ReceiveDataPacket(aNodeNo:integer;aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData:string);
var
  nCheckMsgno : integer;
begin
//  aRealData := StringReplace(aRealData,#0,'0',[rfReplaceAll]);
  L_nENQErrorCount := 0;
  if isDigit(aRcvMsgNo) then nCheckMsgno := strtoint(aRcvMsgNo)
  else nCheckMsgno := 0;

  L_bDeviceResponse[nCheckMsgno] := True; //������ ENQ ���� �����ʹ� �°����� ó�� ����.
  DeviceConnected := True; //�����Ͱ� �ö���� ������ Connected �Ȱ��̴�.

  if L_stLastPacket = aCMD + aRcvMsgNo+aRealData then
  begin
    L_nLastPacketCount := L_nLastPacketCount + 1;
    if L_nLastPacketCount > LASTPACKETRETRYCOUNT then //3ȸ���� ���� �����Ͱ� �ݺ��ؼ� �ö���� Clear ����... �ݺ��ؼ� �ö���� �����Ϳ� ACK ��ȣ�� �༭ ������ ���� �ϱ� ����
    begin
      L_stLastPacket := '';
      L_nLastPacketCount := 0;
    end; 
    Exit;
  end;
  L_stLastPacket := aCMD + aRcvMsgNo+aRealData;
  //���⿡�� ������ �м��ؼ� �ش� ���� ���� ó�� �� ACK ������ �۽�
  {���� ������ Ŀ�ǵ庰 ó��}
  { ================================================================================
  "e" = ENQ
  "a" = Ack
  "c" = �����̺�Ʈ
  "d" = ���Թ������ð����
  "b" = ��庯��
  "f" = �ʱ�ȭ
  "g" = ī��/��й�ȣ/�����͹�ȣ ���
  "j" = ī��/��й�ȣ/�����͹�ȣ ����
  "h" = ī��/��й�ȣ/�����͹�ȣ ��ȸ
  ================================================================================ }

  case aCmd[1] of
    'e' : begin
      //ENQ�� Ack �� ���� �� ����
      SendAck('a',aRcvMsgNo,'',aDeviceVer);
    end;
    'a' : begin
      //Ack �� ������ �ƹ��͵� ���� ���� ����
      ReceiveDoorAckData(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    'c' : begin
      if L_stAccessLastPacket = aRealData then
      begin
        L_nLastAccessPacketCount := L_nLastAccessPacketCount + 1;
        if L_nLastAccessPacketCount > LASTPACKETRETRYCOUNT then //3ȸ���� ���� �����Ͱ� �ݺ��ؼ� �ö���� Clear ����... �ݺ��ؼ� �ö���� �����Ϳ� ACK ��ȣ�� �༭ ������ ���� �ϱ� ����
        begin
          L_stAccessLastPacket := '';
          L_nLastAccessPacketCount := 0;
        end;
        Exit;
      end;
      L_stAccessLastPacket := aRealData;
      //�����̺�Ʈ
      ReceiveAccessEventData(inttostr(aNodeNo),aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer, aRealData);
      SendAck('a',aRcvMsgNo,'',aDeviceVer);
    end;
    'd' : begin
      //if Not L_bDeviceResponse[FIRSTRECV] then L_bDeviceResponse[FIRSTRECV] := True;
      //if Not L_bDeviceResponse[DATARECV] then  L_bDeviceResponse[DATARECV] := True;
      //if Not L_bDeviceResponse[CARDRECV] then  L_bDeviceResponse[CARDRECV] := True;
      //���Թ������ð� ���
      ReceiveDoorSetupAck(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    'b' : begin
      //if Not L_bDeviceResponse[FIRSTRECV] then L_bDeviceResponse[FIRSTRECV] := True;
      //if Not L_bDeviceResponse[DATARECV] then  L_bDeviceResponse[DATARECV] := True;
      //if Not L_bDeviceResponse[CARDRECV] then  L_bDeviceResponse[CARDRECV] := True;
      //��庯��
      ReceiveDoorModeChange(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    'f' : begin
      //if Not L_bDeviceResponse[FIRSTRECV] then L_bDeviceResponse[FIRSTRECV] := True;
      //if Not L_bDeviceResponse[DATARECV] then  L_bDeviceResponse[DATARECV] := True;
      //if Not L_bDeviceResponse[CARDRECV] then  L_bDeviceResponse[CARDRECV] := True;
      //����ʱ�ȭ
      ReceiveDeviceInitialize(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    'g','h' : begin
      //if Not L_bDeviceResponse[FIRSTRECV] then L_bDeviceResponse[FIRSTRECV] := True;
      //if Not L_bDeviceResponse[DATARECV] then  L_bDeviceResponse[DATARECV] := True;
      //if Not L_bDeviceResponse[CARDRECV] then  L_bDeviceResponse[CARDRECV] := True;
      //ī�� ���
      ReceiveCardRegAck(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    'j','k' : begin
      //if Not L_bDeviceResponse[FIRSTRECV] then L_bDeviceResponse[FIRSTRECV] := True;
      //if Not L_bDeviceResponse[DATARECV] then  L_bDeviceResponse[DATARECV] := True;
      //if Not L_bDeviceResponse[CARDRECV] then  L_bDeviceResponse[CARDRECV] := True;
      //ī�� ���
      ReceiveCardDeleteAck(aNodeNo,aMcuID,aECUID,aCMD,aRcvMsgNo,aDeviceVer,aRealData);
    end;
    else begin
      SendAck('a',aRcvMsgNo,'',aDeviceVer); //��Ÿ ���ɾ Ack ��ȣ�� ���� ����
    end;
  end;
  FNode.DeviceRcvAck := True;
end;

procedure TDevice.ReceiveDeviceInitialize(aNodeNo: integer; aMcuID, aECUID,
  aCMD, aRcvMsgNo, aDeviceVer, aRealData: string);
begin
  if Assigned(FOnDeviceInitialize) then
  begin
    OnDeviceInitialize(Self,inttostr(aNodeNo),aECUID,aCmd,aRealData,'','','','','','','','','','','','','','','','');
  end;
end;

procedure TDevice.ReceiveDoorAckData(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
begin
  if aRealData <> '' then DoorState := aRealData[1];
end;

procedure TDevice.ReceiveDoorModeChange(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
begin
  if aRealData[1] = '1' then  DoorMode := aRealData[2]; //���� ������ �� �Ǿ�����
end;

procedure TDevice.ReceiveDoorSetupAck(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
var
  stDoorNo : string;
  stCardMode : string;
  stDoorMode : string;
  stDoorControlTime : string;
  nDoorControlTime : integer;
  nOrd : integer;
  nMsec : integer;
  stLongDoorOpenTime : string;
  stSchedule : string;
  stDoorState : string;
  stNetFailRun : string;
  stAntiPass : string;
  stLongDoorOpenUse : string;
  stNetFailAlarm : string;
  nLockType : integer;
  stDoorLockType : string;
  stFireDoorControl : string;
  stLockState : string;
  stDoorOpenState : string;
  stRemoteDoorOpen : string;
  stResult : string;
begin
  stDoorNo:=  '1';
  stCardMode := '*';
  stDoorMode := '*';
  stDoorControlTime := copy(aRealData,2,3);

  stLongDoorOpenTime := '*';
  stSchedule := '*';
  stDoorState := '*';
  stNetFailRun := '*';  //������
  stAntiPass := '*';  //������
  stLongDoorOpenUse := '*';
  stNetFailAlarm := '*'; //������
  stDoorLockType := '*';
  stFireDoorControl := '*';
  stLockState := '*';
  stDoorOpenState := '*';
  stRemoteDoorOpen := '*';
  stResult := copy(aRealData,1,1);

  if Assigned(FOnDoorSetupAck) then
  begin
    OnDoorSetupAck(Self,inttostr(aNodeNo),aECUID,aCmd,stDoorNo,stCardMode,stDoorMode,stDoorControlTime,stLongDoorOpenTime,stSchedule,stDoorState,stLongDoorOpenUse,stDoorLockType,stFireDoorControl,stLockState,stDoorOpenState,stRemoteDoorOpen,stResult,'','','');
  end;

end;

{procedure TDevice.ReceivePasswordRegAck(aNodeNo: integer; aMcuID, aECUID, aCMD,
  aRcvMsgNo, aDeviceVer, aRealData: string);
var
  stCmd : string;
  stDoorNo : string;
  stCardType : string;
  nPasswordLen : integer;
  stPassword : string;
begin
  stCmd := aRealData[1];
  stDoorNo   := Copy(aRealData,3,1);
  stCardType := Copy(aRealData,4,2);
  nPasswordLen := 0;
  if isDigit(Copy(aRealData,7,2)) then nPasswordLen := strtoint(Copy(aRealData,7,2));
  stPassword := copy(aRealData,9,nPasswordLen);
  if Assigned(FOnPasswordRegData) then
  begin
    OnPasswordRegData(Self,inttostr(aNodeNo),aECUID,stCmd,stPassword,'','','','','','','','','','','','','','','','');
  end;

end; }

procedure TDevice.ReserveTimerTimer(Sender: TObject);
begin
  if G_bApplicationTerminate then
  begin
    ReserveTimer.Enabled := False;
    Exit;
  end;

  if L_nReserveIndex > -1 then Exit;

  L_nENQNotSendCount := L_nENQNotSendCount + 1;

  if L_nENQNotSendCount > 10 then
  begin
    L_nReserveIndex := 0; //ENQ�� �������� ���Ѱ� 10ȸ �̻��̸� ������ ENQ�� ������
    L_nENQNotSendCount := 0;
    Exit;
  end;
  if DeviceConnected and (FirstSendDataList.Count > 0) then
  begin
    L_nReserveIndex := FIRSTRECV;
    Exit;
  end;
  if DeviceConnected and (SendDataList.Count > 0) then
  begin
    L_nReserveIndex := DATARECV;
    Exit;
  end;
  if DeviceConnected and (CardSendDataList.Count > 0) then
  begin
    L_nReserveIndex := CARDRECV;
    Exit;
  end;
  if DeviceConnected and (CardDeleteSendDataList.Count > 0) then
  begin
    L_nReserveIndex := CARDDELETERECV;
    Exit;
  end;
  L_nReserveIndex := 0; //������ �����Ͱ� ������ ENQ�� ������.
  L_nENQNotSendCount := 0;

end;

function TDevice.SendACK(aCmd, aMsgNo, aData, aVer: string): Boolean;
var
  stSendData : string;
  stLen : string;
begin
  stLen := FillZeroNumber((G_nIDLength + 14) + Length(aData),3);
  if Assigned(FOnSendData) then
  begin
    OnSendData(Self,NodeNo,'0000000',DeviceID,aCmd,aMsgNo,aVer,aData);
  end;
  //stSendData := PacketCreate(G_nProgramType,stLen,aVer,FillZeroNumber(0,G_nIDLength) + DeviceID,aCmd,aData,aMsgNo); //ENQ ������ ����
  stSendData := MSR7000PacketCreate(DeviceID,aCmd,aMsgNo,aData);
  //���⿡�� ����� ���Ͽ� ������ �۽�
  if Not FNode.PutString(stSendData) then Exit;

end;

function TDevice.SendPacket(aCmd,aMsgNo, aData, aVer: string;
  aPriority:integer=2): Boolean;
//var
//  stPacket : string;
begin
  Result := false;
  if Not DeviceConnected then Exit;
  if G_bApplicationTerminate then Exit;

    //stDeviceID := FillZeroNumber(0,G_nIDLength) + DeviceID;

    //nDataLength := (G_nIDLength + 14) + Length(aData);
    //stLen := FillZeroNumber(nDataLength, 3);
    //stPacket := PacketCreate(G_nProgramType,stLen,aVer,stDeviceID,aCmd,aData,aMsgNo);
    //stPacket := MSR7000PacketCreate(DeviceID,aCmd,aMsgNo[1],aData);
    case aPriority of
      1 : begin
            FirstSendDataList.Add(aCmd[1] + aMsgNo[1] + aData);
      end;
      2 : begin
            SendDataList.Add(aCmd[1] + aMsgNo[1] + aData);
      end;
      3 : begin
            CardSendDataList.Add(aCmd[1] + aMsgNo[1] + aData);
      end;
      4 : begin
            CardDeleteSendDataList.Add(aCmd[1] + aMsgNo[1] + aData);
      end;

    end;
  

end;

procedure TDevice.SetDeviceConnected(const Value: Boolean);
var
  stEvent : string;
begin
  if FDeviceConnected = Value then Exit;
  FDeviceConnected := Value;
  if Value then stEvent := 'C'
  else
  begin
    DoorMode := ''; //�˼� ���� ���
    stEvent := 'D';
  end;

  if Assigned(FOnDeviceConnected) then
  begin
    OnDeviceConnected(Self,inttostr(FNode.NodeNo),DeviceID,stEvent,'','','','','','','','','','','','','','','','','');
  end;

end;

procedure TDevice.SetDoorMode(const Value: string);
begin
  if FDoorMode = Value then Exit;
  FDoorMode := Value;
  if Assigned(FOnDoorModeChange) then
  begin
    OnDoorModeChange(Self,inttostr(FNode.NodeNo),DeviceID,'b','1',Value,DoorSTATE,'','','','','','','','','','','','','','');
  end;
end;

procedure TDevice.SetDoorSTATE(const Value: string);
begin
  if FDoorSTATE = Value then Exit;
  FDoorSTATE := Value;
  if Assigned(FOnDoorModeChange) then
  begin
    OnDoorModeChange(Self,inttostr(FNode.NodeNo),DeviceID,'b','1',DoorMode,DoorSTATE,'','','','','','','','','','','','','','');
  end;
end;

procedure TDevice.SetNode(const Value: TNode);
begin
  FNode := Value;
end;

procedure TDevice.SetSendMsgNo(const Value: integer);
begin
  if FSendMsgNo = Value then Exit;

  FSendMsgNo := Value;
  if Value > 9 then SendMsgNo := 0;
end;

end.