import 'dart:async';
import 'dart:io';
import 'package:comptabli_blog/app/modules/auth/data/repository/providers/auth_api_providers.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthApiProvider _api = AuthApiProvider();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<AuthResult> sigUpWithEmail({String email, String password}) async {
    return await _api.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> signInWithEmail({String email, String password}) async {
    return await _api.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future createProfile(FirebaseUser user) async {
    return await _api.createProfile(user);
  }

  Future<bool> hasUserLoggedIn() async {
    FirebaseUser user = await _auth.currentUser();
    //1 second to show splash screen
    await Future.delayed(const Duration(seconds: 1));
    if (user != null) {
      print('hey');
      //configureRealTimePushNotifications();
      try {
        await user.reload();
      } catch (e) {
        await _auth.signOut();
        return false;
      }
    }
    return user != null;
  }

   
}
