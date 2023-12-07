import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/components/delivery_drawer.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/delivery/cari_makan.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';
import 'package:ugd2_pbp/view/order/order_review_page.dart';
import 'package:uuid/uuid.dart';

class BeliMakanView extends StatefulWidget {
  int type;
  @override
  BeliMakanView({
    super.key,
    required this.type,
  });

  @override
  State<BeliMakanView> createState() => _BeliMakanViewState();
}

class _BeliMakanViewState extends State<BeliMakanView> {
  bool isPesan = false;
  List<Makanan> makanan = [
    Makanan(
        namaMakanan: "Soto Ayam Madura",
        hargaMakanan: 15000,
        namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"),
  ];
  late int itemCount = makanan.length;
  late Response response;
  late Response response2;
  List<String> imageLink = [];
  bool isHavePesanan = false;
  List<Makanan> pesanan = [];
  void refresh() async {
    // final makanan2 = await MakananClient.fetchAll();
    // imageLink = List.filled(makanan2.length, '');
    print(makanan[0].namaMakanan);
    //clear cache image makanan
    clearMemoryImageCache();
    clearDiskCachedImages();

    //mengambil image semua makanan yang tersimpan di dalam folder public
    //laravel, berdasarkan nama image yang tersimpan di database
    // response2 = await MakananClient.getAllImageMakanan();
    //bentuk response2.body[data] ini adalah array of string
    //kemudian disimpan di imageLink yg berupa list
    // imageLink = json.decode(response2.body)['data'].cast<String>();

    // setState(() {
    //   makanan = makanan2;
    //   itemCount = makanan.length;
    // });
    userId = await getIntValuesSF();
  }

  int userId = -1;
  List<int> tapCounts = [];
  @override
  void initState() {
    super.initState();
    refresh();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DELIVERY - ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins")),
        ),
        body: Column(
          children: [
            Container(
              height: isHavePesanan
                  ? MediaQuery.of(context).size.height - 236
                  : MediaQuery.of(context).size.height - 136,
              child: SingleChildScrollView(
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
                              decoration: const ShapeDecoration(
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
                              child: TextButton(
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Food",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => dropdownBottomSheet(),
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CariMakanView()),
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(itemCount, (index) {
                          return listMakanan(index);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isHavePesanan
                ? Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, -5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                            width: 300,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const ShapeDecoration(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: TextButton(
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.collections_bookmark,
                                      color: Colors.white),
                                  Text(
                                    "1 Item(s)",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Harga",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const OrderReviewView()),
                                );
                              },
                            )),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        drawer: delivery(context));
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome to BeliMakanView"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Column bottomSheet() {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 10,
                    blurRadius: 9,
                    offset: Offset(0, 5)),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50)))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 5,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listMakanan(int index) {
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
                    // ExtendedImage.network(
                    //   imageLink[index],
                    //   width: 100,
                    //   height: 100,
                    //   fit: BoxFit.fill,
                    //   cache: true,
                    // ),
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
                        onPressed: () {
                          addPesanan(index);
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

  Widget dropdownBottomSheet() => DraggableScrollableSheet(
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
                  "Select Type",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Food',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"))),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Snacks',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"))),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Drink',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"))),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Combo',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"))),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }

  void addPesanan(int index) {
    pesanan.add(makanan[index]);

    setState(() {
      if (pesanan.isNotEmpty) {
        isHavePesanan = true;
      } else {
        isHavePesanan = false;
      }
    });
  }
}
