import 'package:totowala/data/model/google/place_suggestion.dart';

abstract class SearchRepository{
  Future<List<PlaceSuggestion>> getPlaceSuggestion(String input,String sessionToken);
}