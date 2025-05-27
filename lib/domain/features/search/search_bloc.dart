import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/core/api/app_req_end_point.dart';
import 'package:totowala/domain/features/search/search_event.dart';
import 'package:totowala/domain/features/search/search_state.dart';
import 'package:totowala/domain/repository/search/search_repository.dart';

import '../../../data/model/place_suggestion.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  final SearchRepository repository;
  SearchBloc(this.repository):super(SearchState.initial()){
    on<SearchPlaceEvent>(_onFetchSuggestions);
    on<PickupPlaceEvent>(_onPickup);
    on<DropPlaceEvent>(_onDrop);
  }

  Future<void> _onFetchSuggestions(
      SearchPlaceEvent event,
      Emitter<SearchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true,));



    try {
      final suggestions = await repository.getPlaceSuggestion(event.input, event.sessionToken);
      emit(state.copyWith(isLoading: false, suggestedPlace: suggestions));

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