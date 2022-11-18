import 'package:flutter/material.dart';
import 'shipper/shipper.dart';
import 'shipper/detailPackage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const ShipperHome(),
      '/detail-package': (context) => const DetailPackage()
    },
    debugShowCheckedModeBanner: false,
  ));
}
