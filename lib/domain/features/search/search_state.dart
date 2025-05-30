import 'package:totowala/data/model/google/place_model.dart';
import 'package:totowala/data/model/google/place_suggestion.dart';

class SearchState{
  final List<PlaceSuggestion>? suggestedPlace;
  final PlaceModel? pickUp;
  final PlaceModel? drop;

  bool isLoading;
  String error;

  SearchState({required this.suggestedPlace,required this.isLoading,required this.error, this.pickUp,  this.drop});

  factory SearchState.initial(){
    return SearchState(suggestedPlace: [],isLoading:false ,error: '');
  }
  SearchState copyWith({
    List<PlaceSuggestion>? suggestedPlace,
    bool? isLoading,
    String? error,
    PlaceModel? pickUp,
    PlaceModel? drop
   }){
    return SearchState(
        suggestedPlace: suggestedPlace?? this.suggestedPlace,
        isLoading: isLoading??false,
        error: error??'',
      pickUp: pickUp?? this.pickUp,
      drop: drop?? this.drop
    );
  }
}