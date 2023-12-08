import 'dart:convert';

class ItemType {
  int id;
  String name;
  String? customize;

  ItemType({
    this.id = 0,
    required this.name,
    required this.customize,
    // ignore: non_constant_identifier_names
  });

  factory ItemType.fromRawJson(String str) =>
      ItemType.fromJson(json.decode(str));
  factory ItemType.fromJson(Map<String, dynamic> json) => ItemType(
        id: json['id'],
        name: json['name'],
        customize: json['customize'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'customize': customize,
      };
}
