import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/home.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';



class PostRepository {
  
final usersReference = Firestore.instance.collection("users");
  DateTime timestamp = DateTime.now();
  final postsReference = Firestore.instance.collection("posts");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addPost(String name, String downloadUrl, List<String> category,
      String text) async {
    FirebaseUser currentUser = await _auth.currentUser();
    DocumentSnapshot documentSnapshot =
        await usersReference.document(currentUser.uid).get();
    if (documentSnapshot.exists) {}
    postsReference.document(postId).setData({
      "postId": postId,
      "ownerId": currentUser.uid,
      "likes": {},
      "text": text,
      "timestamp": timestamp,
      "username": documentSnapshot.data['fullname'].toString(),
      "position": documentSnapshot.data['position'].toString(),
      "writerImage": documentSnapshot.data['photoUrl'].toString(),
      "name": name,
      "downloadUrl": downloadUrl,
      "category": category
    }).catchError((e) {
      print(e);
    });


   

  }

  Future<List<Item>> getPosts(String filter) async {
    List<Item> postList = [];
    if(filter == Recent){
    await postsReference
        .orderBy("timestamp", descending: true)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Item item = new Item(
            id: result['postId'],
            name: result['name'],
            text: result['text'],
            category: result['category'],
            timestamp: result['timestamp'],
            username: result['username'],
            position: result['position'],
            imageUrl: result['downloadUrl'],
            imageWriter: result['imageWriter'],
            ownerId: result['ownerId'],
            likes: result['likes']);
        postList.add(item);
      });

    });
    }else if(filter == Old){

      await postsReference
        .orderBy("timestamp", descending: false)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Item item = new Item(
            id: result['postId'],
            name: result['name'],
            text: result['text'],
            category: result['category'],
            timestamp: result['timestamp'],
            username: result['username'],
            position: result['position'],
            imageUrl: result['downloadUrl'],
            imageWriter: result['imageWriter'],
            ownerId: result['ownerId'],
            likes: result['likes']);
        postList.add(item);
      });

    });

    }else if(filter == MostLiked){
      await postsReference
        .orderBy("likes", descending: true)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Item item = new Item(
            id: result['postId'],
            name: result['name'],
            text: result['text'],
            category: result['category'],
            timestamp: result['timestamp'],
            username: result['username'],
            position: result['position'],
            imageUrl: result['downloadUrl'],
            imageWriter: result['imageWriter'],
            ownerId: result['ownerId'],
            likes: result['likes']);
        postList.add(item);
      });

    });
    }
    
    return postList;
  }


  Future<List<Item>> getUserPosts() async {
    List<Item> postList = [];
    FirebaseUser currentUser = await _auth.currentUser();
  
    await postsReference
        .orderBy("timestamp", descending: false)
        .where("ownerId", isEqualTo: currentUser.uid)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Item item = new Item(
            id: result['postId'],
            name: result['name'],
            text: result['text'],
            category: result['category'],
            timestamp: result['timestamp'],
            username: result['username'],
            position: result['position'],
            imageUrl: result['downloadUrl'],
            imageWriter: result['imageWriter'],
            ownerId: result['ownerId'],
            likes: result['likes']);
        postList.add(item);
      });

    });


    return postList;
    }


    Future<void> updatePost(String comment, String id) async {
    await postsReference.document(id).updateData({"comment":comment}).catchError((e) {
      print(e);
    });
    
  }

    Future<void> deletePost(String id) async {
    await postsReference.document(id).delete().catchError((e) {
      print(e);
    });
    
  }

  Future<List<Item>> searchPosts(String searchField) async {
        List<Item> postList = [];

    await postsReference
       /*.where('name',
            isEqualTo: searchField.substring(0,3))*/
       
        .getDocuments()
         .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Item item = new Item(
            id: result['postId'],
            name: result['name'],
            text: result['text'],
            category: result['category'],
            timestamp: result['timestamp'],
            username: result['username'],
            position: result['position'],
            imageUrl: result['downloadUrl'],
            imageWriter: result['imageWriter'],
            ownerId: result['ownerId'],
            likes: result['likes']);

            if(item.category.contains(searchField)){postList.add(item);
}
      });

          });
          return postList;
  }

  
  

  

  onLikeButtonTapped(Map likes, int likeCount, String postId) async {
    FirebaseUser currentUser = await _auth.currentUser();
    var id = currentUser.uid;
     bool liked = likes[id] == true;
     Map data = {};
    if (liked) {
      likeCount = likeCount - 1;

      data = {"likes.$id": false,"counter":likeCount};
      postsReference.document(postId).updateData({"likes":data});
      likes[id] = false;
    } else if(!liked) {
      likeCount = likeCount + 1;

      data = {"likes.$id": true,"counter":likeCount};
      postsReference.document(postId).updateData({"likes":data});
      likes[id] = true;
    }
  }
}
