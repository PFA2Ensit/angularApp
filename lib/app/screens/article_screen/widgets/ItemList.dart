import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/Comments/commentsPage.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/swipeUp.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final Item item;

  ItemList({@required this.item});

  @override
  _ItemListState createState() =>
      _ItemListState(likeCount: item.getTotalLikes(item.likes));
}

class _ItemListState extends State<ItemList> {
  final postsReference = Firestore.instance.collection("posts");
  final applicationFeedRef = Firestore.instance.collection("feed");
  final usersReference = Firestore.instance.collection("users");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime timestamp = DateTime.now();
  int likeCount;
  Map likes;
  bool isLiked = false;

  _ItemListState({this.likeCount});
  String id;

  userId() async {
    FirebaseUser currentUser = await _auth.currentUser();
    final id = currentUser.uid;

    return id;
  }

  addLike() async {
    FirebaseUser currentUser = await _auth.currentUser();
    DocumentSnapshot documentSnapshot =
        await usersReference.document(currentUser.uid).get();

    bool isNotPostOwner = currentUser.uid != widget.item.ownerId;
    print(isNotPostOwner);
    if (isNotPostOwner) {
      applicationFeedRef
          .document(widget.item.ownerId)
          .collection("feedItems")
          .document(widget.item.id)
          .setData({
        "type": "like",
        "username": documentSnapshot.data['fullname'].toString(),
        "postId": widget.item.id,
        "timestamp": timestamp,
        "url": widget.item.imageUrl
      });
    }
  }

  removeLike() {
    final id = userId();
    bool isNotPostOwner = id != widget.item.ownerId;
    if (isNotPostOwner) {
      applicationFeedRef
          .document(widget.item.ownerId)
          .collection("feedItems")
          .document(widget.item.id)
          .get()
          .then((document) {
        if (document.exists) {
          document.reference.delete();
        }
      });
    }
  }

  onLikeButtonTapped() async {
    FirebaseUser currentUser = await _auth.currentUser();
    final id = currentUser.uid;
    likes = widget.item.likes;
    bool liked = likes[id] == true;
    Map data = {};
    if (liked) {
      setState(() {
        likeCount--;
        isLiked = false;
        likes[id] = false;
        data = {"$id": false, "counter": likeCount};
      });
      postsReference.document(widget.item.id).updateData({"likes": data});
      removeLike();
    } else if (!liked) {
      setState(() {
        likeCount++;
        isLiked = true;
        likes[id] = true;
        data = {"$id": true, "counter": likeCount};
      });
      postsReference.document(widget.item.id).updateData({"likes": data});
      addLike();
    }
  }

  @override
  Widget build(BuildContext context) {
    userId().then((value) => {
          setState(() {
            id = value;
          })
        });

    //isLiked = likes[id] == true;
    //print(isLiked = likes[id] == true );
    /* var id = userId();
    likes = widget.item.likes;

    */

    /*return BlocListener<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is PostLikedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleScreen(),
              ),
            );
            
          }
          else if(state is ErrorLike){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
         
        },*/
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 20.0 / 12.0,
            child: Image.network(
              widget.item.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SwipeUpExample(this.widget.item),
                        ),
                      );
                    },
                    child: Text(
                      widget.item.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(height: 0.0),
                //SizedBox(height: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentsPage(
                                    postId: widget.item.id,
                                    postOwnerId: widget.item.ownerId,
                                    postImage: widget.item.imageUrl,
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.message,
                              color: kColorBlack,
                            )),
                        /* ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            item.imageWriter,
                            fit: BoxFit.fill,
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),*/
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                widget.item.username,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.item.position,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateTime.parse(widget.item.timestamp
                                        .toDate()
                                        .toString())
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 100),
                                  Text("$likeCount"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              onLikeButtonTapped();
                              //onLikeButtonPressed();
                            },
                            child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: Colors.redAccent)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class HeaderContent extends StatelessWidget {
  final Item item;

  HeaderContent(this.item);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.category,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDesc extends StatelessWidget {
  final Item item;

  MovieDesc(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'RELEASE DATE:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.releaseDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'RUNTIME:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.runtime,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
