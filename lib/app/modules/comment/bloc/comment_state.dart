part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentSuccess extends CommentState{

  CommentSuccess();

  @override
  List<Object> get props => [];
}

class CommentFailed extends CommentState{

  final PlatformException error;
  CommentFailed({this.error});
}


class CommentLoadingState extends CommentState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CommentLoadedState extends CommentState {

  List<Comment> comments;

  CommentLoadedState({this.comments});

  @override
  // TODO: implement props
  List<Object> get props => [comments];
}

class CommentFetchErrorState extends CommentState {

  String message;

   CommentFetchErrorState({ this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class CommentDeleteError extends CommentState {

  String message;

   CommentDeleteError({ this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


