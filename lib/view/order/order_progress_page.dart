import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/detailTransaksiClient.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:ugd2_pbp/client/transaksiClient.dart';
import 'package:ugd2_pbp/entity/detailTransaksiEntity.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/view/restaurant/ListRestaurant.dart';

class OrderProcessView extends StatefulWidget {
  const OrderProcessView({
    super.key,
  });

  @override
  State<OrderProcessView> createState() => _OrderProcessViewState();
}

class _OrderProcessViewState extends State<OrderProcessView> {
  List<Transaksi> transaksiFromDatabase = [];
  List<Transaksi> transaksis = [];
  List<Item> itemFromDatabase = [];
  List<Item> items = [];
  List<DetailTransaksi> tDetailFromDatabase = [];

  List<String> imageLink = [];

  List<List<Item>> orderData = [];

  List<String> detailsData = ["1", "2"];

  late int transaksiCount = 0;

  void refresh() async {
    transaksiFromDatabase = await TransaksiClient.fetchAll();
    itemFromDatabase = await ItemClient.fetchAll();
    tDetailFromDatabase = await DetailTransaksiClient.fetchAll();
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
          children: List.generate(orderData[index].length,
              (index2) => orderDetails(orderData[index][index2])),
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
            child: InkWell(
              onTap: () {
                onProgressTap(transaksis[index]);
              },
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
                  Text(
                    transaksis[index].status!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  progress(transaksis[index].status!),
                ],
              ),
            ))
      ]),
    );
  }

  Widget orderDetails(Item item) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: ExtendedImage.network(
            imageLink.where((element) => element.contains(item.photo)).first,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            cache: true,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            Text(
              item.size,
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

  Widget progress(String value) {
    double panjang = 100;
    Color warna = Colors.black;
    switch (value) {
      case "Cooking":
        panjang = 100;
        warna = Colors.grey;
        break;
      case "Delivery":
        panjang = 375 / 2;
        warna = Colors.yellow;
        break;
      case "Success":
        panjang = 375;
        warna = Colors.green;
        break;
      default:
        panjang = 100;
        warna = Colors.grey;
        break;
    }

    return Container(
      width: 400,
      child: Row(
        children: [
          Container(
            width: panjang.toDouble(),
            height: 10,
            margin: const EdgeInsets.only(top: 10),
            color: warna,
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
    );
  }

  void onProgressTap(Transaksi transaksis) {
    setState(() {
      switch (transaksis.status) {
        case "Cooking":
          transaksis.status = "Delivery";
          break;
        case "Delivery":
          transaksis.status = "Success";
          break;
        default:
          break;
      }
    });
    TransaksiClient.update(transaksis, transaksis.id);
  }
}
