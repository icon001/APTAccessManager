unit uDataBaseConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel,
  W7Classes, W7Buttons, Vcl.ImgList,System.iniFiles,Data.DB,Data.Win.ADODB;

type
  TDataBaseConfig = class(TComponent)
  private
    FCancel: Boolean;
    FDBConnected: Boolean;
    class function FindSelf:TComponent;
    procedure SetCancel(const Value: Boolean);
    procedure SetDBConnected(const Value: Boolean);
    procedure TableVersionCheck;
    function GetVersion:integer;
  private
    function Table001VersionMake: Boolean;
    function Table002VersionMake: Boolean;
    function Table003VersionMake: Boolean;

  public
    { Public declarations }
    Procedure ShowDataBaseConfig;
    Function DataBaseConnect(aMessage:Boolean=True):Boolean;
  public
    class Function GetObject:TDataBaseConfig;   //�ڱ��ڽ��� ã�°�  class �� ������������ ��밡��
  Published
    { Published declarations }
    Property Cancel:Boolean read FCancel write SetCancel;
    Property DBConnected : Boolean read FDBConnected write SetDBConnected;
  end;

  TfmDataBaseConfig = class(TForm)
    rg_DBType: TRadioGroup;
    AdvPanel1: TAdvPanel;
    edPasswd: TEdit;
    edDataBaseName: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    edUserid: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    edServerPort: TEdit;
    edServerIP: TEdit;
    Label1: TLabel;
    btn_Save: TW7SpeedButton;
    btn_Close: TW7SpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure rg_DBTypeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDataBaseConfig: TfmDataBaseConfig;

implementation
uses
  DIMime,
  uCommonVariable,
  uDataBase,
  uDBCreate,
  uDBInsert,
  uDBUpdate;

{$R *.dfm}

{ TDataBaseConfig }

function TDataBaseConfig.DataBaseConnect(aMessage: Boolean): Boolean;
var
  ini_fun : TiniFile;
  stDBHost : string;
  stDBPort : string;
  stDBUserID : string;
  stDBUserPw : string;
  stDBName : string;
  stConnectString : string;
  stConnectString1 : string;
begin
  if DBConnected then Exit;
  result := False;
  CanCel := False;
  G_stExeFolder  := ExtractFileDir(Application.ExeName);
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Config.ini');

    G_nDBType := ini_fun.ReadInteger('DBConfig','TYPE',MDB);

    stDBHost  := ini_fun.ReadString('DBConfig','Host','127.0.0.1');
    stDBPort := ini_fun.ReadString('DBConfig','Port','1433');
    stDBUserID := ini_fun.ReadString('DBConfig','UserID','sa');
    stDBUserPw := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW',''));  //saPasswd
    stDBName := lowerCase(ini_fun.ReadString('DBConfig','DBNAME',''));
    G_stGroupCode := ini_fun.ReadString('COMPANY','GROUPCODE','1234567890');
    G_nBuildingCodeLength := ini_fun.ReadInteger('COMPANY','BUILDINGCODELENGTH',5);
    G_nMaxComPort := ini_fun.ReadInteger('RS232','MAXPORT',40);
    G_nCardRegisterPort := ini_fun.ReadInteger('FORM','CardRegisterPort',0);
    G_nComDelayTime := ini_fun.ReadInteger('COMConfig','ComDelay',80);
    G_nLangeType := ini_fun.ReadInteger('Config','LangType',1);


    stConnectString := '';
    if G_nDBType = MSSQL then
    begin
      stConnectString := stConnectString + 'Provider=SQLOLEDB.1;';
      stConnectString := stConnectString + 'Password=' + stDBUserPw + ';';
      stConnectString := stConnectString + 'Persist Security Info=True;';
      stConnectString := stConnectString + 'User ID=' + stDBUserID + ';';
      stConnectString := stConnectString + 'Initial Catalog=' + stDBName + ';';
      stConnectString := stConnectString + 'Data Source=' + stDBHost  + ',' + stDBPort;
    end else if G_nDBType = POSTGRESQL then
    begin
      stConnectString := 'Provider=PostgreSQL OLE DB Provider;';
      stConnectString := stConnectString + 'Data Source=' + stDBHost + ';'   ;
      stConnectString := stConnectString + 'location=' + stDBName + ';';
      stConnectString := stConnectString + 'User Id='+ stDBUserID + ';';
      stConnectString := stConnectString + 'password=' + stDBUserPw;
    end else if G_nDBType = FIREBIRD then
    begin
      stConnectString := 'Provider=MSDASQL;';
      stConnectString := stConnectString + 'DRIVER=Firebird/InterBase(r) driver;';
      stConnectString := stConnectString + 'UID=' + stDBUserID + ';';
      stConnectString := stConnectString + 'PWD=' + stDBUserPw + ';';
      stConnectString := stConnectString + 'Auto Commit=true;';
      stConnectString := stConnectString + 'DBNAME=' + stDBHost + ':' + stDBName;
    end else //����Ʈ�� MDB�� �ν�����
    begin
      stConnectString := 'Provider=Microsoft.Jet.OLEDB.4.0;';
      stConnectString := stConnectString + 'Data Source=' + G_stExeFolder + '\..\DB\ACCINFO.mdb' + ';';
      stConnectString := stConnectString + 'Persist Security Info=True;';
      stConnectString := stConnectString + 'Jet OLEDB:Database ';
    end;

    if G_nDBType <> MDB then
    begin
      stConnectString1 := stConnectString;
    end else
    begin
      //MDB ������ �̺�Ʈ DB �� ���� DB�� �����ϱ� ����
      stConnectString1 := 'Provider=Microsoft.Jet.OLEDB.4.0;';
      stConnectString1 := stConnectString1 + 'Data Source=' + G_stExeFolder + '\..\DB\ACCEVENT.mdb' + ';';
      stConnectString1 := stConnectString1 + 'Persist Security Info=True;';
      stConnectString1 := stConnectString1 + 'Jet OLEDB:Database ';
    end;

//showmessage(stConnectString);

    with dmDataBase.ADOConnection do
    begin
      Connected := False;
      Try
        ConnectionString := stConnectString;
        LoginPrompt:= false ;
        Connected := True;
      Except
        on E : EDatabaseError do
          begin
            // ERROR MESSAGE-BOX DISPLAY
            if aMessage then
              ShowMessage(E.Message );
            Exit;
          end;
        else
          begin
            if aMessage then
              ShowMessage('�����ͺ��̽� ���� ����' );
            Exit;
          end;
      End;
      CursorLocation := clUseServer;
      //CursorLocation := clUseClient;
    end;

    with dmDataBase.ADOEventConnection do
    begin
      Connected := False;
      Try
        ConnectionString := stConnectString1;
        LoginPrompt:= false ;
        Connected := True;
      Except
        on E : EDatabaseError do
          begin
            // ERROR MESSAGE-BOX DISPLAY
            if aMessage then
              ShowMessage(E.Message );
            Exit;
          end;
        else
          begin
            if aMessage then
              ShowMessage('�����ͺ��̽� ���� ����' );
            Exit;
          end;
      End;
      CursorLocation := clUseServer;
      //CursorLocation := clUseClient;
    end;
    DBConnected := True;
    TableVersionCheck;
    result := True;
  Finally
    ini_fun.Free;
  End;

end;

class function TDataBaseConfig.FindSelf: TComponent;
var
  Loop:Integer;
begin
  Result:=Nil;
  for Loop:=0 to Application.ComponentCount-1 do begin
      if Application.Components[Loop] is TDataBaseConfig then begin
          Result:= Application.Components[Loop];
          Break;
      end;
  end;
end;

class function TDataBaseConfig.GetObject: TDataBaseConfig;
begin
   If FindSelf = Nil then TDataBaseConfig.Create(Application);
   Result := TDataBaseConfig(FindSelf);
end;

function TDataBaseConfig.GetVersion: integer;
var
  stSql : string;
begin
  result := 0;
  stSql := 'select * from TB_CONFIG ';
  stSql := stSql + ' where CO_CONFIGGROUP = ''COMMON'' ';
  stSql := stSql + ' AND CO_CONFIGCODE = ''TABLE_VER'' ';
  with dmDataBase.ADOTmpQuery do
  begin
    Close;
    Sql.Clear;
    Sql.Text := stSql;
    Try
      Open;
    Except
      Exit;
    End;
    if recordCount < 1 then Exit;
    Try
      result := strtoint(FindField('CO_CONFIGVALUE').AsString);
    Except
      Exit;
    End;
  end;
end;

procedure TDataBaseConfig.SetCancel(const Value: Boolean);
begin
  FCancel := Value;
end;

procedure TDataBaseConfig.SetDBConnected(const Value: Boolean);
begin
  FDBConnected := Value;
end;

procedure TDataBaseConfig.ShowDataBaseConfig;
begin
  FDBConnected := False;

  fmDataBaseConfig:=TfmDataBaseConfig.Create(Nil);
  Try
    fmDataBaseConfig.ShowModal;
  Finally
    fmDataBaseConfig.Free;
  End;
end;

function TDataBaseConfig.Table001VersionMake: Boolean;
begin
  dmDBCreate.CreateTB_CONFIG;
  dmDBInsert.InsertIntoTB_CONFIG_All('COMMON','TABLE_VER','1','���̺� ��������');
  dmDBCreate.CreateTB_FORMNAME;
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00001','���԰����ý���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00002','�⺻����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00003','�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00004','��Ÿ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00005','�ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00006','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00007','�����ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00008','���Ѱ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00009','����͸�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00010','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00011','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00012','ȸ���ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00013','�μ��ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00014','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00015','���Թ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00016','���Խ����ڵ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00017','ī�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00018','ī����Ѱ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00019','���Թ������Ѱ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00020','��й�ȣ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00021','���Ը���͸�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00022','��Ÿ���͸�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00023','���Ժ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00024','���º�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00025','ȯ�漳��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00026','DB���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00027','��������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00028','���׷��̵�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00029','���α׷�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00030','���α׷�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00031','�α���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00032','�α׾ƿ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00033','��й�ȣ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00034','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00035','�ݱ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00036','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00037','�μ��ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00038','�μ��ڵ��߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00039','�μ��ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00040','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00041','ȸ���ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00042','ȸ���ڵ��߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00043','ȸ���ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00044','ī�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00045','ī���߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00046','ī�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00047','��ϱ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00048','���Թ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00049','���Թ��߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00050','���Թ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00051','�ϰ����ѵ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00052','�ϰ����ѻ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00053','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00054','����߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00055','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00056','���Ի����ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00057','���Ի����ڵ��߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00058','���Ի����ڵ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00059','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00001','���� ��������� ��� �����Ͻðڽ��ϱ�?','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00002','ī���� �Ϸ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00003','ī���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00004','ī���� �Ϸ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00005','ī���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00006','START ��ư�� Ŭ���Ͽ� �α��� �� �۾��ϼ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00007','�ش� �۾��� ���� �Ͻø� �۾�â�� Ȱ��ȭ �˴ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00008','�۾��� �����մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00009','������� ������ ��� ��ְ� �߻� �� �� �ֽ��ϴ�. ����Ͻðڽ��ϱ�?','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00010','������Ʈ ������ ��ġ�Ǿ� ���� �ʽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00011','������ ���� ���Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00012','�����ÿ��� �ش缿�� ����Ŭ�� �ϼ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00013','���α׷��� ������ �ֽ��ϴ�. ���߽ǿ� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00014','�ڵ尡 �������� �ʽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00015','$NAME��(��) �������� �ʽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00016','�۾��� �����͸� �������� �ʾҽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00017','�ߺ� �ڵ� �Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00018','������ ���忡 �����Ͽ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00019','���� �� �����͸� ���� �ϼ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00020','���� �����Ͱ� ���� �˴ϴ�. ���� ���� �Ͻðڽ��ϱ�?','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00021','��ȸ�� �����Ͱ� �����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00022','���� �̹� ������� ī���Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00023','$OLD�� $NEW(��)�� �����Ͻðڽ��ϱ�?','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00024','�����Ǿ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00025','��й�ȣ�� 1000�� ������ ��� ���� �մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00026','����� ��й�ȣ�� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00027','����� ���Թ��� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00028','������ ��й�ȣ�� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00029','�߰��ÿ��� �ش缿�� ����Ŭ���ϼ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00030','���� ����� ����� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00031','������ ���Թ��� �����Ͽ� �ּ���.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00032','������ ��� �Ϸ��� ���Թ��� ���� �� �ּž� �մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00033','������ ��� �Ϸ��� ����� ���� �� �ּž� �մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00034','���� ����� ���� ����� �Ϸ� �Ǿ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00035','������ ���� �Ϸ��� ���Թ��� ���� �� �ּž� �մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00036','������ ���� �Ϸ��� ����� ���� �� �ּž� �մϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00037','���� ���Թ��� ���� ������ �Ϸ� �Ǿ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00038','�����ͺ��̽� ���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00039','�н����尡 ���� �ʽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00040','��ⱳü ���� ���� �ٿ�ε� �Ϸ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00041','�����ʱ�ȭ������ ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00042','��й�ȣ������ ���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00043','ī�嵥���� ���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00044','����ʱ�ȭ ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00045','$NUM��Ʈ�� $NAME���� �̹� ������Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00046','�ش� IP�� $NAME���� �̹� ������Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00047','�ش� ��忡 ���Թ� �߰�ȭ������ �̵��Ͻðڽ��ϱ�?','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00048','$NAME���� �̹� ������� �ڵ��Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00049','���ѵ���� �Ϸ�Ǿ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00050','���ѻ����� �Ϸ�Ǿ����ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00051','���� ��� ��й�ȣ�� Ʋ���ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00052','�ű� �н����尡 �ùٸ��� �ʽ��ϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00053','�н����� �ڸ����� 4�ڸ� �Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('2','M00054','�н������ �����Դϴ�.','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00001','���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00002','�����̷º�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00003','���Ժ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00004','ī��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00005','��й�ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00006','�����͹�ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00007','��ü','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00008','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00009','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00010','�˼� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('3','M00011','���º�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00001','��ȸ�Ⱓ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00002','���Թ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00003','���۱���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00004','ȸ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00005','�μ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00006','�̸�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00007','��ȸ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00008','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00009','���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00010','���Խð�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00011','���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00012','ī���ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00013','���ΰ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00014','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00015','���³�¥','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00016','��ٽð�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00017','��ٽð�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00018','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00019','��ȭ��ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00020','ī������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00021','������ġ�� ���Թ��� ���Ѻο�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00022','���ۻ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00023','��ϱ���Ʈ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00024','ī��׼������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00025','�����̷¹��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00026','�ð�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00027','���ɾ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00028','ȭ������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00029','��й�ȣ����Ʈ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00030','��й�ȣ���Ѱ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00031','��й�ȣ�߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00032','��й�ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00033','��й�ȣ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00034','���Թ���Ȳ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00035','��й�ȣ�����Ȳ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00036','����ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00037','����ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00038','���Թ���ȣ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00039','���Թ���Ī','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00040','�������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00041','�Ҽ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00042','������ð�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00043','����Ī','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00044','���Թ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00045','�������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00046','���Ա���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00047','�̵��ī��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00048','���ī��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00049','���� ������ ���Թ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00050','���Թ���ȸ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00051','���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00052','���Թ��߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00053','���ñ��ѻ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00054','���� ����� ���Թ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00055','�������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00056','���ñ��ѵ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00057','�α���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00058','�н�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00059','Ȯ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00060','���Թ�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00061','�Ҽ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00062','������Ȳ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00063','ī����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00064','ī����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00065','����Ʈ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00066','���Ÿ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00067','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00068','��Ʈ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00069','�ø�����Ʈ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00070','���Ÿ��','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00071','RS232����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00072','TCP/IP����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00073','��������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00074','�����Ʈ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00075','���Խ����ڵ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00076','���Խ��θ�Ī','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00077','�߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00078','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00079','���κ�ī����Ѱ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00080','��ġ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00081','�̵�����Թ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00082','������Թ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00083','���� ������ ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00084','�����ȸ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00085','����߰�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00086','���� ����� ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00087','�����н�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00088','�ű��н�����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00089','�ű��н�����(���Է�)','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00090','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00091','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00092','������','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00093','��ⱳü�ٿ�ε�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00094','ī����ü����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00095','��й�ȣ��ü����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00096','�����ʱ�ȭ','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00097','ȸ���ڵ�','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00098','����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00099','��й�ȣ���� ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00100','��й�ȣ���� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00101','���Ա��� ���','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00102','���Ա��� ����','','');
  dmDBInsert.InsertIntoTB_FormName_Value('4','M00103','�μ��ڵ�','','');
  dmDBCreate.CreateTB_DOORSCHEDULE;
  dmDBCreate.AlterTB_DOOR_SCHEDULEAdd;
  dmDBCreate.CreateTB_HOLIDAY;

end;

function TDataBaseConfig.Table002VersionMake: Boolean;
begin
  dmDBCreate.AlterTB_CARD_CARDCodeADD;

  dmDBUpdate.UpdateTB_CONFIG_Value('COMMON','TABLE_VER','2');
end;

function TDataBaseConfig.Table003VersionMake: Boolean;
begin
  dmDBInsert.InsertIntoTB_FormName_Value('1','M00060','���Թ�������','','');

  dmDBUpdate.UpdateTB_CONFIG_Value('COMMON','TABLE_VER','3');
end;

procedure TDataBaseConfig.TableVersionCheck;
var
  nTableVersion : integer;
begin
  nTableVersion := GetVersion;
  if nTableVersion < 1 then Table001VersionMake;
  if nTableVersion < 2 then Table002VersionMake;
  if nTableVersion < 3 then Table003VersionMake;

end;

procedure TfmDataBaseConfig.FormCreate(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  Try
    if G_stExeFolder = '' then G_stExeFolder := ExtractFileDir(Application.ExeName);
    ini_fun := TiniFile.Create(G_stExeFolder + '\Config.ini');

    rg_DBType.ItemIndex := ini_fun.ReadInteger('DBConfig','TYPE',MDB);

    edServerIP.Text  := ini_fun.ReadString('DBConfig','Host','127.0.0.1');
    edServerPort.Text := ini_fun.ReadString('DBConfig','Port','1433');
    edUserid.Text := ini_fun.ReadString('DBConfig','UserID','sa');
    edPasswd.Text := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW',''));  //saPasswd
    edDataBaseName.Text := lowerCase(ini_fun.ReadString('DBConfig','DBNAME',''));
  Finally
    ini_fun.Free;
  End;
  rg_DBTypeClick(sender);
end;

procedure TfmDataBaseConfig.rg_DBTypeClick(Sender: TObject);
begin
  if rg_DBType.ItemIndex = MDB then AdvPanel1.Visible := False
  else AdvPanel1.Visible := True;

end;

procedure TfmDataBaseConfig.btn_CloseClick(Sender: TObject);
begin
  TDataBaseConfig.GetObject.Cancel := True;
  Close;
end;

procedure TfmDataBaseConfig.btn_SaveClick(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  Try
    if G_stExeFolder = '' then G_stExeFolder := ExtractFileDir(Application.ExeName);
    ini_fun := TiniFile.Create(G_stExeFolder + '\Config.ini');

    ini_fun.WriteInteger('DBConfig','TYPE',rg_DBType.ItemIndex);

    ini_fun.WriteString('DBConfig','Host',edServerIP.Text);
    ini_fun.WriteString('DBConfig','Port',edServerPort.Text);
    ini_fun.WriteString('DBConfig','UserID',edUserid.Text);
    ini_fun.WriteString('DBConfig','UserPW',MimeEncodeString(Trim(edPasswd.Text)));  //saPasswd
    ini_fun.WriteString('DBConfig','DBNAME',edDataBaseName.Text);
  Finally
    ini_fun.Free;
  End;

  TDataBaseConfig.GetObject.DataBaseConnect;
  Close;

end;

end.