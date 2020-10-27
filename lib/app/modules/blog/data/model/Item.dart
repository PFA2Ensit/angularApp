import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Item {
  String id;
  String name;
  String text;
  List<dynamic> category;
  Timestamp timestamp;
  String username;
  String position;
  String imageUrl;
  String imageWriter;
  String ownerId;
  dynamic likes;

  Item.otherContructor(Item item) {
    this.id = item.id;
    this.name = item.name;
    this.text = item.text;
    this.timestamp = item.timestamp;
    this.imageWriter = item.imageWriter;
  }

  Item(
      {this.id,
      this.name,
      this.text,
      this.category,
      this.username,
      this.timestamp,
      this.position,
      this.imageUrl,
      this.imageWriter,
      this.ownerId,
      this.likes});

  factory Item.fromJson(Map<String, dynamic> json) {
    var article = new Item(
        id: json['id'],
        name: json['name'],
        text: json['text'],
        category: json['category'],
        username: json['writer'],
        position: json['position'],
        imageUrl: json['imageUrl'],
        imageWriter: json['imageWriter'],
        ownerId: json['ownerId'],
        likes: json['likes']);
    return article;
  }

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['id'] = doc.documentID;
    return Item.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.name;
    data['text'] = this.text;
    data['category'] = this.category;
    data['writer'] = this.username;
    data['position'] = this.position;
    data['imageUrl'] = this.imageUrl;
    data['imageWriter'] = this.imageWriter;
    data['ownerId'] = this.ownerId;
    data['likes'] = this.likes;

    return data;
  }

  factory Item.fromDocument(DocumentSnapshot documentSnapshot){
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

  }
  int getTotalLikes(likes){
    if (likes == null)  {
      return 0;
    }

    int counter = 0;
    likes.values.forEach((value){
      if (value == true){
        counter ++;
      }
    });
    return counter;
  }
}
