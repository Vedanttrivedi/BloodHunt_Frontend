import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    print("called called");
    super.onReady();
    Timer(Duration(seconds: 3), checkToken);
  }

  void checkToken() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    if (token == null) {
      Get.offAllNamed('/auth');
    } else {
      String? userType = await storage.read(key: "userType");
      print(userType);
      Get.offAllNamed('/home');
    }
  }
}
