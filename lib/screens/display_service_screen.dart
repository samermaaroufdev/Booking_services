import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:booking_services/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:booking_services/widgets/display_service_card.dart';
Future<List<dynamic>> fetchServices() async{
  final response=await http.get(
    Uri.parse(Constants.display_service_api));
    if(response.statusCode!=200){
      throw Exception("Failed to load services");
    }
    final data=jsonDecode(response.body);
    return data['services'];
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Services')),
    body: FutureBuilder<List<dynamic>>(
      future: fetchServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        final services = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(service: service);
            },
          ),
        );
      },
    ),
  );
}
