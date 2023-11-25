import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/adminView/add_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ListFoodView extends StatefulWidget {
  const ListFoodView({super.key});

  @override
  State<ListFoodView> createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  stt.SpeechToText? _speech;
  TextEditingController searchController = TextEditingController();
  bool _isListening = false;
  List<Map<String, dynamic>> makanan = [];
  String searchText = '';

  void refresh() async {
    final data = await MakananClient.fetchAll2();
    setState(() {
      makanan = data;
    });
  }

  @override
  void initState() {
    refresh();
    _speech = stt.SpeechToText();
    _speech?.initialize(onStatus: (status) {
      if (status == stt.SpeechToText.listeningStatus) {
        setState(() {
          _isListening = true;
        });
      }
    });
    super.initState();
  }

  Slidable slidableList(int index) {
    Makanan m = Makanan(
        namaMakanan: makanan[index]["namaMakanan"],
        hargaMakanan: makanan[index]["hargaMakanan"].toString(),
        id: makanan[index]["id"],
        namaFoto: makanan[index]["namaFoto"]);

    return Slidable(
      child: ListTile(
        title: Text(m.namaMakanan!),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(m.hargaMakanan!),
          ],
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Update',
          color: Colors.blue,
          icon: Icons.update,
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InputMakanan(
                        id: m.id,
                        namaMakanan: m.namaMakanan,
                        hargaMakanan: m.hargaMakanan,
                        namaFoto: m.namaFoto,
                      )),
            ).then((_) => refresh());
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await MakananClient.delet(m.id!);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TAMBAH MAKANAN"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputMakanan(
                      id: null,
                      namaMakanan: null,
                      hargaMakanan: null,
                      namaFoto: null,
                    ),
                  ),
                ).then((_) => refresh());
              },
            ),
          ],
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  searchMakanan(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_off),
                    onPressed: () {
                      if (!_isListening) {
                        startListening();
                      } else {
                        stopListening();
                      }
                    },
                  ),
                ),
              )),
          Expanded(
              child: ListView.builder(
            itemCount: makanan.length,
            itemBuilder: (context, index) {
              if (makanan[index]['namaMakanan']
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                  makanan[index]['hargaMakanan']
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())) {
                return slidableList(index);
              } else {
                return Container();
              }
            },
          ))
        ]));
  }

  void searchMakanan(String searchQuery) async {
    final data = await SQLMakanan.getMakananByKeyword(searchQuery);
    setState(() {
      makanan = data;
    });
  }

  Future<void> deleteMakanan(int id) async {
    await SQLMakanan.deletemakanan(id);
    refresh();
  }

  void startListening() {
    if (_speech!.isAvailable) {
      _speech?.listen(
        localeId: 'id_ID',
        onResult: (result) {
          setState(() {
            searchText = result.recognizedWords;
            searchController.text = searchText;
          });
        },
      );
    }
    setState(() {
      _isListening = true;
    });
  }

  void stopListening() {
    _speech?.stop();
    setState(() {
      _isListening = false;
    });
  }
}
