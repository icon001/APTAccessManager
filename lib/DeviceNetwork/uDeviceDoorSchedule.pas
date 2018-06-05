unit uDeviceDoorSchedule;

interface

uses
  System.SysUtils, System.Classes;

type
  TScheduleTime = class(TComponent)
  private
    FStartTime: string;
    FDoorMode: string;
    FEndTime: string;
  public
    property StartTime:string read FStartTime write FStartTime;
    property EndTime:string read FEndTime write FEndTime;
    property DoorMode:string read FDoorMode write FDoorMode;
  end;
  TSchedule = class(TComponent)
  private
    ScheduleList : TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure ScheduleClear;
    procedure ScheduleAdd(aSeq,aStartTime,aEndTime,aDoorMode:string);
    function  GetCurrentTimeDoorMode(aTime:string):string;
  end;
  TDoorSchedule = class(TComponent)
  private
    DayOfWeekList : TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure DayOfWeekScheduleClear;
    procedure DayOfWeekScheduleAdd(aDayCode,aSeq,aStartTime,aEndTime,aDoorMode:string);
    function  GetCurrentTimeDoorMode(aDayCode,aTime:string):string;
  end;

  TdmDoorSchedule = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDoorSchedule: TdmDoorSchedule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDoorSchedule }

constructor TDoorSchedule.Create(AOwner: TComponent);
begin
  inherited;
  DayOfWeekList := TStringList.Create;
end;

procedure TDoorSchedule.DayOfWeekScheduleAdd(aDayCode, aSeq,aStartTime, aEndTime, aDoorMode: string);
var
  oSchedule : TSchedule;
  nIndex : integer;
begin
  nIndex := DayOfWeekList.IndexOf(aDayCode);
  if nIndex > -1 then
  begin
    TSchedule(DayOfWeekList.Objects[nIndex]).ScheduleAdd(aSeq,aStartTime,aEndTime,aDoorMode);
  end else
  begin
    oSchedule := TSchedule.Create(nil);
    oSchedule.ScheduleAdd(aSeq,aStartTime,aEndTime,aDoorMode);
    DayOfWeekList.AddObject(aDayCode,oSchedule);
  end;
end;

procedure TDoorSchedule.DayOfWeekScheduleClear;
var
  i : integer;
begin
  if DayOfWeekList.Count < 1 then Exit;
  for i := DayOfWeekList.Count - 1 downto 0 do
  begin
    TSchedule(DayOfWeekList.Objects[i]).Free;
  end;
  DayOfWeekList.Clear;
end;

destructor TDoorSchedule.Destroy;
begin
  DayOfWeekScheduleClear;
  DayOfWeekList.Free;
  inherited;
end;

function TDoorSchedule.GetCurrentTimeDoorMode(aDayCode, aTime: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := DayOfWeekList.IndexOf(aDayCode);
  if nIndex < 0 then Exit;
  result := TSchedule(DayOfWeekList.Objects[nIndex]).GetCurrentTimeDoorMode(aTime);
end;

{ TSchedule }

constructor TSchedule.Create(AOwner: TComponent);
begin
  inherited;
  ScheduleList := TStringList.Create;
end;

destructor TSchedule.Destroy;
begin
  ScheduleClear;
  ScheduleList.Free;
  inherited;
end;

function TSchedule.GetCurrentTimeDoorMode(aTime: string): string;
var
  i : integer;
begin
  result := '';
  for i := 0 to ScheduleList.Count - 1 do
  begin
    if (TScheduleTime(ScheduleList.Objects[i]).StartTime <= aTime) and
       (TScheduleTime(ScheduleList.Objects[i]).EndTime > aTime)
     then
     begin
       result := TScheduleTime(ScheduleList.Objects[i]).DoorMode;
       break;
     end;
  end;
end;

procedure TSchedule.ScheduleAdd(aSeq,aStartTime, aEndTime, aDoorMode: string);
var
  oScheduleTime : TScheduleTime;
  nIndex : integer;
begin
  oScheduleTime := TScheduleTime.Create(nil);
  oScheduleTime.StartTime := aStartTime;
  oScheduleTime.EndTime := aEndTime;
  oScheduleTime.DoorMode := aDoorMode;
  nIndex := ScheduleList.IndexOf(aSeq);
  if nIndex > -1 then
  begin
    TScheduleTime(ScheduleList.Objects[nIndex]).Free;
    ScheduleList.Delete(nIndex);
  end;
  ScheduleList.AddObject(aSeq,oScheduleTime);
end;

procedure TSchedule.ScheduleClear;
var
  i : integer;
begin
  if ScheduleList.Count < 1 then Exit;

  for i := ScheduleList.Count - 1 downto 0 do
  begin
    TScheduleTime(ScheduleList.Objects[i]).Free;
  end;
  ScheduleList.Clear;
end;

end.
