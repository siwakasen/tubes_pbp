import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/lib_tubes/order_note_page.dart';
import 'package:ugd2_pbp/lib_tubes/ratings_page.dart';

class HistoryOrderView extends StatefulWidget {
  const HistoryOrderView({super.key});

  @override
  State<HistoryOrderView> createState() => _HistoryOrderViewState();
}

class _HistoryOrderViewState extends State<HistoryOrderView> {
  List<String> historyData = ["1", "2"];
  List<String> orderData = ["1", "2"];
  List<bool> isRated = [false, true];
  List<String> rating = ["4", "2"];

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
                  height: 37,
                  child: const Image(
                    image: AssetImage('images/icon_clock.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    'History',
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
            buildHistory(context)
          ],
        ),
      ),
    );
  }

  Widget buildHistory(BuildContext context) {
    return Column(
      children:
          List.generate(historyData.length, (index) => historyList(index)),
    );
  }

  Widget historyList(index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFFFD600),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(
                    orderData.length, (index) => orderDetails(index)),
              ),
              Container(
                padding: EdgeInsets.only(right: 14),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage('images/icon_verify.png'),
                      ),
                    ),
                    Text(
                      "IDR 220.000",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isRated[index]
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          child: const Text(
                            "Rate foods",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RatingView()));
                            });
                          },
                        ),
                      )
                    : Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              child: RatingBarIndicator(
                                rating: double.parse(rating[index]),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 20,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RatingView()));
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 5),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                setState(() {
                                  //hapus rating
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    child: const Text(
                      "Order Note",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderNoteView()));
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              "IDR 110.000",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
