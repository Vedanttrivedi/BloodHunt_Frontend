import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  final String baseUrl = 'http://192.168.29.80:3000';

  final RxBool isLoading = false.obs;
  final RxBool registrationError = false.obs;
  final RxString errorText = ''.obs;
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;
  final RxString phone = ''.obs;

  final RxString userType = 'Donor'.obs;
  final RxBool passwordVisible = false.obs;
  final RxBool confirmPasswordVisible = false.obs;
  final RxString bloodGroup = 'A+'.obs;

  final formKey = GlobalKey<FormState>();

  final userTypeOptions = ['Donor', 'Reciepent'];
  final bloodGroupOptions = [
    'A+',
    'B+',
    'O+',
    'AB+',
    'A-',
    'B-',
    'O-',
    'AB-'
  ]; // Blood group options

  String? validateNotEmpty(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<void> saveToken(String token) async {
    await FlutterSecureStorage().write(key: "token", value: token);
  }

  Future<void> saveUserType(String type) async {
    await FlutterSecureStorage().write(key: "userType", value: type);
  }

  Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_type');
  }

  Future<void> register() async {
    print("register function called");
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      registrationError.value = false;
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/user/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': username.value,
            'email': email.value,
            'password': password.value,
            'userType': userType.value,
            'phone': phone.value,
            'bloodGroup': bloodGroup.value,
          }),
        );
        var responseJson = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Get.snackbar(
            'Registration Successful',
            'You have successfully registered!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          await saveToken(responseJson['token']);
          await saveUserType(userType.value);
          errorText.value = "";
          phone.value = '';
          username.value = '';
          bloodGroup.value = '';
          email.value = '';
          Get.toNamed("/home");
        } else if (response.statusCode == 400) {
          if (responseJson['error'] == 'User with this email already exists') {
            errorText.value = 'User with this email already exists';
          } else if (responseJson['error'] ==
              'User with this username already exists') {
            errorText.value = 'User with this username already exists';
          } else {
            errorText.value = responseJson["error"];
          }
          registrationError.value = true;
        } else {
          errorText.value = responseJson['error'];
          registrationError.value = true;
        }
      } catch (error) {
        print('Registration faileddd: $error');
        errorText.value = 'An error occurred. Please try again.';
        registrationError.value = true;
      } finally {
        isLoading.value = false;
      }
    }
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }
}
