import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/detailTransaksiClient.dart';
import 'package:ugd2_pbp/client/itemClient.dart';
import 'package:ugd2_pbp/entity/detailTransaksiEntity.dart';
import 'package:ugd2_pbp/components/order_items.dart';
import 'package:ugd2_pbp/components/summary.dart';
import 'package:ugd2_pbp/components/transaction_details.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';
import 'package:ugd2_pbp/view/order/history_page.dart';
import 'package:ugd2_pbp/view/order/order_progress_page.dart';

class OrderCompleteView extends StatefulWidget {
  OrderCompleteView(
      {super.key, required this.transaksi, required this.detailTrans});
  Transaksi transaksi;
  List<DetailTransaksi> detailTrans;
  @override
  State<OrderCompleteView> createState() => _OrderCompleteViewState();
}

class _OrderCompleteViewState extends State<OrderCompleteView> {
  List<Item> items = [];
  late Transaksi transaksi;
  List<Item> itemFromDatabase = [];
  List<String> listUkuran = [];
  List<DetailTransaksi> detailTrans = [];

  void refresh() async {
    itemFromDatabase = await ItemClient.fetchAll();
    detailTrans = await DetailTransaksiClient.find(widget.transaksi.id);

    for (var dt in widget.detailTrans) {
      print(dt.id_item);
      items.add(
          itemFromDatabase.where((element) => element.id == dt.id_item).first);
      listUkuran.add(itemFromDatabase
          .where((element) => element.id == dt.id_item)
          .first
          .size);
    }

    setState(() {
      items = detailTrans
          .map((trans) =>
              itemFromDatabase.firstWhere((item) => trans.id_item == item.id))
          .toList();
    });
  }

  @override
  void initState() {
    refresh();
    transaksi = widget.transaksi;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 50),
          Container(
            width: screenWidth,
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage('images/icon_correct.png'),
            ),
          ),
          Container(
            width: screenWidth,
            child: Center(
              child: const Text(
                "Order Success",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: screenWidth,
              child: Column(
                children: List.generate(items.length,
                    (index) => listItem(index, items, widget.detailTrans)),
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
            child: summary(transaksi, 10, 10),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: screenWidth / 2 - 10,
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderProcessView(),
                          ),
                        );
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    highlightColor: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Check Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: screenWidth / 2 - 10,
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeBottomView(
                                bottomBarIndex: 0,
                                pageRenderIndex: 0,
                                typeDeliver: 0),
                          ),
                        );
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    highlightColor: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
