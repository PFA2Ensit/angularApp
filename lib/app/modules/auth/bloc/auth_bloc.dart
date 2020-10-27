import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:comptabli_blog/app/modules/auth/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../../locator.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository = locator<UserRepository>();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      bool hasToken = false;
      try {
        hasToken = await userRepository.hasUserLoggedIn();
        print(hasToken);
      } catch (e) {
        // nothing to do here
      }

      if (hasToken) {
        print("home");
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LogIn) {
      yield AuthenticationLoading();
      try {
        await userRepository.signInWithEmail(
            email: event.email, password: event.password);
        yield Authenticated();
      } on PlatformException catch (error) {
        yield LoginFailed(error: error);
      } catch (ex) {
        yield LoginFailed(
          error: PlatformException(
            code: ex.toString(),
            message:
                'An error has occued when creating your account, please try again later',
          ),
        );
      }
    }

    if (event is SignUp) {
      yield AuthenticationLoading();
      try {
        AuthResult authResult = await userRepository.sigUpWithEmail(
            email: event.email, password: event.password);
        await userRepository.createProfile(authResult.user);
        yield Authenticated();
      } on PlatformException catch (error) {
        yield SignUpFailed(error: error);
      } catch (ex) {
        yield SignUpFailed(
          error: PlatformException(
            code: ex.toString(),
            message: ex.toString(),
          ),
        );
      }
    }

    if (event is LogOut) {
      yield AuthenticationLoading();
      yield Unauthenticated();
    }
  }
}
