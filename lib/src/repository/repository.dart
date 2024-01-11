import 'dart:convert';
import 'package:fix/src/models/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://6582c06602f747c8367a1c7d.mockapi.io/data';

  Future<List<Data>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl)) as http.Response;

      if (response.statusCode == 200) {
        List<Data> data = (jsonDecode(response.body) as List)
            .map((e) => Data.fromJson(e))
            .toList();
        return data;
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data.');
    }
  }
}
