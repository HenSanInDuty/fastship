import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

enum ApiEvent { getAllShipping }

const url = "https://bn-shop.herokuapp.com/api/";

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
