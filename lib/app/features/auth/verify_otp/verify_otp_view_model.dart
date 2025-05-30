import 'package:totowala/domain/features/auth/verify_otp/verify_otp_bloc.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_event.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_state.dart';

class VerifyOtpViewModel{
  final VerifyOTPBloc _verifyOTPBloc;

  VerifyOtpViewModel(this._verifyOTPBloc);

  Stream<VerifyOTPState> get state=> _verifyOTPBloc.stream;
  // Expose current state
  VerifyOTPState get currentState => _verifyOTPBloc.state;



  void verifyOtp(String otp, String mobileNo, String fcmToken){
    _verifyOTPBloc.add(SubmitOtpEvent(otp: otp, mobileNo: mobileNo, fcmToken: fcmToken));
  }


  void resetSubmission(){
    _verifyOTPBloc.add(ResetOTPEvent());
  }

  void dispose(){
    _verifyOTPBloc.close();
  }
}