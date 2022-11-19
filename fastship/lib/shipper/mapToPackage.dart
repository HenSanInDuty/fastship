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
  @override
  Widget build(BuildContext context) {
    final address =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Future<Position> currentLocation = getCurrentLocation();
    final Future<dynamic> position = getPositionOfPlace(address);
    return Scaffold(
      appBar: AppBar(title: const Text("Direction Map")),
      body: FutureBuilder(
          future: Future.wait([currentLocation, position]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, String> endpoint = {};
              Map<String, double> startpoint = {};
              //If map find the way of endpoint
              if (snapshot.data?[1] != []) {
                endpoint['lat'] = snapshot.data?[1]![0]['lat'];
                endpoint['lon'] = snapshot.data?[1]![0]['lon'];
                startpoint['lat'] = snapshot.data?[0]!.latitude;
                startpoint['lon'] = snapshot.data?[0]!.longitude;
                final Future<Map<String, dynamic>> direction =
                    directionsTwoPoinst(startpoint, endpoint);
                return FutureBuilder(
                  future: direction,
                  builder: (context, subSnapshot) {
                    if (subSnapshot.hasData) {
                      if (subSnapshot.data == {}) {
                        return const Center(
                          child: Text("Don't have any data ?"),
                        );
                      }
                      var routes =
                          subSnapshot.data!['routes']![0]!['legs']![0]['steps'];
                      var endMark = routes.length - 1;
                      return FlutterMap(
                        options: MapOptions(
                          center: LatLng(snapshot.data?[0]!.latitude,
                              snapshot.data?[0]!.longitude),
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
                                point: LatLng(snapshot.data?[0]!.latitude,
                                    snapshot.data?[0]!.longitude),
                                width: 30,
                                height: 30,
                                builder: (context) => const Icon(
                                  Icons.location_pin,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Marker(
                                point: LatLng(
                                    routes[endMark]['maneuver']['location'][1],
                                    routes[endMark]['maneuver']['location'][0]),
                                width: 30,
                                height: 30,
                                builder: (context) => const Icon(
                                  Icons.location_pin,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(points: [
                                LatLng(snapshot.data?[0]!.latitude,
                                    snapshot.data?[0]!.longitude),
                                ...[
                                  for (var route in routes)
                                    for (var location in route['intersections'])
                                      LatLng(location['location'][1],
                                          location['location'][0])
                                ]
                              ], color: Colors.blue, strokeWidth: 2)
                            ],
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Has unexpected error"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
              //If map can't find the way of endpoint
              return FlutterMap(
                options: MapOptions(
                  center: LatLng(snapshot.data?[0]!.latitude,
                      snapshot.data?[0]!.longitude),
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
                        point: LatLng(snapshot.data?[0]!.latitude,
                            snapshot.data?[0]!.longitude),
                        width: 30,
                        height: 30,
                        builder: (context) => const Icon(
                          Icons.location_pin,
                          size: 30,
                          color: Colors.blueAccent,
                        ),
                      )
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
