import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:extended_image/extended_image.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<Makanan> makanan = [];
  List<bool> expandableState = [];
  late int itemCount = 0;
  late Response response;
  late Response response1;
  List<String> imageLink = [];
  List<Makanan> makanan2 = [];

  void refresh() async {
    final makanan2 = await MakananClient.fetchAll();
    imageLink = List.filled(makanan2.length, '');
    try {
      response1 = await MakananClient.getAllImageMakanan();
      imageLink = json.decode(response1.body)['data'].cast<String>();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      makanan = makanan2;
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
                  child: ExtendedImage.network(
                    imageLink[index],
                    width: 400,
                    height: 400,
                    fit: BoxFit.fill,
                    cache: true,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    //cancelToken: cancellationToken,
                  )),
              Flexible(
                flex: 1,
                child: Text(makanan[index].namaMakanan!,
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
                    !isExpanded ? '' : makanan[index].hargaMakanan!.toString(),
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
        namaMakanan: makanan[index].namaMakanan!,
        hargaMakanan: makanan[index].hargaMakanan,
        namaFoto: imageLink[index]);
    return ListTile(
      leading: Image.network(b.namaFoto!),
      title: Text(b.namaMakanan!),
      subtitle: Text(b.hargaMakanan!.toString()),
      onTap: () {},
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: SingleChildScrollView(
  //     child: Column(
  //       children: List.generate(itemCount, (index) {
  //         return scrollViewItem(index);
  //       }),
  //     ),
  //   ));
  // }
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(itemCount, (index) {
            return bloc(width, index); // Use the bloc function here
          }),
        ),
      ),
    );
  }
}
