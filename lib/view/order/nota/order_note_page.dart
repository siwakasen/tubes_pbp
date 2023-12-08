import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/components/order_items.dart';
import 'package:ugd2_pbp/components/summary.dart';
import 'package:ugd2_pbp/components/transaction_details.dart';
import 'package:ugd2_pbp/view/order/nota/note_pdf_builder.dart';

class OrderNoteView extends StatefulWidget {
  const OrderNoteView({super.key});

  @override
  State<OrderNoteView> createState() => _OrderNoteViewState();
}

class _OrderNoteViewState extends State<OrderNoteView> {
  List<Makanan> makanan = [];
  List<String> desc = ["Pedas", "Goreng mateng", "tes"];

  @override
  void initState() {
    makanan.add(Makanan(
        namaMakanan: "Soto Ayam Madura",
        hargaMakanan: 15000,
        namaFoto: "logo.png"));
    makanan.add(Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Order Note',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          Divider(
            color: Colors.black,
            height: 20,
            thickness: 2,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: screenWidth,
              child: Column(
                children: List.generate(
                    makanan.length, (index) => listItem(index, makanan, desc)),
              )),
          Container(
            //Container payment method
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            width: screenWidth,
            child: transDetails(),
          ),
          // Container(
          //   //Container payment method
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          //   ),
          //   padding:
          //       const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          //   width: screenWidth,
          //   child: summary(),
          // ),
        ]),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              setState(() {
                createPdf(context);
              });
            },
            child: const Text(
              "Print Note",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
