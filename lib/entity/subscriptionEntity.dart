import 'dart:convert';
//import 'dart:ffi';
// import 'dart:ffi';

class Subscription {
  int id;
  String name;
  int price;
  int percentage;

  Subscription(
      {required this.id,
      required this.name,
      required this.price,
      required this.percentage});

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));
  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        percentage: json['percentage'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'percentage': percentage,
      };
}
