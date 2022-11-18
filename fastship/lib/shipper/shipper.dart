import 'package:flutter/material.dart';
import 'detailPackage.dart';

class ShipperHome extends StatefulWidget {
  const ShipperHome({super.key});

  @override
  State<ShipperHome> createState() => _ShipperHomeState();
}

final List<Map<String, Object>> dumpData = [
  {
    "id": "2",
    "address": "So 2 Duong Nguyen Van Cu, NK, Can Tho",
    "customer_name": "Nhan",
    "status": "Delivery",
  },
  {
    "id": "3",
    "address": "So 2 Duong Nguyen Van Cu, NK, Can Tho",
    "customer_name": "Nhan",
    "status": "Delivery",
  },
  {
    "id": "4",
    "address": "So 2 Duong Nguyen Van Cu, NK, Can Tho",
    "customer_name": "Nhan",
    "status": "Delivery",
  }
];

class _ShipperHomeState extends State<ShipperHome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - 56;
    final width = MediaQuery.of(context).size.width - 56;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Home"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dumpData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/detail-package",
                    arguments: index.toString());
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(children: [
                    SizedBox(
                      width: width / 12 * 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Product No."),
                          Text(
                            dumpData[index]["id"].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: width / 12 * 3,
                        child: Column(
                          children: [
                            const Text("Address"),
                            Text(
                              dumpData[index]["address"].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                    SizedBox(
                        width: width / 12 * 3,
                        child: Column(
                          children: [
                            const Text("Customer"),
                            Text(
                              dumpData[index]["customer_name"].toString() ==
                                      "null"
                                  ? ""
                                  : dumpData[index]["customer_name"].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                    SizedBox(
                        width: width / 12 * 3,
                        child: Column(
                          children: [
                            const Text("Status"),
                            Text(
                              dumpData[index]["status"].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
