// import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:intl/intl.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/order/nota/note_preview_pdf.dart';

Future<void> createPdf(BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  List<Makanan> makanan = [
    Makanan(
        namaMakanan: "Soto Ayam Madura",
        hargaMakanan: 15000,
        namaFoto: "logo.png"),
    Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png")
  ];
  List<String> qty = ["1", "2"];

  pw.Container summary() {
    return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 45),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Order Summary",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Subtotal',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    "1000000",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Delivery fee',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    "20000.00",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Total",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "IDR 10000000",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ])
            ]));
  }

  pw.Container transaction() {
    return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 45),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Transaction Details",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Transaction ID',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    "TR-0001",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Date order',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    "2021-10-10",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Time order',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    "10:54",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ]));
  }

  //nampilin list makanan yang dipesan
  pw.Container orderList() {
    return pw.Container(
      width: MediaQuery.of(context).size.width,
      padding: const pw.EdgeInsets.symmetric(horizontal: 45),
      child: pw.Column(
        children: List.generate(makanan.length, (index) {
          return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  pw.Container(
                    width: 140,
                    child: pw.Text(
                      makanan[index].namaMakanan!,
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  pw.Text(
                    makanan[index].hargaMakanan.toString(),
                    style: const pw.TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  pw.Text(
                    " x ${qty[index]}",
                    style: const pw.TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                pw.Text(
                  makanan[index].hargaMakanan.toString(),
                  style: const pw.TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]);
        }),
      ),
    );
  }

  //tampilin page
  doc.addPage(pw.MultiPage(
    build: (pw.Context context) {
      return [
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text("Crusty Crunch",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)),
        ),
        pw.SizedBox(height: 5),
        pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 40),
            child: pw.Container(height: 1, color: PdfColors.black)),
        pw.SizedBox(height: 20),
        pw.Container(
          width: double.infinity,
          child: orderList(),
        ),
        pw.SizedBox(height: 20),
        transaction(),
        pw.SizedBox(height: 20),
        summary(),
        pw.SizedBox(height: 20),
      ];
    },
  ));

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)));
}

pw.Center footerPDF(String formattedDate) {
  return pw.Center(
      child: pw.Text("Created At ${formattedDate}",
          style: const pw.TextStyle(color: PdfColors.blue)));
}
