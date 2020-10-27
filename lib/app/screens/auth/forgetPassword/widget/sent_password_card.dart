import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class SentPwCard extends StatefulWidget {
  const SentPwCard({
    Key key,
  }) : super(key: key);

  @override
  _SentPwCardState createState() => _SentPwCardState();
}

class _SentPwCardState extends State<SentPwCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image(
                  width: 100,
                  image: AssetImage(
                    'images/sent.png',
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Veuillez vérifier la boite de reception  de votre adresse électronique pour pouvoir restaurer votre mote de passe",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: kColorblue,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(3)),
                  onPressed: () {},
                  child: Text(
                    "Se connecter".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: kColorWhite),
                  ),
                  color: kColorblue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
