import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/service.dart';

class ServiceService {
  static Future<List<Service>> fetchServices() async {
    final response = await http.get(
      Uri.parse(Constants.displayServiceApi),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load services");
    }

    final decoded = jsonDecode(response.body);

    final List data = decoded['services'];

    return data
        .map<Service>((json) => Service.fromJson(json))
        .toList();
  }
}
