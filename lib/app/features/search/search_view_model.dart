import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchViewModel{
  Uuid uuid=const Uuid();
  String _sessionToken='';


  void getSuggestions(String suggestions)async{
    String googleApi = "AIzaSyDovHtxtPHq-fzGsE1rXUPT9tvUBa-1zcM";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseUrl?input=$suggestions&key=$googleApi&sessiontoken=$_sessionToken";

    var response=await http.get(Uri.parse(request));
    print(response.body.toString());
  }

  void onChange(String input){
    if(_sessionToken.isEmpty){
      _sessionToken=uuid.v4();
    }else{
      getSuggestions(input);
    }
  }
}