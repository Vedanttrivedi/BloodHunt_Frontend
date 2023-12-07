import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController loginController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.jpg'),
            SizedBox(height: 20),
            Text(
              'BloodHunt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
