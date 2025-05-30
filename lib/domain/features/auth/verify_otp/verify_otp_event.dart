abstract class VerifyOTPEvent{}


class SubmitOtpEvent extends VerifyOTPEvent{
  String otp;
  String mobileNo;
  String fcmToken;
  SubmitOtpEvent({required this.otp, required this.mobileNo, required this.fcmToken});
}

class ResetOTPEvent extends VerifyOTPEvent{}