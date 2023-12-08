import 'dart:convert';

class Restaurant {
  final int id;
  final String name;
  final String address;
  final String city;
  final String postalCode;
  final String openingHours;
  final String closedHours;

  Restaurant(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.postalCode,
      required this.openingHours,
      required this.closedHours});

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        city: json['city'],
        postalCode: json['postalCode'],
        openingHours: json['openingHours'],
        closedHours: json['closedHours'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'city': city,
        'postalCode': postalCode,
        'openingHours': openingHours,
        'closedHours': closedHours,
      };
}
