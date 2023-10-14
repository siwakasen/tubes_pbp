import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
import 'package:ugd2_pbp/view/adminView/addMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListFoodView extends StatefulWidget {
  const ListFoodView({super.key});

  @override
  State<ListFoodView> createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  List<Map<String, dynamic>> makanan = [];
  void refresh() async {
    final data = await SQLMakanan.getmakanan();
    setState(() {
      makanan = data;
    });
  }

  void initState() {
    refresh();
    super.initState();
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
                            )),
                  ).then((_) => refresh());
                }),
          ],
        ),
        body: ListView.builder(
            itemCount: makanan.length,
            itemBuilder: (context, index) {
              return Slidable(
                child: ListTile(
                  title: Text(makanan[index]['namaMakanan']),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(makanan[index]['hargaMakanan']),
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
                                  id: makanan[index]['id'],
                                  namaMakanan: makanan[index]['namaMakanan'],
                                  hargaMakanan: makanan[index]['hargaMakanan'],
                                  namaFoto: makanan[index]['namaFoto'],
                                )),
                      ).then((_) => refresh());
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      await deleteMakanan(makanan[index]['id']);
                    },
                  )
                ],
              );
            }));
  }

  Future<void> deleteMakanan(int id) async {
    await SQLMakanan.deletemakanan(id);
    refresh();
  }
}
