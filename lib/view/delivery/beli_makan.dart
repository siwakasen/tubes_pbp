import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/pdfView/pdf_view.dart';
import 'package:uuid/uuid.dart';

class BeliMakanView extends StatefulWidget {
  const BeliMakanView({super.key});

  @override
  State<BeliMakanView> createState() => _BeliMakanViewState();
}

class _BeliMakanViewState extends State<BeliMakanView> {
  String id = const Uuid().v1();
  bool isPesan = false;
  List<Makanan> makanan = [];
  late int itemCount = 0;
  late Response response;
  late Response response2;
  List<String> imageLink = [];
  List<Makanan> makanan2 = [];
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
                padding: EdgeInsets.symmetric(vertical: 10),
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
                          Container(
                            child: Text(
                              makanan[index].namaMakanan!,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            makanan[index].hargaMakanan!.toString(),
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text("+",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.red)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  )),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
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
        title: const Text("DELIVERY MAKANAN"),
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
                      padding: EdgeInsets.only(left: 40, right: 20),
                      decoration: ShapeDecoration(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      child: TextButton(
                        child: Text("Food"),
                        onPressed: () {
                          Scaffold.of(context).showBottomSheet<void>(
                            (BuildContext context) {
                              return bottomSheet();
                            },
                          );
                        },
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
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
      drawer: delivery(),
    );
  }

  Container bottomSheet() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: ShapeDecoration(
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
                padding: EdgeInsets.only(top: 10, left: 50, right: 50),
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
                child: Text('Food')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Drinks')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Snack')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Combo')),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Drawer delivery() {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          child: Text('Delivery'),
        ),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: const Text('Order'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: const Text('History'),
          onTap: () {},
        ),
      ],
    ));
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("DELIVERY MAKANAN"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: makanan.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     minVerticalPadding: 30,
//                     leading: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: ExtendedImage.network(
//                         imageLink[index],
//                         width: 400,
//                         height: 400,
//                         fit: BoxFit.fill,
//                         cache: true,
//                         borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                       ),
//                     ),
//                     title: Text(makanan[index].namaMakanan!),
//                     subtitle: Text("Rp ${makanan[index].hargaMakanan!}"),
//                     trailing: Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (tapCounts[index] > 0) {
//                                 tapCounts[index]--;
//                               }
//                             });
//                           },
//                           child: const Icon(Icons.remove),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           tapCounts[index].toString(),
//                           style: const TextStyle(fontSize: 17),
//                         ),
//                         const SizedBox(width: 10),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               tapCounts[index]++;
//                             });
//                           },
//                           child: const Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 isPesan = false;
//                 for (int i = 0; i < tapCounts.length; i++) {
//                   if (tapCounts[i] > 0) {
//                     isPesan = true;
//                     break;
//                   }
//                 }
//                 if (isPesan) {
//                   createPdf(context, makanan, tapCounts, id);
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Warning'),
//                       content: const Text('Pesanan belum diisi.'),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('OK'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//               ),
//               child: Text(
//                 "Place Order",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
}
