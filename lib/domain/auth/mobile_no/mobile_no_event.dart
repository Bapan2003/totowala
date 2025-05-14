// mobile_input_event.dart
abstract class MobileInputEvent {}

class MobileChanged extends MobileInputEvent {
  final String mobile;

  MobileChanged(this.mobile);
}

class MobileSubmitted extends MobileInputEvent {}
