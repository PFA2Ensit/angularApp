import 'dart:ui';

import 'package:flutter/material.dart';

const Color kColorPrimaryBlue = Color(0xff01A0C7);
const Color kColorblue = Color(0xFF3282b8);
const Color kColorDarkblue = Color(0xFF0f4c75);
const Color kColorWhite = Colors.white;
const Color kColorLightBlue = Color(0xFFbbe1fa);
const Color kColorBackgroundDark = Color(0xFF1b262c);
const Color kColorDeepPurple = Colors.deepPurpleAccent;
const Color kColorBlack = Colors.black;
const Color kColorGrey = Colors.grey;
const kPrimaryGradient = LinearGradient(
  begin: Alignment.center,
  end: Alignment.bottomRight,
  stops: [0, 1],
  colors: [
    kColorDarkblue,
    kColorLightBlue,
  ],
);
  const String MostLiked = 'Most Liked';
   const String Recent = 'Recent posts';
  const String Old = 'Old posts';

  const List<String> choices = <String>[
    MostLiked,
    Recent,
    Old
  ];

  const List<String> actions = <String>[
    "edit profile",
    "view posts list",
    
  ];

  const String contact = 'Contactez';
// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

// Animation
const Duration kButtonAnimationDuration = Duration(milliseconds: 600);
const Duration kCardAnimationDuration = Duration(milliseconds: 400);
const Duration kRippleAnimationDuration = Duration(milliseconds: 400);
const Duration kLoginAnimationDuration = Duration(milliseconds: 1500);


ThemeData generatecomptabliTheme(BuildContext context) {
  final theme = Theme.of(context);
  return ThemeData(
      unselectedWidgetColor: kColorBlack,
      primaryColor: kColorBlack,
      secondaryHeaderColor: kColorBlack,
      accentColor: kColorGrey,
      backgroundColor: kColorPrimaryBlue,
      canvasColor: kColorWhite,
      disabledColor: kColorPrimaryBlue,
      textTheme: theme.textTheme.copyWith(
          headline2: TextStyle(
              fontSize: 42,
              letterSpacing: -1,
              fontWeight: FontWeight.w600,
              color: kColorBlack,
              fontStyle: FontStyle.italic),
          headline3: TextStyle(fontSize: 24),
          subtitle1: TextStyle(
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
              color: kColorGrey,
              fontStyle: FontStyle.italic)));
}

TextStyle searchTextStyle = TextStyle(color: Colors.black, fontSize: 22.0);
TextStyle hintStyle = TextStyle(color: Colors.black54, fontSize: 20.0);
