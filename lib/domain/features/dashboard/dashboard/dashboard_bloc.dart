import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_event.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_state.dart';

import '../../../../core/utils/app_helper.dart';

class DashboardBloc extends Bloc<DashboardEvent,DashboardState>{

  DashboardBloc():super(DashboardState.initial()){
    on<ChangeDriverPassengerModeEvent>(_changeDriverPassengerMode);
    on<SetModeEvent>(_setModeEvent);
  }

  void _changeDriverPassengerMode(ChangeDriverPassengerModeEvent event, Emitter<DashboardState> emit)async{

    try{
      await AppSettings.saveData(AppConstant.isDriver, event.isDriver);
      emit(state.copyWith(isDriver: event.isDriver));
    }catch(e,stack){
      debugPrintStack(stackTrace: stack);
    }

  }


  void _setModeEvent(SetModeEvent event, Emitter<DashboardState> emit){
    emit(state.copyWith(isDriver: event.isDriver));
  }
}