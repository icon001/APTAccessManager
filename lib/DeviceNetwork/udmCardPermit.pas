unit udmCardPermit;

interface

uses
  System.SysUtils, System.Classes,Vcl.ExtCtrls,Data.Win.ADODB,Winapi.ActiveX;

type
  TdmCardPermit = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    PermitTimer : TTimer;
    FTimerStart: Boolean;
    procedure SetTimerStart(const Value: Boolean);
    { Private declarations }
    procedure PermitApplyTimerTimer(Sender: TObject);
  private
    Function CardToDevicePermitApply:Boolean;
    Function DeviceToCardPermitApply:Boolean;
    Function DupCheckTB_DEVICECARDNO(aCardNo, aNodeNo, aDeviceID:string):Boolean;
    Function DupCheckTB_DEVICEPASSWORD(aPassword, aNodeNo, aDeviceID:string):Boolean;

    Function EachCardToDevicePermit(aCardNo,aDongCode,aAreaCode:string):Boolean;
    Function EachDeviceToCardPermit(aNodeNo,aDeviceID,aDoorNo,aDongCode,aAreaCode:string):Boolean;

  public
    Function CardPermitRegist(aCardNo,aNodeNo,aDeviceID,aDoorNo:string;aPermit:string):Boolean;
    Function PasswordPermitRegist(aPassword,aNodeNo,aDeviceID,aDoorNo:string;aPermit:string):Boolean;
    { Public declarations }
    property TimerStart : Boolean read FTimerStart write SetTimerStart;
  end;

var
  dmCardPermit: TdmCardPermit;

implementation
uses
  uDataBase,
  uDBFunction,
  uCommonVariable,
  uFunction;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


function TdmCardPermit.CardPermitRegist(aCardNo, aNodeNo, aDeviceID,
  aDoorNo: string;aPermit:string): Boolean;
begin
  if DupCheckTB_DEVICECARDNO(aCardNo, aNodeNo, aDeviceID) then
  begin
    result := dmDBFunction.UpdateTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo, aDeviceID,aDoorNo,aPermit);
  end else
  begin
    result := dmDBFunction.InsertTB_DEVICECARDNO_AccessPermit(aCardNo, aNodeNo, aDeviceID,aDoorNo,aPermit);
  end;

end;

function TdmCardPermit.CardToDevicePermitApply: Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    stSql := ' Select * from TB_CARD ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND CA_ACCPERMIT = ''Y'' ';
    stSql := stSql + ' AND ( CA_ASYNC = ''N'' or CA_ASYNC is null) ';

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit;

      while Not Eof do
      begin
        if G_bApplicationTerminate then Exit;

        if EachCardToDevicePermit(FindField('CA_CARDNO').AsString,
                                          FindField('BC_PARENTCODE').AsString,
                                          FindField('BC_CHILDCODE').AsString) then
        begin
          dmDBFunction.UpdateTB_CARDCardAsync(FindField('CA_CARDNO').AsString,'Y');
        end;
        Next;
      end;

    end;

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmCardPermit.DataModuleCreate(Sender: TObject);
begin
  PermitTimer := TTimer.Create(nil);
  PermitTimer.Interval := 1000;
  PermitTimer.Enabled := False;
  PermitTimer.OnTimer := PermitApplyTimerTimer;
end;

procedure TdmCardPermit.DataModuleDestroy(Sender: TObject);
begin
  PermitTimer.Enabled := False;
  PermitTimer.Free;
end;

function TdmCardPermit.DeviceToCardPermitApply: Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    stSql := ' Select * from TB_DOOR ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND ( DO_CARDASYNC = ''N'' or DO_CARDASYNC is null) ';

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit;

      while Not Eof do
      begin
        if G_bApplicationTerminate then Exit;

        if EachDeviceToCardPermit(FindField('ND_NODENO').AsString,
                                          FindField('DE_DEVICEID').AsString,
                                          FindField('DO_DOORNO').AsString,
                                          FindField('BC_PARENTCODE').AsString,
                                          FindField('BC_CHILDCODE').AsString) then
        begin
          dmDBFunction.UpdateTB_DOORCardAsync(FindField('ND_NODENO').AsString,
                                   FindField('DE_DEVICEID').AsString,
                                   FindField('DO_DOORNO').AsString,
                                   'Y');
        end;
        Next;
      end;

    end;

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmCardPermit.DupCheckTB_DEVICECARDNO(aCardNo, aNodeNo,
  aDeviceID: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := False;
  stSql := ' Select * from TB_DEVICECARDNO ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit;
      result := True;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmCardPermit.DupCheckTB_DEVICEPASSWORD(aPassword, aNodeNo,
  aDeviceID: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := False;
  stSql := ' Select * from TB_DEVICEPASSWD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND DE_DEVICEID = ''' + aDeviceID + ''' ';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordCount < 1 then Exit;
      result := True;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmCardPermit.EachCardToDevicePermit(aCardNo, aDongCode,
  aAreaCode: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := False;
  stSql := ' Select * from TB_DOOR ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND BC_PARENTCODE = ''' + aDongCode + ''' ';
  stSql := stSql + ' AND BC_CHILDCODE = ''' + aAreaCode + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      result := True;
      if recordCount < 1 then Exit;

      while Not Eof do
      begin
        CardPermitRegist(aCardNo,FindField('ND_NODENO').AsString,FindField('DE_DEVICEID').AsString,FindField('DO_DOORNO').AsString,'L');
        Next;
      end;

    end;

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TdmCardPermit.EachDeviceToCardPermit(aNodeNo, aDeviceID, aDoorNo,
  aDongCode, aAreaCode: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := False;
  stSql := ' Select * from TB_CARD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stsql + ' AND CA_ACCPERMIT = ''Y'' ';
  stSql := stSql + ' AND BC_PARENTCODE = ''' + aDongCode + ''' ';
  stSql := stSql + ' AND BC_CHILDCODE = ''' + aAreaCode + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      result := True;
      if recordCount < 1 then Exit;

      while Not Eof do
      begin
        CardPermitRegist(FindField('CA_CARDNO').AsString,aNodeNo,aDeviceID,aDoorNo,'L');
        Next;
      end;

    end;

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;


function TdmCardPermit.PasswordPermitRegist(aPassword, aNodeNo, aDeviceID,
  aDoorNo, aPermit: string): Boolean;
begin
  if DupCheckTB_DEVICEPASSWORD(aPassword, aNodeNo, aDeviceID) then
  begin
    result := dmDBFunction.UpdateTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo, aDeviceID,aDoorNo,aPermit);
  end else
  begin
    result := dmDBFunction.InsertTB_DEVICEPASSWD_AccessPermit(aPassword, aNodeNo, aDeviceID,aDoorNo,aPermit);
  end;

end;

procedure TdmCardPermit.PermitApplyTimerTimer(Sender: TObject);
begin
  Try
    PermitTimer.Enabled := False;
    DeviceToCardPermitApply;
    CardToDevicePermitApply;
  Finally
    PermitTimer.Enabled := TimerStart; // 폼 종료 전까지는 계속 반복
  End;

end;

procedure TdmCardPermit.SetTimerStart(const Value: Boolean);
begin
  FTimerStart := Value;
  PermitTimer.Enabled := Value;
end;


end.
