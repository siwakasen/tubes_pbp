import 'dart:convert';

import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
import 'package:ugd2_pbp/view/adminView/add_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd2_pbp/view/pdfView/pdf_view.dart';
import 'package:uuid/uuid.dart';

class BeliMakanView extends StatefulWidget {
  const BeliMakanView({super.key});

  @override
  State<BeliMakanView> createState() => _BeliMakanViewState();
}

class _BeliMakanViewState extends State<BeliMakanView> {
  List<Map<String, dynamic>> makanan = [];
  String id = const Uuid().v1();
  void refresh() async {
    final data = await SQLMakanan.getmakanan();
    setState(() {
      makanan = data;
      tapCounts = List<int>.filled(makanan.length, 0);
    });
  }

  List<int> tapCounts = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DELIVERY MAKANAN"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: makanan.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    minVerticalPadding: 30,
                    leading: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.memory(
                        const Base64Decoder()
                            .convert(makanan[index]["namaFoto"] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(makanan[index]["namaMakanan"]),
                    subtitle: Text("Rp " + makanan[index]["hargaMakanan"]),
                    trailing: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (tapCounts[index] > 0) {
                                tapCounts[index]--;
                              }
                            });
                          },
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 10),
                        Text(
                          tapCounts[index].toString(),
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tapCounts[index]++;
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                createPdf(context, makanan, tapCounts, id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text(
                "Place Order",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
