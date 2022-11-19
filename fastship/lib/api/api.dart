import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

enum ApiEvent { getAllShipping }

const url = "https://bn-shop.herokuapp.com/api/";
const mapUrl = "https://nominatim.openstreetmap.org/search.php?";

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

Future<List<dynamic>> testApi() async {
  final response =
      await http.get(Uri.parse(url + "shipping/order-detail/list-shipping/"));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }
  return [];
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
  print(position);
  return position;
}

Future<dynamic> getPositionOfPlace(String address) async {
  final response =
      await http.get(Uri.parse("${mapUrl}q=${address}&format=jsonv2 "));
  if (response.statusCode == 200) {
    dynamic result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  }
}

Future<dynamic> getAllPlace(List<String> addresses) async {
  List<dynamic> results = [];
  for (var address in addresses) {
    final response =
        await http.get(Uri.parse("${mapUrl}q=${address}&format=jsonv2 "));
    if (response.statusCode == 200) {
      dynamic result = jsonDecode(utf8.decode(response.bodyBytes));
      results.add(result);
    }
  }

  return results;
}
