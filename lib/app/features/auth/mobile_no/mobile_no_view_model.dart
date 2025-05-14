import '../../../../domain/auth/mobile_no/mobile_no_bloc.dart';
import '../../../../domain/auth/mobile_no/mobile_no_event.dart';
import '../../../../domain/auth/mobile_no/mobile_no_state.dart';

class MobileNoViewModel{

  final MobileInputBloc bloc;

  MobileNoViewModel(this.bloc);

  // Expose bloc stream
  Stream<MobileInputState> get state => bloc.stream;

  // Expose current state
  MobileInputState get currentState => bloc.state;

  // Call to update input
  void onMobileChanged(String value) {
    bloc.add(MobileChanged(value));
  }

  // Call to submit
  void onSubmit() {
    bloc.add(MobileSubmitted());
  }

  void dispose() {
    bloc.close();
  }
}