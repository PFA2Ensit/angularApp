import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComptaAppBar extends StatefulWidget with PreferredSizeWidget {
  final Size preferredSize;
  final Item item;
  static String filter;

  ComptaAppBar({
    Key key,
    this.item
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _ComptaAppBarState createState() => _ComptaAppBarState();
}

class _ComptaAppBarState extends State<ComptaAppBar> {

    
  BlogBloc articleBloc;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int likeCount;

  Map likes;
  String id;

  bool isLiked = false;
  Future<String> userId() async {
    FirebaseUser currentUser = await _auth.currentUser();
    
    
    return  currentUser.uid;
  }


 


  void initState() {
    super.initState();
    ComptaAppBar.filter = Recent;

}

  @override
  Widget build(BuildContext context) {

    userId().then((value) =>  {

       setState(() {
    id=value;
  })
  }              
);

    void choiceAction(String choice){
    if(choice == MostLiked){
      setState(() {
              ComptaAppBar.filter = MostLiked;
               articleBloc = BlocProvider.of<BlogBloc>(context);
    articleBloc.add(FetchArticles(filter:  ComptaAppBar.filter));

      });
    }else if(choice == Recent){
    setState(() {
                ComptaAppBar.filter = Recent;
                 articleBloc = BlocProvider.of<BlogBloc>(context);
    articleBloc.add(FetchArticles(filter:  ComptaAppBar.filter));

    });

    
    }else if(choice == Old){
      setState(() {
                   ComptaAppBar.filter = Old;
                   articleBloc = BlocProvider.of<BlogBloc>(context);
    articleBloc.add(FetchArticles(filter:  ComptaAppBar.filter));

      });

    }
}

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              onTap: () {},
              child: CircleAvatar(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                 child: FutureBuilder(future: usersReference.document(id).get(),
                 // ignore: missing_return
                 builder:(context,dataSnapshot){
                   if(dataSnapshot.hasData){
                     return Image.network(dataSnapshot.data['photoUrl'].toString());
                   }else {
                     return Image.asset("images/profile.png");
                   }
                 }
                ),
              ))),
          Center(
            child: AppLogo(dark:true)),
          
           PopupMenuButton<String>(
             icon: new Icon(const IconData(0xf1de, fontFamily: 'Filter'),
                  size: 35.0, color: kColorBlack),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          
        ],
      ),
    );
  }
}
  
  

