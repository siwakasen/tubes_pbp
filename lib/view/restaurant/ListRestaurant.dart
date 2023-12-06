import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';

class RestaurantList extends StatelessWidget {
  @override
  TextEditingController searchController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search Restaurant",
              hintStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              filled: true,
              fillColor: Color(0xFFD9D9D9),
              isDense: true,
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide.none,
              ),
            ),
            controller: searchController,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
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
                          restaurant.address,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          restaurant.postal_code,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Opening hours: ${restaurant.opening_hours} - ${restaurant.closing_hours}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Text("${restaurant.jarak}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins")),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      print("CK");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeBottomView(
                                  initialSelectedIndex: 0,
                                  lastKnownIndex: 0,
                                )),
                      );
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(290, 50)),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                    child: Text(
                      'Select Restaurant',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
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
                        restaurant.address,
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
  final String address;
  final String jarak;
  final String postal_code;
  final String opening_hours;
  final String closing_hours;

  Restaurant(
      {required this.name,
      required this.address,
      required this.jarak,
      required this.postal_code,
      required this.opening_hours,
      required this.closing_hours});
}

List<Restaurant> restaurantData = [
  Restaurant(
      name: 'Crusty Crunch’s Yogyakarta Ambarukmo',
      address: 'Jl. Laskda Adisucipto, Depok, Daerah Istimewa Yogyakarta ',
      jarak: '200 m',
      postal_code: '55281',
      opening_hours: '10.00',
      closing_hours: '22.00'),
  Restaurant(
      name: 'Crusty Crunch’s Sultan Agung',
      address:
          'Jl. Sultan Agung no. 24. Wirogunan, Mergangsan, Daerah Istimewa Yogyakarta ',
      jarak: '200 m',
      postal_code: '55151',
      opening_hours: '10.00',
      closing_hours: '22.00'),
  Restaurant(
      name: 'Crusty Crunch’s Sudirman Jogja ',
      address: 'Jl. Laskda Adisucipto, Depok, Daerah Istimewa Yogyakarta  ',
      jarak: '200 m',
      postal_code: '55281',
      opening_hours: '10.00',
      closing_hours: '22.00'),
];
