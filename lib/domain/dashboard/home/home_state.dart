import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeState {
  final Position? currentPosition;
  final String address;
  final Set<Marker> markers;
  final BitmapDescriptor? totoIcon;
  final bool isLoading;
  final String? error;
  final GoogleMapController? mapController;

  HomeState({
    required this.currentPosition,
    required this.address,
    required this.markers,
    required this.totoIcon,
    required this.isLoading,
    required this.error,
    required this.mapController
  });

  factory HomeState.initial() {
    return HomeState(
      currentPosition: null,
      address: '',
      markers: <Marker>{},
      totoIcon: null,
      isLoading: false,
      error: null,
      mapController: null,
    );
  }

  HomeState copyWith({
    Position? currentPosition,
    String? address,
    Set<Marker>? markers,
    BitmapDescriptor? totoIcon,
    bool? isLoading,
    String? error,
    GoogleMapController? mapController
  }) {
    return HomeState(
      currentPosition: currentPosition ?? this.currentPosition,
      address: address ?? this.address,
      markers: markers ?? this.markers,
      totoIcon: totoIcon ?? this.totoIcon,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      mapController: mapController?? this.mapController
    );
  }
}
