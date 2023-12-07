import 'package:ui/models/blood_request.dart';

class Recipient {
  final String userId;
  final List<BloodRequest> bloodRequests;

  Recipient({
    required this.userId,
    required this.bloodRequests,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    List<dynamic> bloodRequestsJson = json['bloodRequests'];
    List<BloodRequest> bloodRequests = bloodRequestsJson
        .map((requestJson) => BloodRequest.fromJson(requestJson))
        .toList();

    return Recipient(
      userId: json['userId'],
      bloodRequests: bloodRequests,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> bloodRequestsJson =
        bloodRequests.map((bloodRequest) => bloodRequest.toJson()).toList();

    return {
      'userId': userId,
      'bloodRequests': bloodRequestsJson,
    };
  }
}
