import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/logger.dart';

class Apiservice {
  final String baseUrl = dotenv.get('API_URL');

  String? token;

  Future<List<dynamic>> getProducts() async {
    logger.d("Token: $token");
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      throw Exception("Erro API: ${response.body}");
    }

    final data = jsonDecode(response.body);
    if (data is! List) {
      throw Exception("Resposta inválida: $data");
    }

    return data;
  }
}
