﻿unit uDevicePwAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, W7Classes, W7Panels, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvSmoothPanel, Vcl.ExtCtrls, AdvSmoothLabel,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvToolBtn,ADODB,ActiveX, uSubForm, CommandArray, AdvCombo, AdvGroupBox,
  Vcl.Mask, AdvSpin, AdvOfficeButtons, AdvPanel, Vcl.ComCtrls, AdvListV,
  Vcl.ImgList, Vcl.Menus, AdvMenus, AdvToolBar, AdvToolBarStylers, AdvAppStyler;

type
  TfmDevicePwAdmin = class(TfmASubForm)
    Image1: TImage;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    pan_DoorList: TAdvPanel;
    pan_CardListHeader: TAdvSmoothPanel;
    lb_Company: TAdvSmoothLabel;
    lb_Depart: TAdvSmoothLabel;
    cmb_ListDongCode: TComboBox;
    cmb_ListAreaCode: TComboBox;
    ImageList1: TImageList;
    pop_PermitAdd: TAdvPopupMenu;
    mn_addpermitListDelete: TMenuItem;
    pan_PasswdList: TAdvSmoothPanel;
    sg_PasswordList: TAdvStringGrid;
    ed_Password: TAdvEdit;
    btn_InsertPassword: TSpeedButton;
    btn_PasswordListDelete: TSpeedButton;
    AdvSmoothPanel8: TAdvSmoothPanel;
    pan_PasswdDoor: TAdvPanel;
    pan_PermitDoorList: TAdvSmoothPanel;
    sg_doorList: TAdvStringGrid;
    pan_doorPasswordList: TAdvSmoothPanel;
    sg_doorPasswordList: TAdvStringGrid;
    AdvSmoothPanel10: TAdvSmoothPanel;
    btn_PasswordPermitAdd: TSpeedButton;
    btn_PasswordPermitDelete: TSpeedButton;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    procedure menuTabChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ed_AddNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure pan_PasswdListResize(Sender: TObject);
    procedure AdvSmoothPanel10Resize(Sender: TObject);
    procedure pan_PermitDoorListResize(Sender: TObject);
    procedure pan_doorPasswordListResize(Sender: TObject);
    procedure AdvSmoothPanel8Resize(Sender: TObject);
    procedure sg_PasswordListResize(Sender: TObject);
    procedure sg_doorListResize(Sender: TObject);
    procedure sg_doorPasswordListResize(Sender: TObject);
    procedure btn_InsertPasswordClick(Sender: TObject);
    procedure ed_PasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sg_PasswordListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure btn_PasswordListDeleteClick(Sender: TObject);
    procedure cmb_ListDongCodeChange(Sender: TObject);
    procedure cmb_ListAreaCodeChange(Sender: TObject);
    procedure sg_doorListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure btn_PasswordPermitAddClick(Sender: TObject);
    procedure btn_PasswordPermitDeleteClick(Sender: TObject);
    procedure sg_doorPasswordListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
  private
    ListDongCodeList : TStringList;
    ListAreaCodeList : TStringList;
    SearchPasswordCodeList : TStringList;
    SearchDoorCodeList : TStringList;

    L_nPasswordListMaxCount : integer;
    L_nPasswordCheckCount : integer;        //체크 된 비밀번호 카운트
    L_nAddDoorCheckCount : integer;  //등록 출입문 선택 카운트
    L_nDeletePasswordCheckCount : integer;  //등록 출입문 선택 카운트


    { Private declarations }
  private
    procedure LoadChildCode(aParentCode:string;aPosition:integer;cmbBox:TComboBox;aList:TStringList;aAll:Boolean);

    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);
  private
    function DupCheckPassword(aPassword:string):Boolean;
    function GetPasswordCount:integer;

    procedure ShowPassword;
    procedure ShowDoorList;
    procedure ShowDoorPasswordList;
  public
    { Public declarations }
    procedure FormNameSetting;
    procedure FontSetting;
    procedure Form_Close;
  end;

var
  fmDevicePwAdmin: TfmDevicePwAdmin;

implementation
uses
  uCommonVariable,
  uDataBase,
  uDBFunction,
  uDBFormName,
  uFormUtil,
  uFunction,
  udmCardPermit,
  uFormFontUtil;

{$R *.dfm}


procedure TfmDevicePwAdmin.AdvSmoothPanel10Resize(Sender: TObject);
begin
  inherited;
  btn_PasswordPermitAdd.Top := (AdvSmoothPanel10.Height div 2) - btn_PasswordPermitAdd.Height - 20;
  btn_PasswordPermitDelete.Top := (AdvSmoothPanel10.Height div 2) + 20;
end;

procedure TfmDevicePwAdmin.pan_PasswdListResize(Sender: TObject);
begin
  inherited;
  sg_PasswordList.Height := btn_PasswordListDelete.Top - sg_PasswordList.Top - 10;
end;

procedure TfmDevicePwAdmin.AdvSmoothPanel8Resize(Sender: TObject);
var
  nWidth : integer;
begin
  inherited;
  nWidth := (AdvSmoothPanel8.Width - AdvSmoothPanel10.Width) div 3;
  pan_PermitDoorList.Width := nWidth;
end;

procedure TfmDevicePwAdmin.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmDevicePwAdmin.btn_InsertPasswordClick(Sender: TObject);
var
  stSql : string;
  bResult : Boolean;
begin
  inherited;

  if Trim(ed_Password.Text) = '' then
  begin
    showmessage(stringReplace(dmFormName.GetFormMessage('2','M00015'),'$NAME',dmFormName.GetFormMessage('4','M00032'),[rfReplaceAll]));
    Exit;
  end;

  if Length(Trim(ed_Password.Text)) <> G_nPasswordFixedLength then
  begin
    showmessage(stringReplace(dmFormName.GetFormMessage('2','M00015'),'$NAME',dmFormName.GetFormMessage('4','M00032'),[rfReplaceAll]));
    Exit;
  end;

  if DupCheckPassword(Trim(ed_Password.Text)) then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00017'));
    ed_Password.Text := '';
    Exit;
  end;

  if GetPasswordCount > 999 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00025'));
    Exit;
  end;

  stSql := ' Insert Into TB_PASSWORD( ';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'PA_PASSWORD) ';
  stSql := stSql + ' Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + Trim(ed_Password.Text) + ''') ';

  bResult := dmDataBase.ProcessExecSQL(stSql);
  if Not bResult then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00018'));
    Exit;
  end else
  begin
    ed_Password.Text := '';
    ShowPassword;
  end;
end;

procedure TfmDevicePwAdmin.btn_PasswordListDeleteClick(Sender: TObject);
var
  i : integer;
  bChkState : Boolean;
  stSql : string;
  stMessage : string;
begin
  inherited;
  if L_nPasswordCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00016'));
    Exit;
  end;
  stMessage := dmFormName.GetFormMessage('2','M00020');
  stMessage := stringReplace(stMessage,'$Count',inttostr(L_nPasswordCheckCount),[rfReplaceAll]);
  if (Application.MessageBox(PChar(stMessage),pchar(dmFormName.GetFormMessage('3','M00008')),MB_OKCANCEL) = IDCANCEL)  then Exit;
  With sg_PasswordList do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bChkState);
      if bChkState then
      begin
        dmDBFunction.UpdateTB_DEVICEPASSWD_PasswordDelete(Cells[1,i]);
        stSql := ' Delete From TB_PASSWORD ';
        stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
        stSql := stSql + ' AND PA_PASSWORD = ''' + Cells[1,i] + ''' ';
        dmDataBase.ProcessExecSQL(stSql);
      end;
    end;
    ShowPassword;
  end;

end;

procedure TfmDevicePwAdmin.btn_PasswordPermitAddClick(Sender: TObject);
var
  i,j : integer;
  bChkState : Boolean;
  stPassword : string;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;

  if L_nPasswordCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00026'));
    Exit;
  end;
  if L_nAddDoorCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00027'));
    Exit;
  end;

  btn_PasswordPermitAdd.Enabled := False;

  for i := 1 to sg_PasswordList.RowCount - 1 do
  begin
    sg_PasswordList.GetCheckBoxState(0,i, bChkState);
    if bChkState then
    begin
      stPassword := sg_PasswordList.Cells[1,i];
      with sg_doorList do
      begin
        for j := 1 to RowCount - 1 do
        begin
          GetCheckBoxState(0,j, bChkState);
          if bChkState then
          begin
            stNodeNo := Cells[2,j];
            stDeviceID := Cells[3,j];
            stDoorNo := Cells[4,j];
            dmCardPermit.PasswordPermitRegist(stPassword,stNodeNo,stDeviceID,stDoorNo,'L');
            Application.ProcessMessages;
          end;
        end;
      end;
    end;
  end;
  btn_PasswordPermitAdd.Enabled := True;
  ShowDoorPasswordList;
end;

procedure TfmDevicePwAdmin.btn_PasswordPermitDeleteClick(Sender: TObject);
var
  j : integer;
  bChkState : Boolean;
  stPassword : string;
  stNodeNo : string;
  stDeviceID : string;
  stDoorNo : string;
begin
  inherited;

  if L_nDeletePasswordCheckCount < 1 then
  begin
    showmessage(dmFormName.GetFormMessage('2','M00028'));
    Exit;
  end;
  btn_PasswordPermitDelete.Enabled := False;
  with sg_doorPasswordList do
  begin
    for j := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,j, bChkState);
      if bChkState then
      begin
        stPassword := Cells[2,j];
        stNodeNo := Cells[4,j];
        stDeviceID := Cells[5,j];
        stDoorNo := Cells[6,j];
        dmCardPermit.PasswordPermitRegist(stPassword,stNodeNo,stDeviceID,stDoorNo,'N');
        Application.ProcessMessages;
      end;
    end;
  end;
  btn_PasswordPermitDelete.Enabled := True;
  ShowDoorPasswordList;
end;

procedure TfmDevicePwAdmin.cmb_ListAreaCodeChange(Sender: TObject);
begin
  inherited;
  ShowDoorList;
  ShowDoorPasswordList;

end;

procedure TfmDevicePwAdmin.cmb_ListDongCodeChange(Sender: TObject);
var
  stParentCode : string;
begin
  inherited;
  stParentCode := ListDongCodeList.Strings[cmb_ListDongCode.ItemIndex];
  LoadChildCode(stParentCode,2,cmb_ListAreaCode,ListAreaCodeList,True);
  ShowDoorList;
  ShowDoorPasswordList;
end;

function TfmDevicePwAdmin.DupCheckPassword(aPassword: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := False;
  stSql := 'Select * from TB_PASSWORD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND PA_PASSWORD = ''' + aPassword + ''' ';

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
    end;

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmDevicePwAdmin.ed_AddNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfmDevicePwAdmin.ed_PasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
  aCurrentPosition : integer;
begin
  inherited;
  if Trim(ed_Password.Text) = '' then  Exit;

  with sg_PasswordList do
  begin
    aCurrentPosition := Row;
    if aCurrentPosition = (RowCount - 1) then aCurrentPosition := 1;

    for i := aCurrentPosition to RowCount - 1 do
    begin
      if copy(Cells[1,i],1,Length(ed_Password.Text)) = ed_Password.Text then
      begin
        Row := i;
        SelectRows(i,1);
        if (TopRow + L_nPasswordListMaxCount) < i then TopRow := TopRow + L_nPasswordListMaxCount;
        break;
      end;
    end;
  end;

end;

procedure TfmDevicePwAdmin.FontSetting;
begin
  dmFormFontUtil.TravelFormFontSetting(self,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.TravelAdvOfficeTabSetOfficeStylerFontSetting(AdvOfficeTabSetOfficeStyler1, G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.FormAdvOfficeTabSetOfficeStylerSetting(AdvOfficeTabSetOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormStyleSetting(self,AdvToolBarOfficeStyler1);

end;

procedure TfmDevicePwAdmin.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  ShowPassword;
end;

procedure TfmDevicePwAdmin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMDEVICEPWADMIN);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'FALSE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  ListDongCodeList.Free;
  ListAreaCodeList.Free;
  SearchPasswordCodeList.Free;
  SearchDoorCodeList.Free;

  Action := caFree;
end;

procedure TfmDevicePwAdmin.FormCreate(Sender: TObject);
begin

  ListDongCodeList := TStringList.Create;
  ListAreaCodeList := TStringList.Create;
  SearchPasswordCodeList := TStringList.Create;
  SearchDoorCodeList := TStringList.Create;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);

  LoadChildCode(FillZeroNumber(0,G_nBuildingCodeLength),1,cmb_ListDongCode,ListDongCodeList,True);
  LoadChildCode('',2,cmb_ListAreaCode,ListAreaCodeList,True);
  ShowDoorList;
  ShowDoorPasswordList;
  FontSetting;
end;


procedure TfmDevicePwAdmin.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('1','M00020');
  menuTab.AdvOfficeTabs[0].Caption := dmFormName.GetFormMessage('1','M00035');
  menuTab.AdvOfficeTabs[1].Caption := dmFormName.GetFormMessage('1','M00020');
  pan_PasswdList.Caption.Text := dmFormName.GetFormMessage('4','M00029');
  pan_CardListHeader.Caption.Text := dmFormName.GetFormMessage('4','M00030');
  btn_InsertPassword.Caption := dmFormName.GetFormMessage('4','M00031');
  with sg_PasswordList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00032');
    Hint := dmFormName.GetFormMessage('2','M00012');
  end;
  btn_PasswordListDelete.Caption := dmFormName.GetFormMessage('4','M00033');

  lb_Company.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_Depart.Caption.Text := dmFormName.GetFormMessage('4','M00005');
  pan_PermitDoorList.Caption.Text := dmFormName.GetFormMessage('4','M00034');
  pan_doorPasswordList.Caption.Text := dmFormName.GetFormMessage('4','M00035');

  with sg_doorList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00002');
    cells[2,0] := dmFormName.GetFormMessage('4','M00036');
    cells[3,0] := dmFormName.GetFormMessage('4','M00037');
    cells[4,0] := dmFormName.GetFormMessage('4','M00038');
  end;

  with sg_doorPasswordList do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00002');
    cells[2,0] := dmFormName.GetFormMessage('4','M00032');
    cells[3,0] := dmFormName.GetFormMessage('4','M00022');
    cells[4,0] := dmFormName.GetFormMessage('4','M00036');
    cells[5,0] := dmFormName.GetFormMessage('4','M00037');
    cells[6,0] := dmFormName.GetFormMessage('4','M00038');
  end;
  mn_addpermitListDelete.Caption := dmFormName.GetFormMessage('4','M00065');
  btn_PasswordPermitAdd.Hint := dmFormName.GetFormMessage('4','M00099');
  btn_PasswordPermitDelete.Hint := dmFormName.GetFormMessage('4','M00100');
end;

procedure TfmDevicePwAdmin.FormShow(Sender: TObject);
begin

  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMDEVICEPWADMIN);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
  FormNameSetting;
end;

procedure TfmDevicePwAdmin.Form_Close;
begin
  Close;
end;


function TfmDevicePwAdmin.GetPasswordCount: integer;
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

procedure TfmDevicePwAdmin.LoadChildCode(aParentCode: string; aPosition: integer;
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


procedure TfmDevicePwAdmin.menuTabChange(Sender: TObject);
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
  end;
end;


procedure TfmDevicePwAdmin.pan_PermitDoorListResize(Sender: TObject);
begin
  inherited;
  sg_doorList.Width := pan_PermitDoorList.Width - 20;
  sg_doorList.Height := pan_PermitDoorList.Height - sg_doorList.Top - 20;

end;

procedure TfmDevicePwAdmin.sg_doorListCheckBoxClick(Sender: TObject; ACol,
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
  ShowDoorPasswordList;

end;

procedure TfmDevicePwAdmin.sg_doorListResize(Sender: TObject);
begin
  inherited;
  with sg_doorList do
  begin
    ColWidths[1] := Width - 50;
  end;

end;

procedure TfmDevicePwAdmin.sg_doorPasswordListCheckBoxClick(Sender: TObject;
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

procedure TfmDevicePwAdmin.sg_doorPasswordListResize(Sender: TObject);
var
  nWidth : integer;
begin
  inherited;
  with sg_doorPasswordList do
  begin
    nWidth := (Width - 120) div 2;
    ColWidths[1] := nWidth;
    ColWidths[2] := nWidth;
    ColWidths[3] := 70;
  end;

end;

procedure TfmDevicePwAdmin.sg_PasswordListCheckBoxClick(Sender: TObject; ACol,
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
      nIndex := SearchPasswordCodeList.IndexOf(sg_PasswordList.Cells[1,ARow]);
      if nIndex < 0 then SearchPasswordCodeList.Add(sg_PasswordList.Cells[1,ARow]);
    end else
    begin
      L_nPasswordCheckCount := L_nPasswordCheckCount - 1 ;
      nIndex := SearchPasswordCodeList.IndexOf(sg_PasswordList.Cells[1,ARow]);
      if nIndex > -1 then SearchPasswordCodeList.Delete(nIndex);
    end;
  end;
  ShowDoorPasswordList;

end;

procedure TfmDevicePwAdmin.sg_PasswordListResize(Sender: TObject);
begin
  inherited;
  with sg_PasswordList do
  begin
    ColWidths[1] := Width - 50;
    L_nPasswordListMaxCount := Height div RowHeights[1];
  end;
end;

procedure TfmDevicePwAdmin.ShowDoorList;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_doorList,2,2,true);
  L_nAddDoorCheckCount := 0;

  stSql := 'Select * from TB_DOOR ';
  stSql := stSql + '  Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if cmb_ListDongCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND BC_PARENTCODE = ''' + ListDongCodeList.Strings[cmb_ListDongCode.ItemIndex] + ''' ';  end;
  if cmb_ListAreaCode.ItemIndex > 0 then
  begin
    stSql := stSql + ' AND BC_CHILDCODE = ''' + ListAreaCodeList.Strings[cmb_ListAreaCode.ItemIndex] + ''' ';
  end;
  stSql := stSql + ' ORDER BY idx  ';

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
      with sg_doorList do
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

procedure TfmDevicePwAdmin.ShowDoorPasswordList;
var
  stPasswordList : string;
  stDoorCodeList : string;
  i : integer;
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_doorPasswordList,4,2,true);
  L_nDeletePasswordCheckCount := 0;
  stPasswordList := '';
  if SearchPasswordCodeList.Count > 0 then
  begin
    for i := 0 to SearchPasswordCodeList.Count -1 do
    begin
      if stPasswordList <> '' then stPasswordList := stPasswordList + ',';
      stPasswordList := stPasswordList + '''' + SearchPasswordCodeList.Strings[i] + '''';
    end;
  end;
  stDoorCodeList := '';
  if SearchDoorCodeList.Count > 0 then
  begin
    for i := 0 to SearchDoorCodeList.Count -1 do
    begin
      if stDoorCodeList <> '' then stDoorCodeList := stDoorCodeList + ',';
      stDoorCodeList := stDoorCodeList + '''' + SearchDoorCodeList.Strings[i] + '''' ;
    end;
  end;

  stSql := 'Select a.*,b.ND_NODENO,b.DE_DEVICEID,b.DE_RCVACK,c.DO_DOORNO,c.DO_NAME from  ';
  stSql := stSql + ' ( ';
  stSql := stSql + ' ( ';
  stSql := stSql + ' ( select * from TB_PASSWORD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if stPasswordList <> '' then stSql := stSql + ' AND PA_PASSWORD in (' + stPasswordList + ') ';
  stSql := stSql + ') a ';
  stSql := stSql + ' Inner Join ';
  stSql := stSql + ' ( select * from TB_DEVICEPASSWD ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND DE_DOOR1 = ''Y'' ';
  stSql := stSql + ' AND DE_PERMIT = ''L'' ';
  if stDoorCodeList <> '' then stSql := stSql + ' AND CStr(ND_NODENO) + DE_DEVICEID + CStr(1) in (' + stDoorCodeList + ') ';
  stSql := stSql + ' ) b ';
  stSql := stSql + ' On (a.GROUP_CODE = b.GROUP_CODE) ';
  stSql := stSql + ' AND (a.PA_PASSWORD = b.PA_PASSWORD) ';
  stSql := stSql + ' )' ;
  stSql := stSql + ' Left Join TB_DOOR c ';
  stSql := stSql + ' ON  (b.GROUP_CODE = c.GROUP_CODE) ';
  stSql := stSql + ' AND (b.ND_NODENO = c.ND_NODENO ) ';
  stSql := stSql + ' AND (b.DE_DEVICEID = c.DE_DEVICEID ) ';
  stSql := stSql + ' )';
  stSql := stSql + ' Order by c.DO_NAME ';
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
      with sg_doorPasswordList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DO_NAME').AsString;
          cells[2,nRow] := FindField('PA_PASSWORD').AsString;
          cells[3,nRow] := FindField('DE_RCVACK').AsString;
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

procedure TfmDevicePwAdmin.ShowPassword;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_PasswordList,2,2,true);
  L_nPasswordCheckCount := 0;
  SearchPasswordCodeList.Clear;

  stSql := 'Select * from TB_PASSWORD ';
  stSql := stSql + ' Order by PA_PASSWORD ';

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
      with sg_PasswordList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('PA_PASSWORD').AsString;

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

procedure TfmDevicePwAdmin.pan_doorPasswordListResize(Sender: TObject);
begin
  inherited;
  sg_doorPasswordList.Width := pan_doorPasswordList.Width - 20;
  sg_doorPasswordList.Height := pan_doorPasswordList.Height - sg_doorPasswordList.Top - 20;

end;

initialization
  RegisterClass(TfmDevicePwAdmin);
Finalization
  UnRegisterClass(TfmDevicePwAdmin);

end.
