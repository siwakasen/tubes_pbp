import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';

class TransaksiClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<Transaksi>> fetchAll() async {
    print("get data trans");
    try {
      var response = await get(Uri.http(url, '$endpoint/transactions'));

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

  static Future<List<Transaksi>> fetchSuccessOnly() async {
    print("get data trans success");
    try {
      var response = await get(Uri.http(url, '$endpoint/transactions/success'));

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

  static Future<Response> create(Transaksi trans) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/transactions'),
          headers: {'Content-Type': 'application/json'},
          body: trans.toRawJson());
      print(response);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Transaksi> find(id) async {
    print("finding trans");
    try {
      var response = await get(Uri.http(url, '$endpoint/transactions/$id'));
      print(response.body);

      return Transaksi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Transaksi transaksi, id) async {
    try {
      var response = await put(
          Uri.http(url, '$endpoint/transactions/status/$id'),
          headers: {'Content-Type': 'application/json'},
          body: transaksi.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
