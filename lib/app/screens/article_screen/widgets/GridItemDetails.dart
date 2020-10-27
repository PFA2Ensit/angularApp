import 'dart:convert';
import 'package:share/share.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class GridItemDetails extends StatelessWidget {
  final Item item;

  GridItemDetails(this.item);

  _onShare(BuildContext context) async {
    
    final RenderBox box = context.findRenderObject();

    
      await Share.share( NotusDocument.fromJson(jsonDecode(item.text))
                                .toString(),
          subject: "subject",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      primary: true,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          item.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          HeaderBanner(this.item),
          GetTags(this.item),
          Container(
            height: 500,
            padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 20.0),
            child: ZefyrView(
              document: NotusDocument.fromJson(jsonDecode(item.text)),
            ), /*Text(
              item.text.toString(),
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
            ),*/
          ),
          Container(
            height: 100,
          ),
          new Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.share),
                      onPressed: 
                        
                             () => _onShare(context),
                      
                    ),
                    Text(
                      "Partage",
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
              ),
              Container(
                width: 30,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    Text(
                      "Aime",
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
              )
            ],
          )),
        ],
      ),
    );
  }
}




// ignore: must_be_immutable
class GetTags extends StatelessWidget {
  Item item;
  GetTags(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
      height: 35.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(5),
          itemCount: item.category.length,
          itemBuilder: (BuildContext context, int index) {
            return SetTagsItem(item.category[index]);
          }),
    );
  }
}

class SetTagsItem extends StatelessWidget {
  final String tag;

  SetTagsItem(this.tag);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 45.0,
      margin: EdgeInsets.only(
        left: 6.0,
        right: 9.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        //border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(
          tag,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }
}

class HeaderBanner extends StatelessWidget {
  final Item item;

  HeaderBanner(this.item);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white10,
      elevation: 0.0,
      child: Container(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            /*CircleAvatar(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.network(item.imageWriter),
            )),*/
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(item.username),
                Text(item.position),
              ],
            ),
            Text(
              DateTime.parse(item.timestamp.toDate().toString()).toString(),
            )
          ],
        ),
      ),
    );
  }
}
