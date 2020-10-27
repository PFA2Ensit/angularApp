import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:flutter/material.dart';

class CarouselList extends StatelessWidget {
  final Item item;
  

  const CarouselList({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.symmetric(horizontal: 0.0),
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
              color: Colors.black,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 70,
                    /*Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),*/
                  ),
                  Container(
                    color: Colors.black,
                    margin: EdgeInsets.only(right: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'HOW TO ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.name.replaceAll(' ', '\n'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Les Etapes pas à pas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          new Container(
              padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 2.0),
              child: Column(
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                     DateTime.parse(item.timestamp
                                        .toDate()
                                        .toString())
                                    .toString(),
                    
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
