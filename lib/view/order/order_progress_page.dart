import 'package:flutter/material.dart';

class OrderProcessView extends StatefulWidget {
  const OrderProcessView({super.key});

  @override
  State<OrderProcessView> createState() => _OrderProcessViewState();
}

class _OrderProcessViewState extends State<OrderProcessView> {
  List<String> orderData = ["1", "2"];
  List<String> detailsData = ["1", "2"];
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
            //Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image: AssetImage('images/icon_bag.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    'Order',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 20,
            ),
            buildOrder(context)
          ],
        ),
      ),
    );
  }

  Widget buildOrder(BuildContext context) {
    return Column(
      children: List.generate(orderData.length, (index) => orderList(index)),
    );
  }

  Widget orderList(index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFD600),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(
          children:
              List.generate(detailsData.length, (index) => orderDetails(index)),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Progress",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Cooking",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 400,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFFFD600),
                    ),
                    Expanded(
                      child: Container(
                        height: 10,
                        margin: const EdgeInsets.only(top: 10),
                        color: Color(0xFFD9D9D9),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget orderDetails(index) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: Image(
            image: AssetImage('images/logo.png'),
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Coca - Cola",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            Text(
              "Coca-cola medium",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
