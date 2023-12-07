import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Placeholder(
      child: Scaffold(
        body: Column(
          children: [
            Center(
                child: Text(
              "Welcome home!",
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: controller.logout, child: Text("logout"))
          ],
        ),
      ),
    );
  }
}
