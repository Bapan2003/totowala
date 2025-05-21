import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class HomeEvent {}

class FetchLocation extends HomeEvent {}


class LoadTotoIconEvent extends HomeEvent {}

class AddNearByToto extends HomeEvent{
  final LatLng userLocation;
  AddNearByToto({required this.userLocation});
}

class CreateMapController extends HomeEvent{
  final GoogleMapController mapController;
  CreateMapController({required this.mapController});
}