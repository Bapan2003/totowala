import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;
import 'package:totowala/domain/repository/checkout/checkout_repository.dart';

import '../../../core/api/app_req_end_point.dart';

class CheckoutRepositoryImplement implements CheckoutRepository{
  @override
  Future<dynamic> getRoute(LatLng from, LatLng to) async{
    try{
      final String requestUrl=AppReqEndPoint.getRoute(from.latitude, from.longitude, to.latitude, to.longitude);

      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);


      if (data['routes'].isNotEmpty) {
        return data;
      } else{
         throw 'No route found';
      }
    }catch(e,stack){
      debugPrintStack(stackTrace: stack);
      rethrow;
    }
  }

}