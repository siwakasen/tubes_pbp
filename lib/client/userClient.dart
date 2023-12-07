import 'dart:io';

import 'package:ugd2_pbp/entity/userEntity.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<User> login(String username, String password) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(User user) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/register'),
          headers: {'Content-Type': 'application/json'},
          body: user.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/users/$id'));
      print((response.body));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User User, id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/users/$id'),
          headers: {'Content-Type': 'application/json'},
          body: User.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updatePassword(String password, String email) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/users/pass/${email}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'password': password,
          }));
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> getImageUser(String filename) async {
    try {
      var response =
          await get(Uri.http(url, '$endpoint/users/images/$filename'));
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> updateImageUser(
      File imageFile, id, String filename) async {
    try {
      var apiUrl = 'http://$url$endpoint/users/images/$id';

      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(apiUrl),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          filename: filename,
        ),
      );

      // Send the request
      var response = await request.send();
      print(response);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  static Future<User?> logintesting(String username, String password) async {
    try {
      var response = await post(Uri.http('127.0.0.1:8000', '$endpoint/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }));
      //print((response.body));

      if (response.statusCode != 200) return null;
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> createtesting(User user) async {
    try {
      var response = await post(
          Uri.http('127.0.0.1:8000', '$endpoint/register'),
          headers: {'Content-Type': 'application/json'},
          body: user.toRawJson());
      print(response.body);
      if (response.statusCode != 200) return response;
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
