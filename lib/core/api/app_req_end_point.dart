import 'dart:core';

import 'package:totowala/core/api/app_env/app_env.dart';

class AppReqEndPoint{

  static String baseUrlGMap= 'https://maps.googleapis.com/maps/api';
  static String apiKey= 'AIzaSyDovHtxtPHq-fzGsE1rXUPT9tvUBa-1zcM';


  static String getRoute(double sLat,double sLong, double dLat, double dLong){
    return '$baseUrlGMap/directions/json?origin=$sLat,$sLong&destination=$dLat,$dLong&key=$apiKey';
  }

  static String getPlace(String input, String sessionToken){
    return '$baseUrlGMap/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken';
  }

  static String sendOtpAuth(){
    return '/auth/send-otp';
  }

  static String verifyOtpAuth(){
    return '/auth/signup';
  }

  static String refreshTokenAuth(){
    return '/auth/refresh';
  }

  static String getAllVehicleType(){
    return '/vehiclecategory/get-all-vehicle-category';
  }


}