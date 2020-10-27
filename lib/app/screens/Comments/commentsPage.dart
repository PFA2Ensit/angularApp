import 'package:comptabli_blog/app/screens/Comments/widgets/commentForm.dart';
import 'package:comptabli_blog/app/screens/Comments/widgets/commentsList.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postImage;

  CommentsPage({this.postId, this.postOwnerId, this.postImage});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Comments page",style: TextStyle(color:kColorBlack),),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: CommentList(postId: widget.postId),
            ),
            Divider(),
            CommentForm(postId: widget.postId,postOwnerId:widget.postOwnerId),
          ],
        ));
  }
}
