﻿unit uPersonCardPermit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, W7Classes, W7Panels, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvSmoothPanel, Vcl.ExtCtrls, AdvSmoothLabel,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvToolBtn,ADODB,ActiveX, uSubForm, CommandArray, AdvCombo, AdvGroupBox,
  Vcl.Mask, AdvSpin, AdvOfficeButtons, AdvPanel, Vcl.ComCtrls, AdvListV,
  Vcl.ImgList, Vcl.Menus, AdvMenus, Vcl.Samples.Gauges;

type
  TfmPersonCardPermit = class(TfmASubForm)
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    Image1: TImage;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    pan_CardList: TAdvPanel;
    pan_CardListHeader: TAdvSmoothPanel;
    AdvSmoothLabel1: TAdvSmoothLabel;
    btn_Search: TSpeedButton;
    AdvSmoothLabel12: TAdvSmoothLabel;
    AdvSmoothLabel13: TAdvSmoothLabel;
    ed_name: TAdvEdit;
    cmb_ListDongCode: TComboBox;
    cmb_ListAreaCode: TComboBox;
    AdvSmoothPanel1: TAdvSmoothPanel;
    btn_PackagePermitAdd: TSpeedButton;
    btn_PackagePermitDelete: TSpeedButton;
    sg_CardList: TAdvStringGrid;
    pan_PackagePermitAdd: TAdvPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    lv_packagePermitAddCardList: TAdvListView;
    btn_CardPermitAddPerson: TSpeedButton;
    ImageList1: TImageList;
    pan_addSearch: TAdvSmoothPanel;
    sg_addCardList: TAdvStringGrid;
    ed_addSearchName: TAdvEdit;
    btn_addCancel: TSpeedButton;
    pop_PermitAdd: TAdvPopupMenu;
    mn_addpermitListDelete: TMenuItem;
    AdvSmoothPanel3: TAdvSmoothPanel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    cmb_addPermitDongCode: TComboBox;
    cmb_addPermitAreaCode: TComboBox;
    AdvSmoothLabel3: TAdvSmoothLabel;
    sg_addPermitDoorList: TAdvStringGrid;
    btn_DoorPermitAdd: TSpeedButton;
    pan_PackagePermitDelete: TAdvPanel;
    AdvSmoothPanel4: TAdvSmoothPanel;
    btn_CardPermitDeletePerson: TSpeedButton;
    lv_packagePermitDeleteCardList: TAdvListView;
    pan_deleteSearch: TAdvSmoothPanel;
    btn_deleteCancel: TSpeedButton;
    sg_deleteCardList: TAdvStringGrid;
    ed_deleteSearchName: TAdvEdit;
    AdvSmoothPanel6: TAdvSmoothPanel;
    AdvSmoothLabel4: TAdvSmoothLabel;
    AdvSmoothLabel5: TAdvSmoothLabel;
    btn_DoorPermitDelete: TSpeedButton;
    cmb_deletePermitDongCode: TComboBox;
    cmb_deletePermitAreaCode: TComboBox;
    sg_deletePermitDoorList: TAdvStringGrid;
    pan_PersonPermit: TAdvPanel;
    AdvSmoothPanel5: TAdvSmoothPanel;
    AdvSmoothPanel8: TAdvSmoothPanel;
    AdvSmoothLabel6: TAdvSmoothLabel;
    AdvSmoothLabel7: TAdvSmoothLabel;
    cmb_PersonDongCode: TComboBox;
    cmb_PersonAreaCode: TComboBox;
    AdvGroupBox1: TAdvGroupBox;
    AdvGroupBox2: TAdvGroupBox;
    AdvSmoothLabel8: TAdvSmoothLabel;
    AdvSmoothLabel9: TAdvSmoothLabel;
    AdvSmoothLabel10: TAdvSmoothLabel;
    lb_dong: TAdvSmoothLabel;
    lb_area: TAdvSmoothLabel;
    lb_Position: TAdvSmoothLabel;
    AdvSmoothLabel11: TAdvSmoothLabel;
    lb_Name: TAdvSmoothLabel;
    AdvSmoothLabel15: TAdvSmoothLabel;
    lb_TelNum: TAdvSmoothLabel;
    AdvSmoothLabel17: TAdvSmoothLabel;
    lb_CardNo: TAdvSmoothLabel;
    pan_PersonDoor: TAdvPanel;
    pan_NotPermitDoor: TAdvSmoothPanel;
    pan_PermitDoor: TAdvSmoothPanel;
    AdvSmoothPanel10: TAdvSmoothPanel;
    btn_CardPermitAdd: TSpeedButton;
    btn_CardPermitDelete: TSpeedButton;
    sg_NotPermitDoorList: TAdvStringGrid;
    sg_PermitDoorList: TAdvStringGrid;
    ga_PermitDoorAdd: TGauge;
    procedure menuTabChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ed_AddNameKeyPress(Sender: TObject; var Key: Char);
    procedure sg_CardListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure sg_CardListResize(Sender: TObject);
    procedure cmb_ListDongCodeChange(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure cmb_ListAreaCodeChange(Sender: TObject);
    procedure AdvSmoothPanel2Resize(Sender: TObject);
    procedure btn_CardPermitAddPersonClick(Sender: TObject);
    procedure btn_addCancelClick(Sender: TObject);
    procedure ed_addSearchNameChange(Sender: TObject);
    procedure sg_addCardListDblClick(Sender: TObject);
    procedure mn_addpermitListDeleteClick(Sender: TObject);
    procedure AdvSmoothPanel3Resize(Sender: TObject);
    procedure cmb_addPermitDongCodeChange(Sender: TObject);
    procedure cmb_addPermitAreaCodeChange(Sender: TObject);
    procedure sg_addPermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure btn_DoorPermitAddClick(Sender: TObject);
    procedure AdvSmoothPanel4Resize(Sender: TObject);
    procedure btn_deleteCancelClick(Sender: TObject);
    procedure ed_deleteSearchNameChange(Sender: TObject);
    procedure sg_deleteCardListDblClick(Sender: TObject);
    procedure btn_CardPermitDeletePersonClick(Sender: TObject);
    procedure cmb_deletePermitDongCodeChange(Sender: TObject);
    procedure cmb_deletePermitAreaCodeChange(Sender: TObject);
    procedure AdvSmoothPanel6Resize(Sender: TObject);
    procedure btn_DoorPermitDeleteClick(Sender: TObject);
    procedure sg_deletePermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure btn_PackagePermitAddClick(Sender: TObject);
    procedure btn_PackagePermitDeleteClick(Sender: TObject);
    procedure sg_CardListDblClick(Sender: TObject);
    procedure AdvSmoothPanel8Resize(Sender: TObject);
    procedure pan_PersonDoorResize(Sender: TObject);
    procedure AdvSmoothPanel10Resize(Sender: TObject);
    procedure pan_NotPermitDoorResize(Sender: TObject);
    procedure pan_PermitDoorResize(Sender: TObject);
    procedure cmb_PersonDongCodeChange(Sender: TObject);
    procedure cmb_PersonAreaCodeChange(Sender: TObject);
    procedure sg_NotPermitDoorListResize(Sender: TObject);
    procedure sg_PermitDoorListResize(Sender: TObject);
    procedure sg_NotPermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure sg_PermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure btn_CardPermitAddClick(Sender: TObject);
    procedure btn_CardPermitDeleteClick(Sender: TObject);
  private
    ListDongCodeList : TStringList;
    ListAreaCodeList : TStringList;
    AddPermitDongCodeList : TStringList;
    AddPermitAreaCodeList : TStringList;
    DeletePermitDongCodeList : TStringList;
    DeletePermitAreaCodeList : TStringList;
    PersonDongCodeList : TStringList;
    PersonAreaCodeList : TStringList;

    L_nPageListMaxCount : integer;
    L_nCheckCount : integer;        //체크 된 카운트
    L_nAddDoorCheckCount : integer;  //등록 출입문 선택 카운트
    L_nDeleteDoorCheckCount : integer;  //등록 출입문 선택 카운트
    L_nNotPermitDoorCheckCount : integer;        //체크 된 카운트
    L_nPermitDoorCheckCount : integer;        //체크 된 카운트
    { Private declarations }
  private
    procedure LoadChildCode(aParentCode:string;aPosition:integer;cmbBox:TComboBox;aList:TStringList;aAll:Boolean);
    procedure ShowCardList(aCurrentCode,aCardNo:string;aTopRow:integer = 0);
    procedure SearchAddList;
    procedure SearchDeleteList;
    procedure SearchAddPermitDoor;
    procedure SearchDeletePermitDoor;
    procedure SearchDoorPermit(aCardNo:string);
    procedure SearchNotDoorPermit(aCardNo:string);

    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);
    procedure PackagePermitCardListInitialize(aCardList:TAdvListView);
    procedure PackagePermitCardListAdd(aCardNo,aCardName:string;aCardList:TAdvListView);
  public
    { Public declarations }
    procedure Form_Close;
  end;

var
  fmPersonCardPermit: TfmPersonCardPermit;

implementation
uses
  uCommonVariable,
  uDataBase,
  uDBFormName,
  uFormUtil,
  uFunction,
  uMessage,
  udmCardPermit;

{$R *.dfm}


procedure TfmPersonCardPermit.AdvSmoothPanel10Resize(Sender: TObject);
begin
  inherited;
  btn_CardPermitAdd.Top := (AdvSmoothPanel10.Height div 2) - btn_CardPermitAdd.Height - 20;
  btn_CardPermitDelete.Top := (AdvSmoothPanel10.Height div 2) + 20;
end;

procedure TfmPersonCardPermit.AdvSmoothPanel2Resize(Sender: TObject);
begin
  inherited;
  lv_packagePermitAddCardList.Width := AdvSmoothPanel2.Width - 200;

  pan_addSearch.Left := btn_CardPermitAddPerson.Left - pan_addSearch.Width;
  //pan_addSearch.Left := lv_packagePermitAddCardList.Width - pan_addSearch.Width;
end;

procedure TfmPersonCardPermit.AdvSmoothPanel3Resize(Sender: TObject);
begin
  inherited;
  sg_addPermitDoorList.Height := AdvSmoothPanel3.Height - sg_addPermitDoorList.Top;
  sg_addPermitDoorList.Width := AdvSmoothPanel3.Width - 20;
end;

procedure TfmPersonCardPermit.AdvSmoothPanel4Resize(Sender: TObject);
begin
  inherited;
  lv_packagePermitDeleteCardList.Width := AdvSmoothPanel4.Width - 200;

  pan_deleteSearch.Left := btn_CardPermitDeletePerson.Left - pan_deleteSearch.Width;

end;

procedure TfmPersonCardPermit.AdvSmoothPanel6Resize(Sender: TObject);
begin
  inherited;
  sg_DeletePermitDoorList.Height := AdvSmoothPanel6.Height - sg_DeletePermitDoorList.Top;
  sg_DeletePermitDoorList.Width := AdvSmoothPanel6.Width - 20;

end;

procedure TfmPersonCardPermit.AdvSmoothPanel8Resize(Sender: TObject);
begin
  inherited;
  pan_PersonDoor.Height := AdvSmoothPanel8.Height - pan_PersonDoor.Top - 20;
  pan_PersonDoor.Width := AdvSmoothPanel8.Width - 40;
end;

procedure TfmPersonCardPermit.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmPersonCardPermit.btn_addCancelClick(Sender: TObject);
begin
  inherited;
  pan_addSearch.Visible := False;
  ed_addSearchName.Text := '';
  SearchAddList;
end;

procedure TfmPersonCardPermit.btn_CardPermitAddClick(Sender: TObject);
var
  i : integer;
  stCardNo : string;
  bChkState : Boolean;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;
  stCardNo := lb_CardNo.Caption.Text;

  if L_nNotPermitDoorCheckCount < 1 then
  begin
    showmessage('등록할 출입문을 선택하여 주세요.');
    Exit;
  end;

  with sg_NotPermitDoorList do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bchkState);
      if bchkState then
      begin
        stNodeNo := Cells[2,i];
        stDeviceID := Cells[3,i];
        stDoorNo := Cells[4,i];
        dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'L');
      end;
    end;
  end;
  SearchNotDoorPermit(stCardNo);
  SearchDoorPermit(stCardNo);
end;

procedure TfmPersonCardPermit.btn_CardPermitAddPersonClick(Sender: TObject);
begin
  inherited;
  ed_addSearchName.Text := '';
  pan_addSearch.Visible := True;
  SearchAddList;
end;

procedure TfmPersonCardPermit.btn_CardPermitDeleteClick(Sender: TObject);
var
  i : integer;
  stCardNo : string;
  bChkState : Boolean;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;
  stCardNo := lb_CardNo.Caption.Text;

  if L_nPermitDoorCheckCount < 1 then
  begin
    showmessage('삭제할 출입문을 선택하여 주세요.');
    Exit;
  end;

  with sg_PermitDoorList do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bchkState);
      if bchkState then
      begin
        stNodeNo := Cells[3,i];
        stDeviceID := Cells[4,i];
        stDoorNo := Cells[5,i];
        dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'N');
      end;
    end;
  end;
  SearchNotDoorPermit(stCardNo);
  SearchDoorPermit(stCardNo);
end;

procedure TfmPersonCardPermit.btn_CardPermitDeletePersonClick(Sender: TObject);
begin
  inherited;
  ed_DeleteSearchName.Text := '';
  pan_DeleteSearch.Visible := True;
  SearchDeleteList;

end;

procedure TfmPersonCardPermit.btn_deleteCancelClick(Sender: TObject);
begin
  inherited;
  pan_deleteSearch.Visible := False;
end;

procedure TfmPersonCardPermit.btn_DoorPermitAddClick(Sender: TObject);
var
  i,j : integer;
  bChkState : Boolean;
  stCardNo : string;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;
{  if lv_packagePermitAddCardList.Items.Count < 1 then
  begin
    showmessage('권한을 등록 하려면 입주자를 선택 해 주셔야 합니다.');
    Exit;
  end; }
  if L_nAddDoorCheckCount < 1 then
  begin
    showmessage('권한을 등록 하려면 출입문을 선택 해 주셔야 합니다.');
    Exit;
  end;
  btn_DoorPermitAdd.Enabled := False;
  ga_PermitDoorAdd.Visible := True;
  ga_PermitDoorAdd.MaxValue := sg_CardList.RowCount - 1;
  for i := 0 to sg_CardList.RowCount - 1 do
  begin
    ga_PermitDoorAdd.Progress := i;
    sg_CardList.GetCheckBoxState(0,i, bChkState);
    if bChkState then
    begin
      stCardNo := sg_CardList.Cells[5,i];
      //stCardNo := lv_packagePermitAddCardList.Items[i].SubItems.Strings[0];
      With sg_addPermitDoorList do
      begin
        for j := 1 to RowCount - 1 do
        begin
          GetCheckBoxState(0,j, bChkState);
          if bChkState then
          begin
            stNodeNo := cells[4,j];
            stDeviceID := cells[5,j];
            stDoorNo := cells[6,j];
            dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'L');
          end;
          Application.ProcessMessages;
        end;
      end;
    end;
  end;
  ga_PermitDoorAdd.Visible := False;
  showmessage('선택 출입문에 권한 등록이 완료 되었습니다.');
  btn_DoorPermitAdd.Enabled := True;
end;

procedure TfmPersonCardPermit.btn_DoorPermitDeleteClick(Sender: TObject);
var
  i,j : integer;
  bChkState : Boolean;
  stCardNo : string;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;
{  if lv_packagePermitDeleteCardList.Items.Count < 1 then
  begin
    showmessage('권한을 삭제 하려면 입주자를 선택 해 주셔야 합니다.');
    Exit;
  end;  }
  if L_nDeleteDoorCheckCount < 1 then
  begin
    showmessage('권한을 삭제 하려면 출입문을 선택 해 주셔야 합니다.');
    Exit;
  end;

  for i := 0 to sg_CardList.RowCount - 1 do
  begin
    sg_CardList.GetCheckBoxState(0,i, bChkState);
    if bChkState then
    begin
      stCardNo := sg_CardList.Cells[5,i];
      With sg_DeletePermitDoorList do
      begin
        for j := 1 to RowCount - 1 do
        begin
          GetCheckBoxState(0,j, bChkState);
          if bChkState then
          begin
            stNodeNo := cells[4,j];
            stDeviceID := cells[5,j];
            stDoorNo := cells[6,j];
            dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'N');
          end;
          Application.ProcessMessages;
        end;
      end;
    end;
  end;
  showmessage('선택 출입문에 권한 삭제가 완료 되었습니다.');
end;

procedure TfmPersonCardPermit.btn_SearchClick(Sender: TObject);
begin
  inherited;
  ShowCardList('','');

end;

procedure TfmPersonCardPermit.cmb_addPermitAreaCodeChange(Sender: TObject);
begin
  inherited;
  SearchAddPermitDoor;
end;

procedure TfmPersonCardPermit.cmb_addPermitDongCodeChange(Sender: TObject);
var
  stParentCode : string;
begin
  inherited;
  stParentCode := AddPermitDongCodeList.Strings[cmb_addPermitDongCode.ItemIndex];
  LoadChildCode(stParentCode,2,cmb_addPermitAreaCode,AddPermitAreaCodeList,True);
  SearchAddPermitDoor;
end;

procedure TfmPersonCardPermit.cmb_deletePermitAreaCodeChange(Sender: TObject);
begin
  inherited;
  SearchDeletePermitDoor;

end;

procedure TfmPersonCardPermit.cmb_deletePermitDongCodeChange(Sender: TObject);
var
  stParentCode : string;
begin
  inherited;
  stParentCode := DeletePermitDongCodeList.Strings[cmb_DeletePermitDongCode.ItemIndex];
  LoadChildCode(stParentCode,2,cmb_DeletePermitAreaCode,DeletePermitAreaCodeList,True);
  SearchDeletePermitDoor;

end;

procedure TfmPersonCardPermit.cmb_ListAreaCodeChange(Sender: TObject);
begin
  inherited;
  btn_SearchClick(self);

end;

procedure TfmPersonCardPermit.cmb_ListDongCodeChange(Sender: TObject);
var
  stParentCode : string;
begin
  inherited;
  stParentCode := ListDongCodeList.Strings[cmb_ListDongCode.ItemIndex];
  LoadChildCode(stParentCode,2,cmb_ListAreaCode,ListAreaCodeList,True);
  btn_SearchClick(self);

end;

procedure TfmPersonCardPermit.cmb_PersonAreaCodeChange(Sender: TObject);
begin
  inherited;
  SearchNotDoorPermit(lb_CardNo.Caption.Text);
  SearchDoorPermit(lb_CardNo.Caption.Text);

end;

procedure TfmPersonCardPermit.cmb_PersonDongCodeChange(Sender: TObject);
var
  stParentCode : string;
begin
  inherited;
  stParentCode := PersonDongCodeList.Strings[cmb_PersonDongCode.ItemIndex];
  LoadChildCode(stParentCode,2,cmb_PersonAreaCode,PersonAreaCodeList,True);
  SearchNotDoorPermit(lb_CardNo.Caption.Text);
  SearchDoorPermit(lb_CardNo.Caption.Text);

end;

procedure TfmPersonCardPermit.ed_AddNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfmPersonCardPermit.ed_addSearchNameChange(Sender: TObject);
begin
  inherited;
  SearchAddList;
end;

procedure TfmPersonCardPermit.ed_deleteSearchNameChange(Sender: TObject);
begin
  inherited;
  SearchDeleteList;

end;

procedure TfmPersonCardPermit.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  btn_SearchClick(self);
end;

procedure TfmPersonCardPermit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMPERSONCARDPERMIT);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'FALSE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  ListDongCodeList.Free;
  ListAreaCodeList.Free;
  AddPermitDongCodeList.Free;
  AddPermitAreaCodeList.Free;
  DeletePermitDongCodeList.Free;
  DeletePermitAreaCodeList.Free;
  PersonDongCodeList.Free;
  PersonAreaCodeList.Free;

  Action := caFree;
end;

procedure TfmPersonCardPermit.FormCreate(Sender: TObject);
begin

  ListDongCodeList := TStringList.Create;
  ListAreaCodeList := TStringList.Create;
  AddPermitDongCodeList := TStringList.Create;
  AddPermitAreaCodeList := TStringList.Create;
  DeletePermitDongCodeList := TStringList.Create;
  DeletePermitAreaCodeList := TStringList.Create;
  PersonDongCodeList := TStringList.Create;
  PersonAreaCodeList := TStringList.Create;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);

  LoadChildCode(FillZeroNumber(0,G_nBuildingCodeLength),1,cmb_ListDongCode,ListDongCodeList,True);
  LoadChildCode('',2,cmb_ListAreaCode,ListAreaCodeList,True);

  AdvSmoothPanel3.Align := alClient;
  AdvSmoothPanel6.Align := alClient;
  AdvSmoothPanel8.Align := alClient;
end;


procedure TfmPersonCardPermit.FormShow(Sender: TObject);
begin

  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMPERSONCARDPERMIT);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
end;

procedure TfmPersonCardPermit.Form_Close;
begin
  Close;
end;


procedure TfmPersonCardPermit.LoadChildCode(aParentCode: string; aPosition: integer;
  cmbBox: TComboBox; aList: TStringList; aAll: Boolean);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  cmbBox.Items.Clear;
  aList.Clear;
  if aAll then
  begin
    cmbBox.Items.Add('전체');
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


procedure TfmPersonCardPermit.menuTabChange(Sender: TObject);
var
  stBuildingCode : string;
  stAreaCode : string;
  nIndex : integer;
begin
  if menuTab.ActiveTabIndex = 0 then //Ȩ
  begin
    if menuTab.AdvOfficeTabs.Items[0].Caption = '닫기' then Close
    else
    begin
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
    end;
  end else if menuTab.ActiveTabIndex = 1 then
  begin
    menuTab.AdvOfficeTabs.Items[0].Caption := '닫기';
    pan_PackagePermitAdd.Visible := False;
    pan_PackagePermitDelete.Visible := False;
    pan_PersonPermit.Visible := False;
    pan_CardList.Visible := True;
    pan_CardList.Align := alClient;
  end else if menuTab.ActiveTabIndex = 2 then
  begin
    if L_nCheckCount < 1 then
    begin
      showmessage(MSGNOTSELECTDATAERROR);
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
      Exit;
    end;
    menuTab.AdvOfficeTabs.Items[0].Caption := '이전';
    pan_CardList.Visible := False;
    pan_PackagePermitDelete.Visible := False;
    pan_PersonPermit.Visible := False;
    pan_PackagePermitAdd.Visible := True;
    pan_PackagePermitAdd.Align := alClient;
    //PackagePermitCardListInitialize(lv_packagePermitAddCardList);
    LoadChildCode(FillZeroNumber(0,G_nBuildingCodeLength),1,cmb_addPermitDongCode,AddPermitDongCodeList,True);
    LoadChildCode('',2,cmb_addPermitAreaCode,AddPermitAreaCodeList,True);
    SearchAddPermitDoor;
  end else if menuTab.ActiveTabIndex = 3 then
  begin
    if L_nCheckCount < 1 then
    begin
      showmessage(MSGNOTSELECTDATAERROR);
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
      Exit;
    end;
    menuTab.AdvOfficeTabs.Items[0].Caption := '이전';
    pan_PackagePermitAdd.Visible := False;
    pan_CardList.Visible := False;
    pan_PersonPermit.Visible := False;
    pan_PackagePermitDelete.Visible := True;
    pan_PackagePermitDelete.Align := alClient;
    //PackagePermitCardListInitialize(lv_packagePermitDeleteCardList);
    LoadChildCode(FillZeroNumber(0,G_nBuildingCodeLength),1,cmb_deletePermitDongCode,DeletePermitDongCodeList,True);
    LoadChildCode('',2,cmb_deletePermitAreaCode,DeletePermitAreaCodeList,True);
    SearchDeletePermitDoor;
  end;
end;

procedure TfmPersonCardPermit.mn_addpermitListDeleteClick(Sender: TObject);
var
  stCardNo : string;
  i : integer;
begin
  Try
    if lv_packagePermitAddCardList.SelCount < 1 then Exit;
    for i := lv_packagePermitAddCardList.Items.Count - 1 downto 0 do
    begin
      if lv_packagePermitAddCardList.Items[i].Selected then
      begin
        stCardNo:= lv_packagePermitAddCardList.Items[i].SubItems.Strings[0];
        lv_packagePermitAddCardList.Items[i].Delete;
      end;
    end;
  Except
    Exit;
  End;

end;

procedure TfmPersonCardPermit.PackagePermitCardListAdd(aCardNo,
  aCardName: string; aCardList: TAdvListView);
begin
  aCardList.Items.Add.Caption := aCardName ;
  aCardList.Items[aCardList.Items.Count - 1].SubItems.Add(aCardNo);
  aCardList.Items[aCardList.Items.Count - 1].ImageIndex := 0;
  aCardList.ViewStyle := vsList;
  aCardList.Refresh;
  aCardList.ViewStyle := vsIcon ;
end;

procedure TfmPersonCardPermit.PackagePermitCardListInitialize(
  aCardList: TAdvListView);
var
  i : integer;
  bChkState : Boolean;
  stCardNo : string;
  stCardName : string;
begin

  aCardList.Clear;
  with sg_CardList do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bChkState);
      if bChkState then
      begin
        stCardNo := Cells[5,i];
        stCardName := Cells[4,i];
        PackagePermitCardListAdd(stCardNo,stCardName,aCardList);
      end;
    end;
  end;
end;

procedure TfmPersonCardPermit.pan_NotPermitDoorResize(Sender: TObject);
begin
  inherited;
  sg_NotPermitDoorList.Width := pan_NotPermitDoor.Width - 20;
  sg_NotPermitDoorList.Height := pan_NotPermitDoor.Height - sg_NotPermitDoorList.Top - 20;
end;

procedure TfmPersonCardPermit.pan_PermitDoorResize(Sender: TObject);
begin
  inherited;
  sg_PermitDoorList.Width := pan_PermitDoor.Width - 20;
  sg_PermitDoorList.Height := pan_PermitDoor.Height - sg_PermitDoorList.Top - 20;

end;

procedure TfmPersonCardPermit.pan_PersonDoorResize(Sender: TObject);
begin
  inherited;
  pan_NotPermitDoor.Width := (pan_PersonDoor.Width div 2) - 75;
  pan_PermitDoor.Width := (pan_PersonDoor.Width div 2) - 75;

end;

procedure TfmPersonCardPermit.SearchAddList;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_addCardList,4,2,False);
  if Trim( ed_addSearchName.Text ) = '' then Exit;

  stSql := 'SELECT a.*,b.BC_NAME as DONGNAME,c.BC_NAME as AREANAME FROM ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' TB_CARD a ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 1) b';
  stSql := stsql + ' ON (a.GROUP_CODE = b.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 2) c ';
  stSql := stsql + ' ON (a.GROUP_CODE = c.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_PARENTCODE) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = c.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + '  Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if ed_addSearchName.Text <> '' then
  begin
    stSql := stSql + ' AND a.CA_NAME Like ''%' + ed_addSearchName.Text + '%'' ';
  end;
  stSql := stSql + ' ORDER BY a.idx  ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_addCardList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          cells[0,nRow] := FindField('DONGNAME').AsString;
          cells[1,nRow] := FindField('AREANAME').AsString;
          cells[2,nRow] := FindField('CA_POSITION').AsString;
          cells[3,nRow] := FindField('CA_NAME').AsString;
          cells[4,nRow] := FindField('CA_CARDNO').AsString;
          cells[5,nRow] := FindField('CA_TELNUM').AsString;
          cells[6,nRow] := FindField('CA_ACCPERMIT').AsString;
          cells[7,nRow] := FindField('BC_PARENTCODE').AsString;
          cells[8,nRow] := FindField('BC_CHILDCODE').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmPersonCardPermit.SearchAddPermitDoor;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_addPermitDoorList,4,2,true);
  L_nAddDoorCheckCount := 0;

  stSql := 'SELECT a.*,b.BC_NAME as DONGNAME,c.BC_NAME as AREANAME,d.ND_NAME FROM ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' TB_DOOR a ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 1) b';
  stSql := stsql + ' ON (a.GROUP_CODE = b.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 2) c ';
  stSql := stsql + ' ON (a.GROUP_CODE = c.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_PARENTCODE) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = c.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join TB_NODE d ';
  stSql := stsql + ' ON (a.GROUP_CODE = d.GROUP_CODE )';
  stSql := stSql + ' AND (a.ND_NODENO = d.ND_NODENO) ';
  stSql := stSql + ' ) ';
  stSql := stSql + '  Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_addPermitDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_PARENTCODE = ''' + AddPermitDongCodeList.Strings[cmb_addPermitDongCode.ItemIndex] + ''' ';
  end;
  if cmb_addPermitAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_CHILDCODE = ''' + AddPermitAreaCodeList.Strings[cmb_addPermitAreaCode.ItemIndex] + ''' ';
  end;
  stSql := stSql + ' ORDER BY a.idx  ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_addPermitDoorList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DONGNAME').AsString;
          cells[2,nRow] := FindField('AREANAME').AsString;
          cells[3,nRow] := FindField('DO_NAME').AsString;
          cells[4,nRow] := FindField('ND_NODENO').AsString;
          cells[5,nRow] := FindField('DE_DEVICEID').AsString;
          cells[6,nRow] := FindField('DO_DOORNO').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;


end;

procedure TfmPersonCardPermit.SearchDeleteList;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_deleteCardList,4,2,False);
  if Trim( ed_deleteSearchName.Text ) = '' then Exit;

  stSql := 'SELECT a.*,b.BC_NAME as DONGNAME,c.BC_NAME as AREANAME FROM ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' TB_CARD a ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 1) b';
  stSql := stsql + ' ON (a.GROUP_CODE = b.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 2) c ';
  stSql := stsql + ' ON (a.GROUP_CODE = c.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_PARENTCODE) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = c.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + '  Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if ed_deleteSearchName.Text <> '' then
  begin
    stSql := stSql + ' AND a.CA_NAME Like ''%' + ed_deleteSearchName.Text + '%'' ';
  end;
  stSql := stSql + ' ORDER BY a.idx  ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_deleteCardList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          cells[0,nRow] := FindField('DONGNAME').AsString;
          cells[1,nRow] := FindField('AREANAME').AsString;
          cells[2,nRow] := FindField('CA_POSITION').AsString;
          cells[3,nRow] := FindField('CA_NAME').AsString;
          cells[4,nRow] := FindField('CA_CARDNO').AsString;
          cells[5,nRow] := FindField('CA_TELNUM').AsString;
          cells[6,nRow] := FindField('CA_ACCPERMIT').AsString;
          cells[7,nRow] := FindField('BC_PARENTCODE').AsString;
          cells[8,nRow] := FindField('BC_CHILDCODE').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmPersonCardPermit.SearchDeletePermitDoor;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_deletePermitDoorList,4,2,true);
  L_nDeleteDoorCheckCount := 0;

  stSql := 'SELECT a.*,b.BC_NAME as DONGNAME,c.BC_NAME as AREANAME,d.ND_NAME FROM ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' TB_DOOR a ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 1) b';
  stSql := stsql + ' ON (a.GROUP_CODE = b.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 2) c ';
  stSql := stsql + ' ON (a.GROUP_CODE = c.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_PARENTCODE) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = c.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join TB_NODE d ';
  stSql := stsql + ' ON (a.GROUP_CODE = d.GROUP_CODE )';
  stSql := stSql + ' AND (a.ND_NODENO = d.ND_NODENO) ';
  stSql := stSql + ' ) ';
  stSql := stSql + '  Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_DeletePermitDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_PARENTCODE = ''' + DeletePermitDongCodeList.Strings[cmb_DeletePermitDongCode.ItemIndex] + ''' ';
  end;
  if cmb_DeletePermitAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_CHILDCODE = ''' + DeletePermitAreaCodeList.Strings[cmb_DeletePermitAreaCode.ItemIndex] + ''' ';
  end;
  stSql := stSql + ' ORDER BY a.idx  ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_deletePermitDoorList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DONGNAME').AsString;
          cells[2,nRow] := FindField('AREANAME').AsString;
          cells[3,nRow] := FindField('DO_NAME').AsString;
          cells[4,nRow] := FindField('ND_NODENO').AsString;
          cells[5,nRow] := FindField('DE_DEVICEID').AsString;
          cells[6,nRow] := FindField('DO_DOORNO').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmPersonCardPermit.SearchDoorPermit(aCardNo: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_PermitDoorList,3,2,true);
  L_nPermitDoorCheckCount := 0;

  stSql := ' Select a.*,b.DE_RCVACK from TB_DOOR a ';
  stSql := stSql + ' Inner Join (select * from TB_DEVICECARDNO ';
  stSql := stSql + ' Where DE_PERMIT = ''L'' ';
  stSql := stSql + ' AND DE_DOOR1 = ''Y'' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''') b ';
  stSql := stSql + ' ON(a.GROUP_CODE = b.GROUP_CODE ';
  stSql := stSql + ' AND a.ND_NODENO = b.ND_NODENO ';
  stSql := stSql + ' AND a.DE_DEVICEID = b.DE_DEVICEID ) ';
  stSql := stSql + ' Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_PersonDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_PARENTCODE = ''' + PersonDongCodeList.Strings[cmb_PersonDongCode.ItemIndex] + ''' ';
  end;
  if cmb_PersonAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_CHILDCODE = ''' + PersonAreaCodeList.Strings[cmb_PersonAreaCode.ItemIndex] + ''' ';
  end;

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_PermitDoorList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DO_NAME').AsString;
          cells[2,nRow] := FindField('DE_RCVACK').AsString;
          cells[3,nRow] := FindField('ND_NODENO').AsString;
          cells[4,nRow] := FindField('DE_DEVICEID').AsString;
          cells[5,nRow] := FindField('DO_DOORNO').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmPersonCardPermit.SearchNotDoorPermit(aCardNo: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_NotPermitDoorList,2,2,true);
  L_nNotPermitDoorCheckCount := 0;

  stSql := ' Select * from TB_DOOR ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_PersonDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND BC_PARENTCODE = ''' + PersonDongCodeList.Strings[cmb_PersonDongCode.ItemIndex] + ''' ';
  end;
  if cmb_PersonAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND BC_CHILDCODE = ''' + PersonAreaCodeList.Strings[cmb_PersonAreaCode.ItemIndex] + ''' ';
  end;
  stSql := stSql + ' AND (Cstr(ND_NODENO) + DE_DEVICEID + Cstr(DO_DOORNO)) not in ' ;
  stSql := stSql + ' ( select (Cstr(ND_NODENO) + DE_DEVICEID + ''1'') from TB_DEVICECARDNO ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND DE_PERMIT = ''L'' ';
  stSql := stSql + ' AND DE_DOOR1 = ''Y'' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''') ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_NotPermitDoorList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DO_NAME').AsString;
          cells[2,nRow] := FindField('ND_NODENO').AsString;
          cells[3,nRow] := FindField('DE_DEVICEID').AsString;
          cells[4,nRow] := FindField('DO_DOORNO').AsString;

          nRow := nRow + 1;
          Next;
        end;
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmPersonCardPermit.sg_addCardListDblClick(Sender: TObject);
var
  stCardNo : string;
  stCardName : string;
begin
  inherited;
  with sg_addCardList do
  begin
    stCardNo := Cells[4,row];
    stCardName := Cells[3,row];
    PackagePermitCardListAdd(stCardNo,stCardName,lv_packagePermitAddCardList);
    pan_addSearch.Visible := False;
  end;

end;

procedure TfmPersonCardPermit.sg_addPermitDoorListCheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
begin
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nAddDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nAddDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nAddDoorCheckCount := L_nAddDoorCheckCount + 1
    else L_nAddDoorCheckCount := L_nAddDoorCheckCount - 1 ;
  end;

end;

procedure TfmPersonCardPermit.sg_CardListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nCheckCount := L_nCheckCount + 1
    else L_nCheckCount := L_nCheckCount - 1 ;
  end;

end;

procedure TfmPersonCardPermit.sg_CardListDblClick(Sender: TObject);
var
  nIndex : integer;
begin
  inherited;

  with sg_CardList do
  begin
    if cells[5,Row] = '' then Exit;
    lb_dong.Caption.Text := cells[1,Row];
    lb_Area.Caption.Text := cells[2,Row];
    lb_Position.Caption.Text := cells[3,Row];
    lb_Name.Caption.Text := cells[4,Row];
    lb_TelNum.Caption.Text := cells[6,Row];
    lb_CardNo.Caption.Text := cells[5,Row];
  end;
  menuTab.AdvOfficeTabs.Items[0].Caption := '이전';
  pan_PackagePermitAdd.Visible := False;
  pan_CardList.Visible := False;
  pan_PackagePermitDelete.Visible := False;
  pan_PersonPermit.Visible := True;
  pan_PersonPermit.Align := alClient;
  LoadChildCode(FillZeroNumber(0,G_nBuildingCodeLength),1,cmb_PersonDongCode,PersonDongCodeList,True);
  LoadChildCode('',2,cmb_PersonAreaCode,PersonAreaCodeList,True);
  SearchNotDoorPermit(lb_CardNo.Caption.Text);
  SearchDoorPermit(lb_CardNo.Caption.Text);
end;

procedure TfmPersonCardPermit.sg_CardListResize(Sender: TObject);
var
  i : integer;
  nColWidth : integer;
begin
  inherited;
  with sg_CardList do
  begin
    nColWidth := (width - 50) div 7;
    ColWidths[0] := 30;
    for i := 1 to ColCount - 1 do
    begin
      if ColWidths[i] <> 0 then ColWidths[i] := nColWidth;
    end;

    L_nPageListMaxCount := Height div DefaultRowHeight;
  end;
end;

procedure TfmPersonCardPermit.sg_deleteCardListDblClick(Sender: TObject);
var
  stCardNo : string;
  stCardName : string;
begin
  inherited;
  with sg_deleteCardList do
  begin
    stCardNo := Cells[4,row];
    stCardName := Cells[3,row];
    PackagePermitCardListAdd(stCardNo,stCardName,lv_packagePermitDeleteCardList);
    pan_DeleteSearch.Visible := False;
  end;

end;

procedure TfmPersonCardPermit.sg_deletePermitDoorListCheckBoxClick(
  Sender: TObject; ACol, ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nDeleteDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nDeleteDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nDeleteDoorCheckCount := L_nDeleteDoorCheckCount + 1
    else L_nDeleteDoorCheckCount := L_nDeleteDoorCheckCount - 1 ;
  end;

end;

procedure TfmPersonCardPermit.sg_NotPermitDoorListCheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nNotPermitDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nNotPermitDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nNotPermitDoorCheckCount := L_nNotPermitDoorCheckCount + 1
    else L_nNotPermitDoorCheckCount := L_nNotPermitDoorCheckCount - 1 ;
  end;

end;

procedure TfmPersonCardPermit.sg_NotPermitDoorListResize(Sender: TObject);
begin
  inherited;
  TAdvStringGrid(Sender).ColWidths[1] := TAdvStringGrid(Sender).Width - 55;
end;

procedure TfmPersonCardPermit.sg_PermitDoorListCheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nPermitDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nPermitDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nPermitDoorCheckCount := L_nPermitDoorCheckCount + 1
    else L_nPermitDoorCheckCount := L_nPermitDoorCheckCount - 1 ;
  end;

end;

procedure TfmPersonCardPermit.sg_PermitDoorListResize(Sender: TObject);
begin
  inherited;
  TAdvStringGrid(Sender).ColWidths[2] := 35;
  TAdvStringGrid(Sender).ColWidths[1] := TAdvStringGrid(Sender).Width - 55 - TAdvStringGrid(Sender).ColWidths[2];

end;

procedure TfmPersonCardPermit.ShowCardList(aCurrentCode, aCardNo: string;
  aTopRow: integer);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_CardList,8,2,true);
  L_nCheckCount := 0;

  stSql := 'SELECT a.*,b.BC_NAME as DONGNAME,c.BC_NAME as AREANAME FROM ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' (  ';
  stSql := stSql + ' TB_CARD a ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 1) b';
  stSql := stsql + ' ON (a.GROUP_CODE = b.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = b.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + ' Left Join (select * from TB_BUILDINGCODE where BC_POSITION = 2) c ';
  stSql := stsql + ' ON (a.GROUP_CODE = c.GROUP_CODE )';
  stSql := stSql + ' AND (a.BC_PARENTCODE = c.BC_PARENTCODE) ';
  stSql := stSql + ' AND (a.BC_CHILDCODE = c.BC_CHILDCODE) ';
  stSql := stSql + ' ) ';
  stSql := stSql + '  Where a.GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_ListDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_PARENTCODE = ''' + ListDongCodeList.Strings[cmb_ListDongCode.ItemIndex] + ''' ';
  end;
  if cmb_ListAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND a.BC_CHILDCODE = ''' + ListAreaCodeList.Strings[cmb_ListAreaCode.ItemIndex] + ''' ';
  end;
  if ed_name.Text <> '' then
  begin
    stSql := stSql + ' AND a.CA_NAME Like ''%' + ed_name.Text + '%'' ';
  end;
  if aCardNo <> '' then stSql := stSql + ' AND a.CA_CARDNO = ''' + aCardNo + ''' ';
  stSql := stSql + ' ORDER BY a.idx  ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sg_CardList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DONGNAME').AsString;
          cells[2,nRow] := FindField('AREANAME').AsString;
          cells[3,nRow] := FindField('CA_POSITION').AsString;
          cells[4,nRow] := FindField('CA_NAME').AsString;
          cells[5,nRow] := FindField('CA_CARDNO').AsString;
          cells[6,nRow] := FindField('CA_TELNUM').AsString;
          cells[7,nRow] := FindField('CA_ACCPERMIT').AsString;
          cells[8,nRow] := FindField('BC_PARENTCODE').AsString;
          cells[9,nRow] := FindField('BC_CHILDCODE').AsString;
          if (FindField('CA_CARDNO').AsString )  = aCurrentCode then
          begin
            SelectRows(nRow,1);
          end;

          nRow := nRow + 1;
          Next;
        end;
        if aTopRow = 0 then
        begin
          if Row > (L_nPageListMaxCount - 1) then TopRow := Row - L_nPageListMaxCount;
        end else
        begin
          TopRow := aTopRow;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmPersonCardPermit.btn_PackagePermitAddClick(Sender: TObject);
begin
  inherited;
  menutab.ActiveTabIndex := 2;
  menutabChange(self);

end;

procedure TfmPersonCardPermit.btn_PackagePermitDeleteClick(Sender: TObject);
begin
  inherited;
  menutab.ActiveTabIndex := 3;
  menutabChange(self);

end;

initialization
  RegisterClass(TfmPersonCardPermit);
Finalization
  UnRegisterClass(TfmPersonCardPermit);

end.