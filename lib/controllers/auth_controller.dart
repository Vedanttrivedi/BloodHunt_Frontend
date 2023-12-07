import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  var showRegistration = true.obs;
  var message = "Already have an account? Login here!".obs;
  var title = "Registration".obs;

  changeScreen() {
    showRegistration.value = !showRegistration.value;
    if (showRegistration.value == true) {
      message.value = "Already have an account? Login here!";
      title.value = "Registration";
    } else {
      message.value = "Don't have an account? Register here!";
      title.value = "Login";
    }
  }
}
