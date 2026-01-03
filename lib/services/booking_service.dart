import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/booking.dart';

class BookingService {
  static Future<List<Booking>> fetchBookings(int userId) async {
    final response = await http.post(
      Uri.parse(Constants.bookingApi),
      body: {
        "user_id": userId.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load bookings");
    }

    final decoded = jsonDecode(response.body);

    final List data = decoded['bookings'];

    return data
        .map<Booking>((json) => Booking.fromJson(json))
        .toList();
  }
}
