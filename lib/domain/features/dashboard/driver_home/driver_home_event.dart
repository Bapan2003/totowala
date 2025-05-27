abstract class DriverHomeEvent{}

class ChangeDutyModeEvent extends DriverHomeEvent{
  bool isOnDuty;
  ChangeDutyModeEvent({required this.isOnDuty});
}