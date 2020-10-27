import 'dart:io';

import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/modules/compte/data/repository/compte_repository.dart';
import 'package:comptabli_blog/app/screens/profile/widgets/userInfo.dart';
import 'package:comptabli_blog/app/screens/profile/widgets/userPosts.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../locator.dart';
import 'editProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File profileImage;
  CompteRepository repository = locator<CompteRepository>();
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  userId() async {
    auth.FirebaseUser currentUser = await _auth.currentUser();
    final id = currentUser.uid;

    return id;
  }

  Future pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        child: GestureDetector(
            onTap: () {
              pickImageFromGallery();
            },
            child: profileImage == null
                ? Icon(Icons.add_a_photo)
                : Container(
                    decoration: BoxDecoration(
                        color: kColorBlack,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Image.file(
                      profileImage,
                      fit: BoxFit.cover,
                    ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Compte> user = repository.getUserInfo();
    dynamic value;
    setState(() {
      user.then((value) => value.id);
    });
    final id = userId();

    
    return Scaffold(
      appBar: AppBar(
        actions: [
          id == value
              ? PopupMenuButton<String>(
                  icon:
                      new Icon(Icons.more_vert, size: 35.0, color: kColorBlack),
                  onSelected: action,
                  itemBuilder: (BuildContext context) {
                    return actions.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              : Container()
        ],
        title: Text(
          "Profile",
          style: TextStyle(color: kColorBlack),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFF21BFBD),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          //SizedBox(height: 25.0),
          _buildProfileImage(),
          SizedBox(height: 40.0),
          Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: UserInformation())
        ],
      ),
    );
  }

  void action(String choice) {
    if (choice == "edit profile") {
      /* Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondRoute()),
  );*/
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserPosts()),
      );
    }
  }
}
