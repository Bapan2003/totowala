import 'package:totowala/data/model/place_suggestion.dart';

class SearchState{
  final List<PlaceSuggestion>? suggestedPlace;
  bool isLoading;
  String error;

  SearchState({required this.suggestedPlace,required this.isLoading,required this.error});

  factory SearchState.initial(){
    return SearchState(suggestedPlace: [],isLoading:false ,error: '');
  }
  SearchState copyWith({
    List<PlaceSuggestion>? suggestedPlace,
    bool? isLoading,
    String? error,
   }){
    final newState=SearchState(
        suggestedPlace: suggestedPlace?? this.suggestedPlace,
        isLoading: isLoading??false,
        error: error??''
    );
    print("Created new state: ${newState.suggestedPlace?.length}");

    return newState;
  }
}