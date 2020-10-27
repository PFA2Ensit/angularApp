import 'package:flutter/material.dart';

class ChipsField extends StatefulWidget {
  @override
  _ChipsFieldState createState() => new _ChipsFieldState();
}

class _ChipsFieldState extends State<ChipsField> {
  int count = 1;
  bool isClicked;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
    isClicked = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget ContactRow() {
    void _addNewContactRow() {
      setState(() {
        //isClicked = true;
        count = count + 1;
        isClicked = false;
      });
    }

    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Chip(
            onDeleted: () {
              setState(() {
                count = count - 1;
              });
            },
            deleteIcon: isClicked
                ? Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
            backgroundColor: Colors.black,
            avatar: isClicked
                ? null
                : Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: _addNewContactRow,
                    ),
                  ),
            label: EditableText(
              controller: controller,
              focusNode: FocusNode(),
              backgroundCursorColor: Colors.white,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            ),
          ),
          new Container(
              //padding: new EdgeInsets.all(10.0),
              child: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed:
                      _addNewContactRow) /*RaisedButton(
                  child: Icon(Icons.add), onPressed: _addNewContactRow)*/
              ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _chips = new List.generate(count, (int i) => ContactRow());
    print(count);
    return new Scaffold(body: new LayoutBuilder(builder: (context, constraint) {
      return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(20.0),
            ),
            new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                border: Border.all(
                  width: 3,
                ),
              ),
              height: 130.0,
              width: 350.0,
              child: new ListView(
                children: _chips,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      );
    }));
  }
}
