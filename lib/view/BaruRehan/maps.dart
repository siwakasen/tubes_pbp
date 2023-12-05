import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/BaruRehan/ListRestaurant.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.red,
            onPressed: () {
              // Navigasi ke halaman restoran (RestaurantList)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantList(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/maps.jpeg',
                width: 800, // Sesuaikan dengan lebar yang diinginkan
                height: 600, // Sesuaikan dengan tinggi yang diinginkan
                fit: BoxFit.cover, // Atur sesuai kebutuhan Anda
              ),
              Text(
                'Halaman Maps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
