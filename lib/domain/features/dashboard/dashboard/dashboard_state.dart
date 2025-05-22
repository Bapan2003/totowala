class DashboardState{
  final bool isDriver;

  DashboardState({required this.isDriver});

  factory DashboardState.initial({bool? isDriver}){
    return DashboardState(isDriver:isDriver??false);
  }
  DashboardState copyWith({bool? isDriver}){
    print(isDriver);
    return DashboardState(isDriver: isDriver?? this.isDriver);
  }
}