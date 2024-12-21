import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<LatLng> routePoint = const [
    LatLng(33.511566, 36.295008),
    LatLng(33.510817, 36.300642),
    LatLng(33.512789, 36.300508),
    LatLng(33.51153, 36.305774),
    LatLng(33.511798, 36.310463),
    LatLng(33.513702, 36.315394),
    LatLng(33.517678, 36.316634),
    LatLng(33.514933, 36.31746),
    LatLng(33.50905, 36.317993),
    LatLng(33.508376, 36.301328),
    LatLng(33.503143, 36.304046),
    LatLng(33.505375, 36.295302),
    LatLng(33.499207, 36.300421),
    LatLng(33.505671, 36.28925),
    LatLng(33.513427, 36.277071),
    LatLng(33.52039, 36.296216),
    LatLng(33.52891, 36.293586),
    LatLng(33.527078, 36.306512),
    LatLng(33.510129, 36.289903),
    LatLng(33.509894, 36.28748),
    LatLng(33.510599, 36.278968),
    LatLng(33.504552, 36.274102),
    LatLng(33.50814, 36.268973),
  ];
  void markersFun() {
    for (var i = 0; i < routePoint.length; i++) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: routePoint[i],
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    }
  }

  List<Marker> markers = [];

  final String orsApiKey =
      '5b3ce3597851110001cf62482cdd6c02f15040a08ce2883205b6bdb9';

  @override
  void initState() {
    super.initState();
    markersFun();
    // _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();

    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child:
                const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
          ),
        );
      });
    } on Exception {
      currentLocation = null;
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;

    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        routePoints =
            coords.map((coord) => LatLng(coord[1], coord[0])).toList();
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: destination,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          ),
        );
      });
    } else {
      // Handle errors
      print('Failed to fetch route');
    }
  }

  void _addDestinationMarker(LatLng point) {
    print(point);
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    });
    _getRoute(point);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap with Flutter'),
      ),
      body:
          //  currentLocation == null
          //     ? const Center(child: CircularProgressIndicator()):
          FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(33.5093553, 36.2939167),
          initialZoom: 15.0,
          // onTap: (tapPosition, point) => _addDestinationMarker(point),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: markers,
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.move(
            LatLng(33.5093553, 36.2939167),
            // LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            15.0,
          );
          if (currentLocation != null) {
            mapController.move(
              LatLng(33.5093553, 36.2939167),
              // LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              15.0,
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
