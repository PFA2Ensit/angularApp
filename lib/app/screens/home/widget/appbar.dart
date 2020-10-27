import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class ComptaAppBar extends StatelessWidget {
  const ComptaAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: kColorBlack,
              ),
            ),
            Center(
              child: AppLogo(
                dark: true,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: kColorBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
