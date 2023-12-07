import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:ui/models/appointment_model.dart';
import 'package:ui/models/user_model.dart';

final storage = FlutterSecureStorage();

class DonorInfoController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  RxList<Appointment> appointments = <Appointment>[].obs;
  var message = "hello".obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    getAndStoreAppointments();
  }

  Future<void> getAndStoreAppointments() async {
    try {
      String? jwt = await storage.read(key: 'token');

      final String apiUrl =
          'http://192.168.29.80:3000/appointment/appointmentsList';

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': '$jwt',
        },
      );
      print("got the appoinemnt details");
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        print(data[0]);
        List<dynamic> appointmentData = data;

        appointments.assignAll(
          appointmentData
              .map((appointment) => Appointment.fromJson(appointment))
              .toList(),
        );
        print("hello");
        print(appointments);
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (error) {
      print('Error fetching appointments: $error');
    }
  }

  getData() async {
    print("getdata is called");
    String? jwt = await storage.read(key: 'token');
    String? userType = await storage.read(key: 'userType');

    final String apiUrl = 'http://192.168.29.80:3000/user/getUser';

    Map<String, String> requestBody = {
      'jwt': jwt ??
          '', // Add a default value or handle accordingly if the value is null
      'userType': userType ??
          '', // Add a default value or handle accordingly if the value is null
    };

    try {
      // Make the network call
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print("request is made");
      print(response.body);
      var data = jsonDecode(response.body);
      print("this is my data ");
      print(data["user"]);
      var userData = User.fromJson(data["user"]);
      user.value = userData;
      print(user.value);
      print("user is loaded");

      if (response.statusCode == 200) {
        // If the call to the server was successful, return the response data
        return {
          'success': true,
          'data': response.body,
        };
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the error message
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Catch any error that might occur during the process
      return {
        'success': false,
        'error': error.toString(),
      };
    }
  }

  Future<void> logoutAndNavigateToRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userType');

    Get.snackbar('Success', 'Logout successful',
        snackPosition: SnackPosition.BOTTOM);

    Get.offNamedUntil('/registration', (route) => false);
  }

  void navigateToNewScreen() {
    Get.toNamed('/donorbook');
  }
}
