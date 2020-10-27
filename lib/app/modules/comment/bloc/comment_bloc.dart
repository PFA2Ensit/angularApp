import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comptabli_blog/app/modules/comment/data/model/comment.dart';
import 'package:comptabli_blog/app/modules/comment/data/repository/comment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../../locator.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentRepository repository = locator<CommentRepository>();

  @override
  CommentState get initialState => CommentInitial();

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {

    if (event is CommentAddEvent) {
      try {
        await repository.addComment(event.comment,event.postId,event.postOwnerId,event.url);
        yield CommentSuccess();
      } on PlatformException catch (error) {
        yield CommentFailed(error: error);
      } catch (ex) {
        yield CommentFailed(
          error: PlatformException(
            code: ex.toString(),
            message:
                'An error has occued when adding your comment, please try again later',
          ),
        );
      }
    } else if (event is FetchComments) {
      yield CommentLoadingState();
      try {
        List<Comment> comments = await repository.getComments(event.id);
        yield CommentLoadedState(comments: comments);
      } catch (e) {
        yield CommentFetchErrorState(message: e.toString());
      }
    }
    else if (event is CommentDeleteEvent) {
      yield CommentLoadingState();
      try {
        await repository.deleteComment(event.id,event.commentId);
        yield CommentSuccess();

      } catch (e) {
        yield CommentFetchErrorState(message: e.toString());
      }
    }



  }
}
