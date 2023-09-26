import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModeEvent { toggle }

class ThemeModeBloc extends Bloc<ThemeModeEvent, bool> {
  ThemeModeBloc() : super(false);

  @override
  Stream<bool> mapEventToState(ThemeModeEvent event) async* {
    if (event == ThemeModeEvent.toggle) {
      yield !state;
    }
  }
}
