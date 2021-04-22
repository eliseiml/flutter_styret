import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthModel extends Model {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _emailIsCorrect = true;
  bool _passwordIsCorrect = true;
  bool _emailInFocus = false;
  bool _passwordInFocus = false;

  bool get emailIsCorrect => _emailIsCorrect;
  bool get passwordIsCorrect => _passwordIsCorrect;
  bool get emailInFocus => _emailInFocus;
  bool get passwordInFocus => _passwordInFocus;

  set emailIsCorrect(bool val) {
    _emailIsCorrect = val;
    update();
  }

  set passwordIsCorrect(bool val) {
    _passwordIsCorrect = val;
    update();
  }

  set emailInFocus(bool val) {
    _emailInFocus = val;
    update();
  }

  set passwordInFocus(bool val) {
    _passwordInFocus = val;
    update();
  }

  void onLoginPressed() {}

  void update() {
    notifyListeners();
  }
}

AuthModel authModel = AuthModel();
