import 'package:flutter_styret_app/domain/property.dart';

class User {
  int id;
  String name;
  String email;
  String phone;
  String token;
  List<Property> properties = [];

  User(this.id, this.name, this.email, this.phone, this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> tmpUser = json['user'];
    String tmpToken = json['token'];
    return User(tmpUser['id'], tmpUser['name'], tmpUser['email'],
        tmpUser['phone'], tmpToken);
  }

  void printInfo() {
    print('id: $id');
    print('Name: $name');
    print('email: $email');
    print('phone: $phone');
    print('token: $token');
  }
}

User user;
