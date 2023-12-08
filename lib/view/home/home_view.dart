import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "images/image_top.png",
            height: 160,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Promo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PromoItem(imagePath: 'images/voucher_family.png'),
                PromoItem(imagePath: 'images/voucher_hemat.png'),
                // ...
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              // Mencegah pengguliran
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              children: [
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeBottomView(
                                        pageRenderIndex: 2,
                                        bottomBarIndex: 2,
                                        typeDeliver: 2,
                                      )));
                        },
                        highlightColor: Colors.transparent,
                        child: GridItem(imagePath: 'images/drink.png'))),
                Material(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeBottomView(
                                        pageRenderIndex: 2,
                                        bottomBarIndex: 2,
                                        typeDeliver: 3,
                                      )));
                        },
                        child: GridItem(imagePath: 'images/snack.png'))),
                Material(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeBottomView(
                                        pageRenderIndex: 2,
                                        bottomBarIndex: 2,
                                        typeDeliver: 1,
                                      )));
                        },
                        child: GridItem(imagePath: 'images/food.png'))),
                Material(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeBottomView(
                                        pageRenderIndex: 2,
                                        bottomBarIndex: 2,
                                        typeDeliver: 4,
                                      )));
                        },
                        child: GridItem(imagePath: 'images/combo.png'))),
                // ...
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Rest of the code remains unchanged

class PromoItem extends StatelessWidget {
  final String imagePath;

  const PromoItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Sesuaikan dengan lebar promo item
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;

  const GridItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Sesuaikan dengan lebar yang diinginkan
      height: 50, // Sesuaikan dengan tinggi yang diinginkan
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          width: 50, // Sesuaikan dengan lebar yang diinginkan
          height: 50, // Sesuaikan dengan tinggi yang diinginkan
          fit: BoxFit.contain, // Sesuaikan dengan kebutuhan
        ),
      ),
    );
  }
}
