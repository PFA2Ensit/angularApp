
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/i18n/translations.dart';
import 'package:flutter/material.dart';

class Numbers extends StatefulWidget {
  final Translations translation;

  const Numbers({
    Key key,
    @required this.translation,
  }) : super(key: key);

  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> numbersList = [
      {
        "title": widget.translation.text('Numbers.title.employee'),
        "number": "1",
        "color": kColorBlack,
        "icon": Icons.people
      },
      {
        "title": widget.translation.text('Numbers.title.progress'),
        "number": "+ 10%",
        "color": kColorBlack,
        "icon": Icons.insert_chart
      },
      {
        "title": widget.translation.text('Numbers.title.income'),
        "number": "12000 DT",
        "color": kColorBlack,
        "icon": Icons.trending_up
      },
      {
        "title": widget.translation.text('Numbers.title.expenses'),
        "number": "8500 DT",
        "color": kColorBlack,
        "icon": Icons.trending_down
      }
    ];
    return Container(
      color: kColorWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.translation.text("Home.numbers"),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: kColorBlack),
              ),
            ),
            Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: numbersList[index]['color'],
                                  width: 2)),
                          width: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  numbersList[index]['icon'],
                                  color: numbersList[index]['color'],
                                  size: 40,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        numbersList[index]['number'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .copyWith(
                                              color: numbersList[index]
                                                  ['color'],
                                            ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        numbersList[index]['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                              color: numbersList[index]
                                                  ['color'],
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
