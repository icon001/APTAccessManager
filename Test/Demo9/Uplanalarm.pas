unit Uplanalarm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Planner, StdCtrls, PlanItemEdit;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    AlarmMessage1: TAlarmMessage;
    Label1: TLabel;
    ListBox1: TListBox;
    DefaultItemEditor1: TDefaultItemEditor;
    procedure Planner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure Planner1ItemAlarm(Sender: TObject; Item: TPlannerItem);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Planner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  with planner1.CreateItemAtSelection do
  begin
     text.text := 'New created item';
     alarm.active := true;

     alarm.handler := alarmmessage1;
     alarm.message := 'Hello world';
     alarm.NotifyType := anMessage;
     alarm.timebefore := encodetime(0,30,0,0);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  shorttimeformat := 'HH:NN:SS';
end;

procedure TForm1.Planner1ItemAlarm(Sender: TObject; Item: TPlannerItem);
begin
  listbox1.items.Add('alarm triggered from '+item.Name);
end;

end.
