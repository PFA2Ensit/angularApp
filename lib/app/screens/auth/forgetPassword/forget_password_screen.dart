
import 'package:comptabli_blog/app/screens/auth/forgetPassword/widget/forget_password_form.dart';
import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';

class ForgetPwScreen extends StatelessWidget {
  const ForgetPwScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
            child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: kColorWhite,
              pinned: false,
              snap: false,
              leading: BackButton(
                color: kColorBlack,
              ),
              floating: false,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
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
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          "Mot de passe \nOublié",
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "Récupérez votre mot de passe.",
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      ForgetPwForm(),
                    ],
                  ),
                ],
              ),
            ))
          ],
        )),
      ),
    );
  }
}
