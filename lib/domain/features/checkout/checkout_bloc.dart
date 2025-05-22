import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/core/api/app_req_end_point.dart';
import 'package:totowala/domain/features/checkout/checkout_event.dart';
import 'package:totowala/domain/features/checkout/checkout_state.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/app_helper.dart';

class CheckoutBloc extends Bloc<CheckoutEvent,CheckoutState>{
  CheckoutBloc():super(CheckoutState.initial()){
    on<GetRouteEvent>(_onGetRouteEvent);
    on<CreateMapController>(_createMapController);

  }

  Future<void> _onGetRouteEvent(GetRouteEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(isLoading: true));


    try {

      final String requestUrl=AppReqEndPoint.getRoute(event.from.latitude, event.from.longitude, event.to.latitude, event.to.longitude);
      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (data['routes'].isNotEmpty) {
        final String encoded = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> polylinePoints = AppHelper.decodePolyline(encoded);

        // Add circle and markers
        Set<Circle> circles = {
          Circle(
            circleId: CircleId("start"),
            center: event.from,
            radius: 10,
            fillColor: AppColors.white30,
            strokeColor: AppColors.greenColor,
            strokeWidth: 2,
          ),
        };

        Set<Marker> markers = {
          Marker(
            markerId: MarkerId('end'),
            position: event.to,
            infoWindow: InfoWindow(title: 'End'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        };

        // Optional: Animate to bounds
        final bounds = AppHelper.boundsFromLatLngList([event.from, event.to]);
        state.mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));


        emit(state.copyWith(polylinePoints: polylinePoints,markers: markers,circles: circles));
      } else {
        emit(state.copyWith(error:'No route found' ));
      }
    } catch (e) {
      emit(state.copyWith(error:e.toString() ));
    }
  }


  void _createMapController(CreateMapController event,Emitter<CheckoutState> emit){
    emit(state.copyWith(mapController: event.mapController));
  }

}