object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Test'
  ClientHeight = 802
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 136
    Width = 84
    Height = 13
    Caption = 'Search Behaviour'
  end
  object Label2: TLabel
    Left = 17
    Top = 381
    Width = 57
    Height = 13
    Caption = 'Place Types'
  end
  object Label3: TLabel
    Left = 600
    Top = 10
    Width = 60
    Height = 13
    Caption = 'Place Details'
  end
  object cbKeepResults: TCheckBox
    Left = 16
    Top = 16
    Width = 78
    Height = 17
    Caption = 'KeepResults'
    TabOrder = 0
  end
  object edtGoogleApiKey: TLabeledEdit
    Left = 16
    Top = 56
    Width = 361
    Height = 21
    EditLabel.Width = 74
    EditLabel.Height = 13
    EditLabel.Caption = 'Google API Key'
    TabOrder = 1
  end
  object edtSearchAfterKeystrokes: TLabeledEdit
    Left = 16
    Top = 101
    Width = 121
    Height = 21
    EditLabel.Width = 179
    EditLabel.Height = 13
    EditLabel.Caption = 'Search After X Number of Keystrokes'
    TabOrder = 2
    Text = '3'
  end
  object btnUpdateComp: TButton
    Left = 16
    Top = 460
    Width = 177
    Height = 25
    Caption = 'Update Component Properties'
    TabOrder = 3
    OnClick = btnUpdateCompClick
  end
  object comboSearchBehaviour: TComboBox
    Left = 107
    Top = 133
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = 'WhileTyping'
    Items.Strings = (
      'WhileTyping'
      'OnReturnPressed')
  end
  object comboDropDownOnResults: TCheckBox
    Left = 16
    Top = 163
    Width = 225
    Height = 17
    Caption = 'ShowDropDownWhenResultsArePopulated'
    TabOrder = 5
  end
  object RCGPlaceAutocompleteCombo1: TRCGPlaceAutoCompleteCombo
    Left = 67
    Top = 640
    Width = 745
    Height = 37
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'RCGPlaceAutocompleteCombo1'
    GoogleAPIKey = 'AIzaSyBh_pM5DMLhYz8E412uyEkWDGO-c0YR1GA'
    ActivityIndicator = ActivityIndicator1
    OnAutoCompleteRESTRequestFailed = RCGPlaceAutocompleteCombo1AutoCompleteRESTRequestFailed
    CountryCodeAlpha2.Strings = (
      'ZA'
      'FR')
    PlaceType = ptAddress
    RestClient = RESTClient1
    RestRequest = RESTRequest1
    OnFillPlaceRESTRequestFailed = RCGPlaceAutocompleteCombo1FillPlaceRESTRequestFailed
    AutoPopulatePlaceDetailsOnSelect = False
    OnPlaceDetailsRequestComplete = RCGPlaceAutocompleteCombo1PlaceDetailsRequestComplete
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 818
    Top = 643
    IndicatorType = aitSectorRing
  end
  object edtSessionToken: TLabeledEdit
    Left = 16
    Top = 208
    Width = 121
    Height = 21
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'sessiontoken '
    TabOrder = 8
  end
  object edtOrigin: TLabeledEdit
    Left = 16
    Top = 251
    Width = 121
    Height = 21
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'origin (Lat Long)'
    TabOrder = 9
    Text = '0,0'
  end
  object edtLocation: TLabeledEdit
    Left = 168
    Top = 251
    Width = 121
    Height = 21
    EditLabel.Width = 89
    EditLabel.Height = 13
    EditLabel.Caption = 'location (Lat Long)'
    TabOrder = 10
    Text = '0,0'
  end
  object edtRadius: TLabeledEdit
    Left = 16
    Top = 296
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'radius '
    TabOrder = 11
  end
  object edtLanguage: TLabeledEdit
    Left = 168
    Top = 296
    Width = 121
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'language '
    TabOrder = 12
    Text = 'en'
  end
  object edtOffset: TLabeledEdit
    Left = 168
    Top = 208
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'offset '
    TabOrder = 13
    Text = '0'
  end
  object comboPlaceType: TComboBox
    Left = 83
    Top = 378
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 14
    Text = 'ptAddress'
    Items.Strings = (
      'ptGeocode'
      'ptAddress'
      'ptEstablishment'
      'ptRegions'
      'ptCities')
  end
  object edtComponents: TLabeledEdit
    Left = 17
    Top = 338
    Width = 121
    Height = 21
    EditLabel.Width = 106
    EditLabel.Height = 13
    EditLabel.Caption = 'components/countries'
    TabOrder = 15
    Text = 'ZA,GB,US'
  end
  object cbAutopolulateOnSelect: TCheckBox
    Left = 17
    Top = 411
    Width = 200
    Height = 17
    Caption = 'AutoPopulatePlaceDetailsOnSelect'
    TabOrder = 16
  end
  object Memo1: TMemo
    Left = 600
    Top = 29
    Width = 305
    Height = 496
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 17
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    SynchronizedEvents = False
    Left = 400
    Top = 296
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 400
    Top = 200
  end
end
