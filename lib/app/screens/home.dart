import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/screens/article_screen/articleList.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:comptabli_blog/app/screens/profile/widgets/userInfo.dart';
import 'package:comptabli_blog/app/screens/scanning/scan_screen.dart';

import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'article_screen/search.dart';
import 'messagingDemo.dart';
import 'notifications/notificationsScreen.dart';
import 'notifications/widgets/notifDot.dart';


 final String postId = Uuid().v4();
 final String commentId = Uuid().v4();





class ButtomNavigation extends StatefulWidget{
  @override
  ButtomNavigationState createState() => ButtomNavigationState();
  
    
  }
  
  class ButtomNavigationState extends State<ButtomNavigation>{
    PageController pageController;
    int getPageIndex = 0;
    final scaffoldKey = GlobalKey<ScaffoldState>();


    @override
  void initState() {
    super.initState();
    pageController = PageController();


  }

  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  whenPageChanges(int pageIndex){
    setState(() {
          this.getPageIndex = pageIndex;

    });
  }

  onTapPageChange(int pageIndex){
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds:400 ), curve: Curves.bounceInOut);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body:PageView(
       children:<Widget>[
        //HomeScreen(),
        MessagingDemo(),
        Search(),
        ArticleScreen(),

       NotificationsPage(),
      UserInformation(),
      //MyHomePage(),
      // ScanScreen()
        
         
         
       ],
       controller : pageController,
       onPageChanged : whenPageChanges,
       physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar :CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.search)),
                BottomNavigationBarItem(icon: Icon(Icons.book,size: 37.0,)),

        BottomNavigationBarItem(
          icon: dot(
             Icons.notifications,
             notificationCount
       
      ),),
        BottomNavigationBarItem(icon: Icon(Icons.person))



      ],
      currentIndex: getPageIndex,
      onTap:onTapPageChange ,
      backgroundColor: kColorWhite,
      activeColor: kColorGrey,
      inactiveColor:kColorBlack,)

    );
   
  }
}