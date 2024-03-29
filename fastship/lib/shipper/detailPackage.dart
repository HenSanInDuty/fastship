import 'package:flutter/material.dart';

class DetailPackage extends StatefulWidget {
  const DetailPackage({super.key});

  @override
  State<DetailPackage> createState() => _DetailPackageState();
}

class _DetailPackageState extends State<DetailPackage> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isChangeStatusBtnDisable =
        data['status'] == "Delivering" ? false : true;

    final statusFontColor = {
      "Delivering": Colors.black,
      "Cancel": Colors.redAccent,
      "Received": Colors.greenAccent
    };
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail-Shipping-Package"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PACKAGE INFORMATION",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Card(
                  child: SizedBox(
                    width: width - 32,
                    height: height / 12 * 5,
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              textCell(width - 32, "Package No:",
                                  data['id'].toString()),
                              textCell(width - 32, "Status",
                                  data['status'].toString(),
                                  color: statusFontColor[
                                      data['status'].toString()]!),
                              textCell(width - 32, "Name:",
                                  data['customer']['name']),
                              textCell(width - 32, "Phone:",
                                  data['customer']['phone']),
                              textCell(width - 32, "Address:",
                                  "${data['address']['detail']}, ${data['address']['province']}, ${data['address']['district']}, ${data['address']['ward']}"),
                              textCell(width - 32, "Payment:", data['payment']),
                              textCell(width - 32, "Total:",
                                  data['total'].toString()),
                            ],
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "ADDRESS TRACKING",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: height / 12 * 2,
                  width: width,
                  child: Center(
                      child: ElevatedButton(
                    child: const Text("Click to see detail map"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/map-package",
                          arguments: data['address']);
                    },
                  )),
                ),
                const Text(
                  "ACTION",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: height / 12 * 2,
                  width: width,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: !isChangeStatusBtnDisable
                                ? Colors.orangeAccent
                                : Colors.grey),
                        child: const Text("Change status shipping"),
                        onPressed: !isChangeStatusBtnDisable
                            ? () {
                                Navigator.pushNamed(
                                    context, "/change-status-package",
                                    arguments: data['id']);
                              }
                            : () {},
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ));
  }
}

Row textCell(double width, String title, String data,
    {Color color = Colors.black}) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(width: width / 12 * 3, child: Text(title)),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width / 12 * 8,
            child: Text(
              data,
              textAlign: TextAlign.justify,
              style: TextStyle(color: color),
            ),
          )
        ],
      )
    ],
  );
}
