import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/appBar.dart';
import 'package:comptabli_blog/app/screens/home/widget/declarations.dart';
import 'package:comptabli_blog/app/screens/home/widget/numbers.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/i18n/translations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';

import '../../../app_routes.dart';

void main() {
  runApp(HomeScreen());
}
final usersReference = Firestore.instance.collection("users");
  final postsReference = Firestore.instance.collection("posts");
  final FirebaseAuth _auth = FirebaseAuth.instance;


    final applicationFeedRef =  Firestore.instance.collection("feed");
      DateTime timestamp = DateTime.now();

int notificationCount ;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 bool isClicked = false;
 final scaffoldKey = GlobalKey<ScaffoldState>();


 configureRealTimePushNotifications() async{
   FirebaseUser user = await _auth.currentUser();
   if(Platform.isIOS){
     _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(alert:true,badge:true,sound:true));
     _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
       print("setting registered : $settings");
     });
   }

   _firebaseMessaging.getToken().then((token) {
     usersReference.document(user.uid).updateData({"androidNotificationToken":token});
   } );
   _firebaseMessaging.configure(
           

     onMessage: (Map<String, dynamic> message) async {
       final String recipientId = message["data"]["recipient"];
       final String body = message["notification"]["body"];
        
              
       if(recipientId == user.uid){
         print("id = "+recipientId);
          setState((){
         notificationCount++;
       });
       SnackBar snackBar = SnackBar(content: Text(body));
       scaffoldKey.currentState.showSnackBar(snackBar);
       }

     },
   );


 }
 @override
 void initState() {
   super.initState();
   notificationCount = 0;
   //configureRealTimePushNotifications() ;
 }


  @override
  Widget build(BuildContext context) {
    Translations translation = Translations.of(context);
    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: kColorWhite,
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 70,
              flexibleSpace: FlexibleSpaceBar(background: ComptaAppBar())),
          SliverFillRemainingBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DeclarationsWidget(translation: translation),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Numbers(translation: translation),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(
          Icons.aspect_ratio,
          color: kColorWhite,
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: kColorBlack,
        onPressed: () {
          Navigator.of(context).pushNamed(kCreateBillRoute);
        },
      ),
       bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.storage),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompteForm()),
                  );*/
                },
              ),
              IconButton(
                icon: Icon(Icons.receipt),
                onPressed: () {         Navigator.of(context).pushNamed(kArticleRoute);
},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
