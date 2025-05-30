import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/data/model/auth/verify_otp_model.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_event.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_state.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';

class VerifyOTPBloc extends Bloc<VerifyOTPEvent,VerifyOTPState>{
  final MobileNoRepository _mobileNoRepository;
  VerifyOTPBloc(this._mobileNoRepository):super(VerifyOTPState.initial()){
    on<SubmitOtpEvent>(_onSubmittedOTP);
    on<ResetOTPEvent>(_handleOnReset);
  }
  Future<void> _onSubmittedOTP(SubmitOtpEvent event,Emitter<VerifyOTPState> emit)async {
    emit(state.copyWith(isLoading: true));
    try{
      final VerifyOTPModel response=await _mobileNoRepository.verifyOtp(event.mobileNo, event.otp, event.fcmToken);
      AppSettings.saveAccessToken(response.accessToken??'');
      AppSettings.saveAccessToken(response.refreshToken??'',isRefresh: true);
      AppSettings.saveData(AppConstant.isActive,true);

      emit(state.copyWith(isSubmitted: true));
    }catch(e){
      emit(state.copyWith(error: e.toString()));
    }
  }


  void _handleOnReset(ResetOTPEvent event, Emitter<VerifyOTPState> emit){
    emit(state.copyWith(isSubmitted: false));
  }

}