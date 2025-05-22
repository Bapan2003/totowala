import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/core/api/app_req_end_point.dart';
import 'package:totowala/domain/features/search/search_event.dart';
import 'package:totowala/domain/features/search/search_state.dart';

import '../../../data/model/place_suggestion.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  SearchBloc():super(SearchState.initial()){
    on<SearchPlaceEvent>(_onFetchSuggestions);
    on<PickupPlaceEvent>(_onPickup);
    on<DropPlaceEvent>(_onDrop);
  }

  Future<void> _onFetchSuggestions(
      SearchPlaceEvent event,
      Emitter<SearchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true,));

    final String requestUrl =AppReqEndPoint.getPlace(event.input, event.sessionToken);


    try {
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final predictions = jsonData['predictions'] as List;

        final suggestions = predictions
            .map((e) => PlaceSuggestion.fromJson(e))
            .toList();

        emit(state.copyWith(isLoading: false,suggestedPlace: suggestions));
      } else {
        emit(state.copyWith(isLoading: false,error: 'Failed to load'));      }
    } catch (e) {
      emit(state.copyWith(isLoading: false,error: 'Failed to load $e'));
    }
  }


  void _onPickup(PickupPlaceEvent event,Emitter<SearchState> emit){
    emit(state.copyWith(pickUp: event.placeModel));
  }

  void _onDrop(DropPlaceEvent event,Emitter<SearchState> emit){
    emit(state.copyWith(drop: event.placeModel));
  }
}