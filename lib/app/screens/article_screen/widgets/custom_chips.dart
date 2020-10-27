import 'package:flutter/material.dart';

class InputChipExample extends StatefulWidget {
  @override
  _InputChipExampleState createState() => new _InputChipExampleState();
}

class _InputChipExampleState extends State<InputChipExample> {
  TextEditingController _textEditingController = new TextEditingController();
  List<String> _values = new List();
  List<bool> _selected = new List();

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  Widget buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        selected: _selected[i],
        label: Text(_values[i]),
        avatar: FlutterLogo(),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
          });
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            _values = _values;
            _selected = _selected;
          });
        },
      );

      chips.add(actionChip);
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            child: buildChips(),
          ),
          TextField(
              decoration: InputDecoration(hintText: 'Entrer catégories'),
              controller: _textEditingController,
              onSubmitted: (String str) {
                _values.add(_textEditingController.text);
                _selected.add(true);
                _textEditingController.clear();

                setState(() {
                  _values = _values;
                  _selected = _selected;
                });
              }),
        ],
      ),
    );
  }
}
