abstract class DashboardEvent{}

class ChangeDriverPassengerModeEvent extends DashboardEvent{
  final bool isDriver;
  ChangeDriverPassengerModeEvent({required this.isDriver});
}

class SetModeEvent extends DashboardEvent{
  final bool isDriver;
  SetModeEvent({required this.isDriver});
}