import 'package:map_example/domain/entities/coordinate_entiry.dart';

bool checkOverLap(CoordinateEntity coor1, CoordinateEntity coor2, double zoom) {
  double deltaLngCal = 0;
  double deltaLatCal = 0;
  if (zoom < 11) {
    deltaLngCal = 0.026;
    deltaLatCal = 0.016;
  } else if (zoom >= 11 && zoom < 12.8) {
    deltaLngCal = 0.02;
    deltaLatCal = 0.009;
  } else if (zoom >= 12.8 && zoom < 14.4) {
    deltaLngCal = 0.0035;
    deltaLatCal = 0.0035;
  } else if (zoom >= 14.4 && zoom < 15.20) {
    deltaLngCal = 0.0012;
    deltaLatCal = 0.0012;
  } else if (zoom >= 15.20 && zoom < 16.15) {
    deltaLngCal = 0.0007;
    deltaLatCal = 0.0006;
  } else if (zoom >= 16.15 && zoom < 16.8) {
    deltaLngCal = 0.0005;
    deltaLatCal = 0.0004;
  } else if (zoom >= 16.8) {
    deltaLngCal = 0;
    deltaLatCal = 0;
  }
  double deltaLng = (coor1.lng - coor2.lng).abs();
  double deltaLat = (coor1.lat - coor2.lat).abs();
  return deltaLng <= deltaLngCal && deltaLat <= deltaLatCal;
  // return deltaLng == 0 && deltaLat == 0;
  // return false;
}
