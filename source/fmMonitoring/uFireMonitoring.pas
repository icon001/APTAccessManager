﻿unit uFireMonitoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, W7Classes, W7Panels, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvSmoothPanel, Vcl.ExtCtrls, AdvSmoothLabel,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvToolBtn,ADODB,ActiveX, uSubForm, CommandArray, AdvCombo, AdvAppStyler,
  AdvToolBar, AdvToolBarStylers, Vcl.Menus, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, AdvSplitter, AdvPanel, AdvGroupBox,
  Vcl.Mask, AdvSpin, AdvOfficeButtons, AdvListV,
  AdvMenus, AdvExplorerTreeview, paramtreeview,
  Vcl.Clipbrd, System.IniFiles;

const
  con_DOORLOCKCLOSE = 3;
  con_DOORLOCKOPEN = 4;
  con_DOORFREECLOSE = 5;
  con_DOORFREEOPEN = 6;
  con_DOORNOTSTATE = 7;

type
  TfmFireMonitoring = class(TfmASubForm)
    Image1: TImage;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    pan_DoorList: TAdvPanel;
    ImageList1: TImageList;
    pan_DoorState: TAdvSmoothPanel;
    TreeView_DoorList: TTreeView;
    toolslist: TImageList;
    TreeView_LocationCode: TTreeView;
    SearchTimer: TTimer;
    PopupMenu: TPopupMenu;
    mn_DoorClose: TMenuItem;
    mn_DoorOpenMode: TMenuItem;
    N11: TMenuItem;
    mn_DeviceChange: TMenuItem;
    N13: TMenuItem;
    mn_AllCardDelete: TMenuItem;
    mn_PasswordAllDelete: TMenuItem;
    N16: TMenuItem;
    mn_DeviceInitialize: TMenuItem;
    StateAsyncTimer1: TTimer;
    N1: TMenuItem;
    mn_NodeIP: TMenuItem;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    pan_AlarmListHeader: TAdvSmoothPanel;
    sg_alarmEvent: TAdvStringGrid;
    AdvSplitter3: TAdvSplitter;
    pan_Image: TAdvPanel;
    img_TotImage: TImage;
    AdvSplitter1: TAdvSplitter;
    lb_hint: TLabel;
    MessageTimer1: TTimer;
    RzOpenDialog1: TOpenDialog;
    ed_MapFile: TEdit;
    AlarmTimer1: TTimer;
    procedure menuTabChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ed_AddNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure AdvSmoothPanel8Resize(Sender: TObject);
    procedure sg_PasswordListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure sg_doorListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure sg_doorPasswordListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure pan_DoorStateResize(Sender: TObject);
    procedure sg_AccessEventResize(Sender: TObject);
    procedure TreeView_DoorListClick(Sender: TObject);
    procedure mn_DoorCloseClick(Sender: TObject);
    procedure mn_DoorOpenModeClick(Sender: TObject);
    procedure mn_DeviceChangeClick(Sender: TObject);
    procedure StateAsyncTimer1Timer(Sender: TObject);
    procedure mn_AllCardDeleteClick(Sender: TObject);
    procedure mn_PasswordAllDeleteClick(Sender: TObject);
    procedure mn_DeviceInitializeClick(Sender: TObject);
    procedure pan_AlarmListHeaderResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure pan_ImageResize(Sender: TObject);
    procedure MessageTimer1Timer(Sender: TObject);
    procedure img_TotImageDblClick(Sender: TObject);
    procedure AlarmTimer1Timer(Sender: TObject);
  private
    L_bClear : Boolean;
    L_bAlarmClear : Boolean;
    L_bDblClick : Boolean;
    L_bMapUpdate : Boolean;
    L_bFireAlarm : Boolean;
    L_bFireAlarmDelete : Boolean;
    L_bFormClose : Boolean;
    L_stSelectBuildingCode : string;
    ListDoorCodeList : TStringList;
    ListDongCodeList : TStringList;
    ListAreaCodeList : TStringList;
    SearchPasswordCodeList : TStringList;
    SearchDoorCodeList : TStringList;
    DisplayList : TStringList;
    BuildingImageList : TStringList;
    FireEventList : TStringList;

    L_nPasswordListMaxCount : integer;
    L_nPasswordCheckCount : integer;        //체크 된 비밀번호 카운트
    L_nAddDoorCheckCount : integer;  //등록 출입문 선택 카운트
    L_nDeletePasswordCheckCount : integer;  //등록 출입문 선택 카운트

    procedure LoadChildCode(aParentCode:string;aPosition:integer;cmbBox:TComboBox;aList:TStringList;aAll:Boolean);
    procedure LoadListView;
    Function LoadingFire:Boolean;

    { Private declarations }
  private
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);
    procedure DoorStateChange(aNodeNo,aECUID,aDoorNo:string;aDoorState:integer);
    procedure BuildingImageDblClick(Sender: TObject;aBuildingCode,aBuildingName:string);
    procedure BuildingImageMouseEnter(Sender: TObject;aBuildingCode,aBuildingName:string);
    procedure BuildingImageMouseLeave(Sender: TObject;aBuildingCode,aBuildingName:string);
  private
    function GetAccessResultName(aAccessResultCode:string):string;
    function GetAlarmCodeInfo(aAlarmCode:string; var aAlarmName,aAlarmEvent,aAlarmSound,aAlarmMessage,aColor:string):Boolean;
    function GetstChangeStateName(aChangeStateCode:string):string;
    function GetLocationName(aNodeNo,aECUID,aDoorNo:string;var aDongName,aAreaName,aDoorName:string):Boolean;
    function GetEmployeeInfo(aCardNo:string; var aCompanyName,aDepartName,aEmCode,aUserName:string):Boolean;
    function GetNodeIP(aNodeNo:string):string;
    function GetPasswordCount:integer;
    function GetUserNameFromCardNO(aCardNo:string):string;
  public
    { Public declarations }
    procedure FormNameSetting;
    procedure FontSetting;
    procedure Form_Close;
    procedure DeviceReload;

    procedure RcvAlarmEvent(aNodeNo, aECUID, aDoorNo,aReaderNo, aInOut, aTime, aCardMode, aDoorMode, aAlarmCode:string);
    procedure ReceiveDeviceInitialize(aNodeNo, aECUID, aResult:string);
    procedure RcvDoorModeChange(aNodeNo, aECUID, aResult,aMode,aDoorState:string);

  end;

var
  fmFireMonitoring: TfmFireMonitoring;

implementation
uses
  uCommonVariable,
  uDataBase,
  uDBFunction,
  uDBFormName,
  uFormUtil,
  uFunction,
  udmCardPermit,
  uControler,
  uFormFontUtil,
  uMapBuilding,
  uFireMap;

{$R *.dfm}


procedure TfmFireMonitoring.pan_AlarmListHeaderResize(Sender: TObject);
begin
  inherited;
  sg_alarmEvent.Height := pan_AlarmListHeader.Height - 20;
  sg_alarmEvent.ColWidths[3] := sg_alarmEvent.Width - (sg_alarmEvent.ColWidths[0] + sg_alarmEvent.ColWidths[1] + sg_alarmEvent.ColWidths[2]);
end;

procedure TfmFireMonitoring.pan_DoorStateResize(Sender: TObject);
begin
  inherited;
  TreeView_DoorList.Height := pan_DoorState.Height - 60;
  TreeView_DoorList.Width := pan_DoorState.Width - 20;
end;

procedure TfmFireMonitoring.pan_ImageResize(Sender: TObject);
var
  i : integer;
  nCurXPosition,nCurYPosition : integer;
begin
  inherited;
  if BuildingImageList = nil then Exit;
  if BuildingImageList.Count = 0 then  Exit;

  for i := 0 to BuildingImageList.Count - 1 do
  begin
    TMapFire(BuildingImageList.Objects[i]).ParentImageHeight := pan_Image.Height;
    TMapFire(BuildingImageList.Objects[i]).ParentImageWidth := pan_Image.Width;
    nCurXPosition := 0;
    nCurYPosition := 0;
    if (TMapFire(BuildingImageList.Objects[i]).CurX * img_TotImage.Width) > 0 then
       nCurXPosition := (TMapFire(BuildingImageList.Objects[i]).CurX * img_TotImage.Width) div TMapFire(BuildingImageList.Objects[i]).TotW;
    if (TMapFire(BuildingImageList.Objects[i]).CurY * img_TotImage.Height) > 0 then
      nCurYPosition := (TMapFire(BuildingImageList.Objects[i]).CurY * img_TotImage.Height) div TMapFire(BuildingImageList.Objects[i]).TotH;
    TMapFire(BuildingImageList.Objects[i]).Left := nCurXPosition;
    TMapFire(BuildingImageList.Objects[i]).top := nCurYPosition;
  end;

  lb_hint.Left := pan_Image.Width div 2 - lb_hint.Width div 2;

end;

procedure TfmFireMonitoring.AdvSmoothPanel8Resize(Sender: TObject);
var
  nWidth : integer;
begin
  inherited;
end;

procedure TfmFireMonitoring.sg_AccessEventResize(Sender: TObject);
begin
  inherited;
//  sg_AccessEvent.DefaultColWidth := (sg_AccessEvent.Width - 180) div (sg_AccessEvent.ColCount - 1);
//  sg_AccessEvent.ColWidths[0] := 160;
end;

procedure TfmFireMonitoring.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;


procedure TfmFireMonitoring.AlarmTimer1Timer(Sender: TObject);
var
  i : integer;
  nIndex : integer;
begin
  inherited;
  if FireEventList = nil then Exit;
  if FireEventList.Count = 0 then Exit;
  AlarmTimer1.Enabled := False;
  while L_bFireAlarmDelete do
  begin
    sleep(1);
    Application.ProcessMessages;
  end;
  Try
    L_bFireAlarm := True;
    for i := 0 to FireEventList.Count - 1 do
    begin
      nIndex := BuildingImageList.IndexOf(FireEventList.Strings[i]);
      if nIndex > -1 then TMapFire(BuildingImageList.Objects[nIndex]).MapVisible := Not TMapFire(BuildingImageList.Objects[nIndex]).MapVisible;
    end;
  Finally
    L_bFireAlarm := False;
  End;
  AlarmTimer1.Enabled := Not L_bFormClose;
end;

procedure TfmFireMonitoring.BuildingImageDblClick(Sender: TObject;
  aBuildingCode, aBuildingName: string);
begin
  showmessage('doubleclick');
  if L_bDblClick then Exit;
  Try
    L_bDblClick := True;
  Finally
    L_bDblClick := False;
  End;
end;

procedure TfmFireMonitoring.BuildingImageMouseEnter(Sender: TObject;
  aBuildingCode, aBuildingName: string);
begin
  L_stSelectBuildingCode := aBuildingCode;
end;

procedure TfmFireMonitoring.BuildingImageMouseLeave(Sender: TObject;
  aBuildingCode, aBuildingName: string);
begin
//  L_stSelectBuildingCode := '';
end;

procedure TfmFireMonitoring.Button1Click(Sender: TObject);
var
  FireMap : TMapFire;
  testImage : TImage;
begin
  inherited;

  testImage := TImage.Create(nil);
  testImage.Parent := Pan_Image;
  testImage.Left := 10;
  testImage.Top := 10;
  testImage.Width := 25;
  testImage.Height := 25;
  testImage.Visible := True;
  testImage.Stretch := True;
  testImage.Picture.LoadFromFile(G_stExeFolder + '\fire.png');

end;

procedure TfmFireMonitoring.DeviceReload;
begin
  LoadListView;
  LoadingFire;
end;

procedure TfmFireMonitoring.DoorStateChange(aNodeNo, aECUID, aDoorNo: string;
  aDoorState: integer);
var
  obTreeView   : TTreeview;
  obCodeTreeView : TTreeview;
  obNode1   : TTreeNode;
  obCodeNode1: TTreeNode;
  stCode : string;
begin
  obTreeView := TreeView_DoorList;
  obCodeTreeView := TreeView_LocationCode;   //위치 코드 등록으로 현재 상태를 파악하기 위함
  stCode := 'D' + FillZeroNumber(strtoint(aNodeNo),G_nNodeCodeLength) + FillZeroNumber(strtoint(aECUID),G_nDeviceCodeLength) + FillZeroNumber(strtoint(aDoorNo),G_nDoorCodeLength);
  obCodeNode1:= GetNodeByText(obCodeTreeView,stCode,True);
  if obCodeNode1 <> nil then
  begin
    obNode1 := obTreeView.Items.Item[obCodeNode1.AbsoluteIndex];
    if obNode1 <> nil then
    begin
      obNode1.ImageIndex:=aDoorState;
      obNode1.SelectedIndex:=aDoorState;
    end;
  end;
end;

procedure TfmFireMonitoring.ed_AddNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfmFireMonitoring.FontSetting;
begin
  dmFormFontUtil.TravelFormFontSetting(self,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.TravelAdvOfficeTabSetOfficeStylerFontSetting(AdvOfficeTabSetOfficeStyler1, G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.FormAdvOfficeTabSetOfficeStylerSetting(AdvOfficeTabSetOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormStyleSetting(self,AdvToolBarOfficeStyler1);

end;

procedure TfmFireMonitoring.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

procedure TfmFireMonitoring.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  ini_fun : TiniFile;
begin
  L_bFormClose := True;
  StateAsyncTimer1.Enabled := False;
  SearchTimer.Enabled := False;

  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMFIREMONITORING);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'FALSE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  ListDongCodeList.Free;
  ListAreaCodeList.Free;
  ListDoorCodeList.Free;
  SearchPasswordCodeList.Free;
  SearchDoorCodeList.Free;
  DisplayList.Free;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
    with ini_fun do
    begin
      WriteInteger('AlarmEvent','Height',pan_AlarmListHeader.Height);
    end;
  Finally
    ini_fun.Free;
  End;

  Action := caFree;
end;

procedure TfmFireMonitoring.FormCreate(Sender: TObject);
begin

  L_bClear := True;
  L_bAlarmClear := True;

  ListDongCodeList := TStringList.Create;
  ListAreaCodeList := TStringList.Create;
  ListDoorCodeList := TStringList.Create;
  SearchPasswordCodeList := TStringList.Create;
  SearchDoorCodeList := TStringList.Create;
  DisplayList := TStringList.Create;
  BuildingImageList := TStringList.Create;
  FireEventList := TStringList.Create;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);

  StateAsyncTimer1.Enabled := True;
  SearchTimer.Enabled := True;
  FontSetting;
end;


procedure TfmFireMonitoring.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('1','M00021');
  menuTab.AdvOfficeTabs[0].Caption := dmFormName.GetFormMessage('1','M00035');
  //menuTab.AdvOfficeTabs[1].Caption := dmFormName.GetFormMessage('1','M00021');

  pan_DoorState.Caption.Text := dmFormName.GetFormMessage('4','M00060');
  pan_AlarmListHeader.Caption.Text := dmFormName.GetFormMessage('4','M00142');
  with sg_AlarmEvent do
  begin
    cells[0,0] := WideString(dmFormName.GetFormMessage('4','M00143'));
    cells[1,0] := WideString(dmFormName.GetFormMessage('4','M00002'));
    cells[2,0] := WideString(dmFormName.GetFormMessage('4','M00144'));
    cells[3,0] := WideString(dmFormName.GetFormMessage('4','M00145'));
  end;
  mn_DoorClose.Caption := dmFormName.GetFormMessage('4','M00091');
  mn_DoorOpenMode.Caption := dmFormName.GetFormMessage('4','M00092');
  mn_DeviceChange.Caption := dmFormName.GetFormMessage('4','M00093');
  mn_AllCardDelete.Caption := dmFormName.GetFormMessage('4','M00094');
  mn_PasswordAllDelete.Caption := dmFormName.GetFormMessage('4','M00095');
  mn_DeviceInitialize.Caption := dmFormName.GetFormMessage('4','M00096');
end;

procedure TfmFireMonitoring.FormShow(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMFIREMONITORING);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  FormNameSetting;
  LoadListView;
  LoadingFire;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
    with ini_fun do
    begin
      pan_AlarmListHeader.Height := ReadInteger('AlarmEvent','Height',100);
      if ReadInteger('AlarmEvent','Show',0) = 1 then  pan_AlarmListHeader.Visible := True
      else pan_AlarmListHeader.Visible := False;
    end;

  Finally
    ini_fun.Free;
  End;
end;

procedure TfmFireMonitoring.Form_Close;
begin
  Close;
end;


function TfmFireMonitoring.GetAccessResultName(aAccessResultCode: string): string;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := aAccessResultCode;
  stSql := ' Select * from TB_PERMITCODE';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND PE_PERMITCODE = ''' + aAccessResultCode + ''' ';

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
      if recordcount < 1 then Exit;
      result := FindField('PE_PERMITNAME').AsString;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetAlarmCodeInfo(aAlarmCode: string; var aAlarmName,
  aAlarmEvent, aAlarmSound, aAlarmMessage, aColor: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  aAlarmName := '';
  aAlarmEvent := '';
  aAlarmSound := '';
  aAlarmMessage := '';
  aColor:= '';

  result := False;
  stSql := ' Select * from TB_ALARMCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND AE_ALARMCODE = ''' + aAlarmCode + ''' ';

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
      if recordcount < 1 then Exit;
      result := True;
      aAlarmName := FindField('AE_ALARMNAME').AsString;
      aAlarmEvent := FindField('AE_Event').AsString;
      aAlarmSound := FindField('AE_Sound').AsString;
      aAlarmMessage := FindField('AE_Alarm').AsString;
      aColor := FindField('AE_Color').AsString;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetEmployeeInfo(aCardNo: string; var aCompanyName,
  aDepartName, aEmCode, aUserName: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  aCompanyName := '';
  aDepartName := '';
  aEmCode := '';
  aUserName := '';

  result := False;
  stSql := ' Select a.*,b.BC_NAME as DEPARTNAME,c.BC_NAME as COMPANYNAME from ';
  stSql := stSql + '(' ;
  stSql := stSql + '(' ;
  stSql := stSql + 'TB_CARD a ';
  stSql := stSql + ' Left Join ( select * from tb_buildingCode where bc_position = 2 ) b ';
  stSql := stSql + ' ON (a.GROUP_CODE = b.GROUP_CODE) ';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_PARENTCODE ) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = b.BC_CHILDCODE ) ';
  stSql := stSql + ')';
  stSql := stSql + ' Left Join ( select * from tb_buildingCode where bc_position = 1 ) c ';
  stSql := stSql + ' ON (a.GROUP_CODE = c.GROUP_CODE) ';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_CHILDCODE ) ';
  stSql := stSql + ')';
  stSql := stSql + ' Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND a.CA_CARDNO = ''' + aCardNo + ''' ';

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
      if recordcount < 1 then Exit;
      result := True;
      aCompanyName := FindField('COMPANYNAME').AsString;
      aDepartName := FindField('DEPARTNAME').AsString;
      aEmCode := FindField('CA_CODE').AsString;
      aUserName := FindField('CA_NAME').AsString;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetLocationName(aNodeNo, aECUID, aDoorNo: string;
  var aDongName, aAreaName, aDoorName: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  aDongName := '';
  aAreaName := '';
  aDoorName := '';

  result := False;
  stSql := ' Select a.*,b.BC_NAME as AREANAME,c.BC_NAME as DONGNAME from ';
  stSql := stSql + '(' ;
  stSql := stSql + '(' ;
  stSql := stSql + 'TB_DOOR a ';
  stSql := stSql + ' Left Join ( select * from tb_buildingCode where bc_position = 2 ) b ';
  stSql := stSql + ' ON (a.GROUP_CODE = b.GROUP_CODE) ';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_PARENTCODE ) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = b.BC_CHILDCODE ) ';
  stSql := stSql + ')';
  stSql := stSql + ' Left Join ( select * from tb_buildingCode where bc_position = 1 ) c ';
  stSql := stSql + ' ON (a.GROUP_CODE = c.GROUP_CODE) ';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_CHILDCODE ) ';
  stSql := stSql + ')';
  stSql := stSql + ' Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND a.ND_NODENO = ' + aNodeNo + ' ';
  stSql := stSql + ' AND a.DE_DEVICEID = ''' + aEcuID + ''' ';
  stSql := stSql + ' AND a.DO_DOORNO = ' + aDoorNo + ' ';

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
      if recordcount < 1 then Exit;
      result := True;
      aDongName := FindField('DONGNAME').AsString;
      aAreaName := FindField('AREANAME').AsString;
      aDoorName := FindField('DO_NAME').AsString;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetNodeIP(aNodeNo: string): string;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := '';
  stSql := ' Select * from TB_NODE';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND ND_NODENO = ' + aNodeNo + ' ';

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
      if recordcount < 1 then Exit;
      result := FindField('ND_NODEIP').AsString;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetPasswordCount: integer;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := 0;
  stSql := 'Select * from TB_PASSWORD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';

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
      if recordcount < 1 then Exit;
      result := recordcount;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmFireMonitoring.GetstChangeStateName(aChangeStateCode: string): string;
begin
  result := dmFormName.GetFormMessage('3','M00010');
  if aChangeStateCode = '' then Exit;

  case aChangeStateCode[1] of
    'c' : begin  
      result := dmFormName.GetFormMessage('3','M00004');
    end;
    'p' : begin  
      result := dmFormName.GetFormMessage('3','M00005');
    end;
    'm' : begin  
      result := dmFormName.GetFormMessage('3','M00006');
    end;
    else begin
      result := aChangeStateCode;
    end;
  end;
end;

function TfmFireMonitoring.GetUserNameFromCardNO(aCardNo: string): string;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := '';
  stSql := 'Select * from TB_CARD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';

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
      if recordcount < 1 then Exit;
      result := FindField('CA_NAME').AsString;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmFireMonitoring.img_TotImageDblClick(Sender: TObject);
begin
  inherited;
  if Not L_bMapUpdate then Exit;
  RzOpenDialog1.Title:= '이미지 파일 찾기';
  RzOpenDialog1.DefaultExt:= 'jpg';
  RzOpenDialog1.InitialDir := G_stExeFolder;
  RzOpenDialog1.Filter := 'JPEG files (*.jpg)|*.jpg';
  if RzOpenDialog1.Execute then
  begin
    ed_MapFile.Text := RzOpenDialog1.FileName;
    if FileExists(ed_MapFile.Text) then img_TotImage.Picture.LoadFromFile(ed_MapFile.Text);
  end;

end;

procedure TfmFireMonitoring.LoadChildCode(aParentCode: string; aPosition: integer;
  cmbBox: TComboBox; aList: TStringList; aAll: Boolean);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  cmbBox.Items.Clear;
  aList.Clear;
  if aAll then
  begin
    cmbBox.Items.Add(dmFormName.GetFormMessage('3','M00007'));
    aList.Add('');
    cmbBox.ItemIndex := 0;
  end;
  if aParentCode = '' then Exit;
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    stSql := 'SELECT * FROM TB_BUILDINGCODE ';
    stSql := stSql + '  Where BC_POSITION = ' + inttostr(aPosition);
    stSql := stSql + '  AND BC_PARENTCODE = ''' + aParentCode + ''' ';
    stSql := stSql + '  ORDER BY idx  ';
    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        cmbBox.Items.Add(FindField('BC_NAME').AsString);
        aList.Add(FindField('BC_CHILDCODE').AsString);
        Next;
      end;
      if cmbBox.Items.Count > 0 then cmbBox.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;



function TfmFireMonitoring.LoadingFire: Boolean;
var
  i : integer;
  stSql : string;
  TempAdoQuery : TADOQuery;
  nIconHeight : integer;
  nIconWidth : integer;
  nCurTotWidth,nCurTotHeight : integer;
  nCurXPosition,nCurYPosition : integer;
  stCode : string;
  FireMap : TMapFire ;
begin
  if FileExists(G_stExeFolder + '\Map.jpg') then img_TotImage.Picture.LoadFromFile(G_stExeFolder + '\Map.jpg');

  if BuildingImageList.Count > 0 then
    for i := BuildingImageList.Count - 1 downto 0 do TMapBuilding(BuildingImageList.Objects[i]).Free;

  BuildingImageList.Clear;
  nIconHeight := 50;
  nIconWidth := 50;
  //if isDigit(L_stMapBuildingICON_W) then nIconWidth := strtoint(L_stMapBuildingICON_W);
  //if isDigit(L_stMapBuildingICON_H) then nIconHeight := strtoint(L_stMapBuildingICON_H);
  nCurTotWidth := img_TotImage.Width;
  nCurTotHeight := img_TotImage.Height;

  //stSql := dmDBSql.GetTB_LOCATION_BuildingName(G_stGroupCode,'');
  stSql := 'SELECT * FROM TB_DOOR where DO_FIRE = 1 ';
  stSql := stSql + '  ORDER BY idx  ';
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
      if RecordCount < 1 then Exit;
      First;
      i:=0;

      While Not Eof do
      begin
        stCode := FillZeroNumber(FindField('ND_NODENO').AsInteger,3) + FindField('DE_DEVICEID').AsString + FindField('DO_DOORNO').AsString ;
        FireMap := TMapFire.Create(nil);
        FireMap.Parent := Pan_Image;
        FireMap.ImageFile := G_stExeFolder + '\fire.png';
        FireMap.Stretch := True;
        if FindField('DO_CURX').IsNull then FireMap.CurX := 0
        else FireMap.CurX := FindField('DO_CURX').AsInteger;
        if FindField('DO_CURY').IsNull then FireMap.CurY := 0
        else FireMap.CurY := FindField('DO_CURY').AsInteger;
        FireMap.ParentImageHeight := nCurTotHeight;
        FireMap.ParentImageWidth := nCurTotWidth;
        if FindField('DO_TOTHEIGHT').IsNull or (FindField('DO_TOTHEIGHT').AsInteger = 0) then FireMap.TotH := img_TotImage.Height
        else FireMap.TotH := FindField('DO_TOTHEIGHT').AsInteger;
        if FindField('DO_TOTWIDTH').IsNull or (FindField('DO_TOTWIDTH').AsInteger = 0) then FireMap.TotW := img_TotImage.Width
        else FireMap.TotW := FindField('DO_TOTWIDTH').AsInteger;
        nCurXPosition := 0;
        nCurYPosition := 0;
        if (FireMap.CurX * nCurTotWidth) > 0 then
           nCurXPosition := (FireMap.CurX * nCurTotWidth) div FireMap.TotW;
        if (FireMap.CurX * nCurTotHeight) > 0 then
          nCurYPosition := (FireMap.CurY * nCurTotHeight) div FireMap.TotH;
        FireMap.Left := nCurXPosition;
        FireMap.top := nCurYPosition;
        FireMap.Name := FindField('DO_NAME').AsString;
        FireMap.Height := 32;//strtoint(L_stMapBuildingICON_H);
        FireMap.Width := 32;//strtoint(L_stMapBuildingICON_W);
        FireMap.Code := stCode;
        FireMap.DragOn := False;
        FireMap.MapVisible := False;
        FireMap.OnDblClick := BuildingImageDblClick;
        FireMap.OnMouseEnter := BuildingImageMouseEnter;
        FireMap.OnMouseLeave := BuildingImageMouseLeave;

        BuildingImageList.AddObject(stCode,FireMap);
        inc(i);
        //if i > 1 then Exit;

        Application.ProcessMessages;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmFireMonitoring.LoadListView;
var
  obTreeView   : TTreeview;
  obCodeTreeView : TTreeview;
  obNode1   : TTreeNode;
  obNode2   : TTreeNode;
  obNode3   : TTreeNode;
  obCodeNode1: TTreeNode;
  obCodeNode2: TTreeNode;
  obCodeNode3: TTreeNode;
  stSql : string;
  TempAdoQuery : TADOQuery;
  stCode : string;
  stName : string;
  nDoorImageIndex : integer;
  nIndex : integer;
  stTempCode : string;
begin
  if G_bApplicationTerminate then Exit;
  obTreeView := TreeView_DoorList;
  obTreeView.ReadOnly:= True;
  obTreeView.Items.Clear;
  obCodeTreeView := TreeView_LocationCode;   //위치 코드 등록으로 현재 상태를 파악하기 위함
  obCodeTreeView.ReadOnly := True;
  obCodeTreeView.Items.Clear;

  obNode1:= obTreeView.Items.Add(nil,dmFormName.GetFormMessage('4','M00061'));
  obNode1.ImageIndex:=0;
  obNode1.SelectedIndex:=0;
  obNode1.StateIndex:= -1;
  obCodeNode1 := obCodeTreeView.Items.Add(nil,'B' + FillZeroNumber(0,G_nBuildingCodeLength) + FillZeroNumber(0,G_nBuildingCodeLength));

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      //Sql.Clear;
      stSql := 'Select * from TB_BUILDINGCODE where BC_POSITION = 1 ';
      stSql := stSql + '  ORDER BY idx  ';
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if RecordCount > 0 then
      begin
        First;
        While Not Eof do
        begin
          if G_bApplicationTerminate then Exit;
          stCode := 'B' + FindField('BC_PARENTCODE').AsString + FillZeroStrNum(FindField('BC_CHILDCODE').AsString,G_nBuildingCodeLength);
          stName := FindField('BC_NAME').AsString;

          obNode2:= obTreeView.Items.AddChild(obNode1,stName);
          obNode2.ImageIndex:=1;
          obNode2.SelectedIndex:=1;
          obNode2.StateIndex:= -1;
          obCodeNode2 := obCodeTreeView.Items.AddChild(obCodeNode1,stCode);
          Application.ProcessMessages;
          Next;
        end;
        obNode1.Expanded := True;
      end;
      Close;
      //Sql.Clear;
      stSql := 'Select * from TB_BUILDINGCODE where BC_POSITION = 2 ';
      stSql := stSql + '  ORDER BY idx  ';
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if RecordCount > 0 then
      begin
        First;
        While Not Eof do
        begin
          if G_bApplicationTerminate then Exit;
          stCode := 'B' + FindField('BC_PARENTCODE').AsString + FillZeroStrNum(FindField('BC_CHILDCODE').AsString,G_nBuildingCodeLength);
          stName := FindField('BC_NAME').AsString;
          obCodeNode1:= GetNodeByText(obCodeTreeView,'B' + FillZeroNumber(0,G_nBuildingCodeLength) + FindField('BC_PARENTCODE').AsString,True);
          if obCodeNode1 <> nil then
          begin
            obNode1 := obTreeView.Items.Item[obCodeNode1.AbsoluteIndex];
            if obNode1 <> nil then
            begin
              obNode2:= obTreeView.Items.AddChild(obNode1,stName);
              obNode2.ImageIndex:=2;
              obNode2.SelectedIndex:=2;
              obNode2.StateIndex:= -1;
            end;
            obCodeNode2:= obCodeTreeView.Items.Item[obCodeNode1.AbsoluteIndex];
            if obCodeNode2 <> nil then
            begin
              obCodeNode3:= obCodeTreeView.Items.AddChild(obCodeNode2,stCode);
            end;
            obNode1.Expanded := True;
          end;
          Next;
        end;
      end;
      Close;
      //Sql.Clear;
      stSql := 'Select * from TB_DOOR ';
      stSql := stSql + '  ORDER BY idx  ';
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if RecordCount > 0 then
      begin
        First;
        While Not Eof do
        begin
          if G_bApplicationTerminate then Exit;
          stCode := 'D' + FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FillZeroNumber(strtoint(FindField('DE_DEVICEID').AsString),G_nDeviceCodeLength) + FillZeroNumber(FindField('DO_DOORNO').AsInteger,G_nDoorCodeLength);
          stName := FindField('DO_NAME').AsString;
          if (FindField('BC_CHILDCODE').AsString = '') or
             (FindField('BC_CHILDCODE').AsString = FillZeroNumber(0,G_nBuildingCodeLength))
          then stTempCode := 'B' + FillZeroNumber(0,G_nBuildingCodeLength) + FindField('BC_PARENTCODE').AsString
          else stTempCode := 'B' +FindField('BC_PARENTCODE').AsString + FindField('BC_CHILDCODE').AsString;

          obCodeNode1:= GetNodeByText(obCodeTreeView,stTempCode,True);
          if obCodeNode1 <> nil then
          begin
            obNode1 := obTreeView.Items.Item[obCodeNode1.AbsoluteIndex];
            if obNode1 <> nil then
            begin
              obNode2:= obTreeView.Items.AddChild(obNode1,stName);
              nDoorImageIndex := con_DOORNOTSTATE;
              nIndex := DeviceList.IndexOf(FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FillZeroNumber(strtoint(FindField('DE_DEVICEID').AsString),G_nDeviceCodeLength));
              if nIndex > -1 then
              begin
                if TDevice(DeviceList.Objects[nIndex]).DoorMode = '' then
                begin
                  nDoorImageIndex := con_DOORNOTSTATE;
                end else
                begin
                  case UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorMode)[1] of
                    'C' :
                    begin
                      if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorState) = 'O' then nDoorImageIndex := con_DOORLOCKOPEN
                      else if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorState) = 'C' then nDoorImageIndex := con_DOORLOCKCLOSE
                      else nDoorImageIndex := con_DOORLOCKCLOSE;
                    end;
                    'O' :
                    begin
                      if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorState) = 'O' then nDoorImageIndex := con_DOORFREEOPEN
                      else if UpperCase(TDevice(DeviceList.Objects[nIndex]).DoorState) = 'C' then nDoorImageIndex := con_DOORFREECLOSE
                      else nDoorImageIndex := con_DOORFREEOPEN;
                    end;
                  end;
                end;
              end;
              obNode2.ImageIndex:=nDoorImageIndex;
              obNode2.SelectedIndex:=nDoorImageIndex;
              obNode2.StateIndex:= -1;
            end;
            obCodeNode2:= obCodeTreeView.Items.Item[obCodeNode1.AbsoluteIndex];
            if obCodeNode2 <> nil then
            begin
              obCodeNode3:= obCodeTreeView.Items.AddChild(obCodeNode2,stCode);
            end;
            obNode1.Expanded := True;
          end;
          Next;
        end;
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmFireMonitoring.menuTabChange(Sender: TObject);
var
  stBuildingCode : string;
  stAreaCode : string;
  nIndex : integer;
  i : integer;
begin
  if menuTab.ActiveTabIndex = 0 then //Ȩ
  begin
    if menuTab.AdvOfficeTabs.Items[0].Caption = dmFormName.GetFormMessage('1','M00035') then Close
    else
    begin
      menuTab.ActiveTabIndex := 1;
      //menuTabChange(self);
    end;
  end else if menuTab.ActiveTabIndex = 2 then
  begin
    if menuTab.AdvOfficeTabs.Items[2].Caption = '맵수정' then
    begin
      MessageTimer1.Enabled := True;
      lb_hint.Visible := True;
      menuTab.AdvOfficeTabs.Items[2].Caption := '맵저장';
      menuTab.ActiveTabIndex := 1;
      for i := 0 to BuildingImageList.Count - 1 do
      begin
        TMapFire(BuildingImageList.Objects[i]).DragOn := True;
        TMapFire(BuildingImageList.Objects[i]).MapVisible := True;
      end;
      L_bMapUpdate := True;
    end else
    begin
      MessageTimer1.Enabled := False;
      lb_hint.Visible := False;
      menuTab.AdvOfficeTabs.Items[2].Caption := '맵수정';
      menuTab.ActiveTabIndex := 1;
      for i := 0 to BuildingImageList.Count - 1 do
      begin
        dmDBFunction.UpdateTB_DOOR_Field_StringValue(copy(TMapFire(BuildingImageList.Objects[i]).Code,1,3),copy(TMapFire(BuildingImageList.Objects[i]).Code,4,2),copy(TMapFire(BuildingImageList.Objects[i]).Code,6,1),'DO_TOTHEIGHT',inttostr(TMapFire(BuildingImageList.Objects[i]).ParentImageHeight));
        dmDBFunction.UpdateTB_DOOR_Field_StringValue(copy(TMapFire(BuildingImageList.Objects[i]).Code,1,3),copy(TMapFire(BuildingImageList.Objects[i]).Code,4,2),copy(TMapFire(BuildingImageList.Objects[i]).Code,6,1),'DO_TOTWIDTH',inttostr(TMapFire(BuildingImageList.Objects[i]).ParentImageWidth));
        dmDBFunction.UpdateTB_DOOR_Field_StringValue(copy(TMapFire(BuildingImageList.Objects[i]).Code,1,3),copy(TMapFire(BuildingImageList.Objects[i]).Code,4,2),copy(TMapFire(BuildingImageList.Objects[i]).Code,6,1),'DO_CurX',inttostr(TMapFire(BuildingImageList.Objects[i]).Left));
        dmDBFunction.UpdateTB_DOOR_Field_StringValue(copy(TMapFire(BuildingImageList.Objects[i]).Code,1,3),copy(TMapFire(BuildingImageList.Objects[i]).Code,4,2),copy(TMapFire(BuildingImageList.Objects[i]).Code,6,1),'DO_CurY',inttostr(TMapFire(BuildingImageList.Objects[i]).Top));
        TMapFire(BuildingImageList.Objects[i]).DragOn := False;
        TMapFire(BuildingImageList.Objects[i]).MapVisible := False;
      end;
      if FileExists(ed_MapFile.Text) then
      begin
        CopyFile(PChar(ed_MapFile.Text), PChar(G_stExeFolder + '\Map.jpg'), True);
      end;
      L_bMapUpdate := False;
    end;
  end;

end;


procedure TfmFireMonitoring.MessageTimer1Timer(Sender: TObject);
begin
  inherited;
  lb_hint.Visible := Not lb_hint.Visible;
end;

procedure TfmFireMonitoring.mn_DeviceChangeClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
  stSelectName : string;
begin
  stSelectName := TreeView_DoorList.Selected.Text;
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := inttostr(strtoint(copy(stDoorID,2,G_nNodeCodeLength)));
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);

  //기기락타임정보 재전송
  dmDBFunction.UpdateTB_DOORDeviceAsync(stNodeNo,stEcuID,'1','N');
  //마스터번호 재전송
  dmDBFunction.UpdateTB_DOORMasterRcv(stNodeNo,stEcuID,'1','N');
  //카드데이터 재전송
  dmDBFunction.UpdateTB_DEVICECARDNO_DeviceState(stNodeNo,stEcuID,'N');
  //비밀번호 재전송
  dmDBFunction.UpdateTB_DEVICEPASSWD_DeviceState(stNodeNo,stEcuID,'N');
  showmessage(stSelectName + ':' + dmFormName.GetFormMessage('2','M00040'));
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.mn_DeviceInitializeClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
  stSelectName : string;
begin
  stSelectName := TreeView_DoorList.Selected.Text;
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := copy(stDoorID,2,G_nNodeCodeLength);
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);
  nIndex := DeviceList.IndexOf(stNodeNo + stEcuID);
  if nIndex > -1 then
  begin
    TDevice(DeviceList.Objects[nIndex]).DeviceInitialize;
    showmessage(stSelectName + ':' + dmFormName.GetFormMessage('2','M00041'));
  end;
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.mn_DoorCloseClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
begin
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := copy(stDoorID,2,G_nNodeCodeLength);
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);
  nIndex := DeviceList.IndexOf(stNodeNo + stEcuID);
  if nIndex > -1 then
  begin
    TDevice(DeviceList.Objects[nIndex]).ModeChange('c');
  end;
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.mn_DoorOpenModeClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
begin
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := copy(stDoorID,2,G_nNodeCodeLength);
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);
  nIndex := DeviceList.IndexOf(stNodeNo + stEcuID);
  if nIndex > -1 then
  begin
    TDevice(DeviceList.Objects[nIndex]).ModeChange('o');
  end;
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.mn_PasswordAllDeleteClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
  stSelectName : string;
begin
  stSelectName := TreeView_DoorList.Selected.Text;
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := copy(stDoorID,2,G_nNodeCodeLength);
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);
  nIndex := DeviceList.IndexOf(stNodeNo + stEcuID);
  if nIndex > -1 then
  begin
    TDevice(DeviceList.Objects[nIndex]).PasswordAllDelete(False);
    showmessage(stSelectName + ':' + dmFormName.GetFormMessage('2','M00042'));
  end;
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.mn_AllCardDeleteClick(Sender: TObject);
var
  stDoorID : string;
  stNodeNo : string;
  stEcuID : string;
  nIndex : integer;
  stSelectName : string;
begin
  stSelectName := TreeView_DoorList.Selected.Text;
  stDoorID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stDoorID[1] <> 'D' then Exit;
  stNodeNo := copy(stDoorID,2,G_nNodeCodeLength);
  stEcuID := copy(stDoorID,2 + G_nNodeCodeLength,G_nDeviceCodeLength);
  nIndex := DeviceList.IndexOf(stNodeNo + stEcuID);
  if nIndex > -1 then
  begin
    TDevice(DeviceList.Objects[nIndex]).CardAllDelete(False);
    showmessage(stSelectName + ':' + dmFormName.GetFormMessage('2','M00043'));
  end;
  PopupMenu.CloseMenu;
end;

procedure TfmFireMonitoring.RcvAlarmEvent(aNodeNo, aECUID, aDoorNo, aReaderNo,
  aInOut, aTime, aCardMode, aDoorMode, aAlarmCode: string);
var
  stDisplay : string;
//  stNodeNo : string;
//  stEcuID : string;
//  stDoorNo : string;
  stTemp1,stTemp2 : string;
  stDoorName : string;
  stAlarmName : string;
  stAlarmEvent,stAlarmSound,stAlarmMessage,stColor : string;
  stCode : string;
  nIndex : integer;
begin
  stCode := FillZeroNumber(strtoint(aNodeNo),3) +aECUID + aDoorNo ;

  //여기에서 화면에 뿌려주자.
  with sg_AlarmEvent do
  begin
    if RowCount >= 1000 then  rowCount := 999;


    GetLocationName(aNodeNo,aECUID,aDoorNo,stTemp1,stTemp2,stDoorName);
    GetAlarmCodeInfo(aAlarmCode,stAlarmName,stAlarmEvent,stAlarmSound,stAlarmMessage,stColor);

    if stAlarmEvent <> '1' then Exit; //이벤트 발생건이 아니면 빠져 나가자.
    if Not L_bAlarmClear then InsertRows(1,1);
    L_bAlarmClear := False;

    Cells[0,1] := MakeDatetimeStr(aTime);
    Cells[1,1] := stDoorName;
    Cells[2,1] := aAlarmCode;
    Cells[3,1] := stAlarmName;
    if(aAlarmCode = 'q') then
    begin
      if FireEventList.IndexOf(stCode) < 0 then FireEventList.Add(stCode);
    end else if(aAlarmCode = 'r') then
    begin
      while L_bFireAlarm do
      begin
        sleep(1);
        Application.ProcessMessages;
      end;
      Try
        L_bFireAlarmDelete := True;
        nIndex := FireEventList.IndexOf(stCode);
        FireEventList.Delete(nIndex);
        nIndex := BuildingImageList.IndexOf(stCode);
        if nIndex > -1 then TMapFire(BuildingImageList.Objects[nIndex]).MapVisible := False;
      Finally
        L_bFireAlarmDelete := False;
      End;
    end;

    if isDigit(stColor) then
    begin
      RowColor[1] := strtoint(stColor);
    end;
  end;
end;


procedure TfmFireMonitoring.RcvDoorModeChange(aNodeNo, aECUID, aResult,
  aMode,aDoorState: string);
begin
  if aResult <> '1' then Exit;
  if aMode = '' then
  begin
    DoorStateChange(aNodeNo,aECUID,'1',con_DOORNOTSTATE);
    Exit;
  end;
  case UpperCase(aMode)[1] of
    'O' : begin //개방
      if aDoorState = 'O' then DoorStateChange(aNodeNo,aECUID,'1',con_DOORFREEOPEN)
      else if aDoorState = 'C' then DoorStateChange(aNodeNo,aECUID,'1',con_DOORFREECLOSE)
      else DoorStateChange(aNodeNo,aECUID,'1',con_DOORFREEOPEN);
    end;
    'C' : begin //운영
      if aDoorState = 'O' then DoorStateChange(aNodeNo,aECUID,'1',con_DOORLOCKOPEN)
      else if aDoorState = 'C' then DoorStateChange(aNodeNo,aECUID,'1',con_DOORLOCKCLOSE)
      else DoorStateChange(aNodeNo,aECUID,'1',con_DOORLOCKCLOSE);
    end;
    else begin //모름
      DoorStateChange(aNodeNo,aECUID,'1',con_DOORNOTSTATE);
    end;
  end;
end;

procedure TfmFireMonitoring.ReceiveDeviceInitialize(aNodeNo, aECUID,
  aResult: string);
var
  stDongName,stAreaName,stDoorName : string;
begin
  if aResult <> '1' then Exit;
  if GetLocationName(aNodeNo,aECUID,'1',stDongName,stAreaName,stDoorName) then
  begin
    showmessage(stDoorName + ':' + dmFormName.GetFormMessage('2','M00044'));
  end else
  begin
    showmessage(aNodeNo + aECUID + ':' + dmFormName.GetFormMessage('2','M00044'));
  end;
end;

procedure TfmFireMonitoring.sg_doorListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
var
  nIndex : integer;
  i : integer;
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    SearchDoorCodeList.Clear;
    if State then
    begin
      L_nAddDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1;
      for i := 1 to (Sender as TAdvStringGrid).RowCount do
      begin
        SearchDoorCodeList.Add((Sender as TAdvStringGrid).Cells[2,i] + (Sender as TAdvStringGrid).Cells[3,i] + (Sender as TAdvStringGrid).Cells[4,i]);
      end;
    end else L_nAddDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then
    begin
      L_nAddDoorCheckCount := L_nAddDoorCheckCount + 1;
      nIndex := SearchDoorCodeList.IndexOf((Sender as TAdvStringGrid).Cells[2,ARow] + (Sender as TAdvStringGrid).Cells[3,ARow] + (Sender as TAdvStringGrid).Cells[4,ARow]);
      if nIndex < 0 then SearchDoorCodeList.Add((Sender as TAdvStringGrid).Cells[2,ARow] + (Sender as TAdvStringGrid).Cells[3,ARow] + (Sender as TAdvStringGrid).Cells[4,ARow]);
    end else
    begin
      L_nAddDoorCheckCount := L_nAddDoorCheckCount - 1 ;
      nIndex := SearchDoorCodeList.IndexOf((Sender as TAdvStringGrid).Cells[2,ARow] + (Sender as TAdvStringGrid).Cells[3,ARow] + (Sender as TAdvStringGrid).Cells[4,ARow]);
      if nIndex > -1 then SearchDoorCodeList.Delete(nIndex);
    end;
  end;

end;

procedure TfmFireMonitoring.sg_doorPasswordListCheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then
    begin
      L_nDeletePasswordCheckCount := (Sender as TAdvStringGrid).RowCount - 1;
    end else L_nDeletePasswordCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then
    begin
      L_nDeletePasswordCheckCount := L_nDeletePasswordCheckCount + 1;
    end else
    begin
      L_nDeletePasswordCheckCount := L_nDeletePasswordCheckCount - 1 ;
    end;
  end;

end;

procedure TfmFireMonitoring.sg_PasswordListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
var
  nIndex : integer;
  i : integer;
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    SearchPasswordCodeList.Clear;
    if State then
    begin
      L_nPasswordCheckCount := (Sender as TAdvStringGrid).RowCount - 1;
      for i := 1 to (Sender as TAdvStringGrid).RowCount do
      begin
        SearchPasswordCodeList.Add((Sender as TAdvStringGrid).Cells[1,i]);
      end;
    end else L_nPasswordCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then
    begin
      L_nPasswordCheckCount := L_nPasswordCheckCount + 1;
    end else
    begin
      L_nPasswordCheckCount := L_nPasswordCheckCount - 1 ;
    end;
  end;

end;

procedure TfmFireMonitoring.StateAsyncTimer1Timer(Sender: TObject);
var
  i : integer;
begin
  inherited;

  for i := 0 to DeviceList.Count - 1 do
  begin
    if G_bApplicationTerminate then Exit;
    RcvDoorModeChange(inttostr(TDevice(DeviceList.Objects[i]).NodeNo),TDevice(DeviceList.Objects[i]).DeviceID,'1',TDevice(DeviceList.Objects[i]).DoorMode,TDevice(DeviceList.Objects[i]).DoorSTATE);
  end;


end;

procedure TfmFireMonitoring.TreeView_DoorListClick(Sender: TObject);
var
  stLocateID : string;
  stNodeNo : string;
  stNodeIp : string;
begin
  //TreeView_DoorList.ShowHint := False;
  stLocateID := TreeView_LocationCode.Items.Item[TreeView_DoorList.Selected.AbsoluteIndex].Text;
  if stLocateID[1] <> 'D' then TreeView_DoorList.PopupMenu:= nil
  else
  begin
    TreeView_DoorList.PopupMenu:= PopupMenu;
    stNodeNo := copy(stLocateID,2,G_nNodeCodeLength);
    stNodeIp := GetNodeIP(stNodeNo);
    mn_NodeIP.Caption := 'IP:' + stNodeIp;
    //TreeView_DoorList.Hint := stNodeIp;
    //TreeView_DoorList.ShowHint := True;
  end;

end;

initialization
  RegisterClass(TfmFireMonitoring);
Finalization
  UnRegisterClass(TfmFireMonitoring);

end.