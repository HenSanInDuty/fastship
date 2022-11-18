import 'package:flutter/material.dart';
import '../api/api.dart';

class DetailPackage extends StatefulWidget {
  const DetailPackage({super.key});

  @override
  State<DetailPackage> createState() => _DetailPackageState();
}

class _DetailPackageState extends State<DetailPackage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as String?;
    final height = MediaQuery.of(context).size.height - 56;
    final width = MediaQuery.of(context).size.width - 56;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail-Shipping-Package"),
        ),
        body: Container(
          child: Column(
            children: [
              Text(data ?? "Noan"),
              ElevatedButton(
                  onPressed: () {
                    testApi();
                  },
                  child: Text("Click to test"))
            ],
          ),
        ));
  }
}
