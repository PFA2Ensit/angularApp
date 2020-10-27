
import 'package:comptabli_blog/app/screens/auth/signup/widget/signup_form.dart';
import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
            child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: kColorWhite,
              leading: BackButton(
                color: kColorBlack,
              ),
              pinned: false,
              snap: false,
              floating: false,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: <Widget>[
                  
                  AppLogo(
                    dark: true,
                  ),
                ],
              )),
            ),
            SliverFillRemainingBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Inscription.",
                              style: Theme.of(context).textTheme.headline2,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                "Inscrivez vous a Comptabli.® et profitez de toutes les fonctionnalités de l’application.",
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SignUpForm(),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Vous avez déja un compte ?",
                          style: TextStyle(color: kColorGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            shape: BeveledRectangleBorder(
                                side: BorderSide(
                                    color: kColorWhite,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Se connecter".toUpperCase(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            color: kColorWhite,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        )),
      ),
    );
  }
}
