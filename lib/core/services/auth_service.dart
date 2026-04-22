import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventory_management/logger.dart';

class Authservice {
  final String clientId = dotenv.get('CLIENT_ID');

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(dotenv.get('COGNITO_URL')),
      headers: {
        "Content-Type": "application/x-amz-json-1.1",
        "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
      },
      body: jsonEncode({
        "AuthParameters": {
          "USERNAME": email,
          "PASSWORD": password,
        },
        "AuthFlow": "USER_PASSWORD_AUTH",
        "ClientId": clientId,
      }),
    );

    final data = jsonDecode(response.body);

    logger.d("data: $data");

    if (response.statusCode != 200) {
      throw Exception(data["message"] ?? "Erro no login");
    }

     if (data["ChallengeName"] != null) {
      throw Exception("Necessário trocar senha (NEW_PASSWORD_REQUIRED)");
    }

    return data["AuthenticationResult"]?["AccessToken"];
  }
}
