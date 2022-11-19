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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(color: Colors.blue))),
                  onPressed: () {
                    Navigator.pushNamed(context, "/all-shipping");
                  },
                  icon: const Icon(Icons.local_shipping),
                  label: const Text("All shipping")),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(color: Colors.amber))),
                  onPressed: () {
                    Navigator.pushNamed(context, "/map-all-package");
                  },
                  icon: const Icon(
                    Icons.public,
                    color: Colors.amber,
                  ),
                  label: const Text(
                    "All Package On Map",
                    style: TextStyle(color: Colors.amber),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(color: Colors.grey))),
                  onPressed: () async {
                    await storage.delete(key: 'api_key');
                    setState(() {
                      Navigator.pushNamed(context, "/login");
                    });
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  label: const Text(
                    "Log out",
                    style: TextStyle(color: Colors.grey),
                  )),
            ]),
          ),
        ));
  }
}
