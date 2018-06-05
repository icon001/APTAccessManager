unit uDevicePacket;

interface
uses System.SysUtils;
type
  TReceiveData = procedure(Sender: TObject; aNodeNo : integer;aMcuID,aECUID,aCmd,aMsgNo,aDeviceVer,aRealData:string) of object;
  TComEventData = procedure(Sender: TObject; aData1,aData2,aData3,aData4,aData5,aData6,aData7,aData8,aData9,aData10,aData11,aData12,aData13,aData14,aData15,aData16,aData17,aData18,aData19,aData20:string) of object;

procedure ClearBitB(var b:byte; BitToClear: integer);

function CheckDataPacket(aBuffer:string; var aLeavePacketData:string):string;
Function DataConvert1(aMakeValue:Byte;aData:String):String;
Function DataConvert2(aMakeValue:Byte;aData:String):String;
function DecodeCardNo(aCardNo: string;aLength : integer = 8;bHex:Boolean = False): String;
function DoorControlTimeDecode(aDoorControlTime:string):string;
function DoorControlTimeEncode(aDoorControlTime:string):string;
function EncodeCardNo(aCardNo: string;bHex : Boolean = False): String;
function EncodeData(aKey:Byte; aData: String): String;
Function MakeCSData(aData: string;nCSType:integer=0):String;
function MakeSum(st:string;nCSType:integer=0):Char;

//***MSR-7000 �� �������� ����
function MSR7000CheckDataPacket(aBuffer:string; var aLeavePacketData:string):string;
function MSR7000PacketCreate(aDeviceID,aCmd,aMsgNo,aData:string):string;

//***************************************Packet ����
function PacketCreate(aProgramType:integer;aLen,aVer,aDeviceID,aCmd,aData,aMsgNo:string):string;

implementation
uses
  uFunction,
  uCommonVariable;

procedure ClearBitB(var b:byte; BitToClear: integer);
{ clear a bit in a byte }
begin
  if (BitToClear < 0) or (BitToClear > 7) then exit;
  b := b and not (1 shl BitToClear);
end;

function CheckDataPacket(aBuffer:string; var aLeavePacketData:string):string;
var
  nIndex: Integer;
  stLen: String;
  nDefinedLength: Integer;
  stPacketData: String;
  nEtxIndex: Integer;
  aKey: Byte;
begin

  Result:= '';
  stLen:= Copy(aBuffer,2,3);
  //������ ���� ��ġ �����Ͱ� ���ڰ� �ƴϸ�...
  if not isDigit(stLen) then
  begin
    Delete(aBuffer,1,1);       //1'st STX ����
    nIndex:= Pos(STX,aBuffer); // ���� STX ã��
    if nIndex = 0 then       //STX�� ������...
    begin
      //��ü ������ ����
      aLeavePacketData:= '';
    end else if nIndex > 1 then // STX�� 1'st�� �ƴϸ�
    begin
      Delete(aBuffer,1,nIndex-1);//STX �� ������ ����
      aLeavePacketData:= aBuffer;
    end else
    begin
      aLeavePacketData:= aBuffer;
    end;
    Exit;
  end;

  //��Ŷ�� ���ǵ� ����
  nDefinedLength:= StrtoInt(stLen);
  //��Ŷ�� ���ǵ� ���̺��� ���� �����Ͱ� ������
  if Length(aBuffer) < nDefinedLength then
  begin
    //���� �����Ͱ� ���̰� ������(���� �� ������ ����)
    nEtxIndex:= POS(ETX,aBuffer);
    if nEtxIndex > 0 then
    begin
     Delete(aBuffer,1,nEtxIndex);
    end;
    aLeavePacketData:= aBuffer;
    Exit;
  end;

  // ���ǵ� ���� ������ �����Ͱ� ETX�� �´°�?
  if aBuffer[nDefinedLength] = ETX then
  begin
    stPacketData:= Copy(aBuffer,1,nDefinedLength);
    aKey:= Ord(stPacketData[5]);
    stPacketData:= Copy(stPacketData,1,5) + EncodeData(aKey,Copy(stPacketData,6,Length(stPacketData)-6))+stPacketData[Length(stPacketData)];

    Result:=stPacketData;
    Delete(aBuffer, 1, nDefinedLength);
    aLeavePacketData:= aBuffer;
  end else
  begin
    //������ �����Ͱ� ETX �ƴϸ� 1'st STX����� ���� STX�� ã�´�.
    Delete(aBuffer,1,1);
    nIndex:= Pos(STX,aBuffer); // ���� STX ã��
    if nIndex = 0 then       //STX�� ������...
    begin
      //��ü ������ ����
      aLeavePacketData:= '';
    end else if nIndex > 1 then // STX�� 1'st�� �ƴϸ�
    begin
      Delete(aBuffer,1,nIndex-1);//STX �� ������ ����
      aLeavePacketData:= aBuffer;
    end else
    begin
      aLeavePacketData:= aBuffer;
    end;
  end;
end;

{���� ��ȣ��(BIT4,BIT3,BIT2,BIT1,BIT0) �� data�� XOR �Ѵ�.}
Function DataConvert1(aMakeValue:Byte;aData:String):String;
var
  I: Integer;
  bData: String;
begin
  bData:= aData;
  for I:= 1 to Length(bData) do
  begin
    bData[I]:= Char(ord(bData[I]) XOR aMakeValue);
  end;
  Result:= bData;
end;

{ ���� ��ȣ��(BIT4,BIT3,BIT2,BIT1,BIT0) �� data�� XOR �� Message No�� ���� Nibble�� �ٽ� XOR �Ѵ�.}
Function DataConvert2(aMakeValue:Byte;aData:String):String;
var
  I: Integer;
  bMakeValue: Byte;
  bData: String;
  TempByte: Byte;
begin
  bData:= aData;
  {13���� Byte �� MessageNo}
  bMakeValue:= Ord(aData[13]) and $F;
  Result:= '';
  for I:= 1 to Length(bData) do
  begin
    if I <> 13 then
    begin
      TempByte:= ord(bData[I]) XOR aMakeValue;
      bData[I]:= Char(TempByte XOR bMakeValue);
    end;
  end;
  Result:= bData;
end;

function DecodeCardNo(aCardNo: string;aLength : integer = 8;bHex:Boolean = False): String;
var
  I: Integer;
  st: string;
  bCardNo: int64;
begin

  for I := 1 to aLength do
  begin

    if (I mod 2) <> 0 then
    begin
      aCardNo[I] := Char((Ord(aCardNo[I]) shl 4));
    end else
    begin
      aCardNo[I] := Char(Ord(aCardNo[I]) - $30); //�����Ϻ��� 0���� �����.
      //st:= st + char(ord(aCardNo[I-1]) +ord(aCardNo[I]));
      st:= st + char(ord(aCardNo[I-1]) + ord(aCardNo[I]))
    end;
    //aCardNo[I] := Char(Ord(aCardNo[I]) - $30);
    //st := st + aCardNo[I];
  end;


  st:= tohexstrNospace(st);


  if Not bHex then  //���� ��ȯ�̸�
  begin
    bCardNo:= Hex2Dec(st);
    st:= FillZeroNumber(bCardNo,10);
  end;
  //SHowMessage(st);
  Result:= st;

end;

function DoorControlTimeDecode(aDoorControlTime:string):string;
var
  stDoorControlTime : string;
  nDoorControlTime : integer;
  nOrd : integer;
  nMsec : integer;
begin
  if aDoorControlTime[1] >= #$30 then
  begin
   if aDoorControlTime[1] < #$40 then  stDoorControlTime := aDoorControlTime[1]
   else
   begin
      if (aDoorControlTime[1] >= 'A') and (aDoorControlTime[1] <= 'Z') then  nDoorControlTime := Ord(aDoorControlTime[1]) - Ord('A')
      else nDoorControlTime := Ord(aDoorControlTime[1]) - Ord('a') + 26;
      nDoorControlTime := nDoorControlTime * 5;
      stDoorControlTime := inttostr( 10 + nDoorControlTime );
   end;
  end else
  begin
    nOrd := Ord(aDoorControlTime[1]);
    nMsec := (nOrd - $20) * 100;
    stDoorControlTime := inttostr(nMsec) + 'ms';
  end;
end;

function DoorControlTimeEncode(aDoorControlTime:string):string;
var
  nOrdUDiff : integer;
  nDoorTime : integer;
  nOrd : integer;
  stMSEC : string;
  nMSec : integer;
begin
  Try
    if IsDigit(aDoorControlTime) then
    begin
      if strtoint(aDoorControlTime) < 10 then
      begin
         aDoorControlTime := Trim(aDoorControlTime);
      end else
      begin
        nOrdUDiff := 26;
        nDoorTime := strtoint(aDoorControlTime) - 10;
        nDoorTime := nDoorTime div 5;
        if nDoorTime < nOrdUDiff then  nOrd := Ord('A') + nDoorTime
        else nOrd := Ord('a') + nDoorTime - nOrdUDiff;
        if nOrd > Ord('z') then nOrd := Ord('z');
        aDoorControlTime := Char(nOrd);
      end;
    end else
    begin
      stMSEC := copy(aDoorControlTime,1,3);
      if Not isDigit(stMSEC) then
      begin
        result := '5';
        Exit;
      end;
      nMSec := strtoint(stMsec) div 100;
      if nMSec < 1 then
      begin
        result := '5';
        Exit;
      end;
      if nMSec > 9 then
      begin
        result := '5';
        Exit;
      end;
      nOrd := $20 + nMSec; //21~29 ���� MSEC;
      aDoorControlTime := Char(nOrd);
    end;
    result := aDoorControlTime;
  Except
    Exit;
  End;
end;

function EncodeCardNo(aCardNo: string;bHex : Boolean = False): String;
var
  I: Integer;
  xCardNo: String;
  st: String;
begin
  result := '';
  Try
    if Not bHex then aCardNo:= Dec2Hex(StrtoInt64(aCardNo),8);
    xCardNo:= Hex2Ascii(aCardNo);
    for I:= 1 to 4 do
    begin
      st := st + Char((Ord(xCardNo[I]) shr 4) + $30) + Char((Ord(xCardNo[I]) and $F) + $30);
    end;
    Result:= st;
  Except
    Exit;
  End;
end;

function EncodeData(aKey:Byte; aData: String): String;
var
  Encodetype: Integer;
  aMakeValue: Byte;
  I: Integer;
begin
  EncodeType:= aKey SHR 6; //7,6 �� Bit�� ���ڵ� Ÿ��
  aMakeValue:= aKey;
  for I:= 5 to 7 do ClearBitB(aMakeValue,I); //1,2,3,4,5 Bit�� ������ȣ

  case EncodeType of
    0: Result:= DataConvert1(aMakeValue,aData);
    1: Result:= DataConvert2(aMakeValue,aData);
    else Result:= aData;
  end;
end;

{CheckSum�� �����}
Function MakeCSData(aData: string;nCSType:integer=0):String;
var
  aSum: Integer;
  st: string;
begin
  aSum:= Ord(MakeSum(aData,nCSType));
  aSum:= aSum*(-1);
  st:= Dec2Hex(aSum,2);

  Result:= copy(st,Length(st)-1,2);
end;

function MakeSum(st:string;nCSType:integer=0):Char;
var
  i: Integer;
  aBcc: Byte;
  BCC: string;
  cTemp : char;
begin
  aBcc := Ord(st[1]);
  for i := 2 to Length(st) do
  begin
    cTemp := st[i];
    aBcc := aBcc + Ord(cTemp);
  end;
  if nCSType = 1 then
  begin
    aBcc := aBcc + Ord(#$A7);
  end;
  BCC := Chr(aBcc);
  Result := BCC[1];
end;

function MSR7000CheckDataPacket(aBuffer:string; var aLeavePacketData:string):string;
var
  nIndex: Integer;
  stLen: String;
  nDefinedLength: Integer;
  stPacketData: String;
  nEtxIndex: Integer;
  aKey: Byte;
begin

  Result:= '';
  if Length(aBuffer) < 9 then   //Length üũ �� �����Ͱ� ������ �׳� ���� ������
  begin
    aLeavePacketData:= aBuffer;
    Exit;
  end;

  stLen:= Copy(aBuffer,7,2);
  //������ ���� ��ġ �����Ͱ� ���ڰ� �ƴϸ�...
  if not isDigit(stLen) then
  begin
    Delete(aBuffer,1,1);       //1'st STX ����
    nIndex:= Pos(STX,aBuffer); // ���� STX ã��
    if nIndex = 0 then       //STX�� ������...
    begin
      //��ü ������ ����
      aLeavePacketData:= '';
    end else if nIndex > 1 then // STX�� 1'st�� �ƴϸ�
    begin
      Delete(aBuffer,1,nIndex-1);//STX �� ������ ����
      aLeavePacketData:= aBuffer;
    end else
    begin
      aLeavePacketData:= aBuffer;
    end;
    Exit;
  end;

  //��Ŷ�� ���ǵ� ����
  nDefinedLength:= StrtoInt(stLen) + 11; //Packet Encrept Size 11��
  //��Ŷ�� ���ǵ� ���̺��� ���� �����Ͱ� ������
  if Length(aBuffer) < nDefinedLength then
  begin
    //���� �����Ͱ� ���̰� ������(���� �� ������ ����)
    nEtxIndex:= POS(ETX,aBuffer);
    if nEtxIndex > 0 then
    begin
     Delete(aBuffer,1,nEtxIndex);
    end;
    aLeavePacketData:= aBuffer;
    Exit;
  end;

  // ���ǵ� ���� ������ �����Ͱ� ETX�� �´°�?
  if aBuffer[nDefinedLength] = ETX then
  begin
    stPacketData:= Copy(aBuffer,1,nDefinedLength);
    Result:=stPacketData;
    Delete(aBuffer, 1, nDefinedLength);
    aLeavePacketData:= aBuffer;
  end else
  begin
    //������ �����Ͱ� ETX �ƴϸ� 1'st STX����� ���� STX�� ã�´�.
    Delete(aBuffer,1,1);
    nIndex:= Pos(STX,aBuffer); // ���� STX ã��
    if nIndex = 0 then       //STX�� ������...
    begin
      //��ü ������ ����
      aLeavePacketData:= '';
    end else if nIndex > 1 then // STX�� 1'st�� �ƴϸ�
    begin
      Delete(aBuffer,1,nIndex-1);//STX �� ������ ����
      aLeavePacketData:= aBuffer;
    end else
    begin
      aLeavePacketData:= aBuffer;
    end;
  end;
end;

function MSR7000PacketCreate(aDeviceID,aCmd,aMsgNo,aData:string):string;
var
  stPacket : string;
  stCheckSum : string;
  nSum : integer;
begin
  stPacket := STX + FillZeroStrNum(aDeviceID,2) + '0' + aCmd + aMsgNo + FillZeroNumber(Length(aData),2) + aData;
  nSum := Ord(MakeSum(stPacket,0));
  stCheckSum := Dec2Hex(nSum,2);
  stCheckSum := copy(stCheckSum,Length(stCheckSum)-1,2);
  stPacket := stPacket + stCheckSum + ETX;
  result := stPacket;
end;

function PacketCreate(aProgramType:integer;aLen,aVer,aDeviceID,aCmd,aData,aMsgNo:string):string;
var
  stPacket : string;
  nKey : integer;
begin
  stPacket := STX + aLen + #$20 + aVer + aDeviceID + aCmd + aMsgNo + aData;
  stPacket  := stPacket + MakeCSData(stPacket + ETX,aProgramType) + ETX;
  nKey    := $20;
  result := Copy(stPacket, 1, 5) + EncodeData(nKey,
    Copy(stPacket, 6, Length(stPacket) - 6)) + ETX;
end;

end.