import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutState {
  final List<LatLng> polylinePoints;
  final String? error;
  final bool? isLoading;
  final Set<Marker> markers;
  final Set<Circle> circles;
  final GoogleMapController? mapController;

  CheckoutState({required this.polylinePoints,required this.error,required this.isLoading,required this.markers, required this.circles,required this.mapController});


  factory CheckoutState.initial(){
    return CheckoutState(polylinePoints: [], error: '',isLoading: false,markers: <Marker>{},circles: <Circle>{},mapController: null);
  }

  CheckoutState copyWith({List<LatLng>? polylinePoints,String? error,bool? isLoading, Set<Marker>? markers, Set<Circle>? circles, GoogleMapController? mapController}){
    return CheckoutState(
        polylinePoints: polylinePoints??this.polylinePoints,
        error: error?? this.error,
      isLoading: isLoading?? this.isLoading,
      markers: markers?? this.markers,
      circles: circles?? this.circles,
      mapController: mapController?? this.mapController
    );
  }
}

