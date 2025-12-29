import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/login.php"),
      body: {
        "email": email,
        "password": password,
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/register.php"),
      body: {
        "name": name,
        "email": email,
        "password": password,
      },
    );
    return jsonDecode(response.body);
  }
}
