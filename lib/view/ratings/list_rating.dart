import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd2_pbp/database/sql_helperRating.dart';
import 'package:ugd2_pbp/view/ratings/add_rating.dart';

class RatingView extends StatefulWidget {
  const RatingView({super.key});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  List<Map<String, dynamic>> rating = [];
  void refresh() async {
    final data = await SQLMakanan.getRating();
    setState(() {
      rating = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Rating"),
          backgroundColor: Colors.amber[600],
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputRating(
                        id: null,
                        rateStar: null,
                        textReview: null,
                        namaFoto: null,
                      ),
                    )).then((value) => refresh());
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: rating.length, //var.length
          itemBuilder: (context, index) {
            return Slidable(
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
                          builder: (context) => InputRating(
                                id: rating[index]['id'],
                                rateStar: rating[index]['rateStar'],
                                textReview: rating[index]['textReview'],
                                namaFoto: rating[index]['namaFoto'],
                              )),
                    ).then((_) => refresh());
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    await deleteRatingFunc(rating[index]['id']);
                  },
                )
              ],
              child: ListTile(
                title: RatingBarIndicator(
                  rating: double.parse(rating[index]['rateStar']),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemSize: 20,
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rating[index]['textReview']),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteRatingFunc(int id) async {
    await SQLMakanan.deleteRating(id);
    refresh();
  }
}
