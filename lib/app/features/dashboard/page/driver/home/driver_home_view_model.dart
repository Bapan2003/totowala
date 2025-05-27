import 'package:totowala/domain/features/dashboard/driver_home/driver_home_bloc.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_event.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_state.dart';

class DriverHomeViewModel{
  final DriverHomeBloc _driverHomeBloc;
  DriverHomeViewModel( this._driverHomeBloc);

  Stream<DriverHomeState> get state=>_driverHomeBloc.stream;

  void changeDutyMode(bool isOnDuty){
    _driverHomeBloc.add(ChangeDutyModeEvent(isOnDuty: isOnDuty));
  }

  void dispose(){
    _driverHomeBloc.close();
  }
}