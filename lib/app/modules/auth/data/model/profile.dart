import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String email;
  String companyName;
  bool isOnboard;
  String companyLogo;
  final int createdAt;

  Profile(
      {this.email,
      this.createdAt,
      this.companyLogo,
      this.id,
      this.companyName,
      this.isOnboard});

  factory Profile.fromJson(Map<String, dynamic> json) {
    var profile = new Profile(
        id: json['id'],
        email: json['email'],
        companyName: json['companyName'],
        isOnboard: json['isOnboard'],
        createdAt: json['createdAt'],
        companyLogo: json['companyLogo']);
    return profile;
  }

  factory Profile.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['id'] = doc.documentID;
    return Profile.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['companyName'] = this.companyName;
    data['isOnboard'] = this.isOnboard;
    data['companyLogo'] = this.companyLogo;
    return data;
  }
}
