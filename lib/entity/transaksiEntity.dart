import 'dart:convert';

class Transaksi {
  late int id;
  late int id_user;
  int? id_restaurant;
  int? id_voucher;
  String? address_on_trans;
  int? subtotal;
  int? delivery_fee;
  int? order_fee;
  double? total;
  String? status;
  String? paymentMethod;
  String? datetime;

  Transaksi(
      {this.id = -1,
      required this.id_user,
      required this.id_restaurant,
      this.id_voucher,
      required this.address_on_trans,
      required this.subtotal,
      required this.delivery_fee,
      required this.order_fee,
      this.total,
      required this.status,
      this.paymentMethod,
      this.datetime});

  factory Transaksi.fromRawJson(String str) =>
      Transaksi.fromJson(json.decode(str));
  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
      id: json['id'],
      id_user: json['id_user'],
      id_restaurant: json['id_restaurant'],
      id_voucher: json['id_voucher'],
      address_on_trans: json['address_on_trans'],
      subtotal: json['subtotal'],
      delivery_fee: json['delivery_fee'],
      order_fee: json['order_fee'],
      total: json['total'].toDouble(),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      datetime: json['datetime']);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'id_restaurant': id_restaurant,
        'id_voucher': id_voucher,
        'address_on_trans': address_on_trans,
        'subtotal': subtotal,
        'delivery_fee': delivery_fee,
        'order_fee': order_fee,
        'total': total,
        'status': status,
        'paymentMethod': paymentMethod,
        'datetime': datetime,
      };
  double countTotal(int voucherCut, int subsPercent, int? subtotal,
      int? delivery_fee, int? order_fee) {
    total = (subtotal! + delivery_fee! + order_fee!).toDouble();
    total = total! - voucherCut;
    total = total! - (total! * (subsPercent / 100));
    if (total! < 0) {
      total = 0;
    }
    return total!;
  }
}
