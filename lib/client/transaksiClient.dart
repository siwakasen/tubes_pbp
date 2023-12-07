import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';

class RatingClient {
  static final String url = '192.168.100.211';
  static final String endpoint = 'tugbes/public/api';

  static Future<List<Transaksi>> fetchAll() async {
    print("fetching all");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Transaksi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAll2() async {
    print("fetching all 2");

    try {
      var response = await get(Uri.http(url, '$endpoint/makanans'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }

      Iterable list = json.decode(response.body)['data'];

      // Modify the mapping to Map<String, dynamic>

      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Transaksi transaksi, File photo) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/register'),
          headers: {'Content-Type': 'application/json'},
          body: transaksi.toRawJson());

      // Send the request
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Transaksi> find(id) async {
    print("finding rating");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Transaksi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
