import 'dart:convert';

import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';

class MakananClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<Makanan>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Makanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAll2() async {
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

  static Future<Response> create(Makanan makanan) async {
    try {
      print(makanan.namaFoto);
      var response = await post(Uri.http(url, '$endpoint/makanans'),
          headers: {'Content-Type': 'application/json'},
          body: makanan.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Makanan> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Makanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Makanan makanan, int id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/makanans/$id'),
          headers: {'Content-Type': 'application/json'},
          body: makanan.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Makanan> deleteMakanan(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Makanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
