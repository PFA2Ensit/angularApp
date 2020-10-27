
import 'package:comptabli_blog/app/shared_widgets/compta_card.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/i18n/translations.dart';
import 'package:flutter/material.dart';

class DeclarationsWidget extends StatelessWidget {
  const DeclarationsWidget({
    Key key,
    @required this.translation,
  }) : super(key: key);

  final Translations translation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            translation.text("Home.declaration.title"),
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: kColorBlack),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ComptaCard(
              backgournd: kColorGrey,
              cutSize: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            translation.text("Home.declaration.month"),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: kColorWhite),
                          ),
                          Text(
                            "Février 2020",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: kColorWhite),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(width: 3.0, color: kColorWhite),
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            translation.text("Home.topay") + ' 1500 DT',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: kColorWhite),
                          ),
                          Text(
                            translation.text("Home.deadline") + "28/03/2020",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: kColorWhite),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
