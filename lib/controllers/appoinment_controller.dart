import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentController extends GetxController {
  var data = FlutterSecureStorage();
  final String baseUrl = 'http://192.168.29.80:3000';
  var dateController = TextEditingController().obs;
  var timeController = TextEditingController().obs;
  var selectedLocation = 'Gandhinagar'.obs;

  final RxBool isLoading = false.obs;
  final RxBool appointmentError = false.obs;
  final RxString errorText = ''.obs;
  String? jwtToken = '';
  @override
  void onInit() async {
    super.onInit();
    jwtToken = await data.read(key: "token");
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      dateController.value.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.value.text = picked.format(context);
    }
  }

  Future<void> bookAppointment() async {
    isLoading.value = true;
    appointmentError.value = false;
    print("jwt " + jwtToken!);
    print("request sent");
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/appointment/appointments/'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': '${jwtToken}',
        },
        body: json.encode({
          'location': selectedLocation.value,
          'appointmentDate': dateController.value.text,
        }),
      );
      print("got the response");
      print(response.body);
      if (response.statusCode == 201) {
        Get.snackbar(
          'Appointment Booked',
          'Your appointment has been successfully booked!',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed("/donor");
      } else {
        errorText.value = 'Failed to book appointment. Please try again.';
        appointmentError.value = true;
      }
    } catch (error) {
      errorText.value = 'An error occurred. Please try again.';
      appointmentError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
