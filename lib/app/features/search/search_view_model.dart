import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:totowala/data/model/place_model.dart';
import 'package:totowala/domain/features/search/search_bloc.dart';
import 'package:totowala/domain/features/search/search_event.dart';
import 'package:totowala/domain/features/search/search_state.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/place_suggestion.dart';

class SearchViewModel{


  final SearchBloc _searchBloc;

  SearchViewModel(this._searchBloc);

  Stream<SearchState> get state => _searchBloc.stream;


  Uuid uuid=const Uuid();
  String _sessionToken='';


  void onChange(String input){
    if(_sessionToken.isEmpty){
      _sessionToken=uuid.v4();
    }
    _searchBloc.add(SearchPlaceEvent(input: input, sessionToken: _sessionToken));

  }


  void selectPickUpLocation(String address,double lat,double long){
    var placeModel={
      'latLng':{
        'latitude':lat,
        'longitude':long
      },
      'address':address
    };
    _searchBloc.add(PickupPlaceEvent(placeModel: PlaceModel.fromJson(placeModel)));
  }


  void selectDropLocation(String address,double lat,double long){
    var placeModel={
      'latLng':{
        'latitude':lat,
        'longitude':long
      },
      'address':address
    };
    _searchBloc.add(DropPlaceEvent(placeModel: PlaceModel.fromJson(placeModel)));
  }
}