import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/delivery/beli_makan.dart';
import 'package:ugd2_pbp/view/order/nota/note_page.dart';
import 'package:ugd2_pbp/view/order/ratings_page.dart';

class onBeliView extends StatefulWidget {
  const onBeliView({super.key, required this.makanan});
  final Makanan makanan;

  @override
  State<onBeliView> createState() => _onBeliViewState();
}

class _onBeliViewState extends State<onBeliView> {
  List<String> historyData = ["1", "2"];
  List<String> orderData = ["1", "2"];
  List<bool> isRated = [false, true];
  List<String> rating = ["4", "2"];
  Makanan item = Makanan();
  int quantity = 0;
  List<String> ukuran = <String>[
    'Large',
    'Medium',
    'Small',
  ];
  late String dropdownValue;

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
                          width: 100,
                          height: 100,
                          color: Colors.red,
                          child: Image(image: AssetImage("images/combo.png")),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.namaMakanan!,
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
                      initialSelection: ukuran.first,
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
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BeliMakanView(
                                  type: 0,
                                )));
                  });
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
