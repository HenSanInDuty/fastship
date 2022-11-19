import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
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
                child: const Text("Map tracking all shipping"))
          ],
        ));
  }
}
