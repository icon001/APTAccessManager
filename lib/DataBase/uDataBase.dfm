object dmDataBase: TdmDataBase
  OldCreateOrder = False
  Height = 171
  Width = 270
  object ADOConnection: TADOConnection
    Left = 56
    Top = 8
  end
  object ADOEventConnection: TADOConnection
    Left = 160
    Top = 8
  end
  object ADOQuery: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 56
    Top = 64
  end
  object ADOEventQuery: TADOQuery
    Connection = ADOEventConnection
    Parameters = <>
    Left = 160
    Top = 64
  end
  object ADOTmpQuery: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 56
    Top = 120
  end
end