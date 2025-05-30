class VerifyOTPState{
  final bool isLoading;
  final String? error;
  final bool isSubmitted;
  VerifyOTPState({
    required this.isLoading,
    required this.error,
    required this.isSubmitted
  });

  factory VerifyOTPState.initial(){
    return VerifyOTPState(isLoading: false, error: null, isSubmitted: false);
  }

  VerifyOTPState copyWith({bool? isLoading,String? error, bool? isSubmitted}){
    return VerifyOTPState(isLoading: isLoading?? false, error: error, isSubmitted: isSubmitted??false);
  }
}