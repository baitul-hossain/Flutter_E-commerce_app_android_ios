
import 'package:a_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 24.0
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? 'Hint text..',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0
          )
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
