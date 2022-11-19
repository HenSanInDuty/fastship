import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../api/api.dart';

class MapToPackage extends StatefulWidget {
  const MapToPackage({super.key});

  @override
  State<MapToPackage> createState() => _MapToPackageState();
}

class _MapToPackageState extends State<MapToPackage> {
  final Future<Position> currentLocation = getCurrentLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: currentLocation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FlutterMap(
                options: MapOptions(
                  center:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  zoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        width: 20,
                        height: 20,
                        builder: (context) => const Icon(
                          Icons.pin_drop,
                          size: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Marker(
                        point: LatLng(10.0364216, 105.7875219),
                        width: 20,
                        height: 20,
                        builder: (context) => const Icon(
                          Icons.pin_drop,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  PolygonLayer(
                    polygons: [
                      Polygon(points: [
                        LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        LatLng(10.0364216, 105.7875219)
                      ])
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Text("Has error");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
