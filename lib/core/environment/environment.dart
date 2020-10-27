import 'package:flutter/foundation.dart';

@immutable
class Environment {
  final String baseUrl;
  final String appTitle;

  const Environment({@required this.baseUrl, @required this.appTitle})
      : assert(baseUrl != null),
        assert(appTitle != null);
}
