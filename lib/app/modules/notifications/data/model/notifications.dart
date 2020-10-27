import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  String id;
  String type;
  String postId;
  String username;
  String url;
  Timestamp timestamp;

  Notifications({
    this.id,
    this.type,
    this.postId,
    this.username,
    this.url,
    this.timestamp,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    var article = new Notifications(
      id: json['id'],
      type: json['type'],
      postId: json['postId'],
      username: json['username'],
      url: json['url'],
      timestamp: json['timestamp'],
    );
    return article;
  }

  factory Notifications.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['id'] = doc.documentID;
    return Notifications.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['userId'] = this.postId;
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
