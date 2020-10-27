import 'package:cloud_firestore/cloud_firestore.dart';

class Compte {
  String id;
  String fullname;
  String position;
  List<dynamic> expertises;
  List<dynamic> interests;
  String photoUrl;

  Compte({this.id,this.fullname, this.position, this.expertises, this.interests,this.photoUrl});

  
  factory Compte.fromJson(Map<String, dynamic> json) {
    var compte = new Compte(
        id: json['id'],
        fullname: json['fullname'],
       position: json['position'],
       expertises: json['expertises'],
        interests: json['interests'],
        photoUrl: json['photoUrl']
      );
    return compte;
  }

  factory Compte.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['id'] = doc.documentID;
    return Compte.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['position'] = this.position;
    data['expertises'] = this.expertises;
    data['interests'] = this.interests;
    data['photoUrl'] = this.photoUrl;
   
    return data;
  }
}
