import 'package:flutter/material.dart';
import 'package:ugd2_pbp/lib_tubes/ListRestaurant.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ugd2_pbp/lib_tubes/components_order/summary.dart';
import 'package:ugd2_pbp/lib_tubes/order_complete_page.dart';

class MapsView extends StatefulWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  String? _currentAddress;
  MapController? _mapController;
  Position _currentPosition = Position(
      latitude: -7.779353691217627,
      longitude: 110.41544086617908,
      timestamp: DateTime.now(),
      accuracy: 2000.0,
      altitude: 0.5,
      altitudeAccuracy: 0.0,
      heading: 30.0,
      headingAccuracy: 0.0,
      speed: -122.08395287867832,
      speedAccuracy: 0.5);

  @override
  void initState() {
    _mapController = MapController();
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.manage_search_rounded),
            color: Colors.red,
            iconSize: 35,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantList()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                    _currentPosition.latitude, _currentPosition.longitude),
                initialZoom: 16.99,
              ),
              mapController: _mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.ugd2_pbp',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      width: 30.0,
                      height: 30.0,
                      child: const SizedBox(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition.latitude + 0.0017,
                          _currentPosition.longitude - 0.0014),
                      width: 30.0,
                      height: 30.0,
                      child: SizedBox(
                        child: Icon(
                          Icons.storefront_rounded,
                          color: Colors.amber[900],
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition.latitude + 0.00092,
                          _currentPosition.longitude + 0.0021),
                      width: 30.0,
                      height: 30.0,
                      child: SizedBox(
                        child: Icon(
                          Icons.storefront_rounded,
                          color: Colors.amber[900],
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition.latitude - 0.00095,
                          _currentPosition.longitude + 0.0012),
                      width: 30.0,
                      height: 30.0,
                      child: SizedBox(
                        child: Icon(
                          Icons.storefront_rounded,
                          color: Colors.amber[900],
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      mini: true,
                      onPressed: () {
                        setState(() {
                          _mapController?.move(
                              LatLng(_currentPosition.latitude,
                                  _currentPosition.longitude),
                              16.99);
                        });
                      },
                      child: const Icon(
                        Icons.navigation_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  _getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          _getAddressFromLatLng(_currentPosition);
        });
      });
    } catch (e) {
      print('$e');
      return getLastKnownPosition();
    }
  }

  getLastKnownPosition() async {
    _currentPosition = Position(
        latitude: -7.779353691217627,
        longitude: 110.41544086617908,
        timestamp: DateTime.now(),
        accuracy: 2000.0,
        altitude: 0.5,
        altitudeAccuracy: 0.0,
        heading: 30.0,
        headingAccuracy: 0.0,
        speed: -122.08395287867832,
        speedAccuracy: 0.5);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
