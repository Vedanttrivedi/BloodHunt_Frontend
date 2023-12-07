import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ui/controllers/donor_info_controller.dart';

class TokenService {
  final storage = FlutterSecureStorage();

  Future<String> getToken() async {
    String? token = "";
    await storage.read(key: "token").then((value) => token = value);
    return token ?? "";
  }

  void setToken(String? token) async {
    return await storage.write(key: "token", value: token);
  }

  Future<String?> getUserType() async {
    return await storage.read(key: "userType");
  }

  Future<void> setUserType(String userType) async {
    await storage.write(key: "userType", value: userType);
  }
}
