import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/restaurantClient.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/restaurantEntity.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';

class RestaurantList extends StatefulWidget {
  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

late int userId;

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> restaurantDataList1 = [];
  TextEditingController searchController = TextEditingController();

  void getRestaurant() async {
    final restaurantDataList = await RestaurantClient.fetchAll();
    userId = await getIntValuesSF();
    setState(() {
      restaurantDataList1 = restaurantDataList;
    });
  }

  @override
  void initState() {
    getRestaurant();
    super.initState();
  }

  @override
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
        itemCount: restaurantDataList1.length,
        itemBuilder: (context, index) {
          return RestaurantCard(restaurant: restaurantDataList1[index]);
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
                          "${restaurant.postalCode} ${restaurant.city}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Opening hours: ${restaurant.openingHours} - ${restaurant.closedHours}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      UserClient.updateRes(restaurant.id, userId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeBottomView(
                                  pageRenderIndex: 2,
                                  bottomBarIndex: 2,
                                  typeDeliver: 0,
                                )),
                      );
                      showSnackBar(
                          context, 'Restaurant selected', Colors.green);
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
            // Positioned(
            //   bottom: 8,
            //   right: 8,
            //   child: Text(
            //     '${restaurant.jarak}',
            //     style: TextStyle(
            //         fontSize: 14, color: const Color.fromARGB(255, 65, 65, 65)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
  ));
}

getIntValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs.getInt('intValue') ?? 0;
  return intValue;
}
