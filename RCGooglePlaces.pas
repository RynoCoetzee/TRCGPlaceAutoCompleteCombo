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

unit RCGooglePlaces;

interface

uses
 System.Classes;

procedure Register;

implementation

uses
  uRCGPlaceAutocompleteCombo;

procedure Register;
begin
  RegisterComponents('RCComponents', [TRCGPlaceAutoCompleteCombo]);
end;

end.
