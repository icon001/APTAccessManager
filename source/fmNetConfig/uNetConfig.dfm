object fmNetConfig: TfmNetConfig
  Left = 425
  Top = 156
  BorderIcons = [biSystemMenu]
  Caption = 'Lan Setting'
  ClientHeight = 539
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #44404#47548#52404
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 15
  object pan_header: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 51
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Lan Setting'
    Color = 15387318
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 51
    Width = 720
    Height = 466
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #44404#47548
    Font.Style = []
    PageIndex = 1
    ParentFont = False
    TabOrder = 1
    OnPageChanged = Notebook1PageChanged
    object TPage
      Left = 0
      Top = 0
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'RS-232 '#49444#51221
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TPage
      Left = 0
      Top = 0
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'LAN '#49444#51221
      object pan_Lan: TPanel
        Left = 0
        Top = 0
        Width = 720
        Height = 389
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        TabOrder = 0
        object Label5: TLabel
          Left = 280
          Top = 470
          Width = 55
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'MCU ID '
          Visible = False
        end
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 260
          Height = 387
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alLeft
          TabOrder = 0
          object sg_WiznetList: TStringGrid
            Left = 1
            Top = 1
            Width = 258
            Height = 385
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            ColCount = 2
            DefaultColWidth = 200
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
            TabOrder = 0
            OnClick = sg_WiznetListClick
          end
        end
        object ed_LMCUID: TEdit
          Left = 360
          Top = 465
          Width = 171
          Height = 23
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ImeName = 'Microsoft IME 2003'
          MaxLength = 7
          TabOrder = 1
          Visible = False
        end
        object Panel6: TPanel
          Left = 261
          Top = 1
          Width = 458
          Height = 387
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 2
          object pan_LanDetail: TPanel
            Left = 1
            Top = 1
            Width = 456
            Height = 385
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            Enabled = False
            TabOrder = 0
            object Label3: TLabel
              Left = 30
              Top = 20
              Width = 86
              Height = 15
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Mac Address'
            end
            object chk_ZeronType: TCheckBox
              Left = 3
              Top = 350
              Width = 121
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Zeron Type'
              TabOrder = 0
              Visible = False
            end
            object GroupBox3: TGroupBox
              Left = 30
              Top = 259
              Width = 401
              Height = 94
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Local Server '#49444#51221
              TabOrder = 1
              Visible = False
              object Label7: TLabel
                Left = 30
                Top = 30
                Width = 71
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'IP Address'
              end
              object Label8: TLabel
                Left = 30
                Top = 60
                Width = 27
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Port'
              end
              object Edit_ServerIp: TAdvEdit
                Left = 133
                Top = 26
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 0
                Text = ''
                Visible = True
                Version = '3.3.2.0'
              end
              object Edit_Serverport: TAdvEdit
                Left = 133
                Top = 59
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 1
                Text = '3000'
                Visible = True
                Version = '3.3.2.0'
              end
            end
            object ed_LMAC1: TAdvEdit
              Left = 173
              Top = 16
              Width = 28
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 2
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object ed_LMAC2: TAdvEdit
              Left = 209
              Top = 16
              Width = 29
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 3
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object ed_LMAC3: TAdvEdit
              Left = 245
              Top = 16
              Width = 29
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 4
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object ed_LMAC4: TAdvEdit
              Left = 281
              Top = 16
              Width = 29
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 5
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object ed_LMAC5: TAdvEdit
              Left = 318
              Top = 16
              Width = 28
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 6
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object ed_LMAC6: TAdvEdit
              Left = 354
              Top = 16
              Width = 29
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              EmptyTextStyle = []
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'Tahoma'
              LabelFont.Style = []
              Lookup.Font.Charset = DEFAULT_CHARSET
              Lookup.Font.Color = clWindowText
              Lookup.Font.Height = -13
              Lookup.Font.Name = 'Arial'
              Lookup.Font.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              ImeName = 'Microsoft Office IME 2007'
              ReadOnly = True
              TabOrder = 7
              Text = '00'
              Visible = True
              Version = '3.3.2.0'
            end
            object rg_McSetting: TGroupBox
              Left = 30
              Top = 49
              Width = 401
              Height = 202
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Network Setting'
              TabOrder = 8
              object Label1: TLabel
                Left = 30
                Top = 30
                Width = 71
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'IP Address'
              end
              object Label2: TLabel
                Left = 30
                Top = 63
                Width = 86
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Subnet Mask'
              end
              object Label4: TLabel
                Left = 30
                Top = 95
                Width = 61
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'GateWay'
              end
              object Label6: TLabel
                Left = 30
                Top = 128
                Width = 27
                Height = 15
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Port'
              end
              object ed_LLocalIP: TAdvEdit
                Left = 133
                Top = 26
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 0
                Text = ''
                Visible = True
                Version = '3.3.2.0'
              end
              object ed_LSunnet: TAdvEdit
                Left = 133
                Top = 59
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 1
                Text = ''
                Visible = True
                Version = '3.3.2.0'
              end
              object ed_LGateway: TAdvEdit
                Left = 133
                Top = 91
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 2
                Text = ''
                Visible = True
                Version = '3.3.2.0'
              end
              object ed_LLocalPort: TAdvEdit
                Left = 133
                Top = 124
                Width = 218
                Height = 23
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                EmptyTextStyle = []
                LabelFont.Charset = DEFAULT_CHARSET
                LabelFont.Color = clWindowText
                LabelFont.Height = -11
                LabelFont.Name = 'Tahoma'
                LabelFont.Style = []
                Lookup.Font.Charset = DEFAULT_CHARSET
                Lookup.Font.Color = clWindowText
                Lookup.Font.Height = -13
                Lookup.Font.Name = 'Arial'
                Lookup.Font.Style = []
                Lookup.Separator = ';'
                Color = clWindow
                ImeName = 'Microsoft Office IME 2007'
                TabOrder = 3
                Text = '3000'
                Visible = True
                Version = '3.3.2.0'
              end
              object RadioModeClient: TRadioButton
                Left = 26
                Top = 156
                Width = 142
                Height = 22
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Client Mode'
                Checked = True
                Color = clBtnFace
                ParentColor = False
                TabOrder = 4
                TabStop = True
                Visible = False
              end
              object RadioModeServer: TRadioButton
                Left = 150
                Top = 156
                Width = 141
                Height = 22
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Server Mode'
                Color = clBtnFace
                ParentColor = False
                TabOrder = 5
                Visible = False
              end
              object RadioModeMixed: TRadioButton
                Left = 230
                Top = 156
                Width = 121
                Height = 22
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Mixed Mode'
                Color = clBtnFace
                ParentColor = False
                TabOrder = 6
                Visible = False
              end
              object Checkbox_Debugmode: TCheckBox
                Left = 159
                Top = 200
                Width = 121
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Debug mode'
                TabOrder = 7
                Visible = False
              end
            end
          end
          object chk_MCUChange: TCheckBox
            Left = 8
            Top = 290
            Width = 91
            Height = 21
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'MCU'#44368#52404
            TabOrder = 1
            Visible = False
            OnClick = chk_MCUChangeClick
          end
          object cmb_MCU: TComboBox
            Left = 41
            Top = 420
            Width = 252
            Height = 23
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ImeName = 'Microsoft IME 2003'
            TabOrder = 2
            Visible = False
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 389
        Width = 720
        Height = 77
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alBottom
        TabOrder = 1
        object btn_LClose: TSpeedButton
          Left = 490
          Top = 19
          Width = 131
          Height = 41
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Close'
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000730B0000730B00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
            EEE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8EEE8E8E8E8E8E8E8E8E8E8E8E8EEE3AC
            E3EEE8E8E8E8E8E8E8E8E8E8E8EEE8ACE3EEE8E8E8E8E8E8E8E8E8EEE3E28257
            57E2ACE3EEE8E8E8E8E8E8EEE8E2818181E2ACE8EEE8E8E8E8E8E382578282D7
            578181E2E3E8E8E8E8E8E881818181D7818181E2E8E8E8E8E8E857828989ADD7
            57797979EEE8E8E8E8E88181DEDEACD781818181EEE8E8E8E8E857898989ADD7
            57AAAAA2D7ADE8E8E8E881DEDEDEACD781DEDE81D7ACE8E8E8E857898989ADD7
            57AACEA3AD10E8E8E8E881DEDEDEACD781DEAC81AC81E8E8E8E85789825EADD7
            57ABCFE21110E8E8E8E881DE8181ACD781ACACE28181E8E8E8E8578957D7ADD7
            57ABDE101010101010E881DE56D7ACD781ACDE818181818181E857898257ADD7
            57E810101010101010E881DE8156ACD781E381818181818181E857898989ADD7
            57E882101010101010E881DEDEDEACD781E381818181818181E857898989ADD7
            57ACEE821110E8E8E8E881DEDEDEACD781ACEE818181E8E8E8E857898989ADD7
            57ABE8AB8910E8E8E8E881DEDEDEACD781ACE3ACDE81E8E8E8E857828989ADD7
            57ACE8A3E889E8E8E8E88181DEDEACD781ACE381E8DEE8E8E8E8E8DE5E8288D7
            57A2A2A2E8E8E8E8E8E8E8DE8181DED781818181E8E8E8E8E8E8E8E8E8AC8257
            57E8E8E8E8E8E8E8E8E8E8E8E8AC818181E8E8E8E8E8E8E8E8E8}
          NumGlyphs = 2
          OnClick = btn_LCloseClick
        end
        object btn_LSetting: TSpeedButton
          Left = 285
          Top = 19
          Width = 131
          Height = 41
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Setting'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          OnClick = btn_LSettingClick
        end
        object btn_BroadSearch: TSpeedButton
          Left = 80
          Top = 19
          Width = 131
          Height = 41
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Search'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333FFFFFFFFF333333300000000
            0333333777777777F33333330888888803333337FFFFFFF7F333333307777777
            0333333777777777F33333330FFFFFFF03333337F3F3FFF7F33333330F9F000F
            03333337F7377737F33333330FFFFFFF03333337F3333337F33333330FFFFFFF
            03333337F3FFFFF7F33333330F40004F03333337F77777F7F33333330F00000F
            03333337F7F337F7F33333330F00000F03333337F7FFF7F7F33333330F40004F
            03333337F7777737F33333330FFFFFFF03333337FFFFFFF7F333333300000000
            0333333777777777333333333333333333333333333333333333}
          NumGlyphs = 2
          OnClick = btn_BroadSearchClick
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'test'
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 517
    Width = 720
    Height = 22
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Panels = <
      item
        Width = 1000
      end>
  end
  object Checkbox_DHCP: TCheckBox
    Left = 328
    Top = 300
    Width = 121
    Height = 21
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'DHCP mode'
    TabOrder = 3
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 701
    Top = 103
    Width = 232
    Height = 158
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Setting Delimeter'
    TabOrder = 4
    Visible = False
    object Label9: TLabel
      Left = 30
      Top = 30
      Width = 88
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Time(*10ms)'
    end
    object Label10: TLabel
      Left = 30
      Top = 63
      Width = 96
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Size(1~1024)'
    end
    object Label11: TLabel
      Left = 30
      Top = 95
      Width = 72
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Char(HEX)'
    end
    object Label12: TLabel
      Left = 30
      Top = 128
      Width = 128
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Idle Time(*10ms)'
    end
    object Edit_Time: TAdvEdit
      Left = 160
      Top = 26
      Width = 51
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EmptyTextStyle = []
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -13
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      ImeName = 'Microsoft Office IME 2007'
      ReadOnly = True
      TabOrder = 0
      Text = '10'
      Visible = True
      Version = '3.3.2.0'
    end
    object Edit_Size: TAdvEdit
      Left = 160
      Top = 59
      Width = 51
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EmptyTextStyle = []
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -13
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      ImeName = 'Microsoft Office IME 2007'
      ReadOnly = True
      TabOrder = 1
      Text = '0'
      Visible = True
      Version = '3.3.2.0'
    end
    object Edit_Char: TAdvEdit
      Left = 160
      Top = 91
      Width = 51
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EmptyTextStyle = []
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -13
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      ImeName = 'Microsoft Office IME 2007'
      ReadOnly = True
      TabOrder = 2
      Text = '03'
      Visible = True
      Version = '3.3.2.0'
    end
    object Edit_Idle: TAdvEdit
      Left = 160
      Top = 124
      Width = 51
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EmptyTextStyle = []
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -13
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      ImeName = 'Microsoft Office IME 2007'
      ReadOnly = True
      TabOrder = 3
      Text = '10'
      Visible = True
      Version = '3.3.2.0'
    end
  end
  object GroupBox2: TGroupBox
    Left = 701
    Top = 269
    Width = 232
    Height = 202
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Setting Serial'
    TabOrder = 5
    Visible = False
    object Label13: TLabel
      Left = 30
      Top = 35
      Width = 40
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Speed'
    end
    object Label14: TLabel
      Left = 30
      Top = 68
      Width = 56
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Databit'
    end
    object Label15: TLabel
      Left = 30
      Top = 100
      Width = 48
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Parity'
    end
    object Label16: TLabel
      Left = 33
      Top = 133
      Width = 64
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Stop bit'
    end
    object Label17: TLabel
      Left = 33
      Top = 165
      Width = 32
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Flow'
    end
    object ComboBox_Boad: TComboBox
      Left = 100
      Top = 30
      Width = 111
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ImeName = 'Microsoft Office IME 2007'
      ItemIndex = 5
      TabOrder = 0
      Text = '38400'
      Items.Strings = (
        '1200'
        '2400'
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200'
        '230400')
    end
    object ComboBox_Databit: TComboBox
      Left = 100
      Top = 63
      Width = 111
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ImeName = 'Microsoft Office IME 2007'
      ItemIndex = 1
      TabOrder = 1
      Text = '8'
      Items.Strings = (
        '7'
        '8')
    end
    object ComboBox_Parity: TComboBox
      Left = 100
      Top = 95
      Width = 111
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ImeName = 'Microsoft Office IME 2007'
      ItemIndex = 0
      TabOrder = 2
      Text = 'None'
      Items.Strings = (
        'None'
        'Odd'
        'Even')
    end
    object ComboBox_Stopbit: TComboBox
      Left = 100
      Top = 128
      Width = 111
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ImeName = 'Microsoft Office IME 2007'
      ItemIndex = 0
      TabOrder = 3
      Text = '1'
      Items.Strings = (
        '1')
    end
    object ComboBox_Flow: TComboBox
      Left = 100
      Top = 160
      Width = 111
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ImeName = 'Microsoft Office IME 2007'
      ItemIndex = 0
      TabOrder = 4
      Text = 'None'
      Items.Strings = (
        'None'
        'Xon/Xoff'
        'CTS/RTS')
    end
  end
  object ADOTmpQuery: TADOQuery
    Parameters = <>
    Left = 32
    Top = 136
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    Top = 99
  end
  object IdUDPClient1: TIdUDPClient
    BroadcastEnabled = True
    Port = 0
    Top = 59
  end
  object WiznetTimer: TTimer
    Enabled = False
    Interval = 5000
    Left = 132
  end
end
