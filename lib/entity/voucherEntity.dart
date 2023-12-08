import 'dart:convert';

class Voucher {
  int id;
  String name;
  int cut_price;

  Voucher({
    this.id = 0,
    required this.name,
    required this.cut_price,
  });
  Voucher.empty()
      : id = -1,
        name = '',
        cut_price = -1;
  factory Voucher.fromRawJson(String str) => Voucher.fromJson(json.decode(str));
  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json['id'],
        name: json['name'],
        cut_price: json['cut_price'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cut_price': cut_price,
      };
}
