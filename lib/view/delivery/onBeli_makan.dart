import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
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
        title: const Text("Costumize", style: TextStyle(color: Colors.black)),
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
                          child: Text("ini foto"),
                        ),
                        //@nanti ganti ini
                        // ExtendedImage.network(
                        //   imageLink[index],
                        //   width: 100,
                        //   height: 100,
                        //   fit: BoxFit.fill,
                        //   cache: true,
                        // ),
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
                              icon: Icon(Icons.add),
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
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: const ShapeDecoration(
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    child: DropdownMenu<String>(
                      initialSelection: ukuran.first,
                      width: 260,
                      inputDecorationTheme:
                          InputDecorationTheme(border: InputBorder.none),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
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
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onPressed: () {},
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
