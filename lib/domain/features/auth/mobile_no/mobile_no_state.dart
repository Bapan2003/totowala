// mobile_input_state.dart
class MobileInputState {
  final String mobile;
  final bool isValid;
  final bool isSubmitted;
  final String? error;
  final bool? loading;

  MobileInputState({
    required this.mobile,
    required this.isValid,
    required this.isSubmitted,
    required this.error,
    required this.loading
  });

  factory MobileInputState.initial() {
    return MobileInputState(mobile: '', isValid: false, isSubmitted: false,error: null,loading: false);
  }

  MobileInputState copyWith({
    String? mobile,
    bool? isValid,
    bool? isSubmitted,
    String? error,
    bool? loading
  }) {
    return MobileInputState(
      mobile: mobile ?? this.mobile,
      isValid: isValid ?? this.isValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      error: error,
      loading: loading?? false
    );
  }
}
