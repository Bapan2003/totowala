import 'package:dio/dio.dart';

abstract class ApiManagerBase{

  Future<bool> checkInternetConnection();

  Future<Response<dynamic>> getData(String endPoint,{bool withToken=true});
  Future<Response<dynamic>> postData(String endPoint, var reqBody, {bool withToken=true});
}