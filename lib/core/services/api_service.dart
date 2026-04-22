import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  final String baseUrl = dotenv.get('API_URL');

  String? token;

  Future<List<dynamic>> getProducts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  } 
}