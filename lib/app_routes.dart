
import 'package:comptabli_blog/app/screens/Comments/commentsPage.dart';
import 'package:comptabli_blog/app/screens/article_screen/articleList.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:comptabli_blog/app/screens/notifications/notificationsScreen.dart';
import 'package:flutter/material.dart';

import 'app/screens/auth/forgetPassword/forget_password_screen.dart';
import 'app/screens/auth/login/login_screen.dart';
import 'app/screens/auth/signup/signup_screen.dart';
import 'app/screens/compte_screen/compte.dart';
import 'app/screens/compte_screen/interests_screen.dart';
import 'app/screens/home.dart';
import 'app/screens/splash/splash_screen.dart';
import 'app/screens/tuto/tutorial_screen.dart';


const kMainRoute = '/';
const kLoginRoute = '/login';
const kSignupRoute = '/signup';
const kTutoRoute = '/tuto';
const kHomeRoute = '/home';
const kForgetPwRoute = '/forgetpw';
const kCreateBillRoute = '/createbill';
const kCompteRoute = '/compte';
const kArticleRoute = '/article';
const kCommentsRoute = '/comments';
const kNotifsRoute = '/notifications';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/comments':
        return MaterialPageRoute(builder: (_) => CommentsPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/forgetpw':
        return MaterialPageRoute(builder: (_) => ForgetPwScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/tuto':
       return MaterialPageRoute(builder: (_) => TutorialScreen());
      case '/home':
       return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/createbill':
       // return MaterialPageRoute(builder: (_) => CreateBill());
      case '/compte':
        return MaterialPageRoute(builder: (_) => CompteForm());
      case '/article' :
        return MaterialPageRoute(builder: (_) => ButtomNavigation());
      case '/notifications' :
        return MaterialPageRoute(builder: (_) => NotificationsPage());
      case '/interests' :
        return MaterialPageRoute(builder: (_) => InterestsPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No Route Defined'),
                  ),
                ));
    }
  }
}
