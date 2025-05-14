// mobile_input_state.dart
class MobileInputState {
  final String mobile;
  final bool isValid;
  final bool isSubmitted;

  MobileInputState({
    required this.mobile,
    required this.isValid,
    required this.isSubmitted,
  });

  factory MobileInputState.initial() {
    return MobileInputState(mobile: '', isValid: false, isSubmitted: false);
  }

  MobileInputState copyWith({
    String? mobile,
    bool? isValid,
    bool? isSubmitted,
  }) {
    return MobileInputState(
      mobile: mobile ?? this.mobile,
      isValid: isValid ?? this.isValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
