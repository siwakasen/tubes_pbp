import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_pbp/client/userClient.dart';

void main() {
  test('login success', () async {
    final hasil = await UserClient.logintesting('riksi', 'riksi123');

    expect(hasil?.username, equals('riksi'));
    expect(hasil?.password, equals('riksi123'));
  });
  test('login failed', () async {
    final hasil = await UserClient.logintesting('invalid', 'invalid');
    expect(hasil, null);
  });
}
