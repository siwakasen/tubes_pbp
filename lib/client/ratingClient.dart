import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/ratingEntity.dart';

class RatingClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  // static final String url = '192.168.100.211';
  // static final String endpoint = '/laravel_ugd_api/public/api';

  static Future<List<Rating>> fetchAll() async {
    print("fetching all");
    try {
      var response = await get(Uri.http(url, '$endpoint/ratings'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Rating.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAll2() async {
    print("fetching all 2");

    try {
      var response = await get(Uri.http(url, '$endpoint/ratings'));

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

  static Future<Response> create(Rating rating) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/ratings'),
          headers: {'Content-Type': 'application/json'},
          body: rating.toRawJson());

      // Send the request
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print(response.body);

      return response;
    } catch (e) {
      print("error");
      print(rating.toRawJson());
      return Future.error(e.toString());
    }
  }

  static Future<Rating> find(id) async {
    print("finding rating");
    try {
      var response = await get(Uri.http(url, '$endpoint/ratings/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Rating.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Rating rating, id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/ratings/$id'),
          headers: {'Content-Type': 'application/json'},
          body: rating.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> deleteRating(int id) async {
    try {
      var response = await http.delete(Uri.http(url, '$endpoint/ratings/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print("Success deleting Rating User");
    } catch (e) {
      print("Error deleting Subscription User: $e");
      return Future.error(e);
    }
  }
}
