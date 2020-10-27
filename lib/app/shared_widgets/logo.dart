import 'package:flutter/widgets.dart';

class AppLogo extends StatelessWidget {
  final bool dark;
  const AppLogo({Key key, this.dark = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Image.asset(
        dark ? 'images/logo_dark.png' : 'images/Logo.png',
        height: 60,
      )),
    ));
  }
}
