import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_state.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/appBar.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/carousel.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/gridScreen.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import 'article_add.dart';

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArticleScreen(),
    );
  }
}*/

class ArticleScreen extends StatefulWidget {
  @override
  ArticleScreenState createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  BlogBloc articleBloc;
  String filter = BlogAppBar.filter;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<BlogBloc>(context);
    articleBloc.add(FetchArticles(filter: filter));
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              body: Container(
                child: BlocListener<BlogBloc, BlogState>(
                  listener: (context, state) {
                    if (state is PostFetchErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<BlogBloc, BlogState>(
                    builder: (context, state) {
                      if (state is BlogInitial) {
                        return buildLoading();
                      } else if (state is PostLoadingState) {
                        return buildLoading();
                      } else if (state is PostLoadedState) {
                        return buildArticleList(state.articles);
                      } else if (state is PostFetchErrorState) {
                        return buildErrorUi(state.message);
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildArticleList(List<Item> articles) {
    List<Item> how=[];
    List<Item> other=[];

    articles.forEach((element){
      
      if (element.category.contains("How to series")) {
        how.add(element);
        //print(how.toString());
      } else {
        other.add(element);

        //print(other.toString());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BlogAppBar(),
      body: new ListView(
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "How To Séries",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          CarouselScreen(itemList: how),
          new Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "UniBoard Netwok",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          new Center(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.border_color),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ArticleForm()),
                    );
                  },
                ),
                Text(
                  "Rédiger",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
            width: 60,
            height: 75,
            decoration: new BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            ),
          )),
          //grid view begins here
          Container(
            height: 400.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: GridScreen(itemList: other),
                )
              ],
            ),
          ),
          //ButtomNavigation()
        ],
      ),
      /*bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.storage),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/compte');
                  /*.push(context,
                      new MaterialPageRoute(builder: (context) => Compte()));*/
                },
              ),
              IconButton(
                icon: Icon(Icons.receipt),
                onPressed: () {},
              ),
            ],
          ),
        ),*/
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
