unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  uRCGPlaceAutocompleteCombo, Vcl.ExtCtrls, Vcl.WinXCtrls, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, uGooglePlacesDetails;

type
  TfrmMain = class(TForm)
    cbKeepResults: TCheckBox;
    edtGoogleApiKey: TLabeledEdit;
    edtSearchAfterKeystrokes: TLabeledEdit;
    btnUpdateComp: TButton;
    comboSearchBehaviour: TComboBox;
    Label1: TLabel;
    comboDropDownOnResults: TCheckBox;
    RCGPlaceAutocompleteCombo1: TRCGPlaceAutocompleteCombo;
    ActivityIndicator1: TActivityIndicator;
    edtSessionToken: TLabeledEdit;
    edtOrigin: TLabeledEdit;
    edtLocation: TLabeledEdit;
    edtRadius: TLabeledEdit;
    edtLanguage: TLabeledEdit;
    edtOffset: TLabeledEdit;
    Label2: TLabel;
    comboPlaceType: TComboBox;
    edtComponents: TLabeledEdit;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    cbAutopolulateOnSelect: TCheckBox;
    Label3: TLabel;
    Memo1: TMemo;
    procedure btnUpdateCompClick(Sender: TObject);
    procedure RCGPlaceAutocompleteCombo1AutoCompleteRESTRequestFailed(
      const Sender: TObject; const AException: Exception);
    procedure RCGPlaceAutocompleteCombo1FillPlaceRESTRequestFailed(
      const Sender: TObject; const AException: Exception);
    procedure RCGPlaceAutocompleteCombo1PlaceDetailsRequestComplete(
      const Sender: TObject; const APlaceDetails: TPlaceRootClass);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Rtti;

{$R *.dfm}

procedure TfrmMain.btnUpdateCompClick(Sender: TObject);
var
  LOrigin, LOriginSplit: string;
  LLocation, LLocationSplit: string;
  LComponents, LComponentsSplit: string;
  I: Integer;
begin
  RCGPlaceAutocompleteCombo1.GoogleAPIKey := edtGoogleApiKey.Text;
  RCGPlaceAutocompleteCombo1.KeepResults := cbKeepResults.Checked;

  if comboSearchBehaviour.ItemIndex = 0 then
    RCGPlaceAutocompleteCombo1.SearchBehavior := sbWhileTyping else
      RCGPlaceAutocompleteCombo1.SearchBehavior := sbOnReturn;

  RCGPlaceAutocompleteCombo1.SearchAfterKeystrokeCount := StrToIntDef(edtSearchAfterKeystrokes.Text, 3);
  RCGPlaceAutocompleteCombo1.AutoDropDown := comboDropDownOnResults.Checked;
  RCGPlaceAutocompleteCombo1.SessionToken := edtSessionToken.Text;
  RCGPlaceAutocompleteCombo1.Offeset := StrToIntDef(edtOffset.Text ,0);

  LOrigin := edtOrigin.Text;

  I := 0;
  for LOriginSplit in LOrigin.Split([',']) do
  begin
    if I = 0 then
      RCGPlaceAutocompleteCombo1.Origin.Lat := StrToFloatDef(LOriginSplit, 0) else
        RCGPlaceAutocompleteCombo1.Origin.Long := StrToFloatDef(LOriginSplit, 0);

    Inc(I);
  end;

  LLocation := edtLocation.Text;

  I := 0;
  for LLocationSplit in LLocation.Split([',']) do
  begin
    if I = 0 then
      RCGPlaceAutocompleteCombo1.Location.Lat := StrToFloatDef(LLocationSplit, 0) else
        RCGPlaceAutocompleteCombo1.Location.Long := StrToFloatDef(LLocationSplit, 0);

    Inc(I);
  end;

  RCGPlaceAutocompleteCombo1.Radius := StrToIntDef(edtRadius.Text, 0);
  RCGPlaceAutocompleteCombo1.Language := edtLanguage.Text;

  LComponents := edtComponents.Text;

  RCGPlaceAutocompleteCombo1.CountryCodeAlpha2.Clear;

  for LComponentsSplit in LComponents.Split([',']) do
  begin
    RCGPlaceAutocompleteCombo1.CountryCodeAlpha2.Add(LComponentsSplit);
  end;

  case comboPlaceType.ItemIndex of
    0: RCGPlaceAutocompleteCombo1.PlaceType := ptGeocode;
    1: RCGPlaceAutocompleteCombo1.PlaceType := ptAddress;
    2: RCGPlaceAutocompleteCombo1.PlaceType := ptEstablishment;
    3: RCGPlaceAutocompleteCombo1.PlaceType := ptRegions;
    4: RCGPlaceAutocompleteCombo1.PlaceType := ptCities;
    else RCGPlaceAutocompleteCombo1.PlaceType := ptAddress;
  end;

  RCGPlaceAutocompleteCombo1.AutoPopulatePlaceDetailsOnSelect := cbAutopolulateOnSelect.Checked;

  ShowMessage('Properties Updated');
end;

procedure TfrmMain.RCGPlaceAutocompleteCombo1AutoCompleteRESTRequestFailed(
  const Sender: TObject; const AException: Exception);
begin
  raise AException;
end;

procedure TfrmMain.RCGPlaceAutocompleteCombo1FillPlaceRESTRequestFailed(
  const Sender: TObject; const AException: Exception);
begin
  raise AException;
end;

procedure TfrmMain.RCGPlaceAutocompleteCombo1PlaceDetailsRequestComplete(
  const Sender: TObject; const APlaceDetails: TPlaceRootClass);
begin
  Memo1.Text := APlaceDetails.ToJsonString;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;
end.
