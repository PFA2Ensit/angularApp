
import 'package:comptabli_blog/app/modules/auth/bloc/auth_bloc.dart';
import 'package:comptabli_blog/app/modules/auth/bloc/auth_event.dart';
import 'package:comptabli_blog/app/modules/auth/bloc/auth_state.dart';
import 'package:comptabli_blog/app/shared_widgets/compta_input.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidateForm = false;

  _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        LogIn(
          password: _passwordController.text,
          email: _emailController.text,
        ),
      );
    } else {
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _formKey.currentState.validate();
        _autoValidateForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(context, kHomeRoute, (_) => false);
        }
        if (state is LoginFailed) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
     child:  Form(
        key: _formKey,
        autovalidate: _autoValidateForm,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ComptaInput(
                    labelText: 'Email',
                    textController: _emailController,
                    validator: ValidatorService.validateEmail,
                    onInputTap: () => {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ComptaInput(
                    labelText: 'Mot de passe',
                    textController: _passwordController,
                    isPassword: true,
                    validator: ValidatorService.validatePassword,
                    onInputTap: () => {},
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(kForgetPwRoute);
                  },
                  child: Text(
                    "j'ai oublié mon mot de passe.",
                    style: TextStyle(
                      color: kColorGrey,
                      decoration: TextDecoration.underline,
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
                          borderRadius: BorderRadius.circular(3)),
                      onPressed: () {
                        _onLoginButtonPressed();
                        //print("created");
                      },
                      child: Text(
                        "Se connecter".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: kColorWhite),
                      ),
                      color: kColorGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
