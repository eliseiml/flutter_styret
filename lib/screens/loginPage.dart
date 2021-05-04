import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/screens/propertiesPage.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';
import 'package:flutter_styret_app/widgets/button.dart';
import 'package:flutter_styret_app/widgets/textInputField.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double paddingTop;

  void _onLogin() async {
    await authModel.onLoginPressed();
    if (user != null) {
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PropertiesPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: ScopedModel<AuthModel>(
        model: authModel,
        child:
            ScopedModelDescendant<AuthModel>(builder: (context, model, child) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              //Screen content
              SingleChildScrollView(
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
                        title: S.of(context).kEmail,
                        isEmail: true,
                        validationMsg: S.of(context).kInvalidEmail,
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
                        title: S.of(context).kPassword,
                        validationMsg: S.of(context).kInalidPassword,
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
                        title: S.of(context).kLogin,
                        context: context,
                        onTap: () {
                          _onLogin();
                        })
                  ],
                ),
              ),
              //Wrong data banner
              topNotificationBanner(context),
            ],
          );
        }),
      ),
    );
  }

  Widget topNotificationBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        authModel.inputMatches = true;
        authModel.update();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        height: authModel.inputMatches ? 0 : 40,
        //width: screenWidth,
        color: kAttentionColor,
        margin: EdgeInsets.only(top: paddingTop),
        padding: EdgeInsets.only(left: 20, right: 20),
        duration: Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).kWrongInputNotification,
                style: kNotificationTextStyle),
            Icon(Icons.close, color: kButtonTextColor)
          ],
        ),
      ),
    );
  }
}
