import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  final bool isDev;

  SimpleBlocDelegate({this.isDev = false});

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    _log(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    _log(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log(transition);
  }

  void _log(Object somethingTolog) {
    if (isDev) {
      print(somethingTolog);
    }
  }
}
