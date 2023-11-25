import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<Map<String, dynamic>> makanan = [];
  List<bool> expandableState = [];
  late int itemCount = 0;
  void refresh() async {
    final data = await MakananClient.fetchAll2();
    setState(() {
      makanan = data;
      itemCount = makanan.length;
      expandableState = List.generate(itemCount, (index) => false);
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Widget bloc(double width, int index) {
    bool isExpanded = expandableState[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          expandableState[index] = !isExpanded;
        });
      },
      child: SingleChildScrollView(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 20.0, left: 20.00, top: 5.00),
          width: !isExpanded ? width * 0.4 : width * 1,
          height: !isExpanded ? width * 0.4 : width * 0.5,
          child: Column(
            children: [
              SizedBox(
                  width: !isExpanded ? 800 : 900,
                  height: !isExpanded
                      ? ((MediaQuery.of(context).size.height + 100) / 8.2)
                      : (MediaQuery.of(context).size.height / 5.5),
                  child: Image.memory(const Base64Decoder()
                      .convert(makanan[index]["namaFoto"] as String))),
              Flexible(
                flex: 1,
                child: Text(makanan[index]["namaMakanan"],
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 18,
                      color: globals.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
              ),
              Flexible(
                  flex: 1,
                  child: Text(
                    !isExpanded ? '' : makanan[index]["hargaMakanan"],
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ListTile scrollViewItem(int index) {
    Makanan b = Makanan(
        namaMakanan: makanan[index]["namaMakanan"],
        hargaMakanan: makanan[index]["hargaMakanan"].toString(),
        namaFoto: makanan[index]["namaFoto"]);
    return ListTile(
      leading:
          Image.memory(const Base64Decoder().convert(b.namaFoto as String)),
      title: Text(b.namaMakanan!),
      subtitle: Text(b.hargaMakanan!),
      onTap: () {},
    );
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: List.generate(itemCount, (index) {
          return scrollViewItem(index);
        }),
      ),
    ));
  }
}
