import 'package:totowala/data/model/auth/send_otp_model.dart';
import 'package:totowala/data/model/auth/verify_otp_model.dart';

abstract class MobileNoRepository{
  Future<SendOTPModel> sentOtp(String mobileNo);
  Future<VerifyOTPModel> verifyOtp(String mobileNo, String otp,String fcmToken);
}