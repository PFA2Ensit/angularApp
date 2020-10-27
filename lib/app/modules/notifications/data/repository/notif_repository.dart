import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/notifications/data/model/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';



class NotificationsRepository {
  
final usersReference = Firestore.instance.collection("users");
  DateTime timestamp = DateTime.now();
  final notifsRef = Firestore.instance.collection("feed");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  
  Future<List<Notifications>> getNotifications() async {
    List<Notifications> notifList = [];
    FirebaseUser currentUser = await _auth.currentUser();
    await notifsRef.document(currentUser.uid).collection("feedItems")
        .orderBy("timestamp", descending: true)
        .limit(60)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
       Notifications notif = new Notifications(
            id: result['commentId'],
            type:result["type"],
            postId: result['postId'],
            username: result['username'],
            url: result['url'],
            timestamp: result['timestamp'],
            
           );
       notifList.add(notif);
      });

    });

    
    return notifList;
  }


   

  
}
