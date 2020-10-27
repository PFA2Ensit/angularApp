import 'package:comptabli_blog/app/modules/comment/bloc/comment_bloc.dart';
import 'package:comptabli_blog/app/modules/comment/data/model/comment.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatefulWidget {
  final String postId;
  const CommentList({Key key, this.postId}) : super(key: key);

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentList> {
  CommentBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CommentBloc>(context);
    bloc.add(FetchComments(id: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentFetchErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if( state is CommentDeleteError){

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          
        }
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentInitial) {
            return buildLoading();
          } else if (state is CommentLoadingState) {
            return buildLoading();
          } else if (state is CommentLoadedState) {
            return buildCommentsList(state.comments);
          } else if (state is CommentFetchErrorState) {
            return buildErrorUi(state.message);
          } else
            return Container();
        },
      ),
    );
  }

  Widget buildCommentsList(List<Comment> comment) {
    return ListView.builder(
      itemCount: comment.length,
      itemBuilder: (ctx, pos) {
        final item = comment[pos];
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Dismissible(
                  key: Key(item.toString()),
                  onDismissed: (direction) {
                    bloc = BlocProvider.of<CommentBloc>(context);
                    bloc.add(CommentDeleteEvent(id: widget.postId,commentId:comment[pos].id ));
                    setState(() {
                      comment.removeAt(pos);
                    });

                    // Then show a snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("comment deleted")));
                  },
                  child: ListTile(
                    title: Text(
                      comment[pos].username + " : " + comment[pos].comment,
                      style: TextStyle(color: kColorBlack),
                    ),
                    /*leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(comment[pos].url)),
            ),*/
                    onTap: () {},
                  )),
            ));
      },
    );
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
