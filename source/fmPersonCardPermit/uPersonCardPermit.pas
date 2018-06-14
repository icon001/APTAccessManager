unit uPersonCardPermit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, W7Classes, W7Panels, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvSmoothPanel, Vcl.ExtCtrls, AdvSmoothLabel,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvToolBtn,ADODB,ActiveX, uSubForm, CommandArray, AdvCombo, AdvGroupBox,
  Vcl.Mask, AdvSpin, AdvOfficeButtons, AdvPanel, Vcl.ComCtrls, AdvListV,
  Vcl.ImgList, Vcl.Menus, AdvMenus, Vcl.Samples.Gauges, AdvToolBar,
  AdvToolBarStylers, AdvAppStyler;

type
  TfmPersonCardPermit = class(TfmASubForm)
    Image1: TImage;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    pan_CardList: TAdvPanel;
    pan_CardListHeader: TAdvSmoothPanel;
    btn_Search: TSpeedButton;
    lb_company: TAdvSmoothLabel;
    lb_Depart: TAdvSmoothLabel;
    ed_name: TAdvEdit;
    cmb_ListDongCode: TComboBox;
    cmb_ListAreaCode: TComboBox;
    AdvSmoothPanel1: TAdvSmoothPanel;
    btn_PackagePermitAdd: TSpeedButton;
    btn_PackagePermitDelete: TSpeedButton;
    sg_CardList: TAdvStringGrid;
    pan_PackagePermitAdd: TAdvPanel;
    pan_AddEmployee: TAdvSmoothPanel;
    lv_packagePermitAddCardList: TAdvListView;
    btn_CardPermitAddPerson: TSpeedButton;
    ImageList1: TImageList;
    pan_addSearch: TAdvSmoothPanel;
    sg_addCardList: TAdvStringGrid;
    ed_addSearchName: TAdvEdit;
    btn_addCancel: TSpeedButton;
    pop_PermitAdd: TAdvPopupMenu;
    mn_addpermitListDelete: TMenuItem;
    pan_DoorInfoAdd: TAdvSmoothPanel;
    lb_Company4: TAdvSmoothLabel;
    cmb_addPermitDongCode: TComboBox;
    cmb_addPermitAreaCode: TComboBox;
    lb_Depart4: TAdvSmoothLabel;
    sg_addPermitDoorList: TAdvStringGrid;
    btn_DoorPermitAdd: TSpeedButton;
    pan_PackagePermitDelete: TAdvPanel;
    pan_DelEmpState: TAdvSmoothPanel;
    btn_CardPermitDeletePerson: TSpeedButton;
    lv_packagePermitDeleteCardList: TAdvListView;
    pan_deleteSearch: TAdvSmoothPanel;
    btn_deleteCancel: TSpeedButton;
    sg_deleteCardList: TAdvStringGrid;
    ed_deleteSearchName: TAdvEdit;
    pan_DoorInfo: TAdvSmoothPanel;
    lb_Company3: TAdvSmoothLabel;
    lb_Depart3: TAdvSmoothLabel;
    btn_DoorPermitDelete: TSpeedButton;
    cmb_deletePermitDongCode: TComboBox;
    cmb_deletePermitAreaCode: TComboBox;
    sg_deletePermitDoorList: TAdvStringGrid;
    pan_PersonPermit: TAdvPanel;
    pan_Eminfo: TAdvSmoothPanel;
    pan_AccessGrade1: TAdvSmoothPanel;
    lb_Company2: TAdvSmoothLabel;
    lb_Depart2: TAdvSmoothLabel;
    cmb_PersonDongCode: TComboBox;
    cmb_PersonAreaCode: TComboBox;
    gb_Company1: TAdvGroupBox;
    gb_Employee1: TAdvGroupBox;
    lb_Company1: TAdvSmoothLabel;
    lb_Depart1: TAdvSmoothLabel;
    lb_posi1: TAdvSmoothLabel;
    lb_dong: TAdvSmoothLabel;
    lb_area: TAdvSmoothLabel;
    lb_Position: TAdvSmoothLabel;
    lb_Name1: TAdvSmoothLabel;
    lb_Name: TAdvSmoothLabel;
    lb_Phone1: TAdvSmoothLabel;
    lb_TelNum: TAdvSmoothLabel;
    lb_CardNo1: TAdvSmoothLabel;
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
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    PopupMenu1: TPopupMenu;
    pm_update: TMenuItem;
    cmb_EtcSearch1: TComboBox;
    cmb_EtcSearch2: TComboBox;
    ed_EtcSearch: TAdvEdit;
    Gauge1: TGauge;
    cmb_Condition1: TAdvComboBox;
    cmb_Condition2: TAdvComboBox;
    AdvFormStyler1: TAdvFormStyler;
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
    procedure pan_AddEmployeeResize(Sender: TObject);
    procedure btn_CardPermitAddPersonClick(Sender: TObject);
    procedure btn_addCancelClick(Sender: TObject);
    procedure ed_addSearchNameChange(Sender: TObject);
    procedure sg_addCardListDblClick(Sender: TObject);
    procedure mn_addpermitListDeleteClick(Sender: TObject);
    procedure pan_DoorInfoAddResize(Sender: TObject);
    procedure cmb_addPermitDongCodeChange(Sender: TObject);
    procedure cmb_addPermitAreaCodeChange(Sender: TObject);
    procedure sg_addPermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure btn_DoorPermitAddClick(Sender: TObject);
    procedure pan_DelEmpStateResize(Sender: TObject);
    procedure btn_deleteCancelClick(Sender: TObject);
    procedure ed_deleteSearchNameChange(Sender: TObject);
    procedure sg_deleteCardListDblClick(Sender: TObject);
    procedure btn_CardPermitDeletePersonClick(Sender: TObject);
    procedure cmb_deletePermitDongCodeChange(Sender: TObject);
    procedure cmb_deletePermitAreaCodeChange(Sender: TObject);
    procedure pan_DoorInfoResize(Sender: TObject);
    procedure btn_DoorPermitDeleteClick(Sender: TObject);
    procedure sg_deletePermitDoorListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure btn_PackagePermitAddClick(Sender: TObject);
    procedure btn_PackagePermitDeleteClick(Sender: TObject);
    procedure sg_CardListDblClick(Sender: TObject);
    procedure pan_AccessGrade1Resize(Sender: TObject);
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
    procedure pm_updateClick(Sender: TObject);
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
    procedure FormNameSetting;
    procedure FontSetting;
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
  udmCardPermit,
  uFormFontUtil;

{$R *.dfm}


procedure TfmPersonCardPermit.AdvSmoothPanel10Resize(Sender: TObject);
begin
  inherited;
  btn_CardPermitAdd.Top := (AdvSmoothPanel10.Height div 2) - btn_CardPermitAdd.Height - 20;
  btn_CardPermitAdd.Left := (AdvSmoothPanel10.Width div 2) - (btn_CardPermitAdd.Width div 2);
  btn_CardPermitDelete.Top := (AdvSmoothPanel10.Height div 2) + 20;
  btn_CardPermitDelete.Left := (AdvSmoothPanel10.Width div 2) - (btn_CardPermitDelete.Width div 2);

  Gauge1.Top := btn_CardPermitDelete.Top + btn_CardPermitDelete.Height + 20;
  Gauge1.Left := (AdvSmoothPanel10.Width div 2) - (Gauge1.Width div 2);
end;

procedure TfmPersonCardPermit.pan_AddEmployeeResize(Sender: TObject);
begin
  inherited;
  lv_packagePermitAddCardList.Width := pan_AddEmployee.Width - 200;

  pan_addSearch.Left := btn_CardPermitAddPerson.Left - pan_addSearch.Width;
  //pan_addSearch.Left := lv_packagePermitAddCardList.Width - pan_addSearch.Width;
end;

procedure TfmPersonCardPermit.pan_DoorInfoAddResize(Sender: TObject);
begin
  inherited;
  sg_addPermitDoorList.Height := pan_DoorInfoAdd.Height - sg_addPermitDoorList.Top;
  sg_addPermitDoorList.Width := pan_DoorInfoAdd.Width - 20;
end;

procedure TfmPersonCardPermit.pan_DelEmpStateResize(Sender: TObject);
begin
  inherited;
  lv_packagePermitDeleteCardList.Width := pan_DelEmpState.Width - 200;

  pan_deleteSearch.Left := btn_CardPermitDeletePerson.Left - pan_deleteSearch.Width;

end;

procedure TfmPersonCardPermit.pan_DoorInfoResize(Sender: TObject);
begin
  inherited;
  sg_DeletePermitDoorList.Height := pan_DoorInfo.Height - sg_DeletePermitDoorList.Top;
  sg_DeletePermitDoorList.Width := pan_DoorInfo.Width - 20;

end;

procedure TfmPersonCardPermit.pan_AccessGrade1Resize(Sender: TObject);
begin
  inherited;
  pan_PersonDoor.Height := pan_AccessGrade1.Height - pan_PersonDoor.Top - 20;
  pan_PersonDoor.Width := pan_AccessGrade1.Width - 40;
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
    showmessage(dmFormName.GetFormMessage('2','M00027'));
    Exit;
  end;

  with sg_NotPermitDoorList do
  begin
    Gauge1.Visible := True;
    Gauge1.Progress := 0;
    Gauge1.MaxValue := RowCount;
    for i := 1 to RowCount - 1 do
    begin
      Gauge1.Progress := i;
      GetCheckBoxState(0,i, bchkState);
      if bchkState then
      begin
        stNodeNo := Cells[2,i];
        stDeviceID := Cells[3,i];
        stDoorNo := Cells[4,i];
        dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'L');
      end;
    end;
    Gauge1.Visible := False;
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
    showmessage(dmFormName.GetFormMessage('2','M00031'));
    Exit;
  end;

  with sg_PermitDoorList do
  begin
    Gauge1.Visible := True;
    Gauge1.Progress := 0;
    Gauge1.MaxValue := RowCount;
    for i := 1 to RowCount - 1 do
    begin
      Gauge1.Progress := i;
      GetCheckBoxState(0,i, bchkState);
      if bchkState then
      begin
        stNodeNo := Cells[3,i];
        stDeviceID := Cells[4,i];
        stDoorNo := Cells[5,i];
        dmCardPermit.CardPermitRegist(stCardNo,stNodeNo,stDeviceID,stDoorNo,'N');
      end;
    end;
    Gauge1.Visible := False;
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
  if L_nAddDoorCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00032'));
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
  showmessage(dmFormName.GetFormMessage('2','M00049'));
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
  if L_nDeleteDoorCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00035'));
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
  showmessage(dmFormName.GetFormMessage('2','M00050'));
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

procedure TfmPersonCardPermit.FontSetting;
begin
  dmFormFontUtil.TravelFormFontSetting(self,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.TravelAdvOfficeTabSetOfficeStylerFontSetting(AdvOfficeTabSetOfficeStyler1, G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.FormAdvOfficeTabSetOfficeStylerSetting(AdvOfficeTabSetOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormStyleSetting(self,AdvToolBarOfficeStyler1);

end;

procedure TfmPersonCardPermit.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
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

  pan_DoorInfoAdd.Align := alClient;
  pan_DoorInfo.Align := alClient;
  pan_AccessGrade1.Align := alClient;
  FontSetting;
end;


procedure TfmPersonCardPermit.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('1','M00018');
  menuTab.AdvOfficeTabs[0].Caption := dmFormName.GetFormMessage('1','M00035');
  menuTab.AdvOfficeTabs[1].Caption := dmFormName.GetFormMessage('1','M00018');
  menuTab.AdvOfficeTabs[2].Caption := dmFormName.GetFormMessage('1','M00051');
  menuTab.AdvOfficeTabs[3].Caption := dmFormName.GetFormMessage('1','M00052');
  pan_CardListHeader.Caption.Text := dmFormName.GetFormMessage('4','M00079');
  lb_company.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  btn_Search.Caption := dmFormName.GetFormMessage('4','M00007');
  btn_PackagePermitAdd.Caption := dmFormName.GetFormMessage('1','M00051');
  btn_PackagePermitDelete.Caption := dmFormName.GetFormMessage('1','M00052');
  pm_update.Caption := dmFormName.GetFormMessage('1','M00018');
  with sg_CardList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00004');
    cells[2,0] := dmFormName.GetFormMessage('4','M00005');
    cells[3,0] := dmFormName.GetFormMessage('4','M00018');
    cells[4,0] := dmFormName.GetFormMessage('4','M00006');
    cells[5,0] := dmFormName.GetFormMessage('4','M00012');
    cells[6,0] := dmFormName.GetFormMessage('4','M00019');
    cells[7,0] := dmFormName.GetFormMessage('4','M00011');
    cells[8,0] := dmFormName.GetFormMessage('4','M00080');
    Hint := dmFormName.GetFormMessage('2','M00012');
  end;

  pan_Eminfo.Caption.Text := dmFormName.GetFormMessage('4','M00055');
  gb_Company1.Caption := dmFormName.GetFormMessage('4','M00041');
  gb_Employee1.Caption := dmFormName.GetFormMessage('4','M00055');
  lb_Company1.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart1.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  lb_posi1.Caption.Text := dmFormName.GetFormMessage('4','M00018');
  lb_Name1.Caption.Text := dmFormName.GetFormMessage('4','M00006');
  lb_Phone1.Caption.Text := dmFormName.GetFormMessage('4','M00019');
  lb_CardNo1.Caption.Text := dmFormName.GetFormMessage('4','M00012');
  pan_AccessGrade1.Caption.Text := dmFormName.GetFormMessage('4','M00046');
  lb_Company2.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart2.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  pan_NotPermitDoor.Caption.Text := dmFormName.GetFormMessage('4','M00081');
  pan_PermitDoor.Caption.Text := dmFormName.GetFormMessage('4','M00082');
  with sg_NotPermitDoorList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00002');
    cells[2,0] := dmFormName.GetFormMessage('4','M00036');
    cells[3,0] := dmFormName.GetFormMessage('4','M00037');
    cells[4,0] := dmFormName.GetFormMessage('4','M00038');
  end;
  with sg_PermitDoorList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00002');
    cells[2,0] := dmFormName.GetFormMessage('4','M00022');
    cells[3,0] := dmFormName.GetFormMessage('4','M00036');
    cells[4,0] := dmFormName.GetFormMessage('4','M00037');
    cells[5,0] := dmFormName.GetFormMessage('4','M00038');
  end;
  pan_DelEmpState.Caption.Text := dmFormName.GetFormMessage('4','M00083');
  pan_deleteSearch.Caption.Text := dmFormName.GetFormMessage('4','M00084');
  btn_CardPermitDeletePerson.Caption := dmFormName.GetFormMessage('4','M00085');
  btn_deleteCancel.Caption := dmFormName.GetFormMessage('4','M00051');
  with sg_deleteCardList do
  begin
    cells[0,0] := dmFormName.GetFormMessage('4','M00004');
    cells[1,0] := dmFormName.GetFormMessage('4','M00005');
    cells[2,0] := dmFormName.GetFormMessage('4','M00018');
    cells[3,0] := dmFormName.GetFormMessage('4','M00006');
    cells[4,0] := dmFormName.GetFormMessage('4','M00012');
    cells[5,0] := dmFormName.GetFormMessage('4','M00019');
    cells[6,0] := dmFormName.GetFormMessage('4','M00080');

    Hint := dmFormName.GetFormMessage('2','M00029');
  end;
  pan_DoorInfo.Caption.Text := dmFormName.GetFormMessage('4','M00044');
  lb_Company3.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart3.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  btn_DoorPermitDelete.Caption := dmFormName.GetFormMessage('4','M00053');
  with sg_deletePermitDoorList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00004');
    cells[2,0] := dmFormName.GetFormMessage('4','M00005');
    cells[3,0] := dmFormName.GetFormMessage('4','M00002');
    cells[4,0] := dmFormName.GetFormMessage('4','M00036');
    cells[5,0] := dmFormName.GetFormMessage('4','M00037');
    cells[6,0] := dmFormName.GetFormMessage('4','M00038');
  end;
  pan_AddEmployee.Caption.Text := dmFormName.GetFormMessage('4','M00086');
  pan_DoorInfoAdd.Caption.Text := dmFormName.GetFormMessage('4','M00044');
  pan_addSearch.Caption.Text := dmFormName.GetFormMessage('4','M00084');
  btn_addCancel.Caption := dmFormName.GetFormMessage('4','M00051');
  btn_CardPermitAddPerson.Caption := dmFormName.GetFormMessage('4','M00085');
  with sg_addCardList do
  begin
    cells[0,0] := dmFormName.GetFormMessage('4','M00004');
    cells[1,0] := dmFormName.GetFormMessage('4','M00005');
    cells[2,0] := dmFormName.GetFormMessage('4','M00018');
    cells[3,0] := dmFormName.GetFormMessage('4','M00006');
    cells[4,0] := dmFormName.GetFormMessage('4','M00012');
    cells[5,0] := dmFormName.GetFormMessage('4','M00019');
    cells[6,0] := dmFormName.GetFormMessage('4','M00080');

    Hint := dmFormName.GetFormMessage('2','M00029');
  end;
  lb_Company4.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart4.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  btn_DoorPermitAdd.Caption := dmFormName.GetFormMessage('4','M00056');
  with sg_addPermitDoorList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00004');
    cells[2,0] := dmFormName.GetFormMessage('4','M00005');
    cells[3,0] := dmFormName.GetFormMessage('4','M00002');
    cells[4,0] := dmFormName.GetFormMessage('4','M00036');
    cells[5,0] := dmFormName.GetFormMessage('4','M00037');
    cells[6,0] := dmFormName.GetFormMessage('4','M00038');
  end;
  mn_addpermitListDelete.Caption := dmFormName.GetFormMessage('4','M00065');
  btn_CardPermitAdd.Hint := dmFormName.GetFormMessage('4','M00101');
  btn_CardPermitDelete.Hint := dmFormName.GetFormMessage('4','M00102');

  cmb_EtcSearch1.Clear;
  cmb_EtcSearch1.Items.Add(dmFormName.GetFormMessage('4','M00006'));
  cmb_EtcSearch1.Items.Add(dmFormName.GetFormMessage('4','M00018'));
  cmb_EtcSearch1.Items.Add(dmFormName.GetFormMessage('4','M00011'));
  cmb_EtcSearch1.Items.Add(dmFormName.GetFormMessage('4','M00019'));
  cmb_EtcSearch1.ItemIndex := 0;

  cmb_EtcSearch2.Clear;
  cmb_EtcSearch2.Items.Add(dmFormName.GetFormMessage('4','M00006'));
  cmb_EtcSearch2.Items.Add(dmFormName.GetFormMessage('4','M00018'));
  cmb_EtcSearch2.Items.Add(dmFormName.GetFormMessage('4','M00011'));
  cmb_EtcSearch2.Items.Add(dmFormName.GetFormMessage('4','M00019'));
  cmb_EtcSearch2.ItemIndex := 1;

  cmb_Condition1.Clear;
  cmb_Condition1.Items.Add(dmFormName.GetFormMessage('4','M00137'));
  cmb_Condition1.Items.Add(dmFormName.GetFormMessage('4','M00138'));
  cmb_Condition1.Items.Add(dmFormName.GetFormMessage('4','M00139'));
  cmb_Condition1.ItemIndex := 0;
  cmb_Condition2.Clear;
  cmb_Condition2.Items.Add(dmFormName.GetFormMessage('4','M00137'));
  cmb_Condition2.Items.Add(dmFormName.GetFormMessage('4','M00138'));
  cmb_Condition2.Items.Add(dmFormName.GetFormMessage('4','M00139'));
  cmb_Condition2.ItemIndex := 0;
end;

procedure TfmPersonCardPermit.FormShow(Sender: TObject);
begin
  FormNameSetting;
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMPERSONCARDPERMIT);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
  btn_SearchClick(self);
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


procedure TfmPersonCardPermit.menuTabChange(Sender: TObject);
var
  stBuildingCode : string;
  stAreaCode : string;
  nIndex : integer;
begin
  if menuTab.ActiveTabIndex = 0 then //Ȩ
  begin
    if menuTab.AdvOfficeTabs.Items[0].Caption = dmFormName.GetFormMessage('1','M00035') then Close
    else
    begin
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
    end;
  end else if menuTab.ActiveTabIndex = 1 then
  begin
    menuTab.AdvOfficeTabs.Items[0].Caption := dmFormName.GetFormMessage('1','M00035');
    pan_PackagePermitAdd.Visible := False;
    pan_PackagePermitDelete.Visible := False;
    pan_PersonPermit.Visible := False;
    pan_CardList.Visible := True;
    pan_CardList.Align := alClient;
  end else if menuTab.ActiveTabIndex = 2 then
  begin
    if L_nCheckCount < 1 then
    begin
      showmessage(dmFormName.GetFormMessage('2','M00016'));
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
      Exit;
    end;
    menuTab.AdvOfficeTabs.Items[0].Caption := dmFormName.GetFormMessage('1','M00040');
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
      showmessage(dmFormName.GetFormMessage('2','M00016'));
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
      Exit;
    end;
    menuTab.AdvOfficeTabs.Items[0].Caption := dmFormName.GetFormMessage('1','M00040');
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

procedure TfmPersonCardPermit.pm_updateClick(Sender: TObject);
begin
  inherited;
  sg_CardListDblClick(sg_CardList);
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
  menuTab.AdvOfficeTabs.Items[0].Caption := dmFormName.GetFormMessage('1','M00040');
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
(*  with sg_CardList do
  begin
    nColWidth := (width - 50) div 7;
    ColWidths[0] := 30;
    for i := 1 to ColCount - 1 do
    begin
      if ColWidths[i] <> 0 then ColWidths[i] := nColWidth;
    end;

    L_nPageListMaxCount := Height div DefaultRowHeight;
  end; *)
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
  GridInit(sg_CardList,9,2,true);
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
    if cmb_EtcSearch1.ItemIndex = 0 then
    begin
      if cmb_Condition1.ItemIndex = 0 then stSql := stSql + ' AND a.CA_NAME = ''' + ed_name.Text + ''' '
      else if cmb_Condition1.ItemIndex = 1 then stSql := stSql + ' AND a.CA_NAME Like ''%' + ed_name.Text + '%'' '
      else if cmb_Condition1.ItemIndex = 2 then stSql := stSql + ' AND a.CA_NAME Like ''' + ed_name.Text + '%'' '
      ;
    end else if cmb_EtcSearch1.ItemIndex = 1 then
    begin
      if cmb_Condition1.ItemIndex = 0 then stSql := stSql + ' AND a.CA_POSITION = ''' + ed_name.Text + ''' '
      else if cmb_Condition1.ItemIndex = 1 then stSql := stSql + ' AND a.CA_POSITION Like ''%' + ed_name.Text + '%'' '
      else if cmb_Condition1.ItemIndex = 2 then stSql := stSql + ' AND a.CA_POSITION Like ''' + ed_name.Text + '%'' '
      ;
    end else if cmb_EtcSearch1.ItemIndex = 2 then
    begin
      if cmb_Condition1.ItemIndex = 0 then stSql := stSql + ' AND a.CA_CODE = ''' + ed_name.Text + ''' '
      else if cmb_Condition1.ItemIndex = 1 then stSql := stSql + ' AND a.CA_CODE Like ''%' + ed_name.Text + '%'' '
      else if cmb_Condition1.ItemIndex = 2 then stSql := stSql + ' AND a.CA_CODE Like ''' + ed_name.Text + '%'' ';
    end else if cmb_EtcSearch1.ItemIndex = 3 then
    begin
      stSql := stSql + ' AND a.CA_TELNUM Like ''%' + ed_name.Text+ '%'' ';
    end;
  end;
  if ed_EtcSearch.Text <> '' then
  begin
    if cmb_EtcSearch2.ItemIndex = 0 then
    begin
      if cmb_Condition2.ItemIndex = 0 then stSql := stSql + ' AND a.CA_NAME = ''' + ed_EtcSearch.Text + ''' '
      else if cmb_Condition2.ItemIndex = 1 then stSql := stSql + ' AND a.CA_NAME Like ''%' + ed_EtcSearch.Text + '%'' '
      else if cmb_Condition2.ItemIndex = 2 then stSql := stSql + ' AND a.CA_NAME Like ''' + ed_EtcSearch.Text + '%'' '
      ;
    end else if cmb_EtcSearch2.ItemIndex = 1 then
    begin
      if cmb_Condition2.ItemIndex = 0 then stSql := stSql + ' AND a.CA_POSITION = ''' + ed_EtcSearch.Text + ''' '
      else if cmb_Condition2.ItemIndex = 1 then stSql := stSql + ' AND a.CA_POSITION Like ''%' + ed_EtcSearch.Text + '%'' '
      else if cmb_Condition2.ItemIndex = 2 then stSql := stSql + ' AND a.CA_POSITION Like ''' + ed_EtcSearch.Text + '%'' '
      ;
    end else if cmb_EtcSearch2.ItemIndex = 2 then
    begin
      if cmb_Condition2.ItemIndex = 0 then stSql := stSql + ' AND a.CA_CODE = ''' + ed_EtcSearch.Text + ''' '
      else if cmb_Condition2.ItemIndex = 1 then stSql := stSql + ' AND a.CA_CODE Like ''%' + ed_EtcSearch.Text + '%'' '
      else if cmb_Condition2.ItemIndex = 2 then stSql := stSql + ' AND a.CA_CODE Like ''' + ed_EtcSearch.Text + '%'' '
      ;
    end else if cmb_EtcSearch2.ItemIndex = 3 then
    begin
      if cmb_Condition2.ItemIndex = 0 then stSql := stSql + ' AND a.CA_TELNUM = ''' + ed_EtcSearch.Text + ''' '
      else if cmb_Condition2.ItemIndex = 1 then stSql := stSql + ' AND a.CA_TELNUM Like ''%' + ed_EtcSearch.Text + '%'' '
      else if cmb_Condition2.ItemIndex = 2 then stSql := stSql + ' AND a.CA_TELNUM Like ''' + ed_EtcSearch.Text + '%'' '
      ;
    end;
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
          cells[7,nRow] := FindField('CA_CODE').AsString;
          cells[8,nRow] := FindField('CA_ACCPERMIT').AsString;
          cells[9,nRow] := FindField('BC_PARENTCODE').AsString;
          cells[10,nRow] := FindField('BC_CHILDCODE').AsString;
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
