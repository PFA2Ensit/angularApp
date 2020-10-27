
import 'package:comptabli_blog/app/modules/auth/bloc/auth_bloc.dart';
import 'package:comptabli_blog/app/modules/auth/bloc/auth_event.dart';
import 'package:comptabli_blog/app/modules/auth/bloc/auth_state.dart';
import 'package:comptabli_blog/app/shared_widgets/compta_input.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_routes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidateForm = false;

  _onCreateButtonPressed() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignUp(
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
        if (state is SignUpFailed) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(context, kHomeRoute, (_) => false);
        }
      },
       child:Container(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidateForm,
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
                    onInputTap: () => {},
                    validator: ValidatorService.validatePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ComptaInput(
                    labelText: 'Confirmation',
                    textController: _confirmController,
                    isPassword: true,
                    onInputTap: () => {},
                    customValidationError:
                        ValidatorService.samePasswordValidation(
                            _confirmController.text, _passwordController.text),
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
                        _onCreateButtonPressed();
                      },
                      child: Text(
                        "Rejoindre".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: kColorWhite),
                      ),
                      color: kColorGrey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "En vous connectant, vous acceptez les CGU.",
                      style: TextStyle(
                        color: kColorGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
    
  }
}
