part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentAddEvent extends CommentEvent{
   final String comment;
   final String postId;
   final String postOwnerId;
   final String url;

   CommentAddEvent({this.comment,this.postId,this.postOwnerId,this.url});


}


class FetchComments extends CommentEvent {
  final String id;
  FetchComments({this.id});

  
}

class CommentDeleteEvent extends CommentEvent {
  final String id;
  final String commentId;

  CommentDeleteEvent({this.id,this.commentId});


}

class CommentUpdateEvent extends CommentEvent {
  final String comment;
  final String id;
  final String commentId;

  CommentUpdateEvent({this.comment,this.id,this.commentId});

  
}
