import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String commentId;
  String comment;
  String userId;
  String username;
  String url;
  Timestamp timestamp;

  Comment({
    this.commentId,
    this.comment,
    this.userId,
    this.username,
    this.url,
    this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    var article = new Comment(
      commentId: json['commentId'],
      comment: json['comment'],
      userId: json['userId'],
      username: json['username'],
      url: json['url'],
      timestamp: json['timestamp'],
    );
    return article;
  }

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['commentId'] = doc.documentID;
    return Comment.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['comment'] = this.comment;
    data['userId'] = this.userId;
    data['username'] = this.username;

    data['url'] = this.url;
    data['timestamp'] = this.timestamp;

    return data;
  }

  /*factory Item.fromDocument(DocumentSnapshot documentSnapshot){
    return Item(
        id: documentSnapshot['id'],
        name: documentSnapshot['name'],
        text: documentSnapshot['text'],
        category: documentSnapshot['category'],
        username: documentSnapshot['writer'],
        position: documentSnapshot['position'],
        imageUrl: documentSnapshot['imageUrl'],
        imageWriter: documentSnapshot['imageWriter'],
        ownerId: documentSnapshot['ownerId'],
        likes: documentSnapshot['likes']

    );

  }*/

}
