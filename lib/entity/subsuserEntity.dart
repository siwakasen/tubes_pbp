import 'dart:convert';

class SubscriptionUser {
  int? id_user;
  int? id_subscription;

  SubscriptionUser({this.id_user = 0, this.id_subscription});

  factory SubscriptionUser.fromRawJson(String str) =>
      SubscriptionUser.fromJson(json.decode(str));
  factory SubscriptionUser.fromJson(Map<String, dynamic> json) =>
      SubscriptionUser(
        id_user: json['user_id'],
        id_subscription: json['subscription_id'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'user_id': id_user,
        'subscription_id': id_subscription,
      };
}
