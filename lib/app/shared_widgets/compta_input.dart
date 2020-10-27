
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/app/themes/icons.dart';
import 'package:flutter/material.dart';

class ComptaInput extends StatefulWidget {
  final TextEditingController textController;
  final String labelText;
  final TextCapitalization textCapitalization;
  final String customValidationError;
  final Function onInputTap;
  final Function validator;
  final bool isPassword;
  final bool enabled;
  final TextInputType keyboardType;
  final int maxLines;
  final bool floating;
  final String hintText;
  final TextInputAction textInputAction;
  final Icon suffixIcon;
  final Function onIconTap;
  final Function onSubmitted;

  final bool autofocus;
  const ComptaInput(
      {Key key,
      this.validator,
      this.onSubmitted,
      this.keyboardType,
      this.textController,
      this.textCapitalization = TextCapitalization.none,
      this.labelText = "",
      this.isPassword = false,
      this.customValidationError,
      this.onInputTap,
      this.enabled = true,
      this.autofocus = false,
      this.maxLines = 1,
      this.floating = true,
      this.hintText = "",
      this.textInputAction = TextInputAction.done,
      this.suffixIcon,
      this.onIconTap})
      : super(key: key);

  @override
  _ComptaInputState createState() => _ComptaInputState();
}

class _ComptaInputState extends State<ComptaInput> {
  bool isObscure = false;
  String validationError = '';
  @override
  void initState() {
    super.initState();
    isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.height * 0.005;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              onEditingComplete: widget.onSubmitted,
              autofocus: widget.autofocus,
              maxLines: widget.maxLines,
              obscureText: isObscure,
              keyboardType: widget.keyboardType == null
                  ? TextInputType.text
                  : widget.keyboardType,
              readOnly: !widget.enabled,
              style: TextStyle(fontSize: 16, color: kColorBlack),
              controller: widget.textController
                ..selection = TextSelection.collapsed(
                    offset: widget.textController.text.length),
              onTap: (widget.onInputTap != null)
                  ? () {
                      widget.onInputTap();
                    }
                  : null,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                errorStyle: TextStyle(fontSize: 12),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: kColorBlack, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: kColorBlack, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: kColorBlack, width: 2.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                hintText: widget.hintText,
                suffixIcon: widget.isPassword
                    ? _buildTogglePasswordBtn()
                    : widget.suffixIcon != null ? _buildToggleIconBtn() : null,
                labelText: widget.labelText != null ? widget.labelText : '',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              validator: (value) {
                if (widget.validator != null) {
                  String error = widget.validator(widget.textController.text);
                  setState(() {
                    if (error == null && widget.customValidationError != null) {
                      validationError = widget.customValidationError;
                    } else {
                      validationError = error;
                    }
                  });
                  return error;
                }
                setState(() {
                  validationError = null;
                  if (widget.customValidationError != null) {
                    validationError = widget.customValidationError;
                  }
                });
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildTogglePasswordBtn() {
    return IconButton(
      padding: EdgeInsets.all(0),
      splashColor: Colors.transparent,
      onPressed: () => setState(() {
        isObscure = !isObscure;
      }),
      icon: Icon(
        widget.isPassword
            ? isObscure ? CustomIcons.eye : CustomIcons.eye_off
            : null,
        color: kColorBlack,
      ),
    );
  }

  _buildToggleIconBtn() {
    return IconButton(
      padding: EdgeInsets.all(0),
      splashColor: Colors.transparent,
      onPressed: () => widget.onIconTap(),
      icon: widget.suffixIcon,
    );
  }
}
