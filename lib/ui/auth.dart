import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/auth_controller.dart';
import 'package:ui/ui/login.dart';
import 'package:ui/ui/register.dart';

class AuthControl extends StatelessWidget {
  const AuthControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: Obx(
          () => Text(
            controller.title.value,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => (controller.showRegistration.value == true
                ? RegistrationScreen()
                : LoginScreen())),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => GestureDetector(
                  onTap: controller.changeScreen,
                  child: Text(
                    controller.message.value,
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
