import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:booking_services/utils/constants.dart';
import 'package:booking_services/widgets/display_service_card.dart';
import 'package:booking_services/models/service.dart';

class DisplayServiceScreen extends StatelessWidget {
  const DisplayServiceScreen({super.key});

  Future<List<Service>> fetchServices() async {
    final response =
    await http.get(Uri.parse(Constants.displayServiceApi));

    if (response.statusCode != 200) {
      throw Exception("Failed to load services");
    }

    final decoded = jsonDecode(response.body);

    final List servicesJson = decoded['services'];

    return servicesJson
        .map<Service>((json) => Service.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4F46E5), Color(0xFF9333EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Text(
                      "Services",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FutureBuilder<List<Service>>(
                    future: fetchServices(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final services = snapshot.data!;

                      if (services.isEmpty) {
                        return const Center(
                          child: Text("No services available"),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          itemCount: services.length,
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 3 / 2,
                          ),
                          itemBuilder: (context, index) {
                            return DisplayServiceCard(
                              service: services[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
