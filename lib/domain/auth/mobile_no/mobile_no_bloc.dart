// mobile_input_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mobile_no_event.dart';
import 'mobile_no_state.dart';


class MobileInputBloc extends Bloc<MobileInputEvent, MobileInputState> {
  MobileInputBloc() : super(MobileInputState.initial()) {
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


  void _handleOnSubmitted(MobileSubmitted event, Emitter<MobileInputState> emit){
    if (state.isValid) {
      if (kDebugMode) {
        print("Submitted Mobile: +91${state.mobile}");
      }
      emit(state.copyWith(isSubmitted: true));
      // Trigger OTP or next action
    }
  }


  void _handleOnReset(MobileReset event, Emitter<MobileInputState> emit){
      emit(state.copyWith(isSubmitted: false));
  }

}
