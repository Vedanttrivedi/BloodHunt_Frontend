import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final String baseUrl = 'http://192.168.29.80:3000';

  final RxBool isLoading = false.obs;
  final RxBool loginError = false.obs;
  final RxString errorText = ''.obs;
  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxBool passwordVisible = false.obs;
  Future<void> login() async {
    isLoading.value = true;
    loginError.value = false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username.value,
          'password': password.value,
        }),
      );
      print("gottter");
      if (response.statusCode == 200) {
        print("here");
        final responseData = json.decode(response.body);
        final token = responseData['data']['token'];
        final userType = responseData['data']["userType"];
        await saveToken(token);
        await saveUserType(userType);
        Get.snackbar(
          "Logging in",
          "Please wait...",
          showProgressIndicator: true,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        Get.offAllNamed('/home');
      } else if (response.statusCode == 401) {
        errorText.value = 'Invalid username or password';
        loginError.value = true;
      } else {
        errorText.value = 'An error occurred. Please try again.';
        loginError.value = true;
      }
    } catch (error) {
      print('Login failed: $error');
      errorText.value = 'An error occurred. Please try again.';
      loginError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> saveToken(String? token) async {
    await FlutterSecureStorage().write(key: "token", value: token);
  }

  Future<void> saveUserType(String? type) async {
    await FlutterSecureStorage().write(key: "userType", value: type);
  }
}
