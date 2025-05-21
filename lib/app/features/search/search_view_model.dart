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
}