import 'package:flutter/material.dart';

import 'choice.dart';

// ignore: must_be_immutable
class GridViewItem extends StatefulWidget {
  Choice choice;
  static List<String> selectedIcons = [];
  Color iconColor = Colors.black;
  Color fill = Colors.white;

  GridViewItem(this.choice);

  @override
  _GridViewItemState createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    /*return SizedBox(
        width: double.infinity,
        height: 5000,
        child: RawMaterialButton(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Icon(
                  widget.choice.iconData,
                  color: widget.iconColor,
                  size: 46.0,
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    //padding: EdgeInsets.fromLTRB(5, 8, 5, 5),
                    child: Text(
                      widget.choice.text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    )),
              ],
            ),

            //padding: EdgeInsets.all(5.0),
            fillColor: widget.fill,
            //shape: RoundedRectangleBorder(),
            onPressed: () {
              setState(() {
                widget.iconColor = Colors.orange[200];
              });

              GridViewItem.selectedIcons.add(widget.choice.text);
              print(GridViewItem.selectedIcons.toString());
            }));
  }*/

    return InkWell(
      onTap: () {
        setState(() {
          widget.iconColor = Colors.orange[200];
        });

        GridViewItem.selectedIcons.add(widget.choice.text);
        print(GridViewItem.selectedIcons.toString());
      },
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Icon(
                widget.choice.iconData,
                color: widget.iconColor,
                size: 40.0,
                //fit: BoxFit.cover,
              ),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.choice.text,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
