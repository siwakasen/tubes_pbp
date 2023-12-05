import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/delivery_drawer.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:uuid/uuid.dart';

class CariMakanView extends StatefulWidget {
  const CariMakanView({super.key});

  @override
  State<CariMakanView> createState() => _CariMakanViewState();
}

class _CariMakanViewState extends State<CariMakanView> {
  String id = const Uuid().v1();
  bool isPesan = false;
  List<Makanan> makanan = [];
  late int itemCount = 0;
  late Response response;
  late Response response2;
  List<String> imageLink = [];
  List<Makanan> makanan2 = [];
  List<Makanan> makananFromDatabase = [];

  TextEditingController searchController = TextEditingController();

  void refresh() async {
    final makanan2 = await MakananClient.fetchAll();
    imageLink = List.filled(makanan2.length, '');

    //clear cache image makanan
    clearMemoryImageCache();
    clearDiskCachedImages();

    //mengambil image semua makanan yang tersimpan di dalam folder public
    //laravel, berdasarkan nama image yang tersimpan di database
    response2 = await MakananClient.getAllImageMakanan();
    //bentuk response2.body[data] ini adalah array of string
    //kemudian disimpan di imageLink yg berupa list
    imageLink = json.decode(response2.body)['data'].cast<String>();

    setState(() {
      makanan = makanan2;
      makananFromDatabase = makanan2;
      itemCount = makanan.length;
    });
  }

  List<int> tapCounts = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Widget bloc(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
          child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ExtendedImage.network(
                      imageLink[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      cache: true,
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            makanan[index].namaMakanan!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            makanan[index].hargaMakanan!.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text("+",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.red)),
                                  )),
                            )))
                  ],
                )),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            )
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SEARCH RESULT"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(left: 20),
                    foregroundDecoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        searchMakanan(searchController.text);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                          )))
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: List.generate(itemCount, (index) {
                  return bloc(index); // Use the bloc function here
                }),
              ),
            ),
          ],
        ),
      ),
      drawer: delivery(context),
    );
  }

  Container bottomSheet() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                child: Container(
                  height: 5,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Food')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Drinks')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Snack')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Combo')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  void searchMakanan(String query) {
    List<Makanan> hasilCari = [];
    for (var element in makananFromDatabase) {
      if (element.namaMakanan!.contains(query)) {
        hasilCari.add(element);
      }
    }

    setState(() {
      makanan = hasilCari;
      itemCount = makanan.length;
    });
  }
}
