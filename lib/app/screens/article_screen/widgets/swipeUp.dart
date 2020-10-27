import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:flutter/material.dart';

import 'package:swipe_up/swipe_up.dart';

import 'GridItemDetails.dart';

class SwipeUpExample extends StatefulWidget {
  final Item item;
  const SwipeUpExample(this.item);
  @override
  _SwipeUpExampleState createState() => _SwipeUpExampleState();
}

class _SwipeUpExampleState extends State<SwipeUpExample> {
  @override
  Widget build(BuildContext context) {
    return SwipeUp(
        color: Colors.white,
        sensitivity: 0.5,
        onSwipe: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => GridItemDetails(widget.item)));
        },
        body: Material(
            child: new Stack(
          children: <Widget>[
            
              new Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(
          widget.item.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
              /*decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(widget.item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),*/
            
            new Column(
              children: <Widget>[
                new Container(
                  height: 220,
                ),
                new Center(
                    child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: new Text(
                    widget.item.name,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                )),
                new Container(
                  height: 50,
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: widget.item.category.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SetTagsItem(widget.item.category[index]);
                      }),
                ),
                new Container(
                  height: 150,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.asset(widget.item.imageUrl),
                    )),
                    new Text('Par ' + widget.item.username,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            )
          ],
        )),
        child: Material(
            color: Colors.transparent,
            child: Text('Swipe Up', style: TextStyle(color: Colors.white))));
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.greenAccent,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('UP', style: TextStyle(color: Colors.white, fontSize: 94.0)),
          Text('YOU', style: TextStyle(color: Colors.white, fontSize: 166.0)),
          Text('SWIPED!', style: TextStyle(color: Colors.white, fontSize: 94.0))
        ],
      )),
    );
  }
}
