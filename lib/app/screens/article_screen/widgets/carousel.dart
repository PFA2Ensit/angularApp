import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'carouselList.dart';

// ignore: must_be_immutable
class CarouselScreen extends StatelessWidget {
  List<Item> itemList;
  CarouselScreen({this.itemList});

  @override
  Widget build(BuildContext context) {
  
final bool full = itemList.isNotEmpty;
    return full? Container(
        height: 150,
        child: CarouselSlider(
            items: itemList
                .map(
                  (Item) => CarouselList(item: Item),
                )
                .toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              //enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ))):Container(child:Center(child:Text("No posts Yet",style: TextStyle(color:kColorBlack),)));
  }

  /*List<Item> _itemList() {
    return [
      Item(
          id: 0,
          name: 'HOW TO,CREATE A,COMPANY',
          text: 'article content',
          writer: 'Riadh Ellouze',
         timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'HOW TO,CREATE A,COMPANY',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'HOW TO,CREATE A,COMPANY',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'HOW TO,CREATE A,COMPANY',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
      Item(
          id: 0,
          name: 'HOW TO,CREATE A,COMPANY',
          text: 'article content',
          writer: 'Riadh Ellouze',
          timestamp: '27 April 2018',
          position: 'CEO @ LOGIS',
          imageUrl: 'assets/images/ic_preview_3.png',
          imageWriter: 'assets/images/ic_preview_3.png'),
    ];
  }*/
}
