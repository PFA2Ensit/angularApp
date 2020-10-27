import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  Authenticated();

  @override
  List<Object> get props => [];
}

class LoginFailed extends AuthenticationState {
  final PlatformException error;
  LoginFailed({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignUp $error';
}

class SignUpFailed extends AuthenticationState {
  final PlatformException error;
  SignUpFailed({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignUp $error';
}

class Unauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
