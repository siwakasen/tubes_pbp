import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';

void main() {
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
      photo: "-",
      id_restaurant: -1,
    );
    final hasil = await UserClient.createtesting(user);

    expect(hasil.statusCode, equals(200));
  });

  test('register gagal', () async {
    User user = User(
      id: 0,
      username: "riksi",
      email: "riksi@gmail.com",
      password: "",
      name: "riksi",
      address: "Jl.Blabla",
      bornDate: "2023-12-01",
      phoneNumber: "08123123123",
      photo: "-",
      id_restaurant: -1,
    );
    final hasil = await UserClient.createtesting(user);

    expect(hasil.statusCode, isNot(equals(200)));
  });
}
