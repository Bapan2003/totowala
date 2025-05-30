// mobile_input_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';

import '../../../../core/library/app_text.dart';
import 'mobile_no_event.dart';
import 'mobile_no_state.dart';


class MobileInputBloc extends Bloc<MobileInputEvent, MobileInputState> {
  final MobileNoRepository _mobileNoRepository;
  MobileInputBloc(this._mobileNoRepository) : super(MobileInputState.initial()) {
    on<MobileChanged>(_handleOnChanged );

    on<MobileSubmitted>(_handleOnSubmitted);
    on<MobileReset>(_handleOnReset);
  }

  void _handleOnChanged(
      MobileChanged event,
      Emitter<MobileInputState> emit,
      )  {
    final isValid = RegExp(r'^[6-9]\d{9}$').hasMatch(event.mobile);
    emit(state.copyWith(
      mobile: event.mobile,
      isValid: isValid,
      isSubmitted: false,
    ));
  }


  Future<void> _handleOnSubmitted(MobileSubmitted event, Emitter<MobileInputState> emit) async {

    if (state.isValid) {
      emit(state.copyWith(loading: true));
      try{
        // await Future.delayed(const Duration(seconds: 3));
        await _mobileNoRepository.sentOtp(state.mobile);
        emit(state.copyWith(isSubmitted: true));
      }catch(e){
        emit(state.copyWith(error: e.toString(),isSubmitted: false));
      }

    }else{
      if(state.mobile.isEmpty){
        emit(state.copyWith(error: AppText.pleaseEnter10MobileNumber,isSubmitted: false));
      }else{
        emit(state.copyWith(error: AppText.pleaseEnterCorrectMobile,isSubmitted: false));

      }

    }
  }


  void _handleOnReset(MobileReset event, Emitter<MobileInputState> emit){
      emit(state.copyWith(isSubmitted: false));
  }

}
