import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:totowala/core/api/api_manager/api_manager_base.dart';
import 'package:totowala/core/api/app_req_end_point.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';

import '../../library/app_text.dart';
import '../../utils/app_helper.dart';
import '../app_env/app_env.dart';

class ApiManager implements ApiManagerBase{


  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppEnv.instance.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(minutes: 2),
  ));


  Future<String?> getToken() async {
    String? accessToken=await AppSettings.getAccessToken();
    // Retrieve token from secure storage or wherever you're storing it
    return accessToken;
  }


  ApiManager() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.extra['withToken'] == true) {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final newToken = await refreshAuthToken();

          if (newToken != null) {
            // Save the new token
            await AppSettings.saveAccessToken(newToken);

            // Clone and retry the original request with the new token
            final requestOptions = error.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            final clonedResponse = await _dio.fetch(requestOptions);
            return handler.resolve(clonedResponse);
          }
        }

        return handler.next(error); // Propagate other errors
      },
    ));
  }

  @override
  Future<String?> refreshAuthToken() async {
    try {
      final refreshToken = await AppSettings.getAccessToken(isRefresh: true);

      final response = await _dio.post(AppReqEndPoint.refreshTokenAuth(), options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $refreshToken'
      },
      ));

      logger.i(response.data);
      await AppSettings.saveAccessToken(response.data['refresh_token'],isRefresh: true);

      return response.data['access_token']; // Adjust to your API's response
    } catch (e) {
      logger.e('Token refresh failed: $e');
      return null;
    }
  }

  @override
  Future<Response<dynamic>> getData(String endPoint, {bool withToken = true}) async {
    bool isConnected = await checkInternetConnection();
    if (!isConnected) throw Exception(AppText.noInternetConnection);

    try{

      final options = Options(
          headers: {},
        extra: {'withToken': withToken},
      );
      if(kDebugMode){
        logger.d(endPoint);
      }
      final response = await _dio.get(endPoint, options: options);
      if(kDebugMode){
        logger.i(response);
      }
      return response;
    }catch(e,stack){
      logger.e(e);
      debugPrintStack(stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> postData(String endPoint, var reqBody, {bool withToken = true}) async {
    bool isConnected = await checkInternetConnection();
    if (!isConnected) throw Exception(AppText.noInternetConnection);

    try{
      final options = Options(headers: {
        'Content-Type': 'application/json',
      },
      extra: {'withToken': withToken},
      );
      if(kDebugMode){
        logger.d(endPoint);
      }

      final response = await _dio.post(endPoint,data: reqBody, options: options);
      if(kDebugMode){
        logger.i(response);
      }
      return response;
    }catch(e,stack){
      logger.e(e);
      debugPrintStack(stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    return await AppHelper.checkInternetConnection();
  }

}