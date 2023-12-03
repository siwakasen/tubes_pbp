// import 'dart:io';
import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:intl/intl.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/pdfView/preview_screen.dart';

int getSubTotal(List<Makanan> makanan, List<int> tapCounts) {
  int subHarga = 0;
  for (int i = 0; i < makanan.length; i++) {
    subHarga += makanan[i].hargaMakanan! * tapCounts[i];
  }
  return subHarga;
}

Future<void> createPdf(BuildContext context, List<Makanan> makanan,
    List<int> tapCounts, String id) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final imageLogo =
      (await rootBundle.load("images/logo.jpg")).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.Padding orderDataInput() {
    return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 20),
        child: pw.Table(children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Text(
                  'Subtotal',
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  getSubTotal(makanan, tapCounts).toStringAsFixed(2),
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Text(
                  'Delivery fee',
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  "20000.00",
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(children: [
            pw.Padding(
              child: pw.Text(
                "Total",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            pw.Padding(
              child: pw.Text(
                (20000 + getSubTotal(makanan, tapCounts)).toStringAsFixed(2),
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 10),
            ),
          ])
        ]));
  }

  pw.Padding orderList() {
    return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 45),
        child: pw.Table(
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            border: pw.TableBorder.all(),
            children: List.generate(makanan.length, (index) {
              return tapCounts[index] != 0
                  ? pw.TableRow(children: [
                      pw.Center(
                        child: pw.Image(
                            pw.MemoryImage(Base64Decoder()
                                .convert(makanan[index].namaFoto as String)),
                            width: 190,
                            height: 190),
                      ),
                      pw.Center(
                        child: pw.Text(
                          makanan[index].namaMakanan!,
                          style: const pw.TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      pw.Center(
                          child: pw.Text(
                            tapCounts[index].toString(),
                            style: const pw.TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          widthFactor: 3),
                      pw.SizedBox(height: 80),
                    ])
                  : const pw.TableRow(children: []);
            })));
  }

  final pdfTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (pw.Context context) {
        return pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(
          color: PdfColor.fromHex('#FFBD59'),
        )));
      });

  doc.addPage(pw.MultiPage(
    pageTheme: pdfTheme,
    header: (pw.Context context) {
      return headerPDF();
    },
    build: (pw.Context context) {
      return [
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Image(imageInvoice, height: 140, width: 140),
        ),
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text("Order Success",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 50)),
        ),
        pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 40),
            child: pw.Container(height: 1, color: PdfColors.black)),
        pw.SizedBox(height: 20),
        orderList(),
        pw.SizedBox(height: 20),
        orderDataInput(),
        pw.SizedBox(height: 20),
        pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 40),
            child: pw.Text("Created At ${formattedDate}")),
        pw.SizedBox(height: 20),
        barcodeGaris(id),
      ];
    },
  ));

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)));
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
      child: pw.Center(
          child: pw.BarcodeWidget(
              barcode: Barcode.code128(escapes: true),
              data: id,
              width: 100,
              height: 50)));
}

pw.Center footerPDF(String formattedDate) {
  return pw.Center(
      child: pw.Text("Created At ${formattedDate}",
          style: const pw.TextStyle(color: PdfColors.blue)));
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
          shape: pw.BoxShape.rectangle,
          gradient: pw.LinearGradient(
            colors: [PdfColor.fromHex("#FCDF8A"), PdfColor.fromHex("#F38381")],
            begin: pw.Alignment.topLeft,
            end: pw.Alignment.bottomRight,
          )),
      child: pw.Center(
          child: pw.Text("Modul 8 Libary",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ))));
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 15,
        height: 15,
      ),
    ),
  );
}
