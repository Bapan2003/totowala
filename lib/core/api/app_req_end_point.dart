import 'dart:core';

class AppReqEndPoint{

  static String baseUrl= 'https://maps.googleapis.com/maps/api';
  static String apiKey= 'AIzaSyAfiISUmg_6Bdcw0XI4GhocAi76a9_sYY8&sessiontoken';


  static String getRoute(double sLat,double sLong, double dLat, double dLong){
    return '$baseUrl/directions/json?origin=$sLat,$sLong&destination=$dLat,$dLong&key=$apiKey';
  }

  static String getPlace(String input, String sessionToken){
    return '$baseUrl/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken';
  }
}