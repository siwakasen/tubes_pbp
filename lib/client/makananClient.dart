import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:ugd2_pbp/entity/makananEntity.dart';

class MakananClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<Makanan>> fetchAll() async {
    print("fetching all");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Makanan.fromJson(e)).toList();
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

  static Future<void> create(Makanan makanan, File photo) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://$url$endpoint/makanans'));
      request.files
          .add(await http.MultipartFile.fromPath('namaFoto', photo.path));

      request.fields['hargaMakanan'] = makanan.hargaMakanan.toString();
      request.fields['namaMakanan'] = makanan.namaMakanan!;

      // Send the request
      var response = await request.send();
      print(response);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Makanan> find(id) async {
    print("finding makanan");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Makanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<StreamedResponse> update(
      Makanan makanan, id, File photo) async {
    try {
      print("update makanan");
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://$url$endpoint/makanans/$id'));
      request.files
          .add(await http.MultipartFile.fromPath('namaFoto', photo.path));

      request.fields['hargaMakanan'] = makanan.hargaMakanan.toString();
      request.fields['namaMakanan'] = makanan.namaMakanan!;

      // Send the request
      var response = await request.send();
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateWithoutImage(Makanan makanan, id) async {
    print("getting certain image");
    try {
      var response = await put(Uri.http(url, '$endpoint/makanans/noImage/$id'));
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
          await get(Uri.http(url, '$endpoint/makanans/images/$filename'));
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

  static Future<Response> getAllImageMakanan() async {
    print("getting all image");
    try {
      var response = await get(Uri.http(url, '$endpoint/makanans/images/all'));
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
