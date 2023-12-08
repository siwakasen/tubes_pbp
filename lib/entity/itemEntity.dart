import 'dart:convert';

class Item {
  int id;
  String name;
  int price;
  String photo;
  String size;
  int id_type;

  Item(
      {this.id = 0,
      required this.name,
      required this.price,
      required this.photo,
      required this.size,
      required this.id_type});

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        photo: json['photo'],
        size: json['size'],
        id_type: json['id_type'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'photo': photo,
        'size': size,
        'id_type': id_type,
      };
}
