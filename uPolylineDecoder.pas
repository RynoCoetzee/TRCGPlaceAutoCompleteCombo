unit uPolylineDecoder;

interface

uses
  System.Generics.Collections;

type
  TLatLng = Record
    Lat: Double;
    Lng: Double;
  End;

  TLatLngArray = array of TLatLng;

  TPolylineDecoder = class
    public
    class procedure DecodePolyline(AEncodedPolyline: string; out ALatLngArray: TLatLngArray);
  end;

implementation

uses
  System.SysUtils;

{ TPolylineDecoder }

class procedure TPolylineDecoder.DecodePolyline(AEncodedPolyline: string;
  out ALatLngArray: TLatLngArray);
var
  LPolyLineStr: string;
  LPolyLineCharStr: TArray<Char>;
  LIndex: Integer;
  LCurrentLat: Integer;
  LCurrentLng: Integer;
  LNext5bits: Integer;
  LSum: Integer;
  LShifter: Integer;
  FLatLng: TLatLng;
begin
  FillChar(ALatLngArray, 0, Length(ALatLngArray));

  AEncodedPolyline := AEncodedPolyline.Replace(#$D, '').Replace(#$A, '');

  LPolyLineCharStr := AEncodedPolyline.ToCharArray;

  LIndex := 0;
  LCurrentLat := 0;
  LCurrentLng := 0;
  LNext5bits := 0;

  while LIndex < Length(LPolyLineCharStr) do
  begin
    //Calc Lat
    LSum := 0;
    LShifter := 0;

    repeat
      LIndex := LIndex + 1;
      LNext5bits := Ord(LPolyLineCharStr[LIndex - 1]) - 63;
      LSum := LSum or (LNext5bits and 31) shl LShifter;
      LShifter := LShifter + 5;
    until ((LNext5bits < 32) or (LIndex >= Length(LPolyLineCharStr)));

    if LIndex >= Length(LPolyLineCharStr) then
      Break;

    if (LSum and 1) = 1 then
      LCurrentLat := LCurrentLat + not(LSum shr 1) else
        LCurrentLat := LCurrentLat + Lsum shr 1;

    //Calc Long
    LSum := 0;
    LShifter := 0;

    repeat
      LIndex := LIndex + 1;
      LNext5bits := Ord(LPolyLineCharStr[LIndex - 1]) - 63;
      LSum := LSum or (LNext5bits and 31) shl LShifter;
      LShifter := LShifter + 5;
    until ((LNext5bits < 32) or (LIndex >= Length(LPolyLineCharStr)));

    if ((LIndex >= Length(LPolyLineCharStr)) and (LNext5bits >= 32)) then
      Break;

    if (LSum and 1) = 1 then
      LCurrentLng := LCurrentLng + not(LSum shr 1) else
        LCurrentLng := LCurrentLng + Lsum shr 1;


    FLatLng.Lat := LCurrentLat / 1E5;
    FLatLng.Lng := LCurrentLng / 1E5;

    SetLength(ALatLngArray, Length(ALatLngArray) + 1);

    ALatLngArray[Length(ALatLngArray) - 1] := FLatLng;
  end;


end;

end.
