import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


abstract class CompteState extends Equatable {
  const CompteState();
  
  @override
  List<Object> get props => [];
}

class CompteInitial extends CompteState {}

class CreateCompleted extends CompteState{

  CreateCompleted();

  @override
  List<Object> get props => [];
}

class CreateFailed extends CompteState{

  final PlatformException error;
  CreateFailed({this.error});
}

class ProfileLoadingState extends CompteState {
  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends CompteState {

  final Compte user;

  ProfileLoadedState({@required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileErrorState extends CompteState {
  
  final String message;
  ProfileErrorState({this.message});
}

class UpdateCompleted extends CompteState{

  UpdateCompleted();

  @override
  List<Object> get props => [];
}



