import 'package:flutter/material.dart';
import 'detailPackage.dart';
import '../api/api.dart';

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
  final Future<dynamic> _all_shipping = testApi();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - 56;
    final width = MediaQuery.of(context).size.width - 56;
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Shipping"),
      ),
      body: FutureBuilder<dynamic>(
          future: _all_shipping,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const SorryWidget();
            } else if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListViewAll(width, snapshot.data);
              } else {
                return const SorryWidget();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget ListViewAll(double width, List<dynamic> listShipping) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listShipping.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detail-package",
                  arguments: listShipping[index]);
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
                          listShipping[index]["id"].toString(),
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
                            listShipping[index]["address"]["province"] +
                                listShipping[index]["address"]["district"],
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
                            listShipping[index]['customer']['name'],
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
                            listShipping[index]["status"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                ]),
              ),
            ),
          );
        });
  }
}

class SorryWidget extends StatelessWidget {
  const SorryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Sorry, but i can't find data"),
    );
  }
}
