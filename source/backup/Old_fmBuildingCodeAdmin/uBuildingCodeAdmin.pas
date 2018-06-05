unit uBuildingCodeAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, W7Classes, W7Panels, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvSmoothPanel, Vcl.ExtCtrls, AdvSmoothLabel,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvToolBtn,ADODB,ActiveX, uSubForm, CommandArray, Vcl.Menus;

type
  TfmBuildingCodeAdmin = class(TfmASubForm)
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    Image1: TImage;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    dongCodeList: TAdvSmoothPanel;
    dongCodeAdd: TAdvSmoothPanel;
    lb_Company: TAdvSmoothLabel;
    ed_dongname: TAdvEdit;
    btn_Search: TSpeedButton;
    sg_dongCode: TAdvStringGrid;
    btn_Delete: TSpeedButton;
    lb_CompanyAdd: TAdvSmoothLabel;
    ed_InsertName: TAdvEdit;
    btn_InsertSave: TSpeedButton;
    btn_add: TSpeedButton;
    dongCodeUpdate: TAdvSmoothPanel;
    lb_CompanyUpdate: TAdvSmoothLabel;
    btn_UpdateSave: TSpeedButton;
    ed_UpdatedongName: TAdvEdit;
    ed_UpdateParentCode: TAdvEdit;
    ed_UpdateChildCode: TAdvEdit;
    PopupMenu1: TPopupMenu;
    pm_update: TMenuItem;
    procedure menuTabChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure lb_page1Click(Sender: TObject);
    procedure ed_dongnameChange(Sender: TObject);
    procedure sg_dongCodeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sg_dongCodeKeyPress(Sender: TObject; var Key: Char);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_InsertSaveClick(Sender: TObject);
    procedure ed_InsertNameKeyPress(Sender: TObject; var Key: Char);
    procedure sg_dongCodeCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure sg_dongCodeColChanging(Sender: TObject; OldCol, NewCol: Integer;
      var Allow: Boolean);
    procedure sg_dongCodeDblClick(Sender: TObject);
    procedure btn_UpdateSaveClick(Sender: TObject);
    procedure ed_UpdatedongNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure pm_updateClick(Sender: TObject);
  private
    L_nPageGroupMaxCount : integer ; //한페이지 그룹에 해당하는 페이지수
    L_nPageListMaxCount : integer; //한페이지에 출력되는 리스트 갯수
    L_nCurrentPageGroup : integer;   //지금 속한 페이지 그룹
    L_nCurrentPageList : integer;    //지금 조회 하고 있는 페이지
    L_CurrentSaveRow : integer;

    L_nCheckCount : integer;        //체크 된 카운트
    { Private declarations }
    procedure PageTabCreate(aPageGroup,aCurrentPage:integer);
    procedure ShowDongCode(aCurrentCode:string;aTopRow:integer = 0);
    procedure UpdateCell;
    procedure SaveUpdateCell;

    function ParentCodeDelete(aParentCode:string):Boolean;
    function ChildCodeDelete(aChildCode:string):Boolean;

    function GetNextBuildingCode:string;
    procedure FormNameSetting;
  private
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);
  public
    { Public declarations }
    procedure Form_Close;
  end;

var
  fmBuildingCodeAdmin: TfmBuildingCodeAdmin;

implementation
uses
  uCommonVariable,
  uDataBase,
  uDBFormName,
  uFormUtil,
  uFunction,
  uMessage;

{$R *.dfm}


procedure TfmBuildingCodeAdmin.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmBuildingCodeAdmin.btn_InsertSaveClick(Sender: TObject);
var
  stParentCode : string;
  stChildCode : string;
  stName : string;
  stSql : string;
  bResult : Boolean;
begin
  inherited;
  stName := ed_InsertName.Text;
  stParentCode := FillZeroNumber(0,G_nBuildingCodeLength);
  stChildCode := GetNextBuildingCode;
  if stName = '' then
  begin
    showmessage(stringReplace(MSGNOTNAMEERROR,'$NAME','명칭',[rfReplaceAll]));
    Exit;
  end;

  stSql := ' Insert Into TB_BUILDINGCODE ( ';
  stSql := stSql + 'GROUP_CODE,';
  stSql := stSql + 'BC_PARENTCODE,';
  stSql := stSql + 'BC_CHILDCODE,';
  stSql := stSql + 'BC_POSITION,';
  stSql := stSql + 'BC_NAME ) ';
  stSql := stSql + 'Values( ';
  stSql := stSql + '''' + G_stGroupCode + ''',';
  stSql := stSql + '''' + stParentCode + ''',';
  stSql := stSql + '''' + stChildCode + ''',';
  stSql := stSql + '1,';
  stSql := stSql + '''' + stName + ''') ';

  bResult := dmDataBase.ProcessExecSQL(stSql);
  if bResult then
  begin
    menuTab.ActiveTabIndex := 1;
    menuTabChange(self);
    PageTabCreate(L_nCurrentPageGroup,L_nCurrentPageList);
    ShowDongCode('');
  end else
  begin
    showmessage(MSGDATABASESAVEFAIL);
  end;

end;

procedure TfmBuildingCodeAdmin.btn_SaveClick(Sender: TObject);
begin
  inherited;
  SaveUpdateCell;
end;

procedure TfmBuildingCodeAdmin.btn_SearchClick(Sender: TObject);
begin
  L_nCurrentPageList := 1;
  PageTabCreate(0,L_nCurrentPageList);
  ShowDongCode('');
end;

procedure TfmBuildingCodeAdmin.btn_UpdateSaveClick(Sender: TObject);
var
  stParentCode : string;
  stChildCode : string;
  stName : string;
  stSql : string;
  bResult : Boolean;
begin
  inherited;
  stName := ed_UpdatedongName.Text;
  stParentCode := ed_UpdateParentCode.Text;
  stChildCode := ed_UpdateChildCode.Text;

  if stName = '' then
  begin
    showmessage(stringReplace(MSGNOTNAMEERROR,'$NAME','명칭',[rfReplaceAll]));
    Exit;
  end;
  stSql := ' Update TB_BUILDINGCODE set BC_NAME = ''' + stName + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND BC_PARENTCODE = ''' + stParentCode + '''';
  stSql := stSql + ' AND BC_CHILDCODE = ''' + stChildCode + ''' ';

  bResult := dmDataBase.ProcessExecSQL(stSql);
  if bResult then
  begin
    menuTab.ActiveTabIndex := 1;
    menuTabChange(self);
    PageTabCreate(L_nCurrentPageGroup,L_nCurrentPageList);
    ShowDongCode('');
  end else
  begin
    showmessage(MSGDATABASESAVEFAIL);
  end;

end;

function TfmBuildingCodeAdmin.ChildCodeDelete(aChildCode: string): Boolean;
var
  stSql : string;
begin
    stSql := ' Delete From TB_BUILDINGCODE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND BC_CHILDCODE = ''' + aChildCode + ''' ';

    result := dmDataBase.ProcessExecSQL(stSql);
end;

procedure TfmBuildingCodeAdmin.ed_dongnameChange(Sender: TObject);
begin
  inherited;
  L_nCurrentPageList := 1;
  PageTabCreate(0,L_nCurrentPageList);
  ShowDongCode('');
end;

procedure TfmBuildingCodeAdmin.ed_InsertNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    btn_InsertSaveClick(self);
  end;

end;

procedure TfmBuildingCodeAdmin.ed_UpdatedongNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    btn_UpdateSaveClick(self);
  end;

end;

procedure TfmBuildingCodeAdmin.FormActivate(Sender: TObject);
begin
  inherited;
  FormNameSetting;
end;

procedure TfmBuildingCodeAdmin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMBUILDINGCODE);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'FALSE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  Action := caFree;
end;

procedure TfmBuildingCodeAdmin.FormCreate(Sender: TObject);
begin
  Height := G_nChildFormDefaultHeight;
  L_nPageGroupMaxCount :=5 ; //한페이지 그룹에 해당하는 페이지수
  L_nPageListMaxCount :=16; //한페이지에 출력되는 리스트 갯수
  //L_nPageListMaxCount :=2; //한페이지에 출력되는 리스트 갯수

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);
end;


procedure TfmBuildingCodeAdmin.FormNameSetting;
begin
  Caption := dmFormName.GetFormMessage('1','M00012');
  menuTab.AdvOfficeTabs[0].Caption := dmFormName.GetFormMessage('1','M00035');
  menuTab.AdvOfficeTabs[1].Caption := dmFormName.GetFormMessage('1','M00041');
  menuTab.AdvOfficeTabs[2].Caption := dmFormName.GetFormMessage('1','M00042');
  dongCodeList.Caption.Text := dmFormName.GetFormMessage('1','M00041');
  dongCodeAdd.Caption.Text := dmFormName.GetFormMessage('1','M00042');
  dongCodeUpdate.Caption.Text := dmFormName.GetFormMessage('1','M00043');
  lb_Company.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_CompanyAdd.Caption.Text := dmFormName.GetFormMessage('4','M00004');
  lb_CompanyUpdate.Caption.Text := dmFormName.GetFormMessage('4','M00004');

  btn_Search.Caption :=  dmFormName.GetFormMessage('4','M00007');
  btn_InsertSave.Caption :=  dmFormName.GetFormMessage('4','M00014');
  btn_UpdateSave.Caption :=  dmFormName.GetFormMessage('4','M00014');
  btn_add.Caption :=  dmFormName.GetFormMessage('4','M00077');
  btn_Delete.Caption :=  dmFormName.GetFormMessage('4','M00078');
  pm_update.Caption := dmFormName.GetFormMessage('4','M00098');

  with sg_dongCode do
  begin
    cells[1,0] := dmFormName.GetFormMessage('4','M00004');
    cells[2,0] := dmFormName.GetFormMessage('4','M00097');
    Hint := dmFormName.GetFormMessage('2','M00012');
  end;
end;

procedure TfmBuildingCodeAdmin.FormResize(Sender: TObject);
begin
  BodyPanel.Left := 0;
  BodyPanel.Top := 0;
  BodyPanel.Height := Height - menuTab.Height;

end;

procedure TfmBuildingCodeAdmin.FormShow(Sender: TObject);
begin
  top := 0;
  Left := 0;
  Width := BodyPanel.Width;

  L_nCurrentPageGroup := 0;
  PageTabCreate(L_nCurrentPageGroup,1);
  ShowDongCode('');

  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FORMBUILDINGCODE);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
end;

procedure TfmBuildingCodeAdmin.Form_Close;
begin
  Close;
end;

function TfmBuildingCodeAdmin.GetNextBuildingCode: string;
var
  nChildCode : integer;
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  nChildCode := 1;
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    stSql := 'Select Max(BC_CHILDCODE) as BC_CHILDCODE from TB_BUILDINGCODE ';

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

      if Not isDigit(FindField('BC_CHILDCODE').AsString) then Exit;
      nChildCode := strtoint(FindField('BC_CHILDCODE').AsString) + 1;

    end;
  Finally
    result := FillZeroNumber(nChildCode,G_nBuildingCodeLength);
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmBuildingCodeAdmin.lb_page1Click(Sender: TObject);
begin
  inherited;
  Try
    L_nCurrentPageList := TLabel(Sender).tag;
    PageTabCreate(L_nCurrentPageGroup,L_nCurrentPageList);
    ShowDongCode('');
  Except
    Exit;
  End;

end;

procedure TfmBuildingCodeAdmin.menuTabChange(Sender: TObject);
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
    dongCodeList.Visible := True;
    dongCodeAdd.Visible := False;
    dongCodeList.Align := alClient;
    dongCodeUpdate.Visible := False;
  end else if menuTab.ActiveTabIndex = 2 then
  begin
    menuTab.AdvOfficeTabs.Items[0].Caption := '이전';
    dongCodeList.Visible := False;
    dongCodeAdd.Visible := True;
    dongCodeAdd.Align := alClient;
    ed_InsertName.Text := '';
    dongCodeUpdate.Visible := False;
  end;
end;

procedure TfmBuildingCodeAdmin.PageTabCreate(aPageGroup,aCurrentPage: integer);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  i : integer;
  oLabel : TLabel;
  nCurrentPageStart : integer;
  nCurrentPageNo : integer;
begin
(*  if aPageGroup = 0 then lb_PrePage.Visible := False
  else
  begin
    lb_PrePage.Tag := aPageGroup - 1;
    lb_PrePage.Visible := True;
  end;

  for i := 1 to L_nPageGroupMaxCount do
  begin
    oLabel := TravelPanelLabelItem(TPanel(dongCodeList),'lb_page',i);
    if oLabel <> nil then oLabel.Visible := False;
  end;
  lb_NextPage.Visible := False;

  nCurrentPageStart := (aPageGroup * L_nPageGroupMaxCount) + 1;

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin  *)
//      stSql := ' Select count(*) as cnt from TB_BUILDINGCODE ';
(*      stSql := stSql + ' Where BC_POSITION = 1 ';
      if ed_dongname.Text <> '' then
      begin
        stSql := stSql + ' AND BC_NAME Like ''%' + ed_dongname.Text + '%'' ';
      end;

      Close;
      Sql.Clear;
      Sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then Exit;
      if FindField('cnt').AsInteger > ((nCurrentPageStart - 1) * L_nPageListMaxCount)   then  //현재 페이지에 데이터가 있으면
      begin
        //for i := nCurrentPageStart + 1 to (nCurrentPageStart + L_nPageGroupMaxCount) do
        for i := 1 to L_nPageGroupMaxCount do
        begin
          oLabel := TravelPanelLabelItem(TPanel(dongCodeList),'lb_page',i);
          if oLabel <> nil then
          begin
            TAdvSmoothLabel(oLabel).Visible := true;
            TAdvSmoothLabel(oLabel).Caption.Text := '[' + inttostr((nCurrentPageStart + i -1)) + ']';
            TAdvSmoothLabel(oLabel).Tag := i + nCurrentPageStart -1;
            if aCurrentPage = (nCurrentPageStart + i -1) then
            begin
              //여기서 색깔 넣자
              TAdvSmoothLabel(oLabel).Caption.ColorStart := clRed;
            end else
            begin
              TAdvSmoothLabel(oLabel).Caption.ColorStart := clBlue;
            end;
          end;
          if ((nCurrentPageStart + i -1) * L_nPageListMaxCount) >= FindField('cnt').AsInteger then break; //마지막 페이지 이면 빠져 나가자.
        end;
        if ((nCurrentPageStart + L_nPageGroupMaxCount) * L_nPageListMaxCount) < FindField('cnt').AsInteger then
        begin
          //[다음] 페이지가 존재 하면
          lb_Nextpage.Visible := True;
          lb_Nextpage.Tag := aPageGroup + 1;
        end;
      end;

    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End; *)
end;

function TfmBuildingCodeAdmin.ParentCodeDelete(aParentCode: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  result := True;
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    stSql := 'Select * from TB_BUILDINGCODE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND BC_PARENTCODE = ''' + aParentCode + ''' ';

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
      while Not Eof do
      begin
        ParentCodeDelete(FindField('BC_CHILDCODE').AsString);
        Next;
      end;
    end;

    stSql := ' Delete From TB_BUILDINGCODE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND BC_PARENTCODE = ''' + aParentCode + ''' ';

    result := dmDataBase.ProcessExecSQL(stSql);

  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmBuildingCodeAdmin.pm_updateClick(Sender: TObject);
begin
  inherited;
  sg_dongCodeDblClick(sg_dongCode);
end;

procedure TfmBuildingCodeAdmin.SaveUpdateCell;
var
  stParentCode : string;
  stChildCode : string;
  stName : string;
  stSql : string;
  bResult : Boolean;
begin

  with sg_dongCode do
  begin
    stParentCode := cells[3,L_CurrentSaveRow];
    stChildCode := cells[4,L_CurrentSaveRow];
    stName := cells[1,L_CurrentSaveRow];

    if stParentCode = '' then stParentCode := FillZeroNumber(0,G_nBuildingCodeLength);
    if stChildCode = '' then Exit;

    stSql := ' Update TB_BUILDINGCODE set BC_NAME = ''' + stName + ''' ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND BC_PARENTCODE = ''' + stParentCode + ''' ';
    stSql := stSql + ' AND BC_CHILDCODE = ''' + stChildCode + ''' ';

    bResult := dmDataBase.ProcessExecSQL(stSql);

  end;

end;

procedure TfmBuildingCodeAdmin.sg_dongCodeCheckBoxClick(Sender: TObject; ACol,
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

procedure TfmBuildingCodeAdmin.sg_dongCodeColChanging(Sender: TObject; OldCol,
  NewCol: Integer; var Allow: Boolean);
begin
  inherited;
  with sg_dongCode do
  begin
    if NewCol = 0 then Options := Options + [goEditing]
    else Options := Options - [goEditing];
  end;

end;

procedure TfmBuildingCodeAdmin.sg_dongCodeDblClick(Sender: TObject);
begin
  inherited;
  with sg_dongCode do
  begin
    if cells[4,Row] = '' then Exit;
    ed_UpdatedongName.Text := cells[1,Row];
    if Not isDigit(cells[3,Row]) then cells[3,Row] := FillZeroNumber(0,G_nBuildingCodeLength);
    ed_UpdateParentCode.Text := cells[3,Row];
    ed_UpdateChildCode.Text := cells[4,Row];
  end;
  menuTab.AdvOfficeTabs.Items[0].Caption := '이전';
  dongCodeUpdate.Visible := True;
  dongCodeUpdate.Align := alClient;
  dongCodeList.Visible := False;
  dongCodeAdd.Visible := False;

  ed_UpdatedongName.SelectAll;
  ed_UpdatedongName.SetFocus;

end;

procedure TfmBuildingCodeAdmin.sg_dongCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    L_CurrentSaveRow := sg_dongcode.Row;
    //SaveUpdateCell;
  end;

end;

procedure TfmBuildingCodeAdmin.sg_dongCodeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  L_CurrentSaveRow := sg_dongcode.Row;
  if (Key <> VK_RETURN) and
     (Key <> VK_UP) and
     (Key <> VK_DOWN) then UpdateCell;

end;

procedure TfmBuildingCodeAdmin.ShowDongCode(aCurrentCode: string; aTopRow: integer);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_dongcode,2,2,true);
  sg_dongcode.ColWidths[4] := 50;

  L_nCheckCount := 0;

  stSql := 'SELECT  * FROM TB_BUILDINGCODE ';
  stSql := stSql + '  Where BC_POSITION = 1 ';
  if ed_dongname.Text <> '' then
  begin
    stSql := stSql + ' AND BC_NAME Like ''%' + ed_dongname.Text + '%'' ';
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
      with sg_dongCode do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('BC_NAME').AsString;
          cells[3,nRow] := FindField('BC_PARENTCODE').AsString;
          cells[4,nRow] := FindField('BC_CHILDCODE').AsString;
          if (FindField('BC_CHILDCODE').AsString )  = aCurrentCode then
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

procedure TfmBuildingCodeAdmin.btn_addClick(Sender: TObject);
begin
  inherited;
  menutab.ActiveTabIndex := 2;
  menutabChange(self);
end;

procedure TfmBuildingCodeAdmin.btn_DeleteClick(Sender: TObject);
var
  i : integer;
  bChkState : Boolean;
begin
  inherited;
  if L_nCheckCount = 0 then
  begin
    showmessage(MSGDELETESELECT);
    Exit;
  end;
  if (Application.MessageBox(PChar(inttostr(L_nCheckCount) + MSGDELETECOUNTINFOQUESTION),'정보',MB_OKCANCEL) = IDCANCEL)  then Exit;
  With sg_DongCode do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bChkState);
      if bChkState then
      begin
        ParentCodeDelete(Cells[4,i]);  //해당 ParentCode 아래 있는 모든 코드 삭제
        ChildCodeDelete(Cells[4,i]);
      end;
    end;
  end;
  PageTabCreate(L_nCurrentPageGroup,L_nCurrentPageList);
  ShowDongCode('');

end;

procedure TfmBuildingCodeAdmin.UpdateCell;
var
  Rect: TRect;
begin
{  with sg_dongCode do
  begin
    Rect := CellRect(2, L_CurrentSaveRow);
    btn_Save.Left := Rect.Left ;
    btn_Save.Top :=  Rect.Top ;
    btn_Save.Width := Rect.Right - Rect.Left;
    btn_Save.Height := (Rect.Bottom - Rect.Top);
    btn_Save.BringToFront;   // comboBox1을 최상위로 옮기기 <> SendToBack
    btn_Save.Visible := True;
  end;  }
end;

initialization
  RegisterClass(TfmBuildingCodeAdmin);
Finalization
  UnRegisterClass(TfmBuildingCodeAdmin);

end.
