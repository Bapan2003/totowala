import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../domain/dashboard/home/home_bloc.dart';
import '../../../../../domain/dashboard/home/home_event.dart';
import '../../../../../domain/dashboard/home/home_state.dart';

class HomeViewModel{

  final HomeBloc _homeBloc;

  HomeViewModel(this._homeBloc);

  Stream<HomeState> get state => _homeBloc.stream;

  void fetchLocation() {
    _homeBloc.add(FetchLocation());
  }


  void createMapController(GoogleMapController mapController) {
    _homeBloc.add(CreateMapController(mapController: mapController));
  }
  void dispose() {
    _homeBloc.close();
  }

}