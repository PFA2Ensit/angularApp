import 'dart:io';

import 'package:comptabli_blog/app/modules/compte/bloc/compte_bloc.dart';
import 'package:comptabli_blog/app/modules/compte/bloc/compte_state.dart';
import 'package:comptabli_blog/app/modules/compte/bloc/compte_event.dart';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/screens/profile/editProfileScreen.dart';
import 'package:comptabli_blog/app/screens/profile/widgets/userPosts.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  CompteBloc bloc;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CompteBloc>(context);
    bloc.add(ViewProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompteBloc, CompteState>(
      listener: (context, state) {
        if (state is ProfileErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<CompteBloc, CompteState>(
        builder: (context, state) {
          if (state is CompteInitial) {
            return buildLoading();
          } else if (state is ProfileLoadingState) {
            return buildLoading();
          } else if (state is ProfileLoadedState) {
            return buildUserInfoList(state.user);
          } else if (state is ProfileErrorState) {
            return buildErrorUi(state.message);
          } else
            return Container();
        },
      ),
    );
  }

  


  Widget buildUserInfoList(Compte user)  {
    void action(String choice) {
      if (choice == "edit profile") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePage(
                    compte: user,
                  )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPosts()),
        );
      }
    }

    userId() async {
    FirebaseUser currentUser = await _auth.currentUser();
    String id =  currentUser.uid;
    return id == user.id;
  }

    final id = userId();
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          id != null  
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
         Image.network(user.photoUrl,width: 200.0,height: 150.0,),
          SizedBox(height: 40.0),
          Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 50.0),
                  ListTile(
                    title: Text("Fullname"),
                    subtitle: Text(user.fullname),
                  ),
                  ListTile(
                    title: Text("Position"),
                    subtitle: Text(user.position),
                  ),
                  ListTile(title: Text("Interests"), subtitle: GetTags(user)),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class GetTags extends StatelessWidget {
  Compte item;
  GetTags(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
      height: 45.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(5),
          itemCount: item.interests.length,
          itemBuilder: (BuildContext context, int index) {
            return SetTagsItem(item.interests[index]);
          }),
    );
  }
}

class SetTagsItem extends StatelessWidget {
  final String tag;

  SetTagsItem(this.tag);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 45.0,
      margin: EdgeInsets.only(
        left: 6.0,
        right: 9.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        //border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(
          tag,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ),
    );
  }
}
