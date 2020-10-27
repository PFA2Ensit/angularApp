import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {
  final String email;
  final String password;

  LogIn({this.email, this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LogIn $email - $password';
}

class SignUp extends AuthenticationEvent {
  final String email;
  final String password;

  SignUp({this.email, this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignUp $email - $password';
}

class LogOut extends AuthenticationEvent {}
