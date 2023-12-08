import 'dart:convert';

class SubscriptionUser {
  int? id_user;
  int? id_subscription;
  String? start_at;
  String? end_at;

  SubscriptionUser(
      {this.id_user = 0, this.id_subscription, this.start_at, this.end_at});

  factory SubscriptionUser.fromRawJson(String str) =>
      SubscriptionUser.fromJson(json.decode(str));
  factory SubscriptionUser.fromJson(Map<String, dynamic> json) =>
      SubscriptionUser(
        id_user: json['user_id'],
        id_subscription: json['subscription_id'],
        start_at: json['start_date'],
        end_at: json['end_date'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'user_id': id_user,
        'subscription_id': id_subscription,
        'start_date': start_at,
        'end_date': end_at,
      };
}
