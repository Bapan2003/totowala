import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/domain/features/search/search_event.dart';
import 'package:totowala/domain/features/search/search_state.dart';

import '../../../data/model/place_suggestion.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  SearchBloc():super(SearchState.initial()){
    on<SearchPlaceEvent>(_onFetchSuggestions);
  }

  Future<void> _onFetchSuggestions(
      SearchPlaceEvent event,
      Emitter<SearchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true,));

    final String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    final String requestUrl =
        "$baseUrl?input=${event.input}&key=AIzaSyAfiISUmg_6Bdcw0XI4GhocAi76a9_sYY8&sessiontoken=${event.sessionToken}";

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
}