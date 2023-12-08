import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:ugd2_pbp/client/itemTypeClient.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/itemTypeEntity.dart';

class onBeliView extends StatefulWidget {
  const onBeliView({super.key, required this.makanan, required this.photo});
  final Item makanan;
  final String photo;

  @override
  State<onBeliView> createState() => _onBeliViewState();
}

class _onBeliViewState extends State<onBeliView> {
  List<String> historyData = ["1", "2"];
  List<String> orderData = ["1", "2"];
  List<bool> isRated = [false, true];
  List<String> rating = ["4", "2"];
  late Item item;
  int quantity = 0;

  List<String> ukuran = <String>[
    'Regular',
    'Small',
    'Large',
  ];
  late String dropdownValue;
  var cart = FlutterCart();

  @override
  void initState() {
    dropdownValue = ukuran[0];
    item = widget.makanan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Costumize",
            style: TextStyle(
                color: Colors.black,
                fontSize: 29,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins')),
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
        child: Column(
          children: [
            Container(
              height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: ExtendedImage.network(
                            widget.photo,
                            width: 140,
                            height: 200,
                            fit: BoxFit.fill,
                            cache: true,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dropdownValue,
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity -= 1;
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              quantity.toString(),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity += 1;
                                  });
                                },
                                icon: Icon(Icons.add))
                          ]),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: ShapeDecoration(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    child: DropdownMenu<String>(
                      initialSelection: ukuran[0],
                      width: MediaQuery.of(context).size.width - 60,
                      inputDecorationTheme:
                          InputDecorationTheme(border: InputBorder.none),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      trailingIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 50,
                      ),
                      dropdownMenuEntries:
                          ukuran.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.red),
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
              ),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  if (quantity == 0) {
                    showSnackBar(
                        context, "Inputkan jumlah pesanan", Colors.red);
                  } else {
                    setState(() {
                      Map<String, dynamic> data = {
                        'isPesan': true,
                        'name': item.name,
                        'quantity': quantity,
                        'size': dropdownValue,
                      };

                      Navigator.pop(context, data);
                    });
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
  ));
}
