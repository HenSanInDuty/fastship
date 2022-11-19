import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shipper/shipper.dart';
import 'shipper/mapToPackage.dart';
import 'shipper/mapAllPackage.dart';
import 'shipper/detailPackage.dart';
import 'shipper/changeStatusPackage.dart';
import 'home/home.dart';
import 'authen/login.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storage = const FlutterSecureStorage();
    Future<bool> isLogin = storage.containsKey(key: 'api_key');
    return FutureBuilder(
        future: isLogin,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider<ApiBloc>(
              create: (context) => ApiBloc(),
              child: MaterialApp(
                initialRoute: snapshot.data == true ? '/' : '/login',
                routes: {
                  // When navigating to the "/" route, build the FirstScreen widget.
                  '/': (context) => const Home(),
                  '/login': (context) => const Login(),
                  '/all-shipping': (context) => const ShipperHome(),
                  '/detail-package': (context) => const DetailPackage(),
                  '/map-package': (context) => const MapToPackage(),
                  '/map-all-package': (context) => const MapAllPackage(),
                  '/change-status-package': (context) =>
                      const ChangeStatusPackage()
                },
                debugShowCheckedModeBanner: false,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("What? No way"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
