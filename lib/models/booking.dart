class Booking {
  final int id;
  final int userId;
  final int serviceId;
  final String bookingDate;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.bookingDate,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      serviceId: int.parse(json['service_id'].toString()),
      bookingDate: json['booking_date'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'service_id': serviceId,
      'booking_date': bookingDate,
      'status': status,
    };
  }
}
