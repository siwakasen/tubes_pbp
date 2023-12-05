import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_pbp/client/userClient.dart';

void main() {
  test('login success', () async {
    final hasil = await UserClient.login("alfa", "123123123");
    expect(hasil?.username, equals('alfa'));
    expect(hasil?.password, equals('123123123'));
  });

  test('login failed', () async {
    final hasil = await UserClient.login("invalid", "invalid");
    expect(hasil, null);
  });
}
