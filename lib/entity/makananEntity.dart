import 'dart:convert';

class Makanan {
  int? id;
  String? namaMakanan;
  int? hargaMakanan;
  String? namaFoto;

  Makanan({this.id = 0, this.namaMakanan, this.hargaMakanan, this.namaFoto});

  factory Makanan.fromRawJson(String str) => Makanan.fromJson(json.decode(str));
  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
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
