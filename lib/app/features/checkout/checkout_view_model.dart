import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:totowala/domain/features/checkout/checkout_bloc.dart';
import 'package:totowala/domain/features/checkout/checkout_state.dart';

import '../../../domain/features/checkout/checkout_event.dart';

class CheckoutViewModel{

  final CheckoutBloc _checkoutBloc;

  CheckoutViewModel(this._checkoutBloc);

  Stream<CheckoutState> get state=>_checkoutBloc.stream;

  void loadRoute(LatLng from, LatLng to) {
    _checkoutBloc.add(GetRouteEvent(from, to));
  }

  void createMapController(GoogleMapController mapController) {
    _checkoutBloc.add(CreateMapController(mapController: mapController));
  }

  void dispose() {
    _checkoutBloc.close();
  }

}