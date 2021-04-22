import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String uri = 'secure.styret.com';

class AuthModel extends Model {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  bool inputMatches = true;
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

  Future<http.Response> authRequest() async {
    print('authRequest');
    return http.post(Uri.https(uri, 'api/auth/login'),
        body: {"email": email, "password": password});
  }

  Future<User> fetchUser() async {
    print('fetchUser');
    final response = await authRequest();
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      inputMatches = false;
      update();
      return null;
    }
  }

  Future<void> fetchProperties() async {
    List<Property> list = [];
    print('fetch Properties');
    final response = await http.get(
        Uri.https(uri, 'api/users/${user.id}/properties'),
        headers: {'token': '${user.token}'});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> props = jsonDecode(response.body)['properties'];
      props.forEach((element) {
        list.add(Property.fromMap(element));
      });
      user.properties = list;
    }
    print('properties fetched');
  }

  Future<void> onLoginPressed() async {
    inputMatches = true;
    update();
    if (_emailIsCorrect &&
        _passwordIsCorrect &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      email = emailController.text;
      password = passwordController.text;
    } else {
      _emailIsCorrect = false;
      _passwordIsCorrect = false;
      update();
      return;
    }
    user = await fetchUser();
    if (user != null) {
      user.printInfo();
    } else {
      print("User is null");
    }
  }

  void update() {
    notifyListeners();
  }
}

AuthModel authModel = AuthModel();
