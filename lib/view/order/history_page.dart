import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/client/detailTransaksiClient.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:ugd2_pbp/client/ratingClient.dart';
import 'package:ugd2_pbp/client/transaksiClient.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/detailTransaksiEntity.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/ratingEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/order/nota/note_page.dart';
import 'package:ugd2_pbp/view/order/ratings_page.dart';
import 'package:ugd2_pbp/view/restaurant/ListRestaurant.dart';

class HistoryOrderView extends StatefulWidget {
  const HistoryOrderView({super.key});

  @override
  State<HistoryOrderView> createState() => _HistoryOrderViewState();
}

class _HistoryOrderViewState extends State<HistoryOrderView> {
  List<List<Item>> orderData = [];

  List<Transaksi> transaksiFromDatabase = [];
  List<Transaksi> transaksis = [];
  List<Item> itemFromDatabase = [];
  List<Item> items = [];
  List<DetailTransaksi> tDetailFromDatabase = [];
  List<Rating> ratingFromDatabase = [];
  List<Rating> ratings = [];

  List<String> imageLink = [];

  late Map<Transaksi, List<Item>> itemsInTransaction;

  late User userYangLogin;
  late int transaksiCount = 0;

  void refresh() async {
    transaksiFromDatabase = await TransaksiClient.fetchSuccessOnly();
    itemFromDatabase = await ItemClient.fetchAll();
    tDetailFromDatabase = await DetailTransaksiClient.fetchAll();
    ratingFromDatabase = await RatingClient.fetchAll();
    // imageLink = List.filled(makanan2.length, '');

    //clear cache image makanan
    clearMemoryImageCache();
    clearDiskCachedImages();

    //mengambil image semua makanan yang tersimpan di dalam folder public
    //laravel, berdasarkan nama image yang tersimpan di database
    var response2 = await ItemClient.getAllImageItems();
    //bentuk response2.body[data] ini adalah array of string
    //kemudian disimpan di imageLink yg berupa list
    imageLink = json.decode(response2.body)['data'].cast<String>();
    userId = await getIntValuesSF();

    transaksis = transaksiFromDatabase
        .where((trans) => trans.id_user == userId)
        .toList();

    for (var trans in transaksis) {
      List<Item> itemnya = [];

      for (var detail in tDetailFromDatabase) {
        if (detail.id_transaksi == trans.id) {
          itemnya.add(itemFromDatabase
              .where((element) => element.id == detail.id_item)
              .first);
        }
      }
      orderData.add(itemnya);
    }

    for (var trans in transaksis) {
      var flag = false;
      for (var rating in ratingFromDatabase) {
        if (trans.id == rating.id_transaksi) {
          ratings.add(rating);
          flag = true;
          break;
        }
      }
      if (!flag) {
        ratings.add(Rating(id_transaksi: -1));
      }
    }

    setState(() {
      items = itemFromDatabase;

      transaksiCount = transaksis.length;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

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
            Navigator.pop(context);
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
                Icon(Icons.lock_clock, size: 40, color: Colors.black),
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
      children: List.generate(transaksiCount, (index) => historyList(index)),
    );
  }

  Widget historyList(inde) {
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
              // SizedBox(
              //   height: 160,
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: List.generate(orderData[inde].length,
              //           (index) => orderDetails(orderData[inde], index)),
              //     ),
              //   ),
              // ),
              Column(
                children: List.generate(orderData[inde].length,
                    (index) => orderDetails(orderData[inde], index)),
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
                      "IDR ${transaksis[inde].total}",
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
                ratings[inde].id_transaksi == -1
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
                            setState(() async {
                              var hasil = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RatingView(
                                          transaksi: transaksis[inde],
                                          itemsInThisTransaction:
                                              orderData[inde],
                                          imageLink: imageLink)));
                              setState(() {
                                ratings[inde] = hasil;
                              });
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
                                rating: ratings[inde].stars!.toDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 20,
                              ),
                              onTap: () {
                                setState(() async {
                                  var hasil = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RatingView(
                                              transaksi: transaksis[inde],
                                              itemsInThisTransaction:
                                                  orderData[inde],
                                              imageLink: imageLink)));
                                  setState(() {
                                    ratings[inde] = hasil;
                                  });
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
                                print("deleting");
                                onDelete(ratings[inde].id_transaksi!);
                                setState(() {
                                  ratings[inde] = Rating(id_transaksi: -1);
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
                    child: Text(
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
                                builder: (context) => OrderNoteView(
                                      transaksi: transaksis[inde],
                                    )));
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

  Widget orderDetails(List<Item> orderData, index) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: ExtendedImage.network(
            imageLink
                .where((element) => element.contains(orderData[index].photo))
                .first,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            cache: true,
          ),
        ),
        Container(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderData[index].name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                orderData[index].price.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  void onDelete(int id) {
    RatingClient.deleteRating(id);
  }
}
