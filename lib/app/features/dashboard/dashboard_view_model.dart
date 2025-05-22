import 'package:totowala/domain/features/dashboard/dashboard/dashboard_bloc.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_event.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_state.dart';

class DashboardViewModel{

  final DashboardBloc _dashboardBloc;
  DashboardViewModel(this._dashboardBloc);

  Stream<DashboardState> get state=>_dashboardBloc.stream;

  void changeDriverMode(bool isDriver){
    _dashboardBloc.add(ChangeDriverPassengerModeEvent(isDriver: isDriver));
  }

  void setDriverPassengerMode(bool isDriver){
    _dashboardBloc.add(SetModeEvent(isDriver: isDriver));
  }


  void dispose(){
    _dashboardBloc.close();
  }
}