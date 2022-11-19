import 'api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shipper/shipper.dart';
import 'shipper/mapToPackage.dart';
import 'shipper/mapAllPackage.dart';
import 'shipper/detailPackage.dart';
import 'shipper/changeStatusPackage.dart';
import 'home/home.dart';

void main() {
  runApp(BlocProvider<ApiBloc>(
    create: (context) => ApiBloc(),
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Home(),
        '/all-shipping': (context) => const ShipperHome(),
        '/detail-package': (context) => const DetailPackage(),
        '/map-package': (context) => const MapToPackage(),
        '/map-all-package': (context) => const MapAllPackage(),
        '/change-status-package': (context) => const ChangeStatusPackage()
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
}
