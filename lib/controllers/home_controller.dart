import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //steps
  //first fetch user type then based on that
  //allow user to navigate to donor and patient screen

  void onInit() {
    navigateUser();
    super.onInit();
  }

  navigateUser() async {
    var userType = await FlutterSecureStorage().read(key: 'userType');
    if (userType == "Donor")
      Get.offAndToNamed("/donor");
    else
      Get.offAndToNamed("/patient");
  }

  logout() async {
    //show logout getx snackbar
    Get.snackbar(
      "Logging out",
      "Please wait...",
      showProgressIndicator: true,
      backgroundColor: Colors.amber,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
    await FlutterSecureStorage().deleteAll();
    Get.offAllNamed('/auth');
  }
}
