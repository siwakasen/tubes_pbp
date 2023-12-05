import 'dart:convert';
import 'dart:ffi';

import 'package:ugd2_pbp/entity/makananEntity.dart';

class Order {
  int? id;
  List<Makanan>? listMakanan;
  int? totalHarga;
  int? rating;
  String? progress;

  Order(
      {this.id = 0,
      this.listMakanan,
      this.totalHarga,
      this.rating,
      this.progress});

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));
  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        listMakanan: json['namaMakanan'],
        totalHarga: json['hargaMakanan'],
        rating: json['namaFoto'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'namaMakanan': listMakanan,
        'hargaMakanan': totalHarga,
        'namaFoto': rating,
      };
}
