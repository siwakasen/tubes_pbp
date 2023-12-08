import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/detailTransaksiClient.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:ugd2_pbp/client/subsClient.dart';
import 'package:ugd2_pbp/client/subsUserClient.dart';
import 'package:ugd2_pbp/client/voucherClient.dart';
import 'package:ugd2_pbp/entity/detailTransaksiEntity.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/components/order_items.dart';
import 'package:ugd2_pbp/components/summary.dart';
import 'package:ugd2_pbp/components/transaction_details.dart';
import 'package:ugd2_pbp/entity/subscriptionEntity.dart';
import 'package:ugd2_pbp/entity/subsuserEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/entity/voucherEntity.dart';
import 'package:ugd2_pbp/view/order/nota/note_pdf_builder.dart';

class OrderNoteView extends StatefulWidget {
  const OrderNoteView({super.key, required this.transaksi});
  final Transaksi transaksi;
  @override
  State<OrderNoteView> createState() => _OrderNoteViewState();
}

class _OrderNoteViewState extends State<OrderNoteView> {
  List<DetailTransaksi> deTrans = [];
  List<Item> item = [];
  List<Item> items = [];
  List<Voucher> voucher = [];
  List<Subscription> subs = [];
  SubscriptionUser subuser = SubscriptionUser.empty();
  int voucherCut = 0;
  int percentage = 0;

  void refresh() async {
    deTrans = await DetailTransaksiClient.find(widget.transaksi.id);
    item = await ItemClient.fetchAll();
    voucher = await VoucherClient.fetchAll();
    subs = await SubsClient.fetchAll();
    subuser = await SubsUserClient.find(widget.transaksi.id_user);

    setState(() {
      items = deTrans
          .map((trans) => item.firstWhere((item) => trans.id_item == item.id))
          .toList();
      voucherCut = voucher
          .firstWhere((voucher) => voucher.id == widget.transaksi.id_voucher,
              orElse: () => Voucher.empty())
          .cut_price;
      percentage = subs
          .firstWhere((subs) => subs.id == subuser.id_subscription,
              orElse: () => Subscription.empty())
          .percentage;
    });
  }

  @override
  void initState() {
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
                    items.length, (index) => listItem(index, items, deTrans)),
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
            child: transDetails(widget.transaksi),
          ),
          Container(
            //Container payment method
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            width: screenWidth,
            child: summary(widget.transaksi, voucherCut, percentage),
          ),
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
