import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugd2_pbp/client/ratingClient.dart';
import 'package:ugd2_pbp/entity/itemEntity.dart';
import 'package:ugd2_pbp/entity/ratingEntity.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';
import 'package:ugd2_pbp/view/order/history_page.dart';

class RatingView extends StatefulWidget {
  RatingView(
      {super.key,
      required this.transaksi,
      required this.itemsInThisTransaction,
      required this.imageLink,
      this.rating});
  Transaksi transaksi;
  List<Item> itemsInThisTransaction;
  List<String> imageLink;
  Rating? rating;

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  late Transaksi transaksi;
  late List<Item> itemsInThisTransaction;
  late List<String> imageLink;
  late Rating rating;
  bool isUpdate = false;

  TextEditingController rateStarController = TextEditingController();
  TextEditingController textReviewController = TextEditingController();

  void getRating() async {
    List<Rating> ratingFromDatabase = await RatingClient.fetchAll();

    rating = Rating(id_transaksi: -1);

    for (var rat in ratingFromDatabase) {
      if (rat.id_transaksi == widget.transaksi.id) {
        rating = rat;
        isUpdate = true;
        break;
      }
    }
  }

  @override
  void initState() {
    getRating();
    transaksi = widget.transaksi;
    itemsInThisTransaction = widget.itemsInThisTransaction;
    imageLink = widget.imageLink;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.pop(context, false);
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ratings',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD600),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: List.generate(
                                itemsInThisTransaction.length,
                                (index) => orderDetails(index)),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Image(
                                    image:
                                        AssetImage('images/icon_verify.png')),
                              ),
                              Text(
                                "IDR 220.000",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          height: 40,
                          child: const Text(
                            "How was the foods?",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            rateStarController.text = rating.toInt().toString();
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(18),
                          child: TextFormField(
                            controller: textReviewController,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Tell us more (Optional)",
                              hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 140, 140, 140)),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
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
            onPressed: () async {
              Rating ratingOutput = await onSubmit();
              setState(() {
                Navigator.pop(context, ratingOutput);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HistoryOrderView(),
                //     ));
              });
            },
            child: const Text(
              "Submit",
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

  Widget orderDetails(index) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: ExtendedImage.network(
            imageLink
                .where((element) =>
                    element.contains(itemsInThisTransaction[index].photo))
                .first,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            cache: true,
          ),
        ),
        Container(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemsInThisTransaction[index].name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                "IDR ${itemsInThisTransaction[index].price}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  Rating onSubmit() {
    Rating ratingYangDiBuat = Rating(
        id_transaksi: transaksi.id,
        notes: textReviewController.text,
        stars: int.parse(rateStarController.text));
    if (isUpdate) {
      print("UPDATE RATING");
      RatingClient.update(ratingYangDiBuat, rating.id);
    } else {
      print("CREATE RATING");
      RatingClient.create(ratingYangDiBuat);
    }

    return ratingYangDiBuat;
  }
}
