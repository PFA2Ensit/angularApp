import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextField(
        onChanged: (term) {
          BlocProvider.of<BlogBloc>(context)
              .add(PostSearchEvent(key: term));
        },
        style: searchTextStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          hintStyle: hintStyle,
          hintText: 'Search for a post',
         
        ),
      ),
    );
  }
}