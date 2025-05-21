abstract class SearchEvent{}

class SearchPlaceEvent extends SearchEvent{
  final String input;
  final String sessionToken;
  SearchPlaceEvent({required this.input,required this.sessionToken});
}