import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginEvent { login, logout }

class LoginBloc extends Bloc<LoginEvent, bool> {
  LoginBloc() : super(false);

  Stream<bool> mapEventToState(LoginEvent event) async* {
    switch (event) {
      case LoginEvent.login:
        yield true;
        break;
      case LoginEvent.logout:
        yield false;
        break;
    }
  }
}
