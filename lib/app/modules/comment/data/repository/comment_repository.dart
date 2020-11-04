import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/comment/data/model/comment.dart';
import 'package:comptabli_blog/app/screens/home.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentRepository {
  final usersReference = Firestore.instance.collection("users");
  DateTime timestamp = DateTime.now();
  final commentsRef = Firestore.instance.collection("comments");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addComment(
      String comment, String postId, String postOwnerId, String url) async {
    FirebaseUser currentUser = await _auth.currentUser();

    DocumentSnapshot documentSnapshot =
        await usersReference.document(currentUser.uid).get();
    if (documentSnapshot.exists) {}
    commentsRef
        .document(postId)
        .collection("comments")
        .document(commentId)
        .setData({
      "commentId": commentId,
      "timestamp": timestamp,
      "username": documentSnapshot.data['fullname'].toString(),
      "userId": currentUser.uid,
      "url": currentUser.photoUrl,
      "comment": comment,
    }).catchError((e) {
      print(e);
    });

    bool isNotPostOwner = postOwnerId != currentUser.uid;
    if (isNotPostOwner) {
      applicationFeedRef.document(postOwnerId).collection("feedItems").add({
        "type": "comment",
        "username": documentSnapshot.data['fullname'].toString(),
        "postId": postId,
        "timestamp": timestamp,
        "url": url,
      });
    }
  }

  Future<List<Comment>> getComments(String commentId) async {
    List<Comment> commentList = [];
    await commentsRef
        .document(commentId)
        .collection("comments")
        .orderBy("timestamp", descending: true)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Comment comment = new Comment(
          id: result['commentId'],
          comment: result["comment"],
          userId: result['userId'],
          username: result['username'],
          url: result['url'],
          timestamp: result['timestamp'],
        );
        commentList.add(comment);
      });
    });

    return commentList;
  }

  Future<void> updateComment(String comment, String id ,String commentId) async {
    await commentsRef
        .document(id)
        .collection("comments")
        .document(commentId)
        .updateData({"comment": comment, "timestamp": timestamp}).catchError(
            (e) {
      print(e);
    });
  }

  Future<void> deleteComment(String id, String commentId) async {
    FirebaseUser currentUser = await _auth.currentUser();
    DocumentSnapshot documentSnapshot =
        await commentsRef.document(commentId).get();
    bool isCommentOwner =
        documentSnapshot.data['userId'].toString() == currentUser.uid;
    if (isCommentOwner) {
      await commentsRef
          .document(id)
          .collection("comments")
          .document(commentId)
          .delete()
          .catchError((e) {
        print(e);
        print("success");
      });
    }
  }
}
