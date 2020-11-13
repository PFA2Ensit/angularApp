import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:firebase_auth/firebase_auth.dart';
bool error;
class CompteRepository{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final usersReference = Firestore.instance.collection("users");

  Future<bool> createCompte(String fullname,String position,List<String> expertises,List<String> interests) async {
    final FirebaseUser currentUser = await _auth.currentUser();
    DocumentSnapshot documentSnapshot = await usersReference.document(currentUser.uid).get();
    //bool error;
   if(!documentSnapshot.exists){
       usersReference.document(currentUser.uid).setData({
          "id":currentUser.uid,
          "fullname":fullname,
          "position":position,
          "expertises":expertises,
          "interests":interests,
          "photoUrl":""

       }).catchError((e) {
        print(e);
    });
      error=true; 
   }
   else {
     error = false;
     print("account already exists");}
    
    return error;
  }

  Future<Compte> getUserInfo() async {
    Compte user;
    FirebaseUser currentUser = await _auth.currentUser();
  
    await usersReference
        .where("id", isEqualTo: currentUser.uid)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Compte  compte = new Compte(
            id: result['id'],
            fullname: result['fullname'],
            position: result['position'],
            expertises: result['expertises'],
            interests: result['interests'],
            photoUrl : result['photoUrl']
           );
      user = compte;
      });

    });

    return user;
    }

    Future<void> updateCompte(String fullname,String position,List<String> expertises,List<String> interests,String photoUrl) async {
    final FirebaseUser currentUser = await _auth.currentUser();

      usersReference.document(currentUser.uid).updateData({
          
          "fullname":fullname,
          "position":position,
          "expertises":expertises,
          "interests":interests,
          "photoUrl":photoUrl

       }).catchError((e) {
        print(e);
    });

       
    }

  
}