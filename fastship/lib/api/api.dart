import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> testApi() async {
  final response =
      await http.get(Uri.parse("https://bn-shop.herokuapp.com/api/products/"));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    print(data[0]['agency']['id']);
  } else {
    return "Fail to load data";
  }
  return "Noan";
}
