import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenMap extends StatefulWidget {
  const OpenMap({super.key});
  @override
  State<OpenMap> createState() => _OpenMapState();
}

class _OpenMapState extends State<OpenMap> {
  // late Position _currentPosition;
  Position _currentPosition = Position(
      longitude: -122.08395287867832,
      latitude: 37.42342342342342,
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
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition.longitude);
    print(_currentPosition.latitude);
    print(_currentPosition.timestamp);
    print(_currentPosition.accuracy);
    print(_currentPosition.altitudeAccuracy);
    print(_currentPosition.heading);
    print(_currentPosition.headingAccuracy);
    print(_currentPosition.speed);
    print(_currentPosition.longitude);
    print(_currentPosition.speedAccuracy);
    print("HEREEEEEEEEEEEEEEEEEEEEEEEEEE");
    return Stack(
      children: [
        FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(
                    _currentPosition.latitude, _currentPosition.longitude),
                initialZoom: 13.0),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.ugd2_pbp',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                        _currentPosition.latitude, _currentPosition.longitude),
                    width: 30.0,
                    height: 30.0,
                    child: Container(
                      child: Container(
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Search for your localisation",
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
