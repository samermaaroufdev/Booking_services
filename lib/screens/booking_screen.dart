import 'package:booking_services/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});
  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}
class _CreateBookingPageState extends State<CreateBookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;
  Future<void> submitBooking() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select date and time")),
      );
      return;
    }
    setState(() => isLoading = true);
    final response = await http.post(
      Uri.parse(Constants.createBookingApi),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "book_date":
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
        "book_time":
        "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}",
      }),
    );
    final data = jsonDecode(response.body);

    setState(() => isLoading = false);

    if (data["success"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking saved")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"])),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    selectedDate == null
                        ? "Select booking date"
                        : selectedDate.toString().split(" ")[0],
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => selectedDate = date);
                    }
                  },
                ),

                ListTile(
                  title: Text(
                    selectedTime == null
                        ? "Select booking time"
                        : selectedTime!.format(context),
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => selectedTime = time);
                    }
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submitBooking,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Save Booking"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
