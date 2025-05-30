import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/data/model/google/place_suggestion.dart';
import 'package:totowala/domain/repository/search/search_repository.dart';

import '../../../core/api/app_req_end_point.dart';

class SearchRepositoryImplement implements SearchRepository{
  @override
  Future<List<PlaceSuggestion>> getPlaceSuggestion(String input, String sessionToken) async {
    final String requestUrl =AppReqEndPoint.getPlace(input, sessionToken);

    try{
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final predictions = jsonData['predictions'] as List;

        final suggestions = predictions
            .map((e) => PlaceSuggestion.fromJson(e))
            .toList();

        return suggestions;
      } else {
        throw Exception("Failed to fetch place suggestions. Status code: ${response.statusCode}");
      }
    }catch(e,stack){
      debugPrintStack(stackTrace: stack);
      rethrow;
    }
  }

}