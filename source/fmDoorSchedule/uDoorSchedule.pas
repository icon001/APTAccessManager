﻿unit uDoorSchedule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uSubForm, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, CommandArray, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, AdvSmoothLabel, AdvSmoothPanel, W7Classes,
  W7Panels, AdvGlassButton,ADODB,ActiveX, frmshape, AdvCombo, Vcl.Mask, AdvSpin,
  AdvGroupBox, AdvOfficeButtons, AdvSmoothTileList, AdvSmoothButton,
  AdvSmoothListBox, AdvEdBtn, Vcl.ComCtrls, Vcl.ImgList, AdvToolBar,
  AdvToolBarStylers;

const
  con_LocalCompanyImageIndex = 0;
  con_LocalEmployeeImageIndex = 1;
  con_LocalBuildingImageIndex = 2;

type
  TfmDoorSchedule = class(TfmASubForm)
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    W7Panel1: TW7Panel;
    BodyPanel: TW7Panel;
    menuTab: TAdvOfficeTabSet;
    List: TAdvSmoothPanel;
    lb_SearchName: TAdvSmoothLabel;
    sg_List: TAdvStringGrid;
    btn_Search: TAdvGlassButton;
    btn_Add: TAdvGlassButton;
    Add: TAdvSmoothPanel;
    Update: TAdvSmoothPanel;
    ed_UpdateNodeNoCode: TAdvEdit;
    ed_UpdateDoorCode: TAdvEdit;
    ed_UpdateEcuCode: TAdvEdit;
    btn_AddWeek: TAdvSmoothButton;
    btn_AddSaturday: TAdvSmoothButton;
    btn_AddSunday: TAdvSmoothButton;
    btn_AddHoliday: TAdvSmoothButton;
    pan_AddWeek1: TAdvSmoothPanel;
    cmb_W1HH: TComboBox;
    cmb_W1MM: TComboBox;
    lb_AddWeekHH1: TLabel;
    lb_AddWeekMM1: TLabel;
    cmb_AddW1Mode: TComboBox;
    pan_AddWeek2: TAdvSmoothPanel;
    lb_AddWeekHH2: TLabel;
    lb_AddWeekMM2: TLabel;
    cmb_W2HH: TComboBox;
    cmb_W2MM: TComboBox;
    cmb_AddW2Mode: TComboBox;
    pan_AddWeek3: TAdvSmoothPanel;
    lb_AddWeekHH3: TLabel;
    lb_AddWeekMM3: TLabel;
    cmb_W3HH: TComboBox;
    cmb_W3MM: TComboBox;
    cmb_AddW3Mode: TComboBox;
    pan_AddWeek4: TAdvSmoothPanel;
    lb_AddWeekHH4: TLabel;
    lb_AddWeekMM4: TLabel;
    cmb_W4HH: TComboBox;
    cmb_W4MM: TComboBox;
    cmb_AddW4Mode: TComboBox;
    pan_AddWeek5: TAdvSmoothPanel;
    lb_AddWeekHH5: TLabel;
    lb_AddWeekMM5: TLabel;
    ComboBox13: TComboBox;
    ComboBox14: TComboBox;
    cmb_AddW5Mode: TComboBox;
    pan_AddSaturday1: TAdvSmoothPanel;
    lb_AddSaturdayHH1: TLabel;
    lb_AddSaturdayMM1: TLabel;
    cmb_S1HH: TComboBox;
    cmb_S1MM: TComboBox;
    cmb_AddS1Mode: TComboBox;
    pan_AddSaturday2: TAdvSmoothPanel;
    lb_AddSaturdayHH2: TLabel;
    lb_AddSaturdayMM2: TLabel;
    cmb_S2HH: TComboBox;
    cmb_S2MM: TComboBox;
    cmb_AddS2Mode: TComboBox;
    pan_AddSaturday3: TAdvSmoothPanel;
    lb_AddSaturdayHH3: TLabel;
    lb_AddSaturdayMM3: TLabel;
    cmb_S3HH: TComboBox;
    cmb_S3MM: TComboBox;
    cmb_AddS3Mode: TComboBox;
    pan_AddSaturday4: TAdvSmoothPanel;
    lb_AddSaturdayHH4: TLabel;
    lb_AddSaturdayMM4: TLabel;
    cmb_S4HH: TComboBox;
    cmb_S4MM: TComboBox;
    cmb_AddS4Mode: TComboBox;
    pan_AddSaturday5: TAdvSmoothPanel;
    lb_AddSaturdayHH5: TLabel;
    lb_AddSaturdayMM5: TLabel;
    ComboBox28: TComboBox;
    ComboBox29: TComboBox;
    cmb_AddS5Mode: TComboBox;
    pan_AddSunday1: TAdvSmoothPanel;
    lb_AddSundayHH1: TLabel;
    lb_AddSundayMM1: TLabel;
    cmb_N1HH: TComboBox;
    cmb_N1MM: TComboBox;
    cmb_AddN1Mode: TComboBox;
    pan_AddSunday2: TAdvSmoothPanel;
    lb_AddSundayHH2: TLabel;
    lb_AddSundayMM2: TLabel;
    cmb_N2HH: TComboBox;
    cmb_N2MM: TComboBox;
    cmb_AddN2Mode: TComboBox;
    pan_AddSunday3: TAdvSmoothPanel;
    lb_AddSundayHH3: TLabel;
    lb_AddSundayMM3: TLabel;
    cmb_N3HH: TComboBox;
    cmb_N3MM: TComboBox;
    cmb_AddN3Mode: TComboBox;
    pan_AddSunday4: TAdvSmoothPanel;
    lb_AddSundayHH4: TLabel;
    lb_AddSundayMM4: TLabel;
    cmb_N4HH: TComboBox;
    cmb_N4MM: TComboBox;
    cmb_AddN4Mode: TComboBox;
    pan_AddSunday5: TAdvSmoothPanel;
    lb_AddSundayHH5: TLabel;
    lb_AddSundayMM5: TLabel;
    ComboBox43: TComboBox;
    ComboBox44: TComboBox;
    cmb_AddN5Mode: TComboBox;
    pan_AddHoliday1: TAdvSmoothPanel;
    lb_AddHolidayHH1: TLabel;
    lb_AddHolidayMM1: TLabel;
    cmb_H1HH: TComboBox;
    cmb_H1MM: TComboBox;
    cmb_AddH1Mode: TComboBox;
    pan_AddHoliday2: TAdvSmoothPanel;
    lb_AddHolidayHH2: TLabel;
    lb_AddHolidayMM2: TLabel;
    cmb_H2HH: TComboBox;
    cmb_H2MM: TComboBox;
    cmb_AddH2Mode: TComboBox;
    pan_AddHoliday3: TAdvSmoothPanel;
    lb_AddHolidayHH3: TLabel;
    lb_AddHolidayMM3: TLabel;
    cmb_H3HH: TComboBox;
    cmb_H3MM: TComboBox;
    cmb_AddH3Mode: TComboBox;
    pan_AddHoliday4: TAdvSmoothPanel;
    lb_AddHolidayHH4: TLabel;
    lb_AddHolidayMM4: TLabel;
    cmb_H4HH: TComboBox;
    cmb_H4MM: TComboBox;
    cmb_AddH4Mode: TComboBox;
    pan_AddHoliday5: TAdvSmoothPanel;
    lb_AddHolidayHH5: TLabel;
    lb_AddHolidayMM5: TLabel;
    ComboBox58: TComboBox;
    ComboBox59: TComboBox;
    cmb_AddH5Mode: TComboBox;
    btn_AddSave: TAdvGlassButton;
    btn_AddTimeInitialize: TAdvGlassButton;
    btn_AddAllManager: TAdvGlassButton;
    btn_AddAllOpenMode: TAdvGlassButton;
    btn_AddAllClose: TAdvGlassButton;
    btn_UpdateWeek: TAdvSmoothButton;
    btn_UpdateSaturday: TAdvSmoothButton;
    btn_UpdateSunday: TAdvSmoothButton;
    btn_UpdateHoliday: TAdvSmoothButton;
    pan_UpdateWeek1: TAdvSmoothPanel;
    lb_UpdateWeekHH1: TLabel;
    lb_UpdateWeekMM1: TLabel;
    cmb_UpdateW1HH: TComboBox;
    cmb_UpdateW1MM: TComboBox;
    cmb_UpdateW1MODE: TComboBox;
    pan_UpdateSaturday1: TAdvSmoothPanel;
    lb_UpdateSaturdayHH1: TLabel;
    lb_UpdateSaturdayMM1: TLabel;
    cmb_UpdateS1HH: TComboBox;
    cmb_UpdateS1MM: TComboBox;
    cmb_UpdateS1MODE: TComboBox;
    pan_UpdateSunday1: TAdvSmoothPanel;
    lb_UpdateSundayHH1: TLabel;
    lb_UpdateSundayMM1: TLabel;
    cmb_UpdateN1HH: TComboBox;
    cmb_UpdateN1MM: TComboBox;
    cmb_UpdateN1MODE: TComboBox;
    pan_UpdateHoliday1: TAdvSmoothPanel;
    lb_UpdateHolidayHH1: TLabel;
    lb_UpdateHolidayMM1: TLabel;
    cmb_UpdateH1HH: TComboBox;
    cmb_UpdateH1MM: TComboBox;
    cmb_UpdateH1MODE: TComboBox;
    pan_UpdateHoliday2: TAdvSmoothPanel;
    lb_UpdateHolidayHH2: TLabel;
    lb_UpdateHolidayMM2: TLabel;
    cmb_UpdateH2HH: TComboBox;
    cmb_UpdateH2MM: TComboBox;
    cmb_UpdateH2MODE: TComboBox;
    pan_UpdateSunday2: TAdvSmoothPanel;
    lb_UpdateSundayHH2: TLabel;
    lb_UpdateSundayMM2: TLabel;
    cmb_UpdateN2HH: TComboBox;
    cmb_UpdateN2MM: TComboBox;
    cmb_UpdateN2MODE: TComboBox;
    pan_UpdateSaturday2: TAdvSmoothPanel;
    lb_UpdateSaturdayHH2: TLabel;
    lb_UpdateSaturdayMM2: TLabel;
    cmb_UpdateS2HH: TComboBox;
    cmb_UpdateS2MM: TComboBox;
    cmb_UpdateS2MODE: TComboBox;
    pan_UpdateWeek2: TAdvSmoothPanel;
    lb_UpdateWeekHH2: TLabel;
    lb_UpdateWeekMM2: TLabel;
    cmb_UpdateW2HH: TComboBox;
    cmb_UpdateW2MM: TComboBox;
    cmb_UpdateW2MODE: TComboBox;
    pan_UpdateWeek3: TAdvSmoothPanel;
    lb_UpdateWeekHH3: TLabel;
    lb_UpdateWeekMM3: TLabel;
    cmb_UpdateW3HH: TComboBox;
    cmb_UpdateW3MM: TComboBox;
    cmb_UpdateW3MODE: TComboBox;
    pan_UpdateSaturday3: TAdvSmoothPanel;
    lb_UpdateSaturdayHH3: TLabel;
    lb_UpdateSaturdayMM3: TLabel;
    cmb_UpdateS3HH: TComboBox;
    cmb_UpdateS3MM: TComboBox;
    cmb_UpdateS3MODE: TComboBox;
    pan_UpdateSunday3: TAdvSmoothPanel;
    lb_UpdateSundayHH3: TLabel;
    lb_UpdateSundayMM3: TLabel;
    cmb_UpdateN3HH: TComboBox;
    cmb_UpdateN3MM: TComboBox;
    cmb_UpdateN3MODE: TComboBox;
    pan_UpdateHoliday3: TAdvSmoothPanel;
    lb_UpdateHolidayHH3: TLabel;
    lb_UpdateHolidayMM3: TLabel;
    cmb_UpdateH3HH: TComboBox;
    cmb_UpdateH3MM: TComboBox;
    cmb_UpdateH3MODE: TComboBox;
    pan_UpdateHoliday4: TAdvSmoothPanel;
    lb_UpdateHolidayHH4: TLabel;
    lb_UpdateHolidayMM4: TLabel;
    cmb_UpdateH4HH: TComboBox;
    cmb_UpdateH4MM: TComboBox;
    cmb_UpdateH4MODE: TComboBox;
    pan_UpdateHoliday5: TAdvSmoothPanel;
    lb_UpdateHolidayHH5: TLabel;
    lb_UpdateHolidayMM5: TLabel;
    cmb_UpdateH5HH: TComboBox;
    cmb_UpdateH5MM: TComboBox;
    cmb_UpdateH5MODE: TComboBox;
    pan_UpdateSunday5: TAdvSmoothPanel;
    lb_UpdateSundayHH5: TLabel;
    lb_UpdateSundayMM5: TLabel;
    cmb_UpdateN5HH: TComboBox;
    cmb_UpdateN5MM: TComboBox;
    cmb_UpdateN5MODE: TComboBox;
    pan_UpdateSunday4: TAdvSmoothPanel;
    lb_UpdateSundayHH4: TLabel;
    lb_UpdateSundayMM4: TLabel;
    cmb_UpdateN4HH: TComboBox;
    cmb_UpdateN4MM: TComboBox;
    cmb_UpdateN4MODE: TComboBox;
    pan_UpdateSaturday4: TAdvSmoothPanel;
    lb_UpdateSaturdayHH4: TLabel;
    lb_UpdateSaturdayMM4: TLabel;
    cmb_UpdateS4HH: TComboBox;
    cmb_UpdateS4MM: TComboBox;
    cmb_UpdateS4MODE: TComboBox;
    pan_UpdateSaturday5: TAdvSmoothPanel;
    lb_UpdateSaturdayHH5: TLabel;
    lb_UpdateSaturdayMM5: TLabel;
    cmb_UpdateS5HH: TComboBox;
    cmb_UpdateS5MM: TComboBox;
    cmb_UpdateS5MODE: TComboBox;
    pan_UpdateWeek5: TAdvSmoothPanel;
    lb_UpdateWeekHH5: TLabel;
    lb_UpdateWeekMM5: TLabel;
    cmb_UpdateW5HH: TComboBox;
    cmb_UpdateW5MM: TComboBox;
    cmb_UpdateW5MODE: TComboBox;
    pan_UpdateWeek4: TAdvSmoothPanel;
    lb_UpdateWeekHH4: TLabel;
    lb_UpdateWeekMM4: TLabel;
    cmb_UpdateW4HH: TComboBox;
    cmb_UpdateW4MM: TComboBox;
    cmb_UpdateW4MODE: TComboBox;
    btn_UpdateSave: TAdvGlassButton;
    AdvGlassButton2: TAdvGlassButton;
    btn_UpdateAllOpenMode: TAdvGlassButton;
    btn_UpdateAllManager: TAdvGlassButton;
    btn_UpdateTimeInitialize: TAdvGlassButton;
    tv_buildingCode: TTreeView;
    MenuImageList16: TImageList;
    ed_BuildingCode: TAdvEdit;
    ed_SearchName: TAdvEdit;
    tv_buildingName: TTreeView;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    procedure menuTabChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AddSaveClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sg_ListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure sg_ListDblClick(Sender: TObject);
    procedure ed_SearchNameChange(Sender: TObject);
    procedure btn_UpdateSaveClick(Sender: TObject);
    procedure CommandArrayCommandsTGRADEREFRESHExecute(Command: TCommand;
      Params: TStringList);
    procedure ed_InsertNameKeyPress(Sender: TObject; var Key: Char);
    procedure ed_UpdateNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmb_SearchAreaChange(Sender: TObject);
    procedure cmb_AddW1ModeChange(Sender: TObject);
    procedure btn_AddTimeInitializeClick(Sender: TObject);
    procedure btn_AddAllManagerClick(Sender: TObject);
    procedure btn_UpdateTimeInitializeClick(Sender: TObject);
    procedure btn_UpdateAllManagerClick(Sender: TObject);
  private
    BuildingCodeList : TStringList;
    FloorCodeList : TStringList;
    DeviceIDCodeList : TStringList;
    AreaCodeList : TStringList;
    SetBuildingCodeList : TStringList;
    SetFloorCodeList : TStringList;
    SetAreaCodeList : TStringList;
    UpdateBuildingCodeList : TStringList;
    UpdateFloorCodeList : TStringList;
    UpdateAreaCodeList : TStringList;
    L_nPageListMaxCount : integer;
    L_nCheckCount : integer;
    L_stButtonCloseCaption : string;
    L_stButtonPrevCaption : string;
    L_stDeleteCaption : string;
    L_stMenuID : string;
    { Private declarations }
    Function FormNameSetting:Boolean;
    procedure ComboBoxDoorModeInitiailize(cmb_Box:TComboBox);
    procedure FontSetting;
    Function SearchList(aCurrentCode:string;aTopRow:integer = 0):Boolean;
    Function LoadUpdateSchedule(aNodeNo,aEcuID,aDoorNo:string):Boolean;
  private
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);

    Function CheckScheduleFormat(a1Time,a2Time,a3Time,a4Time,a5Time:string):Boolean;
  public
    { Public declarations }
    procedure FormChangeEvent(aFormName:integer);
  end;

var
  fmDoorSchedule: TfmDoorSchedule;

implementation
uses
  uCommonVariable,
  uDataBase,
  uDBFormName,
  uDBFunction,
  uDBInsert,
  uDBSelect,
  uDBUpdate,
  uFormFontUtil,
  uFormUtil,
  uFunction;
{$R *.dfm}

procedure TfmDoorSchedule.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;

end;

procedure TfmDoorSchedule.btn_AddAllManagerClick(Sender: TObject);
begin
  inherited;
  cmb_AddW1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddW2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddW3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddW4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddW5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_AddS1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddS2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddS3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddS4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddS5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_AddN1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddN2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddN3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddN4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddN5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_AddH1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddH2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddH3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddH4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_AddH5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_AddW1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddW2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddW3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddW4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddW5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_AddS1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddS2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddS3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddS4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddS5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_AddN1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddN2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddN3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddN4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddN5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_AddH1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddH2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddH3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddH4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_AddH5Mode.Color := TAdvGlassButton(sender).BackColor;

end;

procedure TfmDoorSchedule.btn_AddClick(Sender: TObject);
var
  stMessage : string;
begin
  inherited;
  stMessage := '스케줄 적용할 출입문이 선택 되지 않았습니다.';
  if L_nCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;
  menuTab.ActiveTabIndex := 2;
  menuTabChange(self);
end;

procedure TfmDoorSchedule.btn_AddSaveClick(Sender: TObject);
var
  stMessage : string;
  stW1Time,stW2Time,stW3Time,stW4Time,stW5Time : string;
  stS1Time,stS2Time,stS3Time,stS4Time,stS5Time : string;
  stN1Time,stN2Time,stN3Time,stN4Time,stN5Time : string;
  stH1Time,stH2Time,stH3Time,stH4Time,stH5Time : string;
  i : integer;
  bChkState : Boolean;
  stNodeNo,stECUID,stDOORNO : string;
  stClientIP : string;
  stTime : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stW1Time := FillZeroStrNum(cmb_W1HH.Text,2) + FillZeroStrNum(cmb_W1MM.Text,2);
  stW2Time := FillZeroStrNum(cmb_W2HH.Text,2) + FillZeroStrNum(cmb_W2MM.Text,2);
  stW3Time := FillZeroStrNum(cmb_W3HH.Text,2) + FillZeroStrNum(cmb_W3MM.Text,2);
  stW4Time := FillZeroStrNum(cmb_W4HH.Text,2) + FillZeroStrNum(cmb_W4MM.Text,2);
  stW5Time := '2400';

  if Not CheckScheduleFormat(stW1Time,stW2Time,stW3Time,stW4Time,stW5Time) then
  begin
    stMessage := '평일스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stS1Time := FillZeroStrNum(cmb_S1HH.Text,2) + FillZeroStrNum(cmb_S1MM.Text,2);
  stS2Time := FillZeroStrNum(cmb_S2HH.Text,2) + FillZeroStrNum(cmb_S2MM.Text,2);
  stS3Time := FillZeroStrNum(cmb_S3HH.Text,2) + FillZeroStrNum(cmb_S3MM.Text,2);
  stS4Time := FillZeroStrNum(cmb_S4HH.Text,2) + FillZeroStrNum(cmb_S4MM.Text,2);
  stS5Time := '2400';

  if Not CheckScheduleFormat(stS1Time,stS2Time,stS3Time,stS4Time,stS5Time) then
  begin
    stMessage := '토요일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stN1Time := FillZeroStrNum(cmb_N1HH.Text,2) + FillZeroStrNum(cmb_N1MM.Text,2);
  stN2Time := FillZeroStrNum(cmb_N2HH.Text,2) + FillZeroStrNum(cmb_N2MM.Text,2);
  stN3Time := FillZeroStrNum(cmb_N3HH.Text,2) + FillZeroStrNum(cmb_N3MM.Text,2);
  stN4Time := FillZeroStrNum(cmb_N4HH.Text,2) + FillZeroStrNum(cmb_N4MM.Text,2);
  stN5Time := '2400';

  if Not CheckScheduleFormat(stN1Time,stN2Time,stN3Time,stN4Time,stN5Time) then
  begin
    stMessage := '일요일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stH1Time := FillZeroStrNum(cmb_H1HH.Text,2) + FillZeroStrNum(cmb_H1MM.Text,2);
  stH2Time := FillZeroStrNum(cmb_H2HH.Text,2) + FillZeroStrNum(cmb_H2MM.Text,2);
  stH3Time := FillZeroStrNum(cmb_H3HH.Text,2) + FillZeroStrNum(cmb_H3MM.Text,2);
  stH4Time := FillZeroStrNum(cmb_H4HH.Text,2) + FillZeroStrNum(cmb_H4MM.Text,2);
  stH5Time := '2400';

  if cmb_AddW1Mode.ItemIndex < 0 then cmb_AddW1Mode.ItemIndex := 0;
  if cmb_AddW2Mode.ItemIndex < 0 then cmb_AddW2Mode.ItemIndex := 0;
  if cmb_AddW3Mode.ItemIndex < 0 then cmb_AddW3Mode.ItemIndex := 0;
  if cmb_AddW4Mode.ItemIndex < 0 then cmb_AddW4Mode.ItemIndex := 0;
  if cmb_AddW5Mode.ItemIndex < 0 then cmb_AddW5Mode.ItemIndex := 0;

  if cmb_AddS1Mode.ItemIndex < 0 then cmb_AddS1Mode.ItemIndex := 0;
  if cmb_AddS2Mode.ItemIndex < 0 then cmb_AddS2Mode.ItemIndex := 0;
  if cmb_AddS3Mode.ItemIndex < 0 then cmb_AddS3Mode.ItemIndex := 0;
  if cmb_AddS4Mode.ItemIndex < 0 then cmb_AddS4Mode.ItemIndex := 0;
  if cmb_AddS5Mode.ItemIndex < 0 then cmb_AddS5Mode.ItemIndex := 0;

  if cmb_AddN1Mode.ItemIndex < 0 then cmb_AddN1Mode.ItemIndex := 0;
  if cmb_AddN2Mode.ItemIndex < 0 then cmb_AddN2Mode.ItemIndex := 0;
  if cmb_AddN3Mode.ItemIndex < 0 then cmb_AddN3Mode.ItemIndex := 0;
  if cmb_AddN4Mode.ItemIndex < 0 then cmb_AddN4Mode.ItemIndex := 0;
  if cmb_AddN5Mode.ItemIndex < 0 then cmb_AddN5Mode.ItemIndex := 0;

  if cmb_AddH1Mode.ItemIndex < 0 then cmb_AddH1Mode.ItemIndex := 0;
  if cmb_AddH2Mode.ItemIndex < 0 then cmb_AddH2Mode.ItemIndex := 0;
  if cmb_AddH3Mode.ItemIndex < 0 then cmb_AddH3Mode.ItemIndex := 0;
  if cmb_AddH4Mode.ItemIndex < 0 then cmb_AddH4Mode.ItemIndex := 0;
  if cmb_AddH5Mode.ItemIndex < 0 then cmb_AddH5Mode.ItemIndex := 0;

  if Not CheckScheduleFormat(stH1Time,stH2Time,stH3Time,stH4Time,stH5Time) then
  begin
    stMessage := '특정일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;
  With sg_List do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bChkState);
      if bChkState then
      begin
        stNodeNo :=  cells[2,i];
        stECUID :=  cells[3,i];
        stDOORNO :=  cells[4,i];
        //평일
        if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'0') = 1 then
        begin
          stW5Time := '0000';
          dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'0',stW1Time,stW2Time,stW3Time,stW4Time,stW5Time,
                                               inttostr(cmb_AddW1Mode.ItemIndex),inttostr(cmb_AddW2Mode.ItemIndex),inttostr(cmb_AddW3Mode.ItemIndex),
                                               inttostr(cmb_AddW4Mode.ItemIndex),inttostr(cmb_AddW5Mode.ItemIndex),'N');
        end else
        begin
          stW5Time := '0000';
          dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'0',stW1Time,stW2Time,stW3Time,stW4Time,stW5Time,
                                               inttostr(cmb_AddW1Mode.ItemIndex),inttostr(cmb_AddW2Mode.ItemIndex),inttostr(cmb_AddW3Mode.ItemIndex),
                                               inttostr(cmb_AddW4Mode.ItemIndex),inttostr(cmb_AddW5Mode.ItemIndex),'N');
        end;
        //토요일
        if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'1') = 1 then
        begin
          stS5Time := '0000';
          dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'1',stS1Time,stS2Time,stS3Time,stS4Time,stS5Time,
                                               inttostr(cmb_AddS1Mode.ItemIndex),inttostr(cmb_AddS2Mode.ItemIndex),inttostr(cmb_AddS3Mode.ItemIndex),
                                               inttostr(cmb_AddS4Mode.ItemIndex),inttostr(cmb_AddS5Mode.ItemIndex),'N');
        end else
        begin
          stS5Time := '0000';
          dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'1',stS1Time,stS2Time,stS3Time,stS4Time,stS5Time,
                                               inttostr(cmb_AddS1Mode.ItemIndex),inttostr(cmb_AddS2Mode.ItemIndex),inttostr(cmb_AddS3Mode.ItemIndex),
                                               inttostr(cmb_AddS4Mode.ItemIndex),inttostr(cmb_AddS5Mode.ItemIndex),'N');
        end;
        //일요일
        if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'2') = 1 then
        begin
          stN5Time := '0000';
          dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'2',stN1Time,stN2Time,stN3Time,stN4Time,stN5Time,
                                               inttostr(cmb_AddN1Mode.ItemIndex),inttostr(cmb_AddN2Mode.ItemIndex),inttostr(cmb_AddN3Mode.ItemIndex),
                                               inttostr(cmb_AddN4Mode.ItemIndex),inttostr(cmb_AddN5Mode.ItemIndex),'N');
        end else
        begin
          stN5Time := '0000';
          dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'2',stN1Time,stN2Time,stN3Time,stN4Time,stN5Time,
                                               inttostr(cmb_AddN1Mode.ItemIndex),inttostr(cmb_AddN2Mode.ItemIndex),inttostr(cmb_AddN3Mode.ItemIndex),
                                               inttostr(cmb_AddN4Mode.ItemIndex),inttostr(cmb_AddN5Mode.ItemIndex),'N');
        end;
        //공휴일
        if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'3') = 1 then
        begin
          stH5Time := '0000';
          dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'3',stH1Time,stH2Time,stH3Time,stH4Time,stH5Time,
                                               inttostr(cmb_AddH1Mode.ItemIndex),inttostr(cmb_AddH2Mode.ItemIndex),inttostr(cmb_AddH3Mode.ItemIndex),
                                               inttostr(cmb_AddH4Mode.ItemIndex),inttostr(cmb_AddH5Mode.ItemIndex),'N');
        end else
        begin
          stH5Time := '0000';
          dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'3',stH1Time,stH2Time,stH3Time,stH4Time,stH5Time,
                                               inttostr(cmb_AddH1Mode.ItemIndex),inttostr(cmb_AddH2Mode.ItemIndex),inttostr(cmb_AddH3Mode.ItemIndex),
                                               inttostr(cmb_AddH4Mode.ItemIndex),inttostr(cmb_AddH5Mode.ItemIndex),'N');
        end;
      end;
    end;
  end;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);
  SearchList('');

  self.FindSubForm('Main').FindCommand('CHANGE').Params.Values['NAME'] := inttostr(FormDOORSCHEDULEADMIN);
  self.FindSubForm('Main').FindCommand('CHANGE').Execute;

end;

procedure TfmDoorSchedule.btn_AddTimeInitializeClick(Sender: TObject);
begin
  inherited;
  cmb_W1HH.Text := '05';
  cmb_W1MM.Text := '00';
  cmb_W2HH.Text := '12';
  cmb_W2MM.Text := '00';
  cmb_W3HH.Text := '13';
  cmb_W3MM.Text := '00';
  cmb_W4HH.Text := '18';
  cmb_W4MM.Text := '00';

  cmb_S1HH.Text := '05';
  cmb_S1MM.Text := '00';
  cmb_S2HH.Text := '12';
  cmb_S2MM.Text := '00';
  cmb_S3HH.Text := '13';
  cmb_S3MM.Text := '00';
  cmb_S4HH.Text := '18';
  cmb_S4MM.Text := '00';

  cmb_N1HH.Text := '05';
  cmb_N1MM.Text := '00';
  cmb_N2HH.Text := '12';
  cmb_N2MM.Text := '00';
  cmb_N3HH.Text := '13';
  cmb_N3MM.Text := '00';
  cmb_N4HH.Text := '18';
  cmb_N4MM.Text := '00';

  cmb_H1HH.Text := '05';
  cmb_H1MM.Text := '00';
  cmb_H2HH.Text := '12';
  cmb_H2MM.Text := '00';
  cmb_H3HH.Text := '13';
  cmb_H3MM.Text := '00';
  cmb_H4HH.Text := '18';
  cmb_H4MM.Text := '00';

end;

procedure TfmDoorSchedule.btn_SearchClick(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmDoorSchedule.btn_UpdateAllManagerClick(Sender: TObject);
begin
  inherited;
  cmb_UpdateW1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateW2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateW3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateW4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateW5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_UpdateS1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateS2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateS3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateS4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateS5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_UpdateN1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateN2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateN3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateN4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateN5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_UpdateH1Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateH2Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateH3Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateH4Mode.ItemIndex := TAdvGlassButton(sender).Tag;
  cmb_UpdateH5Mode.ItemIndex := TAdvGlassButton(sender).Tag;

  cmb_UpdateW1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateW2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateW3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateW4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateW5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_UpdateS1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateS2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateS3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateS4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateS5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_UpdateN1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateN2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateN3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateN4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateN5Mode.Color := TAdvGlassButton(sender).BackColor;

  cmb_UpdateH1Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateH2Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateH3Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateH4Mode.Color := TAdvGlassButton(sender).BackColor;
  cmb_UpdateH5Mode.Color := TAdvGlassButton(sender).BackColor;

end;

procedure TfmDoorSchedule.btn_UpdateSaveClick(Sender: TObject);
var
  stMessage : string;
  stW1Time,stW2Time,stW3Time,stW4Time,stW5Time : string;
  stS1Time,stS2Time,stS3Time,stS4Time,stS5Time : string;
  stN1Time,stN2Time,stN3Time,stN4Time,stN5Time : string;
  stH1Time,stH2Time,stH3Time,stH4Time,stH5Time : string;
  i : integer;
  bChkState : Boolean;
  stNodeNo,stECUID,stDOORNO : string;
  stClientIP : string;
  stTime : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stW1Time := FillZeroStrNum(cmb_UpdateW1HH.Text,2) + FillZeroStrNum(cmb_UpdateW1MM.Text,2);
  stW2Time := FillZeroStrNum(cmb_UpdateW2HH.Text,2) + FillZeroStrNum(cmb_UpdateW2MM.Text,2);
  stW3Time := FillZeroStrNum(cmb_UpdateW3HH.Text,2) + FillZeroStrNum(cmb_UpdateW3MM.Text,2);
  stW4Time := FillZeroStrNum(cmb_UpdateW4HH.Text,2) + FillZeroStrNum(cmb_UpdateW4MM.Text,2);
  stW5Time := '2400';

  if Not CheckScheduleFormat(stW1Time,stW2Time,stW3Time,stW4Time,stW5Time) then
  begin
    stMessage := '평일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stS1Time := FillZeroStrNum(cmb_UpdateS1HH.Text,2) + FillZeroStrNum(cmb_UpdateS1MM.Text,2);
  stS2Time := FillZeroStrNum(cmb_UpdateS2HH.Text,2) + FillZeroStrNum(cmb_UpdateS2MM.Text,2);
  stS3Time := FillZeroStrNum(cmb_UpdateS3HH.Text,2) + FillZeroStrNum(cmb_UpdateS3MM.Text,2);
  stS4Time := FillZeroStrNum(cmb_UpdateS4HH.Text,2) + FillZeroStrNum(cmb_UpdateS4MM.Text,2);
  stS5Time := '2400';

  if Not CheckScheduleFormat(stS1Time,stS2Time,stS3Time,stS4Time,stS5Time) then
  begin
    stMessage := '토요일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stN1Time := FillZeroStrNum(cmb_UpdateN1HH.Text,2) + FillZeroStrNum(cmb_UpdateN1MM.Text,2);
  stN2Time := FillZeroStrNum(cmb_UpdateN2HH.Text,2) + FillZeroStrNum(cmb_UpdateN2MM.Text,2);
  stN3Time := FillZeroStrNum(cmb_UpdateN3HH.Text,2) + FillZeroStrNum(cmb_UpdateN3MM.Text,2);
  stN4Time := FillZeroStrNum(cmb_UpdateN4HH.Text,2) + FillZeroStrNum(cmb_UpdateN4MM.Text,2);
  stN5Time := '2400';

  if Not CheckScheduleFormat(stN1Time,stN2Time,stN3Time,stN4Time,stN5Time) then
  begin
    stMessage := '일요일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stH1Time := FillZeroStrNum(cmb_UpdateH1HH.Text,2) + FillZeroStrNum(cmb_UpdateH1MM.Text,2);
  stH2Time := FillZeroStrNum(cmb_UpdateH2HH.Text,2) + FillZeroStrNum(cmb_UpdateH2MM.Text,2);
  stH3Time := FillZeroStrNum(cmb_UpdateH3HH.Text,2) + FillZeroStrNum(cmb_UpdateH3MM.Text,2);
  stH4Time := FillZeroStrNum(cmb_UpdateH4HH.Text,2) + FillZeroStrNum(cmb_UpdateH4MM.Text,2);
  stH5Time := '2400';

  if cmb_UpdateW1Mode.ItemIndex < 0 then cmb_UpdateW1Mode.ItemIndex := 0;
  if cmb_UpdateW2Mode.ItemIndex < 0 then cmb_UpdateW2Mode.ItemIndex := 0;
  if cmb_UpdateW3Mode.ItemIndex < 0 then cmb_UpdateW3Mode.ItemIndex := 0;
  if cmb_UpdateW4Mode.ItemIndex < 0 then cmb_UpdateW4Mode.ItemIndex := 0;
  if cmb_UpdateW5Mode.ItemIndex < 0 then cmb_UpdateW5Mode.ItemIndex := 0;

  if cmb_UpdateS1Mode.ItemIndex < 0 then cmb_UpdateS1Mode.ItemIndex := 0;
  if cmb_UpdateS2Mode.ItemIndex < 0 then cmb_UpdateS2Mode.ItemIndex := 0;
  if cmb_UpdateS3Mode.ItemIndex < 0 then cmb_UpdateS3Mode.ItemIndex := 0;
  if cmb_UpdateS4Mode.ItemIndex < 0 then cmb_UpdateS4Mode.ItemIndex := 0;
  if cmb_UpdateS5Mode.ItemIndex < 0 then cmb_UpdateS5Mode.ItemIndex := 0;

  if cmb_UpdateN1Mode.ItemIndex < 0 then cmb_UpdateN1Mode.ItemIndex := 0;
  if cmb_UpdateN2Mode.ItemIndex < 0 then cmb_UpdateN2Mode.ItemIndex := 0;
  if cmb_UpdateN3Mode.ItemIndex < 0 then cmb_UpdateN3Mode.ItemIndex := 0;
  if cmb_UpdateN4Mode.ItemIndex < 0 then cmb_UpdateN4Mode.ItemIndex := 0;
  if cmb_UpdateN5Mode.ItemIndex < 0 then cmb_UpdateN5Mode.ItemIndex := 0;

  if cmb_UpdateH1Mode.ItemIndex < 0 then cmb_UpdateH1Mode.ItemIndex := 0;
  if cmb_UpdateH2Mode.ItemIndex < 0 then cmb_UpdateH2Mode.ItemIndex := 0;
  if cmb_UpdateH3Mode.ItemIndex < 0 then cmb_UpdateH3Mode.ItemIndex := 0;
  if cmb_UpdateH4Mode.ItemIndex < 0 then cmb_UpdateH4Mode.ItemIndex := 0;
  if cmb_UpdateH5Mode.ItemIndex < 0 then cmb_UpdateH5Mode.ItemIndex := 0;

  if Not CheckScheduleFormat(stH1Time,stH2Time,stH3Time,stH4Time,stH5Time) then
  begin
    stMessage := '특정일 스케줄 포맷이 잘못 되었습니다.';
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;

  stNodeNo :=  ed_UpdateNodeNoCode.Text;
  stECUID :=  ed_UpdateEcuCode.Text;
  stDOORNO :=  ed_UpdateDoorCode.Text;
  //평일
  if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'0') = 1 then
  begin
    stW5Time := '0000';
    dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'0',stW1Time,stW2Time,stW3Time,stW4Time,stW5Time,
                                         inttostr(cmb_UpdateW1Mode.ItemIndex),inttostr(cmb_UpdateW2Mode.ItemIndex),inttostr(cmb_UpdateW3Mode.ItemIndex),
                                         inttostr(cmb_UpdateW4Mode.ItemIndex),inttostr(cmb_UpdateW5Mode.ItemIndex),'N');
  end else
  begin
    stW5Time := '0000';
    dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'0',stW1Time,stW2Time,stW3Time,stW4Time,stW5Time,
                                         inttostr(cmb_UpdateW1Mode.ItemIndex),inttostr(cmb_UpdateW2Mode.ItemIndex),inttostr(cmb_UpdateW3Mode.ItemIndex),
                                         inttostr(cmb_UpdateW4Mode.ItemIndex),inttostr(cmb_UpdateW5Mode.ItemIndex),'N');
  end;
  //토요일
  if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'1') = 1 then
  begin
    stS5Time := '0000';
    dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'1',stS1Time,stS2Time,stS3Time,stS4Time,stS5Time,
                                         inttostr(cmb_UpdateS1Mode.ItemIndex),inttostr(cmb_UpdateS2Mode.ItemIndex),inttostr(cmb_UpdateS3Mode.ItemIndex),
                                         inttostr(cmb_UpdateS4Mode.ItemIndex),inttostr(cmb_UpdateS5Mode.ItemIndex),'N');
  end else
  begin
    stS5Time := '0000';
    dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'1',stS1Time,stS2Time,stS3Time,stS4Time,stS5Time,
                                         inttostr(cmb_UpdateS1Mode.ItemIndex),inttostr(cmb_UpdateS2Mode.ItemIndex),inttostr(cmb_UpdateS3Mode.ItemIndex),
                                         inttostr(cmb_UpdateS4Mode.ItemIndex),inttostr(cmb_UpdateS5Mode.ItemIndex),'N');
  end;
  //일요일
  if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'2') = 1 then
  begin
    stN5Time := '0000';
    dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'2',stN1Time,stN2Time,stN3Time,stN4Time,stN5Time,
                                         inttostr(cmb_UpdateN1Mode.ItemIndex),inttostr(cmb_UpdateN2Mode.ItemIndex),inttostr(cmb_UpdateN3Mode.ItemIndex),
                                         inttostr(cmb_UpdateN4Mode.ItemIndex),inttostr(cmb_UpdateN5Mode.ItemIndex),'N');
  end else
  begin
    stN5Time := '0000';
    dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'2',stN1Time,stN2Time,stN3Time,stN4Time,stN5Time,
                                         inttostr(cmb_UpdateN1Mode.ItemIndex),inttostr(cmb_UpdateN2Mode.ItemIndex),inttostr(cmb_UpdateN3Mode.ItemIndex),
                                         inttostr(cmb_UpdateN4Mode.ItemIndex),inttostr(cmb_UpdateN5Mode.ItemIndex),'N');
  end;
  //공휴일
  if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(stNodeNo,stECUID,stDOORNO,'3') = 1 then
  begin
    stH5Time := '0000';
    dmDBUpdate.UpdateTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'3',stH1Time,stH2Time,stH3Time,stH4Time,stH5Time,
                                         inttostr(cmb_UpdateH1Mode.ItemIndex),inttostr(cmb_UpdateH2Mode.ItemIndex),inttostr(cmb_UpdateH3Mode.ItemIndex),
                                         inttostr(cmb_UpdateH4Mode.ItemIndex),inttostr(cmb_UpdateH5Mode.ItemIndex),'N');
  end else
  begin
    stH5Time := '0000';
    dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(stNodeNo,stECUID,stDOORNO,'3',stH1Time,stH2Time,stH3Time,stH4Time,stH5Time,
                                         inttostr(cmb_UpdateH1Mode.ItemIndex),inttostr(cmb_UpdateH2Mode.ItemIndex),inttostr(cmb_UpdateH3Mode.ItemIndex),
                                         inttostr(cmb_UpdateH4Mode.ItemIndex),inttostr(cmb_UpdateH5Mode.ItemIndex),'N');
  end;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);
  SearchList(stNodeNo + stEcuID + stDoorNo,sg_List.TopRow);

  self.FindSubForm('Main').FindCommand('CHANGE').Params.Values['NAME'] := inttostr(FormDOORSCHEDULEADMIN);
  self.FindSubForm('Main').FindCommand('CHANGE').Execute;

end;

procedure TfmDoorSchedule.btn_UpdateTimeInitializeClick(Sender: TObject);
begin
  inherited;
  cmb_UpdateW1HH.Text := '05';
  cmb_UpdateW1MM.Text := '00';
  cmb_UpdateW2HH.Text := '12';
  cmb_UpdateW2MM.Text := '00';
  cmb_UpdateW3HH.Text := '13';
  cmb_UpdateW3MM.Text := '00';
  cmb_UpdateW4HH.Text := '18';
  cmb_UpdateW4MM.Text := '00';

  cmb_UpdateS1HH.Text := '05';
  cmb_UpdateS1MM.Text := '00';
  cmb_UpdateS2HH.Text := '12';
  cmb_UpdateS2MM.Text := '00';
  cmb_UpdateS3HH.Text := '13';
  cmb_UpdateS3MM.Text := '00';
  cmb_UpdateS4HH.Text := '18';
  cmb_UpdateS4MM.Text := '00';

  cmb_UpdateN1HH.Text := '05';
  cmb_UpdateN1MM.Text := '00';
  cmb_UpdateN2HH.Text := '12';
  cmb_UpdateN2MM.Text := '00';
  cmb_UpdateN3HH.Text := '13';
  cmb_UpdateN3MM.Text := '00';
  cmb_UpdateN4HH.Text := '18';
  cmb_UpdateN4MM.Text := '00';

  cmb_UpdateH1HH.Text := '05';
  cmb_UpdateH1MM.Text := '00';
  cmb_UpdateH2HH.Text := '12';
  cmb_UpdateH2MM.Text := '00';
  cmb_UpdateH3HH.Text := '13';
  cmb_UpdateH3MM.Text := '00';
  cmb_UpdateH4HH.Text := '18';
  cmb_UpdateH4MM.Text := '00';

end;

function TfmDoorSchedule.CheckScheduleFormat(a1Time, a2Time, a3Time, a4Time,
  a5Time: string): Boolean;
begin
  result := False;

  if Not isDigit(a1Time) then Exit;
  if Not isDigit(a2Time) then Exit;
  if Not isDigit(a3Time) then Exit;
  if Not isDigit(a4Time) then Exit;
  if Not isDigit(a5Time) then Exit;

  if strtoint(a1Time) >= strtoint(a2Time) then Exit;
  if strtoint(a2Time) >= strtoint(a3Time) then Exit;
  if strtoint(a3Time) >= strtoint(a4Time) then Exit;
  if strtoint(a4Time) >= strtoint(a5Time) then Exit;

  result := True;
end;

procedure TfmDoorSchedule.cmb_SearchAreaChange(Sender: TObject);
begin
  inherited;
  SearchList('');

end;

procedure TfmDoorSchedule.cmb_AddW1ModeChange(Sender: TObject);
begin
  inherited;
  if TComboBox(Sender).ItemIndex = 0 then TComboBox(Sender).Color := clLime
  else if TComboBox(Sender).ItemIndex = 1 then TComboBox(Sender).Color := clGreen
  else if TComboBox(Sender).ItemIndex = 2 then TComboBox(Sender).Color := clRed;
end;

procedure TfmDoorSchedule.ComboBoxDoorModeInitiailize(cmb_Box: TComboBox);
begin
  cmb_Box.Clear;
  cmb_Box.Items.Add(dmFormName.GetFormMessage('4','M00091'));
  cmb_Box.Items.Add(dmFormName.GetFormMessage('4','M00092'));
  cmb_Box.ItemIndex := 0;
end;

procedure TfmDoorSchedule.CommandArrayCommandsTGRADEREFRESHExecute(
  Command: TCommand; Params: TStringList);
begin
  inherited;
  menuTab.AdvOfficeTabs.Items[2].Enabled := IsInsertGrade;
  btn_Add.Enabled := IsInsertGrade;

end;

procedure TfmDoorSchedule.ed_InsertNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    btn_AddSaveClick(self);
  end;

end;

procedure TfmDoorSchedule.ed_SearchNameChange(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmDoorSchedule.ed_UpdateNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    btn_UpdateSaveClick(self);
  end;

end;

procedure TfmDoorSchedule.FontSetting;
begin
  dmFormFontUtil.TravelFormFontSetting(self,G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.TravelAdvOfficeTabSetOfficeStylerFontSetting(AdvOfficeTabSetOfficeStyler1, G_stFontName,inttostr(G_nFontSize));
  dmFormFontUtil.FormAdvOfficeTabSetOfficeStylerSetting(AdvOfficeTabSetOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormFontUtil.FormStyleSetting(self,AdvToolBarOfficeStyler1);
end;

procedure TfmDoorSchedule.FormChangeEvent(aFormName: integer);
var
  stCode : string;
  stCode1 : string;
  nIndex : integer;
begin

end;

procedure TfmDoorSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FormDOORSCHEDULEADMIN);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'FALSE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  BuildingCodeList.Free;
  FloorCodeList.Free;
  DeviceIDCodeList.Free;
  AreaCodeList.Free;
  SetBuildingCodeList.Free;
  SetFloorCodeList.Free;
  SetAreaCodeList.Free;
  UpdateBuildingCodeList.Free;
  UpdateFloorCodeList.Free;
  UpdateAreaCodeList.Free;

  Action := caFree;
end;

procedure TfmDoorSchedule.FormCreate(Sender: TObject);
begin
  inherited;
  L_nPageListMaxCount := 15;
  BuildingCodeList := TStringList.Create;
  FloorCodeList := TStringList.Create;
  DeviceIDCodeList := TStringList.Create;
  AreaCodeList := TStringList.Create;
  SetBuildingCodeList := TStringList.Create;
  SetFloorCodeList := TStringList.Create;
  SetAreaCodeList := TStringList.Create;
  UpdateBuildingCodeList := TStringList.Create;
  UpdateFloorCodeList := TStringList.Create;
  UpdateAreaCodeList := TStringList.Create;

  FontSetting;
end;

function TfmDoorSchedule.FormNameSetting: Boolean;
var
  stSql : string;
  nCommonLength : integer;
  nButtonLength : integer;
  nMenuLength : integer;
  TempAdoQuery : TADOQuery;
begin
  Caption := dmFormName.GetFormMessage('1','M00060');
  menuTab.AdvOfficeTabs[0].Caption := dmFormName.GetFormMessage('1','M00035');
  menuTab.AdvOfficeTabs[1].Caption := dmFormName.GetFormMessage('1','M00048');
  menuTab.AdvOfficeTabs[2].Caption := dmFormName.GetFormMessage('4','M00115');
  L_stButtonCloseCaption := dmFormName.GetFormMessage('1','M00035');
  L_stButtonPrevCaption := dmFormName.GetFormMessage('1','M00040');
  lb_SearchName.Caption.Text := dmFormName.GetFormMessage('4','M00039');
  btn_Search.Caption := dmFormName.GetFormMessage('4','M00007');
  btn_Add.Caption := dmFormName.GetFormMessage('4','M00115');

  btn_AddWeek.Caption := dmFormName.GetFormMessage('4','M00110');
  btn_UpdateWeek.Caption := dmFormName.GetFormMessage('4','M00110');
  btn_AddSaturday.Caption := dmFormName.GetFormMessage('4','M00111');
  btn_UpdateSaturday.Caption := dmFormName.GetFormMessage('4','M00111');
  btn_AddSunday.Caption := dmFormName.GetFormMessage('4','M00112');
  btn_UpdateSunday.Caption := dmFormName.GetFormMessage('4','M00112');
  btn_AddHoliday.Caption := dmFormName.GetFormMessage('4','M00113');
  btn_UpdateHoliday.Caption := dmFormName.GetFormMessage('4','M00113');

  btn_AddTimeInitialize.Caption := dmFormName.GetFormMessage('4','M00121');
  btn_UpdateTimeInitialize.Caption := dmFormName.GetFormMessage('4','M00121');
  btn_AddAllManager.Caption := dmFormName.GetFormMessage('4','M00122');
  btn_UpdateAllManager.Caption := dmFormName.GetFormMessage('4','M00122');
  btn_AddAllOpenMode.Caption := dmFormName.GetFormMessage('4','M00123');
  btn_UpdateAllOpenMode.Caption := dmFormName.GetFormMessage('4','M00123');

  btn_AddSave.Caption := dmFormName.GetFormMessage('4','M00124');
  btn_UpdateSave.Caption := dmFormName.GetFormMessage('4','M00124');

  pan_AddWeek1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_AddWeek2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_AddWeek3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_AddWeek4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_AddWeek5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_AddSaturday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_AddSaturday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_AddSaturday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_AddSaturday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_AddSaturday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_AddSunday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_AddSunday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_AddSunday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_AddSunday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_AddSunday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_AddHoliday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_AddHoliday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_AddHoliday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_AddHoliday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_AddHoliday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');


  pan_UpdateWeek1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_UpdateWeek2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_UpdateWeek3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_UpdateWeek4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_UpdateWeek5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_UpdateSaturday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_UpdateSaturday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_UpdateSaturday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_UpdateSaturday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_UpdateSaturday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_UpdateSunday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_UpdateSunday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_UpdateSunday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_UpdateSunday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_UpdateSunday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  pan_UpdateHoliday1.Caption.Text := dmFormName.GetFormMessage('4','M00116');
  pan_UpdateHoliday2.Caption.Text := dmFormName.GetFormMessage('4','M00117');
  pan_UpdateHoliday3.Caption.Text := dmFormName.GetFormMessage('4','M00118');
  pan_UpdateHoliday4.Caption.Text := dmFormName.GetFormMessage('4','M00119');
  pan_UpdateHoliday5.Caption.Text := dmFormName.GetFormMessage('4','M00120');

  lb_AddWeekHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddWeekHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddWeekHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddWeekHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddWeekHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSaturdayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSaturdayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSaturdayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSaturdayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSaturdayHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSundayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSundayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSundayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSundayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddSundayHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddHolidayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddHolidayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddHolidayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddHolidayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_AddHolidayHH5.Caption := dmFormName.GetFormMessage('4','M00108');

  lb_UpdateWeekHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateWeekHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateWeekHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateWeekHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateWeekHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSaturdayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSaturdayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSaturdayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSaturdayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSaturdayHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSundayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSundayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSundayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSundayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateSundayHH5.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateHolidayHH1.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateHolidayHH2.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateHolidayHH3.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateHolidayHH4.Caption := dmFormName.GetFormMessage('4','M00108');
  lb_UpdateHolidayHH5.Caption := dmFormName.GetFormMessage('4','M00108');

  lb_AddWeekMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddWeekMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddWeekMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddWeekMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddWeekMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSaturdayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSaturdayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSaturdayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSaturdayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSaturdayMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSundayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSundayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSundayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSundayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddSundayMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddHolidayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddHolidayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddHolidayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddHolidayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_AddHolidayMM5.Caption := dmFormName.GetFormMessage('4','M00109');

  lb_UpdateWeekMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateWeekMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateWeekMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateWeekMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateWeekMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSaturdayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSaturdayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSaturdayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSaturdayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSaturdayMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSundayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSundayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSundayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSundayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateSundayMM5.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateHolidayMM1.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateHolidayMM2.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateHolidayMM3.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateHolidayMM4.Caption := dmFormName.GetFormMessage('4','M00109');
  lb_UpdateHolidayMM5.Caption := dmFormName.GetFormMessage('4','M00109');

  with sg_List do
  begin
    hint := dmFormName.GetFormMessage('2','M00012');
    Cells[1,0] := dmFormName.GetFormMessage('4','M00039');
  end;

  ComboBoxDoorModeInitiailize(cmb_AddW1Mode);
  ComboBoxDoorModeInitiailize(cmb_AddW2Mode);
  ComboBoxDoorModeInitiailize(cmb_AddW3Mode);
  ComboBoxDoorModeInitiailize(cmb_AddW4Mode);
  ComboBoxDoorModeInitiailize(cmb_AddW5Mode);
  ComboBoxDoorModeInitiailize(cmb_AddS1Mode);
  ComboBoxDoorModeInitiailize(cmb_AddS2Mode);
  ComboBoxDoorModeInitiailize(cmb_AddS3Mode);
  ComboBoxDoorModeInitiailize(cmb_AddS4Mode);
  ComboBoxDoorModeInitiailize(cmb_AddS5Mode);
  ComboBoxDoorModeInitiailize(cmb_AddN1Mode);
  ComboBoxDoorModeInitiailize(cmb_AddN2Mode);
  ComboBoxDoorModeInitiailize(cmb_AddN3Mode);
  ComboBoxDoorModeInitiailize(cmb_AddN4Mode);
  ComboBoxDoorModeInitiailize(cmb_AddN5Mode);
  ComboBoxDoorModeInitiailize(cmb_AddH1Mode);
  ComboBoxDoorModeInitiailize(cmb_AddH2Mode);
  ComboBoxDoorModeInitiailize(cmb_AddH3Mode);
  ComboBoxDoorModeInitiailize(cmb_AddH4Mode);
  ComboBoxDoorModeInitiailize(cmb_AddH5Mode);

  ComboBoxDoorModeInitiailize(cmb_UpdateW1Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateW2Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateW3Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateW4Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateW5Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateS1Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateS2Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateS3Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateS4Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateS5Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateN1Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateN2Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateN3Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateN4Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateN5Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateH1Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateH2Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateH3Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateH4Mode);
  ComboBoxDoorModeInitiailize(cmb_UpdateH5Mode);

end;

procedure TfmDoorSchedule.FormResize(Sender: TObject);
begin
  inherited;
  BodyPanel.Left := 0;
  BodyPanel.Top := 0;
  BodyPanel.Height := Height - menuTab.Height;

end;

procedure TfmDoorSchedule.FormShow(Sender: TObject);
var
  stNodeNo : string;
  stBuildingCode : string;
  stFloorCode : string;
begin
  inherited;
  WindowState := wsMaximized;

  stNodeNo := '';

  FormNameSetting;


  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(FormDOORSCHEDULEADMIN);
  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;

  menuTab.ActiveTabIndex := 1;
  menuTabChange(self);
  SearchList('');

end;

function TfmDoorSchedule.LoadUpdateSchedule(aNodeNo, aEcuID,
  aDoorNo: string): Boolean;
var
  i : integer;
  stSql : string;
  TempAdoQuery : TADOQuery;
begin
  for i := 0 to 3 do
  begin
    if dmDBFunction.CheckTB_DOORSCHEDULE_DayCode(aNodeNo,aEcuID,aDoorNo,inttostr(i)) < 1 then
    begin
      dmDBInsert.InsertIntoTB_DOORSCHEDULE_All(aNodeNo,aEcuID,aDoorNo,inttostr(i),'0500','1200','1300','1600','0000','0','0','0','0','0','N');
    end;
  end;
  stSql := dmDBSelect.SelectTB_DOORSCHEDULE_DoorNo(aNodeNo,aEcuID,aDoorNo);

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

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
        if FindField('DS_DAYCODE').AsString = '0' then
        begin
          cmb_UpdateW1HH.Text := copy(FindField('DS_TIME1').AsString,1,2);
          cmb_UpdateW1MM.Text := copy(FindField('DS_TIME1').AsString,3,2);
          cmb_UpdateW2HH.Text := copy(FindField('DS_TIME2').AsString,1,2);
          cmb_UpdateW2MM.Text := copy(FindField('DS_TIME2').AsString,3,2);
          cmb_UpdateW3HH.Text := copy(FindField('DS_TIME3').AsString,1,2);
          cmb_UpdateW3MM.Text := copy(FindField('DS_TIME3').AsString,3,2);
          cmb_UpdateW4HH.Text := copy(FindField('DS_TIME4').AsString,1,2);
          cmb_UpdateW4MM.Text := copy(FindField('DS_TIME4').AsString,3,2);
          cmb_UpdateW5HH.Text := '24';
          cmb_UpdateW5MM.Text := '00';
          cmb_UpdateW1MODE.ItemIndex := FindField('DS_TIMEMODE1').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateW1MODE);
          cmb_UpdateW2MODE.ItemIndex := FindField('DS_TIMEMODE2').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateW2MODE);
          cmb_UpdateW3MODE.ItemIndex := FindField('DS_TIMEMODE3').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateW3MODE);
          cmb_UpdateW4MODE.ItemIndex := FindField('DS_TIMEMODE4').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateW4MODE);
          cmb_UpdateW5MODE.ItemIndex := FindField('DS_TIMEMODE5').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateW5MODE);
        end else if FindField('DS_DAYCODE').AsString = '1' then
        begin
          cmb_UpdateS1HH.Text := copy(FindField('DS_TIME1').AsString,1,2);
          cmb_UpdateS1MM.Text := copy(FindField('DS_TIME1').AsString,3,2);
          cmb_UpdateS2HH.Text := copy(FindField('DS_TIME2').AsString,1,2);
          cmb_UpdateS2MM.Text := copy(FindField('DS_TIME2').AsString,3,2);
          cmb_UpdateS3HH.Text := copy(FindField('DS_TIME3').AsString,1,2);
          cmb_UpdateS3MM.Text := copy(FindField('DS_TIME3').AsString,3,2);
          cmb_UpdateS4HH.Text := copy(FindField('DS_TIME4').AsString,1,2);
          cmb_UpdateS4MM.Text := copy(FindField('DS_TIME4').AsString,3,2);
          cmb_UpdateS5HH.Text := '24';
          cmb_UpdateS5MM.Text := '00';
          cmb_UpdateS1MODE.ItemIndex := FindField('DS_TIMEMODE1').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateS1MODE);
          cmb_UpdateS2MODE.ItemIndex := FindField('DS_TIMEMODE2').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateS2MODE);
          cmb_UpdateS3MODE.ItemIndex := FindField('DS_TIMEMODE3').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateS3MODE);
          cmb_UpdateS4MODE.ItemIndex := FindField('DS_TIMEMODE4').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateS4MODE);
          cmb_UpdateS5MODE.ItemIndex := FindField('DS_TIMEMODE5').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateS5MODE);
        end else if FindField('DS_DAYCODE').AsString = '2' then
        begin
          cmb_UpdateN1HH.Text := copy(FindField('DS_TIME1').AsString,1,2);
          cmb_UpdateN1MM.Text := copy(FindField('DS_TIME1').AsString,3,2);
          cmb_UpdateN2HH.Text := copy(FindField('DS_TIME2').AsString,1,2);
          cmb_UpdateN2MM.Text := copy(FindField('DS_TIME2').AsString,3,2);
          cmb_UpdateN3HH.Text := copy(FindField('DS_TIME3').AsString,1,2);
          cmb_UpdateN3MM.Text := copy(FindField('DS_TIME3').AsString,3,2);
          cmb_UpdateN4HH.Text := copy(FindField('DS_TIME4').AsString,1,2);
          cmb_UpdateN4MM.Text := copy(FindField('DS_TIME4').AsString,3,2);
          cmb_UpdateN5HH.Text := '24';
          cmb_UpdateN5MM.Text := '00';
          cmb_UpdateN1MODE.ItemIndex := FindField('DS_TIMEMODE1').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateN1MODE);
          cmb_UpdateN2MODE.ItemIndex := FindField('DS_TIMEMODE2').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateN2MODE);
          cmb_UpdateN3MODE.ItemIndex := FindField('DS_TIMEMODE3').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateN3MODE);
          cmb_UpdateN4MODE.ItemIndex := FindField('DS_TIMEMODE4').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateN4MODE);
          cmb_UpdateN5MODE.ItemIndex := FindField('DS_TIMEMODE5').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateN5MODE);
        end else if FindField('DS_DAYCODE').AsString = '3' then
        begin
          cmb_UpdateH1HH.Text := copy(FindField('DS_TIME1').AsString,1,2);
          cmb_UpdateH1MM.Text := copy(FindField('DS_TIME1').AsString,3,2);
          cmb_UpdateH2HH.Text := copy(FindField('DS_TIME2').AsString,1,2);
          cmb_UpdateH2MM.Text := copy(FindField('DS_TIME2').AsString,3,2);
          cmb_UpdateH3HH.Text := copy(FindField('DS_TIME3').AsString,1,2);
          cmb_UpdateH3MM.Text := copy(FindField('DS_TIME3').AsString,3,2);
          cmb_UpdateH4HH.Text := copy(FindField('DS_TIME4').AsString,1,2);
          cmb_UpdateH4MM.Text := copy(FindField('DS_TIME4').AsString,3,2);
          cmb_UpdateH5HH.Text := '24';
          cmb_UpdateH5MM.Text := '00';
          cmb_UpdateH1MODE.ItemIndex := FindField('DS_TIMEMODE1').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateH1MODE);
          cmb_UpdateH2MODE.ItemIndex := FindField('DS_TIMEMODE2').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateH2MODE);
          cmb_UpdateH3MODE.ItemIndex := FindField('DS_TIMEMODE3').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateH3MODE);
          cmb_UpdateH4MODE.ItemIndex := FindField('DS_TIMEMODE4').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateH4MODE);
          cmb_UpdateH5MODE.ItemIndex := FindField('DS_TIMEMODE5').AsInteger;
          cmb_AddW1ModeChange(cmb_UpdateH5MODE);
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

procedure TfmDoorSchedule.menuTabChange(Sender: TObject);
var
  stNodeNo : string;
  stMessage : string;
begin
  inherited;
  if menuTab.ActiveTabIndex = 0 then //Ȩ
  begin
    if menuTab.AdvOfficeTabs.Items[0].Caption = L_stButtonCloseCaption then Close
    else
    begin
      menuTab.ActiveTabIndex := 1;
      menuTabChange(self);
    end;
  end else if menuTab.ActiveTabIndex = 1 then
  begin
    menuTab.AdvOfficeTabs.Items[0].Caption := L_stButtonCloseCaption;
    List.Visible := True;
    Add.Visible := False;
    List.Align := alClient;
    Update.Visible := False;

  end else if menuTab.ActiveTabIndex = 2 then
  begin
    stMessage := '스케줄 적용할 출입문이 선택 되지 않았습니다.';
    if L_nCheckCount = 0 then
    begin
      Application.MessageBox(PChar(stMessage),'Information',MB_OK);
      menuTab.ActiveTabIndex := 1;
      Exit;
    end;

    menuTab.AdvOfficeTabs.Items[0].Caption := L_stButtonPrevCaption;
    List.Visible := False;
    Add.Visible := True;
    Add.Align := alClient;
    Update.Visible := False;
  end;
end;

function TfmDoorSchedule.SearchList(aCurrentCode:string;aTopRow:integer = 0): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stBuildingCode : string;
begin
  if ed_BuildingCode.Text = '' then ed_BuildingCode.Text := '0';

  stBuildingCode := ed_BuildingCode.Text;

  GridInit(sg_List,2,2,true);
  stSql := dmDBSelect.SelectTB_DOOR_ScheduleDoorName(ed_SearchName.Text);
  L_nCheckCount := 0;

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

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
      with sg_List do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DO_NAME').AsString;
          cells[2,nRow] := FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength);
          cells[3,nRow] := FindField('DE_DEVICEID').AsString;
          cells[4,nRow] := FindField('DO_DOORNO').AsString;
          if (FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FindField('DE_DEVICEID').AsString + FindField('DO_DOORNO').AsString)  = aCurrentCode then
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
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;


procedure TfmDoorSchedule.sg_ListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
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

procedure TfmDoorSchedule.sg_ListDblClick(Sender: TObject);
begin
  inherited;
  with sg_List do
  begin
    ed_UpdateNodeNoCode.Text := cells[2,Row];
    ed_UpdateEcuCode.Text := cells[3,Row];
    ed_UpdateDoorCode.Text := cells[4,Row];
    LoadUpdateSchedule(ed_UpdateNodeNoCode.Text,ed_UpdateEcuCode.Text,ed_UpdateDoorCode.Text);
  end;
  menuTab.AdvOfficeTabs.Items[0].Caption := L_stButtonPrevCaption;
  Update.Visible := True;
  Update.Align := alClient;
  List.Visible := False;
  Add.Visible := False;

end;

initialization
  RegisterClass(TfmDoorSchedule);
Finalization
  UnRegisterClass(TfmDoorSchedule);

end.