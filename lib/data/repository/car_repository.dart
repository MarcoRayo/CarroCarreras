import 'dart:convert';

import '../models/race_car_model.dart';
import 'package:http/http.dart' as http;

class CarRepository {
  final String apiUrl;
  //final String accessToken;

  CarRepository({required this.apiUrl
    //  , required this.accessToken
  });

  Future<void> createCar(CarModel car) async {
    final response = await http.post(
      Uri.parse('$apiUrl/Prod/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(car.toJson()..remove('id')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create car');
    }
  }

  Future<CarModel> getCar(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/cars/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return CarModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load car');
    }
  }

  Future<void> updateCar(CarModel car) async {
    final response = await http.put(
      Uri.parse('$apiUrl/cars'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update car');
    }
  }

  Future<void> deleteCar(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/users/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future<List<CarModel>> getAllCars() async {
    final response = await http.get(
      Uri.parse('$apiUrl/Prod/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<CarModel>.from(l.map((model) => CarModel.fromJson(model)));
    } else {
      throw Exception('Failed to load cars');
    }
  }
}