import 'package:flutter/material.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({Key? key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  final List<String> subscriptionOptions = [
    'Monthly Subscription',
    'Yearly Subscription',
    'Lifetime Subscription',
  ];

  final List<String> subscriptionDesc = [
    'Monthly Subscription',
    'Yearly Subscription',
    'Lifetime Subscription',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: subscriptionOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.yellow, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              tileColor: Colors.yellow,
              title: Text(subscriptionOptions[index]),
              subtitle: Text(subscriptionDesc[index]),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
