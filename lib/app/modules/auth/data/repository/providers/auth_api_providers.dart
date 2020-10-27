import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/auth/data/model/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Future<AuthResult> createUserWithEmailAndPassword(
      {String email, String password}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future createProfile(FirebaseUser user) async {
    Profile company = new Profile(email: user.email, id: user.uid);
    await _firestore
        .collection('companies')
        .document(user.uid)
        .setData(company.toJson());
  }

  Future<AuthResult> signInWithEmailAndPassword(
      {String email, String password}) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
