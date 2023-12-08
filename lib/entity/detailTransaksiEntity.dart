import 'dart:convert';

class DetailTransaksi {
  int id_transaksi;
  int id_item;
  int quantity;

  DetailTransaksi(
      {required this.id_transaksi,
      required this.id_item,
      required this.quantity});

  factory DetailTransaksi.fromRawJson(String str) =>
      DetailTransaksi.fromJson(json.decode(str));

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) =>
      DetailTransaksi(
        id_transaksi: json['id_transaksi'],
        id_item: json['id_item'],
        quantity: json['quantity'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_transaksi': id_transaksi,
        'id_item': id_item,
        'quantity': quantity,
      };
}
