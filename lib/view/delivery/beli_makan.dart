import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/detailTransaksiClient.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/itemTypeClient.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/components/delivery_drawer.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/itemTypeEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/entity/detailTransaksiEntity.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/delivery/cari_makan.dart';
import 'package:ugd2_pbp/view/delivery/onBeli_makan.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';
import 'package:ugd2_pbp/view/order/order_review_page.dart';
import 'package:ugd2_pbp/client/transaksiClient.dart';

// ignore: must_be_immutable
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
  User user = User.empty();
  bool isPesan = false;
  List<Item> items = [];
  late int itemCount = 0;
  late Response response;
  late Response response2;
  List<String> imageLink = [];
  bool isHavePesanan = false;
  late String typeYangsedangDicari = "Pilih Type";
  late int userId;
  List<ItemType> types = [];
  List<Item> itemFromDatabase = [];
  List<ItemType> itemTypeFromDatabase = [];
  List<Item> pesanan = [];
  List<int> qty = [];
  int subtotal = 0;

  String jumlahPesanan() {
    return pesanan.length.toString();
  }

  void refresh() async {
    itemFromDatabase = await ItemClient.fetchAll();
    itemTypeFromDatabase = await ItemTypeClient.fetchAll();
    // imageLink = List.filled(makanan2.length, '');

    //clear cache image makanan
    clearMemoryImageCache();
    clearDiskCachedImages();

    //mengambil image semua makanan yang tersimpan di dalam folder public
    //laravel, berdasarkan nama image yang tersimpan di database
    response2 = await ItemClient.getAllImageItems();
    //bentuk response2.body[data] ini adalah array of string
    //kemudian disimpan di imageLink yg berupa list
    imageLink = json.decode(response2.body)['data'].cast<String>();
    userId = await getIntValuesSF();
    final data = await UserClient.find(userId);

    setState(() {
      user = data;
      items = itemFromDatabase;
      types = itemTypeFromDatabase;
      itemCount = items.length;
      filterSize("Regular");

      print(user);
      print(user.id_restaurant);
      user.id_restaurant == null
          ? WidgetsBinding.instance.addPostFrameCallback((_) {
              showAlertDialog();
            })
          : null;
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
              height: pesanan.isNotEmpty
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      typeYangsedangDicari,
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
                                    builder: (_) => CariMakanView(
                                          imageLink: imageLink,
                                          itemsFromDatabase: itemFromDatabase,
                                        )),
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
            pesanan.isNotEmpty
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.collections_bookmark,
                                      color: Colors.white),
                                  Text(
                                    "${pesanan.length} Item(s)",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "IDR $subtotal",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Transaksi transaksi = Transaksi(
                                    id_user: user.id,
                                    id_restaurant: user.id_restaurant,
                                    address_on_trans: user.address,
                                    subtotal: subtotal,
                                    delivery_fee: 10000,
                                    order_fee: 4000,
                                    status: "not payed");

                                List<DetailTransaksi> detailTransaksi = [
                                  for (int i = 0; i < pesanan.length; i++)
                                    DetailTransaksi(
                                      id_transaksi: -1,
                                      id_item: pesanan[i].id,
                                      quantity: qty[i],
                                    )
                                ];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OrderReviewView(
                                          trans: transaksi,
                                          detailTrans: detailTransaksi)),
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

  Widget listMakanan(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
          child: AnimatedContainer(
        duration: const Duration(milliseconds: 10000),
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
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (items[index].name.contains("Combo")) {
                            setState(() {
                              pesanan.add(items[index]);
                              qty.add(1);
                              for (var i = 0; i < pesanan.length; i++) {
                                subtotal += pesanan[i].price * qty[i];
                              }
                            });
                          } else {
                            Map<String, dynamic> result = await Navigator.push(
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
                            if (result['isPesan'] == true) {
                              Item newItem = items[index].getIdBySize(
                                  itemFromDatabase,
                                  result['name'],
                                  result['size']);
                              setState(() {
                                if (newItem.isSamePesanan(
                                    pesanan, newItem.id)) {
                                  int index = pesanan.indexWhere(
                                      (element) => element.id == newItem.id);
                                  int customizeQty = result['quantity'];
                                  qty[index] += customizeQty;
                                } else {
                                  pesanan.add(newItem);
                                  qty.add(result['quantity']);
                                }
                                for (var i = 0; i < pesanan.length; i++) {
                                  subtotal += pesanan[i].price * qty[i];
                                }
                              });
                            }
                          }
                          print(pesanan.map((e) => e.printPesanan()));
                          print(qty.map((e) => e));
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
                          filter(1);
                          setState(() {
                            typeYangsedangDicari = "Food";
                          });
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
                          filter(3);
                          setState(() {
                            typeYangsedangDicari = "Snack";
                          });
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
                          filter(2);
                          setState(() {
                            typeYangsedangDicari = "Drink";
                          });
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
                          filter(4);
                          setState(() {
                            typeYangsedangDicari = "Combo";
                          });
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
  void showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Please choose the restaurant before ordering foods"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.red,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeBottomView(
                                pageRenderIndex: 1,
                                bottomBarIndex: 1,
                              )));
                },
                child: Text(
                  "Choose Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }

  void addPesanan(int index) {
    pesanan.add(items[index]);

    setState(() {
      if (pesanan.isNotEmpty) {
        isHavePesanan = true;
      } else {
        isHavePesanan = false;
      }
    });
  }

  void filter(
    int filter,
  ) {
    List<Item> hasil = [];
    if (filter == 4) {
      for (var item in itemFromDatabase) {
        if (item.id_type == 4 || item.id_type == 5 || item.id_type == 6) {
          hasil.add(item);
        }
      }
    } else {
      for (var item in itemFromDatabase) {
        if (item.id_type == filter && item.size == "Regular") {
          hasil.add(item);
        }
      }
    }
    //cara ku
    setState(() {
      items = hasil;
      itemCount = items.length;
    });
  }

  void filterSize(String size) {
    List<Item> hasil = [];
    print(itemFromDatabase.length);
    for (var item in itemFromDatabase) {
      if (item.size == size) {
        hasil.add(item);
      }
    }

    setState(() {
      items = hasil;
      itemCount = items.length;
    });
    print("Sorting");
    print(hasil[0].size);
  }
}
