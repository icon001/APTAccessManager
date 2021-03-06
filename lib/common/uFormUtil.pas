unit uFormUtil;

interface
uses Vcl.StdCtrls,System.SysUtils,Vcl.ExtCtrls;

//*************************
//Group Box 내에서 컴포넌트 찾는 함수
//*************************
Function TravelGroupEditItem(GroupBox:TGroupBox;stName:string; no:Integer):TEdit;
Function TravelGroupLabelItem(GroupBox:TGroupBox;stName:string; no:Integer):TLabel;
//*************************
//Panel 내에서 컴포넌트 찾는 함수
//*************************
Function TravelPanelEditItem(Panel:TPanel;stName:string; no:Integer):TEdit;
Function TravelPanelLabelItem(Panel:TPanel;stName:string; no:Integer):TLabel;

implementation

Function TravelGroupEditItem(GroupBox:TGroupBox;stName:string; no:Integer):TEdit;
var
Loop:integer;
begin
  Result:= Nil;

  For Loop:=0 to GroupBox.ControlCount-1 do
  Begin
    If LowerCase(GroupBox.Controls[Loop].name) = LowerCase(stName) + inttostr(no) then
    Begin
      Result:=TEdit(GroupBox.Controls[Loop]);
      exit;
    End;
  End;
end;

Function TravelGroupLabelItem(GroupBox:TGroupBox;stName:string; no:Integer):TLabel;
var
Loop:integer;
begin
  Result:= Nil;

  For Loop:=0 to GroupBox.ControlCount-1 do
  Begin
    If LowerCase(GroupBox.Controls[Loop].name) = LowerCase(stName) + inttostr(no) then
    Begin
      Result:=TLabel(GroupBox.Controls[Loop]);
      exit;
    End;
  End;
end;

Function TravelPanelEditItem(Panel:TPanel;stName:string; no:Integer):TEdit;
var
Loop:integer;
begin
  Result:= Nil;

  For Loop:=0 to Panel.ControlCount-1 do
  Begin
    If LowerCase(Panel.Controls[Loop].name) = LowerCase(stName) + inttostr(no) then
    Begin
      Result:=TEdit(Panel.Controls[Loop]);
      exit;
    End;
  End;
end;

Function TravelPanelLabelItem(Panel:TPanel;stName:string; no:Integer):TLabel;
var
Loop:integer;
begin
  Result:= Nil;

  For Loop:=0 to Panel.ControlCount-1 do
  Begin
    If LowerCase(Panel.Controls[Loop].name) = LowerCase(stName) + inttostr(no) then
    Begin
      Result:=TLabel(Panel.Controls[Loop]);
      exit;
    End;
  End;
end;

end.
