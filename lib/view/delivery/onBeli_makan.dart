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

  @override
  void initState() {
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
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
                        "describsi?",
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
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
          ],
        ),
      ),
    );
  }
}
