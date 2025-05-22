import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CheckoutEvent {}

class GetRouteEvent extends CheckoutEvent {
  final LatLng from;
  final LatLng to;

  GetRouteEvent(this.from, this.to);
}

class CreateMapController extends CheckoutEvent{
  final GoogleMapController mapController;
  CreateMapController({required this.mapController});
}