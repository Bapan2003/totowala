import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CheckoutRepository{
  Future<dynamic> getRoute(LatLng from,LatLng to);
}