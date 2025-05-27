import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_event.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_state.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent,DriverHomeState>{
  DriverHomeBloc():super(DriverHomeState.initial()){
    on<ChangeDutyModeEvent>(_changeDutyMode);
  }

  Future<void> _changeDutyMode(ChangeDutyModeEvent event,Emitter<DriverHomeState> emit)async {
    emit(state.copyWith(isOnDuty: event.isOnDuty));
  }

}