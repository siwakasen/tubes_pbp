import 'dart:convert';

class Rating {
  int? id;
  int? id_transaksi;
  int? stars;
  String? notes;

  Rating({this.id, this.id_transaksi = 0, this.stars, this.notes});

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json['id'],
        id_transaksi: json['id_transaksi'],
        stars: json['stars'],
        notes: json['notes'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_transaksi': id_transaksi,
        'stars': stars,
        'notes': notes,
      };
}
