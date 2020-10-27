import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlogState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class PostSuccess extends BlogState{

  PostSuccess();

  @override
  List<Object> get props => [];
}

class PostFailed extends BlogState{

  final PlatformException error;
  PostFailed({this.error});
}


class PostLoadingState extends BlogState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PostLoadedState extends BlogState {

  List<Item> articles;

  PostLoadedState({@required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class PostFetchErrorState extends BlogState {

  String message;

  PostFetchErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class PostLikedState extends BlogState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorLike extends BlogState {
  String message;

  ErrorLike({@required this.message});
}

class DeleteError extends BlogState {

  String message;

   DeleteError({ this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


class SearchError extends BlogState{

  final String message;

   SearchError({ this.message});

  @override
  List<Object> get props => [message];

} 

class PostsEmptyState extends BlogState{}





