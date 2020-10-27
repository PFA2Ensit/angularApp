import 'package:comptabli_blog/app/screens/article_screen/articleList.dart';
import 'package:comptabli_blog/app/screens/auth/login/login_screen.dart';
import 'package:comptabli_blog/app/screens/compte_screen/compte.dart';
import 'package:comptabli_blog/app/screens/notifications/notificationsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:comptabli_blog/app/themes/constants.dart';


class ButtomNavigation extends StatefulWidget{
  @override
  ButtomNavigationState createState() => ButtomNavigationState();
  
    
  }
  
  class ButtomNavigationState extends State<ButtomNavigation>{
    PageController pageController;
    int getPageIndex = 0;

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
      body:PageView(
       children:<Widget>[
       // HomeScreen(),
               LoginScreen(),

        CompteForm(),
         ArticleScreen(),
         NotificationsPage()
         
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

        BottomNavigationBarItem(icon: Icon(Icons.notifications)),
        BottomNavigationBarItem(icon: Icon(Icons.person))



      ],
      currentIndex: getPageIndex,
      onTap:onTapPageChange ,
      backgroundColor: kColorBlack,
      activeColor: Colors.grey,
      inactiveColor: Colors.blueGrey,)

    );
   
  }
}