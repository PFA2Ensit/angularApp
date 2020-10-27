
import 'package:comptabli_blog/app/modules/auth/bloc/auth_bloc.dart';
import 'package:comptabli_blog/app/modules/auth/bloc/auth_state.dart';
import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_routes.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is Unauthenticated) {
          //navigate to tutorial
          Navigator.of(context).pushNamedAndRemoveUntil(
              kTutoRoute, (Route<dynamic> route) => false);
        }
        if (state is Authenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              kHomeRoute, (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                    height: 100,
                    width: 100,
                    child: AppLogo(
                      dark: true,
                    )),
                Container(
                    child: Text(
                  'Comptabli.',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: kColorBlack),
                )),
                Container(
                    child: Text(
                  'Votre comptable de poche',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: kColorGrey),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
