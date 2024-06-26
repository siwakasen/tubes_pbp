import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/subsClient.dart';
import 'package:ugd2_pbp/client/subsUserClient.dart';
import 'package:ugd2_pbp/entity/subscriptionEntity.dart';
import 'package:ugd2_pbp/entity/subsuserEntity.dart';
import 'package:ugd2_pbp/view/order/history_page.dart';
import 'package:ugd2_pbp/view/order/ratings_page.dart';
import 'package:ugd2_pbp/view/restaurant/ListRestaurant.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => SubscriptionViewState();
}

class SubscriptionViewState extends State<SubscriptionView> {
  void initState() {
    refresh();
    super.initState();
  }

  SubscriptionUser subsuser = SubscriptionUser(
    id_user: -1,
    id_subscription: -1,
  );
  SubscriptionUser? barusub;
  String? namaSubs;
  List<Subscription> listsubs = [];
  int indexPaymentMethod = -1;
  late int selectedSubs;
  bool isSubs = false;
  late int userId;

  void refresh() async {
    userId = await getIntValuesSF();
    final subsData = await SubsClient.fetchAll();
    subsuser = await SubsUserClient.find(userId);
    print("subsuser");
    if (subsuser.id_user == -1) {
      isSubs = false;
    } else {
      isSubs = true;
      if (subsuser.id_subscription == 1) {
        namaSubs = "Bronze";
      } else if (subsuser.id_subscription == 2) {
        namaSubs = "Gold";
      } else if (subsuser.id_subscription == 3) {
        namaSubs = "Platinum";
      } else {
        namaSubs = subsuser.id_subscription.toString();
      }
    }

    setState(() {
      listsubs = subsData;
      print("List Subs");
      print(listsubs.length);
      if (subsuser.id_subscription == 1) {
        namaSubs = "Bronze";
      } else if (subsuser.id_subscription == 2) {
        namaSubs = "Gold";
      } else if (subsuser.id_subscription == 3) {
        namaSubs = "Platinum";
      } else {
        namaSubs = subsuser.id_subscription.toString();
      }
    });
  }

  List<String> paymentMethodData = [
    "Credit/Debit Card",
    "Gopay",
    "Transfer BCA",
    "Transfer Mandiri",
    "Transfer BRI"
  ];
  List<String> imageNamePaymentMethod = [
    "credit_card.png",
    "gopay.png",
    "logo_bca.png",
    "logo_mandiri.png",
    "logo_bri.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subscription',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 20,
            ),
            Column(
              children: List.generate(
                listsubs.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: listsubs[index].name == "Bronze"
                            ? Colors.brown
                            : listsubs[index].name == "Gold"
                                ? Colors.amber[500]
                                : Colors.indigo,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                print(
                                    "ini state isSubs : " + isSubs.toString());
                                setState(() {
                                  print(
                                      "subsuser id ${subsuser.id_subscription}");
                                  selectedSubs = index + 1;
                                  print("ini selected subs : " +
                                      selectedSubs.toString());
                                  if (!isSubs) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => payment(),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                    );
                                  } else {
                                    if (subsuser.id_subscription != index + 1 &&
                                        isSubs) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => updateSubscribe(),
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                      );
                                    } else {}
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listsubs[index].id == 1
                                          ? "Bronze"
                                          : listsubs[index].id == 2
                                              ? "Gold"
                                              : "Platinum",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Price: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        Text(
                                          "IDR " +
                                              listsubs[index].price.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "${listsubs[index].percentage.toString()}% Off on any purchase",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSubs == false
                  ? Center(
                      child: Text("You haven't subscribed yet",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Your subscription is " + namaSubs!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Material(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => stopSubs(),
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                      );
                                    });
                                  },
                                  child: Text("Stop Subscription",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red)),
                                ),
                              ),
                            ],
                          ),
                          Text("Due Date: ${subsuser.end_at}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget payment() => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.only(top: 21),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "Select Payment Method",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 167, 167, 167),
                thickness: 1,
                height: 20,
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("Pay by",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        SubscriptionUser barusub = SubscriptionUser(
                            id_user: userId, id_subscription: selectedSubs);
                        SubsUserClient.create(barusub);

                        subsuser = await SubsUserClient.find(userId);
                        print("subsuser find" +
                            subsuser.id_subscription.toString());
                        setState(() {
                          if (subsuser.id_subscription == 1) {
                            namaSubs = "Bronze";
                          } else if (subsuser.id_subscription == 2) {
                            namaSubs = "Gold";
                          } else if (subsuser.id_subscription == 3) {
                            namaSubs = "Platinum";
                          }
                          isSubs = true;
                          Navigator.of(context).pop();
                          showSnackBar(
                              context,
                              "Successfull to pay using Credit/Debit Card",
                              Colors.green);
                        });
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        height: 70,
                        child: const Row(
                          children: [
                            SizedBox(width: 8),
                            Icon(
                              Icons.credit_card,
                              size: 40,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text("Credit/Debit Card",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 167, 167, 167),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("E-Money",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        SubscriptionUser barusub = SubscriptionUser(
                            id_user: userId, id_subscription: selectedSubs);
                        SubsUserClient.create(barusub);

                        subsuser = await SubsUserClient.find(userId);
                        print("subsuser find" +
                            subsuser.id_subscription.toString());
                        setState(() {
                          if (subsuser.id_subscription == 1) {
                            namaSubs = "Bronze";
                          } else if (subsuser.id_subscription == 2) {
                            namaSubs = "Gold";
                          } else if (subsuser.id_subscription == 3) {
                            namaSubs = "Platinum";
                          }
                          isSubs = true;
                          Navigator.of(context).pop();
                          showSnackBar(context,
                              "Successfull to pay using Gopay", Colors.green);
                        });
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 30,
                              child: Image(
                                image: AssetImage('images/gopay.png'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Gopay",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Bind Gopay Account",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 167, 167, 167),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("Transfer",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        SubscriptionUser barusub = SubscriptionUser(
                            id_user: userId, id_subscription: selectedSubs);
                        SubsUserClient.create(barusub);

                        subsuser = await SubsUserClient.find(userId);
                        print("subsuser find" +
                            subsuser.id_subscription.toString());
                        setState(() {
                          if (subsuser.id_subscription == 1) {
                            namaSubs = "Bronze";
                          } else if (subsuser.id_subscription == 2) {
                            namaSubs = "Gold";
                          } else if (subsuser.id_subscription == 3) {
                            namaSubs = "Platinum";
                          }
                          isSubs = true;
                          Navigator.of(context).pop();
                          showSnackBar(context, "Successfull to pay using BCA",
                              Colors.green);
                        });
                        setState(() {});
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_bca.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "BCA",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        SubscriptionUser barusub = SubscriptionUser(
                            id_user: userId, id_subscription: selectedSubs);
                        SubsUserClient.create(barusub);

                        subsuser = await SubsUserClient.find(userId);
                        print("subsuser find" +
                            subsuser.id_subscription.toString());
                        setState(() {
                          if (subsuser.id_subscription == 1) {
                            namaSubs = "Bronze";
                          } else if (subsuser.id_subscription == 2) {
                            namaSubs = "Gold";
                          } else if (subsuser.id_subscription == 3) {
                            namaSubs = "Platinum";
                          }
                          isSubs = true;
                          Navigator.of(context).pop();
                          showSnackBar(context,
                              "Successfull to pay using Mandiri", Colors.green);
                        });
                        setState(() {});
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_mandiri.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Mandiri",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        SubscriptionUser barusub = SubscriptionUser(
                            id_user: userId, id_subscription: selectedSubs);
                        SubsUserClient.create(barusub);

                        subsuser = await SubsUserClient.find(userId);
                        print("subsuser find" +
                            subsuser.id_subscription.toString());
                        setState(() {
                          if (subsuser.id_subscription == 1) {
                            namaSubs = "Bronze";
                          } else if (subsuser.id_subscription == 2) {
                            namaSubs = "Gold";
                          } else if (subsuser.id_subscription == 3) {
                            namaSubs = "Platinum";
                          }
                          isSubs = true;
                          Navigator.of(context).pop();
                          showSnackBar(context, "Successfull to pay using BRI",
                              Colors.green);
                        });
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_bri.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "BRI",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget updateSubscribe() => DraggableScrollableSheet(
        initialChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.only(top: 21),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "Update Subscription",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 167, 167, 167),
                thickness: 1,
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text("Are you sure to change your subscription?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: 70,
                          child: const Center(
                            child: Text("No",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.green,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          subsuser.id_subscription = selectedSubs;
                          SubsUserClient.update(subsuser, userId);
                          setState(() {
                            namaSubs = subsuser.id_subscription == 1
                                ? "Bronze"
                                : subsuser.id_subscription == 2
                                    ? "Gold"
                                    : "Platinum";
                            Navigator.of(context).pop();
                            showSnackBar(
                                context,
                                "Successfull to update subscription to ${namaSubs!}",
                                Colors.green);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: 70,
                          child: const Center(
                            child: Text("Yes",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget stopSubs() => DraggableScrollableSheet(
        initialChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.only(top: 21),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "Stop Subscription",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 167, 167, 167),
                thickness: 1,
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text("Are you sure to stop your subscription ?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: 70,
                          child: const Center(
                            child: Text("No",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.green,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          SubsUserClient.deleteSubscription(userId);
                          isSubs = false;
                          setState(() {
                            Navigator.of(context).pop();
                            print("ini user id : " + userId.toString());
                            subsuser.id_user = -1;
                            showSnackBar(
                                context,
                                "Your subscription is stopped successfully",
                                Colors.green);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: 70,
                          child: const Center(
                            child: Text("Yes",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
  ));

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}
