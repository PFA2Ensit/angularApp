import 'dart:core';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlogEvent extends Equatable {
   const BlogEvent();
   @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddPost extends BlogEvent {
  Item item;
  AddPost(
      {this.item});

  
  }

class FetchArticles extends BlogEvent {
  final String filter;
  FetchArticles({this.filter});

  
}

// ignore: must_be_immutable
class LikePost extends BlogEvent{
  dynamic likes;
  int likeCount;
  String postId;
  LikePost({this.likes,this.likeCount,this.postId});
}

class FetchUserPosts extends BlogEvent {
  
  FetchUserPosts();

  
}

class PostDeleteEvent extends BlogEvent{
final String id;
  PostDeleteEvent({this.id});

}


class PostSearchEvent extends BlogEvent{
final String key;
  PostSearchEvent({this.key});

}



