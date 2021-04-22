import 'package:flutter/material.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/utilites/strings.dart';
import 'package:flutter_styret_app/widgets/button.dart';
import 'package:flutter_styret_app/widgets/textInputField.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double paddingTop;
  @override
  Widget build(BuildContext context) {
    paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: ScopedModel<AuthModel>(
        model: authModel,
        child:
            ScopedModelDescendant<AuthModel>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //logo
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 60 + paddingTop),
                  child: Image.asset('assets/images/styret_logo.png',
                      height: 140, width: 150),
                ),
                //spacing
                Container(height: 60),
                //Email input
                inputForm(
                    context: context,
                    title: kEmail,
                    isEmail: true,
                    validationMsg: 'Email is invalid',
                    controller: authModel.emailController,
                    textInputAction: TextInputAction.next,
                    inFocus: authModel.emailInFocus,
                    state: authModel.emailIsCorrect,
                    onTap: () {
                      authModel.emailInFocus = true;
                      authModel.passwordInFocus = false;
                    },
                    onInputSubmitted: (val) {
                      authModel.emailInFocus = false;
                      authModel.passwordInFocus = true;
                    },
                    onInputChanged: (val, text) {
                      authModel.emailIsCorrect = val;
                    }),
                //spacing
                Container(height: 23),
                //Password input
                inputForm(
                    context: context,
                    title: kPassword,
                    validationMsg: 'Password is invalid',
                    controller: authModel.passwordController,
                    textInputAction: TextInputAction.done,
                    pattern: r'^[A-Z]?[a-z]+$',
                    obscure: true,
                    inFocus: authModel.passwordInFocus,
                    state: authModel.passwordIsCorrect,
                    onInputSubmitted: (val) {
                      authModel.passwordInFocus = false;
                    },
                    onTap: () {
                      authModel.passwordInFocus = true;
                      authModel.emailInFocus = false;
                    },
                    onInputChanged: (val, text) {
                      authModel.passwordIsCorrect = val;
                    }),
                //spacing
                Container(height: 60),
                //LOGIN button
                button(
                    title: kLogin,
                    context: context,
                    onTap: () {
                      authModel.onLoginPressed();
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
