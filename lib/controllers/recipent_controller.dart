import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ui/models/blood_request.dart';
import '../models/user_model.dart';
import '../models/appointment_model.dart';

final storage = FlutterSecureStorage();

class PatientInfoController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  RxList<BloodRequest> bloodRequests = RxList<BloodRequest>([]);

  @override
  void onInit() {
    super.onInit();
    getData();
    //getAndStoreAppointments();
  }

  getData() async {
    String? jwt = await storage.read(key: 'token');
    String? userType = await storage.read(key: 'userType');
    final String apiUrl = 'http://192.168.29.80:3000/user/getUser';

    Map<String, String> requestBody = {
      'jwt': jwt ?? '',
      'userType': userType ?? '',
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      var data = jsonDecode(response.body);
      var userData = User.fromJson(data["user"]);
      user.value = userData;

      var recp = data["recp"];
      if (recp != null) {
        // Assuming bloodRequests are present in the recp data
        List<dynamic> bloodRequestsData = recp["bloodRequests"];
        bloodRequests.clear();
        bloodRequests.addAll(bloodRequestsData
            .map((requestData) => BloodRequest.fromJson(requestData))
            .toList());
      }
      print("blood request data");
      print(bloodRequests);
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> getBloodRelatedData(String userId) async {
    final String apiUrl = 'http://192.168.29.80:3000/bloodRequests/getRequests';

    Map<String, String> requestBody = {
      'userId': userId,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      var data = jsonDecode(response.body);
      // Assuming data is received in the format of a list of blood requests
      List<dynamic> bloodRequestsData = data['bloodRequests'];
      print("blood request ata");
      print(bloodRequestsData);
      if (response.statusCode == 200) {
        bloodRequests.clear();
        bloodRequests.addAll(bloodRequestsData
            .map((requestData) => BloodRequest.fromJson(requestData))
            .toList());
      } else {
        throw Exception('Failed to load blood requests');
      }
    } catch (error) {
      print('Error fetching blood requests: $error');
    }
  }
}
