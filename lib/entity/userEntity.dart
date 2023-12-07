import 'dart:convert';

class User {
  late int id;
  String username;
  String password;
  String name;
  String email;
  String phoneNumber;
  String address;
  String bornDate;
  String photo;
  int id_restaurant;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.bornDate,
      required this.phoneNumber,
      required this.photo,
      required this.id_restaurant});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      address: json['address'],
      bornDate: json['bornDate'],
      phoneNumber: json['phoneNumber'],
      photo: json['photo'],
      id_restaurant: json['id_restaurant']);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'name': name,
        'address': address,
        'bornDate': bornDate,
        'phoneNumber': phoneNumber,
        'photo': photo,
        'id_restaurant': id_restaurant
      };
}
