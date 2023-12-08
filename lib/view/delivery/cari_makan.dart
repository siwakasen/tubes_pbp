import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/view/delivery/onBeli_makan.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class CariMakanView extends StatefulWidget {
  CariMakanView(
      {super.key, required this.imageLink, required this.itemsFromDatabase});
  List<String> imageLink;
  List<Item> itemsFromDatabase = [];

  @override
  State<CariMakanView> createState() => _CariMakanViewState();
}

class _CariMakanViewState extends State<CariMakanView> {
  String id = const Uuid().v1();
  bool isPesan = false;
  late int itemCount = 0;
  late Response response;
  late Response response2;

  List<Item> items = [];

  List<String> imageLink = [];
  List<Item> itemsFromDatabase = [];

  TextEditingController searchController = TextEditingController();

  void refresh() async {}

  List<int> tapCounts = [];
  @override
  void initState() {
    itemsFromDatabase = widget.itemsFromDatabase;
    imageLink = widget.imageLink;
    items = itemsFromDatabase;
    itemCount = items.length;
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
                      imageLink
                          .where(
                              (element) => element.contains(items[index].photo))
                          .first,
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
                            items[index].name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "IDR ${items[index].price.toString()}",
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => onBeliView(
                                      makanan: items[index],
                                      photo: imageLink
                                          .where((element) => element
                                              .contains(items[index].photo))
                                          .first,
                                    )),
                          );
                        },
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
      // drawer: delivery(context),
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
    List<Item> hasilCari = [];
    for (var element in itemsFromDatabase) {
      if (element.name.contains(query)) {
        hasilCari.add(element);
      }
    }

    setState(() {
      items = hasilCari;
      itemCount = items.length;
    });
  }
}
