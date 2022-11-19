import 'package:flutter/material.dart';
import 'detailPackage.dart';
import '../api/api.dart';

class ShipperHome extends StatefulWidget {
  const ShipperHome({super.key});

  @override
  State<ShipperHome> createState() => _ShipperHomeState();
}

class _ShipperHomeState extends State<ShipperHome> {
  final Future<dynamic> _all_shipping = listShipping();

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

  final colorTheme = {
    "Delivering": {"background": Colors.white, "font": Colors.black},
    "Cancel": {"background": Colors.redAccent, "font": Colors.white},
    "Received": {"background": Colors.greenAccent, "font": Colors.white}
  };

  Widget ListViewAll(double width, List<dynamic> listShipping) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listShipping.length,
        itemBuilder: (context, index) {
          Color backgroundColor =
              colorTheme[listShipping[index]['status']]!['background']!;
          Color fontColor = colorTheme[listShipping[index]['status']]!['font']!;

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detail-package",
                  arguments: listShipping[index]);
            },
            child: Card(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(children: [
                  SizedBox(
                    width: width / 12 * 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Product No.",
                          style: TextStyle(color: fontColor),
                        ),
                        Text(listShipping[index]["id"].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: fontColor))
                      ],
                    ),
                  ),
                  SizedBox(
                      width: width / 12 * 3,
                      child: Column(
                        children: [
                          Text("Address", style: TextStyle(color: fontColor)),
                          Text(
                              listShipping[index]["address"]["province"] +
                                  " " +
                                  listShipping[index]["address"]["district"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: fontColor)),
                        ],
                      )),
                  SizedBox(
                      width: width / 12 * 3,
                      child: Column(
                        children: [
                          Text("Customer", style: TextStyle(color: fontColor)),
                          Text(listShipping[index]['customer']['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: fontColor)),
                        ],
                      )),
                  SizedBox(
                      width: width / 12 * 3,
                      child: Column(
                        children: [
                          Text("Status", style: TextStyle(color: fontColor)),
                          Text(listShipping[index]["status"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: fontColor)),
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
