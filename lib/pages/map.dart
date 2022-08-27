import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  final double latitude;
  final double longitude;
  const Map({Key? key, required this.longitude, required this.latitude})
      : super(key: key);

  @override
  State<Map> createState() => _MapState(this.latitude, this.longitude);
}

class _MapState extends State<Map> {
  double latitude;
  double longitude;
  late final MapController mapController;
  _MapState(this.longitude, this.latitude);
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: Colors.amber[900],
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
              onTap: () async{
               var permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                setState(() {
                  latitude = position.latitude;
                  longitude = position.longitude;
                });
                mapController.move(LatLng(position.latitude,position.longitude),10.00
                );

              },
              child: Icon(
                Icons.place, // add custom icons also
              ),
            ),
          ),
        ],
      ),
      body: Flex(direction: Axis.vertical, children: [
        Flexible(
          flex: 1,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(latitude, longitude),
              zoom: 10.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayerOptions(markers: [
                Marker(
                  point: LatLng(latitude, longitude),
                  width: 18,
                  height: 18,
                  builder: (context) => Icon(
                    Icons.place,
                    color: Colors.amber,
                    size: 34.0,
                  ),
                ),
              ])
            ],
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
