import 'package:comptabli_blog/app/shared_widgets/compta_input.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class ForgetPwForm extends StatefulWidget {
  const ForgetPwForm({
    Key key,
  }) : super(key: key);

  @override
  _ForgetPwFormState createState() => _ForgetPwFormState();
}

class _ForgetPwFormState extends State<ForgetPwForm> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ComptaInput(
            labelText: 'Email',
            textController: _emailController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: kColorGrey, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(3)),
                onPressed: () {},
                child: Text(
                  "Envoyer".toUpperCase(),
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
    );
  }
}
