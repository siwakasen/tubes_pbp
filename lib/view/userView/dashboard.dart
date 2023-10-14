import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class GriddView extends StatefulWidget {
  const GriddView({super.key});

  @override
  State<GriddView> createState() => _GriddViewState();
}

const itemCount = 8;

class _GriddViewState extends State<GriddView> {
  List<bool> expandableState = List.generate(itemCount, (index) => false);
  List<String> gambar = [
    "sumsum.jpg",
    "ayamsmackdown.jpg",
    "nasgor.jpeg",
    "rendang.png",
    "sate.jpg",
    "soto.jpg",
    "naspad.jpeg",
    "rawon.jpg"
  ];
  List<String> namaMakanan = [
    "BUBUR SUMSUM",
    "AYAM GEPREK",
    "NASI GORENG",
    "RENDANG",
    "SATE",
    "SOTO",
    "NASI PADANG",
    "RAWON"
  ];
  List<String> hargaMakanan = [
    'Price : Rp.15.000,00',
    'Price : Rp.10.000,00',
    'Price : Rp.12.000,00',
    'Price : Rp.25.000,00',
    'Price : Rp.15.000,00',
    'Price : Rp.10.000,00',
    'Price : Rp.13.000,00',
    'Price : Rp.12.000,00',
    'Price : Rp.14.000,00'
  ];

  Widget bloc(double width, int index) {
    bool isExpanded = expandableState[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          expandableState[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 20.0, left: 20.00, top: 5.00),
        width: !isExpanded ? width * 0.4 : width * 1,
        height: !isExpanded ? width * 0.4 : width * 0.5,
        child: Column(
          children: [
            SizedBox(
              width: !isExpanded ? 500 : 800,
              height: !isExpanded
                  ? (MediaQuery.of(context).size.height / 7)
                  : (MediaQuery.of(context).size.height / 5.5),
              child: Image.asset("images/" + gambar[index]),
            ),
            Flexible(
              flex: 1,
              child: Text(namaMakanan[index],
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
                  !isExpanded ? '' : hargaMakanan[index],
                  textAlign: TextAlign.center,
                )),
          ],
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
