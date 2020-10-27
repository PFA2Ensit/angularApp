import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/modules/blog/data/repository/post_repository.dart';
import 'package:flutter/services.dart';
import '../../../../locator.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  PostRepository repository = locator<PostRepository>();

  //BlogBloc({this.repository});

  @override
  BlogState get initialState => BlogInitial();

  @override
  Stream<BlogState> mapEventToState(
    BlogEvent event,
  ) async* {
    if (event is AddPost) {
      try {
        await repository.addPost(event.item.name, event.item.imageUrl,
            event.item.category, event.item.text);
        yield PostSuccess();
      } on PlatformException catch (error) {
        yield PostFailed(error: error);
      } catch (ex) {
        yield PostFailed(
          error: PlatformException(
            code: ex.toString(),
            message:
                'An error has occued when adding your post, please try again later',
          ),
        );
      }
    } else if (event is FetchArticles) {
      yield PostLoadingState();
      try {
        List<Item> articles = await repository.getPosts(event.filter);
        print(articles.length);
        yield PostLoadedState(articles: articles);
      } catch (e) {
        yield PostFetchErrorState(message: e.toString());
      }
    } else if (event is LikePost) {
      try {
        await repository.onLikeButtonTapped(
            event.likes, event.likeCount, event.postId);
        yield PostLikedState();
      } catch (e) {
        print("message:" + e.toString());
      }
    } else if (event is FetchUserPosts) {
      yield PostLoadingState();
      try {
        List<Item> articles = await repository.getUserPosts();
        yield PostLoadedState(articles: articles);
      } catch (e) {
        yield PostFetchErrorState(message: e.toString());
      }
    } else if (event is PostDeleteEvent) {
      yield PostLoadingState();
      try {
        await repository.deletePost(event.id);
        yield PostSuccess();
      } catch (e) {
        yield PostFetchErrorState(message: e.toString());
      }
    }
    /* else if (event is PostSearchEvent) {
      yield PostLoadingState();
      try {
        List<Item> articles = await repository.searchPosts(event.key);
        yield PostLoadedState(articles: articles);
        if(articles.length == 0){ yield SearchError(message:"No results found");}
      } catch (e) {
        yield PostFetchErrorState(message: e.toString());
      }
    }*/
    else if (event is PostSearchEvent) {
      yield PostLoadingState();
      try {
        List<Item> articles;
        if (event is PostSearchEvent) {
          print("hitting service");
          articles = await repository.searchPosts(event.key);
        }
        if (articles.length == 0) {
          yield PostsEmptyState();
        } else {
          yield PostLoadedState(articles: articles);
        }
      } catch (_) {
        yield SearchError();
      }
    }
  }
}
