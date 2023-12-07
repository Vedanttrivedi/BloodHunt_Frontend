import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ui/services/token_service.dart';

class BloodRequestController extends GetxController {
  RxString userId = RxString('');
  RxString selectedBloodGroup = RxString('');
  RxString selectedLocation = RxString('');
  RxInt quantity = RxInt(0);

  List<String> bloodGroups = [
    'A+',
    'B+',
    'AB+',
    'O+',
    'A-',
    'B-',
    'AB-',
    'O-',
  ];
  List<String> locations = [
    'Gandhinagar',
    'Ahmedabad',
    'Mumbai',
  ];

  Future<void> receiveBlood() async {
    if (selectedBloodGroup.isEmpty ||
        selectedLocation.isEmpty ||
        quantity.value == 0) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final apiUrl =
        'http://192.168.29.80:3000/bloodBank/receiveBlood'; // Replace with your API endpoint

    final requestBody = {
      'location': selectedLocation.value,
      'quantity': quantity.value,
      'bloodGroup': selectedBloodGroup.value,
    };
    String token = await TokenService().getToken();
    print("token is " + token);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json', 'authorization': token},
          body: jsonEncode(requestBody));
      print("request send");
      if (response.statusCode == 200) {
        print('Data sent successfully!');
        Get.snackbar(
          'Success',
          'Blood request sent successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAndToNamed("/patient");
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to send blood request!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      // Handle any exceptions or network errors
      print('Error sending data: $error');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
