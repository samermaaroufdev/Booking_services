import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.loginApi),
        body: {
          "email": email.trim(),
          "password": password.trim(),
        },
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        return {
          "success": true,
          "message": data["message"] ?? "Login successful",
          "user": data["user"],
        };
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Invalid email or password",
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Server error. Please try again.",
      };
    }
  }

  static Future<Map<String, dynamic>> register(
      String name,
      String email,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.registerApi),
        body: {
          "name": name.trim(),
          "email": email.trim(),
          "password": password.trim(),
        },
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        return {
          "success": true,
          "message": data["message"] ?? "Registration successful",
        };
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Registration failed",
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Server error. Please try again.",
      };
    }
  }
}
