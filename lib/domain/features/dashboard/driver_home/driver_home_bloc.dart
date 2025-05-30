import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_event.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_state.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent,DriverHomeState>{
  DriverHomeBloc():super(DriverHomeState.initial()){
    on<ChangeDutyModeEvent>(_changeDutyMode);
  }

  Future<void> _changeDutyMode(ChangeDutyModeEvent event, Emitter<DriverHomeState> emit) async {
    final service = FlutterBackgroundService();

    if (event.isOnDuty) {
      bool started = await startDuty(service);
      if (started) {
        await AppSettings.saveData(AppConstant.isOnDuty, true);
        emit(state.copyWith(isOnDuty: true));
      }
    } else {
      await stopDuty(service);
      await AppSettings.saveData(AppConstant.isOnDuty, false);
      emit(state.copyWith(isOnDuty: false));
    }
  }


  Future<bool> startDuty(FlutterBackgroundService service) async {
    // ✅ Ensure permissions are granted before starting service
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false; // ❌ Can't start without location permission
      }
    }

    bool isRunning = await service.isRunning();
    if (!isRunning) {
      final success = await service.startService();
      return success;
    }
    return true;
  }


  Future<void> stopDuty(FlutterBackgroundService service) async {
    bool isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService"); // This must be handled in `onStart`
    }
  }
}