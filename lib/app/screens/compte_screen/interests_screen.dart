
import 'dart:io';

import 'package:comptabli_blog/app/modules/compte/bloc/compte_bloc.dart';
import 'package:comptabli_blog/app/modules/compte/bloc/compte_state.dart';
import 'package:comptabli_blog/app/modules/compte/bloc/compte_event.dart';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/screens/compte_screen/widgets/choice.dart';
import 'package:comptabli_blog/app/screens/compte_screen/widgets/item.dart';
import 'package:comptabli_blog/app/screens/profile/profileScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../my_icons_icons.dart';
import '../home.dart';


class InterestsPage extends StatefulWidget {
  final double screenHeight;
  final Compte compte;
  final File profileImage;

  InterestsPage({
    Key key,
    this.compte,
    this.profileImage,
    this.screenHeight,
  }) : super(key: key);
  
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {

  List<Choice> choices = [
    Choice(MyIcons.paint, "Art & culture"),
    Choice(MyIcons.ai, "Intelligence artificielle"),
    Choice(MyIcons.tractor_icon, "Agriculture"),
    Choice(MyIcons.recycle, "Environment"),
    Choice(MyIcons.college_graduation, "Education"),
    Choice(MyIcons.e, "E-commerce"),
    Choice(MyIcons.finance, "Finance"),
    Choice(MyIcons.food, "Restauration"),
    Choice(MyIcons.health_5fe9bcc602d060755a6375608845b192, "Santé"),
    Choice(MyIcons.cup, "Sport"),
    Choice(MyIcons.map, "Voyage"),
    Choice(MyIcons.projektmanagement, "Technologie"),
  ];

  _onCreateButtonPressed() async {
    widget.compte.interests = GridViewItem.selectedIcons ;
    print(widget.compte.interests);

      BlocProvider.of<CompteBloc>(context).add(
        CreateCompte(
          compte:widget.compte
        ),

      );
      String downloadUrl = await uploadPhotos(widget.profileImage);
      widget.compte.photoUrl = downloadUrl;
      BlocProvider.of<CompteBloc>(context).add(
              UpdateProfileEvent(compte: widget.compte),


      );
    
  }

  @override
  Widget build(BuildContext context) {

    Widget gridViewSelection = GridView.count(
        //childAspectRatio: 2.0,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 9.0 / 10.0,
        crossAxisCount: 3,
        children: List.generate(choices.length, (index) {
          return Center(
            child: GridViewItem(choices[index]),
          );
        }));

    return  BlocListener<CompteBloc, CompteState>(
       listener: (context, state) {
        if (state is CreateCompleted) {
         Navigator.push(
                        context,
                        MaterialPageRoute(
                         builder: (context) => ButtomNavigation(),
                        ),
                      );
        }
        if (state is CreateFailed) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is CreateCompleted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
      }, 
    
    child:Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: new Center(
              child: Text("Préférences",
                  style: TextStyle(fontSize: 25, color: Colors.black))),
          backgroundColor: Colors.white,
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          return new Center(
            child: new ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                new Text(
                    "Veuillez séléctionnez les catégories qui vous interessent",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 17.0)),
                new Container(height: 520, child: gridViewSelection),
                new Container(
                  height: 5,
                ),
                Center(
                  child: RaisedButton.icon(
                    color: Colors.black,
                    onPressed: () {
                     _onCreateButtonPressed();
                      
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    label: Text(
                      "Poursuivre",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        })));
  }

  Future<String> uploadPhotos(File file) async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("profile photos");
    StorageUploadTask uploadTask = firebaseStorageRef.child("post_$postId.jpg").putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
