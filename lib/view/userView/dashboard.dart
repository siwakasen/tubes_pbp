import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/database/sql_helperMakanan.dart';

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
    final data = await SQLMakanan.getmakanan();
    setState(() {
      makanan = data;
      itemCount = makanan.length;
      expandableState = List.generate(itemCount, (index) => false);
    });
  }

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
          duration: Duration(milliseconds: 200),
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
                  child:
                      // Image.asset("images/" + gambar[index]),
                      Image.memory(Base64Decoder()
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Align(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(itemCount, (index) {
              return bloc(width, index);
            }),
          ),
        ),
      ),
    );
  }
}
