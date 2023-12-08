import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/voucherEntity.dart';

class VoucherClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<Voucher>> fetchAll() async {
    print("fetching voucher all");
    try {
      var response = await get(Uri.http(url, '$endpoint/voucher'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Voucher.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
