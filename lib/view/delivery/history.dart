import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:ugd2_pbp/component/delivery_drawer.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/entity/orderEntity.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Order> orders = [
    Order(
      listMakanan: <Makanan>[
        Makanan(
            namaMakanan: "Coca Cola",
            hargaMakanan: 10000,
            namaFoto: "cola.png"),
        Makanan(
            namaMakanan: "Burger", hargaMakanan: 20000, namaFoto: "burger.jpg")
      ],
      totalHarga: 30000,
      rating: 4,
      progress: "dimasak",
    ),
    Order(
      listMakanan: <Makanan>[
        Makanan(
            namaMakanan: "Coca Cola",
            hargaMakanan: 10000,
            namaFoto: "cola.png"),
        Makanan(
            namaMakanan: "Burger", hargaMakanan: 20000, namaFoto: "burger.jpg")
      ],
      totalHarga: 30000,
      rating: 4,
      progress: "dimasak",
    ),
  ];
  List<String> imageLink = [];
  late Response response2;

  void refresh() async {
    imageLink = List.filled(2, '');

    //clear cache image makanan
    clearMemoryImageCache();
    clearDiskCachedImages();

    //mengambil image semua makanan yang tersimpan di dalam folder public
    //laravel, berdasarkan nama image yang tersimpan di database
    response2 = await MakananClient.getAllImageMakanan();
    //bentuk response2.body[data] ini adalah array of string
    //kemudian disimpan di imageLink yg berupa list
    imageLink = json.decode(response2.body)['data'].cast<String>();
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
        title: Text('History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(2, (index) {
            return bloc(index); // Use the bloc function here
          }),
        ),
      ),
      drawer: delivery(context),
    );
  }

  Widget bloc(int index) {
    Order order = orders[index];
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: const ShapeDecoration(
            color: Colors.amber,
            shadows: [
              BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 4),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    children: List.generate(2, (index) {
                  return Container(
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ExtendedImage.network(
                            imageLink[index],
                            width: 75,
                            height: 75,
                            fit: BoxFit.fill,
                            // cache: true,
                          ),
                          Column(
                            children: [
                              Text(order.listMakanan![index].namaMakanan!)
                            ],
                          )
                        ]),
                  );
                })),
                Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                    Text('Rp. ${order.totalHarga}'),
                  ],
                ),
              ],
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,
                          color:
                              order.rating! >= 5 ? Colors.yellow : Colors.grey),
                      Icon(Icons.star,
                          color:
                              order.rating! >= 4 ? Colors.yellow : Colors.grey),
                      Icon(Icons.star,
                          color:
                              order.rating! >= 3 ? Colors.yellow : Colors.grey),
                      Icon(Icons.star,
                          color:
                              order.rating! >= 2 ? Colors.yellow : Colors.grey),
                      Icon(Icons.star,
                          color:
                              order.rating! >= 1 ? Colors.yellow : Colors.grey),
                    ],
                  ),
                  Text("Order Summary"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
