import 'package:flutter/material.dart';

class ChangeStatusPackage extends StatefulWidget {
  const ChangeStatusPackage({super.key});

  @override
  State<ChangeStatusPackage> createState() => _ChangeStatusPackageState();
}

class _ChangeStatusPackageState extends State<ChangeStatusPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change status package")),
      body: const Center(child: Text("Oh, hello there")),
    );
  }
}
