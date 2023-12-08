import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ugd2_pbp/entity/subsuserEntity.dart';
import 'package:http/http.dart' as http;

class SubsUserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  static Future<List<SubscriptionUser>> fetchAll() async {
    print("fetching all");
    try {
      var response = await get(Uri.http(url, '$endpoint/subscription_user'));

      if (response.statusCode != 200) {
        if (response.statusCode != 404) throw Exception(response.reasonPhrase);
      }
      print(response.body);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => SubscriptionUser.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(SubscriptionUser SubscriptionUser) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/subscription_user'),
          headers: {'Content-Type': 'application/json'},
          body: SubscriptionUser.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<SubscriptionUser> find(id) async {
    print("finding Subscription User");
    try {
      var response =
          await get(Uri.http(url, '$endpoint/subscription_user/$id'));
      print((response.body));
      if (json.decode(response.body)['data'] == null) {
        return SubscriptionUser(
            id_user: -1, id_subscription: -1, start_at: "", end_at: "");
      }
      return SubscriptionUser.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      print("error finding Subscription User");
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(SubscriptionUser subsuser, id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/subscription_user/$id'),
          headers: {'Content-Type': 'application/json'},
          body: subsuser.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<http.Response> deleteSubscription(int id) async {
    try {
      var response =
          await http.delete(Uri.http(url, '$endpoint/subscription_user/$id'));
      return response;
    } catch (e) {
      print("Error deleting Subscription User: $e");
      return Future.error(e);
    }
  }
}
