class Service {
  final int id;
  final String title;
  final String description;
  final double price;
  final String status;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'status': status,
    };
  }
}
