class DriverHomeState{
  final bool isOnDuty;
  DriverHomeState({required this.isOnDuty});

  factory DriverHomeState.initial(){
    return DriverHomeState(isOnDuty: false);
  }

  DriverHomeState copyWith({bool? isOnDuty}){
    return DriverHomeState(isOnDuty: isOnDuty?? this.isOnDuty);
  }
}