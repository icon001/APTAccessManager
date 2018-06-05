unit uExcelSave;

interface

uses
  SysUtils, Classes,ComObj,AdvGrid,Gauges,Dialogs,Forms;

type
  TdmExcelSave = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function ExcelPrintOut(StringGrid:TAdvStringGrid;refFileName,SaveFileName:String;FileOut:Boolean;ExcelRowStart:integer;stTitle:string;bRowHeader,bColHeader:Boolean;Gauge:TGauge=nil):Boolean;
  end;

var
  dmExcelSave: TdmExcelSave;

implementation

{$R *.dfm}

{ TdmExcelSave }

function TdmExcelSave.ExcelPrintOut(StringGrid: TAdvStringGrid;
  refFileName, SaveFileName: String; FileOut: Boolean;
  ExcelRowStart: integer; stTitle: string; bRowHeader, bColHeader: Boolean;
  Gauge: TGauge): Boolean;
var
  oXL, oWB, oSheet, oRng, VArray : Variant;
  nCol1,nCol2 : Integer;
  Loop : Integer;
  sCurDay,sPreDay : String;
  curDate : TDateTime;
  mergeStart :char;
  i,j,k : Integer;
  st : String;
  nColChar : integer;
  nFixCol,nFixRow : integer;
  stCellRange : string;
begin
  Result := False;
  Try
    oXL := CreateOleObject('Excel.Application');
  Except
    showmessage('엑셀저장 실패로 CSV포맷으로 저장 됩니다.');
    SaveFileName := copy(SaveFileName,1,Length(SaveFileName) - 3) + 'csv';
    StringGrid.SaveToCSV(SaveFileName);
    exit;
  End;

  Try
    if FileExists(refFileName) = False then
    begin
      showmessage('엑셀저장 실패로 CSV포맷으로 저장 됩니다.');
      SaveFileName := copy(SaveFileName,1,Length(SaveFileName) - 3) + 'csv';
      StringGrid.SaveToCSV(SaveFileName);
      exit;
    end;


    oXL.Workbooks.Open(refFileName);
    oXL.DisplayAlerts := False;
  //  oXL.Visible := True;
    oSheet := oXL.ActiveSheet;



    with StringGrid do
    begin

      //타이틀을 적자
      nCol1 := ColCount div 26;
      nCol2 := (ColCount mod 26) + 1;
      if bRowHeader then
      begin
        oSheet.Cells[0,ExcelRowStart - 1] := stTitle;
        //oSheet.Range['A' + inttostr(ExcelRowStart - 1)].Value := stTitle;
        if bColHeader then nFixCol := 0
        else nFixCol := FixedCols ;
        for i:= 0 to FixedRows - 1 do
        begin
          for j:= nFixCol to ColCount - 1 do
          begin
            oSheet.Cells[j,i+ ExcelRowStart]:= Cells[j,i];
            {nColChar := j div 26;
            if j < 26 then
              oXL.Range[Chr(Ord('A') + j ) + inttostr(i+ ExcelRowStart)].Value := Cells[j,i]
            else
              oXL.Range[Chr(Ord('A') + nColChar - 1 ) + Chr(Ord('A') + j - (26 * nColChar) ) + inttostr(i+ ExcelRowStart)].Value := Cells[j,i];
            }
          end;
        end;
        ExcelRowStart := ExcelRowStart + FixedRows ;
      end
      else
      begin
        oSheet.Cells[0,ExcelRowStart - FixedRows - 1] := stTitle;
        //oSheet.Range['A' + inttostr(ExcelRowStart - FixedRows - 1)].Value := stTitle;
      end;

      Gauge.MaxValue := ( RowCount - FixedRows );
      Gauge.Progress := 0;
      for i := FixedRows to RowCount - 1 do
      begin

        if i <  RowCount - 2 then    //한칸씩 삽입
        begin
          //if ColCount < 26 then stCellRange := 'A' + inttostr(i+ ExcelRowStart - FixedRows + 1) + ':' + Chr(Ord('A') + nCol1 ) + Chr(Ord('A') + nCol2 - 1 ) +  inttostr(i+ ExcelRowStart - FixedRows + 1)
          //else                  stCellRange := 'A' + inttostr(i+ ExcelRowStart - FixedRows + 1) + ':' + Chr(Ord('A') + nCol1 -1 ) + Chr(Ord('A') + nCol2 - 1 ) +  inttostr(i+ ExcelRowStart - FixedRows + 1);
          //oSheet.Range[stCellRange].EntireRow.insert;
          oSheet.insertRows(i+ ExcelRowStart - FixedRows + 1,1);//.rows[i+ ExcelRowStart - FixedRows + 1];
        end;
        Gauge.Progress := Gauge.Progress + 1;
        Application.ProcessMessages;
      end;
      StringGrid.CopyToClipBoard;
      oSheet.SelectCells(0,ExcelRowStart - 1,0,ExcelRowStart - 1);
      //oSheet.Range['A' + inttostr(ExcelRowStart - 1), 'A' + inttostr(ExcelRowStart - 1)].Select;
      oSheet.Paste;
    end;//With

    //oXL.Visible := False;
    if FileOut then  oSheet.SaveAs(SaveFileName)
    else  oSheet.PrintOut;
    oXL.ActiveWorkbook.Close(False);
    oXL.Quit;
  Except
    oXL.ActiveWorkbook.Close(False);
    oXL.Quit;
    if FileOut then
    begin
      showmessage('엑셀저장 실패로 CSV포맷으로 저장 됩니다.');
      SaveFileName := copy(SaveFileName,1,Length(SaveFileName) - 3) + 'csv';
      StringGrid.SaveToCSV(SaveFileName);
    end else
    begin
      showmessage('엑셀파일 문제로 출력 실패 하였습니다.');
    end;
    exit;
  End;
  Result := True;
end;

end.
(*
unit
Unit1;
interface
uses  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,  StdCtrls;
type
TForm1 = class(TForm)
Button1: TButton;
procedure Button1Click(Sender: TObject);
procedure DisplayQuarterlySales(oWS : Variant);
private
{ Private declarations }
public
{ Public declarations }
end;
var
Form1: TForm1;
Const xlVAlignCenter = -4108;
Const xlThin = 2;
Const xlEdgeBottom = 9;
Const xlDouble = -4119;
Const xlThick = 4;
Const xl3DColumn = -4100;
Const xlColumns = 2;
Const xlLocationAsObject = 2;
implementation
uses ComObj;
{$R *.DFM}
procedure TForm1.DisplayQuarterlySales(oWS : Variant);
var
  oResizeRange, oChart, oSeries: Variant;
  iNumQtrs,iRet : Integer;
  sMsg : String;
begin
// Determine how many quarters to display data for
  for iNumQtrs := 4 downto 2 do
  begin
    sMsg := 'Enter sales data for ' + IntToStr(iNumQtrs) + ' quarter(s)?';
    if MessageDlg(sMsg,mtConfirmation,[mbYes,mbNo],0) = mrYes then  break;
  end;
  sMsg := 'Displaying data for ' + IntToStr(iNumQtrs) + ' quarter(s).';
  MessageDlg(sMsg,mtInformation,[mbOK],0);
  // Starting at E1, fill headers for the number of columns selected
  oResizeRange := oWS.Range['E1:' + Chr(Ord('E') + iNumQtrs - 1) + '1'];
  oResizeRange.Formula := '="Q" & COLUMN()-4 & CHAR(10) & "Sales"';
  // Change the orientation and WrapText properties for the headers
  oResizeRange.Orientation := 38;
  oResizeRange.WrapText := True;
  // Fill the interior color of the headers
  oResizeRange.Interior.ColorIndex := 36;
  // Fill the columns with a formula and apply a number format
  oResizeRange := oWS.Range['E2:' + Chr(Ord('E') + iNumQtrs - 1) + '6'];
  oResizeRange.Formula := '=RAND()*100';
  oResizeRange.NumberFormat := '$0.00';
  // Apply borders to the Sales  data and headers
  oResizeRange := oWS.Range['E1:' + Chr(Ord('E') + iNumQtrs - 1) + '6'];
  oResizeRange.Borders.Weight := xlThin;
  // Add a totals formula for the sales data and apply a border
  oResizeRange := oWS.Range['E8:' + Chr(Ord('E') + iNumQtrs - 1) + '8'];
  oResizeRange.Formula := '=SUM(E2:E6)';
  oResizeRange.Borders.Item[xlEdgeBottom].LineStyle := xlDouble;
  oResizeRange.Borders.Item[xlEdgeBottom].Weight := xlThick;
  // Add a chart for the selected data
  oResizeRange := oWS.Range['E2:' + Chr(Ord('E') + iNumQtrs - 1) + '6'];
  oChart := oWS.Parent.Charts.Add;
  oChart.ChartWizard(oResizeRange,xl3DColumn,,xlColumns);
  oResizeRange := oWS.Range['A2:A6'];
  oChart.SeriesCollection.Item[1].XValues := oResizeRange;
  iRet := oChart.SeriesCollection.Count;
  for iRet := 1 to iNumQtrs do  begin
    sMsg :=  '="Q' + IntToStr(iRet) + '"';
    oChart.SeriesCollection.Item[iRet].Name := sMsg;
  end;
  oChart.Location(xlLocationAsObject,oWS.Name);
  // Move the chart so as not to cover your data
  oWS.Shapes.Item(1).Top := oWS.Rows.Item[10].Top;
  oWS.Shapes.Item(1).Left := oWS.Columns.Item[2].Left
end;
procedure TForm1.Button1Click(Sender: TObject);
var
  oXL, oWB, oSheet, oRng, VArray : Variant;
begin
// Start Excel and get Application Object
  oXL := CreateOleObject('Excel.Application');
  oXL.Visible := True;
  // Get a new workbook
  oWB := oXL.Workbooks.Add;
  oSheet := oWB.ActiveSheet;
  // Add table headers going cell by cell
  oSheet.Cells[1,1] := 'First Name';
  oSheet.Cells[1,2] := 'Last Name';
  oSheet.Cells[1,3] := 'Full Name';
  oSheet.Cells[1,4] := 'Salary';
  // Format A1:D1 as bold, vertical alignment = center
  oSheet.Range['A1:D1'].Font.Bold := True;
  oSheet.Range['A1:D1'].VerticalAlignment := xlVAlignCenter;
  // Create an array to set multiple values at once
  VArray := VarArrayCreate([0,4,0,1],varVariant);
  VArray[0,0] := 'John';
  VArray[0,1] := 'Smith';
  VArray[1,0] := 'Tom';
  VArray[1,1] := 'Brown';
  VArray[2,0] := 'Sue';
  VArray[2,1] := 'Thomas';
  VArray[3,0] := 'Jane';
  VArray[3,1] := 'Jones';
  VArray[4,0] := 'Adam';
  VArray[4,1] := 'Johnson';
  // Fill A2:B6 with an array of values
  oSheet.Range['A2:B6'] := VArray;
  // Fill C2:C6 with a relative formula (=A2 + ' ' + B2)
  oRng := oSheet.Range['C2:C6'];
  oRng.Formula := '=A2 & " " & B2';
  // Fill D2:D6 with a formula (=RAND()*100000) and apply format
  oRng := oSheet.Range['D2:D6'];
  oRng.Formula := '=RAND()*100000';
  oRng.NumberFormat := '$0.00';
  // Autofit columns A:D
  oRng := oSheet.Range['A1:D1'];
  oRng.EntireColumn.AutoFit;
  // Manipulate a variable number of columns for Quarterly Sales Data
  DisplayQuarterlySales(oSheet);
  // Make sure Excel is visible and give the user control
  // of Microsoft Excel's lifetime
  oXL.Visible := True;
  oXL.UserControl := True;
end;
end.

 procedure TMainForm.Button_Result_ExcelViewClick(Sender: TObject);
var
     LCID, I        : Integer;
     Sheet   : Variant;
     Format         : OleVariant;
     GraphTop, GraphLeft : Integer;
     oRng : OleVariant;
     DirName : String;
     ImageFile : String;
begin
     DirName := 'C:\...\...\' + FileNameEdit.Text;
     LCID := 0;
     If DirectoryExists(DirName) = False Then
     Begin
          CreateDir(DirName);
          ChDir(DirName);
          if IOResult <> 0 then  MessageDlg('Cannot find directory', mtWarning, [mbOk], 0);
     End;

     ExcelApplication1.Connect; //엑셀을 가동한다(InVisible 상태)
     ExcelWorkbook1.connectto(ExcelApplication1.workbooks.add(TOleEnum(xlWBATWorksheet), LCID));
     ExcelWorksheet1.connectto(ExcelWorkbook1.worksheets.item['Sheet1'] as _worksheet );

     //워크시트 이름 변경
     ExcelWorksheet1.Name := AnalEdit.Text;// '엑셀 쉬트 이름 '

     ExcelApplication1.DisplayAlerts[LCID] := False;
     ExcelApplication1.Visible[LCID] := true;

     Sheet := ExcelApplication1.WorkBooks[ExcelApplication1.Workbooks.Count].WorkSheets[ExcelWorkbook1.Worksheets.Count];

     ExcelWorksheet1.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].VerticalAlignment := xlHAlignCenter;
     ExcelWorksheet1.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].HorizontalAlignment := xlHAlignCenter;
     ExcelWorksheet1.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].Value := 'Drop Watcher Test';
     ExcelWorksheet1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].MergeCells := true;
     ExcelWorksheet1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].borders.LineStyle := 1;
     ExcelApplication1.Range['A1','A1'].borders.Color := clNavy;
     ExcelApplication1.Range['A1','A1'].Interior.Color := clYellow;
     ExcelApplication1.Range['A1','A1'].borders.lineStyle := 1;
     ExcelApplication1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].font.bold := true;
     ExcelApplication1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].font.Size := 20;
     ExcelApplication1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].font.Name := '굴림체';
     ExcelApplication1.Range[Sheet.Cells[1,1],Sheet.Cells[2,18]].VerticalAlignment := xlHAlignCenter;
     Sheet.Cells[1,1] := 'Drop Watcher Test ';

     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 81, 18 ]].font.Size := 9;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 81, 18 ]].font.Name := '굴림체';
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 81, 18 ]].HorizontalAlignment := xlHAlignCenter;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 81, 18 ]].VerticalAlignment := xlHAlignCenter;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 81, 18 ]].font.bold := True;

     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 18 ]].font.Size := 9;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 18 ]].font.Name := '굴림체';
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 18 ]].HorizontalAlignment := xlHAlignCenter;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 18 ]].VerticalAlignment := xlHAlignCenter;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 6 ]].borders.lineStyle := 1;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 261, 18 ]].font.bold := True;

     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 5, 6 ]].font.Color:= clWhite;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 5, 6 ]].borders.Color := clNavy;
     ExcelApplication1.Range[Sheet.Cells[ 4, 1 ],Sheet.Cells[ 5, 6 ]].Interior.Color := clBlue;

     ExcelApplication1.Range[Sheet.Cells[ 6, 1 ],Sheet.Cells[ 261, 1 ]].borders.lineStyle := 1;
     ExcelApplication1.Range[Sheet.Cells[ 6, 1 ],Sheet.Cells[ 261, 1 ]].borders.Color := clBlack;
     ExcelApplication1.Range[Sheet.Cells[ 6, 1 ],Sheet.Cells[ 261, 1 ]].Interior.Color := clYellow;

     ExcelWorksheet1.Range[Sheet.Cells[4,1],Sheet.Cells[4,6]].MergeCells := true;

     GraphTop := 5;

     Sheet.Cells[ GraphTop-1, 1 ].Value := '항  목';
     Sheet.Cells[   GraphTop, 1 ].Value := 'No';
     Sheet.Cells[   GraphTop, 2 ].Value := '부  피(pl)';
     Sheet.Cells[   GraphTop, 3 ].Value := '좌  우(um)';  //Sheet.Cells[   GraphTop, 3 ].Memo := '';
     Sheet.Cells[   GraphTop, 3 ].AddComment( '수평 좌우 편차거리');
     Sheet.Cells[   GraphTop, 4 ].Value := '상  하(um)';
     Sheet.Cells[   GraphTop, 4 ].AddComment( '수직 상하 편차거리');
     Sheet.Cells[   GraphTop, 5 ].Value := '속 도(m/s)';
     Sheet.Cells[   GraphTop, 6 ].Value := '각  도(˚)';

     Format := '0';       ExcelApplication1.Range[Sheet.Cells[ 6, 1 ],Sheet.Cells[ 261, 1 ]].NumberFormatLocal   := Format;
     Format := '#,##0.0'; ExcelApplication1.Range[Sheet.Cells[ 6, 2 ],Sheet.Cells[ 261, 6 ]].NumberFormatLocal   := Format;

     For I := 1 to xxx do
     Begin
          Sheet.Cells[ GraphTop + I, 1 ].Value := Formatfloat('000', I );      // Nozzle No
          Sheet.Cells[ GraphTop + I, 2 ].Value := Formatfloat('0.0', m_DropTailVolume       [I] ); // 부피
          Sheet.Cells[ GraphTop + I, 3 ].Value := Formatfloat('0.0', m_DropTailStraightness [I] );  // 좌우편차
          Sheet.Cells[ GraphTop + I, 4 ].Value := Formatfloat('0.0', m_DropTailLength       [I] ); // 드랍간 거리
          Sheet.Cells[ GraphTop + I, 5 ].Value := Formatfloat('0.0', m_DropTailSpeed        [I] ); // 드랍 속도
          Sheet.Cells[ GraphTop + I, 6 ].Value := Formatfloat('0.0', m_DropAngle            [I] ); // 휘어짐 각도
     End;

     GraphTop := 4; GraphLeft := 8;

     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].VerticalAlignment := xlHAlignCenter;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].HorizontalAlignment := xlHAlignCenter;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].Value := 'Test 환경';
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].MergeCells := true;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].borders.LineStyle := 1;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].borders.Color  := clBlack;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+1,GraphLeft+10]].Interior.Color := clYellow;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+6,GraphLeft+10]].borders.lineStyle := 1;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop+2,GraphLeft],Sheet.Cells[GraphTop+6,GraphLeft+10]].Interior.Color := $00DEFEE3;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+6,GraphLeft+10]].font.bold := true;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop  ,GraphLeft+10]].font.Size := 12;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop+2,GraphLeft],Sheet.Cells[GraphTop+6,GraphLeft+10]].font.Size := 9;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop  ,GraphLeft],Sheet.Cells[GraphTop+6,GraphLeft+10]].font.Name := '굴림체';

     Format := '#,##0.0';
     ExcelApplication1.Range[Sheet.Cells[GraphTop+11,GraphLeft+1],Sheet.Cells[GraphTop+15,GraphLeft+9]].NumberFormatLocal   := Format;
     Format := '0';
     ExcelApplication1.Range[Sheet.Cells[GraphTop+11,GraphLeft+6],Sheet.Cells[GraphTop+11,GraphLeft+6]].NumberFormatLocal   := Format;
     Format := '#,##0.0%';
     ExcelApplication1.Range[Sheet.Cells[GraphTop+11,GraphLeft+5],Sheet.Cells[GraphTop+15,GraphLeft+5]].NumberFormatLocal   := Format;
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

     GraphTop := GraphTop + 17;

     ExcelWorksheet1.Range[Sheet.Cells[GraphTop,GraphLeft],Sheet.Cells[GraphTop+102,GraphLeft+10]].VerticalAlignment := xlHAlignCenter;
     ExcelWorksheet1.Range[Sheet.Cells[GraphTop,GraphLeft],Sheet.Cells[GraphTop+102,GraphLeft+10]].HorizontalAlignment := xlHAlignCenter;

     for I :=  0 to 4 do
     Begin
  case I of
            0: ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop,GraphLeft],Sheet.Cells[(I*20)+GraphTop,GraphLeft+10]].Value := '부  피(pl)';
            1: Begin
              ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop,GraphLeft],Sheet.Cells[(I*20)+GraphTop,GraphLeft+10]].Value := '좌  우(um)';
        Sheet.Cells[   (I*20)+GraphTop,GraphLeft ].AddComment( '수평 좌우 편차거리');
             End;
            2: Begin
              ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop,GraphLeft],Sheet.Cells[(I*20)+GraphTop,GraphLeft+10]].Value := '상  하(um)';
        Sheet.Cells[   (I*20)+GraphTop,GraphLeft ].AddComment( '수직 상하 편차거리');
             End;
            3: ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop,GraphLeft],Sheet.Cells[(I*20)+GraphTop,GraphLeft+10]].Value := '속  도(m/s)';
            4: ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop,GraphLeft],Sheet.Cells[(I*20)+GraphTop,GraphLeft+10]].Value := '각  도(˚)';
          end;

      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop   ,GraphLeft+10]].MergeCells := true;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop+1,GraphLeft],Sheet.Cells[(I*20)+GraphTop+18,GraphLeft+10]].MergeCells := true;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop+18,GraphLeft+10]].borders.LineStyle := 1;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop   ,GraphLeft+10]].borders.Color  := clBlack;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop   ,GraphLeft+10]].Interior.Color := clYellow;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop+18,GraphLeft+10]].font.bold := true;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop+18,GraphLeft+10]].font.Size := 12;
      ExcelWorksheet1.Range[Sheet.Cells[(I*20)+GraphTop  ,GraphLeft],Sheet.Cells[(I*20)+GraphTop+18,GraphLeft+10]].font.Name := '굴림체';

   oRng := Sheet.Cells[(I*20)+GraphTop+1,GraphLeft].Select;
          case I of
            0: ImageFile := VolumeGraph;
            1: ImageFile := StraightGraph;
            2: ImageFile := LengthGraph;
            3: ImageFile := SpeedGraph;
            4: ImageFile := AngleGraph;
          end;
      if FileExists(ImageFile) then
      begin
           oRng := Sheet.Pictures.Insert(ImageFile).ShapeRange;
               //oRng := Sheet.
        oRng.ScaleWidth (1, False, 1);
        oRng.ScaleHeight (1, false, 1);
               //////////// Excel 2007에서는 아래처럼 코딩 필요 ///////////////////////////////////////////////////////////////////////////////////////
               //oSheet.Shapes.AddPicture(gsAppDir + `\Logo\` + sCode + `.jpg`, msOTrue, msoTrue, Left:=0, Top:=(iPage*775)+0, Width:=148, Height:=55);
      end;
     End;
     Sheet.Cells[1,1].Select;

     //숫자형 포맷
   //Format := '_-* #,##0.0_-;-* #,##0.0_-;_-* "-"???_-;_-@_-';
   //ExcelApplication1.Range['B1','B1'].NumberFormatLocal := Format;

   //ExcelWorksheet1.Range['F3', 'H8'].Formula := '=RAND()*10';
   //ExcelWorksheet1.Range['F9', 'F9'].Formula := '=SUM(F3:F8)';
   //패턴변경
   //=============================================================================================================================
   //for i := 1 to 18 do
   //begin
      //ExcelWorksheet1.Range['D'+inttostr(i+24),'D'+inttostr(i+24)].Interior.Pattern := i;
      //ExcelWorksheet1.Range['E'+inttostr(i+24),'E'+inttostr(i+24)].Value := 'Interior.Pattern := '+inttostr(i);
   //end;
   //=============================================================================================================================
                  //
//  이미지를 삽입할경우 실제파일을 기록해야 되기 때문에 주석처리 했습니다.
//  실제 파일과 경로명 기록하고 주석푸시고 실행해보세요 ^^
//   백그라운드 이미지
//  //ExcelWorksheet1.SetBackgroundPicture('C:\My Documents\My Pictures\couplevssolo(6).jpg');
//  //이미지 입력
//  Selection := Sheet.Pictures.Insert('C:\My Documents\My Pictures\302492_2.jpg');
//  //이미지위치조절
//  Selection.ShapeRange.IncrementLeft(243);
//  Selection.ShapeRange.IncrementTop(605);

   //차트용 오브젝트 생성
   //ChObj := (ExcelWorksheet1.ChartObjects(EmptyParam, lcid) as ChartObjects).Add(600, 10, 400, 250);
   //ExcelChart1.ConnectTo(ChObj.Chart as _Chart);
   //데이터 범위(데이터뿐만아니라 가로축 세로축에 찍힐 주석값까지 포함해야함)
   //Rnge := ExcelWorksheet1.Range['E2','H8']; // the data range, including titles
   //차트타입
   //ChType := TOleEnum(xl3DColumn);
   //ExcelChart1.ChartWizard(Rnge, ChType, EmptyParam, xlColumns, 1, 1, True,
     //                     ExcelWorksheet1.Range['A1', 'A1'].Text, // The chart title
     //                     '번호', '점수', EmptyParam, lcid);
   //Ax := ExcelChart1.Axes(xlValue, xlPrimary, lcid) as Axis;
   //Ax.AxisTitle.Font.FontStyle := '굴림체';

   //자동으로 컬럼의 폭을 맞춘다.
   //ExcelWorksheet1.Columns.AutoFit;
end;



*)
