import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

enum ApiEvent { getAllShipping }

const url = "http://192.168.67.181:8000/api";

const URL_API = {
  "get_all_shipping": "$url/shipping/order-detail/list-shipping/",
  "change_status_shipping_package": "$url/shipping/order-detail/status/",
  "login": "$url/account/sign-in/"
};

const mapUrl = "https://nominatim.openstreetmap.org/search.php?";
const directionUrl = "http://router.project-osrm.org/route/v1/driving/";
const paramDirection = "?overview=false&steps=true";
// Create storage
const storage = FlutterSecureStorage();
var header = {"Content-Type": "application/json"};

class ApiBloc extends Bloc<ApiEvent, dynamic> {
  ApiBloc() : super(null);

  @override
  Stream<dynamic> mapEventToState(ApiEvent event) async* {
    switch (event) {
      case ApiEvent.getAllShipping:
        break;
    }
    throw UnimplementedError();
  }
}

Future<bool> login(Map<String, String> payload) async {
  final response = await http.post(Uri.parse(URL_API['login']!),
      body: jsonEncode(payload), headers: header);
  if (response.statusCode == 200) {
    dynamic data = jsonDecode(utf8.decode(response.bodyBytes));
    await storage.write(key: 'api_key', value: data['access']);
    return true;
  } else {
    return false;
  }
}

Future<List<dynamic>> listShipping() async {
  String api_key = await storage.read(key: 'api_key') ?? "";
  Map<String, String> authen = {"authorization": 'Bearer $api_key'};
  header.addEntries(authen.entries);
  final response =
      await http.get(Uri.parse(URL_API['get_all_shipping']!), headers: header);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }
  return [];
}

Future<bool> changeStatusShippingPackage(Map<String, dynamic> payload) async {
  final response = await http.post(
      Uri.parse(URL_API['change_status_shipping_package']!),
      body: jsonEncode(payload),
      headers: header);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkPermissionGPS() async {
  bool servicestatus = await Geolocator.isLocationServiceEnabled();
  if (servicestatus) {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  } else {
    return false;
  }
}

Future<Position> getCurrentLocation() async {
  bool permission = await checkPermissionGPS();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<dynamic> getPositionOfPlace(Map<String, dynamic> address) async {
  String addressUrl =
      "${address['ward']},${address['district']},${address['province']}";
  final response =
      await http.get(Uri.parse("${mapUrl}q=$addressUrl&format=jsonv2"));
  if (response.statusCode == 200) {
    dynamic result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  }
}

Future<dynamic> getAllPlace(List<Map<String, dynamic>> addresses) async {
  List<dynamic> results = [];
  for (var address in addresses) {
    String addressUrl =
        "${address['ward']},${address['district']},${address['province']}";
    final response =
        await http.get(Uri.parse("${mapUrl}q=$addressUrl&format=jsonv2"));
    if (response.statusCode == 200) {
      dynamic result = jsonDecode(utf8.decode(response.bodyBytes));
      results.add(result);
    }
  }
  return results;
}

Future<Map<String, dynamic>> directionsTwoPoinst(
    Map<String, double> start, Map<String, String> end) async {
  final urlDirect =
      "$directionUrl${start['lon']},${start['lat']};${end['lon']},${end['lat']}$paramDirection";
  final response = await http.get(Uri.parse(urlDirect));
  if (response.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  }
  return {};
}
