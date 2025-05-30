import 'dart:convert';

import 'package:totowala/core/api/api_manager/api_manager_base.dart';
import 'package:totowala/core/api/app_req_end_point.dart';
import 'package:totowala/data/model/auth/send_otp_model.dart';
import 'package:totowala/data/model/auth/verify_otp_model.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';

class MobileNoRepositoryImplement implements MobileNoRepository{

  final ApiManagerBase _apiManagerBase;
  MobileNoRepositoryImplement(this._apiManagerBase);

  @override
  Future<SendOTPModel> sentOtp(String mobileNo) async {
    try{

      final response = await _apiManagerBase.postData(AppReqEndPoint.sendOtpAuth(),
          {
            "phone_number": mobileNo,
            "country_code": "91"
          },
        withToken: false
      );
      if(response.statusCode==200){
        return SendOTPModel.fromJson(response.data);
      }else{
        throw Exception(response.statusMessage);
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<VerifyOTPModel> verifyOtp(String mobileNo, String otp, String fcmToken) async {
    try{

      final response = await _apiManagerBase.postData(AppReqEndPoint.verifyOtpAuth(),
          {
            "phoneNumber": mobileNo,
            "countryCode": "91",
            "otp": otp,
            "fcm_Token": fcmToken
          },
          withToken: false
      );
      if(response.statusCode==200){
        return VerifyOTPModel.fromJson(response.data);
      }else{
        throw Exception(response.statusMessage);
      }
    }catch(e){
      rethrow;
    }
  }

}