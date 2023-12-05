import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/BaruRehan/home_view.dart';
import 'package:ugd2_pbp/view/BaruRehan/maps.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Cari restoran...',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapsView(),
                ),
              );
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurantData.length,
        itemBuilder: (context, index) {
          return RestaurantCard(restaurant: restaurantData[index]);
        },
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({required this.restaurant});

  void _showRestaurantDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                restaurant.description,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Jarak: ${restaurant.jarak}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFF2626),
                  ),
                  child: Text('select Restaurant'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          _showRestaurantDetails(context);
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        restaurant.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(
                '${restaurant.jarak}',
                style: TextStyle(
                    fontSize: 14, color: const Color.fromARGB(255, 65, 65, 65)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurant {
  final String name;
  final String description;
  final String jarak;

  Restaurant(
      {required this.name, required this.description, required this.jarak});
}

List<Restaurant> restaurantData = [
  Restaurant(
    name: 'Crusty Crunch’s Yogyakarta Ambarukmo',
    description:
        'Jl. Laskda Adisucipto, Depok, Yogyakarta, Daerah Istimewa Yogyakarta 55281',
    jarak: '200 m',
  ),
  Restaurant(
    name: 'Crusty Crunch’s Sultan Agung',
    description:
        'Jl. Sultan Agung no. 24. Wirogunan, Mergangsan, Daerah Istimewa Yogyakarta 55151',
    jarak: '200 m',
  ),
  Restaurant(
    name: 'Crusty Crunch’s Sudirman Jogja ',
    description:
        'Jl. Laskda Adisucipto, Depok, Yogyakarta, Daerah Istimewa Yogyakarta 55281 ',
    jarak: '200 m',
  ),
];
