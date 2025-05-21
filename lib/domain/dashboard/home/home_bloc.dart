import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_helper.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<FetchLocation>(_onFetchLocation);
    on<LoadTotoIconEvent>(_onTotoIconLoading);
    on<AddNearByToto>(_addNearbyBikes);
    on<CreateMapController>(_createMapController);
  }

  Future<void> _onFetchLocation(FetchLocation event, Emitter<HomeState> emit) async {
    add(LoadTotoIconEvent());
    emit(state.copyWith(isLoading: true));

    try {
      final position = await AppHelper.determinePosition();
      final address = await AppHelper.getAddressFromLatLng(position.latitude, position.longitude);

      final Set<Marker> markers = {
        Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "You are here"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };

      state.mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15),
      ));
      
      emit(state.copyWith(
        currentPosition: position,
        address: address,
        markers: markers,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _addNearbyBikes(AddNearByToto event,Emitter<HomeState> emit) {
    final List<Marker> bikeMarkers = [];

    for (int i = 0; i < 3; i++) {
      final offsetLat = 0.0005 * (i % 2 == 0 ? 1 : -1);
      final offsetLng = 0.0005 * (i % 3 == 0 ? 1 : -1);
      final bikePosition = LatLng(
        event.userLocation.latitude + offsetLat,
        event.userLocation.longitude + offsetLng,
      );

      bikeMarkers.add(
        Marker(
          markerId: MarkerId('bike_$i'),
          position: bikePosition,
          icon: state.totoIcon ?? BitmapDescriptor.defaultMarker,
          rotation: i*-1,
          anchor: Offset(0.5, 0.5),
          flat: true,
        ),
      );
    }


    emit(state.copyWith(markers: {
      ...state.markers,
      ...bikeMarkers
    }));
  }

  Future<void> _onTotoIconLoading(LoadTotoIconEvent event, Emitter<HomeState> emit) async {
    final totoIcon = await AppHelper.createMarkerFromIcon(Icons.electric_rickshaw_outlined, AppColors.blueColor, size: 80);
    emit(state.copyWith(totoIcon: totoIcon));

  }

  
  void _createMapController(CreateMapController event,Emitter<HomeState> emit){
    state.copyWith(mapController: event.mapController);
  }

}
