import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../api/api.dart';

class MapAllPackage extends StatefulWidget {
  const MapAllPackage({super.key});

  @override
  State<MapAllPackage> createState() => _MapAllPackageState();
}

final statusFontColor = {
  "Delivering": Colors.blue,
  "Cancel": Colors.redAccent,
  "Received": Colors.greenAccent
};

class _MapAllPackageState extends State<MapAllPackage> {
  final Future<dynamic> all_shipping = listShipping();
  final Future<Position> currentLocation = getCurrentLocation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Package Map")),
      body: FutureBuilder(
          future: Future.wait([currentLocation, all_shipping]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> address = [
                for (var instance in snapshot.data![1])
                  {'status': instance['status'], ...instance['address']}
              ];
              //If have many address
              if (address.isNotEmpty) {
                Future<dynamic> pointAllAddress = getAllPlace(address);
                return FutureBuilder(
                    future: pointAllAddress,
                    builder: ((context, subSnapshot) {
                      if (subSnapshot.hasError) {
                        return const Center(child: Text("Can't find data"));
                      } else if (subSnapshot.hasData) {
                        var dataInMap = subSnapshot.data;
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
                                ...[
                                  for (int i = 0;
                                      i < subSnapshot.data.length;
                                      i++)
                                    Marker(
                                      point: LatLng(
                                          double.parse(dataInMap[i][0]['lat']),
                                          double.parse(dataInMap[i][0]['lon'])),
                                      width: 30,
                                      height: 30,
                                      builder: (context) => Icon(Icons.home,
                                          size: 30,
                                          color: statusFontColor[address[i]
                                              ['status']]),
                                    ),
                                ]
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }));
              } else {
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
                          width: 20,
                          height: 20,
                          builder: (context) => const Icon(
                            Icons.pin_drop,
                            size: 20,
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    )
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return const Text("Has error");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
