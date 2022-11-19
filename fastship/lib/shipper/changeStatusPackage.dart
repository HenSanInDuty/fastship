import 'package:flutter/material.dart';

import '../api/api.dart';

class ChangeStatusPackage extends StatefulWidget {
  const ChangeStatusPackage({super.key});

  @override
  State<ChangeStatusPackage> createState() => _ChangeStatusPackageState();
}

const list = [
  ["0", "Delivery Success"],
  ["1", "Delivery Unsuccess"],
  ["2", "Customer cancel"]
];

const reverseListStatus = {
  "Delivery Success": "0",
  "Delivery Unsuccess": "1",
  "Customer cancel": "2"
};

const btnColorStat = {
  "Delivery Success": Colors.greenAccent,
  "Delivery Unsuccess": Colors.orangeAccent,
  "Customer cancel": Colors.red
};

class _ChangeStatusPackageState extends State<ChangeStatusPackage> {
  String dropdownValue = list[0][1];
  Color btnColor = Colors.greenAccent;
  bool btnLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController note = new TextEditingController();
    final idOrderDetail = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: const Text("Change status package")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: note,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Note',
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    btnColor = btnColorStat[dropdownValue]!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((List<String> value) {
                  return DropdownMenuItem<String>(
                    value: value[1],
                    child: Text(value[1]),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: btnColor),
                onPressed: btnLoading
                    ? () {}
                    : () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext subContext) => AlertDialog(
                            title: const Text('Confirm'),
                            content: const Text(
                                'Are you sure to perform this action ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(subContext, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(subContext, 'Sure');
                                  setState(() {
                                    btnLoading = true;
                                  });
                                  Map<String, dynamic> payload = {
                                    'order_detail': idOrderDetail,
                                    'note': note.text,
                                    'substatus':
                                        reverseListStatus[dropdownValue]
                                  };
                                  bool status =
                                      await changeStatusShippingPackage(
                                          payload);
                                  setState(() {
                                    btnLoading = false;
                                  });

                                  if (status) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar("Change status successful"));
                                    Future.delayed(Duration(seconds: 2));
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar("Change status unsuccessful"));
                                  }
                                },
                                child: const Text('Sure'),
                              ),
                            ],
                          ),
                        );
                      },
                child: btnLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      )
                    : const Text("Confirm"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

SnackBar snackBar(String content) {
  return SnackBar(
    content: Text(content),
  );
}
