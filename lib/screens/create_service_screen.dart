import 'package:flutter/material.dart';
import 'package:booking_services/utils/constants.dart';
import 'package:booking_services/widgets/create_service_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});
  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}
class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final statusController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    statusController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      CreateServiceCard(
      formKey: _formKey,
      title: titleController,
      description: descriptionController,
      price: priceController,
      status: statusController,
    ),
        const SizedBox(height:16),
        ElevatedButton(onPressed:()async {
          if (!_formKey.currentState!.validate()) return;
          try{
            final response = await http.post(
              Uri.parse(Constants.service_api),
              headers:{
                'Content-Type':'application/x-www-form-urlencoded'
              },
              body:{
                'title':titleController.text.trim(),
                'description':descriptionController.text.trim(),
                'price':priceController.text.trim(),
                'status':statusController.text.trim()
              }
            );
            if(response.statusCode!=200){
              throw Exception('Status Error');
            }
            final data=jsonDecode(response.body);
            if(!data['success']){
              throw Exception(data['message']??'Insert failed');
            }
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Service created')));
          }
          catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content:Text(e.toString()))
            );
          }

        }, child:Text('Create Service')),
    ],
    );
  }
}
