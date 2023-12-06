import 'dart:convert';

import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
import 'package:flutter/material.dart';
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
  bool isPesan = false;
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
        title: const Text("DELIVERY MAKANAN"),
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
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tapCounts[index].toString(),
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tapCounts[index]++;
                            });
                          },
                          child: const Icon(Icons.add),
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
                isPesan = true;
                for (int i = 0; i < tapCounts.length; i++) {
                  if (tapCounts[i] > 0) {
                    isPesan = true;
                    break;
                  }
                }
                if (isPesan) {
                  createPdf(context, makanan, tapCounts, id);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('Pesanan belum diisi.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
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
