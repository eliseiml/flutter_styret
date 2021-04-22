import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

Widget inputForm(
    {BuildContext context,
    String title,
    String hintText,
    String validationMsg,
    bool obscure = false,
    bool inFocus = false,
    bool isEmail = false,
    TextEditingController controller,
    TextInputAction textInputAction,
    void onTap(),
    void onInputSubmitted(String value),
    @required bool state,
    Pattern pattern,
    void onInputChanged(bool value, String text)}) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Text(title,
            style: inFocus
                ? kActiveInputTitleTextStyle
                : kInactiveInputTitleTextStyle),
        //Input filed
        Container(
          height: 30,
          padding: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: controller,
            textInputAction: textInputAction,
            onFieldSubmitted: onInputSubmitted,
            onTap: onTap,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            style: kInputTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none),
            obscureText: obscure,
            onChanged: (value) {
              if (!isEmail) {
                RegExp regex = new RegExp(pattern);
                onInputChanged(regex.hasMatch(value), value);
              } else {
                onInputChanged(EmailValidator.validate(value), value);
              }
            },
          ),
        ),
        //bottom border
        Container(
          height: 1,
          color: state
              ? (inFocus ? kAccentColor : kInactiveColor)
              : kAttentionColor,
        ),
        //validation message
        state
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 3),
                child: Text(validationMsg, style: kValidationTextStyle),
              )
      ],
    ),
  );
}
