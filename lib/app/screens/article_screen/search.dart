import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/data/repository/post_repository.dart';
import 'package:comptabli_blog/app/screens/article_screen/searchPage.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/searchBar.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  final PostRepository repository;

  Search({this.repository});

  @override
  SearchState createState() {
    return new SearchState();
  }
}

class SearchState extends State<Search> {
  BlogBloc post;

  @override
  void initState() {
    super.initState();
    /* post =
        BlogBloc(repository: widget.repository);*/
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BlogBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),

          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Search Page',
            style: TextStyle(color:kColorBlack),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            SearchBar(),
            SizedBox(height: 10.0),
            SearchPage()
          ],
        ),
      ),
    );
  }
}