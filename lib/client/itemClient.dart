import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:ugd2_pbp/entity/itemEntity.dart';

class ItemClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<Item>> fetchAll() async {
    print("fetching all item");
    try {
      var response = await get(Uri.http(url, '$endpoint/items'));

      Iterable list = json.decode(response.body)['data'];
      print(list);
      return list.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // static Future<List<Map<String, dynamic>>> fetchAll2() async {
  //   print("fetching all 2");

  //   try {
  //     var response = await get(Uri.http(url, '$endpoint/items'));

  //     if (response.statusCode != 200) {
  //       if (response.statusCode != 404) throw Exception(response.reasonPhrase);
  //     }

  //     Iterable list = json.decode(response.body)['data'];

  //     // Modify the mapping to Map<String, dynamic>

  //     return list.map((e) => e as Map<String, dynamic>).toList();
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  static Future<void> create(Item item, File photo) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://$url$endpoint/items'));
      request.files.add(await http.MultipartFile.fromPath('photo', photo.path));

      request.fields['price'] = item.price.toString();
      request.fields['name'] = item.name;

      // Send the request
      var response = await request.send();
      print(response);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Item> find(id) async {
    print("finding makanan");
    try {
      var response = await get(Uri.http(url, '$endpoint/items/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Item.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> update(Item item, id, File photo) async {
    try {
      print("update makanan");
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://$url$endpoint/items/$id'));
      request.files.add(await http.MultipartFile.fromPath('photo', photo.path));

      request.fields['price'] = item.price.toString();
      request.fields['name'] = item.name;

      // Send the request
      var response = await request.send();
      print(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateWithoutImage(Item makanan, id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/items/noImage/$id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'name': makanan.name,
            'price': makanan.price.toString(),
          }));
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch image: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error([e.toString()]);
    }
  }

  static Future<Response> getImageMakanan(String filename) async {
    print("getting certain image");
    try {
      var response =
          await get(Uri.http(url, '$endpoint/items/images/$filename'));
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch image: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error([e.toString()]);
    }
  }

  static Future<Response> getAllImageItems() async {
    print("getting all image");
    try {
      var response = await get(Uri.http(url, '$endpoint/items/images/all'));
      if (response.statusCode == 200) {
        print(response.body);
        return response;
      } else {
        throw Exception('Failed to fetch image: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error([e.toString()]);
    }
  }

  static Future<Item> deleteMakanan(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/items/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Item.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
