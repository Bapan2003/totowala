import 'package:totowala/data/model/place_model.dart';

abstract class SearchEvent{}

class SearchPlaceEvent extends SearchEvent{
  final String input;
  final String sessionToken;
  SearchPlaceEvent({required this.input,required this.sessionToken});
}

class PickupPlaceEvent extends SearchEvent{
 final PlaceModel placeModel;
  PickupPlaceEvent({required this.placeModel});
}


class DropPlaceEvent extends SearchEvent{
  final PlaceModel placeModel;
  DropPlaceEvent({required this.placeModel});
}

