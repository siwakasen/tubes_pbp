import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/view/order/history_page.dart';
import 'package:ugd2_pbp/view/order/ratings_page.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  List<String> subs = ["1", "2", "3"];
  int idSubs = 1;
  int indexPaymentMethod = -1;
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
                subs.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: subs[index] == "1"
                            ? Colors.brown
                            : subs[index] == "2"
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
                                setState(() {
                                  if (idSubs != index) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => updateSubscribe(),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                    );
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => payment(),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                    );
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
                                      subs[index] == "1"
                                          ? "Bronze"
                                          : subs[index] == "2"
                                              ? "Gold"
                                              : "Platinum",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    const Row(
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
                                          "IDR 49.000",
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
                                      child: const Text(
                                        "15% Off on any purchase",
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
              idSubs == -1
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
                              Text("Your subscription is ${subs[idSubs]}",
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
                          Text("Due Date: 12/12/2021",
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
                      onTap: () {
                        setState(() {
                          indexPaymentMethod = 0;
                          Navigator.of(context).pop();
                        });
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
                      onTap: () => setState(() {
                        indexPaymentMethod = 1;
                        Navigator.of(context).pop();
                        showSnackBar(
                            context,
                            "Successfull to pay using Pembayaran Gopay",
                            Colors.green);
                      }),
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
                      onTap: () => setState(() {
                        indexPaymentMethod = 2;
                        Navigator.of(context).pop();
                        showSnackBar(
                            context,
                            "Successfull to pay using Transfer BCA",
                            Colors.green);
                      }),
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
                      onTap: () => setState(() {
                        indexPaymentMethod = 3;
                        Navigator.of(context).pop();
                        showSnackBar(
                            context,
                            "Successfull to pay using Transfer Mandiri",
                            Colors.green);
                      }),
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
                      onTap: () => setState(() {
                        indexPaymentMethod = 4;
                        Navigator.of(context).pop();
                        showSnackBar(
                            context,
                            "Successfull to pay using Transfer BRI",
                            Colors.green);
                      }),
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
                child: const Text(
                    "Are you sure to update subscription to ... ?",
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
                          setState(() {
                            Navigator.of(context).pop();
                            showSnackBar(
                                context,
                                "Successfull to update subscription to ...  ",
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
                          setState(() {
                            Navigator.of(context).pop();
                            showSnackBar(
                                context,
                                "Your subscription is stopped successfully",
                                Colors.green);
                            idSubs = -1;
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
}
