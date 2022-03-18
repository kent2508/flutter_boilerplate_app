import 'package:bloc/bloc.dart';

class AppBlocLoggingObserver extends BlocObserver {
  @override
  // ignore: unnecessary_overrides
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // print event is here
  }

  @override
  // ignore: unnecessary_overrides
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // print error is here
  }
}
