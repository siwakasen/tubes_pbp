import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:http/http.dart' as http;
import 'package:ugd2_pbp/entity/userEntity.dart';

void main() {
  test('login success', () async {
    final hasil = await UserClient.login('debydeby', 'debydeby123');

    expect(hasil.username, equals('debydeby'));
    expect(hasil.password, equals('debydeby123'));
  });

  test('login failed', () async {
    final result = await UserClient.login('invalid', 'invalid');

    expect(result, null);
  });

  test('register success', () async {
    User user = User(
        id: 0,
        username: "riksi",
        email: "riksi@gmail.com",
        password: "riksi123",
        name: "riksi",
        address: "Jl.Blabla",
        bornDate: "2023-12-01",
        phoneNumber: "08123123123",
        photo: "-");
    final hasil = await UserClient.createTesting(user);

    expect(hasil.statusCode, equals(200));
  });

  test('register gagal', () async {
    User user = User(
        id: 0,
        username: "riksi",
        email: "riksi@gmail.com",
        password: "riksi123",
        name: "riksi",
        address: "Jl.Blabla",
        bornDate: "2023-12-01",
        phoneNumber: "08123123123",
        photo: "-");
    final hasil = await UserClient.createTesting(user);

    expect(hasil.statusCode, isNot(equals(200)));
  });
}
