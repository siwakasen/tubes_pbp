import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/maps/map.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      // Handle changes in the search input
                    },
                    decoration: InputDecoration(
                      hintText: 'What do you want to eat?',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
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
                PromoItem(imagePath: 'images/promo.png'),
                PromoItem(imagePath: 'images/promo.png'),
                PromoItem(imagePath: 'images/promo.png'),
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
                GridItem(imagePath: 'images/drink.png'),
                GridItem(imagePath: 'images/snacks.png'),
                GridItem(imagePath: 'images/food.png'),
                GridItem(imagePath: 'images/combo.png'),
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
