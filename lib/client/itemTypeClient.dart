import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:ugd2_pbp/entity/itemTypeEntity.dart';

class ItemTypeClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<ItemType>> fetchAll() async {
    print("fetching type");
    try {
      var response = await get(Uri.http(url, '$endpoint/type_items'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => ItemType.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(ItemType item) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/register'),
          headers: {'Content-Type': 'application/json'},
          body: item.toRawJson());

      // Send the request
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<ItemType> find(id) async {
    print("finding makanan");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return ItemType.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //ini error
  static Future<void> update(ItemType makanan, id, File photo) async {
    try {
      print("update makanan");
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://$url$endpoint/makanans/$id'));
      request.files
          .add(await http.MultipartFile.fromPath('namaFoto', photo.path));

      // Send the request
      var response = await request.send();
      print(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<ItemType> deleteMakanan(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return ItemType.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
