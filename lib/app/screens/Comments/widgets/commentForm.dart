import 'package:comptabli_blog/app/modules/comment/bloc/comment_bloc.dart';
import 'package:comptabli_blog/app/screens/Comments/commentsPage.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentForm extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String url;
  const CommentForm({Key key, this.postId, this.postOwnerId, this.url})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<CommentForm> {
  final _commentController = TextEditingController();

  saveComment() {
    BlocProvider.of<CommentBloc>(context).add(
      CommentAddEvent(
          comment: _commentController.text,
          postId: widget.postId,
          postOwnerId: widget.postOwnerId,
          url:widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentSuccess) {
            _commentController.clear();
            BlocProvider.of<CommentBloc>(context).add(
              FetchComments(id: widget.postId),
            );
            /*Navigator.push(
                context,MaterialPageRoute(builder: (context) => CommentsPage()));*/
          }
          if (state is CommentFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: ListTile(
          title: TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                  labelText: "ajouter un commentaire...",
                  labelStyle: TextStyle(color: kColorBlack),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kColorGrey)))),
          trailing: OutlineButton.icon(
            onPressed: saveComment,
            icon: Icon(Icons.send),
            label: Text("comment"),
            borderSide: BorderSide.none,
          ),
        ));
  }
}
