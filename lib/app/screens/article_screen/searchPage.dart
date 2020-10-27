import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_state.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}*/



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<BlogBloc>(context),
      builder: (context, state) {
        if (state is BlogInitial) {
          return Container(
               );
        } else if (state is PostsEmptyState) {
          return message( "No Posts found");
        } else if (state is SearchError) {
          return message("Something went wrong");
        } else if (state is PostLoadingState) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else {
          final stateAsPostFetchedState = state as PostLoadedState;
          final results = stateAsPostFetchedState.articles;
          return buildPlayersList(results);
        }
      },
    );
  }

  Widget buildPlayersList(List<Item> players) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          Item player = players[index];
          return ListTile(
            leading: Image.network(
              player.imageUrl,
              width: 70.0,
              height: 70.0,
            ),
            title: Text(player.name, style: TextStyle(color: Colors.black, fontSize: 20.0)),
            subtitle: Text(player.username, style: TextStyle(color:kColorBlack),
          ));
        },
        separatorBuilder: (BuildContext context, index) {
          return Divider(
            height: 8.0,
            color: Colors.transparent,
          );
        },
        itemCount: players.length,
      ),
    );
  }



  Widget message(String message){
 
 
    return Expanded(
      child: Center(
        child: Text(message, textAlign: TextAlign.center,),
      ),
    );
  }
}







