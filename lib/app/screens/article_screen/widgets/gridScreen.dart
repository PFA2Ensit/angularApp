import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:flutter/material.dart';

import 'ItemList.dart';

// ignore: must_be_immutable
class GridScreen extends StatelessWidget {
  List<Item> itemList;
  GridScreen({this.itemList});

  @override
  Widget build(BuildContext context) {
         
final bool full = itemList.isNotEmpty;
    return full?
           Container(
        height: 700,
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(4.0),
          childAspectRatio: 8.0 / 7.5,
          children: itemList
              .map(
                // ignore: non_constant_identifier_names
                (Item) => ItemList(item: Item),
              )
              .toList(),
        )):Container(child:Center(child:Text("No posts Yet")));
  }

  /*return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: ListView(children: <Widget>[
          Container(
            height: 150,
            child: CarouselScreen(),
          ),
          Container(
            height: 1000,
            padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(30, 130)),
                  color: Colors.grey[300],
                )),
                gridView(),
              ],
            ),
          )
        ]));
  }

  Widget gridView() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(4.0),
      childAspectRatio: 8.0 / 7.5,
      children: itemList
          .map(
            // ignore: non_constant_identifier_names
            (Item) => ItemList(item: Item),
          )
          .toList(),
    );
  }
*/
 /* List<Item> _itemList() {
    return [
      Item(
          id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
         id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'Notre aventure avec les invertisseurs',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
    ];
  }*/
}
