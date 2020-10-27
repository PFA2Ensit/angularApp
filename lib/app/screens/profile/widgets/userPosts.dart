import 'dart:convert';

import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_state.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/GridItemDetails.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefyr/zefyr.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({Key key}) : super(key: key);

  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  BlogBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<BlogBloc>(context);
    bloc.add(FetchUserPosts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is PostFetchErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is DeleteError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogInitial) {
            return buildLoading();
          } else if (state is PostLoadingState) {
            return buildLoading();
          } else if (state is PostLoadedState) {
            return buildCommentsList(state.articles);
          } else if (state is PostFetchErrorState) {
            return buildErrorUi(state.message);
          } else
            return Container();
        },
      ),
    );
  }

  Widget buildCommentsList(List<Item> post) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Mes Articles",
            style: TextStyle(color: kColorBlack),
          ),
          backgroundColor: kColorWhite,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView.builder(
          itemCount: post.length,
          itemBuilder: (ctx, pos) {
            final item = post[pos];
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Dismissible(
                  key: Key(item.toString()),
                  onDismissed: (direction) {
                    bloc = BlocProvider.of<BlogBloc>(context);
                    bloc.add(PostDeleteEvent(id: post[pos].id));
                    setState(() {
                      post.removeAt(pos);
                    });

                    // Then show a snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("post deleted")));
                  },
                  child: InkWell(onTap: () {}, child:Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 260.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(post[pos].imageUrl),
                                    fit: BoxFit.fill)),
                          )),
                          ExpansionTile(title: Text(post[pos].name),subtitle:Text(post[pos].likes["counter"].toString()+" likes"),
                          children: [ ZefyrView(
              document: NotusDocument.fromJson(jsonDecode(post[pos].text)),
            ),],)
                    ],
                  ))), /*ListTile(
                    title: Text(
                      post[pos].name,
                      style: TextStyle(color: kColorBlack),
                    ),
                    /*leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(comment[pos].url)),
            ),*/
                    onTap: () {},
                  )),*/
                )));
          },
        ));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
