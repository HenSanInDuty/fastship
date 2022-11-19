import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/all-shipping");
                },
                child: const Text("All shipping")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/map-all-package");
                },
                child: const Text("Map tracking all shipping")),
            ElevatedButton(
                onPressed: () async {
                  await storage.delete(key: 'api_key');
                  Navigator.pushNamed(context, "/login");
                },
                child: const Text("Logout"))
          ],
        ));
  }
}
