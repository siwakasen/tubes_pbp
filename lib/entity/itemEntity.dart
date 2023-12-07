import 'dart:convert';

class Item {
  int? id;
  String? namaMakanan;
  int? hargaMakanan;
  String? namaFoto;

  Item({this.id = 0, this.namaMakanan, this.hargaMakanan, this.namaFoto});

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        namaMakanan: json['namaMakanan'],
        hargaMakanan: json['hargaMakanan'],
        namaFoto: json['namaFoto'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'namaMakanan': namaMakanan,
        'hargaMakanan': hargaMakanan,
        'namaFoto': namaFoto,
      };
}
