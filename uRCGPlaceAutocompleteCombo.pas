{
  ************************************************************************************************
  R. Coetzee - 06/04/2020
  ************************************************************************************************
  TRCGPlaceAutoCompleteCombo is a tightly integrated Restful combo control that exposes
  all the functionality of Google's place autocomplete API and Place Details API:
  ************************************************************************************************

  Google's RESTFUL Autocomplete API: https://developers.google.com/places/web-service/autocomplete
  Google's RESTFUL  places API: https://developers.google.com/places/web-service/details

  With Special thanks to:
  JsonToDelphiClass - 0.65 | Petar Georgiev - 2014 |
  http://pgeorgiev.com | https://github.com/PKGeorgiev/Delphi-JsonToDelphiClass

  Google's Places API Policies with links to it's mapping policies in general:
  https://developers.google.com/places/web-service/policies

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Google's web services IS NOT A FREE SERVICE 
  https://developers.google.com/places/web-service/usage-and-billing
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

unit uRCGPlaceAutocompleteCombo;

interface

uses
  Vcl.StdCtrls, uGooglePlacesAutocomplete, System.Classes, REST.Client,
  Vcl.ExtCtrls, System.Threading, Vcl.WinXCtrls, REST.Types, System.SysUtils,
  Winapi.Windows, System.Generics.Collections, uGooglePlacesDetails;

type
  TRCGSearchBehaviour = (sbWhileTyping, sbOnReturn);

  TRCGPlaceType = (ptGeocode, ptAddress, ptEstablishment, ptRegions, ptCities);

  /// <summary>
  //   Event that fires if the autocomplete REST request fails
  /// </summary>
  /// <returns>
  ///  Exception. If not implemeted Raises Base Exception     
  /// </returns>
  TAutoCompleteRESTRequestFailed = procedure(const Sender: TObject; const AException: Exception) of object;
  /// <summary>
  //   Event that fires if the get place details REST request fails
  /// </summary>
  /// <returns>
  ///  Exception. If not implemeted Raises Base Exception     
  /// </returns>
  TFillPlaceRESTRequestFailed = procedure(const Sender: TObject; const AException: Exception) of object;
  /// <summary>
  //   Event that fires after the place fetails REST request completes successfully
  /// </summary>
  /// <returns>
  ///  Constant expression of the TPlaceRootClass class with the Place's details
  /// </returns>
  TPlaceDetailsRequestComplete = procedure(const Sender: TObject; const APlaceDetails: TPlaceRootClass) of object;

  TLatLong = class(TObject)
    private
      FLat: Double;
      FLong: Double;
    public
      constructor Create;
      property Lat: Double read FLat write FLat;
      property Long: Double read FLong write FLong;
      function HasValues: Boolean;
      function GetLatLngAsCommaStrForAPIRequest: string;
  end;

  IRCGAutoCompleteControl = interface(IInterface)
  ['{1FAA4014-2A68-4CB8-BED5-A8EDE2B76E8F}']
    function GetGoogleAPIKey: string;
    Procedure SetGoogleAPIKey(const Value: string);

    function GetSearchBehavior: TRCGSearchBehaviour;
    procedure SetSearchBehavior(const Value: TRCGSearchBehaviour);

    function GetSearchAfterKeystrokeCount: Integer;
    procedure SetSearchAfterKeystrokeCount(const Value: Integer);

    function GetKeepResults: Boolean;
    procedure SetGetKeepResults(const Value: Boolean);

    function GetActivityIndicator: TActivityIndicator;
    procedure SetActivityIndicator(const Value: TActivityIndicator);

    function GetAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed;
    procedure SetAutoCompleteRESTRequestFailed(const Value: TAutoCompleteRESTRequestFailed);

    function GetCountryCodeAlpha2: TStrings;
    Procedure SetCountryCodeAlpha2(const Value: TStrings);

    function GetSessionToken: string;
    Procedure SetSessionToken(const Value: string);

    function GetOffset: Integer;
    procedure SetOffset(const Value: Integer);

    function GetOrigin: TLatLong;
    Procedure SetOrigin(const Value: TLatLong);

    function GetLocation: TLatLong;
    Procedure SetLocation(const Value: TLatLong);

    function GetRadius: Integer;
    Procedure SetRadius(const Value: Integer);

    function GetPlaceType: TRCGPlaceType;
    Procedure SetPlaceType(const Value: TRCGPlaceType);

    function GetLanguage: string;
    Procedure SetLanguage(const Value: string);

    function GetRestClient: TRESTClient;
    procedure SetRestClient(const Value: TRESTClient);

    function GetRestRequest: TRESTRequest;
    procedure SetRestRequest(const Value: TRESTRequest);

    function GetLastResponseStatus: string;
    function GetAutocompleteResults: TObjectDictionary<string, TPredictionsClass>;

    procedure FillPlaceDetails(var APlaceDetails: TPlaceRootClass; const APlaceId: string);
    procedure FindPredictions(const Value: string; var APredictions: TPredictionsRootClass);

    function GetFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed;
    procedure SetFillPlaceRESTRequestFailed(const Value: TFillPlaceRESTRequestFailed);

    function GetAutoPopulatePlaceDetailsOnSelect: Boolean;
    procedure SetAutoPopulatePlaceDetailsOnSelect(const Value: Boolean);

    function GetPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete;
    procedure SetPlaceDetailsRequestComplete(const Value: TPlaceDetailsRequestComplete);

    function RestAdaptersLinked: Boolean;

    property GoogleAPIKey: string read GetGoogleAPIKey write SetGoogleAPIKey;
    property SearchBehavior: TRCGSearchBehaviour read GetSearchBehavior write SetSearchBehavior;
    property SearchAfterKeystrokeCount: Integer read GetSearchAfterKeystrokeCount write SetSearchAfterKeystrokeCount;
    property KeepResults: Boolean read GetKeepResults write SetGetKeepResults;
    property ActivityIndicator: TActivityIndicator read GetActivityIndicator write SetActivityIndicator;
    property OnAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed read GetAutoCompleteRESTRequestFailed write SetAutoCompleteRESTRequestFailed;
    property CountryCodeAlpha2: TStrings read GetCountryCodeAlpha2 write SetCountryCodeAlpha2;
    property SessionToken: string read GetSessionToken write SetSessionToken;
    property Offeset: Integer read GetOffset write SetOffset;
    property Origin: TLatLong read GetOrigin write SetOrigin;
    property Location: TLatLong read GetLocation write SetLocation;
    property Radius: Integer read GetRadius write SetRadius;
    property PlaceType: TRCGPlaceType read GetPlaceType write SetPlaceType;
    property Language: string read GetLanguage write SetLanguage;
    property LastResponseStatus: string read GetLastResponseStatus;
    property AutocompleteResults: TObjectDictionary<string, TPredictionsClass> read GetAutocompleteResults;
    property RestClient: TRESTClient read GetRestClient write SetRestClient;
    property RestRequest: TRESTRequest read GetRestRequest write SetRestRequest;
    property OnFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed read GetFillPlaceRESTRequestFailed write SetFillPlaceRESTRequestFailed;
    property AutoPopulatePlaceDetailsOnSelect: Boolean read GetAutoPopulatePlaceDetailsOnSelect write SetAutoPopulatePlaceDetailsOnSelect;
    property OnPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete read GetPlaceDetailsRequestComplete write SetPlaceDetailsRequestComplete;
  end;

  TRCGPlaceAutoCompleteCombo = class(TComboBox, IRCGAutoCompleteControl)
  private
    FGoogleAPIKey: string;
    FSearchAfterKeystrokeCount: Integer;
    FSearchBehavior: TRCGSearchBehaviour;
    FKeepResults: Boolean;
    FKeyStrokeCount: Integer;
    FActivityIndicator: TActivityIndicator;
    FAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed;
    FCountryCodeAlpha2: TStrings;
    FOffset: Integer;
    FOrigin: TLatLong;
    FSessionToken: string;
    FLocation: TLatLong;
    FRadius: Integer;
    FPlaceType: TRCGPlaceType;
    FLanguage: string;
    FLastResponseStatus: string;
    FAutocompleteResults: TObjectDictionary<string, TPredictionsClass>;
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed;
    FAutoPopulatePlaceDetailsOnSelect: Boolean;
    FPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete;

    function GetGoogleAPIKey: string;
    function GetSearchAfterKeystrokeCount: Integer;
    function GetSearchBehavior: TRCGSearchBehaviour;
    function GetKeepResults: Boolean;
    function GetActivityIndicator: TActivityIndicator;
    function GetAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed;
    function GetCountryCodeAlpha2: TStrings;
    function GetOffset: Integer;
    function GetOrigin: TLatLong;
    function GetSessionToken: string;
    function GetLocation: TLatLong;
    function GetRadius: Integer;
    function GetPlaceType: TRCGPlaceType;
    function GetLanguage: string;
    function GetRestClient: TRESTClient;
    function GetRestRequest: TRESTRequest;
    function GetFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed;
    function GetPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete;

    procedure SetGoogleAPIKey(const Value: string);
    procedure SetSearchAfterKeystrokeCount(const Value: Integer);
    procedure SetSearchBehavior(const Value: TRCGSearchBehaviour);
    procedure SetGetKeepResults(const Value: Boolean);
    procedure SetActivityIndicator(const Value: TActivityIndicator);
    procedure SetAutoCompleteRESTRequestFailed(const Value: TAutoCompleteRESTRequestFailed);
    procedure SetCountryCodeAlpha2(const Value: TStrings);
    procedure SetOffset(const Value: Integer);
    procedure SetOrigin(const Value: TLatLong);
    procedure SetSessionToken(const Value: string);
    procedure SetLocation(const Value: TLatLong);
    procedure SetRadius(const Value: Integer);
    procedure SetPlaceType(const Value: TRCGPlaceType);
    procedure SetLanguage(const Value: string);
    procedure SetRestClient(const Value: TRESTClient);
    procedure SetRestRequest(const Value: TRESTRequest);
    procedure SetFillPlaceRESTRequestFailed(const Value: TFillPlaceRESTRequestFailed);

    procedure BuildCombo(const Value: string);
    procedure FillComboWithPredictions(var APredictions: TPredictionsRootClass);

    procedure SetActivityIndicatorStat(AStat: Boolean);
    function BuildGoogleRequestString(Value: string): string;
    function GetLastResponseStatus: string;
    function GetAutocompleteResults: TObjectDictionary<string, TPredictionsClass>;
    function GetAutoPopulatePlaceDetailsOnSelect: Boolean;
    procedure SetAutoPopulatePlaceDetailsOnSelect(const Value: Boolean);
    procedure SetPlaceDetailsRequestComplete(const Value: TPlaceDetailsRequestComplete);
    function RestAdaptersLinked: Boolean;
  strict private
    FPredictions: ITask;
    FPlaceDetails: ITask;
    FPredictionsMemLst: TObjectList<TPredictionsRootClass>;
    FPlaceDetailsMemLst: TObjectDictionary<string, TPlaceRootClass>;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Select; override;
  public
    /// <summary>
    ///  The results that are currently populated in the TRCGPlaceAutoCompleteCombo
    /// </summary>
    property AutocompleteResults: TObjectDictionary<string, TPredictionsClass> read GetAutocompleteResults;
    /// <summary>
    ///  The last REST response status returned by the Google API
    ///  See: https://developers.google.com/places/web-service/autocomplete#place_autocomplete_status_codes
    /// </summary>
    property LastResponseStatus: string read GetLastResponseStatus;
    /// <summary>
    ///  Can be used outside the normal scope of the component to find predictions.
    ///  Remember to set PlaceType for the different pace types supported
    ///  https://developers.google.com/places/web-service/autocomplete#place_types
    /// </summary>
    /// <param name="Value">
    ///  Place Name / Place Name Part
    /// </param>
    /// <param name="APredictions">
    ///  Your own TPredictionsRootClass Variable
    /// </param>
    /// <returns>
    ///  Your own TPredictionsRootClass Variable
    /// </returns>
    procedure FindPredictions(const Value: string; var APredictions: TPredictionsRootClass);
    /// <summary>
    ///  Can be used outside the normal scope of the component to get place details.
    ///  One can use "FindPredictions" to get a list of predictions, each prediction will have a Place_Id
    ///  that can be used as the APlaceId value
    /// </summary>
    /// <param name="APlaceDetails">
    ///  Your own TPlaceRootClass Variable
    /// </param>
    /// <param name="APlaceId">
    ///  The place_id of a prediction returned by a "FindPredictions" requests predictions
    /// </param>
    /// <returns>
    ///  Your own TPlaceRootClass Variable
    /// </returns>
    procedure FillPlaceDetails(var APlaceDetails: TPlaceRootClass; const APlaceId: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property GoogleAPIKey: string read GetGoogleAPIKey write SetGoogleAPIKey;
    property SearchBehavior: TRCGSearchBehaviour read GetSearchBehavior write SetSearchBehavior default sbWhileTyping;
    property SearchAfterKeystrokeCount: Integer read GetSearchAfterKeystrokeCount write SetSearchAfterKeystrokeCount default 3;
    property KeepResults: Boolean read GetKeepResults write SetGetKeepResults default False;
    property ActivityIndicator: TActivityIndicator read GetActivityIndicator write SetActivityIndicator;
    property OnAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed read GetAutoCompleteRESTRequestFailed write SetAutoCompleteRESTRequestFailed;
    property CountryCodeAlpha2: TStrings read GetCountryCodeAlpha2 write SetCountryCodeAlpha2;
    property SessionToken: string read GetSessionToken write SetSessionToken;
    property Offeset: Integer read GetOffset write SetOffset default 0;
    property Origin: TLatLong read GetOrigin write SetOrigin;
    property Location: TLatLong read GetLocation write SetLocation;
    property Radius: Integer read GetRadius write SetRadius default 0;
    property PlaceType: TRCGPlaceType read GetPlaceType write SetPlaceType;
    property Language: string read GetLanguage write SetLanguage;
    property RestClient: TRESTClient read GetRestClient write SetRestClient;
    property RestRequest: TRESTRequest read GetRestRequest write SetRestRequest;
    property OnFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed read GetFillPlaceRESTRequestFailed write SetFillPlaceRESTRequestFailed;
    property AutoPopulatePlaceDetailsOnSelect: Boolean read GetAutoPopulatePlaceDetailsOnSelect write SetAutoPopulatePlaceDetailsOnSelect;
    property OnPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete read GetPlaceDetailsRequestComplete write SetPlaceDetailsRequestComplete;
  end;

implementation

const
  GMapsBaseAPIEndpoint = 'https://maps.googleapis.com/maps/api/place/';
  GMapsBaseAutocompletePart = 'autocomplete/';
  GMapsBasePlaceDetailsPart = 'details/';

  OmittedKeys: TArray<Word> = [VK_RETURN, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_DELETE,
                               VK_TAB, VK_CAPITAL, VK_SHIFT, VK_SPACE];

{ TRCGPlaceAutocompleteCombo }


/// <summary>
/// Executed within KeyDown, the high level implemantation of building the Autocomplete Results 
/// <summary>
procedure TRCGPlaceAutocompleteCombo.BuildCombo(const Value: string);
begin
  if not RestAdaptersLinked then
  begin
    raise Exception.Create('An association with a TRESTClient and a TRESTRequest is neccesary to execute RESTFul calls to the Google API');
  end;

  SetActivityIndicatorStat(True);

  FPredictions := TTask.Create(
  procedure
  var
    LPredictions: TPredictionsRootClass;
    Ex: Exception;
  begin
    try
      FindPredictions(Value, LPredictions);

      TThread.Synchronize(Nil,
      procedure
      begin
        SetActivityIndicatorStat(False);
        FillComboWithPredictions(LPredictions);
        FPredictionsMemLst.Add(LPredictions);
      end);
    except
      begin
        Ex := AcquireExceptionObject as Exception;
        FLastResponseStatus := Ex.ToString;

        TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          SetActivityIndicatorStat(False);

          if Assigned(FAutoCompleteRESTRequestFailed) then
          begin
            FAutoCompleteRESTRequestFailed(Self, Ex);
            FreeAndNil(Ex);
          end else
          begin
            raise Ex;
          end;
        end);
      end;
    end;
  end);

  FPredictions.Start;
end;

/// <summary>
/// Fills the combobox with results gathered from "FindPredictions" 
/// <summary>
procedure TRCGPlaceAutocompleteCombo.FillComboWithPredictions(
  var APredictions: TPredictionsRootClass);
var
  Prediction: TPredictionsClass;
  LCurrentTypedText: string;
  LLastCaretPos: Integer;
begin
  if not FKeepResults then
  begin
    LCurrentTypedText := Copy(Self.Text, 0, Self.SelStart);
    LLastCaretPos := Self.SelStart;
    Self.Clear;
    FAutocompleteResults.Clear;
    Self.Text := LCurrentTypedText;
    Self.SelStart := LLastCaretPos;
  end;

  for Prediction in APredictions.predictions do
  begin
    if not (FAutocompleteResults.ContainsKey(Prediction.place_id)) then
    begin
      FAutocompleteResults.Add(Prediction.place_id, Prediction);

      Self.AddItem(Prediction.description, Prediction);
    end;
  end;
end;

/// <summary>
/// Actual RESTFul call to Google retuning Place Details
/// <summary>
procedure TRCGPlaceAutoCompleteCombo.FillPlaceDetails(
  var APlaceDetails: TPlaceRootClass; const APlaceId: string);
begin
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Client.BaseURL := GMapsBaseAPIEndpoint + GMapsBasePlaceDetailsPart;
  FRESTRequest.Method := rmGET;
  FRESTRequest.Resource := Format('json?placeid=%s&key=%s', [APlaceID, FGoogleAPIKey]);
  FRESTRequest.Execute;

  APlaceDetails := TPlaceRootClass.FromJsonString(FRESTRequest.Response.Content);

  FLastResponseStatus := APlaceDetails.status;
end;

/// <summary>
/// Build the REST request's resource string (http string) to send to Google based on the control's properties and the user input
/// <summary>
function TRCGPlaceAutoCompleteCombo.BuildGoogleRequestString(Value: string): string;
var
  LCountryCode: string;
  LCountryBuilder: string;
begin
  Result := Format('json?input=%s', [Value]);

  case FPlaceType of
    ptGeocode: Result := Result + '&types=geocode';
    ptAddress: Result := Result + '&types=address';
    ptEstablishment: Result := Result + '&types=establishment';
    ptRegions: Result := Result + '&types=(regions)';
    ptCities: Result := Result + '&types=(cities)';
    else Result := Result + '&types=address';
  end;

  if FSessionToken <> '' then
    Result := Result + Format('&sessiontoken=%s', [SessionToken]);

  if FOffset <> 0 then
    Result := Result + Format('&offset=%s', [FOffset]);

  if FORigin.HasValues then
    Result := Result + Format('&origin=%s', [FOrigin.GetLatLngAsCommaStrForAPIRequest]);

  if FLocation.HasValues then
    Result := Result + Format('&location=%s', [FLocation.GetLatLngAsCommaStrForAPIRequest]);

  if FRadius <> 0 then
    Result := Result + Format('&radius=%s', [FRadius]);

  if FLanguage <> '' then
    Result := Result + Format('&language=%s', [FLanguage]);

  if FCountryCodeAlpha2.Count > 0 then
  begin
    LCountryBuilder := '&components=';

    for LCountryCode in FCountryCodeAlpha2 do
    begin
      LCountryBuilder := LCountryBuilder + Format('country:%s|', [LCountryCode])
    end;

    LCountryBuilder := Copy(LCountryBuilder, 0, Length(LCountryBuilder) -1);

    Result := Result + LCountryBuilder;
  end;

  Result := Result + Format('&key=%s', [FGoogleAPIKey])
end;

constructor TRCGPlaceAutocompleteCombo.Create(AOwner: TComponent);
var
  LDictionaryOwnerships: TDictionaryOwnerships;
begin
  inherited;

  FKeyStrokeCount := 1;
  FSearchAfterKeystrokeCount := 3;
  FSearchBehavior := sbWhileTyping;
  FKeepResults := False;
  FCountryCodeAlpha2 := TStringList.Create;
  FOrigin := TLatLong.Create;
  FLocation := TLatLong.Create;
  FOffset := 0;
  FRadius := 0;

  LDictionaryOwnerships := [doOwnsValues];
  FAutocompleteResults := TObjectDictionary<string, TPredictionsClass>.Create();
  FPredictionsMemLst := TObjectList<TPredictionsRootClass>.Create(True);
  FPlaceDetailsMemLst := TObjectDictionary<string, TPlaceRootClass>.Create(LDictionaryOwnerships);
end;

destructor TRCGPlaceAutocompleteCombo.Destroy;
begin
  FreeAndNil(FCountryCodeAlpha2);
  FreeAndNil(FOrigin);
  FreeAndNil(FLocation);
  FreeAndNil(FPredictionsMemLst);
  FreeAndNil(FAutocompleteResults);
  FreeAndNil(FPlaceDetailsMemLst);

  inherited;
end;

/// <summary>
/// Actual RESTFul call to Google retuning Predictions for the current user input
/// <summary>
procedure TRCGPlaceAutocompleteCombo.FindPredictions(
  const Value: string; var APredictions: TPredictionsRootClass);
begin
  FRESTClient.BaseURL := GMapsBaseAPIEndpoint + GMapsBaseAutocompletePart;
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Method := rmGET;
  FRESTRequest.Resource := BuildGoogleRequestString(Value);
  FRESTRequest.Execute;

  APredictions := TPredictionsRootClass.FromJsonString(FRESTRequest.Response.Content);

  FLastResponseStatus := APredictions.status;
end;

function TRCGPlaceAutoCompleteCombo.GetActivityIndicator: TActivityIndicator;
begin
  Result := FActivityIndicator;
end;

function TRCGPlaceAutoCompleteCombo.GetAutoCompleteRESTRequestFailed: TAutoCompleteRESTRequestFailed;
begin
  Result := FAutoCompleteRESTRequestFailed;
end;

function TRCGPlaceAutoCompleteCombo.GetAutocompleteResults: TObjectDictionary<string, TPredictionsClass>;
begin
  Result := FAutocompleteResults;
end;

function TRCGPlaceAutoCompleteCombo.GetAutoPopulatePlaceDetailsOnSelect: Boolean;
begin
  Result := FAutoPopulatePlaceDetailsOnSelect;
end;

function TRCGPlaceAutoCompleteCombo.GetCountryCodeAlpha2: TStrings;
begin
  Result := FCountryCodeAlpha2;
end;

function TRCGPlaceAutoCompleteCombo.GetFillPlaceRESTRequestFailed: TFillPlaceRESTRequestFailed;
begin
  Result := FFillPlaceRESTRequestFailed;
end;

function TRCGPlaceAutocompleteCombo.GetGoogleAPIKey: string;
begin
  Result := FGoogleAPIKey;
end;

function TRCGPlaceAutocompleteCombo.GetKeepResults: Boolean;
begin
  Result := FKeepResults;
end;

function TRCGPlaceAutoCompleteCombo.GetLanguage: string;
begin
  Result := FLanguage;
end;

function TRCGPlaceAutoCompleteCombo.GetLastResponseStatus: string;
begin
  Result := FLastResponseStatus;
end;

function TRCGPlaceAutoCompleteCombo.GetLocation: TLatLong;
begin
  Result := FLocation;
end;

function TRCGPlaceAutoCompleteCombo.GetOffset: Integer;
begin
  Result := FOffset;
end;

function TRCGPlaceAutoCompleteCombo.GetOrigin: TLatLong;
begin
  Result := FOrigin;
end;

function TRCGPlaceAutoCompleteCombo.GetPlaceDetailsRequestComplete: TPlaceDetailsRequestComplete;
begin
  Result := FPlaceDetailsRequestComplete;
end;

function TRCGPlaceAutoCompleteCombo.GetPlaceType: TRCGPlaceType;
begin
  Result := FPlaceType;
end;

function TRCGPlaceAutoCompleteCombo.GetRadius: Integer;
begin
  Result := FRadius;
end;

function TRCGPlaceAutoCompleteCombo.GetRestClient: TRESTClient;
begin
  Result := FRestClient;
end;

function TRCGPlaceAutoCompleteCombo.GetRestRequest: TRESTRequest;
begin
  Result := FRESTRequest;
end;

function TRCGPlaceAutocompleteCombo.GetSearchAfterKeystrokeCount: Integer;
begin
  Result := FSearchAfterKeystrokeCount;
end;

function TRCGPlaceAutocompleteCombo.GetSearchBehavior: TRCGSearchBehaviour;
begin
  Result := FSearchBehavior;
end;

function TRCGPlaceAutoCompleteCombo.GetSessionToken: string;
begin
  Result := FSessionToken;
end;

/// <summary>
/// Override key down checking basic top level properties
/// <summary>
procedure TRCGPlaceAutocompleteCombo.KeyDown(var Key: Word;
  Shift: TShiftState);
var
  LOmitKey: Word;
begin
  if FSearchBehavior = sbWhileTyping then
  begin
    for LOmitKey in OmittedKeys do
    begin
      if LOmitKey = Key then
      begin
        Exit;
      end;
    end;

    if (Length(Self.Text) < FSearchAfterKeystrokeCount) or (Self.Text = '') then
      Exit;

    if FKeyStrokeCount > FSearchAfterKeystrokeCount then
      FKeyStrokeCount := 1;

    if FKeyStrokeCount = FSearchAfterKeystrokeCount then
    begin
      BuildCombo(Self.Text);

      Inc(FKeyStrokeCount);
    end else
    begin
      Inc(FKeyStrokeCount)
    end;
  end else
  if FSearchBehavior = sbOnReturn then
  begin
    if Key = VK_RETURN then
    begin
     BuildCombo(Self.Text);
    end;
  end;

  inherited;
end;

function TRCGPlaceAutoCompleteCombo.RestAdaptersLinked: Boolean;
begin
  Result := Assigned(FRESTClient) and Assigned(FRESTRequest);
end;

/// <summary>
///  Override select, 
///  if FAutoPopulatePlaceDetailsOnSelect is True then we find the current selected Place's details based on the current
//   Autocompleted Results
/// </summary>
/// <remarks>
///  Maybe move this to onCloseUp.. Will wait for community feedback... ?
/// </remarks>
procedure TRCGPlaceAutoCompleteCombo.Select;
begin
  inherited;

  if FAutoPopulatePlaceDetailsOnSelect then
  begin
    if (Self.ItemIndex >= 0) and (Assigned(Self.Items.Objects[Self.ItemIndex])) then
    begin
      if ((Self.Items.Objects[Self.ItemIndex]) is TPredictionsClass) then
      begin
        SetActivityIndicatorStat(True);

        FPlaceDetails := TTask.Create(
        procedure
        var
          Ex: Exception;
          LPlaceRootClass: TPlaceRootClass;
          LPredPlaceId: String;
        begin
          try
            LPredPlaceId := ((Self.Items.Objects[Self.ItemIndex]) as TPredictionsClass).place_id;

            if not FPlaceDetailsMemLst.TryGetValue(LPredPlaceId, LPlaceRootClass) then
            begin
              FillPlaceDetails(LPlaceRootClass, LPredPlaceId);
              FPlaceDetailsMemLst.Add(LPredPlaceId, LPlaceRootClass);
            end;

            TThread.Synchronize(Nil,
            procedure
            begin
              if Assigned(FPlaceDetailsRequestComplete) then
              begin
                FPlaceDetailsRequestComplete(Self, LPlaceRootClass);
              end;

              SetActivityIndicatorStat(False);
            end);
          except
            begin
              Ex := AcquireExceptionObject as Exception;
              FLastResponseStatus := Ex.Message;

              TThread.Queue(TThread.CurrentThread,
              procedure
              begin
                SetActivityIndicatorStat(False);

                if Assigned(FFillPlaceRESTRequestFailed) then
                begin
                  FFillPlaceRESTRequestFailed(Self, Ex);
                  FreeAndNil(Ex);
                end else
                begin
                  raise Ex;
                end;
              end);
            end;
          end;
        end);

        FPlaceDetails.Start;
      end;
    end;
  end;
end;

procedure TRCGPlaceAutoCompleteCombo.SetActivityIndicator(
  const Value: TActivityIndicator);
begin
  FActivityIndicator := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetActivityIndicatorStat(
  AStat: Boolean);
begin
  if Assigned(FActivityIndicator) then
    FActivityIndicator.Animate := AStat;
end;

procedure TRCGPlaceAutoCompleteCombo.SetAutoCompleteRESTRequestFailed(
  const Value: TAutoCompleteRESTRequestFailed);
begin
  FAutoCompleteRESTRequestFailed := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetAutoPopulatePlaceDetailsOnSelect(
  const Value: Boolean);
begin
  FAutoPopulatePlaceDetailsOnSelect := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetCountryCodeAlpha2(
  const Value: TStrings);
begin
  if Assigned(FCountryCodeAlpha2) then
    FCountryCodeAlpha2.Assign(Value)
  else
    FCountryCodeAlpha2 := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetFillPlaceRESTRequestFailed(
  const Value: TFillPlaceRESTRequestFailed);
begin
  FFillPlaceRESTRequestFailed := Value;
end;

procedure TRCGPlaceAutocompleteCombo.SetGetKeepResults(
  const Value: Boolean);
begin
  FKeepResults := Value;
end;

procedure TRCGPlaceAutocompleteCombo.SetGoogleAPIKey(const Value: string);
begin
  FGoogleAPIKey := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetLanguage(const Value: string);
begin
  FLanguage := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetLocation(const Value: TLatLong);
begin
  FLocation := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetOffset(const Value: Integer);
begin
  FOffset := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetOrigin(const Value: TLatLong);
begin
  FOrigin := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetPlaceDetailsRequestComplete(
  const Value: TPlaceDetailsRequestComplete);
begin
  FPlaceDetailsRequestComplete := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetPlaceType(
  const Value: TRCGPlaceType);
begin
  FPlaceType := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetRadius(const Value: Integer);
begin
  FRadius := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetRestClient(
  const Value: TRESTClient);
begin
  FRestClient := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetRestRequest(
  const Value: TRESTRequest);
begin
  FRESTRequest := Value;
end;

procedure TRCGPlaceAutocompleteCombo.SetSearchAfterKeystrokeCount(
  const Value: Integer);
begin
  FSearchAfterKeystrokeCount := Value;
end;

procedure TRCGPlaceAutocompleteCombo.SetSearchBehavior(
  const Value: TRCGSearchBehaviour);
begin
  FSearchBehavior := Value;
end;

procedure TRCGPlaceAutoCompleteCombo.SetSessionToken(const Value: string);
begin
  FSessionToken := Value;
end;

{ TLatLong }

constructor TLatLong.Create;
begin
  FLat := 0;
  FLong := 0;
end;

function TLatLong.GetLatLngAsCommaStrForAPIRequest: string;
begin
  Result := FormatFloat('%2.6f', FLat) + ',' + FormatFloat('%2.6f', FLong);
end;

function TLatLong.HasValues: Boolean;
begin
  if (FLat = 0) and (FLong = 0) then
    Result := False else
      Result := True;
end;

end.
