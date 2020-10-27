import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:comptabli_blog/app/themes/constants.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController textController;
  final Function validator;
  final Function onChanged;

  const CustomInputField({
     this.label,
    @required this.prefixIcon,
    this.validator,
    this.onChanged,
    this.textController,
    this.obscureText = false,
  })  : //assert(label != null),
        assert(prefixIcon != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 370.0,
        child: TextFormField(
          style: TextStyle(
        color: Colors.black,
    ),
          decoration: InputDecoration(
            //contentPadding: const EdgeInsets.all(kPaddingM),
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: label,
            hintStyle: TextStyle(
              color: kColorBlack.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: kColorBlack.withOpacity(0.5),
            ),
          ),
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
        ));
  }
}
