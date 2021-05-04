import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String uri = 'secure.styret.com';

class AuthModel extends Model {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
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

  Future<void> logout() async {
    user = null;
    await secureStorage.deleteAll();
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

  int fetchCounter = 0;
  Future<bool> fetchProperties() async {
    fetchCounter++;
    if (fetchCounter > 2) {
      fetchCounter = 0;
      return false;
    }
    List<Property> list = [];
    print('fetch Properties');
    final response = await http
        .get(Uri.https(uri, 'api/users/${user.id}/properties'), headers: {
      'token': '${user.token}',
      'X-Requested-With': 'XMLHttpRequest'
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> props = jsonDecode(response.body)['properties'];
      props.forEach((element) {
        list.add(Property.fromMap(element));
      });
      user.properties = list;
      fetchCounter = 0;
      return true;
    }
    if (response.statusCode == 403) {
      print('403 Invalid token');
      user = await fetchUser();
      await fetchProperties();
    } else {
      return false;
    }
    print('properties fetched');
    return false;
  }

  Future<void> onLoginPressed() async {
    //hide banner
    inputMatches = true;
    update();
    if (_emailIsCorrect &&
        _passwordIsCorrect &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      email = emailController.text;
      password = passwordController.text;
    } else {
      _validateInputs();
      return;
    }
    user = await fetchUser();
    if (user != null) {
      user.printInfo();
      _writeUserToStorage(user);
    } else {
      print("User is null");
    }
  }

  void _validateInputs() {
    if (!_emailIsCorrect || emailController.text.isEmpty) {
      _emailIsCorrect = false;
    }
    if (!_passwordIsCorrect || passwordController.text.isEmpty) {
      _passwordIsCorrect = false;
    }
    update();
  }

  void _writeUserToStorage(User user) async {
    await secureStorage.deleteAll();
    await secureStorage.write(key: 'id', value: '${user.id}');
    await secureStorage.write(key: 'name', value: '${user.name}');
    await secureStorage.write(key: 'email', value: '${user.email}');
    await secureStorage.write(key: 'phone', value: '${user.phone}');
    await secureStorage.write(key: 'token', value: '${user.token}');
    await secureStorage.write(key: 'password', value: password);
    print('User data saved');
  }

  void update() {
    notifyListeners();
  }
}

AuthModel authModel = AuthModel();
