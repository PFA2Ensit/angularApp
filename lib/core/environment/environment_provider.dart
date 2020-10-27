import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'environment.dart';

class EnvironmentProvider extends StatelessWidget {
  final Environment env;
  final Widget child;

  const EnvironmentProvider({@required this.env, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Provider<Environment>.value(
      value: env,
      child: child,
      updateShouldNotify: (_, __) => false,
    );
  }
}
