import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class ComptaCard extends StatelessWidget {
  final Widget child;
  final bool isCut;
  final Color backgournd;
  final double cutSize;
  const ComptaCard({
    this.child,
    this.isCut = true,
    Key key,
    this.backgournd = kColorWhite,
    this.cutSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgournd,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}
